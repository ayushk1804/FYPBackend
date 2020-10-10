package com.vishwa.demo.data

import org.litote.kmongo.*

import com.vishwa.demo.data.collections.Note
import com.vishwa.demo.data.collections.User
import org.litote.kmongo.coroutine.aggregate
import org.litote.kmongo.coroutine.coroutine
import org.litote.kmongo.reactivestreams.KMongo

private val clientd = KMongo.createClient()
private val client = clientd.coroutine
private val database = client.getDatabase("NotesDatabase")
private val users = database.getCollection<User>()
private val notes = database.getCollection<Note>()

suspend fun registerUser(user: User): Boolean {
    return users.insertOne(user).wasAcknowledged()
}
suspend fun getUsers() : List<User>
{
    return users.aggregate<User>(
            sort(
                    ascending(
                            User::email
                    )
            )
    ).toList()
}


package com.vishwa.demo

import com.vishwa.demo.data.collections.User
import com.vishwa.demo.data.getUsers
import com.vishwa.demo.data.registerUser
import io.ktor.application.Application
import io.ktor.application.call
import io.ktor.application.install
import io.ktor.features.CallLogging
import io.ktor.features.ContentNegotiation
import io.ktor.features.DefaultHeaders
import io.ktor.gson.gson
import io.ktor.http.ContentType
import io.ktor.http.HttpStatusCode.Companion.OK
import io.ktor.response.respond
import io.ktor.response.respondText
import io.ktor.routing.Routing
import io.ktor.routing.get
import io.ktor.routing.routing
import io.ktor.server.engine.embeddedServer
import io.ktor.server.netty.Netty
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import org.litote.kmongo.nor

fun main(args: Array<String>): Unit = io.ktor.server.netty.EngineMain.main(args)

@Suppress("unused") // Referenced in application.conf
@kotlin.jvm.JvmOverloads
fun Application.module() {

    install(DefaultHeaders)
    install(CallLogging)
    install(Routing)
    install(ContentNegotiation)
    {
        gson {
            setPrettyPrinting()
        }
    }
    CoroutineScope(Dispatchers.IO).launch {
        registerUser(
                User(
                        "abc@abc.com",
                        "123456"
                )
        )
    }
    routing {
        get("/") {
            call.respondText("Hello, world! Vishwa", ContentType.Text.Plain)
        }
        get("/user")
        {
            val x = getUsers()
            call.respond(OK,x)
        }
    }
//    val port = System.getenv("PORT")?.toInt() ?: 8080
//    val server = embeddedServer(Netty, port) {
//
//    }
//    server.start(wait = true)
}
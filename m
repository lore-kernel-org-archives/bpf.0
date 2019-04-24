Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E8BC10F11
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 19:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60972205ED
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 19:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oKP7Ddx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfDXTVP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:21:15 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:51549 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDXTVO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Apr 2019 15:21:14 -0400
Received: by mail-it1-f193.google.com with SMTP id s3so8382225itk.1;
        Wed, 24 Apr 2019 12:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=JFMvY5L9DXLm/pftU3OWuBfUh9sNUD9lkuE/9qoEnrM=;
        b=oKP7Ddx+/FLcsTkf61nCF+ozCTU+AQ+xIGrvGg05iTvuQWp4aoFiv97ygTMlt+veHR
         FhfH6g5V2338qffaN+VJYb1AspDooxCZFq6mknvP5Xxu4yMc3+HhKxUCj3GlXc70fdRT
         Ywy1+7BaLdGB6dBT8hmUsTqKfzdxTo/YkI+2WE4YaDsmIcSvTgXQmJ/zbO6FdG0GY2Mb
         6H6qfXFx4MAosI67UKs3CGxNJ50Oz2Xl18Wtquf+BI4O/erPe9lAb31tnGAX+cO0i/Im
         IrF9mk5fUfJIUIE+ZG5XvMs1K+HsngcJa0n56TlmI0cFtgs06Zx59c62vfk9j22OJzn5
         8Rag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=JFMvY5L9DXLm/pftU3OWuBfUh9sNUD9lkuE/9qoEnrM=;
        b=WM9TCyK0/eabs1f+bXrmeNGYx4a4rdc7MTzp6fvWWjC7Ersc5h0ujEKAYfhgFEPPn2
         NshuIf0jYn1ksRHMAAqe8F/Af6QRpJOxNvuhk8jhFeZPyuM1z+xXzvyVqp2g0S8dvpfs
         +JImBvHnKRh7q6YHoKAPCo0zre9ROsO9JwLoWvx6d47LbHcZ8RhrDyQ4LAqTV7Bwrh6W
         dTnOLDR2BQREmdDztVH6zJzmvGpz6wOUuOGRJHADt9U+xBMqOOsQOo78qz9ZCBtZhwJ5
         PcF99dbmJBB7IEkOBzQHiSgeoLIWLfgxJMJYZGkXQudJMedc6+9iRri39XAP4OTzBK4F
         W93w==
X-Gm-Message-State: APjAAAWqyDQX/pvFNUyvbzJZ3jECNKKEDlkMTbUcrYOdRtBfGcFi1eIk
        0ViVf0kuRdaexfKl2DVjUmj29o7r2g0=
X-Google-Smtp-Source: APXvYqzTmRNQ8MEGcg6171nKNAo3fGT3CnF5NPZjGqDWzW0x8aBofBkrNe3kW0dQ68GjVd+bjovqwg==
X-Received: by 2002:a24:3602:: with SMTP id l2mr676827itl.68.1556133673601;
        Wed, 24 Apr 2019 12:21:13 -0700 (PDT)
Received: from [127.0.1.1] ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id 140sm3484551itv.44.2019.04.24.12.21.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 12:21:13 -0700 (PDT)
Subject: [bpf PATCH 1/3] bpf: tls,
 implement unhash to avoid transition out of ESTABLISHED
From:   John Fastabend <john.fastabend@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        john.fastabend@gmail.com
Date:   Wed, 24 Apr 2019 12:21:03 -0700
Message-ID: <155613366350.20131.18131808324848803588.stgit@john-XPS-13-9360>
In-Reply-To: <155613361373.20131.9399480750962676899.stgit@john-XPS-13-9360>
References: <155613361373.20131.9399480750962676899.stgit@john-XPS-13-9360>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It is possible (via shutdown()) for TCP socks to go through TCP_CLOSE
state via tcp_disconnect() without calling into close callback. This
would allow a kTLS enabled socket to exist outside of ESTABLISHED
state which is not supported.

Solve this the same way we solved the sock{map|hash} case by adding
an unhash hook to remove tear down the TLS state.

In the process we also make the close hook more robust. We add a put
call into the close path, also in the unhash path, to remove the
reference to ulp data after free. Its no longer valid and may confuse
things later if the socket (re)enters kTLS code paths. Second we add
an 'if(ctx)' check to ensure the ctx is still valid and not released
from a previous unhash/close path.

Fixes: d91c3e17f75f2 ("net/tls: Only attach to sockets in ESTABLISHED state")
Reported-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 include/net/tls.h  |   14 ++++++++++++-
 net/tls/tls_main.c |   57 ++++++++++++++++++++++++++++++++++++++--------------
 net/tls/tls_sw.c   |   13 ++++++++----
 3 files changed, 64 insertions(+), 20 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index d9d0ac66f040..ae13ea19b375 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -266,6 +266,8 @@ struct tls_context {
 	void (*sk_write_space)(struct sock *sk);
 	void (*sk_destruct)(struct sock *sk);
 	void (*sk_proto_close)(struct sock *sk, long timeout);
+	void (*sk_proto_unhash)(struct sock *sk);
+	struct proto *sk_proto;
 
 	int  (*setsockopt)(struct sock *sk, int level,
 			   int optname, char __user *optval,
@@ -303,7 +305,7 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
 int tls_sw_sendpage(struct sock *sk, struct page *page,
 		    int offset, size_t size, int flags);
 void tls_sw_close(struct sock *sk, long timeout);
-void tls_sw_free_resources_tx(struct sock *sk);
+void tls_sw_free_resources_tx(struct sock *sk, bool locked);
 void tls_sw_free_resources_rx(struct sock *sk);
 void tls_sw_release_resources_rx(struct sock *sk);
 int tls_sw_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
@@ -504,6 +506,16 @@ static inline void xor_iv_with_seq(int version, char *iv, char *seq)
 	}
 }
 
+static inline void tls_put_ctx(struct sock *sk)
+{
+	struct inet_connection_sock *icsk = inet_csk(sk);
+	struct tls_context *ctx = icsk->icsk_ulp_data;
+
+	if (!ctx)
+		return;
+	sk->sk_prot = ctx->sk_proto;
+	icsk->icsk_ulp_data = NULL;
+}
 
 static inline struct tls_sw_context_rx *tls_sw_ctx_rx(
 		const struct tls_context *tls_ctx)
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 7e546b8ec000..2973048957bd 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -261,23 +261,16 @@ static void tls_ctx_free(struct tls_context *ctx)
 	kfree(ctx);
 }
 
-static void tls_sk_proto_close(struct sock *sk, long timeout)
+static bool tls_sk_proto_destroy(struct sock *sk,
+				 struct tls_context *ctx, bool destroy)
 {
-	struct tls_context *ctx = tls_get_ctx(sk);
 	long timeo = sock_sndtimeo(sk, 0);
-	void (*sk_proto_close)(struct sock *sk, long timeout);
-	bool free_ctx = false;
-
-	lock_sock(sk);
-	sk_proto_close = ctx->sk_proto_close;
 
 	if (ctx->tx_conf == TLS_HW_RECORD && ctx->rx_conf == TLS_HW_RECORD)
-		goto skip_tx_cleanup;
+		return false;
 
-	if (ctx->tx_conf == TLS_BASE && ctx->rx_conf == TLS_BASE) {
-		free_ctx = true;
-		goto skip_tx_cleanup;
-	}
+	if (ctx->tx_conf == TLS_BASE && ctx->rx_conf == TLS_BASE)
+		return true;
 
 	if (!tls_complete_pending_work(sk, ctx, 0, &timeo))
 		tls_handle_open_record(sk, 0);
@@ -286,10 +279,10 @@ static void tls_sk_proto_close(struct sock *sk, long timeout)
 	if (ctx->tx_conf == TLS_SW) {
 		kfree(ctx->tx.rec_seq);
 		kfree(ctx->tx.iv);
-		tls_sw_free_resources_tx(sk);
+		tls_sw_free_resources_tx(sk, destroy);
 #ifdef CONFIG_TLS_DEVICE
 	} else if (ctx->tx_conf == TLS_HW) {
-		tls_device_free_resources_tx(sk);
+		tls_device_free_resources_tx(sk, destroy);
 #endif
 	}
 
@@ -310,8 +303,39 @@ static void tls_sk_proto_close(struct sock *sk, long timeout)
 		tls_ctx_free(ctx);
 		ctx = NULL;
 	}
+	return false;
+}
+
+static void tls_sk_proto_unhash(struct sock *sk)
+{
+	struct tls_context *ctx = tls_get_ctx(sk);
+	void (*sk_proto_unhash)(struct sock *sk);
+	bool free_ctx;
+
+	if (!ctx)
+		return sk->sk_prot->unhash(sk);
+	sk_proto_unhash = ctx->sk_proto_unhash;
+	free_ctx = tls_sk_proto_destroy(sk, ctx, false);
+	tls_put_ctx(sk);
+	if (sk_proto_unhash)
+		sk_proto_unhash(sk);
+	if (free_ctx)
+		tls_ctx_free(ctx);
+}
 
-skip_tx_cleanup:
+static void tls_sk_proto_close(struct sock *sk, long timeout)
+{
+	struct tls_context *ctx = tls_get_ctx(sk);
+	void (*sk_proto_close)(struct sock *sk, long timeout);
+	bool free_ctx;
+
+	if (!ctx)
+		return sk->sk_prot->destroy(sk);
+
+	lock_sock(sk);
+	sk_proto_close = ctx->sk_proto_close;
+	free_ctx = tls_sk_proto_destroy(sk, ctx, true);
+	tls_put_ctx(sk);
 	release_sock(sk);
 	sk_proto_close(sk, timeout);
 	/* free ctx for TLS_HW_RECORD, used by tcp_set_state
@@ -609,6 +633,8 @@ static struct tls_context *create_ctx(struct sock *sk)
 	ctx->setsockopt = sk->sk_prot->setsockopt;
 	ctx->getsockopt = sk->sk_prot->getsockopt;
 	ctx->sk_proto_close = sk->sk_prot->close;
+	ctx->sk_proto_unhash = sk->sk_prot->unhash;
+	ctx->sk_proto = sk->sk_prot;
 	return ctx;
 }
 
@@ -732,6 +758,7 @@ static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 	prot[TLS_BASE][TLS_BASE].setsockopt	= tls_setsockopt;
 	prot[TLS_BASE][TLS_BASE].getsockopt	= tls_getsockopt;
 	prot[TLS_BASE][TLS_BASE].close		= tls_sk_proto_close;
+	prot[TLS_BASE][TLS_BASE].unhash		= tls_sk_proto_unhash;
 
 	prot[TLS_SW][TLS_BASE] = prot[TLS_BASE][TLS_BASE];
 	prot[TLS_SW][TLS_BASE].sendmsg		= tls_sw_sendmsg;
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index f780b473827b..0577633c319b 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2044,7 +2044,7 @@ static void tls_data_ready(struct sock *sk)
 	}
 }
 
-void tls_sw_free_resources_tx(struct sock *sk)
+void tls_sw_free_resources_tx(struct sock *sk, bool locked)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_sw_context_tx *ctx = tls_sw_ctx_tx(tls_ctx);
@@ -2055,9 +2055,11 @@ void tls_sw_free_resources_tx(struct sock *sk)
 	if (atomic_read(&ctx->encrypt_pending))
 		crypto_wait_req(-EINPROGRESS, &ctx->async_wait);
 
-	release_sock(sk);
+	if (locked)
+		release_sock(sk);
 	cancel_delayed_work_sync(&ctx->tx_work.work);
-	lock_sock(sk);
+	if (locked)
+		lock_sock(sk);
 
 	/* Tx whatever records we can transmit and abandon the rest */
 	tls_tx_records(sk, -1);
@@ -2080,7 +2082,10 @@ void tls_sw_free_resources_tx(struct sock *sk)
 		kfree(rec);
 	}
 
-	crypto_free_aead(ctx->aead_send);
+	if (ctx->aead_send) {
+		crypto_free_aead(ctx->aead_send);
+		ctx->aead_send = NULL;
+	}
 	tls_free_open_rec(sk);
 
 	kfree(ctx);


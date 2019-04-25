Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF84C4321A
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 16:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33FE220878
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 16:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ihd1kR8g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfDYQDV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:03:21 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:35033 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfDYQDV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Apr 2019 12:03:21 -0400
Received: by mail-it1-f193.google.com with SMTP id w15so1008164itc.0;
        Thu, 25 Apr 2019 09:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=AW0j3ch8R3RnVdHOr9w5ogMoZRICWBWT0s9YVxGT4To=;
        b=Ihd1kR8gG7EVhE53ffqLR/wUpiQh0+SjP0/dGDP2Iy4OupjW44nOjjUMC6CE7oUgU+
         PMdj0tCINkCd+Gi2gBEHjH0yHIbCij5mN6r2U2OK5J1NNStp0uqpZjviibtPLaXeaqp0
         NNrdKBnZvGwL6F7Iw1jIPhDUyP49d/ib9J/Tj30lVlOT2ySLCYm6XYm6d10MI9pSQYgV
         wXOzWVkLIIWJRJr+bQcZrakJn5jyAF3d45vm5F7UZ22umkjDkZK1C2Iur6Ri1TH6IpVF
         sYC2P0gwJh9pbXXNRZ5L4kajxdTKKur/Cb51X5PutBHfeZ3sbUgWiXXOW903i+cX819Q
         wblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=AW0j3ch8R3RnVdHOr9w5ogMoZRICWBWT0s9YVxGT4To=;
        b=Z9THgCPVGE11ZVzu6rfxV5e8eboxaez/XNdIzQOlmNWuKUHZsKVHORaedInt/cfqsm
         HpK2vbV0y6P7U2QpMuGXkNA8VyvVWe0kJvLYTvkbRarfeVp8mjo3MpajfNH/8IaHvElb
         ESsiIhu6Ba6uQ9Iz3z6lxswpFdKOrVpMWMGk2L3FB3n9YuGLD39n4YSRGXvnKvNPkNuM
         IuJOvwoJPLeYeZL3ReKuo4q6VZw3KrrMy9y9yhdeMT7PuI8H9ekTACZMvE3S/UXNDAd5
         O9wKtkcDvlc4UHNLRuBKQVgIlzkb4j4R/nu7/BuWr0B8tUmCaq/ijZ82fetFJFnbSPhg
         dnWg==
X-Gm-Message-State: APjAAAXihxvwKiHLoshrxeCJF+u6lwAC4631NnyBOhFVsukZhO7AM3PE
        AS1EslHqg1cDZnRpBB5oryw=
X-Google-Smtp-Source: APXvYqx19mW44tU6htfKK/rghvuLQt/tJjrBguyqbEoyxU+GbpD+YUc+DqQfZxPYm+yol4jpqv2oqg==
X-Received: by 2002:a24:438e:: with SMTP id s136mr4598535itb.110.1556208199621;
        Thu, 25 Apr 2019 09:03:19 -0700 (PDT)
Received: from [127.0.1.1] ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id d5sm1788088ion.44.2019.04.25.09.03.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 09:03:19 -0700 (PDT)
Subject: [bpf PATCH v2 1/3] bpf: tls,
 implement unhash to avoid transition out of ESTABLISHED
From:   John Fastabend <john.fastabend@gmail.com>
To:     jakub.kicinski@netronome.com, john.fastabend@gmail.com,
        ast@kernel.org, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
Date:   Thu, 25 Apr 2019 09:03:08 -0700
Message-ID: <155620818860.22884.14832636768748270693.stgit@john-XPS-13-9360>
In-Reply-To: <155620799743.22884.8046772841813554446.stgit@john-XPS-13-9360>
References: <155620799743.22884.8046772841813554446.stgit@john-XPS-13-9360>
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
 net/tls/tls_main.c |   55 +++++++++++++++++++++++++++++++++++++++-------------
 net/tls/tls_sw.c   |   13 +++++++++---
 3 files changed, 63 insertions(+), 19 deletions(-)

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
index 7e546b8ec000..54842d0ddbb5 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -261,23 +261,16 @@ static void tls_ctx_free(struct tls_context *ctx)
 	kfree(ctx);
 }
 
-static void tls_sk_proto_close(struct sock *sk, long timeout)
+static bool tls_sk_proto_destroy(struct sock *sk,
+				 struct tls_context *ctx, bool locked)
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
@@ -286,7 +279,7 @@ static void tls_sk_proto_close(struct sock *sk, long timeout)
 	if (ctx->tx_conf == TLS_SW) {
 		kfree(ctx->tx.rec_seq);
 		kfree(ctx->tx.iv);
-		tls_sw_free_resources_tx(sk);
+		tls_sw_free_resources_tx(sk, locked);
 #ifdef CONFIG_TLS_DEVICE
 	} else if (ctx->tx_conf == TLS_HW) {
 		tls_device_free_resources_tx(sk);
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
+	void (*sk_proto_close)(struct sock *sk, long timeout);
+	struct tls_context *ctx = tls_get_ctx(sk);
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


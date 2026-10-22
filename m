Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792683620;
	b=Q+FK0ez/uWfkERtARZPKOuS1PEMXSH2Wt0U+R6ZNudZ8RE8e3cb/63Ne92PEYc4zLuDS
	 nvbebMdBHi8ezmGCefIxUh888GC+L1jlKJOl0iGs409TVGo93v0HPSPavgKrUOcb4V2Lw
	 qFRUoM1aU8qWU9xTTdtANutioOaafDXJDQBmC7vrmYDuYmXkdFozegI7GjT024vjtTSfs
	 rUDhqRxF1GoP4GP7Uxu8DWzXovwgOGhaQ4+DbGWa7ouX9H5pbRYynrN3cMiWpMXboWuZM
	 W80ErWWQFSLurK98rsTXsLjMOLMk91b2YmEPSM6p2aCtKjJ/kKF6bHAP4DkIlrLYl7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792683620;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=1VvzaG7f8kY8sdU70SP4PWgnMmzOl8H/DL+fBRJI1W4=;
	b=od5Lbia+UXScKznIGcuHlxXKGDxmoa9GsSWrkHJOnJim3U2W5gR2ZsUscGmDoC1VwHsO
	 Aqe5mV5M6asXG+Z5g66KquwUoHuTZl60f6YaOuZXzODhOrgKuUxZE4hdQngA4JiY82jEV
	 Ld71S/6wKiSit67FrL9O7do2wQ1AMq6wegvNmO4nkUJBir84mI4bl7Z1G0vi+nut42Ifr
	 0njygjdFRkgqiaxby4Mk9L/rQpRfHmMKBJZ5R5lLjXIYTRQeM5tnqskpi4enFR8CBJtY/
	 pQnI62A6y9/+WWljRfqpiLNnr1xRlcCBz6MubWCWiUiG9pVslPBqBSyGEistjsISAXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kwFJBqOQ;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94596606A31A
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 15:40:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94596606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kwFJBqOQ
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc4dbcf2b85so827044a12.3
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 08:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792683619; x=1793288419; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1VvzaG7f8kY8sdU70SP4PWgnMmzOl8H/DL+fBRJI1W4=;
        b=kwFJBqOQVs3qGLjatUX6GWXX4U9ulGUGae1UxOzFPgXpOVoCqe02Mgxk9JxQeviFD3
         4wgeh9TbIYED8+iDAeNLJO4LuocPEEIUTDibwhoxe6yBUqLII6KJuP7hTPDTN1DqI+UA
         +Z84VBM99+U8UTUNpDadWoXaHi8cnxND6nkmxb9B1l0LhpzuTFm/MqP2QMWLRn0xZiqi
         FhSytOBMW8WrmF66OAaeFT4HI7uRhKf2LAW8y8B8aH+CnEcKCc7ip7Afwj3EQSPdytR4
         NnA5tQL8QCRRrY4ifhsxJ2G4/5tmI12DMT8gPJDfZCZIujAPzsZ+WuJ/OoQhnhdi2dfy
         LhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792683619; x=1793288419;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1VvzaG7f8kY8sdU70SP4PWgnMmzOl8H/DL+fBRJI1W4=;
        b=0h/IFfLZH1UC0j+Z8nz6d7VKQYcNablTJyZa51V/iu6PqtPixGNMKffMB8d7soxmy3
         VlBWGeB1u/PyD8kv4NB9HiacfRMCgIsA3Z3Oi8AGdJXBo07t7dpcM0S1weNG+N+PZehl
         LvGgHvofOlO4vgddsIP0GASiyHFLnQQNzhkeqfKYFlcpF0erKNLqox8z0MJoKd1CxGNz
         Tv0WaJ+zOnD3md7eATDpdt4F9vc/unM3ZOA3YyAUjp3bbZox2BQM7sI+AhwD7cN9EzEH
         YT4Y40xCG0WVQrvjqcc1FVgJAU5eQsGFYobHD+lUXUHkzieiBSBfwOIQPTbQsdh/b3L6
         RwOw==
X-Forwarded-Encrypted: i=1; AKwUvBzhMWzb0tk1h0e7UNXyLpqqtutV0ksD4XNYONEBOP5EycQbUGIJoxOykXPKH8yaehxOLxs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLAfDUMm4AQ1aB0+z3Jf+KU2xMp2cPxfnby3CzGu7cxtki8R0KJ
	YUj3mn1qT7h0hvTjyGTalLu9JnP/jAxefRjIqFNF5S+qYVgOdaXWvuLh
X-Gm-Gg: AYBFou3MgWatu+/wUi0DZP70BGB+y6qcJWKMZvtKwz66GALyxtd3K15eXaplclVF2xA
	gjlN7eAgexJI5pkGqmaEiknOgpcgMuhQWwlzARdumlZ/82SpDqvqBN+00sOpJ5sqb84hkoBIh02
	wC7CxwiXerPkKny9unJm36E5cgHDXkZX1x/txJvK6TZG+XT0PK8Z0sh6CY5viGV1/ZveouqBOiR
	d0Hkpk2CR7B1YQyMmTK+BguGJYhlT61Rr/ZrlU33PbPxBaXyhDry2RJkFcO3lyrKBk6VHZ12/eL
	YucjvSFmuUKaQ0/d/AXWwJPJ/fNQctpa96BytHr3yPCrfG/lpumcvbzJKhQuGzAJr8xhsg4oZAQ
	Un8qb44f5EplKRHSrPaSlzjCue7ITosZYXiImytC2LM14TQK1sMnJU26CUvyCtpI/DZOebrQuvC
	wP5Hb7sxnnlrFMAk/L4wnz3TK/us18MrAOsL0B3O9Oi462c4hTUEQpx0KaghGW7u1pWPu7dp3o8
	TII/S+hdLHWY2Uj3nYsm/v+fxrkEDq/ityE8tbjbbftV7OoeDWLL3jMtMF8dtDiXIyQznFoYaX3
	rg7mS3yCU6xWylTYSuxvyEJBGMn6qLsJXtoY1+KHctb0NZ5x/W96Pyyl6cnt
X-Received: by 2002:a17:90b:3b44:b0:39e:4c81:6c5f with SMTP id 98e67ed59e1d1-3ad86d50c9dmr4757070a91.26.1792683618714;
        Thu, 22 Oct 2026 08:40:18 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada48876ebsm4728238a91.1.2026.10.22.08.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 08:40:18 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Oct 2026 15:40:17 +0000
Message-Id: <DMBHB0TQOV1L.38MECMYFGUS5B@gmail.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v2] bpf, sockmap: annotate the psock teardown data
 races
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Dudu Lu" <phx0fer@gmail.com>, <john.fastabend@gmail.com>,
 <jakub@cloudflare.com>, <jiayuan.chen@linux.dev>
In-Reply-To: <20261022054811.35008-1-phx0fer@gmail.com>
References: <20261021155629.68813-1-phx0fer@gmail.com> <20261022054811.35008-1-phx0fer@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Oct 21, 2026 at 10:48 PM Dudu Lu <phx0fer@gmail.com> wrote:
> Annotate every one of these accesses with READ_ONCE()/WRITE_ONCE(),
> matching the existing convention for the same fields: sk->sk_data_ready

This makes KCSAN quiet and leaves the race where it is.

sock_map_link() runs under the sock lock. sock_map_delete_elem() doesn't
take it. sk_callback_lock is the only lock they share and sock_map_link()
takes it after psock_set_prog() and sock_map_init_proto().
So two tcp_bpf_update_proto(sk, psock, false) can run in parallel:
  cpu0: sock_map_link() for a map with msg_parser sees
        psock->progs.stream_verdict and picks TCP_BPF_TXRX
  cpu1: sock_map_del_link() stops the verdict and stores TCP_BPF_TX
  cpu0: stores TCP_BPF_TXRX
The socket is left with tcp_bpf_recvmsg_parser() and no verdict prog.
That's what commit c0d95d3380ee fixed.
Take the lock earlier. Then psock_update_sk_prot needs no annotation.

All accesses to saved_data_ready are under sk_callback_lock except the
three reads in sock_map_del_link(). Move that check under the lock instead
of annotating it. No need to touch skmsg.c and skmsg.h.

Only the two lockless reads of sk->sk_prot need READ_ONCE().

Something like this (compile tested only):

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 38df842..20fb605 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -152,11 +152,11 @@ static void sock_map_del_link(struct sock *sk,
 			struct bpf_map *map = link->map;
 			struct sk_psock_progs *progs = sock_map_progs(map);

-			if (psock->saved_data_ready && progs->stream_parser)
+			if (progs->stream_parser)
 				strp_stop = true;
-			if (psock->saved_data_ready && progs->stream_verdict)
+			if (progs->stream_verdict)
 				verdict_stop = true;
-			if (psock->saved_data_ready && progs->skb_verdict)
+			if (progs->skb_verdict)
 				verdict_stop = true;
 			list_del(&link->list);
 			sk_psock_free_link(link);
@@ -164,8 +164,11 @@ static void sock_map_del_link(struct sock *sk,
 		}
 	}
 	spin_unlock_bh(&psock->link_lock);
-	if (strp_stop || verdict_stop) {
-		write_lock_bh(&sk->sk_callback_lock);
+	if (!strp_stop && !verdict_stop)
+		return;
+
+	write_lock_bh(&sk->sk_callback_lock);
+	if (psock->saved_data_ready) {
 		if (strp_stop)
 			sk_psock_stop_strp(sk, psock);
 		if (verdict_stop)
@@ -173,8 +176,8 @@ static void sock_map_del_link(struct sock *sk,

 		if (psock->psock_update_sk_prot)
 			psock->psock_update_sk_prot(sk, psock, false);
-		write_unlock_bh(&sk->sk_callback_lock);
 	}
+	write_unlock_bh(&sk->sk_callback_lock);
 }

 static void sock_map_unref(struct sock *sk, void *link_raw)
@@ -202,7 +205,7 @@ static struct sk_psock *sock_map_psock_get_checked(struct sock *sk)
 	rcu_read_lock();
 	psock = sk_psock(sk);
 	if (psock) {
-		if (sk->sk_prot->close != sock_map_close) {
+		if (READ_ONCE(sk->sk_prot)->close != sock_map_close) {
 			psock = ERR_PTR(-EBUSY);
 			goto out;
 		}
@@ -284,6 +287,7 @@ static int sock_map_link(struct bpf_map *map, struct sock *sk)
 		}
 	}

+	write_lock_bh(&sk->sk_callback_lock);
 	if (msg_parser)
 		psock_set_prog(&psock->progs.msg_parser, msg_parser);
 	if (stream_parser)
@@ -298,11 +302,11 @@ static int sock_map_link(struct bpf_map *map, struct sock *sk)
 	 */
 	ret = sock_map_init_proto(sk, psock);
 	if (ret < 0) {
+		write_unlock_bh(&sk->sk_callback_lock);
 		sk_psock_put(sk, psock);
 		goto out;
 	}

-	write_lock_bh(&sk->sk_callback_lock);
 	if (stream_parser && stream_verdict && !psock->saved_data_ready) {
 		if (sk_is_tcp(sk))
 			ret = sk_psock_init_strp(sk, psock);
@@ -536,7 +540,7 @@ static bool sock_map_redirect_allowed(const struct sock *sk)

 static bool sock_map_sk_is_suitable(const struct sock *sk)
 {
-	return !!sk->sk_prot->psock_update_sk_prot;
+	return !!READ_ONCE(sk->sk_prot)->psock_update_sk_prot;
 }

 static bool sock_map_sk_state_allowed(const struct sock *sk)

Pls run your reproducer on it, post the reproducer with the respin
and target bpf-next.

pw-bot: cr

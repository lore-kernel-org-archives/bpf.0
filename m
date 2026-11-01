Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560898;
	b=Y8QoEsWsbWgIlUx96Ldelw2m5dglcdpp0UusGH10ZRAPoANIzuIbkCxnTq3aB1GNKx+L
	 NM1U8bW+HEPYWR7QXnIavl6X0V7TlzVBSF2SERMV/2hU7lc9Tdfpl77kdHN49G30R/P0e
	 wZgm7b1QGz6/uW6nsdgt4MjxFrsH6HbtO7xDRiNagrYdGS98pYrpxBerXrGAdVhd931eV
	 vCw7q4v110mk6ph7wwwsrEcM1i4T0hNKliXQVqCBKKXZJVbHD3fQUWh4dbhk6LHDlSGIT
	 9Wq9JtMj1YrksPqxYdwOHg4IlYtgNpQiKsmei/NmyH904cUjo1dyA3c+e1CRCZMP1oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560898;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dz6pRM/Io22GYPHM6stLxgSNOJoApnHNm/0rCYVyXHY=;
	b=H+Eadp4a7MDTApKfxtue5rM8bcevpQBZJ7HguwyFPiesQ4RNWl/2T69QaPIyxf7EJi0F
	 6JB6xYl3MuZ1xTUppuys1wqwUTX+ElqIwz156wJItdVsfKGRPY78IV4gl1Y0LyzVROa9M
	 77BKzeMBIhpYdhmloU+hul2gKEkCChbp+9gYxehVS4BipKVmEPl09Jq9FjshIXNHo/xnd
	 Lbf/a+TIao1qwxFaEU1Ca0uf949VtL+oB+94GuUQzWtdLHvnlm3rfKP7b7lkhpXYiuWzD
	 xTSM/MVw+BP1odgfjb4dI9YOyClIRP2Gb1tWG6rcNK0L2lcPSJRFhgLgIYRqgxS/q6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HnkGGTnF;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E792606A326
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E792606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HnkGGTnF
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e9d7791b00so16769855ad.0
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560897; x=1794165697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dz6pRM/Io22GYPHM6stLxgSNOJoApnHNm/0rCYVyXHY=;
        b=HnkGGTnFHsJZYQGgLpwCXsLPu5A5AkoaltOAKmUyQu8Uak2XauIWb75LliZ7KlENkS
         mM1KPNZt2tmxvoHPH4948xnz91Sj/4udRUC7us5ARsXrbl9AeHOV/e285a0WeeAbv0h0
         r4UeevLiFYPyxh4uGePmgzHjiyWzCwt42XkZMd/97gnwDCkbZxKVbFRLtNwptVgBE0s0
         AUJ3ghyqCYBKLeaqwN1S2jjZv2eJWWEtXKr4+B7dZZg0ffZY7k3Z+VJkX/NhjIr/UsYW
         NNUi5baESdurkGz/pVuHsGroq0gtcDfzCENIq9QkVa9pmMSeDVh70TLqtbgxnV4qHHzq
         d1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560897; x=1794165697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dz6pRM/Io22GYPHM6stLxgSNOJoApnHNm/0rCYVyXHY=;
        b=rjIdM+hR7kESE5dKJIbAlrpQCbcnNgwdYzweKb9+5vbNTDfpiQHZA13jrGRRcYq3Mq
         oWZilW4eLlsxxFGg4+anFz3BurncnvluzHR56qUZTKVy+otmVWrGThda4QA3it4ibszV
         XGwaThjblIJTiJ9NkfxNA/Fa+kgar2VMwjeqMDMpvd/hsiTTEs9O/dOo7ZrWWYAgCgFC
         YEeFnZD6exVrz6vgfBgERuvCvp3HqxAwgfsZ5Q5KeYJdBQaPuSzFQR+JPD5foje51+nR
         gtV6ADXSoHDEjA8mOJAAsKDl8SX6ZI0D4HwCHuvDSbBIosKn2S7SThTpxBD+GxJssANL
         3qtw==
X-Gm-Message-State: APuU4Z/kZNMlDBRgLl83G+lrEjgZQdEruHQmdDC6fB6uPGT1RlAl1B3j
	eXthZsi04Cx+WWzqS3UOxwUf8Ey5QX2ShfvfnJ1VSQHyLzENFVVKD9hQCIk9vA==
X-Gm-Gg: AYBFou1UVdOQvAPPGGGhHiKLtHULPIe3poFDNx/TNZFvBNK/xXLXJK7E9SRumn/9baZ
	ffbL83fBTbsGjVTBROjbpTbWgNC23gYNrRxpkZTuNO0PUB55SrDYxvLTC7zTBG9bm2NgAQIRjkz
	pB3Z/ilVHxFhsUrhi2fKzTu/FaGduiZfDCZMQ1DIduzcsoQF42xF/CEJajvykH8pPFWSbCuwX+M
	xbe9F4Lc/E0a+liWohWb4IP69Ifbsx/+vatke38zf9c1p1thEfNbt4KLanmkMKFByIJi8sagjum
	Rw86VaCvWm8GJtYAmHOUDBMXqUzcEwl6lxefdIHA3z5I+4L2hHUxyBZbpwSgX5HEYWI1SqFuskh
	tNYpz8iMh8ku7zoMfgSGVf3Bm/T4Ylj49EvOHdfLZK3C/jYG4gIXUP5UxZrP0u9FVEByDc4xmat
	mW1/2/k5V3A8j/pQT0iu9VONR9COhnTfEpCnoRppeEUKMmyrCIRDVz2oXlXTiGBo2HhA096Tle4
	+9vNt4fxyKo0uCkrCWUt4YNSJ/afjig7/J+IIiWeJwLtzAFnmTyFXu2VmEFzGGB1Zu9GwPjFVtL
	d87ad5+thgfSON+DP8msTKB+qdEH57cEddmrfyiFx5vRFVu/vUrUM0HCSPjUJ60lS3LyJfQ/95t
	gm/a5K4rxv0g9fYBKgyu/hhKFWfzEqOmoQV8ituLNa8RfZBEwqYTCCQSpfqbgCkhLJKFd9pYCpt
	cYxGbjTsVgGplrrKjYSEk=
X-Received: by 2002:a17:90b:2549:b0:3ac:a7ee:678c with SMTP id 98e67ed59e1d1-3ae89536be7mr6671928a91.2.1793560897506;
        Sun, 01 Nov 2026 11:21:37 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9426ffsm15650206a91.7.2026.11.01.11.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:21:37 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	mason@kernel.org,
	josef@toxicpanda.com
Subject: [PATCH bpf 06/15] bpf, sockmap: Give no progs to a TCP listener
Date: Sun,  1 Nov 2026 19:20:48 +0000
Message-ID: <20261101192057.2296489-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
References: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Mason <mason@kernel.org>

A psock with a verdict prog replaces sk_data_ready and sk_write_space of
its socket. It saves the old callbacks, and the new callbacks call them.
sock_map_link() does this to a TCP listener too. Its new sk_data_ready
cannot read and does not call the old one. Thus it does not wake accept().

sk_clone() copies the new callbacks to each child, but not the psock.
tcp_bpf_clone() restores only sk_prot. Without a psock the child loses data
or does not wake its reader. If it gets a psock, the psock saves the copies
as the old callbacks. Then sk_psock_verdict_data_ready() calls itself until
the stack overflows. sk_psock_write_space() calls itself too, without end.

Give no progs to a TCP listener, as before the first commit below. A
listener receives and sends no data. It stays in the map and keeps its own
callbacks. Add this exception to map_sockmap.rst. A listener no longer gets
-EBUSY from a second map with progs of the same kind.

Since the second commit below, a socket keeps its psock when TCP unhashes
it. sock_map_link() does not see the state that the socket gets later. Do
not depend on TCP to keep such a socket out of TCP_LISTEN. Set both
callbacks in tcp_bpf_clone() to the TCP defaults.

Fixes: 0c48eefae712 ("sock_map: Lift socket state restriction for datagram sockets")
Fixes: b8b8315e39ff ("bpf, sockmap: Remove unhash handler for BPF sockmap usage")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 Documentation/bpf/map_sockmap.rst |  4 +++-
 net/core/sock_map.c               |  9 +++++++++
 net/ipv4/tcp_bpf.c                | 15 +++++++++++++--
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/bpf/map_sockmap.rst b/Documentation/bpf/map_sockmap.rst
index 2d630686a00b..eb466b86df17 100644
--- a/Documentation/bpf/map_sockmap.rst
+++ b/Documentation/bpf/map_sockmap.rst
@@ -33,7 +33,9 @@ of ``__SK_DROP``, ``__SK_PASS``, or ``__SK_REDIRECT``.
 
 When a socket is inserted into one of these maps, its socket callbacks are
 replaced and a ``struct sk_psock`` is attached to it. Additionally, this
-``sk_psock`` inherits the programs that are attached to the map.
+``sk_psock`` inherits the programs that are attached to the map. A TCP listener
+is an exception. It gets a ``struct sk_psock``, but it keeps its callbacks and
+inherits no programs.
 
 A sock object may be in multiple maps, but can only inherit a single
 parse or verdict program. If adding a sock object to a map would result
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index efe49551caba..282c6a4b2b05 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -228,6 +228,14 @@ static int sock_map_link(struct bpf_map *map, struct sock *sk)
 	struct sk_psock *psock;
 	int ret;
 
+	/*
+	 * A listener receives no data. With the callbacks of a verdict program
+	 * or a parser it would no longer wake accept(), and its children would
+	 * copy them.
+	 */
+	if (sk_is_tcp(sk) && sk->sk_state == TCP_LISTEN)
+		goto no_progs;
+
 	stream_verdict = READ_ONCE(progs->stream_verdict);
 	if (stream_verdict) {
 		stream_verdict = bpf_prog_inc_not_zero(stream_verdict);
@@ -262,6 +270,7 @@ static int sock_map_link(struct bpf_map *map, struct sock *sk)
 		}
 	}
 
+no_progs:
 	psock = sock_map_psock_get_checked(sk);
 	if (IS_ERR(psock)) {
 		ret = PTR_ERR(psock);
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index b9761af13989..aa904ded816f 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -777,7 +777,18 @@ void tcp_bpf_clone(const struct sock *sk, struct sock *newsk)
 {
 	struct proto *prot = newsk->sk_prot;
 
-	if (is_insidevar(prot, tcp_bpf_prots))
-		newsk->sk_prot = sk->sk_prot_creator;
+	if (!is_insidevar(prot, tcp_bpf_prots))
+		return;
+
+	newsk->sk_prot = sk->sk_prot_creator;
+	/*
+	 * sock_map_link() gives a listener no programs, but a socket which got
+	 * them in another state and listens now has the psock's sk_data_ready
+	 * and sk_write_space, and sock_copy() has copied them.
+	 * sk_psock_init() refuses a socket that has sk_user_data or a ULP, so
+	 * what the psock replaced were the defaults of a TCP socket.
+	 */
+	newsk->sk_data_ready = sock_def_readable;
+	newsk->sk_write_space = sk_stream_write_space;
 }
 #endif /* CONFIG_BPF_SYSCALL */
-- 
2.55.0


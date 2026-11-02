Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604118;
	b=KjPIXb00e4qBP3wAg/ezmoLCsvQW4AbZmGlY73qFM0+RtW/Qry6wBm1ItVoYRCOQN40P
	 RCq+wl7SEFZuZHZ24Dio8SR9FI5Sa6ZzTtwlEPq1YuuBaSulccRBE/Ggn6mGSoL86Bfxd
	 sQDvEpMIbG5Pz45lmLu2JNA9/M61C+3tiqGXdlAjxk8jfZ4GW5t/GjkNg6IwoiVusyrbN
	 qbv+j4Vftw77OW/kbxmfVsvRvuQ2+srxMythKfSjd/DKkFKFsy9ItQSz5DL5k70kkE2pW
	 ctHAw6soeqZxdYalV/kT5OPNyEP24rXuuwm1PMCBbd2INt87YP86ftMebWR41gavDCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604118;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DJmLVVVW+5deakG/rXx9rSWGIQrWi9+mRR7c5J3o35Y=;
	b=tsqLiZ+q5lXO/xSAbFsqv+u2g/lj5t9z0O5FIghS5sYxqLKVieNTeO/1besZdrtf0f7d
	 1B8BPyQ66I/nAaTvxU7U52KqiqFRnbkqgPKOCR9VW5cu0ClgUhx2MK8GMQffPyV0G5hbR
	 PTKxTYk8OJyFEVc0KNpQ4/OTxmkHe6NIWMrQb/2qMhB1RR74BFsrOSuUsEWOQP7P1ctfi
	 oXEf27Exwoep4O0NTW3RjdXzS/bFDd+j8xAZMR1UER1N/h+zcj3SKSlkyef7CGjxbUu22
	 wm9zCE7MEsBy3jHAstQEGNgF+84wRcpbS4FsE1yS3cKOPNgP28FZbBDS89smw6iknqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IdpUE4co;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6E5606A332
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 07:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C6E5606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IdpUE4co
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3acb512a7a0so1608978a91.1
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 23:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604117; x=1794208917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DJmLVVVW+5deakG/rXx9rSWGIQrWi9+mRR7c5J3o35Y=;
        b=IdpUE4co+PiPL+yBruoswBCDY/L7XhxHdcQl33YTywzuQmWl8ALc5aW/xDhTw4XP8v
         MYzTogUNvP7snu5urYgumlPcJGb27Fy0/lF5xalEmXhMDggU53fxv02ustaGqq45m7/y
         aGDPAYi+jQTS5gwRwy6HjICy0fgfwW1rxnTtVCsomE3sbpSKZDr9vYFU+g5rE/nZaoKq
         Gz1gqks4iRsR9YkNY4APSLZzKsAxCxk55JaORcmN2oVuGbPVI42fb1oykSqexreBro+4
         ce+vhUMVDixgaA8xhTI2sJ5tZ7RHk1WJw8ayNh5kL9lnyIIWLcr3y3DS90vT3LmGLia9
         YWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604117; x=1794208917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DJmLVVVW+5deakG/rXx9rSWGIQrWi9+mRR7c5J3o35Y=;
        b=aqx0Pth6ExRBTt75z7svaeqBH56EExm1yoAJP5N6pIll/9f5JWO7MI8yJ2RyK/+m1W
         6Q9rFfN0+V6Z/ImCWPHExXnwB6oS5vtR2Wa1MNHewf0yZh6oKAczwy37NFWovT7if/kB
         PZ+xTDj6T8+FBUi52sLuhYinM/lhC2d2goBwpEEoT/Q0uAiGb1JdW8SPr/s0F0+LTA+N
         y7Brx9+9gTXejhrulegR+d4JYEmeJCKWrUM55LrgUIWN9NJxMf/k2cbA8RlcMqxP5l9D
         +9J6rZFUHZDOVp6ZdrKP+2ljXnULtSU9mTD9MuphENnN78BgqR9c3TWeDDSTeN+ESzJv
         Mx4Q==
X-Gm-Message-State: APuU4Z/lrPhKQLWZA5x1u5//1gLo6+j1uGDVx2K6++P/VXVeOgapz5Ne
	5Lu6ruJTUmK52buhKtHEtcCSFupA/3CRR+g4cMdHuQ4Bf+RzOHN8r8pfZcEYYg==
X-Gm-Gg: AYBFou2o0h0Y4LbmfW/bQVaNVqhHWurGk36oSOnmm/kAFNwx+8yafdfwaIUL20XlaAT
	65yI9yL83W6g83eVsnni14rAHxcMd7OvTb99zh6tzHIy7rgDohomjDYgBLYGPWoZRgFFfAaGPVk
	z5quFqFZlSYkaY5kc9Z+GLEsV8+nLJN/toc++tmF37L4Lx3vFonLGAydJ4+nXqCUg0ZId5DwQBt
	XddEjdPwgG1FkS/MWTQaSoZ4b+Q7Ns229AW4+S12tMx3Kjj08fpvK+1L9RPvaia/xI9lp+i4Oh2
	gTnxt4mKbQMrUYAU18mNf0zc257UYrJZNCP3lmJy+NdZYB0NvvKSqKhybNrFs4JDgEyfcqgZNUN
	CgsBIc9V1N0qJuOU/Y0pFtCxsOZ4bUytzpz0e+/IYbSjw9XJef/Xto5ZPXiNXbffjJCpv9CBgTM
	cJyy1Z161YikxmCEW092EHsBkhwBRdB05CZOn9xLnd+EQR9EKayurIKaEHzrjZ1ITDLo1dAPFwP
	ZW1Idl/aoflq2UywS/jNqsTQLIwQR4YS1luo1R7RAvl1ED9JpE+9LBUYrTfdUa1iuPvSVfKXGvA
	T9/Y0Khpn90BbBrsA5O1M3MI1kuw06onx2rdVbsIOQo69TruRYS1rBDAkM4hFxD/c4plG4+9to8
	h1068mkDlA5YnFj5ltYAu4BxQxyniWaDHBwqNUwnAYfq/B+hZzW1kpq5tOXZT4JU8FcDnYamA16
	E=
X-Received: by 2002:a17:90b:184f:b0:3ac:83c1:2c0 with SMTP id 98e67ed59e1d1-3ae897e06efmr7231700a91.64.1793604116645;
        Sun, 01 Nov 2026 23:21:56 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae8826a769sm6098801a91.4.2026.11.01.23.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:21:55 -0800 (PST)
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
Subject: [PATCH bpf v2 06/15] bpf, sockmap: Give no progs to a TCP listener
Date: Mon,  2 Nov 2026 07:21:03 +0000
Message-ID: <20261102072112.4160195-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
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
index 36d1bf46353a..fd443350f9b8 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -785,7 +785,18 @@ void tcp_bpf_clone(const struct sock *sk, struct sock *newsk)
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


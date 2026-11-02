Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604130;
	b=gJQ3t7c16L6q7krbaIkf/J1bMwhg142lxORVIq8w/EhJStGAHsAEbgKlnZJ9XKkh8PK2
	 d3WxQ51NgoIqQakShktPYO4o3Cl7sdLdLfyuDmcamtSzaPti33rkGYyrJgN1VwRlZpHcc
	 JMS7CXEu6foqocgf7cnQA1SNI/vLvbmu5cIWnA/jPDTsDtAdBx5etpTxUVu5b40Pj4nf3
	 RrJFn7jB8O9rdm1do8Pvx8Y0ykGqzKlc077C2eVbs4pBgqaLlDVxK/h2ziUrp3ew0EPLE
	 Zzc0MuHt0u64slaWVC71h0W3eZDj9nLY87DF55Sae7hHW8BvrHCxlCgmFwa3H/zqMug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604130;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=q/uS3MNfywD3Vv+T8KYvUL+u5aHeTIkmuMrEypBwwRc=;
	b=tAlUXRZkVJrLT6c4WEebCFRUGIIuVc16kSwGVIkRbYLrOm3tq6KWy624GxQObxMIs2A9
	 qxj6C63hchcK5MqGYr0lns2vgAzsPVc1FoPvsI5M0HUkto7cP3SgbkSHHk195tJNbiZaU
	 KQo0CWvnbhN5FeFb3uLiQuGmmjsDCd5JWVLoTyV1vPr5iPaP9mtfvKNoYk1CNFV+WHvZN
	 GWO1Hyu3jVwkvHsYUZL/koTxJBAkjakY/QEK9zZcNj3LXo9IlQ94k0y3KdJ0rC446lmiX
	 QRMQnssCQgkGq+K9B160R8Eqq5Nduh9M5wBXuNqb4F6EQ00sSc0FfrTPMBFkL4xhIzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TelWpy7y;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23C3606A327
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 07:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C23C3606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TelWpy7y
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cdaefe02d5dso1423723a12.1
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 23:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604129; x=1794208929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q/uS3MNfywD3Vv+T8KYvUL+u5aHeTIkmuMrEypBwwRc=;
        b=TelWpy7yjpGZcuy+E0mUUJFqN+c92ktLiy04CnEidXILsKmPn/nHJYpRowyDxI8FtH
         z5IBPuyPiumtBCT8j6p/VK23LScmYL501NxkANVkBwXwx+st5cI8deX4sfbweAtl20es
         R/LwUas+PZ5IEDD4uL3BV65qkPCPuUTKL4slV8VWv9/HdV98dVXJdtX3x33WuhMBFdug
         21nfpC6WIdzWrQp4/fzV2L6n1BQdKP9y2jFancUDm8bwxcdOEB0Ct93wv+1ds2lSLBya
         CgL3YUmUJqK+Vudt1bR2IjeDmUA6Ev4H1jzrKkULn5AeF/LvzqkPvOrkZdM1X64eRBf4
         +9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604129; x=1794208929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q/uS3MNfywD3Vv+T8KYvUL+u5aHeTIkmuMrEypBwwRc=;
        b=Ma+4tB0AluqT8uOEDsNTWUnkENCjENxWVZjXJ9FvZdXpVwDZBc40ydmIBsgsXT1OLv
         rlUTZBBZ7XKigKcMAXQfenu8V5dvWByy6amvnbJRMNS9jq0SCr+D7s+Ogjr7a9Tnl71z
         0aZnnywSALlIi36Np4u8qTfrXwBXFD3xJ28BGjyZoh+Wwd5bEnI9Q9Beka+ou69jrz25
         qPT1mEtNdpNVu9MLAJWUjDNJEsod/ken6iQBY0Q+jeUh6T/fcF/Zx0eVMLwSuDji0Phn
         GYE+4Rq0uqV8bwpt0nyoMToWLl7sDW2ycoIfI+zhSItMBY6HwNeY63jvq59Cs01cF0oK
         Yvyw==
X-Gm-Message-State: APuU4Z9R3fCEsDsyXmWKYci/Bj8+4oElxSJhR1a4cwY6wWaXD4AbEFFk
	ufqf9sihbUtk7vpDIEOGjIXwl3ZRbsHOQySQaFc4c2CaRr1Su4dYVVLecc4g3Q==
X-Gm-Gg: AYBFou3t2A4XB+qGRTRejTQWXwNTlLWaAlY/Z/k9EfrJYr9oaY1sP+cm23/pE179UJA
	onx544XareLkQDYpOHyZmpvrVwB3SfQoNFHXZv604MpKVXu1rGfodBFcHpuGB/hleO8xad5WZ/9
	N15c3rtfyGrbbDeEa880VPWhZE4ZzR14w/bU/TA8o/FY032YtoxC5RKFrk5NH695/RikIEsBg7L
	euWDxKoSjJKaH4zo2cCF8rBh5XwOI2EDBVTuIibszZfti0++Fmv8GjJx8syZ2Go0H4nHgFehdA3
	SL4TPtKWT6PrWGMFuOrJL6NRFBdJBMaoBey6IL5pWAW8D0PZV6DhZjfaPUm64lE0zlWO5iZNBJU
	rAfDgwT9Kig7MOG3EDnIhboNee8tQQL+vqczuUsCBuqk3jDzrSFpX0SF2rEHlukwkLeqPo8f/XS
	IH7QgAEuaIqS60kQhhN4ONPed8zxO24LPgaD/vbDFK1FbGB8iiAd2u5bqWykb5W9rSzMjHPTlyA
	+oGMFRutotcZ3Z4xfrKGvufYrXb8RWwpzERva1B5pCe64+zWfifz5Mi7P1FGbukeQnroMhgYtro
	Ezup5DsDoboG1RAQ+plYvs2McGopQ6Y2URiHR5/7ZOUouQMSsIFzpKD+8nIvICGA9r/4v3l/KZk
	ZXb7oIs/iPA3GNzS/Ml/U5YY457R8i4+cxJG07a8/Z2gYzhQAmlS4OwKQwGtHHpkMEzHzGqYnuR
	0=
X-Received: by 2002:a17:90b:53c7:b0:3a4:77b8:1770 with SMTP id 98e67ed59e1d1-3ae897c7747mr7453233a91.15.1793604129139;
        Sun, 01 Nov 2026 23:22:09 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845ae5b9sm13043295a91.12.2026.11.01.23.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:22:08 -0800 (PST)
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
Subject: [PATCH bpf v2 08/15] net: Leave sk_stream_wait_memory() once the socket is dead
Date: Mon,  2 Nov 2026 07:21:05 +0000
Message-ID: <20261102072112.4160195-9-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

When an sk_msg prog redirects data to the egress of another socket, the
sender calls tcp_sendmsg_locked() on that socket. The sender holds a
reference to the sock, but not to its file. Thus __tcp_close() can call
sock_orphan() while the sender sleeps in sk_stream_wait_memory().
sock_orphan() sets SOCK_DEAD and sets sk_wq to NULL.

After the sleep the loop continues and does not test SOCK_DEAD. The
subsequent sk_set_bit() can dereference the NULL sk_wq. The tests of sk_err
and sk_shutdown do not always stop the sender. sock_error() clears sk_err,
and __tcp_close() can call tcp_disconnect(), which clears sk_shutdown. The
sender then adds data to the write queue of the dead socket, and
inet_sock_destruct() warns.

Leave the loop with -EPIPE when the socket is dead after the sleep. The
function already tests SOCK_DEAD before remove_wait_queue() for the same
reason. A caller that has the socket open never sees SOCK_DEAD.

Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/stream.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/core/stream.c b/net/core/stream.c
index cb255e2a3a5d..334124d683a7 100644
--- a/net/core/stream.c
+++ b/net/core/stream.c
@@ -150,7 +150,11 @@ int sk_stream_wait_memory(struct sock *sk, long *timeo_p)
 				    (sk_stream_memory_free(sk) && !vm_wait),
 				    &wait);
 		sk->sk_write_pending--;
-		if (ret < 0)
+		/*
+		 * A sender which sockmap has redirected to sk does not keep it
+		 * open. A dead socket has no sk_wq.
+		 */
+		if (ret < 0 || sock_flag(sk, SOCK_DEAD))
 			goto do_error;
 
 		if (vm_wait) {
-- 
2.55.0


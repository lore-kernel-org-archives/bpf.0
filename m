Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560938;
	b=quI/IcuzG7KdHj9yHx247ieUQ6gkbmpVa3syzGQXBCHBG/dVUrwRhmycpfhvbEPVbRjB
	 AA/E6v+8CYOviO5u99sYU0oobBOoHKtpvlD/n5ZN/AttmPBCky0uWIba6H8HipAPSIMkb
	 quG5hhVHWV5wUEMFhbHPCRESbF8kPDrN2hIjcbvfOCGjMI3UxBbrdkUlZ2HOVHvkhvMew
	 7nSYPA3fAzNRRFI0zM1WyjNXdg/9sT+SxWBOMJKLB+uXUZcQnZ9Y5LF52CKgnqlV/QUVM
	 zsM0oDujkfnPbdRh9psFqhvwen6GuGzdDwTT57s6l49bH/XbVetTb0cs3Sqia8nRRuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560938;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zkvPy8BTXAWTFCLyRVJ2sIoHit4yKU7xsRMx7Je7ku4=;
	b=QWgCj8WHKm5kvTz2SYEtnMBqfH9LjhK88AbPSeSkJzm3LLiuPQvJVBcdDaHQCqH9J73C
	 ZG3/aT3mDoSqecI6UurBvha5f/3GfeqMtOfc4D217HWytkRU+cYAZzb9R0lfwwCdokyCG
	 UbXeUXdC/TSQGPqBWBBJclXroBDQ9hcF3N1WOjalwIfjasfyCtW3itE9aiFQL4EWOPLgc
	 y1mHVunG7WEV9RmPh+mYwkR0fxhFBHcGG3T5coOtx3ckZXz5rob7jny5HkmZK4ACeMCdd
	 2JtVbVjSjKX23k0Gb/STqHBa2aUane2uieZQgyhs36abE7ob1aIBh3WKxmtVax4XZxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZGhzQK7L;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BFF606A333
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9BFF606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZGhzQK7L
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ea7987517aso15610065ad.0
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560934; x=1794165734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zkvPy8BTXAWTFCLyRVJ2sIoHit4yKU7xsRMx7Je7ku4=;
        b=ZGhzQK7L6HUcJBrVHYYKo1IIWIOLyyDCWl8LfENkL/wRyYVVe8QrWSlYPPw1/QTwwr
         uYbuRaJeYVB52ObsGC3/Wfob6b2euKoKnuaq+HPdOkQg91wjXHRpLaJf9A9WyfjD6+g0
         tunAIesbX0B5iZGmaKp/smcQC8MmUvIZ2VVdTMA562HOkvkQgaeCCug1WyZcOKpstxUO
         zRMeTFfN66f3J4ts8I8u3N20aR0Y92IOR+/IfZ1XekIpQ9wdwAyrCeXhLnRTsaJipYoL
         86WtkcLIAnkBL7m8mDUB3FRei9uomVpyfalgnR+G4Ds//Yt27gIQcNY3UdkkEFs6knKr
         eVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560934; x=1794165734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zkvPy8BTXAWTFCLyRVJ2sIoHit4yKU7xsRMx7Je7ku4=;
        b=klQUp4pf0ya09xa4DI77xn0seMTOpfVHmN+J9UNimcyp7Aw1rdbwaxU5D3Lb8N8nwl
         1MtFOUs7OFVq/VlP/OY5VHSICN/oJIr59+Xnp4wjTUjm9GJecY2Lc8y+ORvr6XrjQw7m
         2JIN9BFyIVLmu9IiZUn70vQCf5Zs9/9pD0SZAJlsjks77lOOx5/sWJIOkCCWynHhVZoo
         slFSGR6kVkZFFWFoUHcED/Pc+iJ9ZYVxRhM7aj0v7BfUQwd/EIqm2inQVGrEWatCidnA
         cSmu98/SJhP/25ilFLG9+Y75ZFbFIog/2w6IPMH7L2X2FXvbWu+uUaWr7hOMpGl8gtF4
         ejzQ==
X-Gm-Message-State: APuU4Z9F8XLLb3OsvDrtDxP2R7JRppNsNdAB4GtQaMecHnjI4Dw3HI/w
	Y3V+BSvNefwBIjpXuAnCmlX9G6cbbjOuW4d/wipNpVfYrFMpHqKJDZaxrjAJsQ==
X-Gm-Gg: AYBFou0bMdHqAHqIb12dqZQI84A3uPSl0P1A4t1aGTpsprjErVuqVLt6jhjchkTulkt
	blPnYfLuCZaP3ny3lT7ntBDplIzI+8GutNiY2uJDQMfnLme9SZl3sXE3hnfZbSJ2DC9xCYUvBsC
	6xmORg0JdxjCSLOWRJzbLd+WhrxmQ4+RnEZoSq8STMyKRpnSk+qKaU1Z4w8bJ2JyuXKYsvp1hP+
	D/9I+7/oNedyu2irSu1BmBKpmifkpFBOEjL2yNkBp8oZtw0iSOvQCL4aixUmtlzn0Wsosp0xkD9
	S835KMm+oBscJJ3Lyddid+/nTfe9qYmnbvhgWagDMeIdywXDg6W+h6fD0X1Pi+zCBaDMR5Fpsv6
	f1sp9tzc20h7mxR7Koc3hC3DD666rMWfrjEtly9v6BZbn5z9SH1OLnvUuivcjaDmjLHwHFPy7hF
	DiIO5Yj6jhF0oF7Fx7ILlLRv736riLz54SX615AiyalCIzzeiu48gLygaySm69hiSLJPly6Pf2Q
	SaFBBpu8BszJ44RMZWQ/JQxNWSR71JmwZOcKFEJk4kfeqNJT4DRvU/8pG1MDyDD4RLbem8KA4F9
	LvM1TmXY86e/ETTESEKmlfrpqFJmq8l/qBTILaWYqGmpAxEbs7OIeFZw5OwC4ab6KLDX2KJuP1o
	uNqN++9oBKsWzbgIGhCnn5HZtXhA9Etc1rc/v1c7mLECYmHkBy/06j3eNc+cS3SGTZmg4LRiNpB
	Q=
X-Received: by 2002:a17:90b:1c92:b0:3ac:a521:959 with SMTP id 98e67ed59e1d1-3ae898166c8mr6711734a91.29.1793560933989;
        Sun, 01 Nov 2026 11:22:13 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae85f37e7esm6486678a91.1.2026.11.01.11.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:22:13 -0800 (PST)
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
Subject: [PATCH bpf 12/15] bpf, sockmap: Clear the redirect target before the sk_msg prog runs
Date: Sun,  1 Nov 2026 19:20:54 +0000
Message-ID: <20261101192057.2296489-13-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

bpf_msg_redirect_{map,hash}() store the target in msg->sk_redir, without a
reference. After the prog has run, sk_psock_msg_verdict() makes SK_PASS a
redirect if this field is set. But tcp_bpf_send_verdict() runs the prog
again on a cork, and on the rest of a partly sent message. Nothing clears
the field between runs. Thus SK_PASS without a new target is a redirect to
the old target. If that sock is already free, this is a use after free.

Clear msg->sk_redir before each run, as the skb verdict paths do with
skb_bpf_redirect_clear(). Only SK_PASS without a target changes. It now
sends the data on psock->sk. Then sendmsg() can return another value. A
redirect that applies to more bytes uses psock->sk_redir, with its own
reference. The counts msg->apply_bytes and msg->cork_bytes stay as today.

Fixes: e5cd3abcb31a ("bpf: sockmap, refactor sockmap routines to work with hashmap")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/skmsg.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index a5d498982848..8a3b8536c0c2 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -936,6 +936,13 @@ int sk_psock_msg_verdict(struct sock *sk, struct sk_psock *psock,
 
 	sk_msg_compute_data_pointers(msg);
 	msg->sk = sk;
+	/*
+	 * The prog may have run on this sk_msg before: it is a cork, or the
+	 * rest of a message of which only a part was sent. The target of that
+	 * run is not the target of this run, and the sk_msg holds no reference
+	 * to it.
+	 */
+	msg->sk_redir = NULL;
 	ret = bpf_prog_run_pin_on_cpu(prog, msg);
 	msg->sk = NULL;
 	ret = sk_psock_map_verd(ret, msg->sk_redir);
-- 
2.55.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560946;
	b=CbX4k51JdPZLrDhzZ03GaJh8Yyz2xbEA3wweK4UY/e+bP4yvvlvUtkDiyTczgun/fq4H
	 Hu035MLvD1pSZsQ9Ku6iKkf219+oLxrAk/eJV+7JAceCKzOvoljrgd3cVn4XfZ28/NnN8
	 CNfazUwv5Kdm2PVFdFAGK3Yp1yN/Lf3gtpIsoVzhajJ1pCh3xPQgqAmrFIyhupaLE8gKr
	 1o/Ax0qwXAZT0RVIp32uGTuE/sOnBOwP6wa/gu/7AvB+sDJymFKyrrk21rSlZwT0P9egq
	 I9iKHODJbTXKiyG4Aqcllb37l+r608D0SkSxCt2MiJe1k78F1lyDA3SRnPepLvYZAIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560946;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ri0soL3Qksj5Kdn3SrP3no3I/aeDctTXiNHb2hYcsPs=;
	b=iMe88q2EQAbwpIhMi33yOvUgsXaXqUDLyg/PvpLaZwb/mjqumpOfgovgSRkl0X9kkdDb
	 4QIC32J/m7wrexHqSBmJWIW4VRYkC16OoPj1yAm+65SufTMkhmTqjt1+rgBlFm1eYp6KV
	 1DI/dRK8iHx4z13qJsP17IrvCrgbLsZJM+Q5VQqXPZkv1ATgpru3usAOYPvBeRz2L5Yqz
	 nOus6R4OQSSld2IldUBWzBQAirkCyiTRfM7e++M5ipHDDBtiDGynFhfdl9v4o9SxjV8oX
	 CJsMgnFneaqp6FbVnMfo+5hJv8UrSzjXmuyWy/0Ucde7pp3185SGhQpd1UdbNXZWJ1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U8RnCTWe;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF6F606A32E
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCF6F606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U8RnCTWe
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ae2b7e1e17so1519537a91.3
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560940; x=1794165740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ri0soL3Qksj5Kdn3SrP3no3I/aeDctTXiNHb2hYcsPs=;
        b=U8RnCTWeqbriWyJ4wA+SJW6sW/lRM70HU6Wvu6t5u0N7HzsZ88wXdgwZUNBQ3GGSlX
         HKni+7mF8TjN9eQRmQTa6DpOke6A6jw4PMq1eJOVUi7T0VDOQsclBdema0zjh9euAoPf
         TFtUcAxr6czo1jdtOFfi/ULYXXT6A+E/iIugK4w666SWqyua0mnWwZQfdkJJAIopf97/
         LNx5O1Wl2MZ/424TgxAQWV1+v0Lps09O0muDkjiI+OSGZZDhKMUQlRvIYckHqJ+DGCLZ
         lnzDPrJIZ30eFE62scLpqOL13GrsP3SRZNlkoXCtFGLyOVbpJI/9qzxdPTGH9tlWmr1H
         6Z4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560940; x=1794165740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ri0soL3Qksj5Kdn3SrP3no3I/aeDctTXiNHb2hYcsPs=;
        b=V7cEFCUpNrztmJW3Nx/exFQLgELBICZWyqPUYnysvFHi9Bh88cMhd6dhclkC71XI6F
         +Jp/SwfP5OtS9wFpLxflRz7C7DslYcrys+1yNCwvhYqKn4s16ok+9g3hzsI+/uZjP9lY
         ZFTqCXcHX6kCkNOyW7WM22GA9+TC8SgzZf2m6Fvounb0Erki6p1T0EtLtLxL9d/a+mI5
         VTYi6jPp5xsQ6G1Dt07Yl8owqHYEkq5bKMWQE2o1OI3wU4xfAe4WN1r+RtIGSuBhF2ZD
         bzBgr5wtuvFF4U/UlnVUl/hVzwnrxqVN0Ti/5FnOA9DZGhW/chYybDsTXePD7geDuHJZ
         Ty6Q==
X-Gm-Message-State: APuU4Z/mm6URuTsdthedwnNJX7MwDRf2l/2GkcCs9oxds2WpcPjvEAP2
	CcPjyMku5O+nb+BxEGJgIPddCGmzgeCF94SijgaWbue2WZqpmzzZE5ogbdvoOA==
X-Gm-Gg: AYBFou2PD/RwCo6Eg1zUqHd7hswAAjSDawq7lrq84vc7E2YhwRYRuIrvbG0GP9Nn9hV
	prH0HGegBQv7z+Cc+VFwTzXXpUK+g3NX8EzXNJPwOtcZxWVm+nnkEdbOrQqRb77mwefNJEnJPey
	V9sB20BMUr5zEDXlAHx7reoC4VwJJ994dcKdppXSkSNf6dhZFG0OCR/9zzYKxXGoiOs2P/to4BO
	wgmVxWmBlh5x+bDCrprkXXa82jO3eyp8O3sIYrebiflu8SO1IdjSDwdjUwidJb2ZPfapSlyDAm+
	UOjW9wUsjDEria0hSjq3vlql1DlCHd9lHxgohpiGHuDGERaRFUof6RHLME5HCBPlDltW+5JUMVd
	v/RX1KlwIKo+7UxnIC5X3fvEUgko3PbHYJuAINYBmXsr4kwVYCD9uw5Dg0T2QqjiuyOrta3To9i
	XLT1donYM8mcPXPejpZLi06MleodKezhYL+utmkTpS/xLTjKdlfPU3ixG0ipTpyMOIOOYVdJReZ
	+vDe+Nj70aH576pelHwaQuEi/rJeZwzcFqU9MVenhM/+FmOR1rXiybyhPQKkIyruvBNB1IpRwOF
	/F0gHEwhId0GflytXO/t7ngtu25ZRJ0x2wlJdF8WaWzsw9QwtKOEbAZIH+GiJnfNOheJ3D+YLj9
	7aYAubGHrZeFZZWfRiWcfoseID7N7oU/nAnzXJyxVBjCYKbEOEsu/wdxBjZnTq9psaFXNktl9xX
	g=
X-Received: by 2002:a17:90b:5344:b0:3ab:a3ee:33ad with SMTP id 98e67ed59e1d1-3ae897eb378mr6384359a91.22.1793560940036;
        Sun, 01 Nov 2026 11:22:20 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7d429fsm15190285a91.2.2026.11.01.11.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:22:19 -0800 (PST)
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
Subject: [PATCH bpf 13/15] bpf, sockmap: Check that the redirected message is the cork
Date: Sun,  1 Nov 2026 19:20:55 +0000
Message-ID: <20261101192057.2296489-14-alexei.starovoitov@gmail.com>
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

In tcp_bpf_send_verdict(), msg is psock->cork or the sk_msg on the stack of
tcp_bpf_sendmsg(). If psock->cork is not NULL, the SK_REDIRECT branch sets
it to NULL before release_sock() and calls kfree(msg) after the redirect.
Thus the branch assumes that a cork is msg.

This is not true after release_sock(), because a second sender on the same
socket can make a cork. The first sender can run the branch again, and then
psock->cork is not its msg. Nobody sends or frees the cork of the second
sender. kfree() gets the sk_msg on the stack, and the kernel crashes.

Compare psock->cork with msg. Nothing changes for one sender, because
psock->cork is then NULL or msg. The other branches do not change, and a
cork is still not safe for two senders on one socket.

Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv4/tcp_bpf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index a450b1ff3cfb..9bdcbb0a5998 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -509,7 +509,11 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 			psock->eval = __SK_NONE;
 			psock->sk_redir = NULL;
 		}
-		if (psock->cork) {
+		/*
+		 * Another thread can make a cork while this one sends msg
+		 * without the socket lock. Leave that cork alone.
+		 */
+		if (psock->cork == msg) {
 			cork = true;
 			psock->cork = NULL;
 		}
-- 
2.55.0


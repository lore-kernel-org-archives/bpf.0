Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604163;
	b=esUXdpHFPM482mnRsfg71fKf816PHuzuVhyaA06JZCZcK0flujWiG8Kkuk0FWh0Jnwfs
	 m13clfB3wAeX5JK/WwC9MRtXstcvmeHUIuV8KgYne2dDDlr8eh9QW5lrHWNL9ybRcylNn
	 x86m2QXVzu/X4DqQtq6QnCBpP3DRQWkPmT95Jjaa/egu7rf8S/ryR9pYm2s1QTmz3uiWq
	 iza7EtFuFbk5XRlllcOYG6bE0D6cFsIELmwihzX0eyi/eiZTqGrSz62fuQlyVHXsuiMoe
	 cZfGm4j+/lJLlZoMpP0c4kdFaqEzoWkK4yq/Nkm3Mr9NlBlUHAq8JebbZMGqcI299ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604163;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kV0Z1USHTSrdHd41dgedNKXyUstH61hWM+CBeGfT+gI=;
	b=VZhkp+DqNH8RmVj8tSHG550O4atSXqt31GyRl+fbH/vUOwppRmTk7QmgZUeuZ0XC1HcB
	 Ky0gqZaTiELUMtRrSXnqWkEXkfo7LjEOrXCAJ39/iaNgGhEkEEpdaJHvoqL/gZGRbB/Q3
	 SrYn2eXY98LO1aECpApzV4OL4AueSxM5kf52kAp5EzvKjXMbMxGe6Yg0cBbAZvdQ+CFs/
	 d0G0Lp8jQGGrAGP2gqz6+jpG1YfYZzPbPHXC+z8foApPnoLPncB7YAR0l9i3G6AnsmaBF
	 OH7FQYjGzLQSSx1cKZHsiZfkkGg/6aBtzGbucryLiZWayNea/GNOcEQK8co9lr7HvPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n723iRKO;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B800A606A327
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 07:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B800A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n723iRKO
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so2017775a91.1
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 23:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604162; x=1794208962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kV0Z1USHTSrdHd41dgedNKXyUstH61hWM+CBeGfT+gI=;
        b=n723iRKOc3RenQYZgKJq3yYeYR2XHXCsPK0uiL9Ltt/p0Hj52c3Sc7ajFo6I+VPql2
         Jm8i5TkRp4GbWVvboaKYRU1vIC+H0r/dQWbFkDqN900rtWP6gh8sQb9HKQRZMVxwgbp6
         zhXCBnY++CzGMtktaWRIF0tMYl4VM29Hg+3LD+L8Z12U2PIZM6S5szj9u2b4CwO52kjx
         dEJ8SLgFZ141A60mK3ZoU5SsidlzNoe2deoHpiUZk1opqOJpnTh++B/98NM+maMQmW64
         iYTbHJqBQJEeaPvEIHpcwCxq38XSDyFzkZBAXHSliQiG5iAvXYOBrADNZXBdIJWFC3G8
         HBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604162; x=1794208962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kV0Z1USHTSrdHd41dgedNKXyUstH61hWM+CBeGfT+gI=;
        b=JHVX+nmDoG7GOnaFczfjwz9k7cF7BD3AJtdZBrcQoyBTsyC9OWEOEh1qMJw0wZev5C
         EH5EsUQ8VeD0Kjud0maXwoOprDBydRhb9Yp1hKo8JF10IeFAteZ1fsc8qQUS516l/BRY
         xs0fZ5/gnepppMYMZNmaeTasz8pwe+EM6QgdmkzBu6TnCX9f6+2php+biG4SeVxoWWC2
         F/X5PlMryKQN4IW5uwuKTFIsSGjMOkHC2bht2G4n1T84S1lwyMFrg8gIEg07xqzT6fXQ
         hojm2YUk9J1kJrqRkJVlWL1EQvPhp/n9DiJtFItQxb6p4BzfjZQEqK606tXISF88DzwX
         P/IQ==
X-Gm-Message-State: APuU4Z+Fr5YztIkldbHaScumwZ1irRCCHy2w5+5EfPZrpskXNaKeyJni
	6clVeqjFWlxWFsmrLgRRfhyggOi4sbcKGWwChJINiDD9QRCi/gGRpTPS1se1MA==
X-Gm-Gg: AYBFou0a/y1bB3PFM5z2yuEUp06iYDRvZrrwuOfmObMIiYTJy+P3N+3NZ/r0R69Wd6y
	Q0UpopTVzDHYTFPboKfXc7RDntRro+aqUh0dt0d2jPiXQRiBeIxOYhgWyqJMp/IjW586Ls6IV0V
	TkVYWFp0bZq8zkbbZw9hy168p6RCAqW05jbk3K9Lqy1YPS2U6a4p3B0Mfd8McnDlo0xyuVBqq1j
	DF5Uzb/2ey2uRY3N5uCffQvprTxIR6xqExR6fXjdoM4ftOST/TKxqEncw5Ud6SGLDDPyVEFpq81
	06/hpx5Z5ZBT9AgD+CnApnGrCzUI3PBkNiLxas8CkhjDxd2qsfA4Z/LLDQxkUHGrDLnFD0lkamq
	61EJ1MijyRI3ikyj4CKnfrrjng6j8zSQcVP3x86yLZgXcnPoxQMF8HpQD0H7HSE2Je9rTKRfEBd
	/7qgvxWGuPbqoC92Xo+yZ7ig1O7pgCTNIB1Icnpjf+l1Vif9ycEvNyhpwJx1sw8GF4nPSkEv/PX
	/e7Kx9gmOfhbUNFWZMaVBpSgSDBRN0U4V8Vx+Ava+KW4XfCmU/GEYc09lywtVeI7ipgAsZkZvCR
	EfYYQ1m/eG3K1nokHRy0U+ShOPAfLqfXHI+wrbXFg/ImxXK06YXnEOF04Aos9JgpotSjYlBFDJF
	FeLKxpb4YEA2M483kGpL1ZWvqUWPfC+N9fYrwOBgDo4cMjBGbLf2zGyk/8kBiZuT2rKai38tAYg
	==
X-Received: by 2002:a17:90a:d2ce:b0:3ac:9176:e83c with SMTP id 98e67ed59e1d1-3ae89720616mr8312885a91.12.1793604162098;
        Sun, 01 Nov 2026 23:22:42 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845df666sm13045987a91.14.2026.11.01.23.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:22:41 -0800 (PST)
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
Subject: [PATCH bpf v2 13/15] bpf, sockmap: Check that the redirected message is the cork
Date: Mon,  2 Nov 2026 07:21:10 +0000
Message-ID: <20261102072112.4160195-14-alexei.starovoitov@gmail.com>
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
index d8e29b09818c..b1071b0960cf 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -517,7 +517,11 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
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


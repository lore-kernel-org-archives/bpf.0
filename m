Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334101;
	b=TVRsrWvIo8QUAxObkG+jWmgWimyA+sqNkdokIuXOeitWLl5Z9Gm5bgSAVr/F1MbuIR71
	 Jbtfhwcf+eWa7WU2eZGZj60KLfiIOYc8XmPCnVBASMS7emPMXXyXSFpH252FLbguD2ibl
	 YrtJ7NtvRLVbN7ND1yh92ykymLzWpcMPAWK01mqIxDjLSq3nd/dRLeZ8EEXEAKcentQeB
	 CvVzutaJZWWSJfTXokep9Vr6ji9kMZcF8HaltqzTV+3+hH2mr3h/y1N63qkfJL1q/97YW
	 ThXt32mqA1VMlPJfj2YZsAzmQjSRmcdvqK1xpRctfWwGhMKapgTPL26FU5F75SlY1Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=PMpIblKmZXt8BOY3Honm+2Ww2wYw3iNTalEqXhUNRCc=;
	b=L5WGQqKryma55sCuPylSVTL00yPApQOTZCKN6bjb8MxttdSv3iKIKqqsw/amiq8Y23UA
	 wTALJgFP8lzS68emkneEd0R7lV0Xazfd/hgwm/r6xHyrPScirJqOGJidWZR+lXLbcWIuf
	 I4mOceF8MXrt1siLevK3EMidRAX9ZHHWB8xZ8vCzqku/ObaAtoWI2mnnK22duEo0kAAUe
	 Cxcm/6qzUHr81ZRrg9CwuZeH+q78rymzqgnTnvs9tPwtepOiDJzunqwe+BQtfAyvePOBN
	 8tmuD4a1X/BMNcf38MnD43nQFZJeL4xF1QzOX+T3AqiqOGubYpVFL84DYEfvEVTartQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=V2Tu+7XG;
	arc=none smtp.remote-ip=209.85.160.46
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAE5606A31A
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 04:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EAE5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=V2Tu+7XG
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-48e94879f02so96452fac.0
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 21:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1793334100; x=1793938900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PMpIblKmZXt8BOY3Honm+2Ww2wYw3iNTalEqXhUNRCc=;
        b=V2Tu+7XGLweuI6JuW4q0Atp29krGpuRTqzaj3uF28jN846RWoygzoK6hQsvoo1UC9X
         knJAdo9MZNzSZj+rmkB/s1YKmt1kHg8xySqg/Y7Ilb8KXauOASd9C4O2nnuE4TRK807M
         J6rcR7iWe6FJEElVS0i4BdLAwdMFYZoYnAJMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793334100; x=1793938900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PMpIblKmZXt8BOY3Honm+2Ww2wYw3iNTalEqXhUNRCc=;
        b=Dr9zQRio7Yo9oJUzCfVXvv7mPfilGN1mJj0Y5ooHgcpPHybw1g0Qa82Wy12A054Nkt
         LuuHvit1flhUo1klqedLuvhN+BiRYA+l1No4RFs2EEZfR8rAMk0C7/8B855xpP8DHKur
         vv94TDM3lH+G5Ju5rnw32t00K88PdDWIDzVV9YtPP7eSWM/1OtyezcrKFlwxxJUMjXgW
         Nf0dKCig9i6GNcDpx0PxA3Kff9Vom9yExFZM8QNnnXYmdJqitraEvq+txCvamVhRTN37
         DB8hfa2ZdziTDZmnIF7XiyaKH1Y/BM6Od1+uDpYCAOmhrw8yCO2mVut6r0iShnBSq3f4
         fJKA==
X-Gm-Message-State: AFq9FYJssmcPCrLTv0wXkLxtGr6g3AlJl4auoSZfGgs2b6PKZOat7TS+
	bBy7ErlE1J+6iTaSBeiU1OI5PNCmXlG6xldaBASGP0LQt4QeS6KlPXnV7Fts4u/Du5AozH7WUyF
	XAHPYR/M=
X-Gm-Gg: AYBFou3M8qfUy66AnJLMdVOceCC8/b39oeGWkpb0DNsJYAahwx8ta8zcMoitkm+WwPg
	BHI/WG0C0Z6pmRxWAcYrERg68kt4O+t9zflWCnbJauLYBA7ULrIi4B9oM9ygbSyfStUzo4zefl/
	lNafCujEGJAvIBFXtqKWNSITWaYG00LWLBcdOI8ukQa2/TRBt4t7FvFcGBB8ce9nvdF+K158/xn
	V+t/YOpyjlDmIHuLupv4cO3Pcmr2gH0whpSxSnonUTVmijVw1pAZ4njjQ7KAcv3lCqmRu+lRE/3
	c/sAOZF5frrBrn4BRWFGFHv9ghJP0Xg4ULuqGBPyHAbwXy6nFgxJIHGIAk8zJoE/I0PaspfaMFr
	U1czLK0mSx200whb6xODiydT7ROeUz5wkOb0W85plxTR/jJKR4hlakYmwNhd3N2qfAmDOOlSeEq
	wJijO1q9Aq6shuLCXpWlHM5mxBE8KplfBbiKeHaUHW0fImFMv3ejbB8mZGNzWBpn51fZK3d+o9Z
	njxX+3jM8Ofs6JlObdELm8A8YfvuxahRWAiapW3Q4bs6lRpMWm6hrmakIPU5KKtbEWO8OnFlnRv
	/tit/l828KDQZRa7xUC5LNQQW1VnO41P1Ejvxtxh9mk7VpUs7I/z4uWHh1I7qaunT0Spc0OuUub
	G/dZXW3nrDyHkn1s6dHIOptDHWdsIlw==
X-Received: by 2002:a05:6870:1f0a:b0:49d:c8ab:967b with SMTP id 586e51a60fabf-4a907775750mr775519fac.47.1793334100321;
        Thu, 29 Oct 2026 21:21:40 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.5])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a90af650a1sm769349fac.15.2026.10.29.21.21.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 21:21:40 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: bpf@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	outbounddisclosures@openai.com
Subject: [PATCH] net: skmsg: fix copy cursor when coalescing clones
Date: Thu, 29 Oct 2026 21:21:38 -0700
Message-ID: <20261030042138.73739-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
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

A splice or zero-copy append can leave the destination copy cursor at
sg.end. If sk_msg_clone() subsequently coalesces with the last entry,
sg.end does not advance and the cursor still points at an unused slot.
sk_msg_memcopy_from_iter() can then walk around the ring and write into
older entries, including file pages spliced from a read-only descriptor.

Software TLS can reach this with an ordinary MSG_MORE send after a file
splice and a splice from another TCP socket. Both TCP and the TLS
encrypted-message allocation can use the sending task's page fragment,
so the TCP-sourced plaintext can be contiguous with the next cloned
encrypted-message range.

When coalescing with an exhausted destination, move the copy cursor to
the tail and set copybreak to its old length before extending it. Find
the actual tail on each iteration using the ring iterator, including
when end wraps to zero. Leave an existing copy cursor unchanged and
preserve the normal coalescing, reference counting, and memory charging.

Fixes: fda497e5f5b8 ("Optimize sk_msg_clone() by data merge to end dst sg entry")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
I have a reproducer for this issue and can share via DM

 net/core/skmsg.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index df385a5a961e..0e9ff4be78ba 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -103,16 +103,26 @@ int sk_msg_clone(struct sock *sk, struct sk_msg *dst, struct sk_msg *src,
 	}
 
 	while (len) {
+		int last = dst->sg.end;
+
 		sge_len = sge->length - off;
 		if (sge_len > len)
 			sge_len = len;
 
-		if (dst->sg.end)
-			sgd = sk_msg_elem(dst, dst->sg.end - 1);
+		sgd = NULL;
+		if (dst->sg.size) {
+			sk_msg_iter_var_prev(last);
+			sgd = sk_msg_elem(dst, last);
+		}
 
 		if (sgd &&
 		    (sg_page(sge) == sg_page(sgd)) &&
 		    (sg_virt(sge) + off == sg_virt(sgd) + sgd->length)) {
+			/* Start copying at the newly cloned suffix. */
+			if (dst->sg.curr == dst->sg.end) {
+				dst->sg.curr = last;
+				dst->sg.copybreak = sgd->length;
+			}
 			sgd->length += sge_len;
 			dst->sg.size += sge_len;
 		} else if (!sk_msg_full(dst)) {

base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
-- 
2.56.0

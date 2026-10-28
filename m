Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.65
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793148303;
	b=uEhsjhar1rvr4ssWuHcRpXK1qiECqUbpvju7gq71RIdqektMk8z4oSmc3irgqwfWhA/i
	 hQG90kpP/c6kFHCJp95j4jjkbYw2nkYELn3ukgIOzdvhjhw3RKT58Zey6J0epO9MLCX/C
	 bn9EgPBbuTgGRyd98Q3Ze8uHpnhHrjlAS64AJYsD1v1PQNrZB1pHnaNBiJpKFY7I81yuD
	 z4Ubr+B3q9dReYXG/MhULMYKwSUylZYnOqmSq8xp4MBLDSVv/kdE0DpNW3x2ZBlGNKd+E
	 3XRTGaIORZgaYOthwcfmZx1M032p8SuS/8o7ynLV9HFiGYtObwkwc/Nv6eKdhH4nWNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=U6ubplcrFMxbmT77GcsJA9MUhOm2bB0cLLErPjXVNfw=;
	b=zuz1XAdyrp9CSod+gomw6lipfmGzVaymOstud9sl+PPQyblpq5faps459AllN3vS7dfF
	 IpO0vA2Y9tNixA3kPR/lox3w1b6FrvDiZzI321nN6BMhse6RSLi/cMjTo0lg+RAk18oxd
	 i1m6YR1v9+KaJeudiuk2QH+pCn4XjopocRu5pAw0RI/C2u7NL1jVqh3kiMovENoMhrEAW
	 bD//xrmrKhkfHGEvH+SZZxR5u48KseS3hnrYi/XvGvp65Fur7lIf+7iQJUPdb0UAAWMWZ
	 ylj2vEp+fKsZDwBjbVdj/ZK0zTV4XNVS7hsraUD2/083TYohhHtq+iggJ1PxqTeAAFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K2AiAvhm;
	arc=none smtp.remote-ip=74.125.225.65
Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93841606A31E
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 00:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93841606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K2AiAvhm
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-48e345608cfso144779f8f.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 17:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793148302; x=1793753102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U6ubplcrFMxbmT77GcsJA9MUhOm2bB0cLLErPjXVNfw=;
        b=K2AiAvhmMgLZIjMEdq4peEZKrT1Y3yRCrGd4Y7UI/gUV7Dl8t85eG9AH4l6xMtcnMC
         ZlaZ+h4tIKm1gC3G61Fgk06gOyt1jAwp0M/6gPAVJkhmBuHPQnFGJgZ0EFGByu3BEeDV
         YiPiEInVK5QS/FFCfh0Oz+DQdyMaRe8Dt0sJwUWPhqmgYZTceoDACBuQvJyclPjdY5Wo
         wq84VSiTFJoamcGCj7+hdXylJphZIhWro0Gz+rQwCNNTuyAdl1F1oomwm7oRZZpyfMgA
         /vAqsWQT9xuss6vBd/LqHd3v9rDv3BFhtuD7iaw8ce2nXkCCzll1zk1YHBgSLJ56+InD
         bqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793148302; x=1793753102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U6ubplcrFMxbmT77GcsJA9MUhOm2bB0cLLErPjXVNfw=;
        b=Y9P6/c21m7J9ty8dcG7zBkNghizkJGya23V685H1lUwUFbdLqsUsFoQ8UnZ2L73ZMg
         H3btzyILACtbuBuU1rWgljn0SwPaBPNTyIyoSvjSvELh6Uenlfu7NSSDRF2sCBMVSYDW
         Sdw0W0ZMOLiSIxCeNjC8jKlMCTGXliRPoG208rd9j4oBihliA2RjJRGqjcZRNMvAdcvR
         ISd0+vejNB7CtgErZ3E7X8eX7X1qcaPIJSj0TyHBTyi5wUC2hNbktNisH/u7ras5ENC2
         kHq42Z/c47754C8+TKnSNK7qapJzx6Qy2BnThZCoETB68P2BJOOK7rh7yB2A7eKOwv72
         EM5Q==
X-Gm-Message-State: AFq9FYKTwjmsiLkevymG1VP/t00f/NWBK2eqEsnnSdusvub0z5QmXOxK
	YGKbNQMWbbBtCJHt/VBgkEOUPlBNY4rW5nxlZla4DNJ1IWtTSvKxuu0aGeo532IZ
X-Gm-Gg: AYBFou18scqyxhLzwWE7YQp3qBo90whgTyFcGM2g/ngr5/J8vASjBxAeKcBxc20FLrD
	uJLiRcOEHFxezBTU39LU7XGgSA2suT8X8kPsEIuHlHpHK9WXeep9oil7vTZQPj7pi6Si9X+8SDf
	eeLKAITXeah+yX1+q6+hPy+bKjjgV2fsbVMFS1LGaivLRpqBU18DvSbIC4uFjwi5w1UzAJcst7h
	VRvkKFMq+HK0yZiyrAex6Ru7TTi1iQO73HXLZhfaw1SC1ShSZvN2iuji/1kkrOy8EumiSuBQbeU
	KJMaGLCuT0vdIo4bNysDeqSXc5rnWnIbgfkNGIt7x67sMtzVFBuPdfMYHk+GbNcBsMNnOmeyNzN
	olgr6TgRl/3+tgJC8eOidy40JaoZ3Jd8PJ0Sk0RLAKOvy/QlBfn4oU211mAje/m+jTt2vty3GjX
	p+/+0PQj46U2Ol4zsD/GYkqLCc0vZNe3YD3iZycCPja7CgTFZ5065NrDQL5fWUpT4fkpnKsU7D6
	3Rv1C7cy3YM0Jrep2hHsSUqn1m9w5qq0AoY5kRbX4p9diR6iIfwtcHIUsQJn8yMppmtTWYhBPWw
	CrCtsx7mUWh+srIJo5v/3K7XCoGUSocqHvhxeshYTmAmeR7YA2UKCMtTGQImvTR33SguCsz1E4E
	orfNEQnGQ/fuoMcP6tLsi
X-Received: by 2002:adf:e004:0:20b0:48e:d7c:4bc8 with SMTP id ffacd0b85a97d-48e5d284d83mr1857708f8f.7.1793148301749;
        Tue, 27 Oct 2026 17:45:01 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd4bc5sm25501320f8f.34.2026.10.27.17.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 17:45:01 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 08/11] bpf: Let the callback of bpf_user_ringbuf_drain unwind
Date: Wed, 28 Oct 2026 01:44:45 +0100
Message-ID: <98e3a499d89e01ddfb83fcf91e34b2a0e36e1007.1793147364.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793147364.git.memxor@gmail.com>
References: <cover.1793147364.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3158; i=memxor@gmail.com; h=from:subject:message-id; bh=MGvGNrDpLZw+wuQVWtWUC6Ucaev9LuDeujVy+xvdDc4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeuh4/N/p+bJc9+o2PvOjjVEx3ft1p6qjZLLoxcuclsXd CXjdh5vRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACbyg4mRoenfnxLDl3NcespK r16YEmeYpzF/QuRmJTldDtHPentM/RgZ1s0Wyf6Y4jm1Pz31pcfqNTUz/LvfTeXlXTL1wdafimq TOAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

bpf_user_ringbuf_drain() runs the callback with the busy bit set and a
sample peeked. The pad consumes the sample as a return does, and counts
it, since the wakeup at the end is sent for samples consumed. Then it
leaves the loop through the door the error paths use, which clears the
busy bit and sends the wakeup, and leaves with the r0 of the callback.
With that the verifier lets the callback of bpf_user_ringbuf_drain()
unwind.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/ringbuf.c  | 23 +++++++++++++++++++++--
 kernel/bpf/verifier.c |  1 +
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 447863ece26a..fdd997f36f73 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/bpf.h>
+#include <linux/bpf_unwind.h>
 #include <linux/btf.h>
 #include <linux/err.h>
 #include <linux/irq_work.h>
@@ -814,13 +815,14 @@ static void __bpf_user_ringbuf_sample_release(struct bpf_ringbuf *rb, size_t siz
 	smp_store_release(&rb->consumer_pos, consumer_pos + rounded_size);
 }
 
-BPF_CALL_4(bpf_user_ringbuf_drain, struct bpf_map *, map,
+BPF_CALL_x(4, noinline, bpf_user_ringbuf_drain, struct bpf_map *, map,
 	   void *, callback_fn, void *, callback_ctx, u64, flags)
 {
 	struct bpf_ringbuf *rb;
 	long samples, discarded_samples = 0, ret = 0;
 	bpf_callback_t callback = (bpf_callback_t)callback_fn;
 	u64 wakeup_flags = BPF_RB_NO_WAKEUP | BPF_RB_FORCE_WAKEUP;
+	bool unwound = false;
 	int busy = 0;
 
 	if (unlikely(flags & ~wakeup_flags))
@@ -852,8 +854,23 @@ BPF_CALL_4(bpf_user_ringbuf_drain, struct bpf_map *, map,
 		}
 
 		bpf_dynptr_init(&dynptr, sample, BPF_DYNPTR_TYPE_LOCAL, 0, size);
-		ret = callback((uintptr_t)&dynptr, (uintptr_t)callback_ctx, 0, 0, 0);
+		bpf_call_cb(callback, &dynptr, callback_ctx, 0, 0, 0, ret, unwound_at);
+		if (0) {
+unwound_at:
+			/*
+			 * The callback left with unwind_exit. The sample is
+			 * consumed and counted like after a return, so that
+			 * the wakeup below is sent for it, and the helper
+			 * leaves through the door below, as the error paths
+			 * do, with the r0 of the callback.
+			 */
+			unwound = true;
+		}
 		__bpf_user_ringbuf_sample_release(rb, size, flags);
+		if (unwound) {
+			samples++;
+			goto schedule_work_return;
+		}
 	}
 	ret = samples - discarded_samples;
 
@@ -867,6 +884,8 @@ BPF_CALL_4(bpf_user_ringbuf_drain, struct bpf_map *, map,
 		irq_work_queue(&rb->work);
 	else if (!(flags & BPF_RB_NO_WAKEUP) && samples > 0)
 		irq_work_queue(&rb->work);
+	if (unwound)
+		bpf_unwind_leave();
 	return ret;
 }
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3c39cc0f358a..fd63ff36eb90 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11409,6 +11409,7 @@ static bool helper_has_cb_pad(enum bpf_func_id func_id)
 	case BPF_FUNC_loop:
 	case BPF_FUNC_for_each_map_elem:
 	case BPF_FUNC_find_vma:
+	case BPF_FUNC_user_ringbuf_drain:
 		return true;
 	default:
 		return false;
-- 
2.53.0


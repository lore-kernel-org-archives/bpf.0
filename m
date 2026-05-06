Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5489E47F2F3
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 14:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077645; cv=none; b=AtPqRefS6D6oQOkP5op5ZJX2fvDunOFlnbVT/GYclyfcKeVuRtiT7i1EY/ta8YMKzkNS0xsWeASfnXotLkBmcKB28KiJ/IonBeTx+YZbjnCjpm9CF7f8svbMp6cEVWtK18OOcAUjfBzIBbs7BiB9w/kCVOkuEwEvnv+zXmA0Wl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077645; c=relaxed/simple;
	bh=BzeX94441cswHkbsQc/+gIoVnBxhBs7DF2GRrl0MOj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EoJFIzzgaooqbISj9mxgA9HuurQp+QFzYHLWWzzGiSHplE7zNqnByh1gXbsbnVwH4zun72yS0AL1NVFZ/uccOAnFk4xGAVybzVTpZJaoNTqOauAPVKS6XfIBwvcTUbY/hPNP1BSjEsA4g+ms9Mvw1xpuL3H9ZsLvs0yG7YTf7gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LD5ZrXxP; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LD5ZrXxP"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8b3fe2f19a4so58788496d6.2
        for <bpf@vger.kernel.org>; Wed, 06 May 2026 07:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778077638; x=1778682438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bTNnxuGpficxnDh+SY37WmiIuJPAHbR0Q4L6x8/7Ic=;
        b=LD5ZrXxPCcDrEZJgtQ8ht7CoehTIj+WiT2+e3goqjn/LHv4O7QYnDVmpDL6exS2x2l
         wG3Z6h43TuVAdrHc9yWmeGMIBgZ/ADGsLhymEKQLmWRVZlXzGs73h9kwFQSXYR1rXyec
         aavMc95pHDDcNxNNwvjY5KT73eU4TZHoFpm2Hx60Fbez6CVgNQXmE/DYRWFt5VJVIMSF
         rp+JxxwgByevFgqFuRFHfY3XuvN482JJenwwUg6igT4e+hSnKqSrPjDjYNeD1ZkvRk1P
         +bwN94xBkDj+bNck9788YxABBmsKGB+B7sTh4j6E28xD5d2ONd3o2m2uPJuE6bYno5FP
         w68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778077638; x=1778682438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6bTNnxuGpficxnDh+SY37WmiIuJPAHbR0Q4L6x8/7Ic=;
        b=d7VInip6jfpBiIv/49DqSaRHCMxTcvveYWAAEwDveKHvlSYktuyikex4/D42Vy+O7J
         DJ6XT3QRSnjY48DJLL6zjsysWtG5Jj4RcZZsmmT1GOUThoKr90sfHZc7J3ljIgEglZXh
         jpcU4fj+Cmw/cYq/y5VeiGBqMowdFRFNJnqD3CmC/CBx38C1H4NhKde5mIZRsQWI7ulY
         GgBECI3InhuVQMN1CSY+L0POauEUhq/1QYymQ0ZMjxGI4Kn/xou5aoqf5aZUX3ChJn8U
         AtZrdA31BqpYkZl/0BJks9gG7Gm4nyZT8Il05ds4Um4XF8moL/GEaM3eIsB8UZsMgLfU
         l2IA==
X-Gm-Message-State: AOJu0YyXCQnEBl3pSIKKGBj0MAqqJWZgkLJw4aUq21cXTLfrcOZfz7ri
	6rvTF0tPPK3a3dQg7wJx7Miq670pr7sA/wbjbjtkMZDvWWpZ9ldHyBeu2azoWxCyUcQ=
X-Gm-Gg: AeBDiesWOQ49SzfI8hdV8EQBM5rIDgDEXg9RQnlX03BrbG0NncBtWeVfBQiDYlezHVU
	G8X18FpzD1w7XWEdTX3v7eTbsiDWZzPcetX8doVaxU01HcWXiO7BSsZeuFbCQKDuYSm5D5azoLJ
	d2+fWtdTbYnYCYZARdjYb4Y1QkSX+X/EvOwJeGFJfofAaYtiJOecqEzMSSVfCseev9tMAMAkz08
	kTlotmWrTgEfp+yoeeXLIRh+B2d9phyUgeQYu45IBJhM64cd4yXqHoBBFBnshsqqkLFgkX0VDrN
	wQfquxdxXlsukesx/aUqcS6/b+ohZxUcZwHFroLyksaWxOHmAElNAjcaK6aVg90gGLPCrocex42
	izuSNFCXr7yrub/0BzMiUhLIpIxecRo4x3CXIY88TuMINSCbgjv7RY9mDf4zaEg1X6NzVsheHgG
	99nePu+ZswSI6yxJ9ouc+iVQ2Dnao=
X-Received: by 2002:a05:6214:4c87:b0:8ae:660a:be74 with SMTP id 6a1803df08f44-8bc42783129mr47284046d6.7.1778077638079;
        Wed, 06 May 2026 07:27:18 -0700 (PDT)
Received: from localhost ([2a03:2880:f800:18::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d6442d0sm177652366d6.46.2026.05.06.07.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 07:27:17 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 04/12] bpf: Preserve reg->id of pointer objects after null-check
Date: Wed,  6 May 2026 07:27:00 -0700
Message-ID: <20260506142709.2298255-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260506142709.2298255-1-ameryhung@gmail.com>
References: <20260506142709.2298255-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Preserve reg->id of pointer objects after null-checking the register so
that children objects derived from it can still refer to it in the new
object relationship tracking mechanism introduced in a later patch. This
change incurs a slight increase in the number of states in one selftest
bpf object, rbtree_search.bpf.o. For Meta bpf objects, the increase of
states is also negligible.

Selftest BPF objects with insns_diff > 0

Program                   Insns (A)  Insns (B)  Insns   (DIFF)  States (A)  States (B)  States (DIFF)
------------------------  ---------  ---------  --------------  ----------  ----------  -------------
rbtree_search                  6820       7326   +506 (+7.42%)         379         398   +19 (+5.01%)

Meta BPF objects with insns_diff > 0

Program                   Insns (A)  Insns (B)  Insns   (DIFF)  States (A)  States (B)  States (DIFF)
------------------------  ---------  ---------  --------------  ----------  ----------  -------------
ned_imex_be_tclass               52         57     +5 (+9.62%)           5           6   +1 (+20.00%)
ned_imex_be_tclass               52         57     +5 (+9.62%)           5           6   +1 (+20.00%)
ned_skop_auto_flowlabel         523        526     +3 (+0.57%)          39          40    +1 (+2.56%)
ned_skop_mss                    289        292     +3 (+1.04%)          20          20    +0 (+0.00%)
ned_skopt_bet_classifier         78         82     +4 (+5.13%)           8           8    +0 (+0.00%)
dctcp_update_alpha              252        320   +68 (+26.98%)          21          27   +6 (+28.57%)
dctcp_update_alpha              252        320   +68 (+26.98%)          21          27   +6 (+28.57%)
ned_ts_func                     119        126     +7 (+5.88%)           6           7   +1 (+16.67%)
tw_egress                      1119       1128     +9 (+0.80%)          95          96    +1 (+1.05%)
tw_ingress                     1128       1137     +9 (+0.80%)          95          96    +1 (+1.05%)
tw_tproxy_router               4380       4465    +85 (+1.94%)         114         118    +4 (+3.51%)
tw_tproxy_router4              3093       3170    +77 (+2.49%)          83          88    +5 (+6.02%)
ttls_tc_ingress               34656      35717  +1061 (+3.06%)         936         970   +34 (+3.63%)
tw_twfw_egress               222327     222338    +11 (+0.00%)       10563       10564    +1 (+0.01%)
tw_twfw_ingress               78295      78299     +4 (+0.01%)        3825        3826    +1 (+0.03%)
tw_twfw_tc_eg                222839     222859    +20 (+0.01%)       10584       10585    +1 (+0.01%)
tw_twfw_tc_in                 78295      78299     +4 (+0.01%)        3825        3826    +1 (+0.03%)
tw_twfw_egress                 8080       8085     +5 (+0.06%)         456         456    +0 (+0.00%)
tw_twfw_ingress                8053       8056     +3 (+0.04%)         454         454    +0 (+0.00%)
tw_twfw_tc_eg                  8154       8174    +20 (+0.25%)         456         457    +1 (+0.22%)
tw_twfw_tc_in                  8060       8063     +3 (+0.04%)         455         455    +0 (+0.00%)
tw_twfw_egress               222327     222338    +11 (+0.00%)       10563       10564    +1 (+0.01%)
tw_twfw_ingress               78295      78299     +4 (+0.01%)        3825        3826    +1 (+0.03%)
tw_twfw_tc_eg                222839     222859    +20 (+0.01%)       10584       10585    +1 (+0.01%)
tw_twfw_tc_in                 78295      78299     +4 (+0.01%)        3825        3826    +1 (+0.03%)
tw_twfw_egress                 8080       8085     +5 (+0.06%)         456         456    +0 (+0.00%)
tw_twfw_ingress                8053       8056     +3 (+0.04%)         454         454    +0 (+0.00%)
tw_twfw_tc_eg                  8154       8174    +20 (+0.25%)         456         457    +1 (+0.22%)
tw_twfw_tc_in                  8060       8063     +3 (+0.04%)         455         455    +0 (+0.00%)

Looking into rbtree_search, the reason for such increase is that the
verifier has to explore the main loop shown below for one more iteration
until state pruning decides the current state is safe.

long rbtree_search(void *ctx)
{
	...
	bpf_spin_lock(&glock0);
	rb_n = bpf_rbtree_root(&groot0);
	while (can_loop) {
		if (!rb_n) {
			bpf_spin_unlock(&glock0);
			return __LINE__;
		}

		n = rb_entry(rb_n, struct node_data, r0);
		if (lookup_key == n->key0)
			break;
		if (nr_gc < NR_NODES)
			gc_ns[nr_gc++] = rb_n;
		if (lookup_key < n->key0)
			rb_n = bpf_rbtree_left(&groot0, rb_n);
		else
			rb_n = bpf_rbtree_right(&groot0, rb_n);
	}
	...
}

Below is what the verifier sees at the start of each iteration
(65: may_goto) after preserving id of rb_n. Without id of rb_n, the
verifier stops exploring the loop at iter 16.

           rb_n  gc_ns[15]
iter 15    257   257

iter 16    290   257    rb_n: idmap add 257->290
                        gc_ns[15]: check 257 != 290 --> state not equal

iter 17    325   257    rb_n: idmap add 290->325
                        gc_ns[15]: idmap add 257->257 --> state safe

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0891a3ac4d51..e1e95a066019 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15268,15 +15268,10 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
 
 		mark_ptr_not_null_reg(reg);
 
-		if (!reg_may_point_to_spin_lock(reg)) {
-			/* For not-NULL ptr, reg->ref_obj_id will be reset
-			 * in release_reference().
-			 *
-			 * reg->id is still used by spin_lock ptr. Other
-			 * than spin_lock ptr type, reg->id can be reset.
-			 */
-			reg->id = 0;
-		}
+		/*
+		 * reg->id is preserved for object relationship tracking
+		 * and spin_lock lock state tracking
+		 */
 	}
 }
 
-- 
2.52.0


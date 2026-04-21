Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE233A453D
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 22:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776809424; cv=none; b=U/kkE8x4vp0B6SCVjI7+trLh5OkF4y+RANSJk0I7MK9TjwSjjSbZvQyQzB0jwNkB/XJHqRpFavC+I0sbt1TkK4I7kLLUl4/BmFu0O/ybIv/LNQpq/fDou2LhxU0IvN4zwiQM27hlWIkrV+V1nKnXSU71JxSqInkomEQfg4gy0tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776809424; c=relaxed/simple;
	bh=wEKBaIcZaGICrYDZVcwKG88aZwiyYV2sOSwemrrgU9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NA5K+qKdBM3rmm/VBuwYXTZyhxLjw0zS/OvV9HgD9rre+dhdJyDAvWIXCNdGV87+lkGYa0t1/ci2o32rwNXPr17exmDRMZqgolzx/ZJEsyzi+z4GjN+PekZwnq3rbpPxFMJzgdfjLGz0dNvzzdrCJLZn7u4bCvomifiMjcDEnv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VV/yELyg; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VV/yELyg"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35da1af3e10so4546536a91.3
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 15:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776809422; x=1777414222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7WtMgyARQCg7ZvW2sjb3ATztaa73Z76UTWHf0LfROQ=;
        b=VV/yELygwRbKG/Rz4sferm3bhZ43+irooREgDSffJnJTDvPQ7+VPoomkE6Q8LHt8e+
         wNEspZdm9qdP231USPE8FKeCrSiwIUsORnkQU7yZ+D8/PgjUMyQCYptTVlqiexcXnBsv
         i7sXYpwm1BnAKMUmOdy5FdbjDWSMh5zoFZgvZdWKDRXtiRA8gWMWD4GJnk5TJzj0x1BW
         Lw8gaQOFT1f97YzCKs4lUiDeOQIpF+FJEo3aE4+CVvpZNzSuQmXO/JdHOqq2JHoFZqMh
         aAEX1BZb5QYdUSY/lEb2IKzzqXsnoC5eCmlvsh+AVaFX5bu/oLBB7BsOQREfvmTw1hXv
         W8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776809422; x=1777414222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q7WtMgyARQCg7ZvW2sjb3ATztaa73Z76UTWHf0LfROQ=;
        b=mtXKnQAuk/RlCrDXmj2z1KmqsspuEXlbUoEEZaF8t9vErLO8cZua77bFZWslYvlHWa
         56mntCBI/ZLhJX2O8stAqodKcUAqde/dNgX5WFErxzuqjBbQwVlpdOrE8p1KHYJC5T4t
         vayyscRDzfwUL+IPc1+oVtVAF+6KLJD5AA6zw76E6CSAaCXt99gqfM8wjZlYLdJlwkgD
         SGyul7sCcSYBNCg8fzYZWSznjSqUg+OZCr+IWLJ/lKVXg1hUsAjfyu69v6TwKqK6dZbU
         YYAngwduQi8fZLSvZbL+Ri5afXysw0O3wOefnatjO/0KYRulaI+2llECpEVuHFcvNkEg
         cMHQ==
X-Gm-Message-State: AOJu0Yy3rZpuntTX0odjlfakehlgIQmh4zp84ityM805Ucv4daeXOcjg
	ToazjTu9No5KGnR1r1XjAbgmn9xCrh9eEGbj1vZ69agWK9jk+p5heU8nFwt9XQ==
X-Gm-Gg: AeBDietgdP4FUBfFE1JZ1WlRmajUGmcOV0snP+jX7oMwadeEDdVqvkeSINxyV42IfVA
	nmojWg9N8DQAsJtQAnc89dmyajVCA724tCCWKdJ3OfmCQZu1qjg61DRL/d7Pvg0qWi2WLgkgHgo
	vu6LWomKwwh97Zep0GoWpvgcqhFz3HLKZiJ6d65jZ7KGGThj8sq/U6/zLDtJZHVBkzXrxNQxj9P
	zHTegm2pmASsCiDWiaVkj5ujtnw79ml+podwjN2f/vysLyBkxTVwbYNF5PNhy+dy+apqFLfwzIL
	s/hMH+e7SsLAzxhHoHdNkarc2Nc+OrY9TA65KmrB/9MmKTMMEaGgmJBuO/fPN+u0BN6IPCED8DG
	FO6xUXggV8bRMHOPe2X+6h4/Yh4qFKo8q7tZQS44hExj6C7RWbAa8XNYyvy4xaF5d7vPhlUDqWH
	elSmu6CPgc+bHbGMXGw/TEosi4
X-Received: by 2002:a17:90b:2fc4:b0:35f:b6d3:da7d with SMTP id 98e67ed59e1d1-361404635e6mr18770341a91.17.1776809421976;
        Tue, 21 Apr 2026 15:10:21 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:47::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fab1c32sm5688614a91.5.2026.04.21.15.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:10:21 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 3/9] bpf: Preserve reg->id of pointer objects after null-check
Date: Tue, 21 Apr 2026 15:10:10 -0700
Message-ID: <20260421221016.2967924-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421221016.2967924-1-ameryhung@gmail.com>
References: <20260421221016.2967924-1-ameryhung@gmail.com>
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

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 93003a2a96b0..0313b7d5f6c9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15886,15 +15886,10 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
 
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


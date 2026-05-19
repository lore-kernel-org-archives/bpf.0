Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E766C33F8AA
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 18:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214406; cv=none; b=g7pluw1TLHRtB2Q8kilboXKpRHAVwKweHhk/4GTdv8GBEOwattWu9BM7+Wliyb7bfzD8LyWjs9gBE7L1JiHPYP5Na9CVx5KrgkZBKSW8OHDx8Mvo4bMqtcCX7/qmyRxNfPiQW6TvOEpimpn2/kgjNu+8ARpKoHoK4STH9cluyAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214406; c=relaxed/simple;
	bh=tZ51rEhjCGhsr01pIsMpJemlhH/OJfjo4pIBZJ8qjCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUb5YUE/fttRmXpo5tlLdZGkbJ3Ork3jQT/mQesNEJcOVGo6VjDXQqm6AzSgEk9NTi+KJ/FcvEjr9nWHyRyh/v7ts/voochIasLPl3DeiDp7oWsD4t+7R2bTd5GcBIg84U3lrbfGyAKDowS8yTFFkU0b9Q7DnJ07SX/d85VwRjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvTbbsCE; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvTbbsCE"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-65c7492a2ceso3356460d50.3
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 11:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779214402; x=1779819202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5KuNnGRxNHLJT6/5Dkj0fTR1u1/jY83wU7OXw6mQ6U=;
        b=HvTbbsCEWzhJFVh1BVHXMiaLkJKofd9R26KA0bhWDdmUdP7ZpKAo2aiQBR+kYsHk2j
         aDhUMOrbiNadGm0hHC6JWZO28VmKjFHj9B6T+urtJd6AKP+ysaiCpBEMvrlkXMvB7C3u
         v+sa7HPoM0U4W6iWEm/MPC5eEMhhOK0b/xKHjyHwxORFILVC9owra6F6SizzueqAVSDn
         RtzXG3sIhJqS4QABdcPE+jOdZ2tn51JAu/u8oHL2kSqKthL8sZ2Tz0L1mKEEZz2cC5ZZ
         kVwXd7fF25K9mTZYulZPnE9brzsDyGv0k8MdXLHD8ZxCXaeA9I1u8GQxAOfQucoCnbrI
         iAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779214402; x=1779819202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H5KuNnGRxNHLJT6/5Dkj0fTR1u1/jY83wU7OXw6mQ6U=;
        b=ZYcD8LmeHuuGjNWtsibFJju4oR0eXqAzrKRLeG6rCEpD2VreB6SIgUm9XNTNdAQG3Q
         HSpLzjaTm9RrVkbiDwNhpFH+gLdBRJYCujuqZS8WBfoB8+M/sQh/HC3Grf4a5yTP8aXT
         Y30lHcjHM5PHHaUys2xme0qQX12H5uqvce+4OUynMvZ+ZL70fyusjGcwCcSQqZxCdfno
         BE6T9S4KvzbWr4kvbiq4kiUyU0Wc2jvGo6c+THABSZQcmuk0RArom44SZomDY58ielvt
         JfouUVzt1GmTQPT/5oiNrhqg6ojoYbygT8Le64HllZpd4P0CAUcSCiUc9EQaOmIwHXdd
         jSqA==
X-Gm-Message-State: AOJu0Ywmz/gVC+qxRmYrgpcMi0IC9prWCEV5/f7/BGHnRh2SsDbUogQe
	l2TC+P9bVx//19tQBCc2sXzuyR8LUlZz7vm7W2beb+cYclNxre8h2FSruUiepLBK
X-Gm-Gg: Acq92OFM1BF2p+qgHBmGeCII7bc2HwpHOPXREe0n3Mq9zStZeK9dhJI/3VpJl11zRuV
	La6F57i+13dOe45GFGcIDb+4ibTweVFG50Zgw0SmQkjTHqRr1eYC5nxc6wjaf5/Pyo6arJT+cnM
	K63KgX94YmGN+OtLewr4yvLVm774NEVzS2CCpAJ0BQ3Hn1TPInqJu3vdEXu9vEdsQM9s2TZQl82
	t7xzVGyEo5fs3NELsBD1Jor8z3CL91z0aMjO2/RXGKjh4JVNKEdR9xmMCUUBhzWN9s9do5fH0ww
	otAIO1FhxDrN6wRE3rutJoiDrFqjGgbeEotGZHvUL/B8M8txLv1uXHzEho3vjnZi04PFPlpbb8F
	K7NjzZc/4/Wj/wVuoYG5nTSIDcD/RPnIqnlZOD0pcZHgLwcIYHVnGmjdEQbgWgjpXvHGD/TmpJt
	2TkKlhiNPO6vHhmXOS
X-Received: by 2002:a05:690e:1443:b0:65d:7d86:7758 with SMTP id 956f58d0204a3-65e228796fcmr19823501d50.59.1779214401905;
        Tue, 19 May 2026 11:13:21 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:23::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d8e7585sm8236767d50.9.2026.05.19.11.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:13:21 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 04/14] bpf: Preserve reg->id of pointer objects after null-check
Date: Tue, 19 May 2026 11:13:02 -0700
Message-ID: <20260519181314.2731658-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260519181314.2731658-1-ameryhung@gmail.com>
References: <20260519181314.2731658-1-ameryhung@gmail.com>
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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 441950b43a4c..753681b0a987 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15524,15 +15524,10 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
 
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
2.53.0-Meta


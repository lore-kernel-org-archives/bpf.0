Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9688E363C4C
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 01:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019386; cv=none; b=MaU45LxbJdiGsvrSgjdofhtsJYRr6MEeMR0nedYz57iMVrPOLVH3u/dY3JQB2TCuINgczBufbDFrXNAJwX1nzmhBLK5/c9z28EEuBExiYfWhmzfCcx2aSPwWEYMYl4Z6qLNO3QainYybmIvgldbA5xIJMrxX+CJbXSKnF6qOajM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019386; c=relaxed/simple;
	bh=Ol0IcP96iZaNVq94nPErOkDY/wSaji7+/ljrUes0cIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9tWsaeBz6tTf6UJqJnpNER/g0ycHkSAVDFDQ5IPax3zuNgm9iT0v1kAEClu5bCbYYk/60sscdJxhLBxzZD+VvJfDFayWDoLmhWggBeClZNW9Rcfc6IbdkRjF/g/uaSdVD3k1T4x7K6HDl1Fu1FSq8S5aZKzN3QRKizWMpaeXCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGl28ADs; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGl28ADs"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bdeed4f717so73066625ad.0
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 18:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780019384; x=1780624184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oClv69B/E1oDBe27Jpiv2e1r+T6XlJsfNyynJB6bK84=;
        b=WGl28ADsl0YRm9yIavOfj0sj9cOPsj0hylWRoEs4NrpjwBEL6DlBC/5B990tkMWQ1r
         bA5J69Grsa37X21BRiLn8rbqN53GDEMkIXdVnlOFiLQV62hPYSexkIMBUbDliCB2fltb
         Pj9c7nmqbpRPbAAbGZB9Zfs3fMkQV9xr13phmRUnMip2u7iYSFAkSBIW927w+3Zew3G3
         LIO2OpgxbBkR6Z3H82+vzVG6gI7fus5x8i1XzUCKQ7oXZ3TETHBl63kP39/lQBpN6mTs
         Lf4Kq319KY0D8Ysj3eGS9iwt8/CeqRvnzh/uVffl2gctFbpG2LmRDK7icPRydKJQItEv
         JKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780019384; x=1780624184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oClv69B/E1oDBe27Jpiv2e1r+T6XlJsfNyynJB6bK84=;
        b=iPeoPPpa54ndYummxa6B8A99ixwbIY3jkS958hJhRRALKN1ddSnAtP9x+Jvtq53ASS
         mKx5STtdbFiFh5/tXBKzIakh/0wIXCDJtT+DQ0fZgDFuVlSAheSdfJQPTwb9McRns64Z
         PaXNCyPX/HpCZZQB0T53G+QKUbL3rukNhfjVDYeZ87JWb/R4DclqOTTck7wOo3IRagKW
         mvPol1CxuqGQ+8EmNN6S/Sl3tQSRYbx8NUcbt2DMTvtqQ3rZWG5WZkK9pAMPA8ELunpV
         /JoVHb657WafFFXMvFWbDYlGHZviY8b8TY4m5uKFzBinguEY/crk4ZeMAZwxg+48bBjn
         BvQw==
X-Gm-Message-State: AOJu0YyXXI9GaZnlTXgu90zGvl51NNc6Wi3EsAahPLO/ERR948IVjnNW
	ajlR6yZlKkm5vhDU5IOfGsn9rYCckO31A1uZq2DvrFtmerS+okt4tsTJiSW/CA==
X-Gm-Gg: Acq92OEtE2XuCDSSbSmcSPNBQ5SiClrlxe2H9gv81ylIuqv3nL9JXGoaekDOSxlDroa
	4PwcH4aQ2KPuBhD4wFsdMnAcQ79dHH6P17Aj70FeQNlelgOb9XNEXkv1oGibYtyEOPiJgjWa07U
	j3/UAhuJndmZJ1Jm2OsIPqenoMraFEZE4MyEq61oFoGUTNAfjzBWjCNnk9PLd3+uNIZ9fQFgOfY
	VT+zMxVCwJrTotze+9o7ayAWNAn1mSg4pmDCcxPMQQD/aXr3tgbHBYqp5FIa7pVaVHr00PagyOB
	wU25tToF7u9UwFzlXW04ewn0oyiw+yUB79HidbHoDSFGgQAJHiyC2GdkUI4dDoE6eX0qyp0AKg6
	4FV1a37fh7laBCumdwqHH1I10AWlHkQfbXA0YVXNCg4fv+rFZqwvNUXKmY7ArYNRCGDUaOJ3p3x
	8ugYiIuUvXRXDYO+STMQVFu2O2Sud7NpOz0mc=
X-Received: by 2002:a17:903:178e:b0:2bd:907:2cf0 with SMTP id d9443c01a7336-2bf20bd7e82mr11505955ad.32.1780019383925;
        Thu, 28 May 2026 18:49:43 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5a::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a10165sm824725ad.31.2026.05.28.18.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:49:43 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 04/13] bpf: Preserve reg->id of pointer objects after null-check
Date: Thu, 28 May 2026 18:49:27 -0700
Message-ID: <20260529014936.2811085-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260529014936.2811085-1-ameryhung@gmail.com>
References: <20260529014936.2811085-1-ameryhung@gmail.com>
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
index 552840d8d2bd..ec10f9b896d8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15570,15 +15570,10 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
 
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


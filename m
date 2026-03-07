Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0975837B03C
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 06:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772865888; cv=none; b=ksdqAsFAzrFHxfGlc7QNT6Nj82DbZi/t2MO+qKahXD/zggjUUNud3LK5WyCF7Wzh/w5apMsZWRsVtnams1L4u4TfpjbCoVmdcPGXpc1V9RnVLMvPzJ+RFrA7m+8Y3a+r7vCaIHMF1H3vC8bZkqMHDzUqg0JMZsdRKaN9P6PLmM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772865888; c=relaxed/simple;
	bh=zg54N2RacaNRzv4xPjUQtK1TvbPGS4ttunAlGHbREgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUNrQ507mEp5U2YGA7ze/yrK81aac6YFyhFafEdGxi9p96uST0vj1dhVDoI82NmGlTViyLNPwhjlZDQy2tzjT7wc8eR1s9SVt1EGUwLjEFHThtm1qtciuo8Ew+/t53LecC4+isdDN9tF3xl/5Xvr9EIPEsnKxGmHleb18zX+nlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Opp7fMVR; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Opp7fMVR"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-bde0f62464cso3721155a12.2
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 22:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772865886; x=1773470686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IveTH5JWf6wbbtWrNvYx1p+e/Ua/aGYSxO2nKBZt0ag=;
        b=Opp7fMVRMSgzvQOBIW5uplifqY7+bsg12ZFcyAU06KSExynb6/DoBDyxUI2QYq1H/9
         KMuF+zRAOT33l0dqsiENjAkIt/C9ZR0iMAAVaa4gDhMnm51eIJRN42BgsoHAGe+Qf1RK
         OoLeXjPfBmsY2ejBIk5R0knza4/3uiFZrSfLAxnK4UNwUWSp0An1ETAOUigIvoCs5DEG
         TxW8HDcyAd3yL8PZ1M0wBNez8C/LmNBX1e4hZlWr6KXYhJod279WK6w9p3svngHxgSLp
         PqPiWpg0XI5CZTAwX04BhFVxUKC0zV6+gj07qaAlaEQ4D0RELRQ3lX3etwVTH4wIWBEn
         EkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772865886; x=1773470686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IveTH5JWf6wbbtWrNvYx1p+e/Ua/aGYSxO2nKBZt0ag=;
        b=cCOrBo+PL/sEPoqN05HgwG10eli0ZNMkrGjqPyQEwHe43JiJGjezuLz7UuN9DRoyv7
         aiuXth/i8WJP59UMO8dHONYJYlQUeMuPkIjpXUv36EUmejvVZf2jsbMf2ISSg1QbsB/A
         /wNgzd/8UoNZ9YyDsxMk/X0czONkxXHG8bIrqkBnmP3IZzTkMDMT+Eu0jq5xIJ3nfeAB
         /WvAWJY9oZma7k0tJEMijddsohvHAWEQ/ouAL644WQbO0Wr1G7SCLnis3tYpepUxYnga
         XQ9O6BMGgh5cCYSa+PBQ7IgKEVpGTm+LV3fSwfTPfDdo6xFjgEujedhdeqM9hsPOv50D
         JJrg==
X-Gm-Message-State: AOJu0YxEIxmLVEwNa0KEBRusWVSI6colJMh8OcYj6IxEyMjEXwD2d580
	D+1J2JhFzdIQMdVXbYmxPhpkQoq2ds+JDPmE0JaT7yqKYoMGbbGVdDIIUdNWfg==
X-Gm-Gg: ATEYQzyTPOk2n6WlyMVcOLK057b1rUoN6PAoIlhMb0IRzD+0X+o5q95svUYbs7ElM0l
	c6Zkc/KKSHIrM0MBChiU3rXZRi7vwVfyfml5rlyVCfsQEQdZwyk9tu7hu5wLMm2xUT4tLgBvgwR
	R6uNEX6jnQ0x9lZgXO+IxEz4oM0liP6KYUS2zUsnCiMo/ROd+7zqMfLtsAf5MuPsz94rWxUP/Ij
	7gJkpD7ZxFHgDSgdr64y4xG2UpKP0NSuZ65FgbApJjGniUb5CDQZccudfn04AQeJhaY5C5ljvaa
	Azf6HU8E1iTTCkxiVbiQH3BduiGx4Ov2dawhusg4iT5zDwj56A+CPNEVc+I0ie89TZ+dY+71okp
	mSOZAiOreZq1NQ3Uu5QZYicSa2y/Q2f6I1q5iTqZf4lArj7PQuZB6/a70/QpHBtLuuJbjfqei7L
	lmOUnrHUs+NB2Fsg==
X-Received: by 2002:a17:903:ac5:b0:2ae:4a6b:68ea with SMTP id d9443c01a7336-2ae82466961mr45232935ad.43.1772865886243;
        Fri, 06 Mar 2026 22:44:46 -0800 (PST)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae840ad894sm55101425ad.80.2026.03.06.22.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 22:44:45 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v2 05/11] bpf: Preserve reg->id of pointer objects after null-check
Date: Fri,  6 Mar 2026 22:44:33 -0800
Message-ID: <20260307064439.3247440-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260307064439.3247440-1-ameryhung@gmail.com>
References: <20260307064439.3247440-1-ameryhung@gmail.com>
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

Insns (A)  Insns (B)  Insns  (DIFF)  States (A)  States (B)  States (DIFF)
---------  ---------  -------------  ----------  ----------  -------------
     7309       7814  +505 (+6.91%)         394         413   +19 (+4.82%)

Meta BPF objects with insns_diff > 0

Insns (A)  Insns (B)  Insns   (DIFF)  States (A)  States (B)  States (DIFF)
---------  ---------  --------------  ----------  ----------  -------------
       52         57     +5 (+9.62%)           5           6   +1 (+20.00%)
       52         57     +5 (+9.62%)           5           6   +1 (+20.00%)
      676        679     +3 (+0.44%)          54          54    +0 (+0.00%)
      289        292     +3 (+1.04%)          20          20    +0 (+0.00%)
       78         82     +4 (+5.13%)           8           8    +0 (+0.00%)
      252        320   +68 (+26.98%)          21          27   +6 (+28.57%)
      252        320   +68 (+26.98%)          21          27   +6 (+28.57%)
      119        126     +7 (+5.88%)           6           7   +1 (+16.67%)
     1119       1128     +9 (+0.80%)          95          96    +1 (+1.05%)
     1128       1137     +9 (+0.80%)          95          96    +1 (+1.05%)
     4380       4465    +85 (+1.94%)         114         118    +4 (+3.51%)
     3093       3170    +77 (+2.49%)          83          88    +5 (+6.02%)
    30181      31224  +1043 (+3.46%)         832         863   +31 (+3.73%)
   237608     237619    +11 (+0.00%)       11670       11671    +1 (+0.01%)
    94832      94836     +4 (+0.00%)        4787        4788    +1 (+0.02%)
   237387     237407    +20 (+0.01%)       11651       11652    +1 (+0.01%)
    94832      94836     +4 (+0.00%)        4787        4788    +1 (+0.02%)
     8103       8108     +5 (+0.06%)         459         459    +0 (+0.00%)
     8076       8079     +3 (+0.04%)         457         457    +0 (+0.00%)
     8177       8197    +20 (+0.24%)         459         460    +1 (+0.22%)
     8083       8086     +3 (+0.04%)         458         458    +0 (+0.00%)
   237608     237619    +11 (+0.00%)       11670       11671    +1 (+0.01%)
    94832      94836     +4 (+0.00%)        4787        4788    +1 (+0.02%)
   237387     237407    +20 (+0.01%)       11651       11652    +1 (+0.01%)
    94832      94836     +4 (+0.00%)        4787        4788    +1 (+0.02%)
     8103       8108     +5 (+0.06%)         459         459    +0 (+0.00%)
     8076       8079     +3 (+0.04%)         457         457    +0 (+0.00%)
     8177       8197    +20 (+0.24%)         459         460    +1 (+0.22%)
     8083       8086     +3 (+0.04%)         458         458    +0 (+0.00%)

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
index ea10dd611df2..8f9e28901bc4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17014,15 +17014,10 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
 
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
2.47.3


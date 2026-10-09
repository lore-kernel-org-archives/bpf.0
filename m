Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B49C4C1500
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542929; cv=none; b=hNMRy0c31fKCY2mN5KpcC9O15MHnTnTT9v/mLVTQ1/5y+FFXe+Tjkh8ojwMVUcX6vbxhwAUHt9ODO94DUgpZhkXKr47dw11ct2Bsn6e7K8dVc8DMmSWrIHzs04DKOkWiq9uJAzRTnACGQMEFpHFzPxmwUMQoX9HpZSDl2ENiky4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542929; c=relaxed/simple;
	bh=lASMIKQGuAXa6hMt2B8juyDwiHZ3Hk03wB51iawgp8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cn26cM5o0ZLLLAl75XEp4ME9tn1ZFska9PZAMdGbSCKYFR1Mka8pkU0UsuUU8yNUJQIL5+VvgehCkeJHzlm6ctgWEscwy8wHBRQEO7/bJP6t6sJStfw6REw2CQ9vDZiN/GxRxvmhMTXJLMLOA3Y5aOg4IRw2oi8UZuNi8RP+Rww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBhManIq; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBhManIq"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso3584719a91.1
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542911; x=1792147711; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qwhqaKVxZ2Q8ed0UZ1NYDlCyyasIiiEgBnJNZ8HUlxY=;
        b=iBhManIqM1DYpLryGCztCsXbS3caTd8pnK+IaTVxuhOiq+jCQORhZqbjCiVg0QiqJL
         Gtfmb50mLQKAoJKwm50yj0bDd4QtLDRLJwndvxnioy6q3t9e5wkLvQ0gDaJ37nuu2RU6
         20DnVc5b2kVRNQ1jtognwX5U1u/Ut7DIRIMkRPAyimyj1QfwDueu0ZkoG49GABRU3w3c
         b+cBIVTwhrqn5Q6eJDSWUxTVlM9hYF30I/H1XoLX/mLZzcfQcC5BRiT0RU22RdfPXiGF
         KWeAH+VyxIMzAtPInOf5b3itveVriDJcaiqcwH1iho+LvXBewktyhtrUHnqny9XemRhM
         Y9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542911; x=1792147711;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qwhqaKVxZ2Q8ed0UZ1NYDlCyyasIiiEgBnJNZ8HUlxY=;
        b=uda1sEiaZN0xUtY5F5ljkU0qxeu8Itq76P+E5QGKUUc9Qk6/srX5sc78Ou+wRFwOR4
         RZSG81G76qrAUP6/EPUAk/jhB/2kiUTws8LMClu6nWMq7EeoDmKiI4f+o8c/dC8POxPI
         jriEHROgrd61NccqMCVJCrHOQzl45JBUTe3xAvSffMgkAeyfd5IFbTprGWgov8OmTFy2
         fo2GHXJswwjFUJpWRfdv67UEKkSbaVbxKWJvAu9JbhhL2rR8Pwp4F95WvPM2LnmMmrkB
         85xRfoxzGdMxLpAfUoJicHc9MQB3b/SB2P8ZVCQpcMgoL4Nxf2y4EqWxq763bI4FU/h1
         Ag3Q==
X-Gm-Message-State: AFq9FYJ8itT9QJOYsgN+Rx54oDh5Bf5i7xMMi4QGzrs2Pe3m0TyD3gDf
	Aql2gw8VWzTHC8e13i6si6uem+WDHt2o4gBJQhRH3XIcpkwyb/ZMvxBGxpgJQNAx
X-Gm-Gg: AYBFou331FDG5cVIurgI+8zHce3MVPs2WSxf1BxmOGTHh7dLHOqNgiL5DxO6vqqYw5r
	ItXUewPXcY8z/6QszYkQx3B5+sDSgy0IiLE4mr0yk25Ohn6JBF+EHbB7slBBfpYG2RWLnLpRUQd
	DuhpLQBMe9Wuiz94MjrL6nbR+nsp3YQyeqp968gXwKTLHqMHjlXT3ToA6bO9AzpcrdFMLiIYk8d
	+5Q41YEc2hyD7JxG5yT1Zs10QxkkZSZ8WXoZLx/IG2T84PtKbuZyiDxxA2SS9jRp0ziJdGnE4QA
	7YkQz0rOI0hs1BFEqWT4MfU+NkZmFf/UjxwMcNA4QAxnLdhwfAmW/bXalUDvfxv3JyYk5Sb8tF8
	irazEoFHNdZCoTGpZOR3HEayTsL2kmoC7IeTqMaLpEHLmaXmwIw6XO3ZBpOp/PtrtSAbZZnzz9q
	l4R/AfzCbiWskENwILvHCZbavSKJ1JtTUZ/mJV9pfCdXA1cUN6BoGaqQdf1CvHtf3cM5Wfj9ghf
	i9CA1+RiE/0eKTT
X-Received: by 2002:a17:90a:d006:b0:3aa:fc22:8aac with SMTP id 98e67ed59e1d1-3ab3a9325f8mr1450255a91.51.1791542910784;
        Fri, 09 Oct 2026 03:48:30 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:30 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 17/51] bpf: expose bpf_verbose_snum()
Date: Fri,  9 Oct 2026 03:47:35 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-17-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

For use in SCEV logging to make large widened bounds more readable.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/log.c             | 12 ++++++------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index ab86b75888c3..b4396867c6f3 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1165,6 +1165,7 @@ int bpf_vlog_finalize(struct bpf_verifier_log *log, u32 *log_size_actual);
 __printf(3, 4) void verbose_linfo(struct bpf_verifier_env *env,
 				  u32 insn_off,
 				  const char *prefix_fmt, ...);
+void bpf_verbose_snum(struct bpf_verifier_env *env, s64 num);
 
 #define verifier_bug_if(cond, env, fmt, args...)						\
 	({											\
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index d850a7863d2e..87d137734db1 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -527,7 +527,7 @@ static void verbose_unum(struct bpf_verifier_env *env, u64 num)
 		verbose(env, "%#llx", num);
 }
 
-static void verbose_snum(struct bpf_verifier_env *env, s64 num)
+void bpf_verbose_snum(struct bpf_verifier_env *env, s64 num)
 {
 	if (is_snum_decimal(num))
 		verbose(env, "%lld", num);
@@ -609,7 +609,7 @@ static void print_scalar_ranges(struct bpf_verifier_env *env,
 		}
 
 		if (m1->name[0] == 's')
-			verbose_snum(env, m1->val);
+			bpf_verbose_snum(env, m1->val);
 		else
 			verbose_unum(env, m1->val);
 	}
@@ -632,7 +632,7 @@ static void print_reg_state(struct bpf_verifier_env *env,
 	if (t == SCALAR_VALUE && reg->precise)
 		verbose(env, "P");
 	if (t == SCALAR_VALUE && tnum_is_const(reg->var_off)) {
-		verbose_snum(env, reg->var_off.value);
+		bpf_verbose_snum(env, reg->var_off.value);
 		return;
 	}
 
@@ -643,7 +643,7 @@ static void print_reg_state(struct bpf_verifier_env *env,
 		if (state->frameno != reg->frameno)
 			verbose(env, "[%d]", reg->frameno);
 		if (tnum_is_const(reg->var_off)) {
-			verbose_snum(env, reg->var_off.value + reg->delta);
+			bpf_verbose_snum(env, reg->var_off.value + reg->delta);
 			return;
 		}
 	}
@@ -667,7 +667,7 @@ static void print_reg_state(struct bpf_verifier_env *env,
 	}
 	if (t != SCALAR_VALUE && reg->delta) {
 		verbose_a("off=");
-		verbose_snum(env, reg->delta);
+		bpf_verbose_snum(env, reg->delta);
 	}
 	if (type_is_pkt_pointer(t)) {
 		verbose_a("r=");
@@ -683,7 +683,7 @@ static void print_reg_state(struct bpf_verifier_env *env,
 		/* a pointer register with fixed offset */
 		if (reg->var_off.value) {
 			verbose_a("imm=");
-			verbose_snum(env, reg->var_off.value);
+			bpf_verbose_snum(env, reg->var_off.value);
 		}
 	} else {
 		print_scalar_ranges(env, reg, &sep);

-- 
2.53.0

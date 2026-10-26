Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057927;
	b=bLA+ctZSzsDctFnsffAMGlBG5Gb6oqfPGZn1Nm6NDizknAenjUEAyyM/RZ2UQA7OWuli
	 tej9D2eyfBrKwIoV+xJ24c0XN8V3RFVLTH8etU9QRBc2gniDJ+FK/2NC0uRkEeN8lPhQ+
	 j0p87Pw2K3pVo45ANhxYps1gC6Yo8KdfN6m156RHtGomJeQ2r2SDUYScFj5zYMo3xqV/B
	 tzaMwuRWX8+EEn4LQpvFa13JSrEHE6XpLzO/TlB53UK3jQvLQVjAKuQRfS7Sl/omUsMr9
	 /MxEX0/b/cOCoxUmSlUO8fJxqt4y6rML5sdbniNsylgxqY1iTtb3i3H+zGeN7hOrCvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=QeYuCkD+BQ4sWswiWmBK3D+JuBl+p2WiTWLZkfp9jxE=;
	b=liRPEZmSZbohBpavGN1xY2RL4qxfRihJffBTlONE3f7SBLhtqQ+1r62WuEl5BLhaFhk1
	 GdoNSzzVlo8Rup01jGvSbbAJq9T7x02XQwVVjZ8wZcqFO6QUxeKeM50HLJazlRhoKUHzt
	 Oeth7GejcC32T0+IttKoE7NNiir7tnyDugBQvbh3kDiz78m0nzMqUpXL6LQtbtmYTIiqK
	 k/lJ2YxCLYlvczygFPrOWCWWDc96lRNjHqzjdT+H+bj8XM14es/h1KerwsXRIxcupKdBV
	 KVokeTdv6xnJ8NJg1PDOAqI+IZGixgLjpUqYEAasNQ7wejHYg3jrGxVhOF/ZGNlm8SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=A8NSs9xC;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAED606A31F
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 23:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFAED606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=A8NSs9xC
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3acd21ba21aso2778692a91.1
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 16:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793057926; x=1793662726; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QeYuCkD+BQ4sWswiWmBK3D+JuBl+p2WiTWLZkfp9jxE=;
        b=A8NSs9xC5Tniksexwvk91GSeIjwlqPHHPm1sZTXoP3v8m4o3l8i3ZkD2mLPjtri3qf
         N2fQm5Z2eSZFGhimP6FTL9afm+Ss+gYp83iZh3rkdo3aLqYE6QbdbvkMtfl9Q+AQVUMx
         kjlO4SEE7jftoCjVkFdy4oNyzHcO5rSXwQYvAGBMyCALoVEiZXIKxnzm01/zE2ljU9P7
         cRTC3XaUFZeDO0FQitRQ8iNPkbfqIjrV1fx+4CdlMeZ+e1NOQXY+1Q20A5x+87W4rWSQ
         Kl+wvEfFqrouqHuTfhQofRCmI+PvuTeUXpbzyvMaUtY1IYzm3UHMQGsQPg6MDkHAtsEm
         1u3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793057926; x=1793662726;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QeYuCkD+BQ4sWswiWmBK3D+JuBl+p2WiTWLZkfp9jxE=;
        b=0RVStEIZOapBfcaun60Ndgwsk+Bb3BiUnXqCZgtDkoSrRvXlnBHBcHXDne9IHKukqy
         loYf1koAv/MCz2WdC+v9pvmdNxlc56vlJ1towTiqdxTRZ9ZWDCuAggywL4gmGhUBS7IF
         2quArT/WU1rg0hiwfQ4uwDHZqq9xfzU4hEHsJXzTTxnrhExnlohcfRsBGU7wYTI69psi
         gml8OpPQxlutlX1Afv/XyWHTq6v63TZSt8x+1NXwSHEVJIkoVCk2YArZyCIuYsSyloAr
         sMLbk/rUFIHPgJB17cFkZUVirccgE+GlA4xE/tMyQbNkDZ8G6aTGbjqKZF4jFHeO7c8C
         DP3w==
X-Gm-Message-State: AFq9FYL5QTa21/TvqP3GCkAlumngQFGrRFpddqymlFsJL2rA2o76wAfQ
	ybfJLFMjFqLj63qQrrWnn4Awn39Sdt9ghChyYMSx4jpZ30yf0eCmmh6re3K1eA==
X-Gm-Gg: AYBFou19nziHrRTNM3W0ZgY3kw3B6R7N5lj8fmABDwf0MWqgC7H2weoh/ZIG655Qkmv
	X2MgY75jJQ33OJCj4Oer1Vbr6T+7ZlE0/5tdCnQBJy8agb919ctBkWGUpEG7r13xu/+ugsWakYv
	cUY++w2YOZmzr23e3FDdqTdylot9Q6ffKujaN4UfnmUqv9HigSdJKGTYExyXQuuF0lGFbCzeDm/
	2gllyIw7TWev0tYjHZ7NUzW1hEg2QOi3B2xG4glyOR6Mcd6uRTW8CuI3jOK2QiycSs9l7FPfI5y
	+cCRfYKUU6Q21kDFpYvfIB0srIGc8JzyJtf5rQ+y+wBOcMgxUC2DL9J+k3cJvW0ARJurMAM5UHt
	HA8ZppG+r6b24jCloYWEqsvO4m2Gc7adFTe0Z6uIhfAcfIDeJfREj4BcRY+KQpqrDOg6caRjurH
	7IztC4/K0KtaJWO82dmilxm8NjEKLe489pcpfpiYZOxkvY5r0W+NDT5rhaE67wd+7gOPRSaDAz1
	8LUuw/BZbTL7qc6ffgGbn5ATWV281Ionh2PJdSRxhK3lJLrDKrNzcallluANjFXTalJz+McilKs
	LguwYTzkYfb6hCV1P/SUG3oEhv5N879iulDAIZfuqSJcCOYCrkCw/EqtbVfdiUb6MjQqAASf
X-Received: by 2002:a17:90b:2645:b0:3a0:9640:803a with SMTP id 98e67ed59e1d1-3ade9b2ef4bmr7295287a91.5.1793057926238;
        Mon, 26 Oct 2026 16:38:46 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae40455eb5sm1167437a91.12.2026.10.26.16.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 16:38:45 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf v2 06/11] bpf: print 32-bit SCEV bounds as 32-bit numbers
Date: Mon, 26 Oct 2026 16:38:26 -0700
Message-ID: <20261026-scev-simpler-clamp-v2-6-f373aec9825f@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026-scev-simpler-clamp-v2-0-f373aec9825f@gmail.com>
References: <20261026-scev-simpler-clamp-v2-0-f373aec9825f@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

- Print large 32-bit bounds without sign extension.
- Omit 32-bit bounds when they coincide with 64-bit bounds.

Before:
  loop header at ..., widening r0 to 0x80000000..0xffffffff (s32 0xffffffff80000000..-1) step 1
  loop header at ..., widening r0 to 0..3 (s32 0..3) step 1

After:
  loop header at ..., widening r0 to 0x80000000..0xffffffff (s32 0x80000000..-1) step 1
  loop header at ..., widening r0 to 0..3 step 1

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h                      | 1 +
 kernel/bpf/log.c                                  | 8 ++++++++
 kernel/bpf/scev.c                                 | 8 +++++---
 tools/testing/selftests/bpf/progs/verifier_scev.c | 2 +-
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 5926f13ff43c..e51984cb3035 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1280,6 +1280,7 @@ __printf(3, 4) void verbose_linfo(struct bpf_verifier_env *env,
 				  u32 insn_off,
 				  const char *prefix_fmt, ...);
 void bpf_verbose_snum(struct bpf_verifier_env *env, s64 num);
+void bpf_verbose_snum32(struct bpf_verifier_env *env, s32 num);
 
 #define verifier_bug_if(cond, env, fmt, args...)						\
 	({											\
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 5432c0fc442b..fa29d9b994e4 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -535,6 +535,14 @@ void bpf_verbose_snum(struct bpf_verifier_env *env, s64 num)
 		verbose(env, "%#llx", num);
 }
 
+void bpf_verbose_snum32(struct bpf_verifier_env *env, s32 num)
+{
+	if (is_snum_decimal(num))
+		verbose(env, "%d", num);
+	else
+		verbose(env, "%#x", (u32)num);
+}
+
 int tnum_strn(char *str, size_t size, struct tnum a)
 {
 	/* print as a constant, if tnum is fully known */
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 12b147faa32a..04d4962448e2 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -2456,11 +2456,13 @@ static void log_bounds(struct bpf_verifier_env *env, const struct bounds *bounds
 	bpf_verbose_snum(env, cnum64_smin(bounds->r64));
 	bpf_log(log, "..");
 	bpf_verbose_snum(env, cnum64_smax(bounds->r64));
-	if (bounds->r32.size < U32_MAX) {
+	if (bounds->r32.size < U32_MAX &&
+	    (cnum32_smin(bounds->r32) != cnum64_smin(bounds->r64) ||
+	     cnum32_smax(bounds->r32) != cnum64_smax(bounds->r64))) {
 		bpf_log(log, " (s32 ");
-		bpf_verbose_snum(env, cnum32_smin(bounds->r32));
+		bpf_verbose_snum32(env, cnum32_smin(bounds->r32));
 		bpf_log(log, "..");
-		bpf_verbose_snum(env, cnum32_smax(bounds->r32));
+		bpf_verbose_snum32(env, cnum32_smax(bounds->r32));
 		bpf_log(log, ")");
 	}
 	bpf_log(log, " step %u", bounds->step);
diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 9074b2f043d4..2103c58cfaad 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -1771,7 +1771,7 @@ __success
 __log_level(2)
 __flag(BPF_F_TEST_STATE_FREQ)
 __msg("loop header at 1, header_count is 4")
-__msg("loop header at 1, widening r0 to 0..3 (s32 0..3) step 1")
+__msg("loop header at 1, widening r0 to 0..3 step 1")
 __msg("loop header at 1, clamping r0")
 __msg("4: R0=3")
 __naked void pre_cond_je32(void)

-- 
2.56.0

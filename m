Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792800250;
	b=lg9Qg9ToU3XIukf9rZJL4r7mdtEvpYSC7nq1461rbU4eGeafHU5NmJBfRIFbcuZVvcZF
	 lqXBcMK0aeOchmh0Be6pBvtzoE0W0jb874sh+Xx1nhr4yc7/1IeGi6J5J0GRSzHcda7BI
	 PqSzAcxynpakuI7G3cB2/eaytb98R6SKYYBo37x+tLsIQnPuUOEqDfOAuWoyRoPiK806l
	 weeSiS+4L4VZXgVijK3OOtu+dfaV0VHBOD+670a8+ha2kg4lJ5kmM+TPDExpAs18c/ELV
	 WGarf48NNk9ypFzEKY4sW9qID6/vk6DzUxG3SXMuFS5IuX74idqUa6xIHEAsdpPwMrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792800250;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=dh4RV6KjLiyutepNxuHw1bsZCM35vr2Eq32a79rgIrg=;
	b=RP8zeKpTPsyFOhHeeMtdZh8fnBOkk8MU1kGCvg9QBxVyekORrDfQnAMr+jEhLG5NFNLy
	 0R5bNiktV2Pq5H7Yy2Q5izfSHgZB3E+yD+oIO3frqLseVTN7nqyxVOyAjuIFgwlzkl5FS
	 BYz6/1+w36hK45EF8MkzTRO2nv6Zwp7Jj67qkez2na9CXSrCyk/Na8wgnHe5vLs3WO+V7
	 64B3iK6MnRISz4Yd5ti1QVdidKD+8hsOxzHhhkWptSiSjt7gecUVflbxWu/fhhufPYRbR
	 VUQJA4eMR+tMAl+PKLHXgNsorpSLFhHoVYSYjweT75m6H6v9QP26B6O1MLCXkEY762w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="PCH/P+m0";
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D390606A322
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 00:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D390606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PCH/P+m0
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ea1e7fad99so7005525ad.1
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 17:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792800249; x=1793405049; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dh4RV6KjLiyutepNxuHw1bsZCM35vr2Eq32a79rgIrg=;
        b=PCH/P+m0uoKoApbjAC/tCrf5ooiuAp+TruwbDRQt66sxzZAbldoxoN+N7an4n7l7AR
         PtJ5sHm0t9xbzmp4nXz9Hj0Xnwcq03MdkK8an4A/5nMvw19Ui+US5qPgn3HQem64SQb8
         tE72QrBxnZ/PfX/H/KQkOIlnKOkeOlyktKM+xlEiS9B0lryVyk7z2ORStmkOtQHHbnHi
         +2n3XCBT1xks13aXuFpokr/8NA4CQ+7q65sEO2dKAbLzTk6No85IY2+VrnnQ+qKQRTO6
         UG6a9S46kNu91WKFsaB7a/5McqRxhQvRMAtFPNUGJCuEKDRZXfaIhUKXkcel4c+5la+/
         FOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792800249; x=1793405049;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dh4RV6KjLiyutepNxuHw1bsZCM35vr2Eq32a79rgIrg=;
        b=ShROh+tVPlEquItadf4rLOXD/eX16wEmYq429QpKpsHtlKTgv27+TdXLG3RYtjZYNh
         tCPiWm2hpeJXVs4E4hAQYnUr72rvIoo48jhBgUCr3sz5o7ZtENhNeOfr/6CHOSA4PL07
         reLEDPG4/DPp5tPectfZAafKjokyzrbfep6FpJIEAV5i8PHohDc4a6P7uEl1Ei8NmqQN
         e7JNN1QkusSE4E6XdofJDmizme+cDBede9PMnbsqqarfLsShkLqcsrLR9W9uZ9zl3S7O
         41nO1cGvE9HkNIW5nALWOKObXBEJjoHnL4mHENv+/SftccVjhdgInS+xtLqjF11NVtS8
         Z+QA==
X-Gm-Message-State: AFq9FYI7W0vX1GkNi623FasUYf7PL2AHOZQOL8rdBAkcdWyRV/hS818j
	lJhW7IeRmWZL/PpJ9IJy+NBGDkm12Ptn4Kk17JImyan7BQoh/pP1K+r2E+j5zHzP
X-Gm-Gg: AYBFou1Unnryon83ln4c8IDiiVzD0Ul7frsdDPLNEaYOp25RxykUJFfFCCW6/eso5GR
	hhIO+i5M8eEh/vpP53+aPjYd6EvOuWS9aaTM/v2FgqAk2W4DijJFG26BdWXGz5GvI6BPiDEm9E7
	DIIn0bwp+8RHP9mtPslgZivDeP3dR5E7spsjjCYilfhbT0WNaMNHC7gd/HzEKOqJ5gUS/WBbS40
	ybNGvq4FLJ63CdGwfKt99ZuUdJOAYKvekKNL+OEg6RSGpvHPpSnEM9x5AdMHBR20AITplCdhw7t
	CpBpoykC9iCNQ1Xzh6Rp9mkqmBaMAngxvp0b+VfBeN16+Ml4qrppBI3yhLvwk38blJHNZhEIjuW
	Hbi8lVr2H7F7nlAb4GyqtVwY7HrruTxgzIrPria4lATDVmNz7HAMjxYOkilA/nhLTZOHvZgPkOw
	vOyr7H72a2Jq0oGYO67tw5OlNXePsi9RCqy4fJAazIpIT8ZcQc7hT3qbaGONbI26vuphY7jJ/CB
	+Gs1hg8sVMSJ6DT+tIqM3Iqx0gShLHX7C3zUlnYvysVvziNBhXwZ8ENikZGOXOI/zBf8Ty3
X-Received: by 2002:a17:90b:224b:b0:3ac:d19e:85f1 with SMTP id 98e67ed59e1d1-3adeafd6bc7mr582047a91.53.1792800249247;
        Fri, 23 Oct 2026 17:04:09 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba31797sm547433a91.1.2026.10.23.17.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:04:08 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 06/11] bpf: print 32-bit SCEV bounds as 32-bit numbers
Date: Fri, 23 Oct 2026 17:03:48 -0700
Message-ID: <20261023-scev-simpler-clamp-v1-6-d43a07eda7af@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023-scev-simpler-clamp-v1-0-d43a07eda7af@gmail.com>
References: <20261023-scev-simpler-clamp-v1-0-d43a07eda7af@gmail.com>
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

bpf: Simplify printing of SCEV bounds

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
index 14594ba5dbfd..96c98443f346 100644
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
2.53.0

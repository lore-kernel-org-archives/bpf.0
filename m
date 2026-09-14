Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7981249E5FA
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 22:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789424735; cv=none; b=uwCElyuBo1OLD7qFV8orWiFk3C+sEN8RVYjXfLGChiPOg6BhZryI6Z81kRcRKjKYlzcUv1pSrWoUJ2oRHute9Gs3EgM4B36gA4k63cmkjYc4ESEPnaBTpMQnB+PZU2oCMarWfJRTM8ARLlRZKHwsvuKienueE1RNhMJHfF4mqGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789424735; c=relaxed/simple;
	bh=ON8kmQxsKDjdmdwKNRKbeg6/CdQ9248WUMgaeYV6rGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1V3fONJ84zQ52NQ+hjkV8smOL7i2AEZG8s1VDsA4Jk8l9GHXZ/YL1IFf+WfrV7mgP63aQ5TWHZ2UYTw9446z1LsTSSyjb1f5s4ELEV2G77P132qn10F6e+MVNAhfBgmBxO4hQWgm1gmgK9ygqj4h6p+gtgjtmt3ziLXsfm7MGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuvnLYtL; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuvnLYtL"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-48351e5bb47so1370867f8f.1
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 15:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789424732; x=1790029532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0UDqQzkvK35NE6lfaw+f0huGjYCltneaoffbEFSky1I=;
        b=HuvnLYtLFVkkkfiIRIUbAG5aZ8lRFgQsLzsPtQ6EKrNT2crQWLqAYdl5089xcF2oyf
         LOQxHDT3VzbRC5KhHWh6b6jt6DFMb8JIyr1ZWJQ5Hamb2+1etzUXedpchg/R66/t7s/6
         jKxlcAkP2KTPdpusc9XAcfgGRLusKZCN5NSGUBBZUdSeIAKWRkzA+v5Xab4phS82pibI
         hQfpBRrN+b1k1SRuoWI2fciSSZ3tX8FXDI4Rc93S4EVAQ3Dx76JUFx8j8WhMBgka0hCd
         DOqhqnCtHNsbgvEynQsI4ZYyonv0Y8i5FQiT6txuqwOkyZwJsPDtuwxAU1cypJU7pUzY
         CSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789424732; x=1790029532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0UDqQzkvK35NE6lfaw+f0huGjYCltneaoffbEFSky1I=;
        b=vi9I58Qq9FlBgKyHaT0nFWHij0drtH46qx9Usz40nAlLqB86029q/OE7dKQRycv7rw
         LZccr17AwrkDn13QxbELxYeD/6DEXpc4sTHTrPa87vBOFn9u4zDwRfoLONCPPVPFpkGz
         z4kDvB1wl1TH1XYnsNVhZMaxA7wPc3nvL1nIMNxJvE5zyTu3fT1BM3+SWgydpmyu9een
         83MdDTls8/jf8QvDR/aubP10gEVlFgqCPfJ6XNRKZdqUYQJJzXfuH1S8MstLDwUuv9fo
         aXsECzboe7LVHGRLBqaiEfOQmAhTottW87YfU4IaSLnk5GVkr8lKq7vLwUR7wGUaCsOH
         KMEw==
X-Gm-Message-State: AFuF++kApUc+1YnkcUyiDeogRq1bm0HQw3BZxwzoWUWUjQ3584qw6jlW
	u6oc1oxjWH1IHkx0nTvYHocpKdwB6m4EyiC3MnqVzBHJqRsv/SZZg1YzBi0DuZjO870=
X-Gm-Gg: AYBFou2Rf6ERwI/B+RzoXMOexDI7R8NzAlPymBxxErPIRP6ScdFNjJ3PyQtjY2es6vC
	J/S6UQai1vgxSYgMKkdmG12mTh1nLkLgVNkOMp1vHtJQagDuhOIJtgiD7WivRz2puKUnCx9tqhv
	P2us9LOgyKCkYFufDLckoKKalClGWdiqnNZeSym7GC94H7cR+b+ADy8C6RVJQjWzd7ro4MnX85p
	qYGmXVS2KxAQa/WRliLhFSRNGEKV503aKvddCo8MazJCxmIdYKUHDDrn/XEGGpIAMjQ195qTdM2
	nXJtepCgcsY80O+H55y7YUUV3F/NlymVIWF3glcKHHJSqwsnORm3e3HNw3QNCid5bV87zfe9TBW
	wJcI8+HrV4EYg73sfDHD7dBFLJtWuiBDNb6i2Fbsu7v6oV1FpRs4WVxEqSCbRYg+rr8Uc1ZPLoC
	wk2dGXgNngn19QgsinqltdcRma1ouu1ob15TkepR/8d/8ZrDcp58ecTsjxhEIUmGzSd4oK/Cch/
	q0bvFNuwnQh2ipzRESiGmmUjruBhdrcg+gD5wXwjGx9Aj24KAwIoLAdtB/1ylg7wI+kyo1BTqLF
	+O++8HSr9McDDK/CsPlQXXop1CkPdT5Eempilw==
X-Received: by 2002:a05:6000:983:b0:486:f46c:682a with SMTP id ffacd0b85a97d-48702a23253mr10684825f8f.0.1789424731609;
        Mon, 14 Sep 2026 15:25:31 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33ee5csm29856922f8f.20.2026.09.14.15.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 15:25:31 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Sashiko <sashiko-bot@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v4 10/11] libbpf: Reject truncated ldimm64 CO-RE relocations
Date: Tue, 15 Sep 2026 00:25:07 +0200
Message-ID: <20260914222514.1635018-11-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914222514.1635018-1-memxor@gmail.com>
References: <20260914222514.1635018-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5808; i=memxor@gmail.com; h=from:subject; bh=ON8kmQxsKDjdmdwKNRKbeg6/CdQ9248WUMgaeYV6rGk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtFicG+i8/3/xNOC+Rs2vdrkk/AFRFWt7oZiaxfX84Tb Rfjf+PbUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgImYJTD8T7/pa6liK31fy+q7 bvGXWbOdL9gz+0WWqXwVy99UvS64hJHh80yf3CVVj9Pu/908q9TI4B5HjKd18BQFn0K91A1SUz4 yAQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

CO-RE relocation of an ldimm64 instruction operates on two instruction
slots. The original ldimm64 support checked that the second slot existed
only on the resolved relocation path, leaving unresolved relocation
poisoning able to write past the instruction allocation. When CO-RE logic
was moved to the shared relocation implementation, even the resolved-path
check was lost because bpf_core_patch_insn() no longer received the
program length.

A malformed BPF ELF can therefore end a function after the first ldimm64
slot and attach a CO-RE relocation to it. libbpf allocates the instruction
array according to the function symbol size. bpf_core_patch_insn() then
reads the absent second slot while validating a resolved relocation or
writes a poison instruction past the allocation for an unresolved one.

Pass the total instruction count to the shared patch helper and reject a
terminal ldimm64 before either relocation result is handled. Thread the
count through the in-kernel caller as well, since it compiles the same
shared relocation implementation.

Fixes: eacaaed784e2 ("libbpf: Implement enum value-based CO-RE relocations")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/20260914140852.03DA21F0089B@smtp.kernel.org
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h       |  2 +-
 kernel/bpf/btf.c          |  6 +++---
 kernel/bpf/check_btf.c    |  2 +-
 tools/lib/bpf/libbpf.c    |  3 ++-
 tools/lib/bpf/relo_core.c | 11 +++++++++--
 tools/lib/bpf/relo_core.h |  5 +++--
 6 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e57af902560c..62155d87ce31 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3196,7 +3196,7 @@ bool btf_type_ids_nocast_alias(struct bpf_verifier_log *log,
 			       const struct btf *arg_btf, u32 arg_id);
 
 int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
-		   int relo_idx, void *insn);
+		   int relo_idx, void *insn, size_t insn_cnt);
 
 static inline bool unprivileged_ebpf_enabled(void)
 {
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index d67a169ba2bb..78cd9661cdbd 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -9729,7 +9729,7 @@ bpf_core_find_cands(struct bpf_core_ctx *ctx, u32 local_type_id)
 }
 
 int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
-		   int relo_idx, void *insn)
+		   int relo_idx, void *insn, size_t insn_cnt)
 {
 	bool need_cands = relo->kind != BPF_CORE_TYPE_ID_LOCAL;
 	struct bpf_core_cand_list cands = {};
@@ -9793,8 +9793,8 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
 	if (err)
 		goto out;
 
-	err = bpf_core_patch_insn((void *)ctx->log, insn, relo->insn_off / 8, relo, relo_idx,
-				  &targ_res);
+	err = bpf_core_patch_insn((void *)ctx->log, insn, insn_cnt, relo->insn_off / 8,
+				  relo, relo_idx, &targ_res);
 
 out:
 	kfree(specs);
diff --git a/kernel/bpf/check_btf.c b/kernel/bpf/check_btf.c
index 4c1ed842f661..63d0375f5bb0 100644
--- a/kernel/bpf/check_btf.c
+++ b/kernel/bpf/check_btf.c
@@ -399,7 +399,7 @@ int bpf_check_core_relo(struct bpf_verifier_env *env,
 		}
 
 		err = bpf_core_apply(&ctx, &core_relo, i,
-				     &prog->insnsi[core_relo.insn_off / 8]);
+				     &prog->insnsi[core_relo.insn_off / 8], prog->len);
 		if (err)
 			break;
 		bpfptr_add(&u_core_relo, rec_size);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b749c01742ee..619e664f0c00 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6223,7 +6223,8 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 				goto out;
 			}
 
-			err = bpf_core_patch_insn(prog->name, insn, insn_idx, rec, i, &targ_res);
+			err = bpf_core_patch_insn(prog->name, insn, prog->insns_cnt, insn_idx,
+						  rec, i, &targ_res);
 			if (err) {
 				pr_warn("prog '%s': relo #%d: failed to patch insn #%d: %s\n",
 					prog->name, i, insn_idx, errstr(err));
diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index 2672623a4198..92ff923f0d13 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -1046,12 +1046,19 @@ static int insn_bytes_to_bpf_size(__u32 sz)
  * 6. *(T *)(rX + <off>) = <imm>, where T is one of {u8, u16, u32, u64}.
  */
 int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
-			int insn_idx, const struct bpf_core_relo *relo,
-			int relo_idx, const struct bpf_core_relo_res *res)
+			size_t insn_cnt, int insn_idx,
+			const struct bpf_core_relo *relo, int relo_idx,
+			const struct bpf_core_relo_res *res)
 {
 	__u64 orig_val, new_val;
 	__u8 class;
 
+	if (is_ldimm64_insn(insn) && (size_t)insn_idx + 1 >= insn_cnt) {
+		pr_warn("prog '%s': relo #%d: insn #%d (LDIMM64) is truncated\n",
+			prog_name, relo_idx, insn_idx);
+		return -EINVAL;
+	}
+
 	class = BPF_CLASS(insn->code);
 
 	orig_val = res->orig_val;
diff --git a/tools/lib/bpf/relo_core.h b/tools/lib/bpf/relo_core.h
index 1c0566daf8e8..db2e106dc73d 100644
--- a/tools/lib/bpf/relo_core.h
+++ b/tools/lib/bpf/relo_core.h
@@ -87,8 +87,9 @@ int bpf_core_calc_relo_insn(const char *prog_name,
 			    struct bpf_core_relo_res *targ_res);
 
 int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
-			int insn_idx, const struct bpf_core_relo *relo,
-			int relo_idx, const struct bpf_core_relo_res *res);
+			size_t insn_cnt, int insn_idx,
+			const struct bpf_core_relo *relo, int relo_idx,
+			const struct bpf_core_relo_res *res);
 
 int bpf_core_parse_spec(const char *prog_name, const struct btf *btf,
 		        const struct bpf_core_relo *relo,
-- 
2.53.0


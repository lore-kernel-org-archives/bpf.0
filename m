Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F677396B67;
	Mon,  2 Mar 2026 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772445718; cv=none; b=jjpMCNdt/lBs1vIWsS0RoYtSuwQiN/LZ+uLFyE/faApqYLWNDVKJKawaZgFKa2Q6o/1enjEpBy7RB3l5vHZWPAqjHuQdJ7HUPGhIXgQw/G0SyYAigcf7EcLF35h7hYrtWspaBpLnCXS1C+DlRQvRazGtXbqydclBNKJX/XCHuhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772445718; c=relaxed/simple;
	bh=0cYt/HqtpfoGaJjWJFXJXLXhtlMpFnB+n1R2Iu7QNHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgNisWxBwn2GdT3VTHAsTfFaAouiXvaS3KiZM8jV8/gSqENxHe6XSnjeCSYT80o6eComBQ249mEUJhiW2hvhLXjm3kelkXB5ibIKueduGikKhlgX/b/UrM/zC8xfERV4ug3p97tnBv4GLCCxvS+F1sWLv8SUwuBIAF6uYug6W8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fPZFn3hjJzYQv92;
	Mon,  2 Mar 2026 18:01:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7ABBB40577;
	Mon,  2 Mar 2026 18:01:49 +0800 (CST)
Received: from k01.k01 (unknown [10.67.174.197])
	by APP4 (Coremail) with SMTP id gCh0CgCXQvMKYKVpfu0vJQ--.22492S4;
	Mon, 02 Mar 2026 18:01:49 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next v5 2/5] bpf: Pass bpf_verifier_env to jit
Date: Mon,  2 Mar 2026 18:27:23 +0800
Message-ID: <20260302102726.1126019-3-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260302102726.1126019-1-xukuohai@huaweicloud.com>
References: <20260302102726.1126019-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXQvMKYKVpfu0vJQ--.22492S4
X-Coremail-Antispam: 1UD129KBjvAXoW3Zr43Ar45tryfGw1ktF4fXwb_yoW8AFyfZo
	W3tFn0yF48t3ykG3y7trn7GF1UZw17G397uF4fWa95W3yIq34jkrZrXrsrKa4SqF4rGrWD
	uFy8Gw45AFZ8KFZ8n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOs7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	yl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14
	v26r1q6r43MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
	8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
	CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
	daVFxhVjvjDU0xZFpf9x07j5gAwUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Pass bpf_verifier_env to bpf_int_jit_compile() and bpf_jit_blind_constants().
The follow-up patch will use env->insn_aux_data in the JIT stage to detect
indirect jump targets.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 arch/arc/net/bpf_jit_core.c      | 19 ++++++++++---------
 arch/arm/net/bpf_jit_32.c        |  4 ++--
 arch/arm64/net/bpf_jit_comp.c    |  4 ++--
 arch/loongarch/net/bpf_jit.c     |  4 ++--
 arch/mips/net/bpf_jit_comp.c     |  4 ++--
 arch/parisc/net/bpf_jit_core.c   |  4 ++--
 arch/powerpc/net/bpf_jit_comp.c  |  4 ++--
 arch/riscv/net/bpf_jit_core.c    |  4 ++--
 arch/s390/net/bpf_jit_comp.c     |  4 ++--
 arch/sparc/net/bpf_jit_comp_64.c |  4 ++--
 arch/x86/net/bpf_jit_comp.c      |  4 ++--
 arch/x86/net/bpf_jit_comp32.c    |  4 ++--
 include/linux/filter.h           |  6 +++---
 kernel/bpf/core.c                | 10 +++++-----
 kernel/bpf/verifier.c            |  6 +++---
 15 files changed, 43 insertions(+), 42 deletions(-)

diff --git a/arch/arc/net/bpf_jit_core.c b/arch/arc/net/bpf_jit_core.c
index 1421eeced0f5..076aaf52cb80 100644
--- a/arch/arc/net/bpf_jit_core.c
+++ b/arch/arc/net/bpf_jit_core.c
@@ -157,14 +157,15 @@ static void jit_dump(const struct jit_context *ctx)
 }
 
 /* Initialise the context so there's no garbage. */
-static int jit_ctx_init(struct jit_context *ctx, struct bpf_prog *prog)
+static int jit_ctx_init(struct jit_context *ctx, struct bpf_verifier_env *env,
+			struct bpf_prog *prog)
 {
 	memset(ctx, 0, sizeof(*ctx));
 
 	ctx->orig_prog = prog;
 
 	/* If constant blinding was requested but failed, scram. */
-	ctx->prog = bpf_jit_blind_constants(prog);
+	ctx->prog = bpf_jit_blind_constants(env, prog);
 	if (IS_ERR(ctx->prog))
 		return PTR_ERR(ctx->prog);
 	ctx->blinded = (ctx->prog != ctx->orig_prog);
@@ -1335,7 +1336,7 @@ static int jit_patch_relocations(struct jit_context *ctx)
  * to get the necessary data for the real compilation phase,
  * jit_compile().
  */
-static struct bpf_prog *do_normal_pass(struct bpf_prog *prog)
+static struct bpf_prog *do_normal_pass(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 	struct jit_context ctx;
 
@@ -1343,7 +1344,7 @@ static struct bpf_prog *do_normal_pass(struct bpf_prog *prog)
 	if (!prog->jit_requested)
 		return prog;
 
-	if (jit_ctx_init(&ctx, prog)) {
+	if (jit_ctx_init(&ctx, env, prog)) {
 		jit_ctx_cleanup(&ctx);
 		return prog;
 	}
@@ -1374,7 +1375,7 @@ static struct bpf_prog *do_normal_pass(struct bpf_prog *prog)
  * again to get the newly translated addresses in order to resolve
  * the "call"s.
  */
-static struct bpf_prog *do_extra_pass(struct bpf_prog *prog)
+static struct bpf_prog *do_extra_pass(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 	struct jit_context ctx;
 
@@ -1382,7 +1383,7 @@ static struct bpf_prog *do_extra_pass(struct bpf_prog *prog)
 	if (check_jit_context(prog))
 		return prog;
 
-	if (jit_ctx_init(&ctx, prog)) {
+	if (jit_ctx_init(&ctx, env, prog)) {
 		jit_ctx_cleanup(&ctx);
 		return prog;
 	}
@@ -1411,15 +1412,15 @@ static struct bpf_prog *do_extra_pass(struct bpf_prog *prog)
  * (re)locations involved that their addresses are not known
  * during the first run.
  */
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 	vm_dump(prog);
 
 	/* Was this program already translated? */
 	if (!prog->jited)
-		return do_normal_pass(prog);
+		return do_normal_pass(env, prog);
 	else
-		return do_extra_pass(prog);
+		return do_extra_pass(env, prog);
 
 	return prog;
 }
diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index deeb8f292454..9c07cbf1dbfc 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -2142,7 +2142,7 @@ bool bpf_jit_needs_zext(void)
 	return true;
 }
 
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 	struct bpf_prog *tmp, *orig_prog = prog;
 	struct bpf_binary_header *header;
@@ -2162,7 +2162,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	 * then we must fall back to the interpreter. Otherwise, we save
 	 * the new JITed code.
 	 */
-	tmp = bpf_jit_blind_constants(prog);
+	tmp = bpf_jit_blind_constants(env, prog);
 
 	if (IS_ERR(tmp))
 		return orig_prog;
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index adf84962d579..823246c7ff5d 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2006,7 +2006,7 @@ struct arm64_jit_data {
 	struct jit_ctx ctx;
 };
 
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 	int image_size, prog_size, extable_size, extable_align, extable_offset;
 	struct bpf_prog *tmp, *orig_prog = prog;
@@ -2027,7 +2027,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	if (!prog->jit_requested)
 		return orig_prog;
 
-	tmp = bpf_jit_blind_constants(prog);
+	tmp = bpf_jit_blind_constants(env, prog);
 	/* If blinding was requested and we failed during blinding,
 	 * we must fall back to the interpreter.
 	 */
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 3bd89f55960d..b578b176ef01 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1909,7 +1909,7 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 	return ret < 0 ? ret : ret * LOONGARCH_INSN_SIZE;
 }
 
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 	bool tmp_blinded = false, extra_pass = false;
 	u8 *image_ptr, *ro_image_ptr;
@@ -1927,7 +1927,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	if (!prog->jit_requested)
 		return orig_prog;
 
-	tmp = bpf_jit_blind_constants(prog);
+	tmp = bpf_jit_blind_constants(env, prog);
 	/*
 	 * If blinding was requested and we failed during blinding,
 	 * we must fall back to the interpreter. Otherwise, we save
diff --git a/arch/mips/net/bpf_jit_comp.c b/arch/mips/net/bpf_jit_comp.c
index e355dfca4400..faf0ba098a86 100644
--- a/arch/mips/net/bpf_jit_comp.c
+++ b/arch/mips/net/bpf_jit_comp.c
@@ -909,7 +909,7 @@ bool bpf_jit_needs_zext(void)
 	return true;
 }
 
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 	struct bpf_prog *tmp, *orig_prog = prog;
 	struct bpf_binary_header *header = NULL;
@@ -931,7 +931,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	 * then we must fall back to the interpreter. Otherwise, we save
 	 * the new JITed code.
 	 */
-	tmp = bpf_jit_blind_constants(prog);
+	tmp = bpf_jit_blind_constants(env, prog);
 	if (IS_ERR(tmp))
 		return orig_prog;
 	if (tmp != prog) {
diff --git a/arch/parisc/net/bpf_jit_core.c b/arch/parisc/net/bpf_jit_core.c
index a5eb6b51e27a..e85b6e336b19 100644
--- a/arch/parisc/net/bpf_jit_core.c
+++ b/arch/parisc/net/bpf_jit_core.c
@@ -41,7 +41,7 @@ bool bpf_jit_needs_zext(void)
 	return true;
 }
 
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 	unsigned int prog_size = 0, extable_size = 0;
 	bool tmp_blinded = false, extra_pass = false;
@@ -53,7 +53,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	if (!prog->jit_requested)
 		return orig_prog;
 
-	tmp = bpf_jit_blind_constants(prog);
+	tmp = bpf_jit_blind_constants(env, prog);
 	if (IS_ERR(tmp))
 		return orig_prog;
 	if (tmp != prog) {
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 52162e4a7f84..fb77e8beb161 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -129,7 +129,7 @@ bool bpf_jit_needs_zext(void)
 	return true;
 }
 
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *fp)
 {
 	u32 proglen;
 	u32 alloclen;
@@ -154,7 +154,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	if (!fp->jit_requested)
 		return org_fp;
 
-	tmp_fp = bpf_jit_blind_constants(org_fp);
+	tmp_fp = bpf_jit_blind_constants(env, org_fp);
 	if (IS_ERR(tmp_fp))
 		return org_fp;
 
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index b3581e926436..ce157319459f 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -41,7 +41,7 @@ bool bpf_jit_needs_zext(void)
 	return true;
 }
 
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 	unsigned int prog_size = 0, extable_size = 0;
 	bool tmp_blinded = false, extra_pass = false;
@@ -53,7 +53,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	if (!prog->jit_requested)
 		return orig_prog;
 
-	tmp = bpf_jit_blind_constants(prog);
+	tmp = bpf_jit_blind_constants(env, prog);
 	if (IS_ERR(tmp))
 		return orig_prog;
 	if (tmp != prog) {
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 211226748662..84aabfc8a9d6 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2303,7 +2303,7 @@ static struct bpf_binary_header *bpf_jit_alloc(struct bpf_jit *jit,
 /*
  * Compile eBPF program "fp"
  */
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *fp)
 {
 	struct bpf_prog *tmp, *orig_fp = fp;
 	struct bpf_binary_header *header;
@@ -2316,7 +2316,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	if (!fp->jit_requested)
 		return orig_fp;
 
-	tmp = bpf_jit_blind_constants(fp);
+	tmp = bpf_jit_blind_constants(env, fp);
 	/*
 	 * If blinding was requested and we failed during blinding,
 	 * we must fall back to the interpreter.
diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_comp_64.c
index b23d1c645ae5..55da61ca2967 100644
--- a/arch/sparc/net/bpf_jit_comp_64.c
+++ b/arch/sparc/net/bpf_jit_comp_64.c
@@ -1477,7 +1477,7 @@ struct sparc64_jit_data {
 	struct jit_ctx ctx;
 };
 
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 	struct bpf_prog *tmp, *orig_prog = prog;
 	struct sparc64_jit_data *jit_data;
@@ -1492,7 +1492,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	if (!prog->jit_requested)
 		return orig_prog;
 
-	tmp = bpf_jit_blind_constants(prog);
+	tmp = bpf_jit_blind_constants(env, prog);
 	/* If blinding was requested and we failed during blinding,
 	 * we must fall back to the interpreter.
 	 */
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 8f10080e6fe3..43beacaed56d 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3722,7 +3722,7 @@ struct x64_jit_data {
 #define MAX_PASSES 20
 #define PADDING_PASSES (MAX_PASSES - 5)
 
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 	struct bpf_binary_header *rw_header = NULL;
 	struct bpf_binary_header *header = NULL;
@@ -3744,7 +3744,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	if (!prog->jit_requested)
 		return orig_prog;
 
-	tmp = bpf_jit_blind_constants(prog);
+	tmp = bpf_jit_blind_constants(env, prog);
 	/*
 	 * If blinding was requested and we failed during blinding,
 	 * we must fall back to the interpreter.
diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index dda423025c3d..957f7aa951ba 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -2518,7 +2518,7 @@ bool bpf_jit_needs_zext(void)
 	return true;
 }
 
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 	struct bpf_binary_header *header = NULL;
 	struct bpf_prog *tmp, *orig_prog = prog;
@@ -2533,7 +2533,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	if (!prog->jit_requested)
 		return orig_prog;
 
-	tmp = bpf_jit_blind_constants(prog);
+	tmp = bpf_jit_blind_constants(env, prog);
 	/*
 	 * If blinding was requested and we failed during blinding,
 	 * we must fall back to the interpreter.
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 632c03e126d9..8b5e9ac9eee4 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1108,7 +1108,7 @@ static inline int sk_filter_reason(struct sock *sk, struct sk_buff *skb,
 	return sk_filter_trim_cap(sk, skb, 1, reason);
 }
 
-struct bpf_prog *bpf_prog_select_jit(struct bpf_prog *fp, int *err);
+struct bpf_prog *bpf_prog_select_jit(struct bpf_verifier_env *env, struct bpf_prog *fp, int *err);
 struct bpf_prog *__bpf_prog_select_runtime(struct bpf_prog *fp, bool jit_attempted, int *err);
 struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err);
 void bpf_prog_free(struct bpf_prog *fp);
@@ -1155,7 +1155,7 @@ u64 __bpf_call_base(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
 	((u64 (*)(u64, u64, u64, u64, u64, const struct bpf_insn *)) \
 	 (void *)__bpf_call_base)
 
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog);
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog);
 void bpf_jit_compile(struct bpf_prog *prog);
 bool bpf_jit_needs_zext(void);
 bool bpf_jit_inlines_helper_call(s32 imm);
@@ -1312,7 +1312,7 @@ int bpf_jit_get_func_addr(const struct bpf_prog *prog,
 
 const char *bpf_jit_get_prog_name(struct bpf_prog *prog);
 
-struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *fp);
+struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bpf_prog *prog);
 void bpf_jit_prog_release_other(struct bpf_prog *fp, struct bpf_prog *fp_other);
 
 static inline void bpf_jit_dump(unsigned int flen, unsigned int proglen,
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 00be578a438d..7702c232c62e 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1486,7 +1486,7 @@ static void adjust_insn_arrays(struct bpf_prog *prog, u32 off, u32 len)
 #endif
 }
 
-struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *prog)
+struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 	struct bpf_insn insn_buff[16], aux[2];
 	struct bpf_prog *clone, *tmp;
@@ -2505,13 +2505,13 @@ static bool bpf_prog_select_interpreter(struct bpf_prog *fp)
 	return select_interpreter;
 }
 
-struct bpf_prog *bpf_prog_select_jit(struct bpf_prog *fp, int *err)
+struct bpf_prog *bpf_prog_select_jit(struct bpf_verifier_env *env, struct bpf_prog *fp, int *err)
 {
 	*err = bpf_prog_alloc_jited_linfo(fp);
 	if (*err)
 		return fp;
 
-	fp = bpf_int_jit_compile(fp);
+	fp = bpf_int_jit_compile(env, fp);
 	bpf_prog_jit_attempt_done(fp);
 	return fp;
 }
@@ -2541,7 +2541,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct bpf_prog *fp, bool jit_attempt
 	 */
 	if (!bpf_prog_is_offloaded(fp->aux)) {
 		if (!jit_attempted) {
-			fp = bpf_prog_select_jit(fp, err);
+			fp = bpf_prog_select_jit(NULL, fp, err);
 			if (*err)
 				return fp;
 		}
@@ -3072,7 +3072,7 @@ const struct bpf_func_proto bpf_tail_call_proto = {
  * It is encouraged to implement bpf_int_jit_compile() instead, so that
  * eBPF and implicitly also cBPF can get JITed!
  */
-struct bpf_prog * __weak bpf_int_jit_compile(struct bpf_prog *prog)
+struct bpf_prog * __weak bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 	return prog;
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ab2bc0850770..1d2d42078ddf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22844,7 +22844,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		 * all instruction adjustments should be accumulated
 		 */
 		old_len = func[i]->len;
-		func[i] = bpf_int_jit_compile(func[i]);
+		func[i] = bpf_int_jit_compile(env, func[i]);
 		subprog_start_adjustment += func[i]->len - old_len;
 
 		if (!func[i]->jited) {
@@ -22890,7 +22890,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	}
 	for (i = 0; i < env->subprog_cnt; i++) {
 		old_bpf_func = func[i]->bpf_func;
-		tmp = bpf_int_jit_compile(func[i]);
+		tmp = bpf_int_jit_compile(env, func[i]);
 		if (tmp != func[i] || func[i]->bpf_func != old_bpf_func) {
 			verbose(env, "JIT doesn't support bpf-to-bpf calls\n");
 			err = -ENOTSUPP;
@@ -26089,7 +26089,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	/* constants blinding in the JIT may increase prog->len */
 	len = env->prog->len;
 	if (env->subprog_cnt == 1)
-		env->prog = bpf_prog_select_jit(env->prog, &ret);
+		env->prog = bpf_prog_select_jit(env, env->prog, &ret);
 
 	adjust_btf_func(env);
 
-- 
2.47.3


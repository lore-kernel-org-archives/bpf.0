Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD6A38F655;
	Thu, 12 Mar 2026 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773333377; cv=none; b=CgMbtXhS5wcv0usXZv1l7roL/elCs8T1S5SoSwLPjU7m8KBA9p+OsGdIMAefFHg4o4zhcd8Axk+w6nVf/uv6+neISRDVNu1rp0KZgqSi2imqrlCij9411nFAveCsm7eU6Ur4OyTx0ann92NaRUXvbebmEryUopDmzWburEJ0oqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773333377; c=relaxed/simple;
	bh=9V6dJleXdm5upgtX1WSopjb92r3Ie8HFP5yvdv98Bps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LzGEzYYrdRVcn72ITfL4qfk1hc931ibWgpr4z8wDHckjuNxVF6Y8ho62QzETZXXj+KyJpIHnSInYTtviIfo87sRmip4nDY3K82t6QqW12MP48/o2/5Ym0tfjhx3Yc4VXpnp+i1ZAREEjVryKxM9iAbhl7hVbm8AMX06hD5UOMRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fWtWw0LnZzYQv9l;
	Fri, 13 Mar 2026 00:35:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 725174057A;
	Fri, 13 Mar 2026 00:36:13 +0800 (CST)
Received: from k01.k01 (unknown [10.67.174.197])
	by APP4 (Coremail) with SMTP id gCh0CgAX8Ut567JpyHCmAg--.44387S4;
	Fri, 13 Mar 2026 00:36:13 +0800 (CST)
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
	Anton Protopopov <a.s.protopopov@gmail.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Shahab Vahedi <list+bpf@vahedi.org>,
	Russell King <linux@armlinux.org.uk>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Johan Almbladh <johan.almbladh@anyfinetworks.com>,
	Paul Burton <paulburton@kernel.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Luke Nelson <luke.r.nels@gmail.com>,
	Xi Wang <xi.wang@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Wang YanQing <udknight@gmail.com>
Subject: [PATCH bpf-next v9 2/5] bpf: Pass bpf_verifier_env to JIT
Date: Fri, 13 Mar 2026 01:02:52 +0800
Message-ID: <20260312170255.3427799-3-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260312170255.3427799-1-xukuohai@huaweicloud.com>
References: <20260312170255.3427799-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAX8Ut567JpyHCmAg--.44387S4
X-Coremail-Antispam: 1UD129KBjvAXoW3ZF4fKFWrur4DXr18Jw4rGrg_yoW8XFWxGo
	W3tFn0yF48t3ykGrW7trn7JF1UXw17G397Zr4fWan5Wayxt34jkr97WrsrK3WSqa1rGrWD
	uFyxGa15ArsxKF9xn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUO57kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	yl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
	kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GF
	v_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUIID7DUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Pass bpf_verifier_env to bpf_int_jit_compile(). The follow-up patch will
use env->insn_aux_data in the JIT stage to detect indirect jump targets.

Since bpf_prog_select_runtime() can be called by cbpf and lib/test_bpf.c
code without verifier, introduce helper __bpf_prog_select_runtime()
to accept the env parameter.

Remove the call to bpf_prog_select_runtime() in bpf_prog_load(), and
switch to call __bpf_prog_select_runtime() in the verifier, with env
variable passed. The original bpf_prog_select_runtime() is preserved for
cbpf and lib/test_bpf.c, where env is NULL.

Now all constants blinding calls are moved into the verifier, except
the cbpf and lib/test_bpf.c cases. The instructions arrays are adjusted
by bpf_patch_insn_data() function for normal cases, so there is no need
to call adjust_insn_arrays() in  bpf_jit_blind_constants(). Remove it.

Reviewed-by: Anton Protopopov <a.s.protopopov@gmail.com>
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 arch/arc/net/bpf_jit_core.c      |  2 +-
 arch/arm/net/bpf_jit_32.c        |  2 +-
 arch/arm64/net/bpf_jit_comp.c    |  2 +-
 arch/loongarch/net/bpf_jit.c     |  2 +-
 arch/mips/net/bpf_jit_comp.c     |  2 +-
 arch/parisc/net/bpf_jit_core.c   |  2 +-
 arch/powerpc/net/bpf_jit_comp.c  |  2 +-
 arch/riscv/net/bpf_jit_core.c    |  2 +-
 arch/s390/net/bpf_jit_comp.c     |  2 +-
 arch/sparc/net/bpf_jit_comp_64.c |  2 +-
 arch/x86/net/bpf_jit_comp.c      |  2 +-
 arch/x86/net/bpf_jit_comp32.c    |  2 +-
 include/linux/filter.h           |  4 +-
 kernel/bpf/core.c                | 63 ++++++++++++--------------------
 kernel/bpf/syscall.c             |  4 --
 kernel/bpf/verifier.c            |  8 +++-
 16 files changed, 44 insertions(+), 59 deletions(-)

diff --git a/arch/arc/net/bpf_jit_core.c b/arch/arc/net/bpf_jit_core.c
index 973ceae48675..639a2736f029 100644
--- a/arch/arc/net/bpf_jit_core.c
+++ b/arch/arc/net/bpf_jit_core.c
@@ -1400,7 +1400,7 @@ static struct bpf_prog *do_extra_pass(struct bpf_prog *prog)
  * (re)locations involved that their addresses are not known
  * during the first run.
  */
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 	vm_dump(prog);
 
diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index e6b1bb2de627..1628b6fc70a4 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -2142,7 +2142,7 @@ bool bpf_jit_needs_zext(void)
 	return true;
 }
 
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 	struct bpf_binary_header *header;
 	struct jit_ctx ctx;
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index cd5a72fff500..7212ec89dfe3 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2006,7 +2006,7 @@ struct arm64_jit_data {
 	struct jit_ctx ctx;
 };
 
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 	int image_size, prog_size, extable_size, extable_align, extable_offset;
 	struct bpf_binary_header *header;
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 75a3a8fc6368..da0c7257a068 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1909,7 +1909,7 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 	return ret < 0 ? ret : ret * LOONGARCH_INSN_SIZE;
 }
 
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 	bool extra_pass = false;
 	u8 *image_ptr, *ro_image_ptr;
diff --git a/arch/mips/net/bpf_jit_comp.c b/arch/mips/net/bpf_jit_comp.c
index d2b6c955f18e..6ee4abe6a1f7 100644
--- a/arch/mips/net/bpf_jit_comp.c
+++ b/arch/mips/net/bpf_jit_comp.c
@@ -909,7 +909,7 @@ bool bpf_jit_needs_zext(void)
 	return true;
 }
 
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 	struct bpf_binary_header *header = NULL;
 	struct jit_context ctx;
diff --git a/arch/parisc/net/bpf_jit_core.c b/arch/parisc/net/bpf_jit_core.c
index 35dca372b5df..172770132440 100644
--- a/arch/parisc/net/bpf_jit_core.c
+++ b/arch/parisc/net/bpf_jit_core.c
@@ -41,7 +41,7 @@ bool bpf_jit_needs_zext(void)
 	return true;
 }
 
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 	unsigned int prog_size = 0, extable_size = 0;
 	bool extra_pass = false;
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index c9daa1a72378..e478e4e96ab0 100644
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
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index 527baa50dc68..768ac686b359 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -41,7 +41,7 @@ bool bpf_jit_needs_zext(void)
 	return true;
 }
 
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 	unsigned int prog_size = 0, extable_size = 0;
 	bool extra_pass = false;
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index db42a79e9004..9ccf811b7370 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2303,7 +2303,7 @@ static struct bpf_binary_header *bpf_jit_alloc(struct bpf_jit *jit,
 /*
  * Compile eBPF program "fp"
  */
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *fp)
 {
 	struct bpf_binary_header *header;
 	struct s390_jit_data *jit_data;
diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_comp_64.c
index e83e29137566..2fa0e9375127 100644
--- a/arch/sparc/net/bpf_jit_comp_64.c
+++ b/arch/sparc/net/bpf_jit_comp_64.c
@@ -1477,7 +1477,7 @@ struct sparc64_jit_data {
 	struct jit_ctx ctx;
 };
 
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 	struct sparc64_jit_data *jit_data;
 	struct bpf_binary_header *header;
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 77d00a8dec87..72d9a5faa230 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3713,7 +3713,7 @@ struct x64_jit_data {
 #define MAX_PASSES 20
 #define PADDING_PASSES (MAX_PASSES - 5)
 
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 	struct bpf_binary_header *rw_header = NULL;
 	struct bpf_binary_header *header = NULL;
diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 5f259577614a..852baf2e4db4 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -2518,7 +2518,7 @@ bool bpf_jit_needs_zext(void)
 	return true;
 }
 
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 	struct bpf_binary_header *header = NULL;
 	int proglen, oldproglen = 0;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 2f433182372c..3dd609fa7249 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1108,6 +1108,8 @@ static inline int sk_filter_reason(struct sock *sk, struct sk_buff *skb,
 	return sk_filter_trim_cap(sk, skb, 1, reason);
 }
 
+struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct bpf_prog *fp,
+					   int *err);
 struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err);
 void bpf_prog_free(struct bpf_prog *fp);
 
@@ -1153,7 +1155,7 @@ u64 __bpf_call_base(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
 	((u64 (*)(u64, u64, u64, u64, u64, const struct bpf_insn *)) \
 	 (void *)__bpf_call_base)
 
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog);
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog);
 void bpf_jit_compile(struct bpf_prog *prog);
 bool bpf_jit_needs_zext(void);
 bool bpf_jit_inlines_helper_call(s32 imm);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 4c20417c301a..78c550d8f663 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1469,23 +1469,6 @@ void bpf_jit_prog_release_other(struct bpf_prog *fp, struct bpf_prog *fp_other)
 	bpf_prog_clone_free(fp_other);
 }
 
-static void adjust_insn_arrays(struct bpf_prog *prog, u32 off, u32 len)
-{
-#ifdef CONFIG_BPF_SYSCALL
-	struct bpf_map *map;
-	int i;
-
-	if (len <= 1)
-		return;
-
-	for (i = 0; i < prog->aux->used_map_cnt; i++) {
-		map = prog->aux->used_maps[i];
-		if (map->map_type == BPF_MAP_TYPE_INSN_ARRAY)
-			bpf_insn_array_adjust(map, off, len);
-	}
-#endif
-}
-
 struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 	struct bpf_insn insn_buff[16], aux[2];
@@ -1558,12 +1541,6 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bp
 
 		if (env)
 			env->prog = clone;
-		else
-			/* Instructions arrays must be updated using absolute xlated offsets.
-			 * The arrays have already been adjusted by bpf_patch_insn_data() when
-			 * env is not NULL.
-			 */
-			adjust_insn_arrays(clone, subprog_start + i, rewritten);
 
 		/* Walk new program and skip insns we just inserted. */
 		insn = clone->insnsi + i + insn_delta;
@@ -2526,13 +2503,13 @@ static bool bpf_prog_select_interpreter(struct bpf_prog *fp)
 	return select_interpreter;
 }
 
-static struct bpf_prog *bpf_prog_jit_compile(struct bpf_prog *prog)
+static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 #ifdef CONFIG_BPF_JIT
 	bool blinded = false;
 	struct bpf_prog *orig_prog = prog;
 
-	prog = bpf_jit_blind_constants(NULL, orig_prog);
+	prog = bpf_jit_blind_constants(env, orig_prog);
 	/* If blinding was requested and we failed during blinding, we must fall
 	 * back to the interpreter.
 	 */
@@ -2542,7 +2519,7 @@ static struct bpf_prog *bpf_prog_jit_compile(struct bpf_prog *prog)
 	if (prog != orig_prog)
 		blinded = true;
 
-	prog = bpf_int_jit_compile(prog);
+	prog = bpf_int_jit_compile(env, prog);
 	if (blinded) {
 		if (!prog->jited) {
 			bpf_jit_prog_release_other(orig_prog, prog);
@@ -2555,18 +2532,8 @@ static struct bpf_prog *bpf_prog_jit_compile(struct bpf_prog *prog)
 	return prog;
 }
 
-/**
- *	bpf_prog_select_runtime - select exec runtime for BPF program
- *	@fp: bpf_prog populated with BPF program
- *	@err: pointer to error variable
- *
- * Try to JIT eBPF program, if JIT is not available, use interpreter.
- * The BPF program will be executed via bpf_prog_run() function.
- *
- * Return: the &fp argument along with &err set to 0 for success or
- * a negative errno code on failure
- */
-struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
+struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct bpf_prog *fp,
+					   int *err)
 {
 	/* In case of BPF to BPF calls, verifier did all the prep
 	 * work with regards to JITing, etc.
@@ -2594,7 +2561,7 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
 		if (*err)
 			return fp;
 
-		fp = bpf_prog_jit_compile(fp);
+		fp = bpf_prog_jit_compile(env, fp);
 		bpf_prog_jit_attempt_done(fp);
 		if (!fp->jited && jit_needed) {
 			*err = -ENOTSUPP;
@@ -2620,6 +2587,22 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
 
 	return fp;
 }
+
+/**
+ *	bpf_prog_select_runtime - select exec runtime for BPF program
+ *	@fp: bpf_prog populated with BPF program
+ *	@err: pointer to error variable
+ *
+ * Try to JIT eBPF program, if JIT is not available, use interpreter.
+ * The BPF program will be executed via bpf_prog_run() function.
+ *
+ * Return: the &fp argument along with &err set to 0 for success or
+ * a negative errno code on failure
+ */
+struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
+{
+	return __bpf_prog_select_runtime(NULL, fp, err);
+}
 EXPORT_SYMBOL_GPL(bpf_prog_select_runtime);
 
 static unsigned int __bpf_prog_ret1(const void *ctx,
@@ -3107,7 +3090,7 @@ const struct bpf_func_proto bpf_tail_call_proto = {
  * It is encouraged to implement bpf_int_jit_compile() instead, so that
  * eBPF and implicitly also cBPF can get JITed!
  */
-struct bpf_prog * __weak bpf_int_jit_compile(struct bpf_prog *prog)
+struct bpf_prog * __weak bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 	return prog;
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 274039e36465..fb07be46c936 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3090,10 +3090,6 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	if (err < 0)
 		goto free_used_maps;
 
-	prog = bpf_prog_select_runtime(prog, &err);
-	if (err < 0)
-		goto free_used_maps;
-
 	err = bpf_prog_mark_insn_arrays_ready(prog);
 	if (err < 0)
 		goto free_used_maps;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3ccefd13121b..c8c4d7ea8588 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22992,7 +22992,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->might_sleep = env->subprog_info[i].might_sleep;
 		if (!i)
 			func[i]->aux->exception_boundary = env->seen_exception;
-		func[i] = bpf_int_jit_compile(func[i]);
+		func[i] = bpf_int_jit_compile(env, func[i]);
 		if (!func[i]->jited) {
 			err = -ENOTSUPP;
 			goto out_free;
@@ -23036,7 +23036,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	}
 	for (i = 0; i < env->subprog_cnt; i++) {
 		old_bpf_func = func[i]->bpf_func;
-		tmp = bpf_int_jit_compile(func[i]);
+		tmp = bpf_int_jit_compile(env, func[i]);
 		if (tmp != func[i] || func[i]->bpf_func != old_bpf_func) {
 			verbose(env, "JIT doesn't support bpf-to-bpf calls\n");
 			err = -ENOTSUPP;
@@ -26304,6 +26304,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 		convert_pseudo_ld_imm64(env);
 	}
 
+	env->prog = __bpf_prog_select_runtime(env, env->prog, &ret);
+	if (ret)
+		goto err_release_maps;
+
 	adjust_btf_func(env);
 
 err_release_maps:
-- 
2.47.3


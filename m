Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF5E34BA24;
	Fri,  3 Apr 2026 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775208638; cv=none; b=aHRJ+4IgUEK9a2wYG0++ifaVQ5n0VytybWC2fxM2w58pgYOWeOtf3Qo/V028qSWSxVy+ICcKMlkvrBgNP8FbN4F6VveKQbreBXIIU6jhi6ZE2VayiePhp+IY8zGdod+lZnl33PA4tJiPrpmBUq6BuqOj/fW5omVuDQvHtKIpB9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775208638; c=relaxed/simple;
	bh=EWCKWTyiRWqq5EFL7KT9yZZiwzHx6KxYMUE9m5k0ttQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fn/keZE1Xt2yL8iUpQ0Ed2Sn1nf4Usst1kKz0zyCh7eFMdRI5L9lsAOaCSk/qcxoyaKXQQoBF2f03X2lxAqZDpGdinZAb1eNXCLt3JVikM5oOOvRM9n3IInVoW4nToE+YZ/Ce+Q6OD6KdawHd84Cq3NL7iUEI7d5yh9ILFGMC6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fnD313n5rzYQttT;
	Fri,  3 Apr 2026 17:30:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E46F540591;
	Fri,  3 Apr 2026 17:30:30 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP1 (Coremail) with SMTP id cCh0CgCXmdmziM9pq1_jDA--.17616S4;
	Fri, 03 Apr 2026 17:30:30 +0800 (CST)
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
Subject: [PATCH bpf-next v11 2/5] bpf: Pass bpf_verifier_env to JIT
Date: Fri,  3 Apr 2026 09:09:12 +0000
Message-ID: <20260403090915.473493-3-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403090915.473493-1-xukuohai@huaweicloud.com>
References: <20260403090915.473493-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXmdmziM9pq1_jDA--.17616S4
X-Coremail-Antispam: 1UD129KBjvAXoW3ZF4fKFWrur45tr4xXr1DKFg_yoW8WrWrXo
	W3tFn0yF48t3ykGrW7Jrn7JF15Zw17G397Zr4fWan5Wayxt34jkr97Wwsrt3WSqa1rGw4D
	uFyxGa15ArsxKF9xn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUO87kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	yl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14
	v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jI
	sjbUUUUU=
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
to call adjust_insn_arrays() in bpf_jit_blind_constants(). Remove it.

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
 kernel/bpf/verifier.c            | 20 ++++++----
 16 files changed, 50 insertions(+), 65 deletions(-)

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
index fcc8c0c29fb0..5149ce4cef7e 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1920,7 +1920,7 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
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
index 711028bebea3..27fecb4cc063 100644
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
index 2dfc279b1be2..94128fe6be23 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2312,7 +2312,7 @@ static struct bpf_binary_header *bpf_jit_alloc(struct bpf_jit *jit,
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
index d396e55c9a1d..d7ae6fa1998b 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1107,6 +1107,8 @@ static inline int sk_filter_reason(struct sock *sk, struct sk_buff *skb,
 	return sk_filter_trim_cap(sk, skb, 1, reason);
 }
 
+struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct bpf_prog *fp,
+					   int *err);
 struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err);
 void bpf_prog_free(struct bpf_prog *fp);
 
@@ -1152,7 +1154,7 @@ u64 __bpf_call_base(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
 	((u64 (*)(u64, u64, u64, u64, u64, const struct bpf_insn *)) \
 	 (void *)__bpf_call_base)
 
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog);
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog);
 void bpf_jit_compile(struct bpf_prog *prog);
 bool bpf_jit_needs_zext(void);
 bool bpf_jit_inlines_helper_call(s32 imm);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index b458a85b3e18..0327008ba5e3 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1489,23 +1489,6 @@ void bpf_jit_prog_release_other(struct bpf_prog *fp, struct bpf_prog *fp_other)
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
 /* Now this function is used only to blind the main prog and must be invoked only when
  * bpf_prog_need_blind() returns true.
  */
@@ -1580,12 +1563,6 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bp
 
 		if (env)
 			env->prog = clone;
-		else
-			/* Instructions arrays must be updated using absolute xlated offsets.
-			 * The arrays have already been adjusted by bpf_patch_insn_data() when
-			 * env is not NULL.
-			 */
-			adjust_insn_arrays(clone, i, rewritten);
 
 		/* Walk new program and skip insns we just inserted. */
 		insn = clone->insnsi + i + insn_delta;
@@ -2559,14 +2536,14 @@ static bool bpf_prog_select_interpreter(struct bpf_prog *fp)
 	return select_interpreter;
 }
 
-static struct bpf_prog *bpf_prog_jit_compile(struct bpf_prog *prog)
+static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 #ifdef CONFIG_BPF_JIT
 	bool blinded = false;
 	struct bpf_prog *orig_prog = prog;
 
 	if (bpf_prog_need_blind(orig_prog)) {
-		prog = bpf_jit_blind_constants(NULL, orig_prog);
+		prog = bpf_jit_blind_constants(env, orig_prog);
 		/* If blinding was requested and we failed during blinding, we must fall
 		 * back to the interpreter.
 		 */
@@ -2575,7 +2552,7 @@ static struct bpf_prog *bpf_prog_jit_compile(struct bpf_prog *prog)
 		blinded = true;
 	}
 
-	prog = bpf_int_jit_compile(prog);
+	prog = bpf_int_jit_compile(env, prog);
 	if (blinded) {
 		if (!prog->jited) {
 			bpf_jit_prog_release_other(orig_prog, prog);
@@ -2588,18 +2565,8 @@ static struct bpf_prog *bpf_prog_jit_compile(struct bpf_prog *prog)
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
@@ -2627,7 +2594,7 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
 		if (*err)
 			return fp;
 
-		fp = bpf_prog_jit_compile(fp);
+		fp = bpf_prog_jit_compile(env, fp);
 		bpf_prog_jit_attempt_done(fp);
 		if (!fp->jited && jit_needed) {
 			*err = -ENOTSUPP;
@@ -2653,6 +2620,22 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
 
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
@@ -3140,7 +3123,7 @@ const struct bpf_func_proto bpf_tail_call_proto = {
  * It is encouraged to implement bpf_int_jit_compile() instead, so that
  * eBPF and implicitly also cBPF can get JITed!
  */
-struct bpf_prog * __weak bpf_int_jit_compile(struct bpf_prog *prog)
+struct bpf_prog * __weak bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 	return prog;
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e1505c9cd09e..553dca175640 100644
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
index 0d6bfccf0dd7..3378b373a461 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23142,7 +23142,7 @@ static int  __jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->might_sleep = env->subprog_info[i].might_sleep;
 		if (!i)
 			func[i]->aux->exception_boundary = env->seen_exception;
-		func[i] = bpf_int_jit_compile(func[i]);
+		func[i] = bpf_int_jit_compile(env, func[i]);
 		if (!func[i]->jited) {
 			err = -ENOTSUPP;
 			goto out_free;
@@ -23186,7 +23186,7 @@ static int  __jit_subprogs(struct bpf_verifier_env *env)
 	}
 	for (i = 0; i < env->subprog_cnt; i++) {
 		old_bpf_func = func[i]->bpf_func;
-		tmp = bpf_int_jit_compile(func[i]);
+		tmp = bpf_int_jit_compile(env, func[i]);
 		if (tmp != func[i] || func[i]->bpf_func != old_bpf_func) {
 			verbose(env, "JIT doesn't support bpf-to-bpf calls\n");
 			err = -ENOTSUPP;
@@ -26504,6 +26504,16 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 		convert_pseudo_ld_imm64(env);
 	}
 
+	/* extension progs temporarily inherit the attach_type of their targets
+	   for verification purposes, so set it back to zero before returning
+	 */
+	if (env->prog->type == BPF_PROG_TYPE_EXT)
+		env->prog->expected_attach_type = 0;
+
+	env->prog = __bpf_prog_select_runtime(env, env->prog, &ret);
+	if (ret)
+		goto err_release_maps;
+
 	adjust_btf_func(env);
 
 err_release_maps:
@@ -26517,12 +26527,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (!env->prog->aux->used_btfs)
 		release_btfs(env);
 
-	/* extension progs temporarily inherit the attach_type of their targets
-	   for verification purposes, so set it back to zero before returning
-	 */
-	if (env->prog->type == BPF_PROG_TYPE_EXT)
-		env->prog->expected_attach_type = 0;
-
 	*prog = env->prog;
 
 	module_put(env->attach_btf_mod);
-- 
2.43.0


Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE1C282F1B;
	Fri,  3 Apr 2026 13:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775224173; cv=none; b=fsUQ7jMnM5kfzQICvyy632p0cIMfXOVq0LE+LhqVw9Xj8QYikj1NnCrRnyeOTC5v1xMQosP+3DMCKXCBZgmVlgPJNwPl5AItyjHZWQUyQBqoqj/0jJT3VnVrUCIAHt1Bn75SzNbYMzg7YfjROFGCMdgwsuvV9KoHuLS5A44o/1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775224173; c=relaxed/simple;
	bh=gRH62jWw3eyJP/tJsKpCyKGhWqOYRcJQQoOL5KP54XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Feqy8/wXfSWAbV3PWTYVtohlcC9dwdzEG26Sib4G4wWJr10P70yOo3BQhwW7Xyfl2t10pugcS0nJVkmcGAUQVViGRC1VbCEQSTYZzs3o/jeHxP5gzXdLTt0mjdb3E/VUr6bT8z9tB2dz/UP5EbaJxLfYTKC6jxn6uQCyNdIdA/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fnKnG66GbzKHMVD;
	Fri,  3 Apr 2026 21:48:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id B291540574;
	Fri,  3 Apr 2026 21:49:27 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP3 (Coremail) with SMTP id _Ch0CgAnB1Rjxc9pPbfoDA--.34698S4;
	Fri, 03 Apr 2026 21:49:27 +0800 (CST)
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
Subject: [PATCH bpf-next v12 2/5] bpf: Pass bpf_verifier_env to JIT
Date: Fri,  3 Apr 2026 13:28:08 +0000
Message-ID: <20260403132811.753894-3-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403132811.753894-1-xukuohai@huaweicloud.com>
References: <20260403132811.753894-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAnB1Rjxc9pPbfoDA--.34698S4
X-Coremail-Antispam: 1UD129KBjvAXoWfZrWrCr13GryDZFyrAF17Awb_yoW8ZF1DGo
	W3Krn0yF48t3ykGrZrJrn7JF1UZw17G397Zr4fGFs5W34xt34UKryxWwsrK3WSq3WrGw4D
	uFyxGay5ArZ8KFZxn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUO07kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	yl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14
	v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxU
	IID7DUUUU
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
 include/linux/filter.h           | 17 +++++-
 kernel/bpf/core.c                | 93 +++++++++++++++++---------------
 kernel/bpf/syscall.c             |  4 --
 kernel/bpf/verifier.c            | 36 +++++++------
 16 files changed, 98 insertions(+), 76 deletions(-)

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
index d396e55c9a1d..83f37d38c5c1 100644
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
@@ -1187,12 +1189,25 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 #ifdef CONFIG_BPF_SYSCALL
 struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
 				     const struct bpf_insn *patch, u32 len);
+struct bpf_insn_aux_data *bpf_dup_insn_aux_data(struct bpf_verifier_env *env);
+void bpf_restore_insn_aux_data(struct bpf_verifier_env *env,
+			       struct bpf_insn_aux_data *orig_insn_aux);
 #else
 static inline struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
 						   const struct bpf_insn *patch, u32 len)
 {
 	return ERR_PTR(-ENOTSUPP);
 }
+
+static inline struct bpf_insn_aux_data *bpf_dup_insn_aux_data(struct bpf_verifier_env *env)
+{
+	return NULL;
+}
+
+static inline void bpf_restore_insn_aux_data(struct bpf_verifier_env *env,
+					     struct bpf_insn_aux_data *orig_insn_aux)
+{
+}
 #endif /* CONFIG_BPF_SYSCALL */
 
 int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index cc61fe57b98d..093ab0f68c81 100644
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
@@ -1577,12 +1560,6 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bp
 
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
@@ -2551,47 +2528,63 @@ static bool bpf_prog_select_interpreter(struct bpf_prog *fp)
 	return select_interpreter;
 }
 
-static struct bpf_prog *bpf_prog_jit_compile(struct bpf_prog *prog)
+static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 #ifdef CONFIG_BPF_JIT
 	bool blinded = false;
 	struct bpf_prog *orig_prog = prog;
+	struct bpf_insn_aux_data *orig_insn_aux;
 
 	if (bpf_prog_need_blind(orig_prog)) {
-		prog = bpf_jit_blind_constants(NULL, orig_prog);
+		if (env) {
+			/* If env is not NULL, we are called from the end of bpf_check(), at this
+			 * point, only insn_aux_data is used after failure, so we only restore it
+			 * here.
+			 */
+			orig_insn_aux = bpf_dup_insn_aux_data(env);
+			if (!orig_insn_aux)
+				return orig_prog;
+		}
+		prog = bpf_jit_blind_constants(env, orig_prog);
 		/* If blinding was requested and we failed during blinding, we must fall
 		 * back to the interpreter.
 		 */
-		if (IS_ERR(prog))
-			return orig_prog;
+		if (IS_ERR(prog)) {
+			prog = orig_prog;
+			if (env)
+				goto out_restore;
+			else
+				return prog;
+		}
 		blinded = true;
 	}
 
-	prog = bpf_int_jit_compile(prog);
+	prog = bpf_int_jit_compile(env, prog);
 	if (blinded) {
 		if (!prog->jited) {
 			bpf_jit_prog_release_other(orig_prog, prog);
 			prog = orig_prog;
+			if (env)
+				goto out_restore;
 		} else {
 			bpf_jit_prog_release_other(prog, orig_prog);
+			if (env)
+				goto out_free;
 		}
 	}
+
+	return prog;
+
+out_restore:
+	bpf_restore_insn_aux_data(env, orig_insn_aux);
+out_free:
+	kvfree(orig_insn_aux);
 #endif
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
@@ -2619,7 +2612,7 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
 		if (*err)
 			return fp;
 
-		fp = bpf_prog_jit_compile(fp);
+		fp = bpf_prog_jit_compile(env, fp);
 		bpf_prog_jit_attempt_done(fp);
 		if (!fp->jited && jit_needed) {
 			*err = -ENOTSUPP;
@@ -2645,6 +2638,22 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
 
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
@@ -3132,7 +3141,7 @@ const struct bpf_func_proto bpf_tail_call_proto = {
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
index 66cef3744fde..5084a754a748 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22983,7 +22983,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 	return 0;
 }
 
-static u32 *dup_subprog_starts(struct bpf_verifier_env *env)
+static u32 *bpf_dup_subprog_starts(struct bpf_verifier_env *env)
 {
 	u32 *starts = NULL;
 
@@ -22995,13 +22995,13 @@ static u32 *dup_subprog_starts(struct bpf_verifier_env *env)
 	return starts;
 }
 
-static void restore_subprog_starts(struct bpf_verifier_env *env, u32 *orig_starts)
+static void bpf_restore_subprog_starts(struct bpf_verifier_env *env, u32 *orig_starts)
 {
 	for (int i = 0; i < env->subprog_cnt; i++)
 		env->subprog_info[i].start = orig_starts[i];
 }
 
-static struct bpf_insn_aux_data *dup_insn_aux_data(struct bpf_verifier_env *env)
+struct bpf_insn_aux_data *bpf_dup_insn_aux_data(struct bpf_verifier_env *env)
 {
 	size_t size;
 
@@ -23009,8 +23009,8 @@ static struct bpf_insn_aux_data *dup_insn_aux_data(struct bpf_verifier_env *env)
 	return kvmemdup(env->insn_aux_data, size, GFP_KERNEL_ACCOUNT);
 }
 
-static void restore_insn_aux_data(struct bpf_verifier_env *env,
-				  struct bpf_insn_aux_data *orig_insn_aux)
+void bpf_restore_insn_aux_data(struct bpf_verifier_env *env,
+			       struct bpf_insn_aux_data *orig_insn_aux)
 {
 	/* the expanded elements are zero-filled, so no special handling is required */
 	vfree(env->insn_aux_data);
@@ -23153,7 +23153,7 @@ static int __jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->might_sleep = env->subprog_info[i].might_sleep;
 		if (!i)
 			func[i]->aux->exception_boundary = env->seen_exception;
-		func[i] = bpf_int_jit_compile(func[i]);
+		func[i] = bpf_int_jit_compile(env, func[i]);
 		if (!func[i]->jited) {
 			err = -ENOTSUPP;
 			goto out_free;
@@ -23197,7 +23197,7 @@ static int __jit_subprogs(struct bpf_verifier_env *env)
 	}
 	for (i = 0; i < env->subprog_cnt; i++) {
 		old_bpf_func = func[i]->bpf_func;
-		tmp = bpf_int_jit_compile(func[i]);
+		tmp = bpf_int_jit_compile(env, func[i]);
 		if (tmp != func[i] || func[i]->bpf_func != old_bpf_func) {
 			verbose(env, "JIT doesn't support bpf-to-bpf calls\n");
 			err = -ENOTSUPP;
@@ -23297,12 +23297,12 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 
 	prog = orig_prog = env->prog;
 	if (bpf_prog_need_blind(orig_prog)) {
-		orig_insn_aux = dup_insn_aux_data(env);
+		orig_insn_aux = bpf_dup_insn_aux_data(env);
 		if (!orig_insn_aux) {
 			err = -ENOMEM;
 			goto out_cleanup;
 		}
-		orig_subprog_starts = dup_subprog_starts(env);
+		orig_subprog_starts = bpf_dup_subprog_starts(env);
 		if (!orig_subprog_starts) {
 			err = -ENOMEM;
 			goto out_free_aux;
@@ -23347,8 +23347,8 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	return 0;
 
 out_restore:
-	restore_subprog_starts(env, orig_subprog_starts);
-	restore_insn_aux_data(env, orig_insn_aux);
+	bpf_restore_subprog_starts(env, orig_subprog_starts);
+	bpf_restore_insn_aux_data(env, orig_insn_aux);
 	kvfree(orig_subprog_starts);
 out_free_aux:
 	kvfree(orig_insn_aux);
@@ -26523,6 +26523,14 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 
 	adjust_btf_func(env);
 
+	/* extension progs temporarily inherit the attach_type of their targets
+	   for verification purposes, so set it back to zero before returning
+	 */
+	if (env->prog->type == BPF_PROG_TYPE_EXT)
+		env->prog->expected_attach_type = 0;
+
+	env->prog = __bpf_prog_select_runtime(env, env->prog, &ret);
+
 err_release_maps:
 	if (ret)
 		release_insn_arrays(env);
@@ -26534,12 +26542,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
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


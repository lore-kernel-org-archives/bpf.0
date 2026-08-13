Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [40.65.178.148])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2413C2775;
	Thu, 13 Aug 2026 12:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=40.65.178.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786622483; cv=none; b=J0mB1k5t1Rsg97xZ2tBDrkxzAkxO9piaDzyBzZYvd8RNJ9gzg+wfAZRt3atTzfNufWyO98yghn9rBE53HHbr8yoJDTY8i3z7T7f6Lu2KLprozXbNyCv7RKe7MxWl1Tx6XqZh+V+ym4vDRDBayQZNcsuQOS8fTHoHedM2XDifE74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786622483; c=relaxed/simple;
	bh=6NboFQuHCKK8vq6XXSVXro/UcsBd2lnP0eeO1DCHFck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZIjlHd/oOCij1L7ma2f4L/9AOrKdzsK6UuFHXk0It8JrQZECrHTRfsjUcsSxGFrFvU4B77ryP0DotfB1lowS+gzPjHcPRWgzLwr2GyTAYX50WV1uLW1ovre6PLyDYHJu6d11z53vqLXhyyNXKa3jYrvh1MWIiyVm2M+ywJsLPPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=Mk7Gt1d5; arc=none smtp.client-ip=40.65.178.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="Mk7Gt1d5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=+KzligLo6ZhjIxe52XRB5qyxdak6CJv
	SAA7e7j0F6zU=; b=Mk7Gt1d5MMNTa+BsDjXxJJVAvp5hqJH2lEmTuigGahXV0BE
	eqxFtmMElW79Cc1BiH14Xxl2FhAn7idh3HGRaqLkFN4UPW3U8a5fGLzdvDx+/pZ9
	NV8RC9rmk2nFyzHJq5DYHT84WTZ9XBmhIk9IqsInbVd1GB2mMXJmaVnZgSVE=
Received: from [172.17.0.4] (unknown [101.6.30.195])
	by web3 (Coremail) with SMTP id ygQGZQAn+BbosX1q_MyTAA--.65327S4;
	Thu, 13 Aug 2026 20:00:47 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Date: Thu, 13 Aug 2026 12:00:41 +0000
Subject: [PATCH bpf-next 2/2] selftests/bpf: Cover IA32 narrow kfunc
 returns
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-bpf-next-039-ia32-kfunc-return-v1-v1-2-37495ec632b5@mails.tsinghua.edu.cn>
References: <20260813-bpf-next-039-ia32-kfunc-return-v1-v1-0-37495ec632b5@mails.tsinghua.edu.cn>
In-Reply-To: <20260813-bpf-next-039-ia32-kfunc-return-v1-v1-0-37495ec632b5@mails.tsinghua.edu.cn>
To: Wang YanQing <udknight@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786622447; l=5739;
 i=chenyy23@mails.tsinghua.edu.cn; s=kernel; h=from:subject:message-id;
 bh=6NboFQuHCKK8vq6XXSVXro/UcsBd2lnP0eeO1DCHFck=;
 b=03TIQLagEWJbuhokKoGGhwh6AdPVLu4U48CeCNtRP+fthMfKKCLFrP/38T2mNZVpDRWRuX+Yt
 Xb6DfhdI+f0CesbT+savx1cXO4/WdMzVCWrbnoXr3XFLRNWWXWdYmdo
X-Developer-Key: i=chenyy23@mails.tsinghua.edu.cn; a=ed25519;
 pk=+Q11PEDVzoU+87KHlIeNWKwv/GiutzE5094ej7opM+s=
X-CM-TRANSID:ygQGZQAn+BbosX1q_MyTAA--.65327S4
X-Coremail-Antispam: 1UD129KBjvJXoW3AF13AF43ArW5Cr17KFyUJrb_yoW7ZF1rpa
	4kC34qkrn7G3W3WF1xGF4UuFWfKFs7Z3yUJr40gr97ZF1UX34DXr4xKFW5tr95K3yF93yY
	ya4Sga13ZF1xAaUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBq1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2kKe7AKxVWUXVWUAwAac4AC62xK8xCEY4
	vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VCjz48v1sIEY20_GrWkJr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxkIecxEwVAFwVW5JwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
	x26r4rKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
	0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMI
	IF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z2
	80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbPxhPUUUUU==
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

Teach test_loader to select IA32-specific cases and add unsigned bool and
signed int kfunc-return tests. Each case consumes the high half of R0 after
the call and checks the required zero or sign extension.

Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 tools/testing/selftests/bpf/prog_tests/verifier.c  |  2 +
 tools/testing/selftests/bpf/progs/bpf_misc.h       |  1 +
 .../selftests/bpf/progs/verifier_kfunc_return.c    | 84 ++++++++++++++++++++++
 tools/testing/selftests/bpf/test_loader.c          | 13 ++--
 4 files changed, 96 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 8113fea7ba86c..4638e0a45db6e 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -127,6 +127,7 @@
 #include "verifier_set_retval.skel.h"
 #include "verifier_lsm.skel.h"
 #include "verifier_jit_inline.skel.h"
+#include "verifier_kfunc_return.skel.h"
 #include "irq.skel.h"
 #include "verifier_ctx_ptr_param.skel.h"
 #include "verifier_zext.skel.h"
@@ -289,6 +290,7 @@ void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
 void test_irq(void)			      { RUN(irq); }
 void test_verifier_mtu(void)		      { RUN(verifier_mtu); }
 void test_verifier_jit_inline(void)               { RUN(verifier_jit_inline); }
+void test_verifier_kfunc_return(void)             { RUN(verifier_kfunc_return); }
 void test_verifier_ctx_ptr_param(void)       { RUN(verifier_ctx_ptr_param); }
 void test_verifier_zext(void)                 { RUN_TESTS(verifier_zext); }
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 5eacf1b432521..1498da04597af 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -155,6 +155,7 @@
 #define __btf_func_path(path)	__test_tag("test_btf_func_path=" path)
 #define __arch(arch)		__test_tag("test_arch=" arch)
 #define __arch_x86_64		__arch("X86_64")
+#define __arch_x86_32		__arch("X86_32")
 #define __arch_arm64		__arch("ARM64")
 #define __arch_riscv64		__arch("RISCV64")
 #define __arch_s390x		__arch("s390x")
diff --git a/tools/testing/selftests/bpf/progs/verifier_kfunc_return.c b/tools/testing/selftests/bpf/progs/verifier_kfunc_return.c
new file mode 100644
index 0000000000000..52a94daf03922
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_kfunc_return.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define BPF_NO_KFUNC_PROTOTYPES
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+extern int bpf_strcmp(const char *s1__ign, const char *s2__ign) __ksym;
+extern bool bpf_dynptr_is_null(const struct bpf_dynptr *p) __ksym;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} kfunc_return_map SEC(".maps");
+
+static const char string_a[] = "a";
+static const char string_b[] = "b";
+
+void __kfunc_btf_root(void)
+{
+	struct bpf_dynptr ptr = {};
+
+	bpf_strcmp(string_a, string_b);
+	bpf_dynptr_is_null(&ptr);
+}
+
+SEC("syscall")
+__flag(BPF_F_SLEEPABLE)
+__success __retval(0)
+__arch_x86_32
+__naked void kfunc_bool_return_zero_extended(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	*(u32 *)(r10 - 4) = r0;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[kfunc_return_map] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto 1f;				\
+	r1 = r0;					\
+	r2 = 8;						\
+	r3 = 0;						\
+	r4 = r10;					\
+	r4 += -24;					\
+	call %[bpf_dynptr_from_mem];			\
+	if r0 != 0 goto 1f;				\
+	r0 = 0x100000000 ll;				\
+	r1 = r10;					\
+	r1 += -24;					\
+	call bpf_dynptr_is_null;				\
+	r0 >>= 32;					\
+	exit;						\
+1:	r0 = 2;						\
+	exit;						\
+"	:
+	: __imm_addr(kfunc_return_map),
+	  __imm(bpf_map_lookup_elem),
+	  __imm(bpf_dynptr_from_mem)
+	: __clobber_all);
+}
+
+SEC("syscall")
+__flag(BPF_F_SLEEPABLE)
+__success __retval(-1)
+__arch_x86_32
+__naked void kfunc_int_return_sign_extended(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	r1 = %[string_a] ll;				\
+	r2 = %[string_b] ll;				\
+	call bpf_strcmp;				\
+	r0 >>= 32;					\
+	exit;						\
+"	:
+	: __imm_addr(string_a),
+	  __imm_addr(string_b)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 07807757b518d..8a9f4a31a1bb1 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -374,16 +374,19 @@ static const char **collect_decl_tags(struct btf *btf, int id, int *cnt)
 enum arch {
 	ARCH_UNKNOWN	= 0x1,
 	ARCH_X86_64	= 0x2,
-	ARCH_ARM64	= 0x4,
-	ARCH_RISCV64	= 0x8,
-	ARCH_S390X	= 0x10,
-	ARCH_LOONGARCH	= 0x20,
+	ARCH_X86_32	= 0x4,
+	ARCH_ARM64	= 0x8,
+	ARCH_RISCV64	= 0x10,
+	ARCH_S390X	= 0x20,
+	ARCH_LOONGARCH	= 0x40,
 };
 
 static int get_current_arch(void)
 {
 #if defined(__x86_64__)
 	return ARCH_X86_64;
+#elif defined(__i386__)
+	return ARCH_X86_32;
 #elif defined(__aarch64__)
 	return ARCH_ARM64;
 #elif defined(__riscv) && __riscv_xlen == 64
@@ -577,6 +580,8 @@ static int parse_test_spec(struct test_loader *tester,
 		} else if ((val = str_has_pfx(s, "test_arch="))) {
 			if (strcmp(val, "X86_64") == 0) {
 				arch = ARCH_X86_64;
+			} else if (strcmp(val, "X86_32") == 0) {
+				arch = ARCH_X86_32;
 			} else if (strcmp(val, "ARM64") == 0) {
 				arch = ARCH_ARM64;
 			} else if (strcmp(val, "RISCV64") == 0) {

-- 
2.43.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118518;
	b=BmoyB8qinghtuaWH/P8BRntdxlLsb7eBnM1TPM9JHkYwXUQsKJcVw9sUt0KQ7JHXd+ca
	 X+lAfkexMSe/0ue72rd/lXkmYljA80kIaM1LDYnpGSHH4HtoIQ5gFv5umcwxASeg2trWW
	 9g6Zu4hOAxBj4RCBS8HT98NB76TypQsplC7l4ATi3F7PGmw0CngL1aKPouHW/UJnzLpyQ
	 fk/IA0eSOazFuPHAhjN1DUmbhjwl5RrWMf1v2afedKSaLP2Ob0fghDPZtpgLwyoh0Wxue
	 OHUdQAO//Qn6sT/puhoU7+XzeL8l21GvjMmm4+TxN6WiQscJxxT22uK+dMi4rDH5Ouw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118518;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NZYABka5j4ImZ7EGIuGf6YSfl1wz5MVEavRY8ItyrIo=;
	b=vLpV1NmGVluksNcGLG7XlXzRonBNXvWMfW67eaOshgVfFx3TWi4zzV7lsPxp2DtBuWF9
	 GY5kErpj5vQAXBOQ+EB79R+MjDGfjj7zDUJzgqvnbB7B2SOG4UVQlwlIBhZ+NOK8GbVm7
	 LwCISD43YQBnCtYmuTZi6wsnshMvXLeIKHVVsQKx14rCVH7U7qqoCZvd3I5Qx1OUWKC+r
	 DpSU1FShJYY8ZJvKIWjUFnxGQrujskANs3dmTpTUF1BD7yOui7+DxmR3HwajC9GwClDAk
	 clNHE/Q7adn86EIuGrWX/4BxfGokg2AvQSzVMVPsURViIUXjBvjxrbE1z4PnKdqsGLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=IRoq26Hz;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B0A606A32F
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 16:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87B0A606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=IRoq26Hz
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a05f2d5cd3so63727b3a.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 09:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1793118517; x=1793723317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NZYABka5j4ImZ7EGIuGf6YSfl1wz5MVEavRY8ItyrIo=;
        b=IRoq26HzyUZgssMqOsJquZe/X13GmKaG5oEwsrBBAA1byoZp5IIcEmHmPrFFUggnV6
         jqnxZwJGhTRTNaDvekPxWsK/G0qF6oDXQBx5d4WW2FO9+19N60QeBg/pZPJYJ62iop0J
         6/SQ4Vt1sYRHKKFDOUKJJZNQevbQvII+hLo4ZinAIWdjB2pvjQdGooI+x38NElZn/cB3
         0h0pNWzlMIVY8ItakqYW4FvioQ6pZ6xqAqwOV69OsUS+0Zi9VRCd6HDIoyqZKK7EPKw+
         v/QKiuE5DdEc2YuzaXJrvCeh3OU8M3aQcBLg5MTJYpjoeR4AelNn5ePSEcmyuR2Pmwox
         NFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793118517; x=1793723317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NZYABka5j4ImZ7EGIuGf6YSfl1wz5MVEavRY8ItyrIo=;
        b=SfAZiG5ImmfG2VkTd56adRl4M4A4jV5qR2PmfLmu4jn1b5YKRYVDYBCkBxGbeBS5oU
         wVSal2UGRqtOQAoj36whp0nN2/hMqumkgPPnwmevlrTG+76sOhf5I5OrrTgLoqyxbt3I
         eAPYxj/aVK64oNS1aEaMou1rcjUX58SaGSUbnXlMqmj7cus0wHi73pim+r8iEf8OZOmM
         V/etgSgGX5TFt7opR4wl8hnUVOzZ1pXks+gF6HeQU3oW9bmUC2lma5KDQ3bamErPxFmF
         S4w8pRsdOAgJA5QcxaU46Enbkhd1BOzAhja/DQnyZyBzOLuuAOogG044Gzau0Y1xKSsn
         4oeg==
X-Gm-Message-State: AFq9FYLoVRjptJr1+OHjXRSZLupoDtlmhyIS1S5kB1iL+6x+p1FlUmX5
	D4/qy+oy9P4MwsFF52xVshvU+Lj35KTgVcfAwyfk2MUzU/Sn6B4aMRbQ4Xm5BBb3UG9aXFyCiWW
	z7x2pYg4=
X-Gm-Gg: AYBFou24v4adPTrnhv/D+vzhTlYJve3vFq9WHJAxxDEiB+qYJ6jwZdckDPzviWpi2Q4
	/cMHkmv3RWUfu+5gdGZav4QxoM3W7rg6FL7j2EeJE8S9lOXPf//chUButsM0o8dTvcEBU85m9hS
	e5CBDPLMwoWBYr2JzklT+j1NXAIneb8SuNDc56XJDF3/Z09BvdluypC3Ee/6imcHrttyQYuDhYY
	WkEkCcxO+o044rDbl7G9QBq8Qxhiw95uPHKGLh2K737ouwY4fhHGZbG+DAYJG0+j5z0sCUbJ7PB
	9E0gIaCQl+FpnKymo7vW8xLDguX0Z13SO4INYpSENFS9cR6AiF7ypBkNYsmeyZgJFnJwA6uf+yL
	jSBgZuae8UPvMn22K/3xSFajZ+nFsv7QSHKsY1z+AFTtTHttIIVo6BOYf4vSXS4vOn/G6JSwFzO
	8qMXN3AXXpp9tvD8VB0s+p2qveHpUedyZG4GCT1JLmiS0zrJVVnxXxUOrKId8ZFz3EJFBm9Bai1
	c4ciiZJj0Ttx5Htt0WSAnYaFohBknildwkrLpiYopmfYvZX7jN7W+WUaV4oYekwKiO2qV2Ph3/o
	OT0oSeXc48NsdYJTtw==
X-Received: by 2002:a05:6a21:1f81:b0:3e2:1418:aae8 with SMTP id adf61e73a8af0-3e7cd4d7949mr7380663637.72.1793118516876;
        Tue, 27 Oct 2026 09:28:36 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a662c913sm257286b3a.31.2026.10.27.09.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:28:36 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next 5/7] selftests/bpf: Test local IRQ kfunc inlining
Date: Tue, 27 Oct 2026 16:28:18 +0000
Message-ID: <20261027162820.10887-6-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027162820.10887-1-emil@etsalapatis.com>
References: <20261027162820.10887-1-emil@etsalapatis.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that userspace cannot submit the kernel-private IRQ save and
restore opcodes directly.

Add nested IRQ save/restore tests in the main program and across a BPF
subprogram call. Inspect translated instructions for the expected
operation counts, flags register and reserved fields. Check the native
x86-64 or arm64 instruction sequences when inlining is enabled, and the
kfunc fallback when the kernel configuration disables it.

Run the JIT tests with hardening enabled and restore the original sysctl
setting afterwards. The selftests are discovered automatically by the
existing build rules.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../selftests/bpf/prog_tests/irq_jit.c        | 128 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/irq.c       |  24 ++++
 tools/testing/selftests/bpf/progs/irq_jit.c   |  55 ++++++++
 3 files changed, 207 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/irq_jit.c
 create mode 100644 tools/testing/selftests/bpf/progs/irq_jit.c

diff --git a/tools/testing/selftests/bpf/prog_tests/irq_jit.c b/tools/testing/selftests/bpf/prog_tests/irq_jit.c
new file mode 100644
index 000000000000..3d5dc3c77edb
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/irq_jit.c
@@ -0,0 +1,128 @@
+#include <test_progs.h>
+#include <network_helpers.h>
+#include <sysctl_helpers.h>
+#include "irq_jit.skel.h"
+
+static void check_irq_native(int prog_fd, __u32 jited_len)
+{
+#if defined(__x86_64__)
+	static const __u8 save[] = { 0x9c, 0x41, 0x5a, 0xfa, 0x4c, 0x89, 0x17 };
+	static const __u8 restore[] = {
+		0x4c, 0x8b, 0x17, 0x49, 0xf7, 0xc2, 0x00, 0x02, 0x00, 0x00, 0x74, 0x01, 0xfb,
+	};
+#elif defined(__aarch64__)
+	static const __u8 save[] = { 0xdf, 0x43, 0x03, 0xd5 };
+	static const __u8 restore[] = { 0x0a, 0x00, 0x40, 0xf9, 0x2a, 0x42, 0x1b, 0xd5 };
+	static const __u8 pmr_save[] = { 0x0b, 0x46, 0x18, 0xd5 };
+	static const __u8 pmr_restore[] = { 0x0a, 0x00, 0x40, 0xf9, 0x0a, 0x46, 0x18, 0xd5 };
+#else
+	return;
+#endif
+#if defined(__x86_64__) || defined(__aarch64__)
+	struct bpf_prog_info info = {};
+	__u32 info_len = sizeof(info);
+	__u8 *image;
+	int err;
+
+	if (!ASSERT_GT(jited_len, 0, "jited_len"))
+		return;
+	image = malloc(jited_len);
+	if (!ASSERT_OK_PTR(image, "jited_image"))
+		return;
+	info.jited_prog_len = jited_len;
+	info.jited_prog_insns = ptr_to_u64(image);
+	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
+	if (!ASSERT_OK(err, "jited_prog_info"))
+		goto out;
+#if defined(__x86_64__)
+	ASSERT_TRUE(memmem(image, jited_len, save, sizeof(save)), "native_irq_save");
+	ASSERT_TRUE(memmem(image, jited_len, restore, sizeof(restore)), "native_irq_restore");
+#else
+	ASSERT_TRUE(memmem(image, jited_len, save, sizeof(save)) ||
+		    memmem(image, jited_len, pmr_save, sizeof(pmr_save)), "native_irq_save");
+	ASSERT_TRUE(memmem(image, jited_len, restore, sizeof(restore)) ||
+		    memmem(image, jited_len, pmr_restore, sizeof(pmr_restore)), "native_irq_restore");
+#endif
+out:
+	free(image);
+#endif
+}
+
+static void check_irq_insns(int prog_fd, bool expect_inline)
+{
+	struct bpf_prog_info info = {};
+	__u32 info_len = sizeof(info);
+	struct bpf_insn *insns;
+	__u32 xlated_len;
+	int save_count = 0, restore_count = 0;
+	int err;
+
+	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
+	if (!ASSERT_OK(err, "prog_info"))
+		return;
+	xlated_len = info.xlated_prog_len;
+	insns = malloc(xlated_len);
+	if (!ASSERT_OK_PTR(insns, "xlated_insns"))
+		return;
+	memset(&info, 0, sizeof(info));
+	info.xlated_prog_len = xlated_len;
+	info.xlated_prog_insns = ptr_to_u64(insns);
+	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
+	if (!ASSERT_OK(err, "xlated_prog_info"))
+		goto out;
+	for (size_t insn_idx = 0; insn_idx < info.xlated_prog_len / sizeof(*insns); insn_idx++) {
+		struct bpf_insn *insn = &insns[insn_idx];
+
+		if (insn->code != (BPF_ST | 0xe0))
+			continue;
+		ASSERT_EQ((__u32)insn->dst_reg, BPF_REG_1, "flags_reg");
+		ASSERT_EQ((__u32)insn->src_reg, 0, "reserved_src_reg");
+		ASSERT_EQ(insn->off, 0, "reserved_off");
+		if (insn->imm == 0)
+			save_count++;
+		else if (insn->imm == 1)
+			restore_count++;
+		else
+			ASSERT_FAIL("unexpected IRQ operation %d", insn->imm);
+	}
+	ASSERT_EQ(save_count, expect_inline ? 2 : 0, "save_count");
+	ASSERT_EQ(restore_count, expect_inline ? 2 : 0, "restore_count");
+	if (expect_inline)
+		check_irq_native(prog_fd, info.jited_prog_len);
+out:
+	free(insns);
+}
+
+void test_irq_jit(void)
+{
+	struct irq_jit *skel;
+	const char *harden = "/proc/sys/net/core/bpf_jit_harden";
+	char old_harden[32];
+	int err;
+
+	if (sysctl_set_or_fail(harden, old_harden, "2"))
+		return;
+	skel = irq_jit__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "irq_jit_open_and_load"))
+		goto restore_harden;
+	for (int prog_idx = 0; prog_idx < 2; prog_idx++) {
+		struct bpf_program *prog = prog_idx ? skel->progs.irq_jit_subprog :
+						    skel->progs.irq_jit_basic;
+		LIBBPF_OPTS(bpf_test_run_opts, opts,
+			.data_in = &pkt_v4,
+			.data_size_in = sizeof(pkt_v4),
+			.repeat = 16,
+		);
+
+		if (!test__start_subtest(bpf_program__name(prog)))
+			continue;
+		err = bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
+		if (!ASSERT_OK(err, "test_run"))
+			continue;
+		ASSERT_LE(opts.retval, 1, "test_retval");
+		check_irq_insns(bpf_program__fd(prog), opts.retval == 0);
+	}
+	irq_jit__destroy(skel);
+restore_harden:
+	sysctl_set_or_fail(harden, NULL, old_harden);
+}
diff --git a/tools/testing/selftests/bpf/progs/irq.c b/tools/testing/selftests/bpf/progs/irq.c
index 50727fa9b11d..ffb74d3c55c0 100644
--- a/tools/testing/selftests/bpf/progs/irq.c
+++ b/tools/testing/selftests/bpf/progs/irq.c
@@ -11,6 +11,30 @@ extern void bpf_local_irq_save(unsigned long *) __weak __ksym;
 extern void bpf_local_irq_restore(unsigned long *) __weak __ksym;
 extern int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void *unsafe_ptr__ign, u64 flags) __weak __ksym;
 
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+#define IRQ_FLAGS_REG_BYTE 0x01
+#else
+#define IRQ_FLAGS_REG_BYTE 0x10
+#endif
+
+SEC("?tc")
+__failure __msg("unknown opcode e2")
+__naked void irq_internal_save_rejected(void)
+{
+	asm volatile (".byte 0xe2, %[flags_reg]; .short 0; .long 0; r0 = 0; exit;"
+		      : : __imm_const(flags_reg, IRQ_FLAGS_REG_BYTE)
+		      : __clobber_all);
+}
+
+SEC("?tc")
+__failure __msg("unknown opcode e2")
+__naked void irq_internal_restore_rejected(void)
+{
+	asm volatile (".byte 0xe2, %[flags_reg]; .short 0; .long 1; r0 = 0; exit;"
+		      : : __imm_const(flags_reg, IRQ_FLAGS_REG_BYTE)
+		      : __clobber_all);
+}
+
 struct bpf_res_spin_lock lockA __hidden SEC(".data.A");
 struct bpf_res_spin_lock lockB __hidden SEC(".data.B");
 
diff --git a/tools/testing/selftests/bpf/progs/irq_jit.c b/tools/testing/selftests/bpf/progs/irq_jit.c
new file mode 100644
index 000000000000..45834448333b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/irq_jit.c
@@ -0,0 +1,55 @@
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+extern void bpf_local_irq_save(unsigned long *) __ksym;
+extern void bpf_local_irq_restore(unsigned long *) __ksym;
+extern bool CONFIG_TRACE_IRQFLAGS __kconfig __weak;
+extern bool CONFIG_PARAVIRT_XXL __kconfig __weak;
+extern bool CONFIG_ARM64_DEBUG_PRIORITY_MASKING __kconfig __weak;
+
+static __always_inline int irq_jit_result(void)
+{
+	bool fallback = CONFIG_TRACE_IRQFLAGS;
+
+#if defined(__TARGET_ARCH_x86)
+	fallback |= CONFIG_PARAVIRT_XXL;
+#elif defined(__TARGET_ARCH_arm64)
+	fallback |= CONFIG_ARM64_DEBUG_PRIORITY_MASKING;
+#else
+	fallback = true;
+#endif
+	return fallback;
+}
+
+SEC("tc")
+int irq_jit_basic(struct __sk_buff *ctx)
+{
+	unsigned long outer_flags, inner_flags;
+
+	bpf_local_irq_save(&outer_flags);
+	bpf_local_irq_save(&inner_flags);
+	bpf_local_irq_restore(&inner_flags);
+	bpf_local_irq_restore(&outer_flags);
+	return ctx->len ? irq_jit_result() : 2;
+}
+
+static __noinline void irq_jit_nested(void)
+{
+	unsigned long flags;
+
+	bpf_local_irq_save(&flags);
+	bpf_local_irq_restore(&flags);
+}
+
+SEC("tc")
+int irq_jit_subprog(struct __sk_buff *ctx)
+{
+	unsigned long flags;
+
+	bpf_local_irq_save(&flags);
+	irq_jit_nested();
+	bpf_local_irq_restore(&flags);
+	return ctx->len ? irq_jit_result() : 2;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.52.0


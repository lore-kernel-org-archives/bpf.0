Received: from mta0.migadu.com (out-48.mta0.migadu.com [91.218.175.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2B5EEB3
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 00:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787616795; cv=none; b=F8kU/CnAuvkD00rtwEuKA9F2lct4yh2cu+ZUBt2Ptd5EhfyUZhbThS0ncf94PTMvL2jdZWW+qGTe9NqtwwKWVIxH+fH41KW72thFs65nqS52fNzVgGLV164GswF0k6x4e6+uama4XdKU9kk39+J1PrRv7koTirhgizi9Ha2JJwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787616795; c=relaxed/simple;
	bh=f9qG1bMVWhb5KSslSocg1dwy/aeSjv0KZLGcHBO1/uI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lf+soerf9BMpXnGzi3gLiexm/BEXkvm+T6c99qtI7gYTGD3frxDNGogo+dnPAm7zAKG2L74Ru9keiX1jW2/WKVy2ZWvjUcQhoUOwZFtTt8P0cdrT3L3wMW1kKgr9BkFcc54NxN9bS1fZK6haXBFvGwTLKGEu2wq6nbcEaCBIl+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eVl40Umx; arc=none smtp.client-ip=91.218.175.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eVl40Umx"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=f9qG1bMVWhb5KSslSocg1dwy/aeSjv0KZLGcHBO1/uI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787616787; v=1; x=1788221587;
 b=eVl40UmxTbDecXSnP/hd86QF1SuDKInxswHBRuI9KByI4JQuySzPUfNVUN+g/apiY/nOo6eg
 TzxRit0dW4o6drEIewjvec88gdPyPUS6Nf7iLzj9GBXVovMlMDin/OHVS04z7g3ou4lUXONca54
 Pc9lAKMK8rcRmCLvhRbk3iSI=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:125c:1:cef:bdf9:9d01:faef] (2620:10d:c090:500::7:8921)
	by smtp.migadu.com with ESMTPS id b49edbb2b77230b7;
	Tue, 25 Aug 2026 00:12:57 +0000
X-Mizu-Trace-ID: b49edbb2b77230b7
X-Migadu-Flow: FLOW_OUT
Message-ID: <fa7cc4ad-6b8d-4bdf-8e2c-66d98ddef7df@linux.dev>
Date: Mon, 24 Aug 2026 17:12:49 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 4/9] bpf, x86: emit KASAN checks in x86 JITed
 programs
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 sashiko-reviews@lists.linux.dev,
 =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
References: <20260822-kasan-v7-0-99afee6ef7fd@bootlin.com>
 <20260822-kasan-v7-4-99afee6ef7fd@bootlin.com>
 <20260821233332.1D2201F00A3A@smtp.kernel.org>
 <DKWOG6YKM2NY.1FJHLE7BKZW9Y@gmail.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <DKWOG6YKM2NY.1FJHLE7BKZW9Y@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/23/26 3:30 PM, Kumar Kartikeya Dwivedi wrote:
> On Sat Aug 22, 2026 at 1:33 AM CEST, sashiko-bot wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [High] `emit_kasan_check` fails to save the caller-saved register %r10 (BPF_REG_AX), which corrupts BPF_REG_0 and memory pointers during atomic fetch operations.
>> --
>>
>> --- Patch [4]: [PATCH bpf-next v7 4/9] bpf, x86: emit KASAN checks in x86 JITed programs ---
>> commit 6bca50db6e9af9416363fe2e60f4e42f924950c9
>> Author: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
>>
>> bpf, x86: emit KASAN checks in x86 JITed programs
>>
>> Insert KASAN shadow memory checks before memory load and store
>> operations in JIT-compiled BPF programs. This helps detect memory safety
>> bugs such as use-after-free and out-of-bounds accesses at runtime.
>>
>>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>>> index 13ba3232993ac..8134d028a2f2c 100644
>>> --- a/arch/x86/net/bpf_jit_comp.c
>>> +++ b/arch/x86/net/bpf_jit_comp.c
>>
>> [ ... ]
>>
>>> @@ -1110,6 +1121,92 @@ static void maybe_emit_1mod(u8 **pprog, u32 reg, bool is64)
>>>  	*pprog = prog;
>>>  }
>>>
>>> +static int emit_kasan_check(struct bpf_verifier_env *env, u8 **pprog,
>>> +			    u32 addr_reg, struct bpf_insn *insn, u8 *ip,
>>> +			    bool is_write)
>>> +{
>>> +#ifdef CONFIG_BPF_JIT_KASAN
>>> +	u32 bpf_size = BPF_SIZE(insn->code);
>>> +	s32 off = insn->off;
>>> +	u8 *prog = *pprog;
>>> +	void *kasan_func;
>>> +
>>> +	if (!env)
>>> +		return 0;
>>> +
>>> +	/* Derive KASAN check function from access type and size */
>>> +	switch (bpf_size) {
>>> +	case BPF_B:
>>> +		kasan_func = is_write ? __asan_store1 : __asan_load1;
>>> +		break;
>>> +	case BPF_H:
>>> +		kasan_func = is_write ? __asan_store2 : __asan_load2;
>>> +		break;
>>> +	case BPF_W:
>>> +		kasan_func = is_write ? __asan_store4 : __asan_load4;
>>> +		break;
>>> +	case BPF_DW:
>>> +		kasan_func = is_write ? __asan_store8 : __asan_load8;
>>> +		break;
>>> +	default:
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	/* Save rax */
>>> +	EMIT1(0x50);
>>> +	/* Save rcx */
>>> +	EMIT1(0x51);
>>> +	/* Save rdx */
>>> +	EMIT1(0x52);
>>> +	/* Save rsi */
>>> +	EMIT1(0x56);
>>> +	/* Save rdi */
>>> +	EMIT1(0x57);
>>> +	/* Save r8 */
>>> +	EMIT2(0x41, 0x50);
>>> +	/* Save r9 */
>>> +	EMIT2(0x41, 0x51);
>>> +	/*
>>> +	 * SystemV ABI states that we should also save r10/r11, but in
>>> +	 * practice those registers are _not_ used by the limited set of
>>> +	 * kasan helpers we are calling here, so that's fine not to save those.
>>> +	 */
>>> +
>>> +	/* mov rdi, addr_reg */
>>
>> [Severity: High]
>> Is it safe to skip saving %r10 and %r11 here?
>>
>> In the x86 BPF JIT, %r10 is mapped to BPF_REG_AX. During atomic fetch
>> operations, BPF_REG_0 is stashed into BPF_REG_AX before calling
>> emit_kasan_check():
>>
>> arch/x86/net/bpf_jit_comp.c:do_jit() {
>>     ...
>>     /* Will need RAX as a CMPXCHG operand so save R0 */
>>     emit_mov_reg(&prog, true, BPF_REG_AX, BPF_REG_0);
>>     if (src_reg == BPF_REG_0)
>>         real_src_reg = BPF_REG_AX;
>>     if (dst_reg == BPF_REG_0)
>>         real_dst_reg = BPF_REG_AX;
>>
>>     if (!bpf_atomic_is_load_store(insn)) {
>>         if (!accesses_stack_only) {
>>             err = emit_kasan_check(env, &prog, real_dst_reg, insn, ip, true);
>>     ...
>> }
>>
>> Since the KASAN helpers are standard C functions, they are permitted by the
>> System V AMD64 ABI to clobber caller-saved registers like %r10 (especially if
>> kasan_report is called).
>>
>> If %r10 is clobbered, could this corrupt the stashed BPF_REG_0 and potentially
>> cause a crash when real_dst_reg is used as a memory pointer in the subsequent
>> emit_ldx() call?
>>
>> arch/x86/net/bpf_jit_comp.c:do_jit() {
>>     ...
>>     /* Load old value */
>>     emit_ldx(&prog, BPF_SIZE(insn->code), BPF_REG_0, real_dst_reg, insn->off);
>>     ...
>>     /* Restore R0 after clobbering RAX */
>>     emit_mov_reg(&prog, true, BPF_REG_0, BPF_REG_AX);
>>     ...
>> }
> 
> This looks like a real bug, R10 is used for both atomics and constant blinding.
> We probably also should save R11.


Hi Kumar, Alexis.

This topic has a bit of history now [1][2].
I don't quite like it, but IMO we should give in to the bots.

Reasons to save r10 and r11:
* SystemV ABI
* bots wouldn't shut up about it (think of future llm bot reports!)
* if our analysis of the kasan helpers is wrong about r10/r11 usage OR
  if something changes (the helpers themselves, the compilers, build
  flags, JIT's usage of r10/r11 etc.) - we'll get clobbered regs

Reasons to *not* save r10 and r11:
* we make the bpf prog a bit smaller and faster, the win is not very
  clear but it's percentages, not a factor

A counter-argument to clobbering is that a kasan bug here most likely
means a bug in the verifier, so it doesn't matter if machine dies.

A counter-argument to that would be: why deliberately increase the bug
surface and let the machine die if we can easily prevent it?

Pasting below a clobbering reproducer from my clanker.

[1] https://lore.kernel.org/all/5f38c9a5-a8a3-4bed-bb8c-b7260a1c1a11@linux.dev/
[2] https://lore.kernel.org/all/CAADnVQ+c9h_wuNwj8pjx885oNErGY7bxxCwKi+DiJ0XKSpyYfg@mail.gmail.com/


diff --git a/tools/testing/selftests/bpf/prog_tests/kasan.c b/tools/testing/selftests/bpf/prog_tests/kasan.c
index 2b424767a0f3..160445395ddc 100644
--- a/tools/testing/selftests/bpf/prog_tests/kasan.c
+++ b/tools/testing/selftests/bpf/prog_tests/kasan.c
@@ -309,6 +309,149 @@ static void run_blinding_subtest(void)
 	free(ctx);
 }
 
+/*
+ * Value-integrity subtests.
+ *
+ * The suite above only checks that a KASAN report was emitted. A report is not
+ * fatal here (the kernel runs with kasan_multi_shot and panic_on_warn=0), so
+ * the program keeps executing afterwards and its state must be intact. These
+ * two subtests check the two places where the JIT keeps live BPF state in
+ * BPF_REG_AX (x86 r10) across the injected __asan_* call.
+ */
+#define R0_SENTINEL	0x5EEDFACE
+#define ST_SENTINEL	0x0B0BCAFE
+
+static void run_atomic_fetch_integrity_subtest(struct test_ctx *ctx,
+					       struct kasan *skel)
+{
+	struct test_spec spec = {
+		.prog_type = "atomic_fetch_r0_integrity",
+		.is_write = true,
+	};
+
+	if (!test__start_subtest("atomic_fetch_r0_integrity"))
+		return;
+
+	strncpy(ctx->prog_name, "atomic_fetch_r0_integrity", PROG_NAME_MAX_LEN);
+
+	/*
+	 * Control run: same instruction, same instrumentation, unpoisoned
+	 * target. No report, so nothing may be disturbed. If this one fails,
+	 * the test itself is wrong.
+	 */
+	skel->data->poison_target = false;
+	skel->bss->r0_after_atomic = 0;
+	spec.expect_no_report = true;
+	exec_subtest(ctx, &spec, 8, false);
+	ASSERT_EQ(skel->bss->r0_after_atomic, R0_SENTINEL,
+		  "control: r0 preserved when no report fires");
+
+	skel->data->poison_target = true;
+	skel->bss->r0_after_atomic = 0;
+	spec.expect_no_report = false;
+
+	/* Asserts that the report fired: the check must have been emitted. */
+	exec_subtest(ctx, &spec, 8, false);
+
+	/*
+	 * ... and that returning from it left r0 alone. The JIT saves r0 into
+	 * BPF_REG_AX before the CMPXCHG loop and restores it after, with the
+	 * KASAN check in between.
+	 */
+	ASSERT_EQ(skel->bss->r0_after_atomic, R0_SENTINEL,
+		  "r0 preserved across a KASAN report in a fetch atomic");
+}
+
+static void run_atomic_fetch_addr_subtest(struct test_ctx *ctx,
+					  struct kasan *skel)
+{
+	struct test_spec spec = {
+		.prog_type = "atomic_fetch_r0_addr",
+		.is_write = true,
+	};
+
+	if (!test__start_subtest("atomic_fetch_r0_addr"))
+		return;
+
+	strncpy(ctx->prog_name, "atomic_fetch_r0_addr", PROG_NAME_MAX_LEN);
+	exec_subtest(ctx, &spec, 8, false);
+
+	ASSERT_EQ(skel->bss->r0_addr_after, skel->bss->r0_addr_ref,
+		  "r10 (used as the atomic base address) preserved");
+}
+
+static void run_atomic_fetch_oob_c_subtest(struct test_ctx *ctx)
+{
+	struct test_spec spec = {
+		.prog_type = "atomic_fetch_oob_c",
+		.is_write = true,
+	};
+
+	if (!test__start_subtest("atomic_fetch_oob_c"))
+		return;
+
+	strncpy(ctx->prog_name, "atomic_fetch_oob_c", PROG_NAME_MAX_LEN);
+	exec_subtest(ctx, &spec, 8, false);
+}
+
+static void run_blinding_integrity_subtest(void)
+{
+	struct test_spec spec = {
+		.prog_type = "st_blinded_integrity",
+		.is_write = true,
+	};
+	char bpf_jit_harden = '2';
+	struct kasan_write_val val;
+	struct kasan_harden *skel;
+	struct test_ctx *ctx;
+	__u32 key = 0;
+	int ret;
+
+	if (!test__start_subtest("st_blinded_integrity"))
+		return;
+
+	ctx = calloc(1, sizeof(*ctx));
+	if (!ASSERT_OK_PTR(ctx, "alloc blinding ctx"))
+		return;
+	ctx->klog_fd = -1;
+
+	ret = set_bpf_jit_harden(&bpf_jit_harden);
+	if (!ASSERT_OK(ret, "set bpf_jit_harden"))
+		goto free_ctx;
+
+	skel = kasan_harden__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open and load blinded prog"))
+		goto restore;
+
+	ctx->klog_fd = open_kernel_logs();
+	if (!ASSERT_OK_FD(ctx->klog_fd, "open kernel logs"))
+		goto destroy;
+
+	ctx->obj = skel->obj;
+	strncpy(ctx->prog_name, "st_blinded_integrity", PROG_NAME_MAX_LEN);
+
+	/* Asserts that the report fired. */
+	exec_subtest(ctx, &spec, 8, false);
+
+	/* ... and that the blinded store still wrote the right value. */
+	ret = bpf_map__lookup_elem(skel->maps.test_map, &key, sizeof(key),
+				   &val, sizeof(val), 0);
+	if (!ASSERT_OK(ret, "read back blinded store target"))
+		goto close_klog;
+	ASSERT_EQ(val.data_8, ST_SENTINEL,
+		  "blinded store value preserved across a KASAN report");
+
+close_klog:
+	close(ctx->klog_fd);
+destroy:
+	kasan_harden__destroy(skel);
+restore:
+	ASSERT_OK(set_bpf_jit_harden(&bpf_jit_harden),
+		  "restore hardening configuration");
+free_ctx:
+	free(ctx);
+}
+
 static struct test_spec tests[] = {
 	{
 		.prog_type = "st",
@@ -439,11 +582,16 @@ void test_kasan(void)
 		run_subtest(ctx, test);
 	}
 
+	run_atomic_fetch_integrity_subtest(ctx, skel);
+	run_atomic_fetch_addr_subtest(ctx, skel);
+	run_atomic_fetch_oob_c_subtest(ctx);
+
 	/*
 	 * Blinding subtest is handled differently as it needs the
 	 * corresponding program to be loaded with bpf_jit_harden raised
 	 */
 	run_blinding_subtest();
+	run_blinding_integrity_subtest();
 
 close:
 	close(ctx->klog_fd);
diff --git a/tools/testing/selftests/bpf/progs/kasan.c b/tools/testing/selftests/bpf/progs/kasan.c
index ea29197646b0..68a041f14353 100644
--- a/tools/testing/selftests/bpf/progs/kasan.c
+++ b/tools/testing/selftests/bpf/progs/kasan.c
@@ -459,4 +459,111 @@ int ldx_oob(struct __sk_buff *skb)
 	return tmp.data_1;
 }
 
+/*
+ * Value-integrity tests: a KASAN report must not change what the program
+ * computes. The kernel keeps running after a report under kasan_multi_shot,
+ * so every register the JIT holds live across the injected __asan_* call must
+ * come back unchanged.
+ */
+#define R0_SENTINEL	0x5EEDFACE
+
+/*
+ * The JIT lowers an RMW fetch atomic into a CMPXCHG loop and needs RAX as the
+ * CMPXCHG operand, so it stashes BPF r0 into BPF_REG_AX (x86 r10) before the
+ * loop and restores it afterwards. The KASAN check sits between the two, so
+ * r10 holds live BPF state across the call.
+ *
+ * Keep a sentinel in r0 across the atomic and publish it afterwards: if the
+ * check clobbers r10, the restored r0 is garbage.
+ */
+__u64 r0_after_atomic = 0;
+/* Cleared by the control run, which must not produce a report at all. */
+bool poison_target = true;
+
+SEC("tcx/ingress")
+int atomic_fetch_r0_integrity(struct __sk_buff *skb)
+{
+	struct kasan_test_val *val;
+	__u32 key = 0;
+
+	val = bpf_map_lookup_elem(&test_map, &key);
+	if (!val)
+		return 0;
+
+	if (poison_target)
+		bpf_kfunc_kasan_poison(val, sizeof(struct kasan_test_val));
+	asm volatile ("r0 = %[sentinel];"
+		      "r1 = 8;"
+		      "r1 = atomic_fetch_or((u64 *)(%[val] + 8), r1);"
+		      "*(u64 *)(%[out] + 0) = r0;"
+		      :
+		      : [val] "r" (val), [out] "r" (&r0_after_atomic),
+			[sentinel] "i" (R0_SENTINEL)
+		      : "r0", "r1", "memory");
+	if (poison_target)
+		bpf_kfunc_kasan_unpoison(val, sizeof(struct kasan_test_val));
+
+	return 0;
+}
+
+/*
+ * Same lowering, but with the target pointer in r0. The JIT then uses
+ * BPF_REG_AX as real_dst_reg, i.e. r10 is not merely holding a value across
+ * the KASAN check - it is the base address of the ldx and of the locked
+ * cmpxchg that follow it.
+ */
+__u64 r0_addr_after = 0;
+__u64 r0_addr_ref = 0;
+
+SEC("tcx/ingress")
+int atomic_fetch_r0_addr(struct __sk_buff *skb)
+{
+	struct kasan_test_val *val;
+	__u32 key = 0;
+
+	val = bpf_map_lookup_elem(&test_map, &key);
+	if (!val)
+		return 0;
+
+	bpf_kfunc_kasan_poison(val, sizeof(struct kasan_test_val));
+	asm volatile ("r0 = %[val];"
+		      "r1 = 8;"
+		      "r1 = atomic_fetch_or((u64 *)(r0 + 8), r1);"
+		      "*(u64 *)(%[out] + 0) = r0;"
+		      "*(u64 *)(%[ref] + 0) = %[val];"
+		      :
+		      : [val] "r" (val), [out] "r" (&r0_addr_after),
+			[ref] "r" (&r0_addr_ref)
+		      : "r0", "r1", "memory");
+	bpf_kfunc_kasan_unpoison(val, sizeof(struct kasan_test_val));
+
+	return 0;
+}
+
+/*
+ * Plain C, no asm: the second lookup returns the map value pointer in r0 and
+ * the compiler leaves it there for the fetch atomic, so the JIT uses
+ * BPF_REG_AX (r10) as the base address of the post-check ldx and cmpxchg.
+ */
+SEC("tcx/ingress")
+int atomic_fetch_oob_c(struct __sk_buff *skb)
+{
+	struct kasan_test_val *val, *val2;
+	__u32 key = 0;
+
+	val = bpf_map_lookup_elem(&test_map, &key);
+	if (!val)
+		return 0;
+
+	bpf_kfunc_kasan_poison(val, sizeof(struct kasan_test_val));
+
+	val2 = bpf_map_lookup_elem(&test_map, &key);
+	if (!val2)
+		return 0;
+	__sync_fetch_and_or(&val2->data_8, 8);
+
+	bpf_kfunc_kasan_unpoison(val, sizeof(struct kasan_test_val));
+	return 0;
+}
+
 char LICENSE[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/kasan_harden.c b/tools/testing/selftests/bpf/progs/kasan_harden.c
index a2756bbfd529..9172a1017a8e 100644
--- a/tools/testing/selftests/bpf/progs/kasan_harden.c
+++ b/tools/testing/selftests/bpf/progs/kasan_harden.c
@@ -38,4 +38,36 @@ int st_blinded(struct __sk_buff *skb)
 	return 0;
 }
 
+/*
+ * Constant blinding lowers a BPF_ST_MEM into
+ *   BPF_REG_AX = imm ^ rnd; BPF_REG_AX ^= rnd; *(dst + off) = BPF_REG_AX
+ * and the JIT emits the KASAN check before that store, so BPF_REG_AX (x86 r10)
+ * holds the value to be written across the __asan_* call.
+ *
+ * Written in asm to guarantee a raw BPF_ST opcode regardless of -mcpu: at
+ * -mcpu=v3 clang lowers an immediate store to MOV+STX, which is not blinded
+ * through BPF_REG_AX and does not exercise this path.
+ */
+#define ST_SENTINEL	0x0B0BCAFE
+
+SEC("tcx/ingress")
+int st_blinded_integrity(struct __sk_buff *skb)
+{
+	struct kasan_test_val *val;
+	__u32 key = 0;
+
+	val = bpf_map_lookup_elem(&test_map, &key);
+	if (!val)
+		return 0;
+
+	bpf_kfunc_kasan_poison(val, sizeof(struct kasan_test_val));
+	asm volatile ("*(u64 *)(%[val] + 8) = %[sentinel];"
+		      :
+		      : [val] "r" (val), [sentinel] "i" (ST_SENTINEL)
+		      : "memory");
+	bpf_kfunc_kasan_unpoison(val, sizeof(struct kasan_test_val));
+
+	return 0;
+}
+
 char LICENSE[] SEC("license") = "GPL";
-- 
2.53.0-Meta



Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506A732B103
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728834; cv=none; b=DQglEGOzxnUDknSHi1BIlXFjPln3QBhHgv2F4WRSXOs0RxT0D9pR/tVbsnC9rYWpmAfRmKB2rC04RoxTfzViJgHKYFhljNXr9jouUYwYFmcDH5EiDbulwcnLQKOzkD3hVQyLncPpoHIGSlGpYh/pSdclmvtN3H6m6ongGn+frU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728834; c=relaxed/simple;
	bh=v29liR08HV268l93mu5RRNDkogQe6C7RQIhjB5TiQuY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q1QVcYyyJ934tViQNVu1M2TrkUsHh8tzvm3/DC9QKCeoGx/Dd/m52h7s4vhneMnpaWaHC8CFh12XouGWA1bmUVAj50mYrbHqv61G7LZrHON76vAWHMBLOfCKBOFue8URG2ihYMirVnURD0nLMkxXKd/pMd71WxvL5Gufng2Bte0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cxmi4Zkh; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cxmi4Zkh"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c999f162c9aso8160451a12.3
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 07:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784728833; x=1785333633; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1mcjtBnYim3GM1gk3lVV9pkUsUsu2bQG4ImpXHHwTGg=;
        b=Cxmi4ZkhvuQIAOWTUqugz2BQZSjYwUpVHZy7Tyny+9oxvXWWc3SFgLfbpD9FgPHldh
         DPS3Qm5izFmg+b6gQMepdlDb/lbzbACqA9e65vNhGDar4n8SbairQjSq7xjyTfnwutyp
         xncgfdVuXgP1a09ivNXP5SP02Hzy+bDmGAMaCJRFqwZotKYvsO7ERIv8027nFWXwlB6F
         JWtog6fF/PPyWCcyCsjAwtUPR1K6biqeutdSb8WXmMAZ/htrL2s8Wc6lns24BZTf9yRk
         WT8O9Xy8DaQas65w5tyrwEMzDSaxChQA2/s+cXblQBYuZ0y8PK/XEfLhF8YmL/+pOnSq
         OZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784728833; x=1785333633;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1mcjtBnYim3GM1gk3lVV9pkUsUsu2bQG4ImpXHHwTGg=;
        b=NVxRfWgjvkn8uDQvazaoNDb1iPTh3BYdKyDtYZT5Zc4lv1pyisSEW1LhVJRlDrZpm+
         nJcKKqAkLTwfkFmwEtfkN0Prolafk9HIcww0T+Pzsugu4LvLLZV1Eh/Y2sJP25NuFhba
         yT1HZXBNkiISa9WpK+NCtGY12bLSrp1DmDnZHOgl9ntiKDq2Mi71TRdAXoyodUc/0kdY
         MuDVZfuZ99R5V2A+bxfoYKLUioGzXih/474qE64CzG/OCgoEeF+T1WA5hSJyeOFkDYDN
         jeAsHOnO00aJ3x/aXS7EsI0LABxZZme4hhg3mB9/fivkmo//hmfWYGtFSSa1DVaTDSD6
         lD6Q==
X-Forwarded-Encrypted: i=1; AHgh+RqU/0GoyCG4DY37ICNA2iHTAFmIHia0tP7pPmFhjJ4KcGx1MYUuTIxos5oVOG2YgeKypYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxtMrm71FVq1f2YzI+jETlMqSvp8I1hW3JY/ISkMOnXpKn/IeW
	UxAog2TZr3A8dILqO3IJMdIXRfXzrrLR1XMnFcDYUTpT2SGEW0BTcsAp
X-Gm-Gg: AR+sD12QaRNsh5SdUTXeE0iLE7HnWtO1RPIDy+VKyISyhH/U/NPoGXhkV7lMTQvOnwn
	6hngrg+/q0OYnfV/9mH1+FVzoLO1tK5j2UZurHt11n4jXF0mNFnJ2tnnpqX57r6ebm8GJMeSaFX
	b8dGFnV6NgAQUOn5HCYwRWxdwfJjkeyy/T0ZC317Tx5z4rfQ12t5jrwrAXjeFAoLMIFRLUbqnXU
	xqy3I5sNCnjNsaKMVL/VZmZW0xmTfKxNM6KT9TTdXzvwCx8fPeH5oIs4PWgijVmyUYL2CuKoNJc
	akKwINq/CzfzfCcMYPNg8hI8gA5E/WxYLNhdBT+d3Tfn+rAT3IVaEEjDeYkiEJAO/vU/tW6jU94
	ZfvHKYAten/pNxt2WmFO6+XQSBNptHSZQng9dQOyWratraED1YZEn8OO9FHuHGXutd10C14iBrm
	0+Wuw3Pa3H3Zpp1vXLdztIrY+AmAC7tIZVS9lkwqxJVk/d3Rw=
X-Received: by 2002:a05:6a20:eed0:10b0:3c4:14a3:fed4 with SMTP id adf61e73a8af0-3c414a442bcmr4588280637.55.1784728829637;
        Wed, 22 Jul 2026 07:00:29 -0700 (PDT)
Received: from computer.goose-salary.ts.net ([2a09:bac5:40b2:277d::3ef:c9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb8f1a8a1fsm1242281a12.26.2026.07.22.07.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 07:00:28 -0700 (PDT)
From: Varun R Mallya <varunrmallya@gmail.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	bjorn@kernel.org,
	pulehui@huawei.com
Cc: alex@ghiti.fr,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	puranjay@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	varunrmallya@gmail.com
Subject: [PATCH bpf-next v3 0/6] Add BPF Exceptions support for RISC-V
Date: Wed, 22 Jul 2026 19:30:07 +0530
Message-ID: <20260722140015.1982158-1-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset aims to add BPF exceptions supports for riscv64 by
implementing the arch_bpf_stack_walk function and then updating the
prologue and epilogue for BPF JIT on riscv. Also,
bpf_jit_supports_exceptions() returns true now so that the verifier does
not reject programs containing BPF exceptions on riscv64.

On riscv the unwinder used by arch_bpf_stack_walk() is the frame-pointer
unwinder, so exception support is gated on CONFIG_FRAME_POINTER.

In the prologue and epilogue of the RISC-V JIT, I saved the
return address and then the frame-pointer according to [1]. Also,
according to [2], s0 to s11 are callee saved registers, which is why a
new array (rv_exception_csave_regs) has been created to save these
registers which contains all the required registers along with the frame
pointer as well as return address.

The following demonstrates that all the selftests for BPF exceptions pass:
root@virtme-ng:~/bpf# ./test_progs -t exceptions
#114/1   exceptions/exception_throw_always_1:OK
#114/2   exceptions/exception_throw_always_2:OK
#114/3   exceptions/exception_throw_unwind_1:OK
#114/4   exceptions/exception_throw_unwind_2:OK
#114/5   exceptions/exception_throw_default:OK
#114/6   exceptions/exception_throw_default_value:OK
#114/7   exceptions/exception_tail_call:OK
#114/8   exceptions/exception_ext:OK
#114/9   exceptions/exception_ext_mod_cb_runtime:OK
#114/10  exceptions/exception_throw_subprog:OK
#114/11  exceptions/exception_assert_nz_gfunc:OK
#114/12  exceptions/exception_assert_zero_gfunc:OK
#114/13  exceptions/exception_assert_neg_gfunc:OK
#114/14  exceptions/exception_assert_pos_gfunc:OK
#114/15  exceptions/exception_assert_negeq_gfunc:OK
#114/16  exceptions/exception_assert_poseq_gfunc:OK
#114/17  exceptions/exception_assert_nz_gfunc_with:OK
#114/18  exceptions/exception_assert_zero_gfunc_with:OK
#114/19  exceptions/exception_assert_neg_gfunc_with:OK
#114/20  exceptions/exception_assert_pos_gfunc_with:OK
#114/21  exceptions/exception_assert_negeq_gfunc_with:OK
#114/22  exceptions/exception_assert_poseq_gfunc_with:OK
#114/23  exceptions/exception_bad_assert_nz_gfunc:OK
#114/24  exceptions/exception_bad_assert_zero_gfunc:OK
#114/25  exceptions/exception_bad_assert_neg_gfunc:OK
#114/26  exceptions/exception_bad_assert_pos_gfunc:OK
#114/27  exceptions/exception_bad_assert_negeq_gfunc:OK
#114/28  exceptions/exception_bad_assert_poseq_gfunc:OK
#114/29  exceptions/exception_bad_assert_nz_gfunc_with:OK
#114/30  exceptions/exception_bad_assert_zero_gfunc_with:OK
#114/31  exceptions/exception_bad_assert_neg_gfunc_with:OK
#114/32  exceptions/exception_bad_assert_pos_gfunc_with:OK
#114/33  exceptions/exception_bad_assert_negeq_gfunc_with:OK
#114/34  exceptions/exception_bad_assert_poseq_gfunc_with:OK
#114/35  exceptions/exception_assert_range:OK
#114/36  exceptions/exception_assert_range_with:OK
#114/37  exceptions/exception_bad_assert_range:OK
#114/38  exceptions/exception_bad_assert_range_with:OK
#114/39  exceptions/exception_throw_from_void_global:OK
#114/40  exceptions/non-throwing fentry -> exception_cb:OK
#114/41  exceptions/throwing fentry -> exception_cb:OK
#114/42  exceptions/non-throwing fexit -> exception_cb:OK
#114/43  exceptions/throwing fexit -> exception_cb:OK
#114/44  exceptions/throwing extension (with custom cb) -> exception_cb:OK
#114/45  exceptions/throwing extension -> global func in exception_cb:OK
#114/46  exceptions/exception_ext_mod_cb_runtime:OK
#114/47  exceptions/throwing extension (with custom cb) -> global func in exception_cb:OK
#114/48  exceptions/exception_ext:OK
#114/49  exceptions/non-throwing fentry -> non-throwing subprog:OK
#114/50  exceptions/throwing fentry -> non-throwing subprog:OK
#114/51  exceptions/non-throwing fentry -> throwing subprog:OK
#114/52  exceptions/throwing fentry -> throwing subprog:OK
#114/53  exceptions/non-throwing fexit -> non-throwing subprog:OK
#114/54  exceptions/throwing fexit -> non-throwing subprog:OK
#114/55  exceptions/non-throwing fexit -> throwing subprog:OK
#114/56  exceptions/throwing fexit -> throwing subprog:OK
#114/57  exceptions/non-throwing fmod_ret -> non-throwing subprog:OK
#114/58  exceptions/non-throwing fmod_ret -> non-throwing global subprog:OK
#114/59  exceptions/non-throwing extension -> non-throwing subprog:OK
#114/60  exceptions/non-throwing extension -> throwing subprog:OK
#114/61  exceptions/non-throwing extension -> non-throwing subprog:OK
#114/62  exceptions/non-throwing extension -> throwing global subprog:OK
#114/63  exceptions/throwing extension -> throwing global subprog:OK
#114/64  exceptions/throwing extension -> non-throwing global subprog:OK
#114/65  exceptions/non-throwing extension -> main subprog:OK
#114/66  exceptions/throwing extension -> main subprog:OK
#114/67  exceptions/reject_exception_cb_type_1:OK
#114/68  exceptions/reject_exception_cb_type_2:OK
#114/69  exceptions/reject_exception_cb_type_3:OK
#114/70  exceptions/reject_exception_cb_type_4:OK
#114/71  exceptions/reject_exception_cb_type_5:OK
#114/72  exceptions/reject_async_callback_throw:OK
#114/73  exceptions/reject_with_lock:OK
#114/74  exceptions/reject_subprog_with_lock:OK
#114/75  exceptions/reject_with_rcu_read_lock:OK
#114/76  exceptions/reject_subprog_with_rcu_read_lock:OK
#114/77  exceptions/reject_with_rbtree_add_throw:OK
#114/78  exceptions/reject_with_reference:OK
#114/79  exceptions/reject_global_subprog_throw_with_reference:OK
#114/80  exceptions/reject_with_cb_reference:OK
#114/81  exceptions/reject_with_cb:OK
#114/82  exceptions/reject_with_subprog_reference:OK
#114/83  exceptions/reject_throwing_exception_cb:OK
#114/84  exceptions/reject_exception_cb_call_global_func:OK
#114/85  exceptions/reject_exception_cb_call_static_func:OK
#114/86  exceptions/reject_multiple_exception_cb:OK
#114/87  exceptions/reject_exception_throw_cb:OK
#114/88  exceptions/reject_exception_throw_cb_diff:OK
#114/89  exceptions/reject_subprog_rcu_lock_throw:OK
#114/90  exceptions/reject_subprog_throw_preempt_lock:OK
#114/91  exceptions/reject_subprog_throw_irq_lock:OK
#114/92  exceptions/reject_set_exception_cb_bad_ret1:OK
#114/93  exceptions/reject_set_exception_cb_bad_ret2:OK
#114/94  exceptions/reject_out_of_range_global_throw:OK
#114/95  exceptions/check_assert_eq_int_min:OK
#114/96  exceptions/check_assert_eq_int_max:OK
#114/97  exceptions/check_assert_eq_zero:OK
#114/98  exceptions/check_assert_eq_llong_min:OK
#114/99  exceptions/check_assert_eq_llong_max:OK
#114/100 exceptions/check_assert_lt_pos:OK
#114/101 exceptions/check_assert_lt_zero:OK
#114/102 exceptions/check_assert_lt_neg:OK
#114/103 exceptions/check_assert_le_pos:OK
#114/104 exceptions/check_assert_le_zero:OK
#114/105 exceptions/check_assert_le_neg:OK
#114/106 exceptions/check_assert_gt_pos:OK
#114/107 exceptions/check_assert_gt_zero:OK
#114/108 exceptions/check_assert_gt_neg:OK
#114/109 exceptions/check_assert_ge_pos:OK
#114/110 exceptions/check_assert_ge_zero:OK
#114/111 exceptions/check_assert_ge_neg:OK
#114/112 exceptions/check_assert_range_s64:OK
#114/113 exceptions/check_assert_range_u64:OK
#114/114 exceptions/check_assert_single_range_s64:OK
#114/115 exceptions/check_assert_single_range_u64:OK
#114/116 exceptions/check_assert_generic:OK
#114/117 exceptions/check_assert_with_return:OK
#114     exceptions:OK
Summary: 1/117 PASSED, 0 SKIPPED, 0 FAILED

Since all exception tests pass now, the denylist file has been removed
as it is empty now.

Changes in v1->v2:
v1: https://lore.kernel.org/bpf/20260621144259.288135-1-varunrmallya@gmail.com/
- resolve the ftrace trampoline address with ftrace_graph_ret_addr()
  inside arch_bpf_stack_walk()
- Remove duplicated code in bpf_jit_build_prologue()

Changes in v2->v3:
v2: https://lore.kernel.org/bpf/20260628081710.113333-1-varunrmallya@gmail.com/
- extend walk_stackframe to use sp/fp similar to how arm64 does it. (Björn Töpel)
- refactor prologue/epilogue into helpers. (Björn Töpel)
- fix comments to make them netdev style.
- save/restore the tail-call counter in the exception prologue/epilogue
- exception_tail_call now passes since bpf2bpf+tailcall mixing landed [3], so
  drop the (now-empty) DENYLIST.riscv64
- (!aux->exception_cb) has been simplified to only one condition (Pu Lehui)

[1]: https://riscv-non-isa.github.io/riscv-elf-psabi-doc/#_frame_pointer_convention
[2]: https://riscv-non-isa.github.io/riscv-elf-psabi-doc/#_integer_register_convention
[3]: https://lore.kernel.org/bpf/bf647816-d292-419c-b79f-fc048122aebc@huaweicloud.com

Varun R Mallya (6):
  riscv: Use arch_stack_walk() for the kernel callchain
  riscv, stacktrace: Pass sp and fp to the walk_stackframe() callback
  riscv, stacktrace: Implement arch_bpf_stack_walk() for BPF
  riscv, bpf: Split prologue and epilogue into helper functions
  riscv, bpf: Add support for BPF exceptions
  riscv, bpf: Remove BPF exceptions from denylist

 arch/riscv/include/asm/stacktrace.h          |   5 +-
 arch/riscv/kernel/perf_callchain.c           |   3 +-
 arch/riscv/kernel/stacktrace.c               |  64 ++++-
 arch/riscv/net/bpf_jit_comp64.c              | 254 ++++++++++++++-----
 tools/testing/selftests/bpf/DENYLIST.riscv64 |   2 -
 5 files changed, 253 insertions(+), 75 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/DENYLIST.riscv64

-- 
2.55.0


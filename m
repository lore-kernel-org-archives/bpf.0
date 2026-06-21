Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2683C367B99
	for <bpf@vger.kernel.org>; Sun, 21 Jun 2026 14:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782052995; cv=none; b=U1Gas6EzADjellAf5CbjVwrMXEfW6CBq5jGWHmtJ7lREK/R3+BQv9+8QD7I1NATjPgeyP2ovoXmEuhSQf2XclXkWjj1MCJPot1dmJPZL7NqTqZyk/SEREYzRBMPmu3c8vxN4jk2t2pI6lQA37VTWeTmcplQ4k0WdOaTmOZGMY2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782052995; c=relaxed/simple;
	bh=7b/5/uuFY0iMAiAkkmjH/SZ4lUwfkNtTGXcNmQ3L7zI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ctde8w3a5S1R9w8EmtZRmMUFh5AS2HFsqcGAHgXrs0w9czrF0qnZd+/Na0UQ44Wm53XGSMs4AKj9Mx10L9W5Sw3i0FrOOzsIBw1hO1iP0wRJRkR2BjD69wp9cMghEbaODus4pnVmn2Nvn+r6TYVtsbLFBhgszLFL+FbjitGbSz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEyyakpZ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEyyakpZ"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8423610ec93so3323418b3a.2
        for <bpf@vger.kernel.org>; Sun, 21 Jun 2026 07:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782052992; x=1782657792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j21QVkqcaKlx86cBO+UHi3ihgP8Gq0rj/qDDVA+Xps4=;
        b=iEyyakpZeeQcyGRZAGYpALJe6PttsMDfVJLiyeCQQRYMShGm+yqlsBq/zBmVrxot1N
         2OOSQywuDWxIID7Sgp7StxJcnIaYOZAhZ2FsLmcuUF4t1DhV/ECinJcig8QAUxeCiCH2
         xUzag6olcG2FRjQjIL4XqRM26NzS/YZCqTpkLSR0hFl1Y9AWQ4Rx1NufTZcUHQ3SqdYB
         nIIMrORXU5PkhEslgLHAs/g3UCbpplgCBgWXglCdBvpL9wO2gvBYF8psCjqwzOgc2CWv
         1khc8tjHyrDAQEUt3dwdA3d0GycrKvnYsrRv7UIqqnngxczJIDyGesFeE9Yw/n2B7Cs7
         +ajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782052992; x=1782657792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j21QVkqcaKlx86cBO+UHi3ihgP8Gq0rj/qDDVA+Xps4=;
        b=d7OJeCclpsgb7Edm9FlQXdP58RCzptx+JEewqc48ih+RRwwci8Q46StAhVY7Z5JGbh
         DJ2XaQozL+nFemLyOcG7LNLUZi8kb/ybhZeBFYgzA81nPSVcGSShSfDI68NO+FXP7Z5T
         MIjG0P+btP3+5OqS2YJVtv4dRSji7eC7XTiKfvxs6drwVU2NO/qVzemrpVFVE01KAUKQ
         QddSLoLJb1hnXyqT1lI8bYPpfywqqrqRH4ZZfCZxSwp38bXD9DZPFfZdvnicvgooMADJ
         TXn0M1bERZlNSo2OB6SZhBPPuTrbmRhOrq1fQYWGwMa7i95Pk8zeRDpnS3C1yX6JX5ck
         VJXA==
X-Forwarded-Encrypted: i=1; AFNElJ8cZQnF1iZtsixYiZoXtDqUtx2RqyRCljlxEmRBbipJd3oCA5DDC4F5ttmHRYhjkZoGp2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhJCma1dW5BSoL/UxVvCBp1k8YwEvWe3QqleBnPq0hpaLU2Csg
	ZxvomIzeRO6ATj7k194+aHWWgv89aoYgsOhfCOEFXtDHGzXQ7fbjZPuR
X-Gm-Gg: AfdE7cmg2izIJBtlqMfN/Yy4LrVQixmMVdLHVk/s+TXkAqXIdmYAdlSZMOSvOFtCX+M
	5B2LCDGG0uA5xS+gBBrNqYAS3ZNL44/oQC1aBX7UPz1opzx1oNppyyleBpKjAXB3i3x8FEZEdrO
	JOPuVjead5S9a3sQ39O1eUo7R4lpjKEgCqYcxAO9D9x+NasrOxMV2CyUeFg1hXkMnPOtQ6Rir7F
	CB89V4RtjWL/Z5QMEmTCMddDAG9/z4w9e1VPk6tL0EpePODz51jQ3NkgB1fl8knwgtKKd4P1LFZ
	uJfJDFv1gTZsVosHQjx9OB7IfsUrQCzOF4Sqvkn+txrmbfJ6zAxLddWYSyI/rAvqrqEpq+hnNGj
	oOV9RJCk/9VzZGDajCjOSNpHErcymfM7egq7jnG5nt0BdX3x9ZojGKvTunWWi+TiQopdpcpeQA1
	lmg35Y1SPsYz2ZL6wRTmIrrHv9TM7nKdvOXQTl4ok=
X-Received: by 2002:a05:6a00:2eaa:b0:842:7992:bdd6 with SMTP id d2e1a72fcca58-845508a31e5mr11541607b3a.36.1782052992276;
        Sun, 21 Jun 2026 07:43:12 -0700 (PDT)
Received: from computer ([2a09:bac5:3b4a:8aa::dd:17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564e7687csm4963254b3a.35.2026.06.21.07.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 07:43:11 -0700 (PDT)
From: Varun R Mallya <varunrmallya@gmail.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	bjorn@kernel.org
Cc: alex@ghiti.fr,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	pulehui@huawei.com,
	puranjay@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	varunrmallya@gmail.com
Subject: [PATCH bpf-next 0/3] Add BPF Exceptions support for RISC-V
Date: Sun, 21 Jun 2026 20:12:56 +0530
Message-ID: <20260621144259.288135-1-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

The following demonstrates that all the selftests for BPF exceptions
apart from the ones that mix bpf-to-bpf calls and tailcalls pass.
This patch was tested using vmtest.sh to run the selftests.

test_exceptions_success:PASS:exceptions__open 0 nsec
libbpf: prog 'exception_tail_call': BPF program load failed: -EINVAL
libbpf: prog 'exception_tail_call': -- BEGIN PROG LOAD LOG --
0: R1=ctx() R10=fp0
; volatile int ret = 0; @ exceptions.c:106
0: (b4) w2 = 0                        ; R2=0
1: (63) *(u32 *)(r10 -4) = r2         ; R2=0 R10=fp0
; ret = exception_tail_call_subprog(ctx); @ exceptions.c:108
2: (85) call pc+4
caller:
 R10=fp0
callee:
 frame1: R1=ctx() R2=0 R10=fp0
7: frame1: R1=ctx() R10=fp0
; int exception_tail_call_subprog(struct __sk_buff *ctx) @ exceptions.c:96
7: (bf) r6 = r1                       ; frame1: R1=ctx() R6=ctx()
; volatile int ret = 10; @ exceptions.c:98
8: (b4) w1 = 10                       ; frame1: R1=10
9: (63) *(u32 *)(r10 -4) = r1         ; frame1: R1=10 R10=fp0 fp-8=mmmm????
; asm volatile("r1 = %[ctx]\n\t" @ bpf_helpers.h:169
10: (18) r7 = 0xff60000080df1800      ; frame1: R7=map_ptr(map=jmp_table,ks=4,vs=4)
12: (bf) r1 = r6                      ; frame1: R1=ctx() R6=ctx()
13: (bf) r2 = r7                      ; frame1: R2=map_ptr(map=jmp_table,ks=4,vs=4) R7=map_ptr(map=jmp_table,ks=4,vs=4)
14: (b7) r3 = 0                       ; frame1: R3=0
15: (85) call bpf_tail_call#12
mixing of tail_calls and bpf-to-bpf calls is not supported
processed 11 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
-- END PROG LOAD LOG --
libbpf: prog 'exception_tail_call': failed to load: -EINVAL
libbpf: failed to load object 'exceptions'
libbpf: failed to load BPF skeleton 'exceptions': -EINVAL
test_exceptions_success:FAIL:exceptions__load unexpected error: -22 (errno 22)
tester_init:PASS:tester_log_buf 0 nsec
process_subtest:PASS:obj_open_mem 0 nsec
process_subtest:PASS:specs_alloc 0 nsec
tester_init:PASS:tester_log_buf 0 nsec
process_subtest:PASS:obj_open_mem 0 nsec
process_subtest:PASS:specs_alloc 0 nsec
#113/1   exceptions/reject_exception_cb_type_1:OK
#113/2   exceptions/reject_exception_cb_type_2:OK
#113/3   exceptions/reject_exception_cb_type_3:OK
#113/4   exceptions/reject_exception_cb_type_4:OK
#113/5   exceptions/reject_exception_cb_type_5:OK
#113/6   exceptions/reject_async_callback_throw:OK
#113/7   exceptions/reject_with_lock:OK
#113/8   exceptions/reject_subprog_with_lock:OK
#113/9   exceptions/reject_with_rcu_read_lock:OK
#113/10  exceptions/reject_subprog_with_rcu_read_lock:OK
#113/11  exceptions/reject_with_rbtree_add_throw:OK
#113/12  exceptions/reject_with_reference:OK
#113/13  exceptions/reject_global_subprog_throw_with_reference:OK
#113/14  exceptions/reject_with_cb_reference:OK
#113/15  exceptions/reject_with_cb:OK
#113/16  exceptions/reject_with_subprog_reference:OK
#113/17  exceptions/reject_throwing_exception_cb:OK
#113/18  exceptions/reject_exception_cb_call_global_func:OK
#113/19  exceptions/reject_exception_cb_call_static_func:OK
#113/20  exceptions/reject_multiple_exception_cb:OK
#113/21  exceptions/reject_exception_throw_cb:OK
#113/22  exceptions/reject_exception_throw_cb_diff:OK
#113/23  exceptions/reject_subprog_rcu_lock_throw:OK
#113/24  exceptions/reject_subprog_throw_preempt_lock:OK
#113/25  exceptions/reject_subprog_throw_irq_lock:OK
#113/26  exceptions/reject_set_exception_cb_bad_ret1:OK
#113/27  exceptions/reject_set_exception_cb_bad_ret2:OK
#113/28  exceptions/reject_out_of_range_global_throw:OK
#113/29  exceptions/check_assert_eq_int_min:OK
#113/30  exceptions/check_assert_eq_int_max:OK
#113/31  exceptions/check_assert_eq_zero:OK
#113/32  exceptions/check_assert_eq_llong_min:OK
#113/33  exceptions/check_assert_eq_llong_max:OK
#113/34  exceptions/check_assert_lt_pos:OK
#113/35  exceptions/check_assert_lt_zero:OK
#113/36  exceptions/check_assert_lt_neg:OK
#113/37  exceptions/check_assert_le_pos:OK
#113/38  exceptions/check_assert_le_zero:OK
#113/39  exceptions/check_assert_le_neg:OK
#113/40  exceptions/check_assert_gt_pos:OK
#113/41  exceptions/check_assert_gt_zero:OK
#113/42  exceptions/check_assert_gt_neg:OK
#113/43  exceptions/check_assert_ge_pos:OK
#113/44  exceptions/check_assert_ge_zero:OK
#113/45  exceptions/check_assert_ge_neg:OK
#113/46  exceptions/check_assert_range_s64:OK
#113/47  exceptions/check_assert_range_u64:OK
#113/48  exceptions/check_assert_single_range_s64:OK
#113/49  exceptions/check_assert_single_range_u64:OK
#113/50  exceptions/check_assert_generic:OK
#113/51  exceptions/check_assert_with_return:OK
#113     exceptions:FAIL

All error logs:
test_exceptions_success:PASS:exceptions__open 0 nsec
libbpf: prog 'exception_tail_call': BPF program load failed: -EINVAL
libbpf: prog 'exception_tail_call': -- BEGIN PROG LOAD LOG --
0: R1=ctx() R10=fp0
; volatile int ret = 0; @ exceptions.c:106
0: (b4) w2 = 0                        ; R2=0
1: (63) *(u32 *)(r10 -4) = r2         ; R2=0 R10=fp0
; ret = exception_tail_call_subprog(ctx); @ exceptions.c:108
2: (85) call pc+4
caller:
 R10=fp0
callee:
 frame1: R1=ctx() R2=0 R10=fp0
7: frame1: R1=ctx() R10=fp0
; int exception_tail_call_subprog(struct __sk_buff *ctx) @ exceptions.c:96
7: (bf) r6 = r1                       ; frame1: R1=ctx() R6=ctx()
; volatile int ret = 10; @ exceptions.c:98
8: (b4) w1 = 10                       ; frame1: R1=10
9: (63) *(u32 *)(r10 -4) = r1         ; frame1: R1=10 R10=fp0 fp-8=mmmm????
; asm volatile("r1 = %[ctx]\n\t" @ bpf_helpers.h:169
10: (18) r7 = 0xff60000080df1800      ; frame1: R7=map_ptr(map=jmp_table,ks=4,vs=4)
12: (bf) r1 = r6                      ; frame1: R1=ctx() R6=ctx()
13: (bf) r2 = r7                      ; frame1: R2=map_ptr(map=jmp_table,ks=4,vs=4) R7=map_ptr(map=jmp_table,ks=4,vs=4)
14: (b7) r3 = 0                       ; frame1: R3=0
15: (85) call bpf_tail_call#12
mixing of tail_calls and bpf-to-bpf calls is not supported
processed 11 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
-- END PROG LOAD LOG --
libbpf: prog 'exception_tail_call': failed to load: -EINVAL
libbpf: failed to load object 'exceptions'
libbpf: failed to load BPF skeleton 'exceptions': -EINVAL
test_exceptions_success:FAIL:exceptions__load unexpected error: -22 (errno 22)

[1]: https://riscv-non-isa.github.io/riscv-elf-psabi-doc/#_frame_pointer_convention
[2]: https://riscv-non-isa.github.io/riscv-elf-psabi-doc/#_integer_register_convention

Varun R Mallya (3):
  riscv: stacktrace: Implement arch_bpf_stack_walk() for BPF
  riscv, bpf: Add support for BPF exceptions
  riscv, bpf: Remove BPF exceptions from BPF CI denylist

 arch/riscv/kernel/stacktrace.c               |  28 +++++
 arch/riscv/net/bpf_jit_comp64.c              | 102 +++++++++++++++++++
 tools/testing/selftests/bpf/DENYLIST.riscv64 |   1 -
 3 files changed, 130 insertions(+), 1 deletion(-)

-- 
2.54.0


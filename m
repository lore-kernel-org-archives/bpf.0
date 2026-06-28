Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CCD40D561
	for <bpf@vger.kernel.org>; Sun, 28 Jun 2026 08:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782634646; cv=none; b=YvLwBiPmKWUIQ0TAgDsGcDwkJRIydnmk5a4boM4W7qeAAv/mhm/rAmW2j8fKero4qUBY2LNvNaeHpBf871eYsbfuHPeJHuwbGbRDkp45/bEUwsrvPqHY243jTNashT5nzVvVWrxaN0IKuT2/uZepeFWluHPOKgRjH2rqJDJ60QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782634646; c=relaxed/simple;
	bh=ZVJSgxqjHxIaagSegdJMGLIo9Z+AcJ6RU1r0rFT3VW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mxJkrxEqLWPS0Il85PyUNV2cRUInVEGwfVUyNgRAtg8v/8jl9G0ZePf3lICThRQWkRcBggZo+Na0uh1xXvQy6MJ+ynrzcU5wjRQ1fgwV8zM2zlolKy4Tv3Uw0jVrg79tDOHGxeUaXqB3R3jUCgMfUc13jsaSS1Je8Szo37NaBCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAe40TeV; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAe40TeV"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c99eaa1f020so10761a12.2
        for <bpf@vger.kernel.org>; Sun, 28 Jun 2026 01:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782634644; x=1783239444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TMZJ3bc/HOOdrYFXeaDGp5Mr01fg5cOybXiq3cNrcV0=;
        b=BAe40TeVR1z5QPqwv92yz5CyYKgX4gErYs+lVD/O3cmjOnjIz4UdP8kbP3oNuDQU56
         9nq+NBTgscDSFus1B4oUC4hD495nIx3EXtE+l6p3EaU3kLCoX8Bb60bR2Z0bzIX4u6jM
         DDeXZpQau0qrq32kyophPiOjTRlQDuIlNxrGAmMsulivcIIJaHDwMfggs15aokPP1eBo
         UCnBYtQJkafenC9C/KDhxbxDWlMDCPcVqrhfkYnfP5HMFwwQucE4r7b/dFAWSykp1H+H
         UK9Mo3z99zczJWqam1o1KCiLp1wwKF5Jgo7/wcjYc4L5gOdcKRmvc5XaR1FSFPe779nz
         XP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782634644; x=1783239444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMZJ3bc/HOOdrYFXeaDGp5Mr01fg5cOybXiq3cNrcV0=;
        b=A3+zTFqVJeLUKvbp99uVBUJO/MzMw1XMhllOSfEBmwGZM3ysbT1yzXsqCIKUabkB8I
         LmDNqz2dMU4APaO8fGsr07lpV6TUueWJyr7JpD08AXdaJXj+rF6HMBrIakFGhuGBwCjT
         F3z3IIc5ultLGcEAjfnh+yWxUxRxsOagBj3Pr4BD42bLzukby9hyCn29Zk/XBqM5ycvP
         Yz3Up2vplk9NMPiNMXb9ICWGwhH/DYAO4kYIhqSAjDIhZMmcfsCK3Z/sg9LZI6q77yNB
         fQvcOfT1RXomRRiPa99YMjFlWP0TPC5nzKkzWxjqPGLaJml3bodeSebKGkD9FKYc1x8f
         1f7Q==
X-Forwarded-Encrypted: i=1; AFNElJ+D1POwUdke6X/jLLg1IANkx+msrNi6YDXtKkl/pPDIRxeLqoUkCVwmYMWFStQH48SFEu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7c7PT94JzhqjHfoFrCvdqGeLqbv2uXb1NKCVdpVQVLFyuIyuI
	tDhPcy2ztVyuh1FATw3wAPi46j2OXOh8ReuYyuQW3IhYSsOjlWMo+wu+
X-Gm-Gg: AfdE7cl61d57s55rfzZDviz+T1xKFQdESfgbTeUZxfTSYw95LI4TOXctASvfC7JhCfZ
	yXku9z1ed0VRF8M26dc9ADhTJe2P7swhJzPrjaTLGjI6oKL0CeQPSKRlEGSqM02ZBqDU36eTIRt
	Bd7i1d7FT/BOG3xZkOV7cAhqnX64pJe3IUMl1vL11GXHZLle5mgzESeVbk2S7sTK+wig6aGqHr6
	TXFWlcG5QLsZSnqhY5zKmDOBPR95x3KedAmd3BRI8Y+KCQjUysLy9zgD6JzIYpn/uKxeNI4WVpQ
	12IY1nyFl/KP6OZyZ7t89mj5+OeX5Oi514Z7EYnjKR6ogiSrr0XktgXv6gxc5Qv0LahKgx6r4AW
	xeKtqAkuPNcRET2utmA7LfkBMSCt0I4EhLz8fa1d8/KofasMMZSIWSCescSt219lMLGUBi0EXPh
	mOG51Tx+EnvTwpuU3EjcjQlhprcvrte7p2w0pflZM60QtP0GFREIUTmoU=
X-Received: by 2002:a05:6300:6bc2:20b0:3b3:1c7b:ff0 with SMTP id adf61e73a8af0-3bd4af033acmr7744492637.32.1782634643791;
        Sun, 28 Jun 2026 01:17:23 -0700 (PDT)
Received: from computer.goose-salary.ts.net ([2a09:bac5:3b4a:8aa::dd:15])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92bd55985asm6020434a12.31.2026.06.28.01.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 01:17:23 -0700 (PDT)
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
	shuah@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	varunrmallya@gmail.com
Subject: [PATCH bpf-next v2 0/3] Add BPF Exceptions support for RISC-V
Date: Sun, 28 Jun 2026 13:47:07 +0530
Message-ID: <20260628081710.113333-1-varunrmallya@gmail.com>
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

Changes in v1->v2:
v1: https://lore.kernel.org/bpf/20260621144259.288135-1-varunrmallya@gmail.com/
- resolve the ftrace trampoline address with ftrace_graph_ret_addr()
  inside arch_bpf_stack_walk()
- Remove duplicated code in bpf_jit_build_prologue()

[1]: https://riscv-non-isa.github.io/riscv-elf-psabi-doc/#_frame_pointer_convention
[2]: https://riscv-non-isa.github.io/riscv-elf-psabi-doc/#_integer_register_convention


Varun R Mallya (3):
  riscv: stacktrace: Implement arch_bpf_stack_walk() for BPF
  riscv, bpf: Add support for BPF exceptions
  riscv, bpf: Remove BPF exceptions from BPF CI denylist

 arch/riscv/kernel/stacktrace.c               |  31 +++++
 arch/riscv/net/bpf_jit_comp64.c              | 115 ++++++++++++++++---
 tools/testing/selftests/bpf/DENYLIST.riscv64 |   1 -
 3 files changed, 133 insertions(+), 14 deletions(-)

-- 
2.54.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59752AF1D
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 16:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776530365; cv=none; b=MDRdPlWUxjWX1hqzfePB7YLUwQPYKQXoQ9Ib+jZEa62TMtXfmotnJoCE2CAye3rmfOlyIswEuRlEi+/7u5McdccHK9xLZ8AMZU+R47rTlrVEJYBpdKVnRa+6iMJkkwZoXfoaQWlfPA4JQGG818vVxD45cPJag5dUeMS6EQP9ZRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776530365; c=relaxed/simple;
	bh=9IwEp0wFmLzyspdG3dmrGCv8JnFqH5Y1PlV8ugEWvBo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LpRg36AbI+Wv9m4UdFo66UozLMw1QebO2lMLCuatQBAr+/+PRCEqfEMCbkubUKarXO0vppRWwDbpdN0xBUCkoq8cro00RLrCYCe2xq9eFRqxkl5rve+jS48umeaJs7myqxnBrE/crrJSRyROHy8cT1fHRmWPh8ByHXRmi7kFIgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRFueieZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRFueieZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033C5C19424;
	Sat, 18 Apr 2026 16:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776530365;
	bh=9IwEp0wFmLzyspdG3dmrGCv8JnFqH5Y1PlV8ugEWvBo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oRFueieZvnoxBwx3qfXbddR8Xc2/zAe+IVP/jlJQ3tz8+tmr8tsk+Q7uEG7eDrPJ3
	 d4VZ2NtJTh2ONidBXq8xsl7V5cNHlxvThUyqr4cEnY969nrj5Y5nb3MkLwMuEeG3IL
	 BOeBQdu0TanI/gUXUKj/3Oc4j4pEXIjpPVZnufL+BtVId6DwAfQwAUL5w7faYgoBop
	 4CuYiNOixW/RSn3huR+ZPIUTxYc4Gd+tTA2cz0R9qZkqrIAYny25uJLPZMsFKnqDT5
	 +fil10aTIfAoKeS8ff+noQdo2s0qYu9sDwIZ1vAuuB6f8tLIkpCvUB1/srNsytPysv
	 43Ef8o/1wEWhQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "Jose E .
 Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com, Martin KaFai Lau
 <martin.lau@kernel.org>, Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: [PATCH bpf-next v5 00/16] bpf: Support stack arguments for BPF
 functions and kfuncs
In-Reply-To: <20260417034658.2625353-1-yonghong.song@linux.dev>
References: <20260417034658.2625353-1-yonghong.song@linux.dev>
Date: Sat, 18 Apr 2026 17:39:19 +0100
Message-ID: <m2v7do1avc.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yonghong Song <yonghong.song@linux.dev> writes:

> Currently, bpf function calls and kfunc's are limited by 5 reg-level
> parameters. For function calls with more than 5 parameters,
> developers can use always inlining or pass a struct pointer
> after packing more parameters in that struct. But there is
> no workaround for kfunc if more than 5 parameters is needed.
>
> This patch set lifts the 5-argument limit by introducing stack-based
> argument passing for BPF functions and kfunc's, coordinated with
> compiler support in LLVM [1]. The compiler emits loads/stores through
> a new bpf register r11 (BPF_REG_PARAMS) to pass arguments beyond
> the 5th, keeping the stack arg area separate from the r10-based program
> stack. The maximum number of arguments is capped at MAX_BPF_FUNC_ARGS
> (12), which is sufficient for the vast majority of use cases.
>
> In verifier, r11 based stores can survive bpf-to-bpf and kfunc
> calls. For example
>       *(u64 *)(r11 - 8) = r6;
>       *(u64 *)(r11 - 16) = r7;
>       call bar1;                // arg6 = r6, arg7 = r7
>       call bar2;                // reuses same arg6, arg7 without re-storing

Argument registers are caller saved, that means if the x86 JIT will use
R9 for the arg6 and call bar1, it can clobber it (by calling a helper or
another bpf-to-bpf call) and then bar2 will receive clobbered value for
arg6 because it did not reload it.

This only works for caller saved registers like arg5 (R8 on x86-64) (R5
on bpf) because R5 (BPF) is caller saved and compiler will make sure to
save R5 before the call. But for stacked arguments, compiler models them
as stack memory and if the JIT models them as a register to follow
calling convention, they need to be saved/reloaded before calls. 

Let me explain with an example, if you apply this patch to the selftests:

-- >8 --

From 52924eb28056fe8a2321b1cadf9409f6ca90603d Mon Sep 17 00:00:00 2001
From: Puranjay Mohan <puranjay@kernel.org>
Date: Sat, 18 Apr 2026 09:11:06 -0700
Subject: [PATCH] selftests/bpf: Add test for stack arg register clobbering

Add verifier test stack_arg_reuse_across_inner_call which uses inline
asm to store stack args, call a subprog that internally calls another
subprog with different stack arg values (100, 200 instead of 6, 7),
then reuse the original stores for a second call without re-storing.

This exposes JIT bugs where stack arg registers (x5-x7 on arm64, R9
on x86) are clobbered by the inner call but not refreshed before
the second call.

Correct result: 315 + 28 = 343.
Clobbered result: 315 + 315 = 630. (on arm64)

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../selftests/bpf/progs/verifier_stack_arg.c  | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
index 41ce950ea40e..0c6b433404e8 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
@@ -462,6 +462,62 @@ __naked void stack_arg_sequential_calls(void)
        );
 }

+/*
+ * subprog_7args_inner_call takes 7 args like subprog_7args, but
+ * internally calls subprog_7args with different stack arg values
+ * (100, 200).  This clobbers whatever the JIT placed in the stack
+ * arg registers (x5-x7 on arm64, R9 on x86).
+ */
+__noinline __used
+static int subprog_7args_with_inner_call(int a, int b, int c, int d,
+                                        int e, int f, int g)
+{
+       return subprog_7args(a, b, c, d, e, 100, 200);
+}
+
+SEC("tc")
+__description("stack_arg: store reuse across inner call")
+__success __retval(343)
+__arch_x86_64
+__arch_arm64
+__naked void stack_arg_reuse_across_inner_call(void)
+{
+       asm volatile (
+               /* call1: subprog_7args_inner_call(1,2,3,4,5,6,7)
+                * internally calls subprog_7args(1,2,3,4,5,100,200)=315
+                * which clobbers stack arg registers with 100, 200.
+                * Returns 315.
+                */
+               "r1 = 1;"
+               "r2 = 2;"
+               "r3 = 3;"
+               "r4 = 4;"
+               "r5 = 5;"
+               "*(u64 *)(r11 - 8) = 6;"
+               "*(u64 *)(r11 - 16) = 7;"
+               "call subprog_7args_with_inner_call;"
+               "r6 = r0;" /* 315 */
+               /* call2: reuse r11 stores from call1 (no re-store).
+                * subprog_7args(1,2,3,4,5,6,7) should return 28.
+                * If clobbered: subprog_7args(1,2,3,4,5,100,200)=315.
+                */
+               "r1 = 1;"
+               "r2 = 2;"
+               "r3 = 3;"
+               "r4 = 4;"
+               "r5 = 5;"
+               /*
+                * the 6th and 7th arg should be 6, 7 as set above.
+                * But the inner call in subprog_7args_inner_call clobbered
+                * them and reusing again without a re-store will be wrong.
+                */
+               "call subprog_7args;" /* should return 28, but will be 315 due to clobber */
+               "r0 += r6;" /* should have 315 + 28 = 343 but will be 315 + 315 = 630 */
+               "exit;"
+               ::: __clobber_all
+       );
+}
+
 #else

 SEC("socket")
--
2.52.0

-- 8< --

If I run this arm64 (I have a patch to add support)

I get:
run_subtest:PASS:obj_open_mem 0 nsec
run_subtest:PASS:unexpected_load_failure 0 nsec
do_prog_test_run:PASS:bpf_prog_test_run 0 nsec
run_subtest:FAIL:1313 Unexpected retval: 630 != 343
#631/14  verifier_stack_arg/stack_arg: store reuse across inner
call:FAIL

And on x86 it will be:
  - Second call gets R9 = 100 (clobbered), [rsp+0] = 7 (survives, because subprog get's own stack slot)
  - subprog_7args(1,2,3,4,5, 100, 7) = 122 instead of 28
  - Total: 315 + 122 = 437 instead of 343

^^ this is not tested just a theoretical looking at x86 JIT code added
in this patchset that used R9 for sixth argument.

So, I think the fix it to make the JITs keep the 6th arg (x86) and
(6,7,8)th arg (arm64) on the stack and re-load them before every call.
Or the compiler should treat all r11 stack slots like caller saved stack
and reload them.

Please let me know if my analysis is correct or maybe my arm64 jit
implementation is broken.

Thanks,
Puranjay

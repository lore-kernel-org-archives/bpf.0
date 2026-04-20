Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1936730E84B
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 20:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776716613; cv=none; b=nTUGuij0Rui+ySat1YhoiMUpFpOCEjZqNdX8Zz0jylheZ7K7mdSxVccDDiElCuwVeK5PNK9io9XdaxLrEDVZ3m49kT/gRUGQjYe190YfWOcyYGGWYY5yOx3O6UHSX3RQECEGJfYN0+V4+Qj11pE4sePcHGMLTbgvDkmvroN7gmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776716613; c=relaxed/simple;
	bh=GQkwCZWkYn55rC50gtmpb+S1vnTNIjwhnq502mr7zgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UXyI3Prxxmnib4RN/ZXeGa+49C6Oc2rDofhycrzwCUlxv9r3TNjSFZ+MFKQZfALxXxLJXn+wxXVinekc+EfM+6ZnlMbaXsVUl7/9A6/F/9wd9OOsPSBvIhnDjaO5YIXpHpbiNojWxD0Nu0ZwjItf3jmuFmtFCqQgDMS4KNd5NN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HwQnJVI/; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HwQnJVI/"
Message-ID: <21aad67d-97b8-4ffd-8b4a-747ee8b917be@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776716608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uMwVRq+jFs6/H5Vrg7m8GrbwOrAglvP73pREjUAgbn8=;
	b=HwQnJVI/GkGfOkIIwWgJxg4ylwbFtLbU+Tgr6JW1b6aEuqpYA1pA6BTDaIC/XVwREViuKt
	kEW97Ro+6uTumqxqT41jBPw1tfhij7No92QHDWdQTMAbpmOfZKJaUn7MpN51K5ApX6HlV+
	aFXbX9/upwElf5EuTBpZYyMclXXnpdQ=
Date: Mon, 20 Apr 2026 13:22:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 00/17] bpf: Support stack arguments for BPF
 functions and kfuncs
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Puranjay Mohan <puranjay12@gmail.com>
References: <20260419163316.731019-1-yonghong.song@linux.dev>
 <m2mryx1vwi.fsf@kernel.org>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <m2mryx1vwi.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/20/26 8:41 AM, Puranjay Mohan wrote:
> Yonghong Song <yonghong.song@linux.dev> writes:
>
>> Currently, bpf function calls and kfunc's are limited by 5 reg-level
>> parameters. For function calls with more than 5 parameters,
>> developers can use always inlining or pass a struct pointer
>> after packing more parameters in that struct although it may have
>> some inconvenience. But there is no workaround for kfunc if more
>> than 5 parameters is needed.
>>
>> This patch set lifts the 5-argument limit by introducing stack-based
>> argument passing for BPF functions and kfunc's, coordinated with
>> compiler support in LLVM [1]. The compiler emits loads/stores through
>> a new bpf register r11 (BPF_REG_PARAMS) to pass arguments beyond
>> the 5th, keeping the stack arg area separate from the r10-based program
>> stack. The current maximum number of arguments is capped at
>> MAX_BPF_FUNC_ARGS (12), which is sufficient for the vast majority of
>> use cases.
>>
>> All kfunc/bpf-function arguments are caller saved, including stack
>> arguments. For register arguments (r1-r5), the verifier already marks
>> them as clobbered after each call. For stack arguments, the verifier
>> invalidates all outgoing stack arg slots immediately after a call,
>> requiring the compiler to re-store them before any subsequent call.
>> This follows the native calling convention where all function
>> parameters are caller saved.
>>
>> The x86_64 JIT translates r11-relative accesses to RBP-relative
>> native instructions. Each function's stack allocation is extended
>> by 'max_outgoing' bytes to hold the outgoing arg area below the
>> callee-saved registers. This makes implementation easier as the r10
>> can be reused for stack argument access. At both BPF-to-BPF and kfunc
>> calls, outgoing args are pushed onto the expected calling convention
>> locations directly. The incoming parameters can directly get the value
>> from caller.
>>
>> To support kfunc stack arguments, before doing any stack arguments,
>> existing codes are refactored/modified to use bpf_reg_state as much
>> as possible instead of using regno, and to pass a non-negative argno,
>> encoded to support both registers and stack arguments, as a single
>> variable.
>>
>> Global subprogs with >5 args are not yet supported. Only x86_64
>> is supported for now.
>>
>> For the rest of patches, patches 1-4 make changes to make it
>> easy for future stack arguments for kfuncs. Patches 5-8
>> supports bpf-to-bpf stack arguments. Patch 9 rejects interpreter
>> for stack arguments. Patch 10 rejects subprogs if tailcall reachable.
>> Patch 11 adds stack argument support for kfuncs. Patch 12 enables
>> stack arguments for x86_64 and Patch 13 implements the x86_64 JIT.
>> Patches 14-16 are some test cases.
>>
>>    [1] https://github.com/llvm/llvm-project/pull/189060
>>
>> Note:
>>    - The patch set is on top of the following commit:
>>      eb0d6d97c27c  Merge tag 'bpf-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
>>    - This patch set requires latest llvm23 compiler. It is possible that a build
>>      failure may appear:
>>        /home/yhs/work/bpf-next/scripts/mod/modpost.c:59:13: error: variable 'extra_warn' set but not used [-Werror,-Wunused-but-set-global]
>>               59 | static bool extra_warn;
>>                  |             ^
>>            1 error generated.
>>      In this case, the following hack can workaround the build issue:
>>        --- a/Makefile
>>        +++ b/Makefile
>>        @@ -467,7 +467,7 @@ KERNELDOC       = $(srctree)/tools/docs/kernel-doc
>>         export KERNELDOC
>>
>>         KBUILD_USERHOSTCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
>>        -                        -O2 -fomit-frame-pointer -std=gnu11
>>        +                        -O2 -fomit-frame-pointer -std=gnu11 -Wno-unused-but-set-global
>>         KBUILD_USERCFLAGS  := $(KBUILD_USERHOSTCFLAGS) $(USERCFLAGS)
>>         KBUILD_USERLDFLAGS := $(USERLDFLAGS)
>>
>> Changelogs:
>>    v5 -> v6:
>>      - v5: https://lore.kernel.org/bpf/20260417034658.2625353-1-yonghong.song@linux.dev/
>>      - Do stack arguments invalidation after bpf function or kfunc all. This is to
>>        following native achitecture calling convention.
>>      - Fix some r11 related issues in const_fold, liveness and insn checking.
>>      - Fix a few places for precision marking for stack arguments. All these cases
>>        have const value and mark them as precise.
>>      - Unconditionally copy some incoming/outgoing stat.
>>      - Fix a missing tailcall case with main prog having tailcall and there is no
>>        other subprog's.
>>      - Add and fix tests as suggested in v5.
>>      - Reorder some patches, e.g., preparing stack arguments in bpf functions,
>>        disabling JIT, before allowing proper r11 usage.
>>    v4 -> v5:
>>      - v4: https://lore.kernel.org/bpf/20260412045826.254200-1-yonghong.song@linux.dev/
>>      - Use r11 instead of r12, llvm also updated with r11.
>>      - Change int type 'reg_or_arg' to u32 'argno' where 'argno' encodes to support
>>        both bpf registers and stack arguments.
>>      - Track per-state bitmask 'out_stack_arg_mask' for r11 based stores, so at any
>>        particular call, it knows what stores are available. This is important since
>>        stores may be in different basic block.
>>      - Previously after each call, all store slots are invalidated. This patches
>>        disabled such invalidation.
>>      - Ensure r11 reg only appearing in allowed insns. Also avoid r11 for reg tracking
>>        purpose.
>>      - Make stack_arg_regs more similar to regular reg's (struct bpf_reg_state *)..
>>      - Reorder r11 based stores from 'arg6:off:-24, arg7:off:-16, arg8:off:-8" to
>>        "arg6:off:-8, arg7:off:-16, arg8:off:-24".
>>      - Add a few more tests, including e.g., two callee's with different number of
>>        stack arguments, shared r11-stores in different branches, etc.
>>
>>    v3 -> v4:
>>      - v3: https://lore.kernel.org/bpf/20260405172505.1329392-1-yonghong.song@linux.dev/
>>      - Refactor/Modify codes to make it easier for later kfunc stack argument support
>>      - Invalidate outgoing slots immediately after the call to prevent reuse
>>      - Fix interaction between stack argument PTR_TO_STACK and dead slot poisoning
>>      - Reject stack arguments if tail call reachable
>>      - Disable private stack if stack argument is used
>>      - Allocate outgoing stack argument region after callee saved registers, and this
>>        simplifies the JITed code a lot.
>>    v2 -> v3:
>>      - v2: https://lore.kernel.org/bpf/20260405165300.826241-1-yonghong.song@linux.dev/
>>      - Fix selftest stack_arg_gap_at_minus8().
>>      - Fix a few 'UTF-8' issues.
>>    v1 -> v2:
>>      - v1: https://lore.kernel.org/bpf/20260402012727.3916819-1-yonghong.song@linux.dev/
>>      - Add stack_arg_safe() to do pruning for stack arguments.
>>      - Fix an issue with KF_ARG_PTR_TO_MEM_SIZE. Since a faked register is
>>        used, added verification log to indicate the start and end of such
>>        faked register usage.
>>      - For x86_64 JIT, copying incoming parameter values directly from caller's stack.
>>      - Add test cases with stack arguments e.g. mem, mem+size, dynptr, iter, etc.
>>
>> Yonghong Song (17):
>>    bpf: Remove unused parameter from check_map_kptr_access()
>>    bpf: Refactor to avoid redundant calculation of bpf_reg_state
>>    bpf: Refactor to handle memory and size together
>>    bpf: Prepare verifier logs for upcoming kfunc stack arguments
>>    bpf: Introduce bpf register BPF_REG_PARAMS
>>    bpf: Reuse MAX_BPF_FUNC_ARGS for maximum number of arguments
>>    bpf: Support stack arguments for bpf functions
>>    bpf: Reject stack arguments in non-JITed programs
>>    bpf: Track r11 registers in const_fold and liveness
>>    bpf: Prepare architecture JIT support for stack arguments
>>    bpf: Enable r11 based insns
>>    bpf: Support stack arguments for kfunc calls
>>    bpf: Reject stack arguments if tail call reachable
>>    bpf,x86: Implement JIT support for stack arguments
>>    selftests/bpf: Add tests for BPF function stack arguments
>>    selftests/bpf: Add tests for stack argument validation
>>    selftests/bpf: Add verifier tests for stack argument validation
>>
> This set looks good to me overall:
>
> Acked-by: Puranjay Mohan <puranjay@kernel.org>
>
> I added support for arm64 in https://lore.kernel.org/all/20260420153603.4097618-1-puranjay@kernel.org/
> Please incorporate it into your series if you do another version.

Thanks, Puranjay! I will send another revision later which adds support
for precision backtracking and additional/modified test cases among other
things. I won't include your patches in the next revision. Once the patch
set is stable enough, I can add your patches. Optionally, the patch set is
already large enough, so maybe at some point, after this patch set is merged,
you can send your patch set separately.

>
> Thanks,
> Puranjay


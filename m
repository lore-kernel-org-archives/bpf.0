Received: from mta1.migadu.com (out-152.mta1.migadu.com [95.215.58.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2787E36493C
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 23:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790637197; cv=none; b=Ns2nNPe+rDYKqYv0zrs/rHDebRp4rFVBjkpt7ewdg/OAvUgIuMEztnZd+UjrRmW1tqHoTgrdl3uZz1tmb3HwwihpPHQUijEkNMPCL1a9k+tCaJSqPOGxBw3pWbzb/GXCSgdjJiP7PcKINIOYUzv7VEGMAq4oCuLwVeyDItDLV1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790637197; c=relaxed/simple;
	bh=7RoiqoRNFqjTDbI6Tu2iwj7TYs/6MG+px9aEnDhNSxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LzOstfC81kc6n+84W22XdU1hP82Me+EmTh7l4OMnDfHIlBX2/s3Cyx5NX9roKZBx+8HzetXKWj3XX6XjqCJCsu73XoFtKfTw5CPa+I9VDhaypzu8VAhJVhBBeTabJiw2wPeLCaqjminVYxa5EqU0nH7k8TJvWMgKH8i3o5+4eb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wa2un31G; arc=none smtp.client-ip=95.215.58.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wa2un31G"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7RoiqoRNFqjTDbI6Tu2iwj7TYs/6MG+px9aEnDhNSxI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790637192; v=1; x=1791241992;
 b=wa2un31Gjj30eURMFkvDwhgZy3SvWjbGtRLREGE71PpaBMFm5OLdjPBg1S+868WI0/wU4LF1
 eeZMvWoQJt6sKZ+oXeXg7jA2+VQLDCNCew/0wRm3vFcXdO0Dl6SQ300Xj/cFx0Tgc5TVGwJD4Gz
 61j/BXafoUDZUim3HGElFmf4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0fe08cb5dd7dfc97;
	Mon, 28 Sep 2026 23:13:09 +0000
X-Mizu-Trace-ID: 0fe08cb5dd7dfc97
X-Migadu-Flow: FLOW_OUT
Message-ID: <a25b9150-55ba-41ef-8de9-0067b4576278@linux.dev>
Date: Mon, 28 Sep 2026 16:13:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 00/17] bpf: Indirect calls of bpf subprogs
 (callx)
To: patchwork-bot+netdevbpf@kernel.org,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, Emil Tsalapatis <emil@etsalapatis.com>
References: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
 <179022901639.1337807.12766583921039284951.git-patchwork-notify@kernel.org>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <179022901639.1337807.12766583921039284951.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-09-23 10:50 p.m., patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to bpf/bpf-next.git (master)
> by Alexei Starovoitov <ast@kernel.org>:

Alexei,

We're testing clang 21->22 bump on BPF CI, and something is broken
when compiling callx selftests:

2026-09-28T22:12:12.4226025Z error: Undefined temporary symbol 
.Lswitch.table.call_by_switch
2026-09-28T22:12:12.4229909Z 1 error generated.
2026-09-28T22:12:12.4265848Z make[1]: *** [Makefile.skel:93: 
/home/runner/work/ci/ci/tools/testing/selftests/bpf/cpuv4/verifier_callx_rodata.bpf.o] 
Error 1
2026-09-28T22:12:12.4275948Z make: *** [Makefile:533: 
/home/runner/work/ci/ci/tools/testing/selftests/bpf/test_progs-cpuv4] 
Error 2
2026-09-28T22:12:12.4291571Z   CLNG-BPF [test_progs-no_alu32] 
verifier_gotol.bpf.o
2026-09-28T22:12:12.4292514Z make: *** Waiting for unfinished jobs....

See: https://github.com/libbpf/ci/actions/runs/36487754699/job/109148996137

What's the requirements for callx? Does it need bleeding edge clang?
If so, let's explicitly skip relevant selftests for clang < N?

Currently CI runs with clang-21.

> 
> On Thu, 24 Sep 2026 03:10:25 +0000 you wrote:
>> From: Alexei Starovoitov <ast@kernel.org>
>>
>> v1->v2:
>> - Dropped "bpf: Don't fold loads from insn_array maps into constants".
>>    bpf_map_direct_read() rejects insn_array already.
>> - patch 1: emit the same diag as sort_subprogs_topo() (bpf-ci).
>> - patch 3 is new: taking the address of a function that is never called
>>    hit verifier_bug() in jit_subprogs(). Not related to callx, but callx
>>    makes it likely.
>> - patch 4: BPF_OP() == BPF_CALL in liveness like in const_fold, explained
>>    in the comment why slots are live before callx callsite (Eduard).
>> - patch 5: moved !bpf_is_callx() into nested 'if' (Eduard). JIT support
>>    is checked before the type of the register.
>> - patch 6: sync callbacks are in the call graph too. Stack depth of
>>    a callback whose address is read from .rodata or taken in another
>>    subprog was not accounted.
>> - patch 10:
>>    . check_cfg() explores functions of a table one at a time. It was
>>      losing changes_pkt_data and other effects of the functions in
>>      a table that call each other.
>>    . no cmpxchg64(), it's not available on all 32-bit archs.
>>    . don't reject the prog that reads a pointer to a function that was
>>      removed as dead code (sashiko).
>>    . load of the pointer sets jit_required, so the prog that passes it to
>>      a helper as a callback can't run in the interpreter (bpf-ci).
>>    . tbl[i].data at variable offset is a regular load when none of
>>      the possible offsets overlaps with a pointer (bpf-ci).
>> - patch 12: append the functions and copy the map only for progs that
>>    have callx. The rest use .rodata as-is (bpf-ci). Pass token_fd to map
>>    create. Dropped dead bpf_map_lookup_elem() fallback.
>> - patch 14: light skeleton reserves fd_array slots only when the object
>>    has callx.
>> - selftests: anchored callx_retval_is_tracked to the caller, the tests
>>    of global func in a table and of const folding of the pointer test what
>>    they claim now, skip without JIT, fixed ASSERT_GT() of u32 and
>>    the comment, added tests for the above (bpf-ci). The table in
>>    callx_rodata_lskel test is volatile. clang was turning it into
>>    direct calls, so the test didn't test light skeleton.
>> - Added acks.
>> v1: https://lore.kernel.org/bpf/20260922011323.1298619-1-alexei.starovoitov@gmail.com/
>>
>> [...]
> 
> Here is the summary with links:
>    - [bpf-next,v2,01/17] bpf: Fix infinite loop in check_max_stack_depth()
>      https://git.kernel.org/bpf/bpf-next/c/f2c33a159190
>    - [bpf-next,v2,02/17] selftests/bpf: Test recursion through a global function and a callback
>      https://git.kernel.org/bpf/bpf-next/c/6cec7366b5ce
>    - [bpf-next,v2,03/17] bpf: Keep functions with address taken when removing dead code
>      https://git.kernel.org/bpf/bpf-next/c/fb1f5ac185b7
>    - [bpf-next,v2,04/17] bpf: Prepare static analysis passes for callx instruction
>      https://git.kernel.org/bpf/bpf-next/c/373e3fd0bff0
>    - [bpf-next,v2,05/17] bpf: Add callx instruction to call bpf subprogs indirectly
>      https://git.kernel.org/bpf/bpf-next/c/7f0f66c069ae
>    - [bpf-next,v2,06/17] bpf: Add callx calls to the call graph
>      https://git.kernel.org/bpf/bpf-next/c/b7151a69bc6e
>    - [bpf-next,v2,07/17] bpf, x86: Add JIT support for callx
>      https://git.kernel.org/bpf/bpf-next/c/69a30e5fe5a8
>    - [bpf-next,v2,08/17] bpf, arm64: Add JIT support for callx
>      https://git.kernel.org/bpf/bpf-next/c/11a516144d9a
>    - [bpf-next,v2,09/17] bpf: Discover subprogs described by func_info
>      https://git.kernel.org/bpf/bpf-next/c/3a03595510dc
>    - [bpf-next,v2,10/17] bpf: Recognize pointers to functions in read-only maps
>      https://git.kernel.org/bpf/bpf-next/c/a04286f6d828
>    - [bpf-next,v2,11/17] libbpf: Support pointers to static functions in data when linking
>      https://git.kernel.org/bpf/bpf-next/c/296fd4782754
>    - [bpf-next,v2,12/17] libbpf: Resolve pointers to functions in read-only data
>      https://git.kernel.org/bpf/bpf-next/c/b223044a68d5
>    - [bpf-next,v2,13/17] libbpf: Treat .data.rel.ro as read-only data
>      https://git.kernel.org/bpf/bpf-next/c/6ec77f0a7697
>    - [bpf-next,v2,14/17] libbpf: Support pointers to functions in read-only data in light skeleton
>      https://git.kernel.org/bpf/bpf-next/c/9f99fc05fc92
>    - [bpf-next,v2,15/17] selftests/bpf: Add tests for callx
>      https://git.kernel.org/bpf/bpf-next/c/e9b22d50796d
>    - [bpf-next,v2,16/17] selftests/bpf: Add tests for callx through pointers in read-only data
>      https://git.kernel.org/bpf/bpf-next/c/b018e998e645
>    - [bpf-next,v2,17/17] bpf, docs: Document callx instruction
>      https://git.kernel.org/bpf/bpf-next/c/fd318eab4b09
> 
> You are awesome, thank you!


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9E62931EE
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 05:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790229090; cv=none; b=iDogM66JoFZwyCiarWSx9BZ4/IxGBLvxbgODQGDXu9KVDfWs701PqRenMHxYdgrljYFtxKmXVtE7f00ROiFKzFaY4a2Fl2nJkY0iVJnSfEQYG+T4TaZwN1BOFlPgtDozeIqdiOevZq4cmwsbsNfEQ/1DNNDCiZXz1jChLbzFic8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790229090; c=relaxed/simple;
	bh=YYqAZ2If+Qtg0+94+hClVusgL6OpIQ+iHwRYfdAtZh8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kv2jPNtUaxBY9IOVOLRNKbsvf85+VU9Zye/7FphBWPfZkbkgRELCDowxLnM1lM+MPURMb9bO+xNRcUu3vNLGzvmBYnUSp2yrA3uYEdAfd+a4bOudzQpHSu1i5A0fYM2eTlMkcLYrXokjyCx8lJTJmSpiSvP0NfH31Nht1Bk78/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lp4fico0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lp4fico0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4601F000FF;
	Thu, 24 Sep 2026 05:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790229087;
	bh=Zhm21WsPX/ZHNUAX57uojAbIY6/DxEHRS2ZpYtAJ+vg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Lp4fico0dny7PBCy6Spw8rBy4B0NU9Jg4ddQ+842iKu6KVB5u9BEagWgjFU3UxFWG
	 a6Bdu5Akbcvp15umbkaSzVJ5PTGimhKSgjzLpeGNHv3b9yGxznbYGx4y6aW1iy+G2E
	 F05h9rr6+BwJmLn3rLaed8AJgaXahtmQt013DgjnyDJMcJ4yxfyZPkd/dnna2m/uF7
	 mHRkZz0yCMwT6Sk3Xga8auKBts+S9xjgfPaw3SyW/UKUccO9ejGqFYQKK6ZHGptuK6
	 HrG9laea57ZxIPUjoLSISlYRngISwItisJmDGfIiA8psOab5TC2WgkZAnL2vxc/Qla
	 IeHcBR18glHkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AD139EAF44;
	Thu, 24 Sep 2026 05:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 00/17] bpf: Indirect calls of bpf subprogs
 (callx)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179022901639.1337807.12766583921039284951.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 05:50:16 +0000
References: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 24 Sep 2026 03:10:25 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> v1->v2:
> - Dropped "bpf: Don't fold loads from insn_array maps into constants".
>   bpf_map_direct_read() rejects insn_array already.
> - patch 1: emit the same diag as sort_subprogs_topo() (bpf-ci).
> - patch 3 is new: taking the address of a function that is never called
>   hit verifier_bug() in jit_subprogs(). Not related to callx, but callx
>   makes it likely.
> - patch 4: BPF_OP() == BPF_CALL in liveness like in const_fold, explained
>   in the comment why slots are live before callx callsite (Eduard).
> - patch 5: moved !bpf_is_callx() into nested 'if' (Eduard). JIT support
>   is checked before the type of the register.
> - patch 6: sync callbacks are in the call graph too. Stack depth of
>   a callback whose address is read from .rodata or taken in another
>   subprog was not accounted.
> - patch 10:
>   . check_cfg() explores functions of a table one at a time. It was
>     losing changes_pkt_data and other effects of the functions in
>     a table that call each other.
>   . no cmpxchg64(), it's not available on all 32-bit archs.
>   . don't reject the prog that reads a pointer to a function that was
>     removed as dead code (sashiko).
>   . load of the pointer sets jit_required, so the prog that passes it to
>     a helper as a callback can't run in the interpreter (bpf-ci).
>   . tbl[i].data at variable offset is a regular load when none of
>     the possible offsets overlaps with a pointer (bpf-ci).
> - patch 12: append the functions and copy the map only for progs that
>   have callx. The rest use .rodata as-is (bpf-ci). Pass token_fd to map
>   create. Dropped dead bpf_map_lookup_elem() fallback.
> - patch 14: light skeleton reserves fd_array slots only when the object
>   has callx.
> - selftests: anchored callx_retval_is_tracked to the caller, the tests
>   of global func in a table and of const folding of the pointer test what
>   they claim now, skip without JIT, fixed ASSERT_GT() of u32 and
>   the comment, added tests for the above (bpf-ci). The table in
>   callx_rodata_lskel test is volatile. clang was turning it into
>   direct calls, so the test didn't test light skeleton.
> - Added acks.
> v1: https://lore.kernel.org/bpf/20260922011323.1298619-1-alexei.starovoitov@gmail.com/
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,01/17] bpf: Fix infinite loop in check_max_stack_depth()
    https://git.kernel.org/bpf/bpf-next/c/f2c33a159190
  - [bpf-next,v2,02/17] selftests/bpf: Test recursion through a global function and a callback
    https://git.kernel.org/bpf/bpf-next/c/6cec7366b5ce
  - [bpf-next,v2,03/17] bpf: Keep functions with address taken when removing dead code
    https://git.kernel.org/bpf/bpf-next/c/fb1f5ac185b7
  - [bpf-next,v2,04/17] bpf: Prepare static analysis passes for callx instruction
    https://git.kernel.org/bpf/bpf-next/c/373e3fd0bff0
  - [bpf-next,v2,05/17] bpf: Add callx instruction to call bpf subprogs indirectly
    https://git.kernel.org/bpf/bpf-next/c/7f0f66c069ae
  - [bpf-next,v2,06/17] bpf: Add callx calls to the call graph
    https://git.kernel.org/bpf/bpf-next/c/b7151a69bc6e
  - [bpf-next,v2,07/17] bpf, x86: Add JIT support for callx
    https://git.kernel.org/bpf/bpf-next/c/69a30e5fe5a8
  - [bpf-next,v2,08/17] bpf, arm64: Add JIT support for callx
    https://git.kernel.org/bpf/bpf-next/c/11a516144d9a
  - [bpf-next,v2,09/17] bpf: Discover subprogs described by func_info
    https://git.kernel.org/bpf/bpf-next/c/3a03595510dc
  - [bpf-next,v2,10/17] bpf: Recognize pointers to functions in read-only maps
    https://git.kernel.org/bpf/bpf-next/c/a04286f6d828
  - [bpf-next,v2,11/17] libbpf: Support pointers to static functions in data when linking
    https://git.kernel.org/bpf/bpf-next/c/296fd4782754
  - [bpf-next,v2,12/17] libbpf: Resolve pointers to functions in read-only data
    https://git.kernel.org/bpf/bpf-next/c/b223044a68d5
  - [bpf-next,v2,13/17] libbpf: Treat .data.rel.ro as read-only data
    https://git.kernel.org/bpf/bpf-next/c/6ec77f0a7697
  - [bpf-next,v2,14/17] libbpf: Support pointers to functions in read-only data in light skeleton
    https://git.kernel.org/bpf/bpf-next/c/9f99fc05fc92
  - [bpf-next,v2,15/17] selftests/bpf: Add tests for callx
    https://git.kernel.org/bpf/bpf-next/c/e9b22d50796d
  - [bpf-next,v2,16/17] selftests/bpf: Add tests for callx through pointers in read-only data
    https://git.kernel.org/bpf/bpf-next/c/b018e998e645
  - [bpf-next,v2,17/17] bpf, docs: Document callx instruction
    https://git.kernel.org/bpf/bpf-next/c/fd318eab4b09

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



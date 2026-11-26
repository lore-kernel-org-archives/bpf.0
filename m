Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795656615;
	b=ZDQXUBlbMG7g2dHKQpKqFtoJH0n2yXj6MVrNdvwYkrhbts80AJSNhp4D1/nyzGV9VSNa
	 RnPi2IZ0dmUCjwQ8R/T+ciiAfRskUIlADIopxE08XTuphfEN56EhiZt+YQR4REVlqkNw+
	 NtpFrEynf36csbMCh/rCarkLTv7Fmd9/5QpEuLCF+47euKDmKDxyDiqmKMMsw7MoGfP5Z
	 o4622HTDmcvbdVJS0bMpN3j65Dtpp9Vx5Ke21vpHFaq5KhI3qmHwDRX4m/poxyMT7gTf5
	 a7ry1eiAgQXjpezilQXxhYVrX8uwHvfEVWHaLPSu5g7c4p4RxMRMkqDrPt6nP9sKpRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795656615;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=yAqf7lYAGziMschAeGErtYtYStKdMWrJr3pO79aVOCY=;
	b=3ZvNALeulMKSf2R0EoBbb/gv36lGZY1xRC6WzmyCWpfRJ5AV0XXKejEYcQ8MHeqPHQnQ
	 b1jvQz6nZEyQDOlqVJ1dAoNSYA29IKBrVhg468cKzFnH70DBn1Z+OX4S8QhjtNVj55Gx/
	 QDI6IgLujL75mBn71n1L+ufZ2QWCT4MSfhB44J05ONQnsNPitRDwXXZ/M5Kbr7VewjD5/
	 0dITZNY9tvXdSEqbKvO+uBDu+ZJ/K2apNv3jl/NWtNqTRtmGSGZWlFGAEiGE+1S97RSNO
	 mmRdzgf/WCA9yF37Ixd7q2AFaqLiqRrwmPuzIlsFH0E27HRzeVJCVJ4Ri9jh+JT4ZBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qg3W4fp8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F8E606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 01:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qg3W4fp8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A2B1F000CA;
	Thu, 26 Nov 2026 01:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795656615;
	bh=yAqf7lYAGziMschAeGErtYtYStKdMWrJr3pO79aVOCY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Qg3W4fp8VdZDHvNd7bhcR7g8JmX8OI8lL1ye6mEsBzAF0xDemzpEHygyEDWr4a0hH
	 MI6MteTz8cVmizkkDNw0wt9eG+LyJEMza2OagW0ms78/JbdEovbMOUwxjz/dx99s9V
	 SFnYbHUOzmv42bMozCymLkWsXNAFvzrFm6R2UJwhFTrS2OUkR7H1t7Gh82l5c5F7yn
	 UScgKYJ0xrR4H9CMWEtiSy9FlO2r1Q1n4jboMkSocB10z8yr21oKEnza8DJnHNjg//
	 P7HwzhWLxeJfiBOgX/8NvJ4H2bFh1LJIyTRRUdG/lTflmp5OZ7UwHl5AHJoujl/N03
	 MiLwOE2wAN/qA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15623809A24;
	Thu, 26 Nov 2026 01:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
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
Subject: Re: [PATCH bpf 00/47] bpf: Fixes for hooks, tail calls, CAP_BPF,
 JITs and sockmap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179565661377.1434942.15476923037679347488.git-patchwork-notify@kernel.org>
Date: Thu, 26 Nov 2026 01:30:13 +0000
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 25 Nov 2026 03:28:51 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> These patches fix bugs in BPF:
> 
>   patches  area
>   -------  ----------------------------------------------------------------
>   01-04    what the verifier trusts: pointers, attach types, ranges, ids
>   05-08    extensions and tail calls: they run in the hook of another prog
>   09       struct_ops: the struct of a prog
>   10       bpffs: delegate options
>   11-12    NULL in tracepoints and helpers
>   13-15    bpf_throw(): tracers, KASAN, symbols, line info
>   16       XDP redirect in async callbacks
>   17-18    checks at attach and load: cgroup links, signed programs
>   19-20    bpf_lock, dumps of the stack
>   21-22    arena: the length of mmap(), TLB
>   23-24    prints of BTF enums, the result of bpf_res_spin_lock()
>   25-33    kernel addresses and tasks: CAP_BPF is not enough
>   34-37    x86 and arm64 JIT
>   38-43    skb, XDP, sk_msg and sockaddr helpers
>   44-45    sockmap
>   46       libbpf
>   47       struct_ops: the type of r0 at exit
> 
> [...]

Here is the summary with links:
  - [bpf,01/47] bpf: Do not trust pointers in flexible arrays
    https://git.kernel.org/bpf/bpf/c/2acad73b68ca
  - [bpf,02/47] bpf: Look at the type of a program next to expected_attach_type
    https://git.kernel.org/bpf/bpf/c/e74ff9b13b44
  - [bpf,03/47] bpf: Do not take bpf_get_retval() of struct bpf_tcp_ops for an errno
    https://git.kernel.org/bpf/bpf/c/7ee82af6e463
  - [bpf,04/47] bpf: Do not allow bpf_d_path() by an id of another BTF
    https://git.kernel.org/bpf/bpf/c/1139c7d8ffcd
  - [bpf,05/47] bpf: Check that an extension fits the hook of its target
    https://git.kernel.org/bpf/bpf/c/f44d0e6a1d68
  - [bpf,06/47] bpf: Take the attach type of the target for tail calls of an extension
    https://git.kernel.org/bpf/bpf/c/3d6d222bb979
  - [bpf,07/47] bpf: Compare what a hook tells next to its prototype at tail calls
    https://git.kernel.org/bpf/bpf/c/98ff9cff0b94
  - [bpf,08/47] bpf: Reserve cookie and ip in the trampoline for tail calls
    https://git.kernel.org/bpf/bpf/c/bf675c921655
  - [bpf,09/47] bpf: Check that a program and a struct_ops map are for the same struct
    https://git.kernel.org/bpf/bpf/c/80184a7381c1
  - [bpf,10/47] bpf: Keep the names in front of a number in delegate options
    https://git.kernel.org/bpf/bpf/c/4151f3558d6e
  - [bpf,11/47] bpf: Do not trust the neighbour of tp_btf/neigh_create
    https://git.kernel.org/bpf/bpf/c/2c517088d2ef
  - [bpf,12/47] bpf: Check for NULL in helpers that take a kernel pointer
    https://git.kernel.org/bpf/bpf/c/a6de3c4be04d
  - [bpf,13/47] bpf: Leave nothing behind in the frame of bpf_throw()
    https://git.kernel.org/bpf/bpf/c/86cedb416c46
  - [bpf,14/47] bpf: Add the symbol of a prog before its id
    https://git.kernel.org/bpf/bpf/c/f7a40c2de8d4
  - [bpf,15/47] bpf: Do not fill jited line info for a hidden subprog
    https://git.kernel.org/bpf/bpf/c/2f2b119ea30d
  - [bpf,16/47] bpf: Fix NULL dereference in XDP redirect from async callbacks
    https://git.kernel.org/bpf/bpf/c/f28ed533106b
  - [bpf,17/47] bpf: Check the attach type when a cgroup link gets another program
    https://git.kernel.org/bpf/bpf/c/a5e757f6cb34
  - [bpf,18/47] bpf: Refuse metadata maps of signed programs that can be mapped writable
    https://git.kernel.org/bpf/bpf/c/c66c8adf3226
  - [bpf,19/47] bpf: Take bpf_lock with interrupts disabled
    https://git.kernel.org/bpf/bpf/c/2c00b6b35af0
  - [bpf,20/47] bpf: Bound the time that dumps of the stack take
    https://git.kernel.org/bpf/bpf/c/a70da21f98e0
  - [bpf,21/47] bpf: Refuse mmap() of a part of an arena
    https://git.kernel.org/bpf/bpf/c/0cd1f2029b1b
  - [bpf,22/47] bpf: Flush TLB when a page of arena replaces the scratch page
    https://git.kernel.org/bpf/bpf/c/16829046f0a0
  - [bpf,23/47] bpf: Fix reads past an enum in prints of BTF data
    https://git.kernel.org/bpf/bpf/c/6c8d5a113c23
  - [bpf,24/47] bpf: Give the error of bpf_res_spin_lock() a 32-bit range
    https://git.kernel.org/bpf/bpf/c/703826e497ff
  - [bpf,25/47] bpf: Give syscall programs without CAP_PERFMON the base helpers only
    https://git.kernel.org/bpf/bpf/c/2ff55b023f63
  - [bpf,26/47] bpf: Require CAP_PERFMON for kfuncs that leak pointers or touch tasks
    https://git.kernel.org/bpf/bpf/c/3e03955a6518
  - [bpf,27/47] bpf: Require CAP_PERFMON to read streams
    https://git.kernel.org/bpf/bpf/c/54b59a467bc7
  - [bpf,28/47] bpf: Limit reads of variables of the kernel
    https://git.kernel.org/bpf/bpf/c/419c69483a62
  - [bpf,29/47] bpf: Require CAP_PERFMON for dumps of xlated insns
    https://git.kernel.org/bpf/bpf/c/b8aa487429d4
  - [bpf,30/47] bpf: Zero bpf_list_head in copies of map values
    https://git.kernel.org/bpf/bpf/c/8252c3517f95
  - [bpf,31/47] bpf: Require CAP_PERFMON to read pinned maps with special fields
    https://git.kernel.org/bpf/bpf/c/398557b30b9c
  - [bpf,32/47] bpf: Require CAP_PERFMON to pass values of insn_array as memory
    https://git.kernel.org/bpf/bpf/c/5fec973f49da
  - [bpf,33/47] bpf: Require CAP_PERFMON for the dump of all storages of sockets
    https://git.kernel.org/bpf/bpf/c/f9e4fda5eb35
  - [bpf,34/47] bpf, x86: Do not use the paranoid ITS thunk
    https://git.kernel.org/bpf/bpf/c/9bc9dab41113
  - [bpf,35/47] bpf, x86: Enforce alignment of atomics in arenas
    https://git.kernel.org/bpf/bpf/c/62a99ab25c91
  - [bpf,36/47] bpf, x86: Fix the range of BPF code that has a frame pointer
    https://git.kernel.org/bpf/bpf/c/1c34522e8b78
  - [bpf,37/47] bpf, arm64: Restore the shadow call stack pointer after an exception
    https://git.kernel.org/bpf/bpf/c/918bea2c6b68
  - [bpf,38/47] bpf: Clear the data that bpf_msg_push_data() adds
    https://git.kernel.org/bpf/bpf/c/401fce9f48b1
  - [bpf,39/47] bpf: Fail loads from a network header that was not set
    https://git.kernel.org/bpf/bpf/c/766907cdaeef
  - [bpf,40/47] bpf: Fix slices behind the end of an XDP packet
    https://git.kernel.org/bpf/bpf/c/2fc7a1733992
  - [bpf,41/47] bpf: Clear family and port of a short address for cgroup sockaddr hooks
    https://git.kernel.org/bpf/bpf/c/2abc088aae54
  - [bpf,42/47] bpf: Take a neighbour of the L3 master in bpf_redirect_neigh()
    https://git.kernel.org/bpf/bpf/c/c1b5decc7314
  - [bpf,43/47] bpf: Keep the MAC header in bpf_skb_change_tail()
    https://git.kernel.org/bpf/bpf/c/28ffeb9cb972
  - [bpf,44/47] bpf, sockmap: Keep the parser and sk_data_ready in sync
    https://git.kernel.org/bpf/bpf/c/b3a433f20f0a
  - [bpf,45/47] bpf, sockmap: Hold the psock of the work in sk_psock_backlog()
    https://git.kernel.org/bpf/bpf/c/9abfa0ad4f76
  - [bpf,46/47] libbpf: Fix struct_ops members 59-61 and optional struct_ops maps
    https://git.kernel.org/bpf/bpf/c/434ea9c5125a
  - [bpf,47/47] bpf: Check the type of R0 at the exit of a struct_ops program
    https://git.kernel.org/bpf/bpf/c/65e362827a6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



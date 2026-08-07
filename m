Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADD74B04BE;
	Fri,  7 Aug 2026 03:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786072366; cv=none; b=VrRf7orper3kT2qMLwoBNYHc7atubItUI16U3z/MUyLVjDLIq2FYLsRo82rGGscxSGMTMeAZClQ4pYMF5hEaAzzEt1Qu5LPsK6XKzEpeRb+JgbrE2Ki12dwW12fDKuirOy4o7cIMkqy+dcZiE923jYF7SOx6HxA5/pB+E0uiKjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786072366; c=relaxed/simple;
	bh=0HgOx7/Pj5zndNbstidWTIjN6pM5lH4vWFEQwOGm4DQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lWYWdqdsEFqbW3llTOGUkzlG72ntxzAYLqg9uKeJCnL7+dqRTY/nhbGQgsoS3ZjB0OtMj23v+OyfUDI/H0eCeN9swuL+uUR4j3G9wtHA3bcLBb0gfyzy6XfDPCtdPoWXeuwCtXq7Kd+Q2KUSVsaO31zpxN462sUSnWUphyha6A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfCLDSat; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfCLDSat"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D021F000E9;
	Fri,  7 Aug 2026 03:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786072364;
	bh=TKoPvYzwdFSDzD4WBzYKwi8zCPzsID1+6n1mKOfGKxM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=UfCLDSatgC+Gal0pnC++4G/vohSPoVyrDHj9mI24uL8sdbvpAbeh6vBHNx0vwcVw+
	 ccraV3stkWhj6v/40hsiKNI45YW+sjYnO71DWk1NihdzcToVced6+uB9vEMtA52m18
	 F3Vnk40Kww/voiX9HxW76BxJCR7rGyCiSyvtcurBUZ/JjvpHqqEzisgGkSBDsKzKzr
	 2ujLIilvhAbyrtxso/gMLmW0drQAAe302jWmHgLXl+f3bSo1qRTx0WPG+c63iRuJPH
	 PIBh8XCUVes9fyHvlqfN7XFss+Jcap9Vgi7lpIFPMLNZAm0wdeKvCv2ACp/bJyyJ12
	 APUP1u7+rv+GA==
Date: Thu, 6 Aug 2026 21:12:42 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>
cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
    Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
    Alexandre Ghiti <alex@ghiti.fr>, Andy Chiu <andybnac@gmail.com>, 
    =?ISO-8859-15?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>, 
    Steven Rostedt <rostedt@goodmis.org>, 
    Masami Hiramatsu <mhiramat@kernel.org>, bpf@vger.kernel.org, 
    Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH] riscv: ftrace: Fix ftrace_modify_call failure on kprobed
 functions
In-Reply-To: <20260802094929.3978390-1-pulehui@huaweicloud.com>
Message-ID: <4a7ed7d1-9eda-3082-81cb-5375b7839f29@kernel.org>
References: <20260802094929.3978390-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

On Sun, 2 Aug 2026, Pu Lehui wrote:

> From: Pu Lehui <pulehui@huawei.com>
> 
> We are frequently hitting the following splat during the riscv bpf
> selftests:
> 
> 00000000026dc75a: expected (7c3ff297) but got (00100073)
> ------------[ ftrace bug ]------------
> ftrace failed to modify
> [<ffffffff03c44c1c>] bpf_kfunc_common_test+0x4/0x20 [bpf_testmod]
>  actual:   e7:82:c2:ce
> Updating ftrace call site to call a different ftrace function
> ftrace record flags: 80100002
>  (2)
>  expected tramp: ffffffff80043904
> ------------[ cut here ]------------
> WARNING: kernel/trace/ftrace.c:2278 at ftrace_bug+0x46e/0x4b0, CPU#1: test_progs/98
> ...
> [<ffffffff80008f4e>] ftrace_bug+0x46e/0x4b0
> [<ffffffff803d3e86>] ftrace_replace_code+0x16e/0x170
> [<ffffffff803d42b6>] ftrace_modify_all_code+0x12e/0x1b8
> [<ffffffff800430f4>] arch_ftrace_update_code+0x14/0x28
> [<ffffffff803e0324>] ftrace_startup+0x14c/0x2a0
> [<ffffffff803e133c>] ftrace_startup_subops+0x584/0x1050
> [<ffffffff804500e6>] register_ftrace_graph+0x4e6/0x1018
> [<ffffffff804cf9f6>] register_fprobe_ips+0xc66/0x12f8
> [<ffffffff8049abe8>] bpf_kprobe_multi_link_attach+0x5d8/0xe68
> [<ffffffff8050fcaa>] __sys_bpf+0x3d5a/0x47f0
> [<ffffffff805107ee>] __riscv_sys_bpf+0xae/0x168
> [<ffffffff80034d78>] syscall_handler+0x60/0x100
> [<ffffffff8228b4f4>] do_trap_ecall_u+0x174/0x208
> [<ffffffff822b69c4>] handle_exception+0x16c/0x178
> 
> After debugging, it can be triggered by similar commands below:
> ```
> echo do_nanosleep > set_ftrace_filter
> echo function > current_tracer
> echo 'p do_nanosleep' > kprobe_events
> echo 1 > events/kprobes/enable
> echo 'f do_nanosleep' > dynamic_events

I guess you meant 

echo 'f do_nanosleep' >> dynamic_events

instead?

> echo 1 > events/fprobes/enable
> ```
> 
> The reason is that attaching a kprobe to an ftrace-traced function entry
> replaces its initial auipc insn with ebreak. When ftrace_modify_call
> later runs, it expects auipc insn, so verification fails and triggers
> ftrace_bug.
> 
> The expected auipc logic remains conceptually unchanged, and kprobe
> single-stepping ensures normal execution. Therefore, if the first insn
> is ebreak, bypassing the check to continue patching the jalr insn is
> safe and avoids ftrace failures.
> 
> Fixes: b2137c3b6d7a ("riscv: ftrace: prepare ftrace for atomic code patching")
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

I queued the patch with the reproduction sequence updated as mentioned 
above for v7.2-rc.  Please let me know ASAP if you don't agree -


- Paul

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A11330B10
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104529; cv=none; b=gwHzuYmG5QQXmmRAetYKBp/c1yWc8tcwk1H8C7b0w1/QcSap1bvibL1SEYkxcBPsrM41+uJoq0axtJZvB4BzMfQ+maBmoy2UM92G4xhKrORMVrIrC6l47Kmcmg2eSkA1hnCWRQs/1lzcPV/42p+7Xqa8EWA1Yo9NOIFW4BWllHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104529; c=relaxed/simple;
	bh=SSeTYrk6DxFnOZGx7luqCwiinStUnL9aJI7UyILYpts=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VmE+hwROrPZBmElpSDBBYktimboAX2bOUES8M8v+mX9sSvqGZ/7LmE86KGaKmjaqGbFPdXgxWiZNa+uD+alKSqYWT8kXzttvIju6W6OmtPP5RaQh/WpF2YPDNBDZdwisO0qYT4kmHVa+zf+Yi1E27/UFXT2s5MP2our8eigH1Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKfHt6/t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKfHt6/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE128C2BCF6;
	Mon, 18 May 2026 11:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779104529;
	bh=SSeTYrk6DxFnOZGx7luqCwiinStUnL9aJI7UyILYpts=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=eKfHt6/tVndcsAXSQCvOeI29bN1LEwueekrpu7e1luR7QR+yK1VX9tjOdPcJvfhdu
	 DYDWAPcDyU1dShgieQSJ9y0LCQRFdc17+5pIan8GkiZJqWFdIcMcziXPrWVMmAaVGB
	 /8LTrxqAOqULfbE63wc4vfhfHcWFjthQ4cfjc3CfaKWY9Qyskjudv55py/0sRtI0I7
	 JeHxVoxQEnqM/yJohecWfRil8SQZuYwxJ+7MmcpaGYTy2topSjtmKh6lGrTXVk//ge
	 YxiEtnTcxm8I0npEBniTYr7ELQWvN8B+LfENF7Q71KJEq/Pg3s4GVtX7FJXfXGvnHk
	 19JoeOjSGOQZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 02/11] uprobes/x86: Allow to copy uprobe trampolines
 on fork
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260518105957.123445-3-jolsa@kernel.org>
References: <20260518105957.123445-3-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 11:42:08 +0000
Message-Id: <20260518114208.CE128C2BCF6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] __in_uprobe_trampoline uses current->mm instead of the target =
mm_struct, causing kernel crashes and instruction stream corruption during =
uprobe_unregister.
- [High] Removing VM_DONTCOPY without synchronizing the uprobes state cause=
s a linear VMA leak across fork chains.
--

commit be0e6254bd9df4f56adce23d7a5e24a78c286291
Author: Jiri Olsa <jolsa@kernel.org>
uprobes/x86: Allow to copy uprobe trampolines on fork

This commit allows vma uprobe trampoline objects to be copied on fork to
the new process by removing the VM_DONTCOPY flag.

> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -702,7 +702,7 @@ static struct uprobe_trampoline *create_uprobe_trampo=
line(unsigned long vaddr)
> =20
>  	tramp->vaddr =3D vaddr;
>  	vma =3D _install_special_mapping(mm, tramp->vaddr, PAGE_SIZE,
> -				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_DONTCOPY|VM_IO,
> +				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_IO,

Does removing VM_DONTCOPY without synchronizing the uprobes state cause a
linear VMA leak across fork chains?

When dup_mmap() copies the uprobe trampoline VMA to the child process during
fork(), the child's tracking list (mm->uprobes_state.head_tramps) is
initialized as completely empty via mm_init_uprobes_state(), meaning the
parent's state is not duplicated.

When the child process executes a uprobe, arch_uprobe_optimize() calls
get_uprobe_trampoline(). Because head_tramps is empty, it fails to find the
VMA it already inherited. It then falls back to create_uprobe_trampoline(),
which calls find_nearest_trampoline(). Since the inherited VMA is already
mapped, find_nearest_trampoline() finds a new unmapped area and installs a
second duplicate trampoline VMA.

In a deep fork chain, each generation inherits all previous VMAs, has an
empty head_tramps list, and creates a new VMA. Can this cause a linear
accumulation of redundant VMAs, eventually exhausting vm.max_map_count and
virtual memory?

As a related question about the uprobe trampolines introduced in the preced=
ing
commit ba2bfc97b462, does __in_uprobe_trampoline() safely handle unregister=
ed
uprobes?

When a uprobe is unregistered (e.g., via bpf_uprobe_unregister in a workque=
ue
or by a different process like perf), set_orig_insn() calls is_optimized() =
to
check if the uprobe is optimized. If is_optimized() internally calls
__in_uprobe_trampoline() which hardcodes current->mm for the VMA lookup, do=
es
it completely ignore the passed mm parameter?

If unregistered asynchronously from a kernel thread, current->mm is NULL. C=
an
this cause a deterministic NULL pointer dereference in vma_lookup() and cra=
sh
the kernel?

Additionally, if unregistered by a different process, would vma_lookup()
search the wrong mm, return false, and cause set_orig_insn() to incorrectly
assume the instruction is not optimized? Could this lead to replacing only
the first byte of the 5-byte CALL instruction with the original opcode,
leaving the 4-byte relative offset as garbage and crashing the traced proce=
ss
when it executes the corrupted instruction?

>  				&tramp_mapping);
>  	if (IS_ERR(vma)) {
>  		kfree(tramp);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518105957.1234=
45-3-jolsa@kernel.org?part=3D1

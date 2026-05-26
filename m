Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA743A4523;
	Tue, 26 May 2026 21:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832011; cv=none; b=F9xpG91TNPOM2pnyHxrccKstdNs8UIhrpOM7wzVmzMi1Jd6X77Af0tKAUOlvL4KXVQEaNhUwG04f4LFh5Qw1t1lmX3ASTzrKnTJv04/VTijqqWsYVn8VFaMQFyeKqgyQYnPISMELMMf2Vo9a+n64SpiEfI8wYx3WE5bkNBblu5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832011; c=relaxed/simple;
	bh=WSUAOSUPo6geJlcixk0FB+dt9UABheUqIDTN6TT9TVk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FMKvF9oO2MvuApI2c8AiVcbT7KR/DW5vvmnMkoTn7yJfKmaAgtgZPlqmB2e0JMYvWJDzFeeQ7LGmu0ZgWssv9H7chRAUiLeRTZRbvMZ6F4N5FPy0DNJSTjylNYBUPIdMo6f1Q3cLSHu7CyygYCsH5qVxSJyqioLDou5QjeUAkTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oz3KExNr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oz3KExNr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74BE1F000E9;
	Tue, 26 May 2026 21:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779832009;
	bh=ZXkkXJRTk/8zwj+Slmf1tKjqifj94v2pK6gYJ0fGcK8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=oz3KExNrci9PV4j/T8HiadoXiVgEf0lUzQ6TnidmYvlylZou/w91Yv6TwCVJm99WS
	 /MQjIQ9LiJXZoiOHyirBGLegKTPEHCfkMHLcAlltSnjQOSLLzII/LZakF2JzB/1cDr
	 KmbMAn6oxLUQX4VKaIVnwGE7Ib33a5PmFNC3yoXuFZHFo7YxNFTmuP3VIhQOFRiMAf
	 KkauZwQOk90T5JqMg8CKJ0nCWQPc3xUR60CynQGPPn54G+9ZvQE+GOqRf3rmsyF2L6
	 ZZ6gxL4mcsJESIbUD1UlNhQKtflZO7EssyklmBmY1wf2zkgm03H7a5Iq8KrsdUdGq7
	 3fYY/PONXS7ag==
Content-Type: multipart/mixed; boundary="===============0785503471317599894=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <addf3472e04583c864492a9343420c1e0356b324b4a84a71145dd759d8ec367d@mail.kernel.org>
In-Reply-To: <20260526205840.173790-5-jolsa@kernel.org>
References: <20260526205840.173790-5-jolsa@kernel.org>
Subject: Re: [PATCHv4 04/13] uprobes/x86: Unmap trampoline vma object in case it's unused
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,oleg@redhat.com,peterz@infradead.org,mingo@kernel.org,mhiramat@kernel.org,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 26 May 2026 21:46:49 +0000 (UTC)

--===============0785503471317599894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 68883203f0583fb1a8d79536f5c8945542974abd
> Author: Jiri Olsa <jolsa@kernel.org>
> Date:   Tue May 26 22:58:31 2026 +0200
>
>     uprobes/x86: Unmap trampoline vma object in case it's unused
>
>     In case the optimization fails, we leak new-ly created trampoline
>     vma mapping (in case we just created it), let's unmap it.
>
>     Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
>     Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Should this Fixes: tag point to a9fe6f54968c instead? The vma leak bug
was actually introduced by commit a9fe6f54968c ("uprobes/x86: Remove
struct uprobe_trampoline object"), not ba2bfc97b462. Commit a9fe6f54968c
removed the destroy_uprobe_trampoline() cleanup call, and its commit
message explicitly states: "The new vma leak is fixed in following
change."

Suggested: Fixes: a9fe6f54968c ("uprobes/x86: Remove struct
uprobe_trampoline object")

> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index c8af41ed681a..af5af7d67999 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -677,11 +677,14 @@ static unsigned long find_nearest_trampoline(unsigned long vaddr)
>  	return high_tramp;
>  }
>
> -static struct vm_area_struct *get_uprobe_trampoline(struct mm_struct *mm, unsigned long vaddr)
> +static struct vm_area_struct *get_uprobe_trampoline(struct mm_struct *mm, unsigned long vaddr,
> +						    bool *new_mapping)
>  {
>  	VMA_ITERATOR(vmi, mm, 0);
>  	struct vm_area_struct *vma;
>
> +	*new_mapping = false;
> +
>  	if (vaddr > TASK_SIZE || vaddr < PAGE_SIZE)
>  		return ERR_PTR(-EINVAL);
>

Does this fix address the VMA leak scenario across fork chains? In v2,
sashiko-bot raised a concern about inherited-but-not-tracked VMAs:

https://lore.kernel.org/bpf/20260518114208.CE128C2BCF6@smtp.kernel.org/

When VM_DONTCOPY is removed, child processes inherit trampoline VMAs
but their tracking list (mm->uprobes_state.head_tramps) is empty. When
the child executes a uprobe, get_uprobe_trampoline() fails to find the
inherited VMA and creates a duplicate trampoline.

Child fork:
  dup_mmap()
    copies trampoline VMA to child
  mm_init_uprobes_state()
    initializes head_tramps as empty (parent's state not copied)

Child executes uprobe:
  arch_uprobe_optimize()
    get_uprobe_trampoline()
      head_tramps is empty, fails to find inherited VMA
      create_uprobe_trampoline()
        find_nearest_trampoline() finds new unmapped area
        installs second duplicate trampoline VMA

In a deep fork chain, each generation inherits all previous VMAs, has an
empty head_tramps list, and creates a new VMA. Can this cause linear
accumulation of redundant VMAs, eventually exhausting vm.max_map_count?

While this patch addresses unmapping failed optimization attempts, it
does not prevent the inherited-but-not-tracked VMA leak scenario in fork
chains.

> @@ -696,6 +699,7 @@ static struct vm_area_struct *get_uprobe_trampoline(struct mm_struct *mm, unsign
>  	if (IS_ERR_VALUE(vaddr))
>  		return ERR_PTR(vaddr);
>
> +	*new_mapping = true;
>  	return _install_special_mapping(mm, vaddr, PAGE_SIZE,
>  				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_IO,
>  				&tramp_mapping);

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26475828601
--===============0785503471317599894==--

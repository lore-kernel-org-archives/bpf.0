Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19FC29A32D;
	Tue, 26 May 2026 21:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832006; cv=none; b=XozUSir5kWKlUyGzDrcXyoo1gEBepNq2heWekNnzkof6XaOFcQCa6ZMf+cUAkJOHHWIUaWFVSOhxo9XDKhJQzKrYKPlP2pAw8kBX1cmgTXb2n0gdq8lYo0Tiue3lMhg3P0i31nKN0iIXPvXx3zkZxPSgTay8thQDa/m2us+pgWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832006; c=relaxed/simple;
	bh=WgjCZsYJQAP8foY6KUNIvshR2c8fqu4CYfGvw7bgZF0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=f/YJxoSWWKmaeNXCTW7qXGOu0TSjamS6q0Kg9ZuUmTwCk0Uw1wABlKPPZ9nb7kYHcxK/49RS17rB3zRBQjzUl0MlJ4zt8LrrdTNzs5KpZY5PwwT1KgQdLVvrFsSqorMeFX7PQJr94ajoEJzqP3nwOW9afAZzKVEuXA92YuwRFiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e76Wkwiq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e76Wkwiq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290E01F000E9;
	Tue, 26 May 2026 21:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779832004;
	bh=aIrbZKCRhS3iRDWsAMShf1yuOnw1ACzjPQ2vKc1IHrM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=e76WkwiqNEGG28EKs+SG8aN9uok1+XHrl812NRxUVllSjp8SbYghOC/ca1RuBtHR+
	 VmZbNwDaB933ocw3La40zY2AdFwB4RIcbyzkN2pyTVR2yxKZk0iiPiQ6QposJWOfx8
	 ZEsEwEVbs45/7QPZRwXw82mBCwlECoIL10Z9Fzdam9tcx5PM7QdS8wQDLkE2Nb2xLh
	 4plNEHJAmyhsFKfUO1zf0us5lPHC0ADN/GY1Z3ZLygOz8KgGnqPL5PL2hy83Cy9diB
	 BMeehbAlWI/w1nK20KjNJ654KEbRZl7xqpvo6STsJDeGsvaVm1+51kQqHKsvYz3Z0v
	 kHkPQjKYthCDg==
Content-Type: multipart/mixed; boundary="===============6468242954221287289=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <22e6111c3aa950ec8eaa29c776670e6f834f82249190a652b2afa9a9cb551d76@mail.kernel.org>
In-Reply-To: <20260526205840.173790-3-jolsa@kernel.org>
References: <20260526205840.173790-3-jolsa@kernel.org>
Subject: Re: [PATCHv4 02/13] uprobes/x86: Remove struct uprobe_trampoline object
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,oleg@redhat.com,peterz@infradead.org,mingo@kernel.org,mhiramat@kernel.org,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 26 May 2026 21:46:44 +0000 (UTC)

--===============6468242954221287289==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 2be6707e3320..733655bc610e 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c

[ ... ]

> @@ -1111,21 +1051,18 @@ int set_orig_insn(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>  static int __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_struct *mm,
>  				  unsigned long vaddr)
>  {
> -	struct uprobe_trampoline *tramp;
> -	struct vm_area_struct *vma;
> -	bool new = false;
> -	int err = 0;
> +	struct pt_regs *regs = task_pt_regs(current);
> +	struct vm_area_struct *vma, *tramp;
>
> +	if (!user_64bit_mode(regs))
> +		return -EINVAL;
>  	vma = find_vma(mm, vaddr);
>  	if (!vma)
>  		return -EINVAL;
> -	tramp = get_uprobe_trampoline(vaddr, &new);
> -	if (!tramp)
> -		return -EINVAL;
> -	err = swbp_optimize(auprobe, vma, vaddr, tramp->vaddr);
> -	if (WARN_ON_ONCE(err) && new)
> -		destroy_uprobe_trampoline(tramp);
> -	return err;
> +	tramp = get_uprobe_trampoline(mm, vaddr);
> +	if (IS_ERR(tramp))
> +		return PTR_ERR(tramp);
> +	return WARN_ON_ONCE(swbp_optimize(auprobe, vma, vaddr, tramp->vm_start));
>  }

When swbp_optimize() fails in __arch_uprobe_optimize() and the preceding
get_uprobe_trampoline() call created a new trampoline VMA via
_install_special_mapping(), does the new VMA leak in the process address
space?

The pre-patch code tracked whether the trampoline was newly created and
called destroy_uprobe_trampoline() on the failure path:

  err = swbp_optimize(auprobe, vma, vaddr, tramp->vaddr);
  if (WARN_ON_ONCE(err) && new)
      destroy_uprobe_trampoline(tramp);
  return err;

The new code drops that cleanup entirely:

  return WARN_ON_ONCE(swbp_optimize(auprobe, vma, vaddr, tramp->vm_start));

Although the old destroy_uprobe_trampoline only freed the struct (not the
underlying VMA), the new code appears to introduce a VMA leak: the freshly
mapped PAGE_SIZE special mapping in the user's address space stays mapped
even though optimization failed. arch_uprobe_optimize() then sets
ARCH_UPROBE_FLAG_OPTIMIZE_FAIL so subsequent calls won't retry, leaving the
orphan trampoline mapping in the address space until exit_mmap() reaps it at
process teardown.

The commit message mentions: "Note the original code called
destroy_uprobe_trampoline if the optimiation failed, but it only freed the
struct uprobe_trampoline object, not the vma. The new vma leak is fixed in
following change."

Is the VMA leak addressed in the subsequent commit in this series?

A secondary behaviour change is that 'return WARN_ON_ONCE(swbp_optimize(...))'
now returns the boolean truth value of the error (0 or 1) instead of the
original errno. While the current caller (arch_uprobe_optimize) only treats
the value as boolean, could this surprise a future caller that propagates the
return code?

Commit message:

>     uprobes/x86: Remove struct uprobe_trampoline object
>
>     Removing struct uprobe_trampoline object and it's tracking code,
>     because it's not needed. We can do same thing directly on top of
>     struct vm_area_struct objects.
>
>     This makes the code simpler and allows easy propagation of the
>     trampoline vma object into child process in following change.
>
>     Note the original code called destroy_uprobe_trampoline if the
>     optimiation failed, but it only freed the struct uprobe_trampoline
>     object, not the vma. The new vma leak is fixed in following change.
>
>     Acked-by: Andrii Nakryiko <andrii@kernel.org>
>     Signed-off-by: Jiri Olsa <jolsa@kernel.org>

CI bot suggested adding a Fixes tag in v3: 'Fixes: ba2bfc97b462
("uprobes/x86: Add support to optimize uprobes")' because the commit message
notes a VMA resource leak in the original code.

Reference: https://lore.kernel.org/bpf/8861cc7af8e0dfff2674ca4ae6381ea2d82c242dec115774e8e11048bde358c4@mail.kernel.org/

The author responded that 'the logic stays' and a separate fix is needed, but
did not explain why the Fixes tag should not be included. If this patch is
documenting a pre-existing bug (even if the full fix comes later), should it
include a Fixes tag for backporting purposes?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26475828601
--===============6468242954221287289==--

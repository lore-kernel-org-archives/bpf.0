Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C983A4523;
	Tue, 26 May 2026 21:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832002; cv=none; b=bNGrMu2rtBBvAp4F2t9VsKj614R9q0aauiKF15zpCkg2C2btZDTf79AWlU9GlQqBFiAXZ/hR75a8Fnp51nhWp73JaqhLdgVcPtpkJP5IFNs4Oha7Gia+FLxVi95V8FRyipZQeSS2xrsauezHu9O2reJQrApe9AsNuniW23BIqxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832002; c=relaxed/simple;
	bh=AIaIRZNS4yl1xo3jPF1YIGDA0kXB0VAH6xbyFHL0eD4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=IY7tQGcRfSdjP1xM419mnzqD3mpJaO/2t26z22VO1QtCGPlSUuA6DhThtMwVCOqfePF1VWeWO3yravncWtIEJTh6N0bDuN5Kf3KLiJf6x3VUiDMxuqsz+cnsQ2BxAXC4gqFyy06DsNucP+IGAdKGSFGRxoiS6CV5CJFlbI9mUVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koDGFubm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koDGFubm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F551F000E9;
	Tue, 26 May 2026 21:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779832000;
	bh=VpSfT+UWuDFTUhvnUlrWFh2yBv7oAThOPMT4uQoDU2E=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=koDGFubmDf+zg14SARuNBl3ymq3d6rI9gs5Xuay7ONJHmQTwD4/zOKwap2P6ij8tY
	 VCMO6RW8uaO7mdJfJ0UruRUuVjvb7ypVXnx3Oe4fxFMMZuIhSNBm5BebfnYxRrKyTN
	 HqvIpT/sGuEEc680iKf9PwPdrS+jhC4BykKWTWvYO/kjpVeMnxC4HVPsl+VYIi+mii
	 9RVhHdQL5SVFgdK+tgEAJYcRIze7IVUhLPvXZaxFQ8VvJzCuqksvJ15+REzgYVOtjt
	 PB34k6L3U4zXT6Xiz+ws7jw2XhDXjQ2cSUfmGzW9/++Ndm+lC/gCGs95YAscyeYbg6
	 CoumC+go5RsMQ==
Content-Type: multipart/mixed; boundary="===============4039224583989397285=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <aa6bd23387138013e5b10a9d9bacf6dfbcf9a2981ddb132a3d29e3c8524c65fa@mail.kernel.org>
In-Reply-To: <20260526205840.173790-4-jolsa@kernel.org>
References: <20260526205840.173790-4-jolsa@kernel.org>
Subject: Re: [PATCHv4 03/13] uprobes/x86: Allow to copy uprobe trampolines on fork
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,oleg@redhat.com,peterz@infradead.org,mingo@kernel.org,mhiramat@kernel.org,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 26 May 2026 21:46:40 +0000 (UTC)

--===============4039224583989397285==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 733655bc610e..c8af41ed681a 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -697,7 +697,7 @@ static struct vm_area_struct *get_uprobe_trampoline(struct mm_struct *mm, unsign
>  		return ERR_PTR(vaddr);
>
>  	return _install_special_mapping(mm, vaddr, PAGE_SIZE,
> -				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_DONTCOPY|VM_IO,
> +				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_IO,
>  				&tramp_mapping);
>  }

When a process with optimized uprobes is forked, the child inherits the
optimized code and trampoline. This means sys_uprobe invocations in the
child will go into the uprobe trampoline, and the syscall will keep
returning -EPROTO since no handler is registered.

Is there a way to restore the original memory pages for clones?

This behavior seems suboptimal from a performance perspective. For
standard int3-based uprobes, breakpoints are removed via
UPROBE_HANDLER_REMOVE. Could something similar be implemented for
optimized uprobes, perhaps with proper filtering in uprobe_multi?

Reference: https://lore.kernel.org/bpf/CAEf4BzYo-8PAXFJt9MHoUn9ux1O2YVxJADC0tGSsacVu_R8Stw@mail.gmail.com/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26475828601
--===============4039224583989397285==--

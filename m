Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7083BC660
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 20:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775940466; cv=none; b=D28gd+1+ddNTIWmqT66MXSHRdctOAsv19vgICQCakl+ipKymHEGAp3kNdRh59xF5HrW+NyVqstuZsPKtdjcCOQSKej0XyjwTZVd6JCzzwZ4++eG0sfVMiODby/JER7clB+myKJ3eNFZvt6cbyuJuZGfz8Ud9FvR8bTra2soG3TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775940466; c=relaxed/simple;
	bh=wOokfXSfKm4ynD5vPPTq+ixi8gWAqs3HE6TQ2OU2aGA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=am2D8K6TIJn9qGigcfb/a5E9Jbo2daIydtGi6eKQyI9nmtJU3bEDVzC07zUs2iaWSShDUzbfTZFsYE4lQNXytFKUK15Td+uRz3jyuT/TjECgTTYTWATm1f5ThGI+Y/0HSwIZoHIThDY/qNgjd5KFtv/Cuao8aNdwz36PxVA3yyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1fmrdkW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1fmrdkW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99F9C116C6;
	Sat, 11 Apr 2026 20:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775940466;
	bh=wOokfXSfKm4ynD5vPPTq+ixi8gWAqs3HE6TQ2OU2aGA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=i1fmrdkWvG3iQ+ZKIW4njb3MXiEWPEbu3TJHXx9vj4IpYi9BsbTnPCSHpJlkZ84p4
	 E18aJshbMQVYlOR9avyFpQ4tZ+slx7AHSe1C9QS45drIBMy8ef42Y9UQhfgv9n7F+u
	 qGh/ZHVcq6bgaLubFDC1/pL+8cTvZjid6OgN2qegSQZXwLBfnA3QMCUOf1CjzpbIpQ
	 4p9f3Vs/kmOxongLppUA+0L/XiHBaExBqg2IthVNEBGh/VzyNh/ql0CuseT8s6SdZt
	 BJTadofRzJ9NOJY3XnvI7pYt4bsy3qNBb4raFJE94qHeAho28pbJuqyoo+fXULHXBD
	 KcC5C5fNp5Sxw==
Content-Type: multipart/mixed; boundary="===============2084711179146525473=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <28eafb56189a855054f43d028e509bb4e52cedd62af35ed22857e2db9f07dc2c@mail.kernel.org>
In-Reply-To: <20260411200840.1793567-3-bestswngs@gmail.com>
References: <20260411200840.1793567-3-bestswngs@gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: Fix use-after-free of arena VMA on fork
From: bot+bpf-ci@kernel.org
To: bestswngs@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,brho@google.com,emil@etsalapatis.com,bpf@vger.kernel.org,xmei5@asu.edu,bestswngs@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 11 Apr 2026 20:47:43 +0000 (UTC)

--===============2084711179146525473==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Fix this by tracking each child VMA separately. arena_vm_open() now
> clears the inherited vm_private_data and calls remember_vma() to
> register a fresh vma_list entry for the new VMA. arena_vm_close()
> unconditionally removes and frees the entry.

Should "unconditionally" be "conditionally" here?  When
remember_vma() fails due to OOM in arena_vm_open(), vm_private_data
stays NULL, and arena_vm_close() returns early without removing or
freeing anything:

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index f355cf1c1a16..3462c4463617 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c

[ ... ]

> @@ -336,9 +334,17 @@ static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *vma)
>  static void arena_vm_open(struct vm_area_struct *vma)
>  {
> +	struct bpf_map *map = vma->vm_file->private_data;
> +	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
> +
> +	vma->vm_private_data = NULL;
> +	guard(mutex)(&arena->lock);
> +	/* OOM is silently ignored; arena_vm_close() handles NULL. */
> +	remember_vma(arena, vma);
>  }

[ ... ]

> @@ -347,10 +353,9 @@ static void arena_vm_close(struct vm_area_struct *vma)
>  	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
>  	struct vma_list *vml = vma->vm_private_data;
>
> +	if (!vml)
>  		return;

arena_vm_close() returns here when vml is NULL, so it does not
unconditionally remove and free the entry.

> Also add arena_vm_may_split() returning -EINVAL to prevent VMA
> splitting, which would break the pgoff arithmetic in arena_vm_fault().

Would splitting actually break the pgoff arithmetic?
arena_vm_fault() uses vmf->pgoff for range_tree operations and
kbase + (u32)(vmf->address) for the kernel mapping.  Both of these
use values that are independent of vm_start and vm_pgoff adjustments
made by __split_vma().

Similarly, compute_pgoff() computes from absolute addresses:

    (u32)(uaddr - (u32)arena->user_vm_start) >> PAGE_SHIFT

And zap_pages() iterates all VMAs in the list, with
unmap_single_vma() clamping each call to the individual VMA's
bounds.

Preventing splitting still seems like the right call for keeping the
VMA tracking simple, but could the commit message give a more
accurate reason?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24290771286
--===============2084711179146525473==--

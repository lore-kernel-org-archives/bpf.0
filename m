Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792986783;
	b=fl4SclySku+mFvi6F9Z/y+E6oxXDvKd3SHRXhYvhf8HAGUqHdcolX+gXN0R53qflGXGs
	 xfPp2FltkellPcpU2moDlj/B9NrdpmzjNopZOw2+0t7nlygVSn0ncCPyBY6ZpDosFC9N6
	 7TN0NpC7fvnqXfFklVuEFAlqYbGJ9+F3AvyL9e4K0faaXdBOSASGj54+MOl7cVj6uiugG
	 dho8Qd332ycH0JQdb7BbGk6peFot/53TdlWS9MCoTc1cSOvePxjtkZFQYkSiLwckvQHSA
	 WCXeDW7CoXI6yvs6VLKfdvkXAIYLavmvgIkmLYeUXtYhDB9OPl0mDr9kCRiUKd2mleQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792986783;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=286TsvvvOKPJ1nt0w4yx0OWCK8TFiB7L5SJM5/EfG8k=;
	b=x1hsbGaBv8zZ5X6iS1FiDm5QbOc0GyDvg3YDoWWRnBiFCL+K/BPXjXLnTePUZmnCZJO4
	 z+FUKxXrUwYuVhedBcTh6iURV1n5Ockwu7WTvUbzS6EXUDgEdfI9BRHWkhsleQw3XOUhd
	 d6FZDwJtSAlmXE4WijkfSlFUSjcQDlvqk+zd5Ea/d9PmlhUBBIpr1SGm57+FhBt823rgb
	 eLUZDsC+gqwbCQARU1MP0MqcEnHgfarUoNkGhzFny0Xei11/j7ALTvnu32NtMk8LrJfc6
	 vBiMWJYIPkcQJi/xFC5Pc662ZyCJMsZfQ4hkUkbxHM+EWr3uTOZPA4USZ1hjwopegSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ns4ram7D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E77B606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ns4ram7D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFC21F01825;
	Mon, 26 Oct 2026 03:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792986783;
	bh=286TsvvvOKPJ1nt0w4yx0OWCK8TFiB7L5SJM5/EfG8k=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Ns4ram7DTtTn20raMzc5BK+JEa3rLcBhNK7onHQHBPg6bkT0g3HgbWIAEzpHx6cNP
	 Yb3mbrhFLSet0EKGOjXfTm8Ey1NYUnRZHPDI6qbORZEv6gyFcmTrqwHxDyqqyXFaH/
	 vPISgiq2yRg4741juoIHQosBKS+QNhwqusNGkgcuY1D1RNigV+KTAodbq9qzX5IBLO
	 N/4DneYworKo2kThBCHA7c5QEFV4fkYa0MfiIgipDE7Zj1AufgDccM6yS9NJqQPNa+
	 5brrGQ0ZdeNn6bNyWm/1I5VzVvhAIBg7dvOvBGqBVHMdRt1MNMTlewwIZ7c7eb77cA
	 DFqtXRWN4oSLA==
Content-Type: multipart/mixed; boundary="===============5069274340101120587=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <38b996f5c5ec8dd485a96d6358407bae70ab8a89a8beedbdc49bde8becdab1eb@mail.kernel.org>
In-Reply-To: <20261026025943.404450-43-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-43-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 42/81] bpf: Allow BPF_MAX_SUBPROGS targets of a read from a table of functions
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 26 Oct 2026 03:53:02 +0000 (UTC)

--===============5069274340101120587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Allow BPF_MAX_SUBPROGS targets of a read from a table of functions

TL;DR: Nit only: check_func_ptr_read() uses kmalloc_array(), which
deprecated.rst discourages; kmalloc_objs() might read better, though the
review calls it a style point and not a bug.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8f5aa77e4ecc..e179514c3b59 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -7150,17 +7150,20 @@ static int check_func_ptr_read(struct bpf_verifier_env *env, struct bpf_reg_stat

[ ... ]

>  	ptrs = bpf_map_range_func_ptrs(env, map, min_off, max_off - min_off + size, &cnt);
>  	if (!ptrs)
>  		return -ENOENT;
>  	if (cnt > BPF_MAX_FUNC_PTR_RANGE)
>  		goto overlap;
> +	targets = kmalloc_array(BPF_MAX_FUNC_PTR_TARGETS, sizeof(*targets), GFP_KERNEL_ACCOUNT);
> +	if (!targets)
> +		return -ENOMEM;

this isn't a bug, but Documentation/process/deprecated.rst lists the
open-coded form:

	ptr = kmalloc_array(count, sizeof(*ptr), gfp);

as deprecated in favor of:

	ptr = kmalloc_objs(*ptr, count [, gfp]);

verifier.c already uses kmalloc_objs() for used_maps and used_btfs, and this
appears to be the only kmalloc_array() left under kernel/bpf/.

The deprecated.rst text is written for struct objects and targets is an
array of u16, so this is a style point only.  Would this read better as:

	targets = kmalloc_objs(*targets, BPF_MAX_FUNC_PTR_TARGETS, GFP_KERNEL_ACCOUNT);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40263142572
--===============5069274340101120587==--

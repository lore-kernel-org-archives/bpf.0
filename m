Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9963559F2
	for <bpf@vger.kernel.org>; Sat, 11 Jul 2026 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783763706; cv=none; b=NIplebMOkwd/INVmOa4quXKA2ax5vq3DMJHa/uGk1Pi9cCqtsDlhVFUYujQuXwpEfipaG/MeCNLpEcTWRFVce/8XYVWPgKWqSEWM88TkE1TNd08jZY+CU7jJ81VhHk23C2obyJMWWRA0hx/AasDQq25AHzP1G76AVjIjlEt6Fco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783763706; c=relaxed/simple;
	bh=luLUPRPcIiKNiZiYxdbCyBP4yj5C6eWrvLl8fKa0lvQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SmBGkiWs5LfYOkshbc0W7uFyFkUpeBnFeoCvXsd8Fufa4jQSNNR76m2+6g5HnIKv54nz2wEOLHIXsE/LEQSgbhtj+gRDyZb30hfx1rsWzopiZnbj5zZ2vvQBwzgvw4APDvHuaWrJkrLYM4oOmkaa5nW8N7hx1qVFkFrT0Mrw5JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZGmCPiF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZGmCPiF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC961F000E9;
	Sat, 11 Jul 2026 09:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783763705;
	bh=DPuBs4Ny8LDuaPrgEDzLxtRR09Zcis/NsXlv5Mle01w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mZGmCPiFWPLRIfUpW/1HaxE2EkH5X2uzuz1DkzfcSWZGp2i3nMHy8Zbkb9nEvvSi1
	 zkbubgRwyYduPi/+jgiFFNKnyMSuCS+FZAoMyODXBWYiRc+lsH3ekhHx0QiDJeagSE
	 XwNN0dqn34I8gdtnKORexVuf/wVz4cIx1dkWUYr4PxzCe+uRWbcV5DgLeApsnExlXW
	 LMYXFSYpPSvXst3UZYYj4bKwtRnoLJL9/V0wTH7BzHTfVVm4GxWENjzo8JRewJRDnY
	 D6/ONkXHnmjvfsk7m0LWvXs34hblCuL9rSLm88Bo7FPwh2DK8M+Xp05X7ugs6F9nQS
	 juY2MRlbtqHxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/5] bpf: dispatcher: allocate
 bpf_dispatcher->rw_image with vmalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260711-execmem-x86-rox-bpf-v0-v2-1-bfd956d35119@kernel.org>
References: <20260711-execmem-x86-rox-bpf-v0-v2-0-bfd956d35119@kernel.org>
 <20260711-execmem-x86-rox-bpf-v0-v2-1-bfd956d35119@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 09:55:04 +0000
Message-Id: <20260711095505.0CC961F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Uninitialized kernel memory is copied into an executable BPF dispa=
tcher region, leaking data and creating unintended ROP/JOP gadgets.
--

--- Patch [1]: [PATCH bpf-next v2 1/5] bpf: dispatcher: allocate bpf_dispat=
cher->rw_image with vmalloc() ---
commit 12eba9f58f961b936cd08cfa17b30375eb214d2a
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

bpf: dispatcher: allocate bpf_dispatcher->rw_image with vmalloc()

This commit changes bpf_dispatcher->rw_image allocation to use vmalloc()
instead of bpf_jit_alloc_exec() since the rel32 offsets are calculated
against the final image, removing the need for the temporary buffer to live
in the module address range.

> diff --git a/kernel/bpf/dispatcher.c b/kernel/bpf/dispatcher.c
> index ea2d60dc1feeb..d85b3e8ad2e4e 100644
> --- a/kernel/bpf/dispatcher.c
> +++ b/kernel/bpf/dispatcher.c
> @@ -148,7 +148,10 @@ void bpf_dispatcher_change_prog(struct bpf_dispatche=
r *d, struct bpf_prog *from,
>  		d->image =3D bpf_prog_pack_alloc(PAGE_SIZE, bpf_jit_fill_hole_with_zer=
o, false);
>  		if (!d->image)
>  			goto out;
> -		d->rw_image =3D bpf_jit_alloc_exec(PAGE_SIZE);
> +		/* d->rw_image doesn't need to be in module memory range, so we
> +		 * can use vmalloc.
> +		 */
> +		d->rw_image =3D vmalloc(PAGE_SIZE);

[Severity: High]
This isn't a bug introduced by this patch, but since we are changing the
allocation here, does this code leak uninitialized kernel memory into the
executable dispatcher image?

vmalloc() does not zero-initialize the memory, and neither did the previous
bpf_jit_alloc_exec() call. When the architecture-specific code generates the
dispatcher instructions into this buffer, it only writes a few hundred byte=
s.

Later, bpf_dispatcher_update() copies exactly 2048 bytes from this partially
uninitialized temporary buffer into the executable RO+X dispatcher image:

bpf_dispatcher_update()
   ...
   bpf_arch_text_copy(new, tmp, PAGE_SIZE / 2);

Could this overwrite the safe int3 trap instructions placed by
bpf_prog_pack_alloc() with random bytes from the uninitialized kernel memor=
y,
potentially creating unintended ROP/JOP gadgets? Would it be safer to use
vzalloc() here instead?

>  		if (!d->rw_image) {
>  			bpf_prog_pack_free(d->image, PAGE_SIZE);
>  			d->image =3D NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711-execmem-x8=
6-rox-bpf-v0-v2-0-bfd956d35119@kernel.org?part=3D1

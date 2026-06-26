Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0827B303CAE
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 18:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782500381; cv=none; b=jtBwgqVuC3x/xm4XJm8vjYHwVgPZ2ZQdau1jxt8XDBmSfLdeF3LYCRS3t1Krdtdh5dzSjaj1e+vm0puxBorZDVEFVZPcDQb7TBRogbQda6C/mz9wCXVYfKjole0wQtXJ0YEHj8ZJO6UQgdRpdxgQlS0k50BB0BYqTrp9YdNGrnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782500381; c=relaxed/simple;
	bh=Sx0IEiOXa5BGTu9KA5Lgan2nFqNT/z27kWtbTL+V0BM=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eLRLfWGpkfdiN4M9daj4gBZ64lUjZbsx2+ON8Xan/quG3yQ1kfBGMH1uwtoaAtjnxp8OVunBVBxSO8l//C6YihOcW4ERFeB1Pa5h7BAH67I2Wc6MeRb4eq9EKJOxC48t+zRs00UOdCU4eWqDsEnQUbo31kyoVdzw12RBB3NbV/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anzvop4P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anzvop4P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863571F000E9
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 18:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782500379;
	bh=zgMGXPKtf5ERUR337W2IMpG8FagnQPJM0fLEusvUxMA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=anzvop4PB62kPUMix1uCu7HJgxW/p6cK9LSCT+MLV73OSGXC77mvY6mEFRQLATxl/
	 TwQ3wIeUDt5p9AFknIuqM4JeQ4qyPEOsqXSmZdBQJHqqIy1f0OcVhVNjpoFNZDcdNb
	 VZPLALdK3L+KJvId1jKcWlu8pvdhayaO2XnDyqsW3wQE3wPQbrRR8JZhlELYktWTmk
	 8/xIHFo/IYsOwDHEUFkqjEApIpV56736r3eiS00wgMgGSo85ZT5YO1ob+iDjG8ygpi
	 T6EaGhP0bmzoKNRzFWuufeMXvcCseixhC2uaiBJBObz85syzYarT8iIPtAfuawrVXR
	 uBYGCa4mwzKfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/5] bpf: dispatcher: allocate
 bpf_dispatcher->rw_image with vmalloc()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
In-Reply-To: <20260626-execmem-x86-rox-bpf-v0-v1-1-45a0b0ed4fe9@kernel.org>
References: <20260626-execmem-x86-rox-bpf-v0-v1-0-45a0b0ed4fe9@kernel.org>
 <20260626-execmem-x86-rox-bpf-v0-v1-1-45a0b0ed4fe9@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 18:59:39 +0000
Message-Id: <20260626185939.863571F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Uninitialized vmalloc memory is copied into the executable BPF dis=
patcher image, creating an information leak and potential W^X bypass.
--

commit a818beebb25a7db7c07963818946c91a734b9050
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

bpf: dispatcher: allocate bpf_dispatcher->rw_image with vmalloc()

This patch changes the allocation of the temporary bpf_dispatcher->rw_image
from bpf_jit_alloc_exec() to vmalloc(). This saves space in the module addr=
ess
range since the temporary buffer doesn't require executable permissions.

> diff --git a/kernel/bpf/dispatcher.c b/kernel/bpf/dispatcher.c
> index b77db7413f8c7..a7a6a375cdd31 100644
> --- a/kernel/bpf/dispatcher.c
> +++ b/kernel/bpf/dispatcher.c
[ ... ]
> @@ -148,7 +148,10 @@ void bpf_dispatcher_change_prog(struct bpf_dispatche=
r *d, struct bpf_prog *from,
>  		d->image =3D bpf_prog_pack_alloc(PAGE_SIZE, bpf_jit_fill_hole_with_zer=
o);
>  		if (!d->image)
>  			goto out;
> -		d->rw_image =3D bpf_jit_alloc_exec(PAGE_SIZE);
> +		/* d->rw_image doesn't need to be in module memory range, so we
> +		 * can use vmalloc.
> +		 */
> +		d->rw_image =3D vmalloc(PAGE_SIZE);

[Severity: High]
This is a pre-existing issue, but does allocating this temporary buffer wit=
hout
zeroing it leak uninitialized memory into the executable dispatcher image?

When bpf_dispatcher_update() updates the dispatcher, it unconditionally cop=
ies
PAGE_SIZE / 2 bytes (2048 bytes) from this buffer into the executable RO+X
image:

kernel/bpf/dispatcher.c:bpf_dispatcher_update() {
    ...
    arch_prepare_bpf_dispatcher(d->rw_image, ...);
    ...
    if (IS_ERR(bpf_arch_text_copy(new, tmp, PAGE_SIZE / 2)))
    ...
}

Since arch_prepare_bpf_dispatcher() only writes a small number of
instructions into the buffer, the rest of the 2048 bytes copied by
bpf_arch_text_copy() comes from whatever was previously in this allocation.

Could this allow malicious gadgets to be sprayed into vmalloc space from
userspace and then copied into executable memory, potentially bypassing W^X
protections?

Would it be safer to use vzalloc() here to ensure the unused portions of the
buffer are padded with zeroes?

>  		if (!d->rw_image) {
>  			bpf_prog_pack_free(d->image, PAGE_SIZE);
>  			d->image =3D NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-execmem-x8=
6-rox-bpf-v0-v1-0-45a0b0ed4fe9@kernel.org?part=3D1

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0FF3BFAE2
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 09:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882866; cv=none; b=XqiZFWfHiytMM6HbHzYWDOxtmiVCvYiVIpp7G4YdTMyTO0Q87INyncrRHsV7QXpfe/lXFwhubhFV2c20VqUfKy2yR/4/Cl9Vbuc+eX/s+ILp41V8crO/zC/GHZZ4gQcI2GmTp63MRU1b0ESB2Zo7za20xFhznwDhhcdfxZXz/EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882866; c=relaxed/simple;
	bh=D+jvzJVfs0sRH4IkC98vagVoEIjj3+o+4pKdpwVsr4Q=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jzyCvUIyRk+il2OFoaYxDhg0oWVP0TVrZoM7K6HMMMTiUITZBHRxtUmRwCkdtxU4hlVjWnOW2YT+qiRWWLcUO0bDvBR7zaOlOIHXSBmxhUeOBcrEylOOtvFgaeTydLi/KnEPPyTjSvWbLVvc+zhN4YaVNpJiMriVgIe13SkSZok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVMKJGtH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVMKJGtH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C0F1F000FF;
	Tue, 13 Oct 2026 09:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791882865;
	bh=hb1PC7rs531AEDdn9BanCEMByWerjvo7417T3tXIyNY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mVMKJGtHiY4jtAsdTRJYvZldMpOOT7o1j2Z1lCc8SN5ydZU/Tv9Q3+MJwNky7wdm1
	 TMVae0jY2LbEbJxEMoZmaAY5W73DpqEV97tg/nLeXL/EDMidMEx+De/mL9P1k8WL0p
	 rEuyqLgDiF6VRNgM+mG0I2PmeX0gYIMZHl8mi3BglwMh+vJsojKz7iX1z+uiTasMgC
	 7e9wFD4DMezzj3baq+OrQEXd+UsBMbDCamb7gZW6efDOZBZzXLOs/P1Ih9/AHLGn2G
	 O1P3sdwCrBhMFvrP9xL7x/seS+spzTACdheXdz4kXcjz5qpVDvK7Lu0NH56d956hSP
	 XR9txVdVUv7sg==
Content-Type: multipart/mixed; boundary="===============0604972186055048958=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e0768eaad7915c5a442a41e017b5171ecce458a0fea83525181cc47111bb41ba@mail.kernel.org>
In-Reply-To: <20261013082012.1107446-9-memxor@gmail.com>
References: <20261013082012.1107446-9-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 08/13] libbpf: Bind the arena of an object to every program in it
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 13 Oct 2026 09:14:24 +0000 (UTC)

--===============0604972186055048958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Bind the arena of an object to every program in it

TL;DR: Nit only: the fd_array_used comment in struct bpf_object says slot 0
stays empty and no count is passed, which the new arena binding in libbpf.c
contradicts. Comment probably needs updating.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> +static int bpf_object__bind_arena(struct bpf_object *obj, struct bpf_program *prog,
> +				  struct bpf_prog_load_opts *load_attr)
> +{

[ ... ]

> +	if (!obj->fd_array_used) {
> +		err = libbpf_ensure_mem((void **)&obj->fd_array, &obj->fd_array_cap, sizeof(int), 1);
> +		if (err)
> +			return err;
> +		obj->fd_array_used = 1;
> +	}
> +	obj->fd_array[0] = map->fd;
> +	load_attr->fd_array = obj->fd_array;
> +	/* with slot 0 filled every slot handed out is valid, so the array can go with a count */
> +	load_attr->fd_array_cnt = obj->fd_array_used;
> +	return 0;
> +}

This isn't a bug, but is the comment on struct bpf_object's fd_array_used
still accurate?

	/*
	 * Slots handed out so far, slot 0 included. A kfunc insn names a module
	 * BTF slot through its offset, slot 0 stands for vmlinux BTF and stays
	 * empty, so the array goes to the kernel without a count.
	 */
	size_t fd_array_used;

With this patch bpf_object__bind_arena() stores the arena fd in slot 0
(obj->fd_array[0] = map->fd) and hands the array to the kernel with a count
(load_attr->fd_array_cnt = obj->fd_array_used), including when the object
has no module BTFs at all.

For an object with an arena on a kernel with FEAT_FD_ARRAY_CNT, that
comment now describes the opposite of what the code does.  Should it be
updated along with this new use of slot 0?

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38370395582
--===============0604972186055048958==--

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9684490C1D
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 09:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789549418; cv=none; b=SCzDmz2Ui6cqLmG6RFKGoT4o8Pck95jnDI7fszu4OAMzlnP75DcilocfTYic3NtZFwt4jy+axbb2obs06z9hgklBCIUKM7SV7oB0/kvxrWfL4CaiwK+g5eNEJRVsIPKp6M8c6aJq3+47s9oqGT7nHlgZiKiQq8hc1K/dyqnXFWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789549418; c=relaxed/simple;
	bh=z4verueTmcvaJw5sdJeklApFc2JIVHbToA07DAKRlyQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=LorhyLKUSQWXsKx8GQqcCnmHOKfxgby7NLOI6soKX59lY584j9/fL/T6z2EYsfsP4ftkvNIxuiKpKyO3Ayy6qfl259wWFw8eet9JmnH2t6i0ZxlxN+SVFIanl4UAQzVHPNFAC/M2OTAf47UoGajOXZ8tnSAGLBiUCQ/TDZIcDJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgB16ktw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgB16ktw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FEE1F00898;
	Wed, 16 Sep 2026 09:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789549403;
	bh=zLBscZsBM+7yYKtXCyiF4sYUsvT/jGu2+VfINW195+A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kgB16ktwLXvaat9D9a9q/ZPK3Ts/Djom2CLJA0PyQRuTuHkT4aOdJQXVJ6UONHqc0
	 uT+aulIAkDGSKuHzbhD4rh7qeGrkszFlb+L8Lpn2jCAvJsaY4V5NFc63v00cjVqOms
	 yGuLmx2VcHClUYfHfeK3H0Omd13ok9z5N2fyYLbpVFGm986tZyKefl8G411ndZX+dp
	 vvucY3ZG6zZcgs3Eo8cTBRuhPf/O+NmD8XwyqYWZ8S9Z977vG0TxAcyAlFS/XjD6cb
	 kTh8bT9jOBvc0Z01HtwOT2Z1Tpp0ho7+e4qVFkjqVp+vs7MxSIDWYkky2Z3lmwmBg0
	 ZsB5RILI15TcA==
Content-Type: multipart/mixed; boundary="===============5124110801100035418=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7a9b72bef1a168a32411f6cd355e6742156557a37c7d5df67f2d7a918706f838@mail.kernel.org>
In-Reply-To: <20260916074118.1007116-8-alan.maguire@oracle.com>
References: <20260916074118.1007116-8-alan.maguire@oracle.com>
Subject: Re: [PATCH v3 bpf-next 07/11] bpftool: Handle multi-split BTF by supporting multiple base BTFs
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,jolsa@kernel.org
Cc: daniel@iogearbox.net,ihor.solodrai@linux.dev,yonghong.song@linux.dev,song@kernel.org,qmo@kernel.org,martin.lau@linux.dev,memxor@gmail.com,emil@etsalapatis.com,bpf@vger.kernel.org,nsc@kernel.org,puranjay@kernel.org,yatsenko@meta.com,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 16 Sep 2026 09:03:22 +0000 (UTC)

--===============5124110801100035418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit ce1a2ae119f4c77324c56fee2aa1fa0305ae09f5
> Author: Alan Maguire <alan.maguire@oracle.com>
> Date:   Wed Sep 16 08:41:14 2026 +0100
>
>     bpftool: Handle multi-split BTF by supporting multiple base BTFs
>
>     For bpftool to be able to dump .BTF.inline data in
>     /sys/kernel/btf/foo.inline for module foo, it needs to support
>     multi-split BTF because the parent-child relationship of BTF
>     inline data for modules is
>
>     vmlinux BTF data
>             module BTF data
>                     module BTF inline data
>
>     So for example to dump BTF inline info for xfs we would run
>
>     $ bpftool btf dump -B /sys/kernel/btf/vmlinux -B /sys/kernel/btf/xfs file /sys/kernel/btf/xfs.inline
>
>     Multiple bases are specified with the vmlinux base BTF first (parent)
>     followed by the xfs BTF (child), and finally the XFS BTF extra.

The sentence here doesn't match the example command. The example passes two
-B options (vmlinux and xfs) and one target file (xfs.inline). Could the
wording be clearer? Perhaps: "Bases are given outermost first: the vmlinux
BTF (parent), then the xfs module BTF (split on vmlinux); the .BTF.inline
data is then passed as the target FILE."

The term "XFS BTF extra" doesn't appear elsewhere in the message or code,
but the .inline data was called "module BTF inline data" in the hierarchy
diagram above.

>
>     Update help text accordingly.
>
>     Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index bca0a3982f09b..bbe8f9ea144fa 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c

[ ... ]

> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> index 5ababd8f7d0a0..cff76be7d2e86 100644
> --- a/tools/bpf/bpftool/main.c
> +++ b/tools/bpf/bpftool/main.c

[ ... ]

Andrii Nakryiko raised a documentation concern in the RFC/v1 review
(https://lore.kernel.org/bpf/CAEf4BzYMsLc+BHHEOg7iXj_DqCMoj1WR_gBk_8MYUdd1+WnpKQ@mail.gmail.com/):
The help text syntax now shows {[{-B|--base-btf} FILE]... } which indicates
repetition, but neither the help text nor tools/bpf/bpftool/Documentation/
bpftool-btf.rst explains that the order of multiple -B arguments matters
(vmlinux first as parent, then module BTF as child) or how the parent-child
chaining works. The commit message explains this, but the user-facing
documentation doesn't. Should the documentation include this information?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35072175008
--===============5124110801100035418==--

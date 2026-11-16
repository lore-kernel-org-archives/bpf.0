Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794811147;
	b=iFTlX927Jg6/yNoSbCuyIN5iNy3LbQdylWumBCPTnebYCUNjFTdgXgkqCxtoDqMqrGNp
	 HNOci1fiP3ysCduPv7NzXNaCxZgv9GDstmpuxtY2IEAPoi/kEUuFakWjJKcMLGiGY2p3j
	 RTDkgt7ehk27Oe5gtZl0MSSS9T1/xrdWuymVQ2Sz3Oat7/J+Mja4/BqALJKGObdTbiM6g
	 HftUFxeyikhJ/JpRGuyTl3Z099UwaHEpDd6IS/HXOwq5+bxQgLUMLQUe8Ql6sTXrGcFju
	 964QEKeCxBSNKDMk3CvqF+wUfm51eFg4F1Vs7WBfif4uWvbUM5Py6uw1EUvjXRTBzSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794811147;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=MABZxFUmFYhSt1RvdlykTgIwrPnLp1OAS2+7ilN3M+U=;
	b=1lrUfpT+GJ0IAApjL+qq7BCEfs5kTysFjF2EOBKXqB3BYFIM76yrnS5M+EGlPcNMp91z
	 NKLVzx1Rk4Ftg7yUqPOItPCk5h5LZqC1CVZrnbEzmOxxDjzDgZcpdXIUJ4MVPS26jzD4J
	 J91J0CT6hbkNwua/lT/ojOgpnTzPdUJVIoifVZpt760U5MTclihzLTnosoDwXuhjHkqXn
	 s/Y9XhZRLWL/Uyr8TtdVGUOzyOqzZbFAz1lIvlqnYYDnsy7j6TA8RYfzMCSTPia8avfqG
	 ySpxY5U5fdFYw/Icjw6vE9IKXfn39JbD/7enp/wj85BT+ayvt5E2j98vNzmX2ezLf/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PQLg1Gji;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0D8606A32F
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 06:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PQLg1Gji
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14F41F000C5;
	Mon, 16 Nov 2026 06:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794811147;
	bh=MABZxFUmFYhSt1RvdlykTgIwrPnLp1OAS2+7ilN3M+U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PQLg1GjiaMNyM1fnNVaIVgggB+DsiF+1kaNVSKF8mZ1fJLfr4/HjNpQ/RpG8wG+nL
	 z8eSlY++fr/weQqrxtjBueJoRTXXfetUCju3Itxj3qqhKy4Bucq5La0QchnfcS97tJ
	 otqixuGEHFsRawgdgU9TWLNec+p2s6FiWS0GNs5J3KJ9nTd3Wp67a9aGMXFYWHV2vf
	 iWVaKjWyQY9HvMku885Ik1qzzma47MLw0exqTKi5uPSQEzz7KxZLlE9bTVQ/TQW4Lg
	 b+OfJ0YjipY/+l5F0dP/mBgITovP4xvUGusI6PYVmCDg4BUhEr+MYJTEVUEpk0Bdi1
	 MNBoCeN9MlVyQ==
Content-Type: multipart/mixed; boundary="===============8882863217707492737=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <946f29663faad86182bfa2e1e7c2141bac86bfba6b20a9fdbb8a60350c60724e@mail.kernel.org>
In-Reply-To: <20261116055638.4171529-8-alexei.starovoitov@gmail.com>
References: <20261116055638.4171529-8-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 07/21] bpf: Remove the limits on maps, BTFs and fd_array of a program
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 16 Nov 2026 06:39:06 +0000 (UTC)

--===============8882863217707492737==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Remove the limits on maps, BTFs and fd_array of a program

TL;DR: bpf_prog_bind_map() may hit a WARN (panic under panic_on_warn) from
kvmalloc_objs() without __GFP_NOWARN once map count is unbounded; impractical
to reach, needs huge memory and fds.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c

[ ... ]

> @@ -6291,8 +6291,8 @@ static int bpf_prog_bind_map(union bpf_attr *attr)
>  			goto out_unlock;
>  		}
>  
> -	used_maps_new = kmalloc_objs(used_maps_new[0],
> -				     prog->aux->used_map_cnt + 1);
> +	used_maps_new = kvmalloc_objs(used_maps_new[0],
> +				      prog->aux->used_map_cnt + 1);
>  	if (!used_maps_new) {
>  		ret = -ENOMEM;
>  		goto out_unlock;

Can this kvmalloc_objs() call trigger a WARN splat?  It uses plain
GFP_KERNEL without __GFP_NOWARN, and nothing bounds
prog->aux->used_map_cnt any more, since this patch removes MAX_USED_MAPS
and the 4096 fd_array cap for bpf_capable loaders.

A program can now be loaded with a used_maps table built by
bpf_table_next() (which passes __GFP_NOWARN) holding more than
INT_MAX / sizeof(void *) entries.  A later BPF_PROG_BIND_MAP on that
program would then ask kvmalloc for more than INT_MAX bytes, and
__kvmalloc_node_noprof() does:

    WARN_ON_ONCE(!(flags & __GFP_NOWARN))

for such a size and returns NULL.  The syscall then fails with -ENOMEM
and also prints a warning, which panics under panic_on_warn.

Reaching that size needs hundreds of GB of kernel memory and roughly 268M
open fds passed by a CAP_BPF loader, so it is not very practical.  Still,
every other allocation in this patch uses BPF_VERIFIER_GFP, which includes
__GFP_NOWARN.  Would GFP_KERNEL | __GFP_NOWARN (or
GFP_KERNEL_ACCOUNT | __GFP_NOWARN) be appropriate here?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43815411838
--===============8882863217707492737==--

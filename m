Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794811143;
	b=YP5pSrzJN95mlQflDK61f+TQLkobGRF9CIOolr8wpgmSOcMywC+IT47Gr5IkDpn64Dqa
	 5koQ5ZNvDlmScEpnej9WyKhD0SRKUljDFG9ve2L6/hjbgOmqXMggDAFv0rxknLxf1F8o5
	 4mvL+08qshiAsK5Q8mpQapBZDjIkk3OGP6SU47XKngxFnk7J4y8m29qajL+FSiX+K9kcI
	 tBA/H6OLJXAv/78JFZNjPXycbSmbG9FidFGPBj5x3WWmS87o7XACEQWwnBSfJLqaYdfAa
	 LXXfC3sRTWqGnvRNSEk1IvxzP0Z3jvXprIsjQGuwdFEPEFWP9E8k9mJm5szWwlDURVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794811143;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=FOEpmShc30N5DltC1ZtZXjX6ubB3KJ1DUUhWP0dYc/8=;
	b=5iwlI/hVs8oHtU3sTODWA1aFi73RE6jQIhSgR4ZyfwHMdTAfxw70NCdauLhrs5yZ1YW2
	 3ZJ35/12D0oGgUGzPtwlB/WLLV22Gqk8563y5yxazHqpuD1K06QwGgmUSmDy3WVNL3jhp
	 7rqlbhrbW0z53+Cvw3FannNw6t8NW18XaHJCRHWFzyJT/QyhjonGL0tuaWj5mDnd0MZSQ
	 0fdLOdKMM3Cyvj2d7ePPa9cT0L8bPxD0h1ckFE6e7xjVfbYhB6r2txhsspr8juz8srz6T
	 v+2SA4aSS2BrEW1Xkk20gyn8/3rbGbYNbS3ZqOG2WuU6PB7Ui2G6VSzDf0PToCNyNPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jylawJIn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAD9606A329
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 06:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jylawJIn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D485F1F000C4;
	Mon, 16 Nov 2026 06:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794811143;
	bh=FOEpmShc30N5DltC1ZtZXjX6ubB3KJ1DUUhWP0dYc/8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=jylawJIn6ieTTVY97KUipm0BHCJi4zfvEjJ77oe2upUQvh2LOxT4Rwix7bNJdCSRC
	 TEJtq7/Hwdu7R6uFawyOf1oIOZ0GSczy9h+TnxbykXq/0c4EBxGt6UvUjDJVIroIww
	 mT+LNPpue4QXChYYcIMQrYfi0yd8wTONbcZE90b3lyy56Z2k4HddtEJ1AP1ifVnWKy
	 Cho5S4oA9tC5LBaKpF/mVKlT9lgs6vn6LsafRxSINVAxmobI233r86uhsy3b3jHGOQ
	 jeZTtz+JB5v5D0gUYbKp+ROiu4AHYBTo1Wpybh28MiB81go6ObNrq/EXupoQoOPQQn
	 tg96Z7e/O9FRA==
Content-Type: multipart/mixed; boundary="===============4672396231146384719=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <65f9d1f98cb58f973a080519a345b41a50e2a0ddeb35a24beaf9bc845de1fb5c@mail.kernel.org>
In-Reply-To: <20261116055638.4171529-10-alexei.starovoitov@gmail.com>
References: <20261116055638.4171529-10-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 09/21] bpf: Remove the limits on kfuncs of a program
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 16 Nov 2026 06:39:02 +0000 (UTC)

--===============4672396231146384719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Remove the limits on kfuncs of a program

TL;DR: Nit only: with the last bsearch() callers removed, <linux/bsearch.h>
may no longer be needed in verifier.c. The review finds no bug.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -2831,50 +2811,38 @@ static struct btf *fd_array_get_btf(struct bpf_verifier_env *env, u32 idx)
> -	tab = prog->aux->kfunc_tab;
> -	return bsearch(&desc, tab->descs, tab->nr_base_descs,
> -		       sizeof(tab->descs[0]), kfunc_desc_cmp_by_id_off);
> +	return func_id && i >= 0 ? &env->prog->aux->kfunc_tab->descs[i] : NULL;
>  }

[ ... ]

This isn't a bug, but with the last bsearch() callers in find_kfunc_desc(),
__find_kfunc_desc_btf() and find_kfunc_desc_btf_cached() gone, is
<linux/bsearch.h> still needed in verifier.c, or could the include go too?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43815411838
--===============4672396231146384719==--

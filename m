Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE942AD32
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 03:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787196919; cv=none; b=FLcNvO9pLeSrDVW3eFgc/foX8+WQGmPLw0hiZK+eq1agUrt3wGlM48e0/9jKW0HXd4uxUpuycxbz6aSyd0GwoKvTlOIQVx+BlsTVQeg7CW75gjICjqsx1H1dx7V6/T+Z9chocfQ4Ima95x7qoJOV5ppPnvwBji1qxAOYYeARK1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787196919; c=relaxed/simple;
	bh=PRnt9wH+/0h8SYXYLSqpx2qN09vzm01PC6c7OqkMJVc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=s53tkk5aGTgOQWhY/YwYYpbE/xTbbSKNUBnZZ4shqrVoPWHKZIJ7KRrjxncSo0nOpedgrvVIK1mp0cQ4omjlOtDfzaFM6F2Q5hosNleFXmXeXauaVJtjU44euSOmmgT5TbB6qgODyRZIjjKVCI2tth4T/jQmZ5eVaZg76TrDaQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpFq99tx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpFq99tx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E0C1F000E9;
	Thu, 20 Aug 2026 03:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787196918;
	bh=RnONXHR5X3y4k6rGKMa7ULUzrJTo2T1pBFuOSI7YSxo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BpFq99txDD2GkwDlD3+JnGPl5scP/KCGxxPpx4hs7bI4B2eLLqbj/hD0CvPTBchc0
	 6D2Aw12SPUigXP6/HG+vCdnV2giZvbA4E9C/3htZ9/ZMWIiWASgab+SHivVTWw0yVN
	 Kfd/SXYr0e/CtPk07nWFmqFij4JtjeUe6YB5s8QP6ws4WX+opVRUqdiqrjCF/g1K/V
	 5mNpa3U+aI+6G1F9v5onFsCwGKlj/0Ue+aop6HTVyKokxwlruFibKLubQ0lL+lSjvE
	 PqGLigbVhh7AiW2plH3GWbCVQJsyxpM+UAgzD0Zsn1EsyHG3QR4nQVZbqfwwm/LuJB
	 nv51icYVqb4Sw==
Content-Type: multipart/mixed; boundary="===============4509149911100374228=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <04f589c08869393820bbdc19c5f7ae01b442bfa792624f13a6cf504eea554ea8@mail.kernel.org>
In-Reply-To: <20260820022831.18601-1-zirajs7@gmail.com>
References: <20260820022831.18601-1-zirajs7@gmail.com>
Subject: Re: [PATCH bpf v2] bpf: keep trampoline progs alive until image release
From: bot+bpf-ci@kernel.org
To: zirajs7@gmail.com,ast@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,andrii@kernel.org
Cc: john.fastabend@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,bpf@vger.kernel.org,rhkrqnwk98@gmail.com,paulmck@kernel.org,leon.hwang@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 20 Aug 2026 03:35:18 +0000 (UTC)

--===============4509149911100374228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 7719f6528445..bacb6bc2e27b 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h

[ ... ]

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 1a721fc4bef5..33383d1dc1e0 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -529,8 +529,36 @@ bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total, bool *ip_a
>  	return tnodes;
>  }
>
> +static void bpf_tramp_image_get_progs(struct bpf_tramp_image *im,
> +				      struct bpf_tramp_nodes *tnodes)
> +{
> +#ifdef CONFIG_PREEMPTION
> +	int i, kind;
> +
> +	for (kind = 0; kind < BPF_TRAMP_MAX; kind++)
> +		for (i = 0; i < tnodes[kind].nr_nodes; i++) {
> +			struct bpf_prog *prog = tnodes[kind].nodes[i]->link->prog;
> +
> +			bpf_prog_inc(prog);
> +			im->progs[im->nr_progs++] = prog;
> +		}
> +#endif
> +}

This isn't a bug, but would renaming bpf_tramp_image_get_progs() to
something like bpf_tramp_image_hold_progs() help avoid confusion with
the existing bpf_trampoline_get_progs() right above it? The two helpers
do completely different things: bpf_trampoline_get_progs() collects nodes
from hlists while bpf_tramp_image_get_progs() takes refcounts.

> +
> +static void bpf_tramp_image_put_progs(struct bpf_tramp_image *im)
> +{
> +#ifdef CONFIG_PREEMPTION
> +	int i;
> +
> +	for (i = 0; i < im->nr_progs; i++)
> +		bpf_prog_put(im->progs[i]);
> +#endif
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32326053450
--===============4509149911100374228==--

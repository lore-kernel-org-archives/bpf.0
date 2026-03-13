Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD2B390219
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 12:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773404468; cv=none; b=q063AvvZF0yWtIU0WNpd1JovCeh2ryGiExO2R8O/JZaFQkwZYtHL+kLK0pXu3OgmyFsW65sHibHnpW9ZV6CD+SKkduY3C9kfGjIrUIyuJcH1m4nflM49clGH0NaO/AWLKMWsEGYr8o3yUFQrySvs8DeMViem2l6Hsg4eiuBKuI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773404468; c=relaxed/simple;
	bh=aVqu86OqOP/fq2iNPTX/U9dZWrwntmPZ9hmBVFi1R0o=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=MjQazdA8jI9QnBe4v2n/6EfxSwPQshgbHbYHg6yy2EtivusNeiP/NaEwE5qXlpNF1u9MNnwozLXogT0z5a36MN5BdLaY1evQKYXOH8sRhavhPkLlkn8liL4P605f9PUHdHC2JN/VYV667HmLTmncPRyD1Tv3ANxggRUXH2eB4zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hqlk1y5a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hqlk1y5a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72A0C19421;
	Fri, 13 Mar 2026 12:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773404468;
	bh=aVqu86OqOP/fq2iNPTX/U9dZWrwntmPZ9hmBVFi1R0o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Hqlk1y5a6sUOeEbqbGnBfwbGIXr320n93oz++PIRpQ2/M5i0r0/U69NH9ui6mNj7y
	 bvCkyufni36whJhJAs+TTcGIKIfuuNltG2IYN4M/1BPSjHnFf7DQXWgJ5jyA9FqDjU
	 nXHggjW7ke/5gXCWxHmSeT9G5Xz0viZxMdI4mLntcMIBswugyeb3EJkexgH/Tclbj7
	 xO92cJqdGny18KvBBe7Zq72tFOrzw8vqGw/zledAzczNaoQuetJEFOJR/hiJzEOZGS
	 x/otHC/Ci2v5G3yc/Ik6wt8kI8XwDaRDS0W/Z0L/VavcAGzK6sdKHCbzQ4xiW6v7+q
	 p6W/HKatm83WA==
Content-Type: multipart/mixed; boundary="===============7442985298383976832=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <823e66acdcc6a34bc99cbbd93db6965e0b333c364d852e8cc727fd70df90ca08@mail.kernel.org>
In-Reply-To: <a988ecf2c57e265b97917136b14b421038534e8c.1773401138.git.paul.chaignon@gmail.com>
References: <a988ecf2c57e265b97917136b14b421038534e8c.1773401138.git.paul.chaignon@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpf: better naming for __reg_deduce_bounds() parts
From: bot+bpf-ci@kernel.org
To: paul.chaignon@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,shung-hsi.yu@suse.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 13 Mar 2026 12:21:07 +0000 (UTC)

--===============7442985298383976832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4fbacd2149cd..189e951886ed 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -2518,6 +2518,10 @@ static void __reg32_deduce_bounds(struct bpf_reg_state *reg)
>  		reg->s32_min_value = max_t(s32, reg->s32_min_value, (s32)reg->smin_value);
>  		reg->s32_max_value = min_t(s32, reg->s32_max_value, (s32)reg->smax_value);
>  	}
> +}
> +
> +static void deduce_bounds_32_from_32(struct bpf_reg_state *reg)
> +{
>  	/* if u32 range forms a valid s32 range (due to matching sign bit),

The new deduce_bounds_32_from_32() contains a comment referencing the
old function name:

    /* See __reg64_deduce_bounds() for detailed explanation.

Since this commit renamed __reg64_deduce_bounds() to
deduce_bounds_64_from_64(), should this cross-reference be updated
to match?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23049683430
--===============7442985298383976832==--

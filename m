Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A773746C4A0;
	Fri, 14 Aug 2026 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786728027; cv=none; b=VkK3hARkA/APz61q+BCWdAkKgbtHg0KLbV5qkjI8AoG5y0UrSH8mY2yRGsRwKqsybFn0AZB340x1yR7qCargE/29Q3/vhthRh0NWH1/71f9c7/8xw2/pGy5/rX1/QxUjKYspmJHlQnAOwnyHc9DnBrdgGGco9g+NlgJ0QQiNUu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786728027; c=relaxed/simple;
	bh=8GQh9rBAA6z26TGLGiEp5dwivQ8gSIe4cV2lQMdApJA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=AqiliJROPPP2oQB1vy90mKN7jejik7FA0UMsqxynY+NbfG6s5cckLne3ED66E4Wh4wdiTWavSKYfa6jxk9R6jk2L0S8JJBWIY0SSbcNueQBg2e0dTyX/IUW5cn9PtcZjFh4sqaFLeFwq1srqOXTNn6LKREHVoE19JDuARECjqT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRZ47P4z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRZ47P4z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE321F000E9;
	Fri, 14 Aug 2026 17:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786728026;
	bh=uooHG2BHLaRaCcviN7u//aDnU0Dk7DLPBDrQSrFtMjQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=RRZ47P4zT7vH8OU2cUfv2KQwSQI16CnyFtQf6GOINZvae5FGAkyHLsv1rdQo5i6r4
	 jMSoH+DPlKEOwRpop034Rxh/emIo+Ie8jJEb/ZW4JkdBtZe8UqdwQerp2UR//qJX8h
	 uWxkRX9ZFYfUz3oJdPOZbMoRDb81Ddee/og/bUYgBWwoFN4cugmei03mtgWx4lrOGX
	 5ACVu5yldj7eadW99+OeA6nJj7lh0OIx8spzWWgyPBfh1D/HN+6xYPycs/pCyIaW9L
	 IBqW0btDn9JVJO7Zksm9Sx5mKPhIw40JVrAw1TUexquj4DQzzrgm0NbCytgjDQw0Yd
	 zp/XQx7uI8nVg==
Content-Type: multipart/mixed; boundary="===============5964117934427762234=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <51dfecf5aebb1ed4bf613936150b1fd55b3852e6bf3c88fda0756a286a581109@mail.kernel.org>
In-Reply-To: <20260814144116.2767304-1-cui.tao@linux.dev>
References: <20260814144116.2767304-1-cui.tao@linux.dev>
Subject: Re: [PATCH] sched_ext/scx_flatcg: expire cached hweights on weight changes
From: bot+bpf-ci@kernel.org
To: cui.tao@linux.dev,tj@kernel.org,void@manifault.com
Cc: arighi@nvidia.com,changwoo@igalia.com,suzhidao@xiaomi.com,yphbchou0911@gmail.com,zhaomengmeng@kylinos.cn,sched-ext@lists.linux.dev,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,cui.tao@linux.dev,cuitao@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 14 Aug 2026 17:20:25 +0000 (UTC)

--===============5964117934427762234==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> sched_ext/scx_flatcg: expire cached hweights on weight changes
>
> fcg_cgroup_set_weight() updates cgc->weight and the parent's
> child_weight_sum but doesn't bump hweight_gen, so the hweights cached by
> cgrp_refresh_hweight() stay stale until some task activation bumps the
> generation. For cgroups whose tasks never go through a 0->n runnable
> transition (e.g. persistently busy ones), a cpu.weight change never
> propagates to scheduling at all.
>
> Bump hweight_gen on weight changes so the next refresh recomputes with
> the new weight.
>
> Verified on a flatcg VM: a live cpu.weight 100->800 change on a busy
> cgroup leaves HWT update at 0 and the distribution unchanged; with it,
> hweight_gen increments and the refresh recomputes.

This looks like a bug fix. Should this include a Fixes: tag pointing to
the commit that introduced the scx_flatcg scheduler?

  Fixes: a4103eacc2ab4 ("sched_ext: Add a cgroup scheduler which uses flattened hierarchy")

This isn't a bug, but should the verification sentence say "without this
change" to make the "with it" contrast more explicit? The first clause
lacks a matching counterpart, so on first read the "with it" appears to
refer back to something unstated.

>
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>

> diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
> index fec3595818269..059b68ca00cbc 100644
> --- a/tools/sched_ext/scx_flatcg.bpf.c
> +++ b/tools/sched_ext/scx_flatcg.bpf.c
> @@ -604,6 +604,9 @@ void BPF_STRUCT_OPS(fcg_cgroup_set_weight, struct cgroup *cgrp, u32 weight)
>  		pcgc->child_weight_sum += (s64)weight - cgc->weight;
>  	cgc->weight = weight;
>  	bpf_spin_unlock(&cgv_tree_lock);
> +
> +	/* expire cached hweights so the new weight propagates */
> +	__sync_fetch_and_add(&hweight_gen, 1);
>  }
>
>  static bool try_pick_next_cgroup(u64 *cgidp)


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31820156939
--===============5964117934427762234==--

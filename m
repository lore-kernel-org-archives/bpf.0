Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E9921CFF6
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 19:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771010476; cv=none; b=nW3idCjqvbmS08eKQhNH1NZv+iHtfTWQL0Z4tWE15PbcHQ/tiHNRihSwLaMbMx57dJ2WfIie5NRL3EHH4gxG21FhCazXLsDEN9e4uuCaT4ET71qHz1LA2XrDcTJpup6TmF+4nVwcm19kqdYkCSUKQt/acaBY+MyUkV/RPCAbHto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771010476; c=relaxed/simple;
	bh=ynHZci9pV7HpnT6lXdrYCKj+P02I+ZwewkW+m0hz6EQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=P374yt23gds9cgGbYWhF8a+aoP6MWwjACL6Mb3Xc+by753NwczSSUMAyGy/ZfE8zlLA0Il9iJRvoErqHXgtxQq3OKS6CrqtYeDVckbDh3AExZa5rWDM2Bg5wZUnwIcfQ8/XYer5M6lRYi8xrbXBn2Gx9QZNCWuEal7maewx10xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsFbXWbm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsFbXWbm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15213C116C6;
	Fri, 13 Feb 2026 19:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771010476;
	bh=ynHZci9pV7HpnT6lXdrYCKj+P02I+ZwewkW+m0hz6EQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=LsFbXWbmyfMoZHg61ebE32NCtx5vLmOat1Y3NN9NZSQMzhZ8LozWDvy5FOT1BU75y
	 ZvlBNQw3pyeFQ6ZKzDM+eFLfvdmSbdmYgtzliN6ESgljNrluLm13WXdTgiFIny9E90
	 +fv2WrNEdw1NHlPGiF2W7G/nGE0dnJ0stv/2JxgatRimSzm+D1wAVre7iPDU3MifZT
	 1mgT6cD22u791yNNPU0lP0Krz2PWoePNFhPoivyO/E4ZfH0QiNKKG/XYDn48fDUtDm
	 9GmiMLhMmzrqnfT+eKE+2bo7RsE900nMpKqDBn3dDmcUIH8hTfPYcs8/bVAYWBPTgb
	 p7KleYdddHiSA==
Content-Type: multipart/mixed; boundary="===============3198666041322034169=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c0c998028128dd292cee56826b219491d24924dd98d2196c79f9890d76d49c67@mail.kernel.org>
In-Reply-To: <20260213185155.337935-1-mykyta.yatsenko5@gmail.com>
References: <20260213185155.337935-1-mykyta.yatsenko5@gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: Fix special fields mem leak for non-prealloc maps
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,eddyz87@gmail.com,memxor@gmail.com
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 13 Feb 2026 19:21:16 +0000 (UTC)

--===============3198666041322034169==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -279,6 +279,36 @@ static void htab_free_elems(struct bpf_htab *htab)
>  	bpf_map_area_free(htab->elems);
>  }
>
> +/*
> + * Clear special fields (timer/wq/task_work) poisoned by cancel_and_free()
> + * in recycled preallocated map elements.

The comment says "preallocated map elements", but this function is also
called from alloc_htab_elem() for non-prealloc elements that are recycled
through bpf_mem_cache_alloc(). Should this say "recycled map elements"
instead?

> + *
> + * Uses WRITE_ONCE to match the READ_ONCE/xchg/cmpxchg used by concurrent
> + * readers on the underlying pointer (bpf_async_kern.cb / bpf_task_work_kern.ctx).
> + */
> +static void bpf_obj_init_special_fields(const struct btf_record *rec, void *obj)

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21999202181

AI-authorship-score: low
AI-authorship-explanation: The patch demonstrates deep domain expertise in BPF internals and concurrency, is authored by a known contributor to the subsystem, and shows no typical AI-generated code patterns.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Minor comment inaccuracy in bpf_obj_init_special_fields saying preallocated when the function also serves non-prealloc elements; no functional impact.

--===============3198666041322034169==--

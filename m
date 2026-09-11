Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF153EC82E;
	Fri, 11 Sep 2026 04:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789100916; cv=none; b=Jecsw2pK2KPty/w0qrX4x/umPYpJmQspQbFnlEIW/b1MqUl6ro+PZyQ4SQvP/dkyLk43tiuXofey97VhnW+zs9JjnSnAgrW5zEBeEOLzUnkuV4yvsaudOnTRnKGQBeXgAyWxjIDo47vjaLsbWt4MbRa6df1upM98LSe48zVknSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789100916; c=relaxed/simple;
	bh=Dx/c25sb/XTyqL3+46QtE9jlHycNbKSaaDR1GRMTW64=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Z+r2cuUKXOQqDGohi5WzMoUsGjrV+5FSLHSeu8E9oJ5X+PdqqgxHMMCOlf2Td+3HtZkyihhY1HTXAEf3FgtMWxKiTNBLORJpZPTRh94NEMQ/sfguEfPVphLlUnZxFjYhs+Wg3rs106/PuVu1OgtFfGIpJJWYRaJMcBWt+OYyscA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8GqsQST; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8GqsQST"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3149C1F00893;
	Fri, 11 Sep 2026 04:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789100914;
	bh=Brr0L5XVcMypGJPmh3VttfJ85LRlkXb59ZjzBMJV85w=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=S8GqsQST+qPDBHzSdWvs3sWfnhCDJHSr8pZN9dxbosQuSNCiyZ6QIqSQtISKlczUX
	 5EcoFXjseAumW6M267Sxl2D1sF6onPbkjyx95C0SVG0ArxGQmUYcfF2LRz4Res1Vb1
	 qEp9VsH0E1WFBv/I4Ly8xje9w2LppJPA8qYyienmF9sTcYer32aXBn1teesDJ6yF2n
	 pmHz8J+X7O5bws/wE6vJA07ALiSFdToHxV8r7qPKDDy/RV6afOnb83HRBOXwwMJkea
	 Qn/Gx1MtXuwGaiVstUadA626UdeBLSG+eEbksr31Pix5ACbYpKHFCr8OccHTcvdKwH
	 Ngn9Ihl1+6CmA==
Content-Type: multipart/mixed; boundary="===============8542153647152711809=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c55811f4eb2a0d4884ee2eb3167557cd405a5b7aecd988a51acf525c77e3a0e1@mail.kernel.org>
In-Reply-To: <20260911034715.219552-2-diannaaav@gmail.com>
References: <20260911034715.219552-2-diannaaav@gmail.com>
Subject: Re: [PATCH bpf-next v5 1/2] bpftool: Add recursive map dumping
From: bot+bpf-ci@kernel.org
To: diannaaav@gmail.com,qmo@kernel.org,bpf@vger.kernel.org
Cc: andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 11 Sep 2026 04:28:34 +0000 (UTC)

--===============8542153647152711809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index 684a8fb72414..c0505f504967 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c

[ ... ]

> @@ -826,12 +827,44 @@ static void free_map_kv_btf(struct btf *btf)
>  		btf__free(btf);
>  }
>
> +struct map_dump_ctx {
> +	struct hashmap *seen;
> +	__u32 *pending_ids;
> +	size_t pending_cnt;
> +};
> +
> +static int collect_inner_map(struct map_dump_ctx *ctx, __u32 id)
> +{
> +	__u32 *ids;
> +	int err;
> +
> +	if (hashmap__find(ctx->seen, id, NULL))
> +		return 0;
> +
> +	ids = libbpf_reallocarray(ctx->pending_ids, ctx->pending_cnt + 1,
> +				  sizeof(*ids));
> +	if (!ids) {
> +		p_err("mem alloc failed");
> +		return -1;
> +	}
> +	ctx->pending_ids = ids;

This isn't a bug, but since libbpf_internal.h is already being pulled
in here, would libbpf_ensure_mem() (with a cap field in struct
map_dump_ctx) be a better fit than reallocating by one element per
discovered inner map?

The pending-id array grows by exactly one element for every newly
discovered inner map, so a map-of-maps with N distinct inner maps
performs N reallocations. libbpf_ensure_mem() is designed for this
pattern and grows the buffer geometrically, keeping the growth
amortised.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34560347455
--===============8542153647152711809==--

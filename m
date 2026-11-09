Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794246146;
	b=4jqEAwv6tgLJDxUPjuoxM9L27hztBL+8QWdi94vLFSEipvGDHfFvZJc/h4m4sajXJTHI
	 Rop1GOIn9GnnMHpe+0e5eudVF1ULOb5yvUVMAENWQ3PELvliJLFVvEk/bSIxJPExtfMGe
	 p07j0Aj4p0ENmQQye+YD7tVjDY2dP7Zh3WgQQlHowWLcx2xloZnm+9kMnJrCO+osFhnpt
	 irqg272hPt8M5jFsqKLCxCX0Ku77qxsrkGgWUknqvnRzfFt9sxAeuWl9MYv/uFjhw8yOn
	 lV6s2wTR7FwwZacqiUb2v9oTtyjfXb6EZaX+sV4uz8OvX2cK13qhJi2YyTHarIVmV2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794246146;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=HVFnfxCRtLWhwbnOed4Zxay97qiBRvEPwR6EG+RbU48=;
	b=1pvudQeJNkvAhHI9Dh19+A/m/1g06N+QcXgOb653qAOF/Wp2bJMpjkat44WVEnicwkzb
	 P4dKEoiSTPinXdRHQzHKFieYhCsnYAM7/qB5OFhH0LyvTZHKqlEUBgRHdWqzfEUS30xni
	 LR2iWtm2ghrgaKnBeFafrep9deEI5127xou614+Lt9raguPF2FRV6g/BVeQBrfF78lEM5
	 Q4ADzCmNyCDcH058YJiKdrbRagCuYUrpx1ryjwHfR2aZ3VzHowpebuJhwUDFj4zvrpIPU
	 yx+4ri9NN2Hi6mlmnVoC9QoWKqh9q2zK0EfFvTrM9Z6GRn+ebzz08l0aEReK9lMyoow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ebM9YOaw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EC9606A32A;
	Mon,  9 Nov 2026 17:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ebM9YOaw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE131F008A1;
	Mon,  9 Nov 2026 17:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794246145;
	bh=HVFnfxCRtLWhwbnOed4Zxay97qiBRvEPwR6EG+RbU48=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ebM9YOawOVLtmA2XGMuhlv8wGan3pTQdH77ft7eYgClT857R5aUnFEpBDPfXfnjqe
	 +DvMGmt8t5RGSTQM3qV4DHJWR60G12VV51kuOem+FSgh52DAwLSJkLTTU0su18zi3I
	 2pe5KvhtN19W7JH6LF8tJXgsKYPfE9VCF2QrQ07qmqZLmWsLyijrFnq9WPdh71v26a
	 alnDQKCBS/T+DPkNXjBb/MCC3orjUYvn1J23gEhmuj0hBEDdfoFQV9+78GRE5TTqg3
	 DHLWFw8FHWE59ayCavIgKoEwWyGkBbYY2H/f41qBCWRpVqcsA9JDxi0jkW4Nb5vHXC
	 zjSjRpQzYvB7A==
Content-Type: multipart/mixed; boundary="===============3410284379207065469=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <4bd4574839415920b87e63fe2c5340ec54df15620210a2aad053ea7d7be14b94@mail.kernel.org>
In-Reply-To: <20261109170550.141443-2-a.s.protopopov@gmail.com>
References: <20261109170550.141443-2-a.s.protopopov@gmail.com>
Subject: Re: [PATCH v2 bpf-next 01/18] bpf: Add BTF ID sets for fmod_ret targets
From: bot+bpf-ci@kernel.org
To: a.s.protopopov@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,almagui@kernel.org,john.fastabend@gmail.com,qmo@kernel.org,brauner@kernel.org,kpsingh@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,sashal@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  9 Nov 2026 17:42:25 +0000 (UTC)

--===============3410284379207065469==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add BTF ID sets for fmod_ret targets

TL;DR: Nits only in resolve_btfids: a comment may misleadingly suggest entries
with a missing function are rejected (they only warn), and a new outer "off"
is shadowed by the inner one.

> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c

[ ... ]

> @@ -1344,7 +1355,16 @@ static bool is_arena_param(const struct btf *btf, const struct btf_param *param)
>  	       param_name_has_suffix(name, PARAM_SUFFIX_ARENA_NULLABLE);
>  }
>  
> -static int collect_kfuncs(struct object *obj, struct btf2btf_context *ctx)
> +typedef int (*set_func_fn)(struct btf2btf_context *ctx, const char *name,
> +			   u32 btf_id, u32 flags);
> +
> +/*
> + * Call FN for each function in the BTF ID sets which have SET_FLAG set. Reject
> + * an entry with flags other than ALLOWED_FLAGS, also if its function is missing.
> + */

This isn't a bug, but could this read "even if its function is missing"?
As written it can suggest that entries with a missing function are
rejected, while collect_set_funcs() only prints a WARN, increments
warnings and continues to the next entry.

[ ... ]

> @@ -1356,24 +1376,39 @@ static int collect_kfuncs(struct object *obj, struct btf2btf_context *ctx)
>  	for (next = rb_first(&obj->sets); next; next = rb_next(next)) {
>  		struct btf_id_set8 *set8;
>  		struct btf_id *set_id;
> -		u64 set_addr;
> +		u64 set_addr, off;

[ ... ]

>  		for (u32 i = 0; i < set_id->cnt; i++) {
>  			size_t off = (char *)&set8->pairs[i] - (char *)set8;
>  			const char *name = find_name_by_addr(obj, set_addr + off);

This isn't a bug, but would a distinct name for the new outer offset, for
example set_off, make it clearer which offset "set_addr + off" uses here?

The inner "size_t off" (offset of a pair within the set) now shadows the
outer "off" (offset of the set within .BTF_ids), and the inner declaration
would trigger -Wshadow.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42662799554
--===============3410284379207065469==--

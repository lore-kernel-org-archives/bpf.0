Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA56B358378
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 06:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502182; cv=none; b=Bbt2oRPLsWmHf9/WcbJtxlB8OhLDzJsAerAMDh25PJlpOVwGP7Vja8pQ6M+KL9WEp1rHtdo5yNCD2f/+kOsjLcDAhofWXHy+Mydy2nxewtAPS3YbvpMSvh/HDlnQrTGGa8dwM19gEkMwofqqzcUcotN6yS9PBqxzfVjuFfc0SYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502182; c=relaxed/simple;
	bh=bhStVmuP5Chn8Q+lAuaID6ORW73ii0G/DlRnpEM1H6s=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WhND4TJEP+9iZ72Ndx3zA0sjh8tnrdBfBj1aABMDOzeyPcQdcshcbHrH2OOr1VI3QHyQqfggx1XPXh9yTDtBnar+3JtU/Uj5Q5Lj9RmKB+p/1NvVwWSi8p2Y93xGuiHfnI/gg2PRIcN52n46vqQAUvbpJHRup7fupIjN5GfP/kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THqZbt2z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THqZbt2z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131881F00A3D;
	Fri,  4 Sep 2026 06:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788502181;
	bh=AQEmRn7FMSaQawwSOKXC+qx+NtQwZSHgXkkjORB43bM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=THqZbt2zG79TQZhEuJZj8ECxnGSVsJFWIwaMbLapRoXIVTU8yXfBACX0etd5jEZfl
	 PiT1u99CVdMc57DYX0L6yqrWENTzX+LGvjws5eiafAdUQU20I5vAVkGCZUtS8DPTjt
	 uKxryYmWx5xjX6jeVn36LFqyN23m631h7AK7KhCzgx7DNfXwWCx507qROZxVV5wZbt
	 IYsYGSsqXygR0jxh9C/FUW2ZFin6xPvXOEhu/BMq44/PM0JhSxMI5wof/ymvQ34Qw0
	 Wq2+uMVBkkCaGeSMbOLVtzLxsLMBf76HsPrUFfKKUMK4w6ucBbvJ9vzXM7rrMqN64y
	 he8KJNLNIGnug==
Content-Type: multipart/mixed; boundary="===============4869065197338784549=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8d16df40357e1ac7177a9e63e754fb506f348198ee3dfbad37d7c969b0f13431@mail.kernel.org>
In-Reply-To: <20260904051038.3980676-1-yonghong.song@linux.dev>
References: <20260904051038.3980676-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 08/12] bpf: Record a 16-byte argument alignment in the function model
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  4 Sep 2026 06:09:41 +0000 (UTC)

--===============4869065197338784549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 3a7eb2185c35..5b93aa97f1bc 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1193,6 +1193,9 @@ struct bpf_prog_offload {
>  	u32			jited_len;
>  };
>
> +/* Argument aligned to 16 bytes. */
> +#define BTF_FMODEL_ALIGN16_ARG		BIT(0)
> +
>  /* The argument is signed. */
>  #define BTF_FMODEL_SIGNED_ARG		BIT(1)

[ ... ]

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 6c391449e298..f933a675b0a8 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7633,6 +7633,15 @@ int btf_distill_func_proto(struct bpf_verifier_log *log,
>  		}
>  		m->arg_size[i] = ret;
>  		m->arg_flags[i] = __get_arg_fmodel_flags(btf, &args[i], t);
> +
> +		align16 = btf_type_align16(btf, t, 0);
> +		if (align16 < 0) {
> +			bpf_log(log, "The function %s arg%d type %s has unknown alignment.\n",
> +				tname, i, btf_type_str(t));
> +			return -EINVAL;
> +		} else if (align16) {
> +			m->arg_flags[i] |= BTF_FMODEL_ALIGN16_ARG;
> +		}
>  	}
>  	m->nr_args = nargs;
>  	return 0;

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 030fb37c22ef..461883158ffa 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11748,6 +11748,31 @@ bool btf_struct_is_composed_of(struct bpf_verifier_env *env,
>  	return btf_struct_member_walk(env, btf, t, member_kinds, 0, NULL);
>  }
>
> +int btf_type_align16(const struct btf *btf, const struct btf_type *t, int rec)
> +{
> +	const struct btf_member *member;
> +	int ret;
> +	u32 i;
> +
> +	while (btf_type_is_array(t))
> +		t = btf_type_skip_modifiers(btf, btf_array(t)->type, NULL);
> +
> +	if (btf_type_is_int(t))
> +		return t->size > 8;
> +	if (!btf_type_is_struct(t))
> +		return 0;
> +	if (rec >= BTF_MEMBER_MAX_DEPTH)
> +		return -E2BIG;
> +
> +	for_each_member(i, t, member) {
> +		ret = btf_type_align16(btf, btf_type_skip_modifiers(btf, member->type, NULL),
> +				       rec + 1);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}

This isn't a bug, but btf_type_align16() looks structurally similar to
kfunc_arg_align() further down in the same file. Both walk types with the
same pattern: strip arrays with `while (btf_type_is_array(t))`, test for
`btf_type_is_int(t)` with `t->size > 8`, bail on `!btf_type_is_struct(t)`,
check `rec >= BTF_MEMBER_MAX_DEPTH`, and recurse through members via
`btf_type_skip_modifiers(btf, member->type, NULL)`. Could the two share one
walk, and would hiding the `rec` argument behind a wrapper keep the exported
signature simpler, the way btf_struct_is_composed_of() wraps
btf_struct_member_walk()?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33840714551
--===============4869065197338784549==--

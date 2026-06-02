Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3712357CEB;
	Tue,  2 Jun 2026 10:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780396948; cv=none; b=pAuQsq2gCyxiSaiVT9l06wEJqLz2dwxSf5B6bDpaT0lVYRHv3PfMQHGbQE1/cM99GiQ1dXpQPlS/f7PuAiy9GvU18mIvRfjzvWWIHMe0xr/n7ZbB2HY8nhQga8aOFujq2At28DvOUKrAODnbuRy5YwbPge9C8s3BHxX29iIvdg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780396948; c=relaxed/simple;
	bh=UpnKTFJwYYk2YyxzrPLPljtFJP9GPrW2eeHL6X4ORtM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=aRNMktgONts4P3vIuyvqO00PMiQoWRdvBWeqEaVcRe8144WxtRdvXaIWp4GZQZF4FExdMKtszrAr/VVTpOGR/JUUvOTpOkOb19BBa5KnKez1E07T6WVP5efkmU6ylgj6aJKWfxgyrVbVM1M3OcF6sByTnLT0O4l+bxPi96s/N6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gi95sUhH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gi95sUhH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442FF1F00893;
	Tue,  2 Jun 2026 10:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780396946;
	bh=mSoYaCAUmkuPRBUcUyfyJzmc/sxoH+48pweWEr5NtsA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gi95sUhHdtgZhymyvX4K6YmsPwqA62hBXigZ+jyXVy2gu0DSYhV51XTGU0OCi7tOU
	 hRNoNxbbCqwk6uRAlOfb92q/8MAqgX+2Ize0M45HCAJcrOeB/dyI8ydn7blMYwfsVL
	 WMpJ0M/d1/vA07NmRJgRRgNZ2YalGAP1yVQO+opPMUU36FOIGmng4p20MdMegIFlLj
	 Eeh4S8aGy79TlWCGV+J1ELhicZZ1opc07NScI4sKfvkEETDEQ9NsSuvoR9G3qf34vJ
	 Spa7jGmTeQDQ5Yed7bAC8mCKzXov5sl63l7yfT/SGCVj8QPMw96zuBNY2D1TC/2+Hu
	 lceyXqBe8N80A==
Content-Type: multipart/mixed; boundary="===============5238431668704563574=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c18516ffb5e7280f6956b650ee3072bfc66fbef8807a0b96c8d370278aa189e9@mail.kernel.org>
In-Reply-To: <20260602093836.2632714-2-chenyuan_fl@163.com>
References: <20260602093836.2632714-2-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf v4 1/2] bpf: Fix kfunc implicit arg inject type detection to prevent invalid pointer deref
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,eddyz87@gmail.com,yonghong.song@linux.dev
Cc: andrii@kernel.org,ast@kernel.org,bot+bpf-ci@kernel.org,bpf@vger.kernel.org,chenyuan@kylinos.cn,chenyuan_fl@163.com,clm@meta.com,daniel@iogearbox.net,ihor.solodrai@linux.dev,jolsa@kernel.org,linux-kernel@vger.kernel.org,martin.lau@kernel.org,martin.lau@linux.dev,memxor@gmail.com,song@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  2 Jun 2026 10:42:26 +0000 (UTC)

--===============5238431668704563574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7fb88e1cd7c4..57e5fdf9f7e0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12082,9 +12082,22 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  			continue;
>  		}
>
> -		if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(meta, i))
> +		if (is_kfunc_arg_ignore(btf, &args[i]))
>  			continue;
>
> +		if (is_kfunc_arg_implicit(meta, i)) {
> +			/* list_push / rbtree_add kfuncs have implicit args
> +			 * (e.g. 'off' parameter) handled during verification
> +			 * in bpf_fixup_kfunc_call().  Don't flag them.
> +			 */

A small note here: the v2 review asked for a comment recording that this
workaround exists because of the pahole 1.30 BTF mismatch, so the code can be
removed once that toolchain issue is no longer relevant.  The comment block
here only documents the list_push/rbtree_add exception and does not mention the
pahole 1.30 rationale.  Should that be added?

> +			if (is_bpf_list_push_kfunc(meta->func_id) ||
> +			    is_bpf_rbtree_add_kfunc(meta->func_id))
> +				continue;
> +			verbose(env, "%s unrecognized implicit argument, possible BTF mismatch\n",
> +				reg_arg_name(env, argno));
                                ^^^^^^^^^^^^^^^^^^^^^^^

Will this compile?  I cannot find a declaration of argno or a definition of
reg_arg_name() anywhere in the tree at this commit.

The per-argument loop in check_kfunc_args() names its register index regno,
not argno:

kernel/bpf/verifier.c:check_kfunc_args() {
    ...
    for (i = 0; i < nargs; i++) {
        ...
        u32 regno = i + 1, ref_id, type_size;
        ...
    }
}

There is no argno in this function, and git grep for reg_arg_name at this
commit returns only this call site, with no definition or declaration.  That
would give "argno undeclared" and an implicit declaration of reg_arg_name(),
which is an error under -Werror=implicit-function-declaration, so
kernel/bpf/verifier.c (obj-y, always built) would fail to build.

The rest of this function uses regno with an R%d format, for example "R%d is
not a scalar".  Did you mean something like:

	verbose(env, "R%d unrecognized implicit argument, possible BTF mismatch\n",
		regno);

The bpf-ci bot and sashiko-bot both raised this on v3 and v4, and it still
reads reg_arg_name(env, argno) verbatim here:

  https://lore.kernel.org/bpf/20260602085827.2562222-2-chenyuan_fl@163.com/

> +			return -EFAULT;
> +		}
> +

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26812478701
--===============5238431668704563574==--

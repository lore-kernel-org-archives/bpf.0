Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378BA340A6D;
	Wed, 21 Jan 2026 02:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768961766; cv=none; b=rYPmEEjPbbOWuCavwyFjWQHxQLHkjZe8NXBdiJndxLszLfno6pOR+A/1N0QC863ioPBWWXKZKf5pOzYylnW4KChReqIUs9t55YzQ6RZfVwkrNXtjxSkIK0Ya0fADZot7/EOW89mCpoyaKDt62LTzOQOOfjF35CA9V0q2hobfxlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768961766; c=relaxed/simple;
	bh=2MOCRyXu8ZaFqYG4cvlaaz22U2NOb0JSsUjJSlHibeY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=iLWXMnDcrFYwjpUTP8tJNUWLF4AmYTs5ZQdwDA8StCHerlsjwljqsKwViZcOgnetiqKnALK4GKudaVmaH3yK4lmK+VYazERg4ruK/62AAb+yOR2EbNjXhCu2PG5pojp7+r4zhEaTD2JVey0fP9DTOyJN8KvQWC7sXg1NiSXSFrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9RPYNCL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9RPYNCL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7904FC16AAE;
	Wed, 21 Jan 2026 02:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768961766;
	bh=2MOCRyXu8ZaFqYG4cvlaaz22U2NOb0JSsUjJSlHibeY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=m9RPYNCLXck8UDxF1l8OU4xDZDuOcKwPDW4PctmGV8EksIqn7IB9t7HpXV+1cTwBy
	 E62U7j44O7C+AVJkJhFekqoErCX5zIu1kGlK+v/4RI+b0D8V9GpIQ1N/aqPelK9zIR
	 7jf0eq0/p9f5IsfZEoCsHl1whDudoTE7wgGBbGvMKJGbMVBfINevk45Ht1tCQbhb+G
	 0+EWXoze966pPlX5bPLXOIhFfmJ159vKCDWlxc28NSMSQ7eVAH6X444NGZRLtLS8BY
	 ulY3G2BJC1V6JO180LAPiEBEzB4ZMA7ldAq6n9hSVG8RqxqOS7CyrE5x9PSzyqYQce
	 vnx79idJypBYw==
Content-Type: multipart/mixed; boundary="===============6515518196209418825=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f5d7058d44d03e21fecfdeb4c6b7d0329ff4f764fe24aa6f86d5c5da9ccfa3ad@mail.kernel.org>
In-Reply-To: <20260121015157.7283-1-chensong_2000@189.cn>
References: <20260121015157.7283-1-chensong_2000@189.cn>
Subject: Re: [PATCH] kernel/bpf/btf.c: reject to register duplicated kfunc
From: bot+bpf-ci@kernel.org
To: chensong_2000@189.cn,martin.lau@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,chensong_2000@189.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 21 Jan 2026 02:16:04 +0000 (UTC)

--===============6515518196209418825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index d10b3404260f..b4ded7669642 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -8615,12 +8615,23 @@ static int btf_check_iter_kfuncs(struct btf *btf, const char *func_name,
>  	return 0;
>  }
>
> -static int btf_check_kfunc_protos(struct btf *btf, u32 func_id, u32 func_flags)
> +static int btf_check_kfunc_protos(struct btf *btf, u32 func_id, u32 func_flags,
> +			const struct module *module)
>  {
>  	const struct btf_type *func;
>  	const char *func_name;
>  	int err;
>
> +	/* check if there is any duplicated kfunc in vmlinux */
> +	if (module) {
> +		func = btf_type_by_id(btf_vmlinux, func_id);

The func_id parameter comes from the module's BTF (via btf_relocate_id),
but this code looks it up in btf_vmlinux. BTF type IDs are specific to
each BTF - vmlinux and modules have independent ID namespaces.

Is this lookup correct? btf_type_by_id(btf_vmlinux, func_id) will return
whatever type happens to be at that numeric ID in vmlinux, not the type
with the same name as the module's kfunc. For example, if the module's
kfunc has BTF ID 100, this returns vmlinux type ID 100, which is likely
an unrelated struct or typedef.

This seems like it would cause false positives - any module kfunc
registration would fail if its BTF ID happens to fall within vmlinux's
BTF ID range (vmlinux typically has tens of thousands of types).

To detect duplicate names, shouldn't this use btf_find_by_name_kind()
to search by the function name instead of btf_type_by_id()?

> +		if (func) {
> +			pr_err("kfunc %s is already present in vmlinux\n",
> +						btf_name_by_offset(btf_vmlinux, func->name_off));

Since func is an unrelated vmlinux type (not the module's kfunc), this
error message prints the wrong function name - it shows whatever random
vmlinux type was found at that ID, not the module's kfunc name.

> +			return -EINVAL;
> +		}
> +	}

[ ... ]

> @@ -8911,7 +8922,7 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
>
>  	for (i = 0; i < kset->set->cnt; i++) {
>  		ret = btf_check_kfunc_protos(btf, btf_relocate_id(btf, kset->set->pairs[i].id),
> -					     kset->set->pairs[i].flags);
> +					     kset->set->pairs[i].flags, kset->owner);

This shows that func_id passed to btf_check_kfunc_protos is from the
module's BTF (btf_relocate_id operates on the module's btf), confirming
the namespace mismatch when it gets looked up in btf_vmlinux above.

>  		if (ret)
>  			goto err_out;
>  	}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21194595610

--===============6515518196209418825==--

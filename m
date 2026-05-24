Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7666717BA2;
	Sun, 24 May 2026 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779614133; cv=none; b=b7W7LdRc+LWAWI9lGwjJmkcvbWTVFnHHixq3dFwLr7szteJmpZbNefS8A3rQ0oHxM+hYWVNubhh36ipYFC1wvbWbk3n1ClZC97F3gWvnL9zvLR5hprTyBEsziQwdntVOuSMVJbkwTiH/jMcsnFtnlV+4w7sCJXupDXyb6mLzDcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779614133; c=relaxed/simple;
	bh=1Di4iThA01yRrzOMzaM77LmDLs6VRd31ocBku8z+EJ8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=inFPvGHTFPRVOIjuCAARK1LjBudBskfL9IRIoT/sxA5ZMyrYgZ9aqPhdnh/fo96nghDmnb7g0K2HIwK7TiyKj2WWV1SwXyN9d+vzV+du8WXs3limG7Y1dJemmbmUQI8ZyeFPlkJ8U+De6HUFtKbattu070khDmBPCLHIo8Ic7Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWIEyQ63; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWIEyQ63"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA90E1F000E9;
	Sun, 24 May 2026 09:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779614132;
	bh=Oty1LxxD0n8FHBtk1hrNw3GW9X8S/OOGerS0BRE6utM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=iWIEyQ63Ws9r+JBHJJNQlAzmj28dKh4PzH6f8m4WTuwNmppvN8SzlMjGbLnvhDlTG
	 CzEXT542iJj/nOmGCHmgO3Ra1zIghrv3UGVu8fiAWFQ0YRdmIEVOQyzSiDR/PwVxYV
	 MEjsRzcmSSJC8QlklPsbPUjy/5Mg6lV7fwXi1etI9ZrPnFC/TBzoiwBYgbjlSWM2Ub
	 Khi73jKzfr5T1H2RFL18pAC6eDNtr8wind1AGoYA3ND6wQWjvsQcI0W1eOcIcxcEEb
	 ZzqcZI30WBMKZC+kOmm+B+O+mo8HEs/cyYIVMeQv9tFOVyRgl8QujDoLdMMl/6yvJZ
	 l6vA1lQD7E7bA==
Content-Type: multipart/mixed; boundary="===============4917593662841231434=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e5ca9aed83f28248172fb088e55dc1cf7170417b0e45ec564ee0da4791bcee99@mail.kernel.org>
In-Reply-To: <20260524082944.10625-1-chensong_2000@126.com>
References: <20260524082944.10625-1-chensong_2000@126.com>
Subject: Re: [PATCH v3] kernel/bpf/btf.c: reject to register duplicated kfunc
From: bot+bpf-ci@kernel.org
To: chensong_2000@126.com,martin.lau@linux.dev,ast@kernel.org,alexei.starovoitov@gmail.com,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,kaitao.cheng@linux.dev
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,chensong_2000@126.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 24 May 2026 09:15:31 +0000 (UTC)

--===============4917593662841231434==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 17d4ab0a8206..425c9f5c64fa 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -8673,6 +8673,47 @@ static int btf_check_iter_kfuncs(struct btf *btf, const char *func_name,
>  	return 0;
>  }
>
> +static int btf_check_kfunc_name(struct btf *btf, const char *func_name, u32 kind)
> +{
> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> +	struct btf_module *btf_mod, *tmp;
> +#endif
> +	s32 id;
> +	int ret = 0;
> +
> +	if (!btf_is_module(btf))
> +		goto out;

During v2 review, Alexei Starovoitov suggested a different approach: instead
of rejecting duplicate kfunc registration, he proposed allowing module kfuncs
to override kernel kfuncs, similar to livepatching. He stated: "imo that's a
more interesting use case than helping out-of-tree module to produce nicier
error" and "I'm not convinced that we should be doing it... because ^^^ is
what I think we should be doing instead."

The author requested implementation guidance on how the override mechanism
would determine which kfunc to call, but received no maintainer response.

Should this implementation be reconsidered? The current approach rejects
duplicates, but the maintainer's feedback indicated preference for an
override/livepatching mechanism instead.

Reference: https://lore.kernel.org/bpf/CAADnVQJEjhJH6+2cLJ0jM_fZ366oU3yoK1b5aMk=VgksXhJtoQ@mail.gmail.com/

> +
> +	id = btf_find_by_name_kind(bpf_get_btf_vmlinux(),
> +					func_name, kind);
> +	if (id >= 0) {
> +		pr_err("kfunc %s (id: %d) is already present in vmlinux.\n",
> +					func_name, id);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> +	mutex_lock(&btf_module_mutex);
> +	list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
> +		if (btf_mod->btf == btf)
> +			continue;
> +		id = btf_find_by_name_kind(btf_mod->btf,
> +					func_name, kind);
> +		if (id >= 0) {
> +			pr_err("kfunc %s (id: %d) is already present in module %s.\n",
> +					func_name, id, btf_mod->module->name);
> +			ret = -EINVAL;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&btf_module_mutex);
> +#endif
> +
> +out:
> +	return ret;
> +}
> +
>  static int btf_check_kfunc_protos(struct btf *btf, u32 func_id, u32 func_flags)
>  {
>  	const struct btf_type *func;
> @@ -8686,7 +8727,8 @@ static int btf_check_kfunc_protos(struct btf *btf, u32 func_id, u32 func_flags)
>
>  	/* sanity check kfunc name */
>  	func_name = btf_name_by_offset(btf, func->name_off);
> -	if (!func_name || !func_name[0])
> +	if (!func_name || !func_name[0]
> +			|| btf_check_kfunc_name(btf, func_name, BTF_INFO_KIND(func->info)))
>  		return -EINVAL;
>
>  	func = btf_type_by_id(btf, func->type);

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26356787905
--===============4917593662841231434==--

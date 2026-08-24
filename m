Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C4033A6E2;
	Mon, 24 Aug 2026 13:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578319; cv=none; b=uQEN4kwO8dbJF8gcYC7J0Spy3QAXJc0wpG64QSmub5BnWsOQT2V1hztsMQuZNZiY6FJcbiedU/TpM1fhwseNnLr6Uuu8IOESpPcpoqG+eplrDcsJSgl7CpakuDdgppvBGrQrP0aYemZ1zj96SUDz6i8/JZLtf3LSkOrX0ix6AZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578319; c=relaxed/simple;
	bh=GNCGui7P2AnmzIfr9ZkhsD6RefuXjdvfS82HsheqZsM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=sQrEuo6A0TRVlHL7/JU3ykvpAePwnCDkM1kA6+bG7vkICP8vCwO7UXwirycGKRrC+mJbuoHSBY1ofCZu4tO5WXYrO1yNUXe3bxcwJRtAiEXPx3kmebSVfxxYHYlgG8c3+EtKXDpN8aERWPDNjnLDy66FxJroxdZ7HRu0haN7EZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HamXLMwu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HamXLMwu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4B01F00A3A;
	Mon, 24 Aug 2026 13:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787578312;
	bh=OxKKi0/V2fk/sc/a1SKNBUlsnCLui6ACXsD+B8Vtw+U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=HamXLMwur7SX02Ge2bLzY/iwZrndwDJFx0RlbP8TT9F4Vi47tCSuvukrjZDpQZ1LP
	 7f09Xdm7br6FYqdjFFpZ7TO8EMiSiCv1r8sZi0tJL/3PMW8s6DEG/Gm3Ik4fBIVfHv
	 Vw4KK9rQnUmBXefQSjc8DkoOY9oG5+A3Mo8VcY9JOwqu0BJF0c4uJ4AhZW9ImN3UjK
	 xDb18Lshg5zKfi01mSwsgAXTWcCs1QPDwEX+b0CNIZAd3RBRCxRjrDr7dmdgA0ub/9
	 bTlBEMrchJfbjEBXECuSFtHOhkZCNpoivwhogaXQvgK/eXX01vWJMFwwp2Nfddv+9l
	 11OouhnNyIosw==
Content-Type: multipart/mixed; boundary="===============2052238105983823877=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8b583f9deb409bec43e97f558b1e3197f2cd54ca4e5121eacada28b04749f812@mail.kernel.org>
In-Reply-To: <20260824125310.1384-2-zhaofuyu@vivo.com>
References: <20260824125310.1384-2-zhaofuyu@vivo.com>
Subject: Re: [PATCH bpf-next v4 1/2] libbpf: support selective kernel module BTF loading via bpf_object_open_opts
From: bot+bpf-ci@kernel.org
To: zhaofuyu@vivo.com,bpf@vger.kernel.org,eddyz87@gmail.com,andrii.nakryiko@gmail.com,alan.maguire@oracle.com
Cc: andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,yatsenko@meta.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,zhaofuyu@vivo.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 24 Aug 2026 13:31:52 +0000 (UTC)

--===============2052238105983823877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index b965ad571540..838602319da8 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h

[ ... ]

> @@ -224,10 +224,32 @@ struct bpf_object_open_opts {
>  	 * point (/sys/fs/bpf), in case this default behavior is undesirable.
>  	 */
>  	const char *bpf_token_path;
> +	/*
> +	 * Optional list of kernel module names whose BTFs should be loaded.
> +	 * nr_btf_module_names specifies the number of entries in
> +	 * btf_module_names.
> +	 *
> +	 * If btf_module_names is NULL, all module BTFs are loaded,
> +	 * preserving the default behavior. Otherwise, only the BTFs of
> +	 * the listed modules are loaded. A non-NULL btf_module_names
> +	 * with nr_btf_module_names equal to zero means that no module
> +	 * BTFs are loaded.
> +	 *
> +	 * The list must not contain duplicate entries; otherwise
> +	 * -EINVAL is returned.
> +	 *
> +	 * This affects:
> +	 * - BPF CO-RE relocations against types defined in modules;
> +	 * - BTF-based resolution of function attach targets for
> +	 *   fentry/fexit/fmod_ret/freplace/LSM programs;
> +	 * - extern (ksym) resolution for kernel symbols defined in modules.
                   ^^^^

This isn't a bug, but would it be worth adding struct_ops kernel-type
resolution to the "This affects:" list?

find_struct_ops_kern_types() (tools/lib/bpf/libbpf.c:1049) looks up
'bpf_struct_ops_<name>' via find_ksym_btf_id(), which falls back to
obj->btf_modules[] after load_module_btfs().

A struct_ops implementation whose kernel type lives in a module (e.g. a
module-provided tcp_congestion_ops or sched_ext-style struct_ops) will
therefore stop resolving once a filter that omits that module is supplied.

> +	 */
> +	const char **btf_module_names;
> +	size_t nr_btf_module_names;
>
>  	size_t :0;
>  };
> -#define bpf_object_open_opts__last_field bpf_token_path
> +#define bpf_object_open_opts__last_field nr_btf_module_names



---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32730521630
--===============2052238105983823877==--

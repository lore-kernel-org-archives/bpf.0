Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AF2440A24;
	Wed, 26 Aug 2026 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787753629; cv=none; b=uFRr4nsa8V8xxY4zkD1LGLqQBobv8C5qy7uR9pCDJ8A7HpuAFm1OVo8QgJWUZkDkN5BGsIKjacdNuT9fK9lFpw3WylBXtEjRiqT8vCxvuV9e5KTpk8nx9RwrQQeivyI00AfBhEwokuHj5/ewZBmVEqzLGyVJO7iIuIdIMJo4mrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787753629; c=relaxed/simple;
	bh=siQQzugb6i2GxW3ETzgbi78tK5vYrkY8qWh3zvVC33o=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=JSonYZUs8f00Q/3QE+vo6cT3Gweo70kd1obElf2h7YEgr7yls8GrLLie2iPTiINkDuf4nJTgPFZ5lfpUQpn2BJmHnroIsXJA6f6VR4Ee9w4FgvVAbvqGL9TEpNMFKPxEmuW/YrGJY3HtT/dvKZW+3F+FLfwO3ImYY28qM5fe4/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eam7gz7U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eam7gz7U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC8E1F000E9;
	Wed, 26 Aug 2026 14:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787753627;
	bh=DoNai0egyuEuE3N9WXxIRle4kZ+94rBQFqleqlia+10=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=eam7gz7UW6PcX1jh0FNTvGikkfBgPpUkCRNGAkp8ZQ9VEkcjy/rKskE/jZkFNxgUb
	 q6vhbgLx1dl5+j1ZuQyc7pnr1MdsIDDau5XB2kqowVyzijmNk/bt8gacOv4CDkGpTp
	 9cV0Uvp4PPs8Q6VIVMF8rv4XXA0t9HAGllrkYMlJvEsN96SQDPH9Us/BbyCrmayC9q
	 GiWNHvbefkwgsBJAHMEHFdqaklu1CHnPIfv9Q3iPTwVl6SfZiM4eAbWzU3Xm2PyQNU
	 YDj8VQQ+BXeZOPAXw4j0XQYFx8ROGh4aa7g6ZzH0acOrlYXg0eR6GqIYFo/60AMRH3
	 EI1e0ksRKFElg==
Content-Type: multipart/mixed; boundary="===============1356956985035104454=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <70202a9e53b06c7d44cd83b2824fc43fab79a2ac24d0e0c71bb95759eca5508c@mail.kernel.org>
In-Reply-To: <20260826131428.302-2-zhaofuyu@vivo.com>
References: <20260826131428.302-2-zhaofuyu@vivo.com>
Subject: Re: [PATCH bpf-next v5 1/2] libbpf: support selective kernel module BTF loading via bpf_object_open_opts
From: bot+bpf-ci@kernel.org
To: zhaofuyu@vivo.com,bpf@vger.kernel.org,eddyz87@gmail.com,andrii.nakryiko@gmail.com,alan.maguire@oracle.com
Cc: andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,yatsenko@meta.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,zhaofuyu@vivo.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 26 Aug 2026 14:13:46 +0000 (UTC)

--===============1356956985035104454==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b749c01742ee0..a466aabf35e1c 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -5851,6 +5854,99 @@ int bpf_core_add_cands(struct bpf_core_cand *local_cand,
>  	return 0;
>  }
>
> +static void bpf_object_free_btf_module_names(struct bpf_object *obj)
> +{

Andrii Nakryiko raised a concern in v3 about the naming convention used
here. Internal helper functions should not use double underscore naming, as
that convention is reserved for extern method-like APIs. Would
bpf_object_free_module_names and bpf_object_init_module_names be more
appropriate, following the single underscore pattern for internal helpers?

Reference: https://lore.kernel.org/bpf/CAEf4BzbbdjeSW88EEk2xRvAxq-HWUJ7qTw4BYnL3kLH0f0uhwg@mail.gmail.com/

> +	size_t i;
> +
> +	if (!obj->btf_module_names)
> +		return;
> +
> +	for (i = 0; i < obj->nr_btf_module_names; i++)
> +		zfree(&obj->btf_module_names[i]);
> +	zfree(&obj->btf_module_names);
> +	obj->nr_btf_module_names = 0;
> +}
> +
> +static int bpf_object_init_btf_module_names(struct bpf_object *obj,
> +					    const struct bpf_object_open_opts *opts)
> +{
> +	const char **names;
> +	size_t i, j, cnt;
> +	int err;
> +
> +	names = OPTS_GET(opts, btf_module_names, NULL);
> +	if (!names)
> +		return 0;
> +
> +	cnt = OPTS_GET(opts, nr_btf_module_names, 0);
> +
> +	/*
> +	 * Allocate one entry for an empty list to distinguish it from the
> +	 * default behavior.
> +	 */
> +	obj->btf_module_names = calloc(cnt ?: 1,
> +				       sizeof(*obj->btf_module_names));
> +	if (!obj->btf_module_names)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < cnt; i++) {
> +		if (!names[i] || !names[i][0]) {
> +			pr_warn("invalid kernel module BTF name at index %zu\n", i);
> +			err = -EINVAL;
> +			goto err_out;
> +		}
> +
> +		for (j = 0; j < i; j++) {
> +			if (strcmp(obj->btf_module_names[j], names[i]) == 0) {
> +				pr_warn("duplicate kernel module BTF name '%s'\n",
> +					names[i]);
> +				err = -EINVAL;
> +				goto err_out;
> +			}
> +		}

Andrii Nakryiko suggested in v3 that the module name list should be sorted
and duplicates detected in a single pass rather than using the O(n^2)
nested loop approach. The suggestion was to error out with -EINVAL if
duplicates are found after sorting. Would this optimization be worth
implementing?

Reference: https://lore.kernel.org/bpf/CAEf4BzbbdjeSW88EEk2xRvAxq-HWUJ7qTw4BYnL3kLH0f0uhwg@mail.gmail.com/

> +
> +		obj->btf_module_names[i] = strdup(names[i]);
> +		if (!obj->btf_module_names[i]) {
> +			err = -ENOMEM;
> +			goto err_out;
> +		}
> +
> +		obj->nr_btf_module_names++;
> +	}
> +	return 0;
> +
> +err_out:
> +	bpf_object_free_btf_module_names(obj);
> +	return err;
> +}

[ ... ]

> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index b965ad5715403..b8c1d98d69d85 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -224,10 +224,32 @@ struct bpf_object_open_opts {
>  	 * point (/sys/fs/bpf), in case this default behavior is undesirable.
>  	 */
>  	const char *bpf_token_path;
> +	/*
> +	 * Optional list of kernel module names whose BTFs should be loaded.
> +	 * nr_btf_module_names specifies the number of entries in
> +	 * btf_module_names.
> +	 *
> +	 * With btf_module_names:
> +	 * - when provided, only the BTFs of the specified modules are loaded;
> +	 * - when an empty list is provided, no module BTFs are loaded;
> +	 * - when NULL, all module BTFs are loaded as before.
> +	 *
> +	 * The list must not contain duplicate entries; otherwise -EINVAL is
> +	 * returned.
> +	 *
> +	 * This affects:
> +	 * - BPF CO-RE relocations against types defined in modules;
> +	 * - BTF-based resolution of function attach targets for
> +	 *   fentry/fexit/fmod_ret/freplace/LSM programs;
> +	 * - struct_ops kernel type resolution;
> +	 * - extern (ksym) resolution for kernel symbols defined in modules.
> +	 */

Looking at the 'This affects:' list and the -EINVAL contract, are there two
things missing?

First, load_module_btfs() has four callers in libbpf.c, but the list above
covers only three: bpf_core_find_cands (CO-RE relocations), find_kernel_btf_id
(fentry/fexit/etc), and find_ksym_btf_id (extern resolution). The fourth
caller is find_attach_module(), which is reached from tracing_multi_mod_fd()
and collect_func_ids_by_glob() for 'module:glob' attach patterns:

    mod = find_attach_module(obj, pattern);
    if (!mod) {
        err = -EINVAL;
        goto cleanup;
    }

So a user who sets btf_module_names and then attaches a tracing-multi
program with 'mymod:foo*' gets -EINVAL if mymod is not in the list, but the
documented behavior above doesn't hint that this option affects multi-attach
module resolution.

Second, the -EINVAL contract mentions only duplicates, but
bpf_object_init_btf_module_names() also rejects NULL and empty-string
entries:

    if (!names[i] || !names[i][0]) {
        pr_warn("invalid kernel module BTF name at index %zu\n", i);
        err = -EINVAL;

Would it be worth clarifying both of these in the documentation?

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

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32974547426
--===============1356956985035104454==--

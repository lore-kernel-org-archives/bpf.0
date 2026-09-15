Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEC43BD63B
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 13:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789479230; cv=none; b=bDTqudXu6HmweMlOQgzRXPv7mj8xTCCtHmukRMaaeDjesKrQYGpanTk9RjIIp6hjiInsFbCC7V1GjaJOpD+/uSOORppxgo+DPkF71EgZEfuLSLUxms7kCdw0mx5PEOaTC1SZpcXAk8QM95MzuwW/mRAWkRkHzAxHywmjVG2fVMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789479230; c=relaxed/simple;
	bh=HZGmmDf0hwKPF6vc1Yoa7g0dVX4Kigh2Son7Dazb4WA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jFh7SY0eL1NgLNUYHME75znsORDBkj9jOq26tOypUhCJpPRftd+j5XWIbB7P2mJ+PRVlgydyuHBDyoWbgQvcil6diy8eP4iWZk4QgPmRvtKHO3PrsyCL8l9eM2fd30rzeoJJ6BwPpvJgqckH/chhudYvr2OUCINhfbDT+t7Gr9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gu/HFAL0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gu/HFAL0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8BDE1F00893;
	Tue, 15 Sep 2026 13:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789479229;
	bh=jRuMx/eNVLBuNoCwxR8Evlo3ullrqv35DCQBAHzp2Mk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gu/HFAL0kJInOZqFcMGC8nNMytwNVLK65MeZt0Rg+EpFUCKnvgBhMfvuhi3QTWSlJ
	 hCDg/b2HVE3XtlTYwskvDuFTplbyxKZ5DEUnG9DPHdU3738JzxObz4moDFTWg0sNYN
	 jI8MTnbZ2Oa3hojZIJ8u0ULYBpq5ACVs/6whqIqj6ZV5viVAJEBSvs9cNAQaSrdSnd
	 Qax4wB1i8K7tYKcvJ9dYcz0mU4IaS+bYHfkSnMr9iVV5MEzn2mNOD+VKM6WNxLHDyZ
	 lASPLw83vJZY4kApqsqqw9EeGyz5wqjV9eF5pL1jwRIFtwXN6cwp/uwayOMfqWwaUp
	 rt5aqH3K+Hv4w==
Content-Type: multipart/mixed; boundary="===============0593099552983870878=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f8c574661d83a77fecbcb19d996d08ff15de281cc585b7a7e76c8e7476c6c8ef@mail.kernel.org>
In-Reply-To: <20260915124104.77287-2-zhaofuyu@vivo.com>
References: <20260915124104.77287-2-zhaofuyu@vivo.com>
Subject: Re: [PATCH bpf-next v9 1/2] libbpf: support selective kernel module BTF loading via bpf_object_open_opts
From: bot+bpf-ci@kernel.org
To: zhaofuyu@vivo.com,bpf@vger.kernel.org
Cc: eddyz87@gmail.com,andrii.nakryiko@gmail.com,alan.maguire@oracle.com,olsajiri@gmail.com,zhaofuyu@vivo.com,andrii@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 15 Sep 2026 13:33:48 +0000 (UTC)

--===============0593099552983870878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 613afae26519..d6f297bd5dfb 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -5838,6 +5840,21 @@ int bpf_core_add_cands(struct bpf_core_cand *local_cand,
>  	return 0;
>  }
>
> +static bool is_btf_mod_allowed(const struct bpf_object *obj, const char *name)
> +{
> +	ssize_t i;
> +
> +	if (obj->btf_module_allowlist_cnt < 0)
> +		return true;
> +
> +	for (i = 0; i < obj->btf_module_allowlist_cnt; i++) {
> +		if (strcmp(obj->btf_module_allowlist[i], name) == 0)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  static int load_module_btfs(struct bpf_object *obj)
>  {
>  	struct bpf_btf_info info;
> @@ -5860,6 +5877,9 @@ static int load_module_btfs(struct bpf_object *obj)
>  	if (!kernel_supports(obj, FEAT_MODULE_BTF))
>  		return 0;
>
> +	if (obj->btf_module_allowlist_cnt == 0)
> +		return 0;
> +
>  	while (true) {
>  		err = bpf_btf_get_next_id(id, &id);
>  		if (err && errno == ENOENT)
> @@ -5902,6 +5922,11 @@ static int load_module_btfs(struct bpf_object *obj)
>  			continue;
>  		}
>
> +		if (!is_btf_mod_allowed(obj, name)) {
> +			close(fd);
> +			continue;
> +		}
> +
>  		btf = btf_get_from_fd(fd, obj->btf_vmlinux);

[ ... ]

> @@ -5926,6 +5951,9 @@ static int load_module_btfs(struct bpf_object *obj)
>  			break;
>  		}
>  		obj->btf_module_cnt++;
> +
> +		if (obj->btf_module_allowlist_cnt == obj->btf_module_cnt)
> +			break;
>  	}

In an earlier review thread for v6, Alan Maguire suggested adding optional
flexibility to distinguish between modules that must exist versus modules
that are optional. He proposed a required_module_cnt parameter to handle
scenarios where a module might be built-in ('y') on one kernel and a
module ('m') on another:

  "it might be good to retain the non-existent module tolerance optionally
  somehow (a required_module_cnt perhaps?) since it's often the case that
  a module is built-in on one kernel and a module on another. If a module
  is builtin ("y" instead of "m"), having a way to say "load this if it
  is a module but don't fail if it is not present" would be handy, since
  the needed BTF would then be in vmlinux BTF rather than module BTF."
  https://lore.kernel.org/bpf/b2602c85-c5ad-42d9-9f64-1bb7e1100a85@oracle.com/

While you initially agreed to add module count verification, was the
follow-up enhancement suggestion for optional required_module_cnt
deliberately deferred, or should it be considered for this version?

> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 48266e752223..d3415a0671a8 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -224,10 +224,24 @@ struct bpf_object_open_opts {
>  	 * point (/sys/fs/bpf), in case this default behavior is undesirable.
>  	 */
>  	const char *bpf_token_path;
> +	/*
> +	 * Optional allowlist of kernel module names whose BTFs libbpf is
> +	 * allowed to load. The allowlist limits which kernel module BTFs libbpf
> +	 * will consult wherever module BTF might be needed.
> +	 *
> +	 * When the option is not specified, the existing behavior remains
> +	 * unchanged. An explicitly specified empty list prevents libbpf from
> +	 * consulting any kernel module BTFs.
> +	 *
> +	 * The list must contain valid, non-empty module names and must not
> +	 * contain duplicate entries; otherwise -EINVAL is returned.
> +	 */
> +	const char **btf_module_allowlist;
> +	size_t btf_module_allowlist_cnt;

Does the documentation accurately describe how the empty list case works?
The implementation distinguishes three states purely by the pointer, not
the count:

    obj->btf_module_allowlist_cnt = mod_allow ? mod_allow_cnt : -1;

so btf_module_allowlist == NULL yields -1, which is_btf_mod_allowed()
treats as 'allow everything'. The only way to reach the documented
empty-list state is to set btf_module_allowlist to some non-NULL pointer
while leaving btf_module_allowlist_cnt at 0, but C has no zero-length
array literal to point it at. Should the comment explain this explicitly?

Also, does the error handling match what the comment describes? The
comment says "otherwise -EINVAL is returned" but bpf_object__open_file()
and bpf_object__open_mem() return NULL with errno == EINVAL rather than
-EINVAL directly:

    return libbpf_ptr(bpf_object_open(...));

Only bpf_object__open_skeleton() actually returns -EINVAL. Should the
documentation clarify that the *_open*() functions set errno rather than
returning a negative value?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34972296720
--===============0593099552983870878==--

Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277A430FC1E
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 07:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772694009; cv=none; b=EbpSS8HQ/JvP0REEJ/HoLyowuKyB1kEhgxgQNysI1A3JAkQCbqsMG6TafRS/s9Uqo1DURkWW1FlgzmWSOYY0Xrzi+VVyHioMZawDpyKejyP29Zx7MpOTLZlJXeVkclKwvGcEjhE7u3S5gx04erzpS/DmdL/3TtZ4RxSAyq+idRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772694009; c=relaxed/simple;
	bh=I7U/rIja0hkqLwde0y+xCfy9HDS+KsjUXWaIjEhHC4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lEn+/QnhpxXjKHQGbb3jUVHeaTLIm3T0Vyp/MuACrntIno0INEkHa7SvDPCRrEQ5bBnOfJ+NWrRWG2AfZa7OBCXzO8DNxLBGwrMqHUNFesQboui4MITCRoGZdn/CyAxHFFJhJb6TcN/pXLUlP/iRgTtHHu0o6CFoQAbjEPBIRbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d+lAoFVb; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d+lAoFVb"
Message-ID: <0f3ec422-4b98-4311-96de-ccfc86bb22ad@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772693996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PKZjmBMs6uqPznaGXDzSJjOUHnipnd2ok2ANadgI9vQ=;
	b=d+lAoFVbsuaB+CybiKDAzO2i5esmKLgwufdF+C5F76sc0uWwZg3kZY5/EGedhxIoQw8cYz
	ZRa0oFWamJLBwkTW+Sn0LbEy/eztxvvHpJbHUIqM7usdiXMN2fAuP9QwHfJffg725RVPQB
	OfaNwTcTKPH/OtyzEhFnJgnwzTJXEng=
Date: Thu, 5 Mar 2026 14:59:48 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv2 bpf-next 15/23] libbpf: Add support to create tracing
 multi link
Content-Language: en-US
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 Menglong Dong <menglong8.dong@gmail.com>, Steven Rostedt <rostedt@kernel.org>
References: <20260304222141.497203-1-jolsa@kernel.org>
 <20260304222141.497203-16-jolsa@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260304222141.497203-16-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/3/26 06:21, Jiri Olsa wrote:
> Adding bpf_program__attach_tracing_multi function for attaching
> tracing program to multiple functions.
> 
>   struct bpf_link *
>   bpf_program__attach_tracing_multi(const struct bpf_program *prog,
>                                     const char *pattern,
>                                     const struct bpf_tracing_multi_opts *opts);
> 
> User can specify functions to attach with 'pattern' argument that
> allows wildcards (*?' supported) or provide BTF ids of functions
> in array directly via opts argument. These options are mutually
> exclusive.
> 
> When using BTF ids, user can also provide cookie value for each
> provided id/function, that can be retrieved later in bpf program
> with bpf_get_attach_cookie helper. Each cookie value is paired with
> provided BTF id with the same array index.
> 
> Adding support to auto attach programs with following sections:
> 
>   fsession.multi/<pattern>
>   fsession.multi.s/<pattern>
>   fentry.multi/<pattern>
>   fexit.multi/<pattern>
>   fentry.multi.s/<pattern>
>   fexit.multi.s/<pattern>
> 
> The provided <pattern> is used as 'pattern' argument in
> bpf_program__attach_kprobe_multi_opts function.
> 
> The <pattern> allows to specify optional kernel module name with
> following syntax:
> 
>   <module>:<function_pattern>
> 
> In order to attach tracing_multi link to a module functions:
> - program must be loaded with 'module' btf fd
>   (in attr::attach_btf_obj_fd)
> - bpf_program__attach_kprobe_multi_opts must either have
>   pattern with module spec or BTF ids from the module
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c   | 309 +++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h   |  15 ++
>  tools/lib/bpf/libbpf.map |   1 +
>  3 files changed, 325 insertions(+)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 34987ce7cdc8..8842adcf8c8a 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -7716,6 +7716,52 @@ static int bpf_object__sanitize_prog(struct bpf_object *obj, struct bpf_program
>  static int libbpf_find_attach_btf_id(struct bpf_program *prog, const char *attach_name,
>  				     int *btf_obj_fd, int *btf_type_id);
>  
> +static inline bool is_tracing_multi(enum bpf_attach_type type)
> +{
> +	return type == BPF_TRACE_FENTRY_MULTI || type == BPF_TRACE_FEXIT_MULTI ||
> +	       type == BPF_TRACE_FSESSION_MULTI;
> +}
> +
> +static int tracing_multi_mod_fd(struct bpf_program *prog, int *btf_obj_fd)
> +{
> +	const char *attach_name, *sep, *mod_name = NULL;
> +	int i, err, mod_len = 0;
> +
> +	*btf_obj_fd = 0;
> +	attach_name = strchr(prog->sec_name, '/');
> +
> +	/* Program with no details in spec, using kernel btf. */
> +	if (!attach_name)
> +		return 0;
> +
> +	attach_name++;
> +	sep = strchr(attach_name, ':');
> +	if (sep) {
> +		mod_name = attach_name;
> +		mod_len = sep - mod_name;
> +	}
> +
> +	/* Program with no module section, using kernel btf. */
> +	if (!mod_name)
> +		return 0;
> +
> +	err = load_module_btfs(prog->obj);
> +	if (err)
> +		return err;
> +
> +	for (i = 0; i < prog->obj->btf_module_cnt; i++) {
> +		const struct module_btf *mod = &prog->obj->btf_modules[i];
> +
> +		if (mod_name && strncmp(mod->name, mod_name, mod_len) == 0) {

strncmp() is not enough to exactly compare two module names, as
strncmp() only compares the first 'mod_len' bytes.

So, mod_name "foo" could match mod "foobar", since 'obj->btf_modules'
are not sorted by name after loading from kernel.

To find the exact module via module name, "strncmp() == 0 &&
mod->name[mod_len] == '\0'" would be better.

> +			*btf_obj_fd = mod->fd;
> +			return 0;
> +		}
> +	}
> +
> +	/* Specified module was not found, let's bail out. */
> +	return -EINVAL;
> +}
> +
>  /* this is called as prog->sec_def->prog_prepare_load_fn for libbpf-supported sec_defs */
>  static int libbpf_prepare_prog_load(struct bpf_program *prog,
>  				    struct bpf_prog_load_opts *opts, long cookie)
> @@ -7779,6 +7825,18 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
>  		opts->attach_btf_obj_fd = btf_obj_fd;
>  		opts->attach_btf_id = btf_type_id;
>  	}
> +
> +	if (is_tracing_multi(prog->expected_attach_type)) {
> +		int err, btf_obj_fd = 0;
> +
> +		err = tracing_multi_mod_fd(prog, &btf_obj_fd);
> +		if (err < 0)
> +			return err;
> +
> +		prog->attach_btf_obj_fd = btf_obj_fd;
> +		opts->attach_btf_obj_fd = btf_obj_fd;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -9835,6 +9893,7 @@ static int attach_kprobe_session(const struct bpf_program *prog, long cookie, st
>  static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
>  static int attach_lsm(const struct bpf_program *prog, long cookie, struct bpf_link **link);
>  static int attach_iter(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> +static int attach_tracing_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
>  
>  static const struct bpf_sec_def section_defs[] = {
>  	SEC_DEF("socket",		SOCKET_FILTER, 0, SEC_NONE),
> @@ -9883,6 +9942,12 @@ static const struct bpf_sec_def section_defs[] = {
>  	SEC_DEF("fexit.s+",		TRACING, BPF_TRACE_FEXIT, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
>  	SEC_DEF("fsession+",		TRACING, BPF_TRACE_FSESSION, SEC_ATTACH_BTF, attach_trace),
>  	SEC_DEF("fsession.s+",		TRACING, BPF_TRACE_FSESSION, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
> +	SEC_DEF("fsession.multi+",	TRACING, BPF_TRACE_FSESSION_MULTI, 0, attach_tracing_multi),
> +	SEC_DEF("fsession.multi.s+",	TRACING, BPF_TRACE_FSESSION_MULTI, SEC_SLEEPABLE, attach_tracing_multi),
> +	SEC_DEF("fentry.multi+",	TRACING, BPF_TRACE_FENTRY_MULTI, 0, attach_tracing_multi),
> +	SEC_DEF("fexit.multi+",		TRACING, BPF_TRACE_FEXIT_MULTI, 0, attach_tracing_multi),
> +	SEC_DEF("fentry.multi.s+",	TRACING, BPF_TRACE_FENTRY_MULTI, SEC_SLEEPABLE, attach_tracing_multi),
> +	SEC_DEF("fexit.multi.s+",	TRACING, BPF_TRACE_FEXIT_MULTI, SEC_SLEEPABLE, attach_tracing_multi),
>  	SEC_DEF("freplace+",		EXT, 0, SEC_ATTACH_BTF, attach_trace),
>  	SEC_DEF("lsm+",			LSM, BPF_LSM_MAC, SEC_ATTACH_BTF, attach_lsm),
>  	SEC_DEF("lsm.s+",		LSM, BPF_LSM_MAC, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_lsm),
> @@ -12258,6 +12323,250 @@ static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, stru
>  	return ret;
>  }
>  
> +#define MAX_BPF_FUNC_ARGS 12
> +
> +static bool btf_type_is_modifier(const struct btf_type *t)
> +{
> +	switch (BTF_INFO_KIND(t->info)) {
> +	case BTF_KIND_TYPEDEF:
> +	case BTF_KIND_VOLATILE:
> +	case BTF_KIND_CONST:
> +	case BTF_KIND_RESTRICT:
> +	case BTF_KIND_TYPE_TAG:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool is_allowed_func(const struct btf *btf, const struct btf_type *t)
> +{
> +	const struct btf_type *proto;
> +	const struct btf_param *args;
> +	__u32 i, nargs;
> +	__s64 ret;
> +
> +	proto = btf_type_by_id(btf, t->type);
> +	if (BTF_INFO_KIND(proto->info) != BTF_KIND_FUNC_PROTO)
> +		return false;
> +
> +	args = (const struct btf_param *)(proto + 1);
> +	nargs = btf_vlen(proto);
> +	if (nargs > MAX_BPF_FUNC_ARGS)
> +		return false;
> +
> +	/* No support for struct/union return argument type. */
> +	t = btf__type_by_id(btf, proto->type);
> +	while (t && btf_type_is_modifier(t))
> +		t = btf__type_by_id(btf, t->type);
> +
> +	if (btf_is_struct(t) || btf_is_union(t))
> +		return false;
> +
> +	for (i = 0; i < nargs; i++) {
> +		/* No support for variable args. */
> +		if (i == nargs - 1 && args[i].type == 0)
> +			return false;
> +
> +		/* No support of struct argument size greater than 16 bytes. */
> +		ret = btf__resolve_size(btf, args[i].type);
> +		if (ret < 0 || ret > 16)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +static int
> +collect_btf_func_ids_by_glob(const struct btf *btf, const char *pattern, __u32 **ids)
> +{
> +	__u32 type_id, nr_types = btf__type_cnt(btf);
> +	size_t cap = 0, cnt = 0;
> +
> +	if (!pattern)
> +		return -EINVAL;
> +
> +	for (type_id = 1; type_id < nr_types; type_id++) {
> +		const struct btf_type *t = btf__type_by_id(btf, type_id);
> +		const char *name;
> +		int err;
> +
> +		if (btf_kind(t) != BTF_KIND_FUNC)
> +			continue;
> +		name = btf__name_by_offset(btf, t->name_off);
> +		if (!name)
> +			continue;
> +
> +		if (!glob_match(name, pattern))
> +			continue;
> +		if (!is_allowed_func(btf, t))
> +			continue;
> +
> +		err = libbpf_ensure_mem((void **) ids, &cap, sizeof(**ids), cnt + 1);
> +		if (err) {
> +			free(*ids);
> +			return -ENOMEM;
> +		}
> +		(*ids)[cnt++] = type_id;
> +	}
> +
> +	return cnt;
> +}
> +
> +static int collect_func_ids_by_glob(struct bpf_object *obj, const char *pattern, __u32 **ids)
> +{
> +	const char *mod_name = NULL, *sep;
> +	int i, err, mod_len = 0;
> +	struct btf *btf = NULL;
> +
> +	err = bpf_object__load_vmlinux_btf(obj, true);
> +	if (err)
> +		return err;
> +
> +	/* In case we have module specified, we will find its btf and use that. */
> +	sep = strchr(pattern, ':');
> +	if (sep) {
> +		mod_name = pattern;
> +		mod_len = sep - pattern;
> +		pattern = sep + 1;
> +
> +		err = load_module_btfs(obj);
> +		if (err)
> +			goto cleanup;
> +
> +		for (i = 0; i < obj->btf_module_cnt; i++) {
> +			const struct module_btf *mod = &obj->btf_modules[i];
> +
> +			if (!strncmp(mod->name, mod_name, mod_len)) {

Same concern here.

Would it be better to factor out a helper to find module via name?

Thanks,
Leon

[...]


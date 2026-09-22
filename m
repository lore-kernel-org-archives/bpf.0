Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B283403E8
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 02:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790042504; cv=none; b=fZHfgZgGafI+vrJ93ZmidxsCKyDAj2N+wRf/4cYA/7L6bZIBwWLzncEHco/RRJRfVm6Pcf/tpzNhZqjTUAkDTuojT0Qg/h+IU/4RyGlvvwOs6XDjuA3mkE60e1Al1k4yCoXSxHe0z/qy1Xr2266kkEVbudgbRgKUkBsMY9KlnZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790042504; c=relaxed/simple;
	bh=PpOtd1YKtxsx6f87LLZ3nDKvqJiCnT7v6hHppRPLKeQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jXOdLhC3NYuCzlFnX+kg8MJOyxjMfPpHhOwF9/mbmtP1sq0yAEyDEzPakoLAtJ1wlI+sAJ+CN8BpFZ5MweY402jwYnt9V7ShHjdWKi8OD5AcbVLfvVYwjVP5P6l59/R50QsOOP+kO3gAM+zm9WYR9zQnAXowBLL+C7o5uso9NOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTLM69J2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTLM69J2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8171F000FF;
	Tue, 22 Sep 2026 02:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790042501;
	bh=CTzbte1bJiB5o64m2KdyRI7tJlXzAbMBta9hyEsz5Ag=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=YTLM69J2gihY4LuldBdPFH9+hHmgEuYFB175Z8G2C/CocDFLAm7pIMCDXvCjxyRap
	 2YQE75sH2XMVbUbkXMPLPBIygUeid0d1B6kxaycwOwh3gHzt+GivBHVYLk9P0SztuU
	 Z2C4DhzsGroNuJnoQ2l8RuwXoWms3VCwWPPVLhmYc+sRrpw6LX1ZfyLl1qv9esALMN
	 aJURbXGR+vTUOGDIfKPtS6I/dvoLeKCEgTXoW1EbaRzGXy+Nq8PbGCZ2aU8spScTXk
	 wBbh/IW4kY6wR3vYL4dAi4yTf07VTWfK61JszaIuYADMLjLvc/VhrkMngJaQR8YlZc
	 7tQDF5kTZPE1g==
Content-Type: multipart/mixed; boundary="===============2202868088719188459=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4e82b1131fc982d16aca9eb5628d15b0dca1891e30c298202b291383674c4219@mail.kernel.org>
In-Reply-To: <20260922011323.1298619-15-alexei.starovoitov@gmail.com>
References: <20260922011323.1298619-15-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 14/17] libbpf: Support pointers to functions in read-only data in light skeleton
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 22 Sep 2026 02:01:40 +0000 (UTC)

--===============2202868088719188459==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
> index 6c5ad6c55e8a..206adf28793d 100644
> --- a/tools/lib/bpf/bpf_gen_internal.h
> +++ b/tools/lib/bpf/bpf_gen_internal.h

[ ... ]

> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index af3a04f161ac..251392aa8b41 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c

[ ... ]

> +int bpf_gen__func_ptr_map_create(struct bpf_gen *gen, const char *map_name, int obj_map_idx,
> +				 void *pvalue, __u32 value_size, const __u32 *ptr_offs,
> +				 const __u64 *ptr_vals, int ptr_cnt)
> +{
> +	int attr_size = offsetofend(union bpf_attr, map_extra);
> +	int map_create_attr, map_idx, key, value, zero = 0, i;
> +	union bpf_attr attr;
> +
> +	if (gen->nr_func_ptr_maps == gen->max_func_ptr_maps) {
> +		gen->error = -EDOM; /* internal bug */
> +		return 0;
> +	}
> +	map_idx = gen->nr_obj_maps + gen->nr_func_ptr_maps++;

Can max_func_ptr_maps end up being too small? bpf_object_load() counts
nr_progs using prog->autoload before calling bpf_gen__init(), but
bpf_object_prepare() can still turn autoload ON after that point.

The sequence is:

bpf_object_load() (libbpf.c)
  counts nr_progs from programs[i].autoload
  calls bpf_gen__init() with nr_func_ptr_maps * nr_progs

bpf_object_prepare()
  bpf_object_adjust_struct_ops_autoload() can set prog->autoload = true
  bpf_object__relocate()
    bpf_object__relocate_data()
      create_func_ptr_map()
        bpf_gen__func_ptr_map_create() <-- called for newly enabled program

bpf_object_adjust_struct_ops_autoload() enables prog->autoload if there
are autocreated struct_ops maps that reference the program (libbpf.c around
line 1212). This happens for SEC("?struct_ops/...") programs that start
with autoload = false but get re-enabled during prepare.

If such a program references a read-only map with func_ptr_cnt, it needs
a copy that was never counted in the reservation.

Since the boundary check treats max_func_ptr_maps as a hard invariant and
returns -EDOM on overflow, could a light skeleton for an object with both
a func-ptr map and a SEC("?struct_ops/...") program fail with -EDOM?

[ ... ]

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b5c580ec02bc..2e11808f7508 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -9583,8 +9615,17 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
>  	 * permit cross-endian creation of "light skeleton".
>  	 */
>  	if (obj->gen_loader) {
> +		int nr_func_ptr_maps = 0, nr_progs = 0, i;
> +
> +		/* every program may get a copy of every map with pointers to functions */
> +		for (i = 0; i < obj->nr_maps; i++)
> +			if (obj->maps[i].autocreate && obj->maps[i].func_ptr_cnt)
> +				nr_func_ptr_maps++;
> +		for (i = 0; i < obj->nr_programs; i++)
> +			if (obj->programs[i].autoload && !prog_is_subprog(obj, &obj->programs[i]))
> +				nr_progs++;
>  		bpf_gen__init(obj->gen_loader, obj->log_level | extra_log_level,
> -			      obj->nr_programs, obj->nr_maps);
> +			      obj->nr_programs, obj->nr_maps, nr_func_ptr_maps * nr_progs);
>  	} else if (!is_native_endianness(obj)) {
>  		pr_warn("object '%s': loading non-native endianness is unsupported\n", obj->name);
>  		return libbpf_err(-LIBBPF_ERRNO__ENDIAN);

This is the same ordering issue from the other side. The nr_progs loop
uses programs[i].autoload at this point in bpf_object_load(), but the
reservation is passed to bpf_gen__init() before bpf_object_prepare()
runs.

Since bpf_object_prepare() is called after this count (at libbpf.c
around line 9632), and it can raise autoload from false to true, could
the reservation be short by one copy per struct_ops program that gets
re-enabled?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35675730306
--===============2202868088719188459==--

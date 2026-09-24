Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24142E62A4
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 00:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790209931; cv=none; b=EA+Likm6o2mNcxEqX/TxsZC7kRMSJ/2gVoafrcKy1zAO6RPHOhVNP4BJJJ/o55sNzQgwOsROl9rTvOcR1U03G/EUphAe9FLEYWFApUcMTpz+RBwKjrvxy7hcblLj0Gk9IJC1uNVQgQm+H91XMGSkLk2pwxSA82JRNl6TJCo1U7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790209931; c=relaxed/simple;
	bh=5EU1JiP/o4JtKbffVK/y3gOisDrUkLWiRqd8DN/DoAo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Xf9ola54P+HRYuE1lgDMLnuwBR+G6Fv28NvX6YFa1WJXxQFnaTNWqbdcWzQw9j87z9uwOI6e6GW/VmxOMoD3Rhjb7OS7yc+KBsGH0uc2zMTh1wGj6pivrdI890wQ4UTW5ifeWdYzF+tYQMv+mY01/vhkFb7Fb1cnqqRz2cqPa7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETFtPbGV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETFtPbGV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9221F000FF;
	Thu, 24 Sep 2026 00:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790209929;
	bh=os+r3a9tmTh80T6ftK2LEX+An2itYZG8XHR9j98OC0s=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ETFtPbGVFLTX81r/ip7tW42TNLNWT3G1dRfteikJUm9RNa2IfJJA7npE+GZx00NXY
	 nGSeMqUMuE27uQbUgyLR3UAbtuydvlh7TUboHZ1T8qW/YXmpAVL1seyThwBVtoGxWG
	 tLy9vvl4C4iMRQiWKy4YWUEkp9vGcl7SzoiLkavtHbUbsXBjMKeqrqVAqXVY0EItvW
	 jrWkkGVTpQsBtd1BC2cSmSZT46fn7AVFhYZJ2YOdUfM4WuwAgcSlXY252AcpH0UR4W
	 75NOT7ZccWel2PrPdjVaxP2BritLS8oNUuJeFguQCnrzepo76lWR5lJnPuVFo+IMXc
	 lepr2h1LULvVA==
Content-Type: multipart/mixed; boundary="===============7589687938421852612=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f1e9abde3dbaa149969b0516348bd781ef4d762715941ff2984e9c5d126ffb85@mail.kernel.org>
In-Reply-To: <20260923232939.1886328-9-andrey.grodzovsky@crowdstrike.com>
References: <20260923232939.1886328-9-andrey.grodzovsky@crowdstrike.com>
Subject: Re: [PATCH bpf-next v5 8/8] selftests/bpf: Convert veristat to BPF_PROG_LOAD_STRATEGY_MANUAL
From: bot+bpf-ci@kernel.org
To: andrey.grodzovsky@crowdstrike.com,bpf@vger.kernel.org,andrii@kernel.org,ast@kernel.org
Cc: martin.kelly@crowdstrike.com,slava.imameev@crowdstrike.com,linux-open-source@crowdstrike.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 00:32:07 +0000 (UTC)

--===============7589687938421852612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
> index 9cfc9b4b41c12..0cd19b59037f6 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c

[ ... ]

> @@ -1726,18 +1725,15 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
>  	if (env.force_reg_invariants)
>  		bpf_program__add_flags(prog, BPF_F_TEST_REG_INVARIANTS);
>
> -	opts.log_buf = buf;
> -	opts.log_size = buf_sz;
> -	opts.log_level = log_level;
> +	bpf_program__set_log_buf(prog, buf, buf_sz);
> +	bpf_program__set_log_level(prog, log_level);
>
>  	cgroup_err = reset_stat_cgroup();
>  	mem_peak_a = cgroup_memory_peak();
> -	fd = bpf_program__clone(prog, &opts);
> -	if (fd < 0) {
> -		err = fd;
> -		if (env.verbose)
> -			fprintf(stderr, "Failed to load program %s %d\n", prog_name, err);
> -	}
> +	err = bpf_program__load(prog);

When bpf_object__prepare() fails earlier in process_obj(), does this path
still capture the verifier log and stats?

Both bpf_program__set_log_buf() and bpf_program__set_log_level() refuse
to work when obj->state >= OBJ_LOADED:

    /* from libbpf.c */
    if (prog->obj->state >= OBJ_LOADED)
        return libbpf_err(-EBUSY);

On failure, bpf_object_prepare() sets obj->state = OBJ_LOADED. The setters
return -EBUSY, veristat ignores these return values, and bpf_program__load()
proceeds with prog->log_buf == NULL and prog->log_level == 0.

This means no stats are captured in veristat's buf (TOTAL_INSNS, TOTAL_STATES,
DURATION all report zero), and the -v "VERIFIER LOG:" block stays empty.

The old bpf_program__clone() path took log_buf/log_size/log_level directly
from opts, which do not depend on object state, so this used to work.

[ ... ]

> @@ -2297,7 +2293,7 @@ static int process_obj(const char *filename)
>  	env.files_processed++;
>
>  	bpf_object__for_each_program(prog, obj) {
> -		bpf_program__set_autoload(prog, true);
> +		bpf_program__set_load_strategy(prog, BPF_PROG_LOAD_STRATEGY_MANUAL);
>  		prog_cnt++;
>  	}

Can struct_ops programs still be verified by veristat after this change?

bpf_program__set_load_strategy() refuses MANUAL for struct_ops programs:

    /* tools/lib/bpf/libbpf.c */
    if (prog->type == BPF_PROG_TYPE_STRUCT_OPS)
        return libbpf_err(-EINVAL);

prog->type is already BPF_PROG_TYPE_STRUCT_OPS at this point because
bpf_object_init_progs() sets it from SEC("struct_ops+") / SEC("struct_ops.s+")
during bpf_object__open_file().

process_obj() ignores the return value, so these programs stay in their AUTO
state (or AUTO/DISABLED after bpf_object_adjust_struct_ops_autoload()).

Then process_prog() calls bpf_program__load(prog), which rejects any
non-MANUAL program:

    if (prog_is_subprog(obj, prog) ||
        prog->load_strategy != BPF_PROG_LOAD_STRATEGY_MANUAL)
        return libbpf_err(-EINVAL);

Every struct_ops program gets VERDICT failure with an empty verifier log and
zero stats. No verification is attempted.

Before this change, bpf_program__clone() loaded these programs using
prog->attach_btf_id/expected_attach_type, which
bpf_object__init_kern_struct_ops_maps() fills in during bpf_object__prepare().

This affects every sched_ext scheduler (the BPF CI veristat-scx job) and the
struct_ops objects in selftests (bpf_cubic, bpf_dctcp, bpf_qdisc_*,
dummy_st_ops_*, and others).

> commit 0fd4c97df1e253ae8d918685a5e167dcf2123865
> Author: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
>
> selftests/bpf: Convert veristat to BPF_PROG_LOAD_STRATEGY_MANUAL
>
> veristat used bpf_program__clone() to verify each program in
> isolation. Replace it with BPF_PROG_LOAD_STRATEGY_MANUAL plus
> bpf_program__load()/bpf_program__unload(): process_obj() marks every
> program MANUAL and calls bpf_object__prepare() instead of
> bpf_object__load(); process_prog() loads and unloads one program at a

The commit message says process_obj() "calls bpf_object__prepare() instead of
bpf_object__load()" as though this patch makes that switch. Looking at the
parent commit, process_obj() already calls bpf_object__prepare() (veristat.c
line 2312 in HEAD~1), and this diff does not touch that call. The only change
in process_obj() is set_autoload(true) -> set_load_strategy(MANUAL).

Also, "marks every program MANUAL" is not accurate for struct_ops programs,
which bpf_program__set_load_strategy() rejects with -EINVAL (see the question
above about struct_ops verification).


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35934836796
--===============7589687938421852612==--

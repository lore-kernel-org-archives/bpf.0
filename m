Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1A3444713;
	Thu, 27 Aug 2026 11:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787829062; cv=none; b=Vjb9Wcg/eckjVbdq3PnxmwLerbLLz6JQcrWiTWWvTIJqzBmOXYAtUOqKYkc+KtNKjpgvmXlyEdu5pN2qVDGdWyaKxY34UNpoDCWg7jygn9Uug/kDNRbiJkDDmxEPwvyxYFGocOhUhFo7+VxYbbCSbcFq+RDeZ5nbLT0whiLpin0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787829062; c=relaxed/simple;
	bh=csLblvEF7PomuCSEWvL/6BgEeru+n0VaCgNQeZwA0EI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=KR9TPSwwLgXyY+2G+1VfCx7kS8ZUiLbiGbqV0eOQ/eSC5zc8X6gEHFlcrAMxxtI39OLypM7oYESqaxP5flfSHkmos0k7MQ9fTCPvG8HsAwJDcXEgAYKhuPuIy4XKm6ci0xgiu11nVu872avhK/Ux9bFQZD09M9onVgL8coIn5+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwC+dvDg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwC+dvDg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573D91F000E9;
	Thu, 27 Aug 2026 11:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787829054;
	bh=vXob/rpMQi2QRQEHDISu89Hqj+pXmFCgFtfSg61dU0E=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=DwC+dvDgNHaX/g9BXGo9hrJkg5hSVz3nMxYzN5vFuac1nSL5g4q4+nyA4qIKn1ger
	 Sg7t3I5c7qPVXr76M7LJl9yMhjW0en6iFqNVD2TX2N9zvjStKROc71gQoQ1wnhmPMa
	 cidG3KExpoAUMqxDgMmHnIg1cMPkc0EslNaaRzWWguqjS+ctdBhhzvyfiDDdTuPJLj
	 Ri7HT3Y4gOnxYMJ5PYh47btZ3AUKZIMOM5VxEVZ6qdiwtk7Nh978+GI0MhsqU8CXSN
	 SvRI2noT0wWP4YFX7gVa29UbZRQHcpYx7dactqpTcpvGSGjRsyGFY4owbs4Q6bhWmW
	 e1t8QhELoy16Q==
Content-Type: multipart/mixed; boundary="===============0691679697015854772=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f8413c983b5bbf569125bfa9d12a81f2293adc9905f89d746cc51276c21459ea@mail.kernel.org>
In-Reply-To: <20260827100214.169215-1-toke@redhat.com>
References: <20260827100214.169215-1-toke@redhat.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Move XDP frags flag to prog_flags
From: bot+bpf-ci@kernel.org
To: toke@redhat.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,lorenzo@kernel.org,toke@redhat.com
Cc: bpf@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 27 Aug 2026 11:10:54 +0000 (UTC)

--===============0691679697015854772==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b749c01742ee0..7d6f0fe518d99 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -7879,6 +7877,12 @@ static int tracing_multi_mod_fd(struct bpf_program *prog, int *btf_obj_fd)
>  	return 0;
>  }
>
> +static int setup_xdp_frags(struct bpf_program *prog, long cookie)
> +{
> +	prog->prog_flags |= BPF_F_XDP_HAS_FRAGS;
> +	return 0;
> +}

Does storing BPF_F_XDP_HAS_FRAGS in prog->prog_flags here break callers
that use bpf_program__set_flags()?

bpf_program__set_flags() overwrites rather than OR-ing:

    int bpf_program__set_flags(struct bpf_program *prog, __u32 flags)
    {
            ...
            prog->prog_flags = flags;
    }

Previously the flag was OR'd into the load-time opts by
libbpf_prepare_prog_load(), so it survived any user manipulation of
prog_flags between open and load. The new code latches it into
prog->prog_flags at open time, so it's lost whenever a caller assigns
prog_flags instead of OR-ing.

bpf_object_load_prog() passes prog->prog_flags straight to the kernel:

    load_attr.prog_flags = prog->prog_flags;

Two in-tree callers do exactly that on SEC("xdp.frags") programs.

bpftool (tools/bpf/bpftool/prog.c), i.e. 'bpftool prog load FILE PIN
xdpmeta_dev DEV':

    if (prog_type == BPF_PROG_TYPE_XDP && xdpmeta_ifindex) {
            bpf_program__set_flags(pos, BPF_F_XDP_DEV_BOUND_ONLY);
            bpf_program__set_ifindex(pos, xdpmeta_ifindex);

Before: final prog_flags = BPF_F_XDP_DEV_BOUND_ONLY | BPF_F_XDP_HAS_FRAGS.
After:  final prog_flags = BPF_F_XDP_DEV_BOUND_ONLY only.

tools/testing/selftests/bpf/xdp_hw_metadata.c on program "rx", whose
section is SEC("xdp.frags") (progs/xdp_hw_metadata.c):

    prog = bpf_object__find_program_by_name(bpf_obj->obj, "rx");
    bpf_program__set_ifindex(prog, ifindex);
    bpf_program__set_flags(prog, BPF_F_XDP_DEV_BOUND_ONLY);

The load still succeeds (BPF_F_XDP_HAS_FRAGS is optional,
kernel/bpf/syscall.c:2936), so the loss is silent:
kernel/bpf/syscall.c:3062 sets prog->aux->xdp_has_frags = 0, after which
net/core/dev.c:10418 refuses to attach the program on a device whose MTU
needs more than one buffer, skb_cow_data_for_xdp() returns -EINVAL
(net/core/skbuff.c:1021), and drivers such as mlx5 (en_main.c:4701)
restrict the RQ configuration. A multi-buffer XDP program is silently
downgraded to a single-buffer one.

Note the resulting asymmetry inside libbpf_prepare_prog_load() itself:
the other section-implied flag is still applied at load time:

    if (def & SEC_SLEEPABLE)
            opts->prog_flags |= BPF_F_SLEEPABLE;

so BPF_F_SLEEPABLE survives bpf_program__set_flags(prog, 0) while
BPF_F_XDP_HAS_FRAGS no longer does. Keeping the load-time 'opts->prog_flags
|= BPF_F_XDP_HAS_FRAGS' in addition to the new prog_flags initialisation,
or having bpf_program__set_flags() preserve section-implied bits, would give
visibility without breaking existing callers.

>
>  /* this is called as prog->sec_def->prog_prepare_load_fn for libbpf-supported sec_defs */
>  static int libbpf_prepare_prog_load(struct bpf_program *prog,
>  				    struct bpf_prog_load_opts *opts, long cookie)
>  @@ -7892,9 +7896,6 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
>  	if (def & SEC_SLEEPABLE)
>  		opts->prog_flags |= BPF_F_SLEEPABLE;
>
> -	if (prog->type == BPF_PROG_TYPE_XDP && (def & SEC_XDP_FRAGS))
> -		opts->prog_flags |= BPF_F_XDP_HAS_FRAGS;
> -

Should setup_xdp_frags() keep a program type guard?

The deleted load-time code was guarded:

    if (prog->type == BPF_PROG_TYPE_XDP && (def & SEC_XDP_FRAGS))
            opts->prog_flags |= BPF_F_XDP_HAS_FRAGS;

setup_xdp_frags() has no equivalent guard, and because the flag is now
latched into prog->prog_flags at open time it also survives a later type
change. bpf_program__set_type() only clears the section handler, not the
flags:

    prog->type = type;
    ...
    if (prog->sec_def != &custom_fallback_def)
            prog->sec_def = NULL;

So for a SEC("xdp.frags") program retyped to something else, the old code
dropped BPF_F_XDP_HAS_FRAGS while the new code keeps it.

bpftool retypes on request:

    if (bpf_program__type(pos) != prog_type)
            bpf_program__set_type(pos, prog_type);

'bpftool prog load xdp_frags.o PIN type sched_cls dev DEV' now reaches
bpf_prog_dev_bound_init() with BPF_F_XDP_HAS_FRAGS but without
BPF_F_XDP_DEV_BOUND_ONLY and is rejected:

    if (attr->prog_flags & BPF_F_XDP_HAS_FRAGS &&
        !(attr->prog_flags & BPF_F_XDP_DEV_BOUND_ONLY))
            return -EINVAL;               /* kernel/bpf/offload.c */

where it previously loaded. Without an ifindex the load still succeeds, but
a non-XDP program ends up with prog->aux->xdp_has_frags = 1
(kernel/bpf/syscall.c:3062), which changes prog-array owner compatibility
('map->owner->xdp_has_frags == aux->xdp_has_frags', kernel/bpf/core.c:2541)
and so can make a tail-call map setup fail.

The trigger requires a deliberate retype, but the guard removal is a
behaviour change that the changelog does not mention. If the flag is meant
to be XDP-only, should setup_xdp_frags() keep the type test or should
bpf_program__set_type() drop the bit when moving away from
BPF_PROG_TYPE_XDP?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33062649421
--===============0691679697015854772==--

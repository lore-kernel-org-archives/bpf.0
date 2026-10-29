Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793314454;
	b=ljI2gUQkuT4kc7DrPf0TsqCq2NMoo6YLg/xG1aVxVY523r3JAvLywPzTAIKaj/uA61lM
	 PSC9OTigO7wKCl/EFwJKwe4/11R0D0yoedBRwcfYDbzIadKDvGPUryKsDPIok23F/rU3u
	 H0x1iF87FnfK7txIyJyIExyD/QIYGevNDO3/uvrAdOf74px3GgOwdmSNrM+MSInp70wvm
	 Z10Q9jpFRtMCGqWK8rfqZcLh/oAkzh2U5pU7B+AFVWeVNkERrCMxAhd0kSd5W5qar/sxX
	 y5vD2oY3eSS7c+FdB2KiM24mhhA9v0MJJ2rmSsRmscEub7esqtApH6n/Pg8IYvT2Dqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793314454;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1WL9uIiuX6C84uHnt+eFCAdrcNjOKEKWyGO2dQfIwik=;
	b=L/HRgOqniynh3sKBkAuSWjD9BjlgLvZsV4RnEjMIVlNmlPFroinlELpdyJk4qjOGPPmh
	 HVN0Vei5NBbKic/jXhI6yJH+iOoR7WI+nva/6rwLczgOCKfhwy+60IsJkMT2NBGUKjgrr
	 DhqOvt6rdoJPYhNkf0OIUzsJc93tzk3E5qM7vcXW2IlcPa+9YIFlA0NZCkyK91N5+4t2x
	 uPJhSXs80V14g4ShiHB2bxj3oYUdnG3uwCLwzlSWi71kD07oNn3P7qelfnivFOwQcrhKJ
	 m6gcShXGq6EqvuslO9GdGtSDgQMoTQlHX50srvzOUFvf91Vg198cD0UKRKNEEOfOieQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H8buU2T9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30F2606A31A
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 22:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H8buU2T9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D691F01816;
	Thu, 29 Oct 2026 22:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793314453;
	bh=1WL9uIiuX6C84uHnt+eFCAdrcNjOKEKWyGO2dQfIwik=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=H8buU2T9AFbydJ5KCTlYu8hySId/PLJzAPWwYhj8x2bS0PIHuA+tQa1/A42qKkW9H
	 qxpDCFGW8jhjJedmFz41yTK6t6MhXM39+xYRuYCwOKsau6qvcs1YQ7pc0hcFqXaxlH
	 vkDyaAYRtEj/woyb5b9NVWax7v0vMmlWIu0vHqfcV6HXAmhhqeYAyJvvxAa9QXDqmY
	 5Ro8q23s+4SNSoRSTY6pV1wOLpHvmmlVzDwEYQy7HM7TpkQMwVoUdHmd2CmD97mRLw
	 oaiyFSgqQ+nQGDCrzp699ZK7CMTe6r+8LIRc04xafliDgfpPE8851OaNm4Il/4HSZx
	 pVoQXk9EEZqZA==
Message-ID: <sashiko-outbox-190106@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v9 4/7] libbpf: BPF programs manual loading and
 attaching
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>, bpf@vger.kernel.org
In-Reply-To: <20261029223348.3730738-5-andrey.grodzovsky@crowdstrike.com>
References: <20261029223348.3730738-1-andrey.grodzovsky@crowdstrike.com>
 <20261029223348.3730738-5-andrey.grodzovsky@crowdstrike.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 22:54:12 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] libbpf: bpf_map__init_kern_struct_ops() clobbers MANUAL load str=
ategy
--

commit dc922049cb04bf1494a0c7805a4fd1d881505fad
Author: Slava Imameev <slava.imameev@crowdstrike.com>

libbpf: BPF programs manual loading and attaching

This commit adds support for BPF_PROG_LOAD_STRATEGY_MANUAL, allowing BPF
programs to be skipped during the initial bpf_object load and loaded or
unloaded on demand via bpf_program__load() and bpf_program__unload().

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index e2cea1bca1d2d..1a5b582d63b24 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -1227,6 +1228,14 @@ static int bpf_object_adjust_struct_ops_autoload(s=
truct bpf_object *obj)
>  		if (prog->type !=3D BPF_PROG_TYPE_STRUCT_OPS)
>  			continue;
> =20
> +		/*
> +		 * If the user set the load strategy to MANUAL, don't guess it
> +		 * from map autocreate: a MANUAL program is loaded explicitly
> +		 * with bpf_program__load(), which rejects any other strategy.
> +		 */
> +		if (prog->load_strategy =3D=3D BPF_PROG_LOAD_STRATEGY_MANUAL)
> +			continue;

[Severity: Medium]
Can bpf_map__init_kern_struct_ops() overwrite a struct_ops program's
BPF_PROG_LOAD_STRATEGY_MANUAL setting before this check in
bpf_object_adjust_struct_ops_autoload() is reached?

During bpf_object_prepare(), bpf_object__init_kern_struct_ops_maps() runs
immediately before bpf_object_adjust_struct_ops_autoload():

tools/lib/bpf/libbpf.c:bpf_object_prepare() {
    ...
    err =3D err ? : bpf_object__init_kern_struct_ops_maps(obj);
    err =3D err ? : bpf_object_adjust_struct_ops_autoload(obj);
    ...
}

Inside bpf_object__init_kern_struct_ops_maps() ->
bpf_map__init_kern_struct_ops(), if a callback member is absent in the
running kernel BTF (with a zeroed shadow field) or if its slot in a
struct_ops map's shadow struct was cleared or replaced, load_strategy is
unconditionally reset to BPF_PROG_LOAD_STRATEGY_DISABLED:

tools/lib/bpf/libbpf.c:bpf_map__init_kern_struct_ops() {
    ...
    if (!kern_member) {
        ...
        if (st_ops->progs[i]) {
            st_ops->progs[i]->load_strategy =3D BPF_PROG_LOAD_STRATEGY_DISA=
BLED;
            st_ops->progs[i] =3D NULL;
        }
        ...
    }
    ...
    if (btf_is_ptr(mtype)) {
        prog =3D *(void **)mdata;
        if (st_ops->progs[i] && st_ops->progs[i] !=3D prog)
            st_ops->progs[i]->load_strategy =3D BPF_PROG_LOAD_STRATEGY_DISA=
BLED;
    ...
}

When a user sets BPF_PROG_LOAD_STRATEGY_MANUAL via
bpf_program__set_load_strategy(), those assignments clobber load_strategy to
BPF_PROG_LOAD_STRATEGY_DISABLED.

Then bpf_object_adjust_struct_ops_autoload() does not see
BPF_PROG_LOAD_STRATEGY_MANUAL, so it either leaves the program as
BPF_PROG_LOAD_STRATEGY_DISABLED (causing a subsequent bpf_program__load() to
fail with -EINVAL) or sets it to BPF_PROG_LOAD_STRATEGY_AUTO if another
autocreated struct_ops map still references it.

Should bpf_map__init_kern_struct_ops() preserve load_strategy when it is set
to BPF_PROG_LOAD_STRATEGY_MANUAL?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029223348.3730=
738-1-andrey.grodzovsky@crowdstrike.com?part=3D4

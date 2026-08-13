Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590E448CD7C
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786635497; cv=none; b=hiUIn3Lh2QfRKg9XmR6aCmlp9GXqdqGmflfl8DhPNhmlXvWUdtDf9Bod0DHZfyV4hfkK1Z9XUYKAy3OpN/jE4PVOviKq4hIP7oCKsDKw1AV09kfgH7bxb+cpSHcyQH7AcaXrDZvrCkpTC2gpNtoDarjlxuElQ5qzqVE7+zgYa9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786635497; c=relaxed/simple;
	bh=Uo4f5C6T0M51zLcZoCG3B4EgKGqWF80xf6eVkZvNw3c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uMNCD2st7Okm8qGwiFFSkn545N/16cGyNuKqXaPffRL3mz8UZ8Rc/jMsujub3kKJ/FFAUKT/kmio2+vMAmdMQFNHaGQrQ5hxzsJo+rkruu5sQhZhmgu/BO70AnYTqv36QMB4BPCztaRUNwMY21Cr8EneT2mnPTtrtJUgU/biDGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+QVbAiG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+QVbAiG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C69D1F000E9;
	Thu, 13 Aug 2026 15:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786635491;
	bh=i49qQpA7SEG7Cdqd91wDMDrYUXIQ1VSv6Ta8fQ0sNXU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q+QVbAiGC480rFxSy1iBIv8zvkIsM5vab7EWB5n/pkJtn/psNwL6xxM79YgQMwppN
	 LFjm6l8rKoHS5qA+oR64TgLqT9viSchrT0zdVREQTvLyNwNAfMfg2xfWNDms0pcl2b
	 Ao75ehaYrVDWyYTP9YZWQFaN+A8Q8PT8S1MNhTO1xMxnpFpOAYM3PjCpRetFsjO5Mt
	 Kk72poETctM6/uBpdBVjzttcxxXgVeGK0tDjx1d/a9YR7eIB0FER2E25KPnMCPXv81
	 JlxwCE8Eg//Rf1yvGG3L8kiL3O9Jq8dbfpEEH6//brZDDPvtA6/XCXyFzoVNk05NcE
	 NXpoQQ5zWq49Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v12 04/10] libbpf: Probe percpu data feature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260813152324.97937-5-leon.hwang@linux.dev>
References: <20260813152324.97937-1-leon.hwang@linux.dev>
 <20260813152324.97937-5-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 15:38:11 +0000
Message-Id: <20260813153811.6C69D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The feature probe `probe_kern_percpu_data` incorrectly returns a=
 negative error code and logs a warning when the kernel lacks support for `=
BPF_MAP_TYPE_PERCPU_ARRAY`. Feature probes in libbpf should silently return=
 0 when a feature is missing to gracefully indicate its absence without pol=
luting stderr.
--

--- Patch [4]: [PATCH bpf-next v12 04/10] libbpf: Probe percpu data feature=
 ---
commit 783c3759ac5b8bbe1c5368930abe9953ff13c465
Author: Leon Hwang <leon.hwang@linux.dev>

    libbpf: Probe percpu data feature
   =20
    This commit adds a feature probe for global percpu data support. It all=
ows
    libbpf to detect if the kernel supports percpu data early and make capa=
bility
    decisions accordingly.

> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index b7e388f99d0bb..ef9581c113035 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
[ ... ]
> +static int probe_kern_percpu_data(int token_fd)
> +{
> +	struct bpf_insn insns[] =3D {
> +		BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0),
> +		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, 0),
> +		BPF_EXIT_INSN(),
> +	};
> +	LIBBPF_OPTS(bpf_map_create_opts, map_opts,
> +		.token_fd =3D token_fd,
> +		.map_flags =3D token_fd ? BPF_F_TOKEN_FD : 0,
> +	);
> +	LIBBPF_OPTS(bpf_prog_load_opts, prog_opts,
> +		.token_fd =3D token_fd,
> +		.prog_flags =3D token_fd ? BPF_F_TOKEN_FD : 0,
> +	);
> +	int ret, map, insn_cnt =3D ARRAY_SIZE(insns);
> +
> +	map =3D bpf_map_create(BPF_MAP_TYPE_PERCPU_ARRAY, "libbpf_percpu", size=
of(int), 8, 1,
> +			     &map_opts);
> +	if (map < 0) {
> +		pr_warn("Error in %s(): %s. Couldn't create simple percpu_array map.\n=
",
> +			__func__, errstr(map));
> +		return map;
> +	}

[Severity: Medium]
Will this cause spurious warnings when probing environments that don't supp=
ort
BPF_MAP_TYPE_PERCPU_ARRAY?

Since feat_supported() expects feature probes to return 0 when a feature is
missing, returning a negative error code here causes feat_supported() to log
an additional failure warning.

Should this return 0 instead of map (and perhaps omit the pr_warn) to
gracefully indicate the feature's absence without polluting stderr?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813152324.9793=
7-1-leon.hwang@linux.dev?part=3D4

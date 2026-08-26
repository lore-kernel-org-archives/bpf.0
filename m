Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE5E39A04B
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 18:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787769201; cv=none; b=Eguaj26zjKiZtz2vIL61FUrjAU+t2QZsOUB3+MP4e6yMutH1zZD/+y7SjtCY2BJkez/CQ+d5ocKCr//i+0u2lveSNX3sgC+ZIR+pi72GQlqJUf/rW9MDu30u0BSJAH5JP75eV0k+q9uF0GEwjx+ejmfBO3i7+Z7G5a5a6qd6XHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787769201; c=relaxed/simple;
	bh=ema/PPLV+SiyZDpPoT30QkO/ZUIv13JVq+BG1LhVEhk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tHfHlYmS1Ae2Wp6Zq6jOkT3NK+Gu4B6hzB11zL0EMb4Vy8/jJlNr/mSo6aiOVI5c/8H8CVyNVoeLQJBV6+ORCS4MfPGXIGDp8aZcLIM9j7S7KBXcIZWsQTInFut2h2HNm5ycJfnkpiZQv+n4s8mblfoAJohsL33Cz7J928lDLJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTu9t7Es; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTu9t7Es"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBADA1F000E9;
	Wed, 26 Aug 2026 18:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787769186;
	bh=C9s3hzBTHpRPSaHz19Z0+IgoiIVyYOYkPLqN0FI/IaQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bTu9t7EsjoLOTjLl06oX/MjelER9LbCe0xctsfhDNhlN1v47Lp/woq+q9OUfOJd39
	 zNU1EzyCTyghtrM98uSheYcfixXV6sJjsINty7sdheQTwZIqeAMpXxoNurVCWAU9Xk
	 dkNW8149MbyPm9T58VpgAzcgFxMYKWu67tUmNp5XURdhmp7WwW/yi5sG1bDAsdUcQD
	 q16J4eiuA//0l1fEh6ep53oL+DnVXf1QapngS/3GUGRdfQvMkvP37OCRrzWYfvfdJ1
	 hG1NALKScAXT2kNi/sahzcn0+OHkKb6FoDPwWcE/0Fkgnqh79/GX0JFLbHgiYh7LAc
	 qCN+eVodFR8PA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/5] libbpf: BPF programs dynamic loading
 and attaching
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260826181825.1826541-3-andrey.grodzovsky@crowdstrike.com>
References: <20260826181825.1826541-1-andrey.grodzovsky@crowdstrike.com>
 <20260826181825.1826541-3-andrey.grodzovsky@crowdstrike.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 18:33:05 +0000
Message-Id: <20260826183305.EBADA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] `bpf_program__load_dynamically` overwrites `prog->fd` without clos=
ing the old one, leading to a file descriptor leak if the program is alread=
y loaded.
- [Medium] Public API `bpf_program__load_dynamically` returns a negative er=
ror code directly on failure instead of wrapping it in `libbpf_err()`, viol=
ating LIBBPF-001.
- [Medium] `bpf_program__load_dynamically` permanently corrupts the user-co=
nfigured `log_level` state.
- [Medium] The internal static function `bpf_program__set_dynamicload` inco=
rrectly uses the `libbpf_err()` wrapper.
- [Medium] The public API `bpf_program__load_dynamically` dereferences `pro=
g` before verifying it is not NULL.
--

commit d4848d3e91d6da741dd4f244c1469a745b1d0a7e
Author: Slava Imameev <slava.imameev@crowdstrike.com>

libbpf: BPF programs dynamic loading and attaching

BPF programs designated as dynamically loaded can be loaded and
attached independently after the initial bpf_object loading and
attaching. This patch enables these programs to be reloaded and
reattached multiple times, reducing load times for utilities with
many conditionally needed programs.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 821d854d43a9f..c3fe1de432108 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
[ ... ]
> @@ -15220,12 +15239,73 @@ void bpf_object__destroy_skeleton(struct bpf_ob=
ject_skeleton *s)
>  	free(s);
>  }
> =20
> +static int bpf_program__set_dynamicload(struct bpf_program *prog)
> +{
> +	struct bpf_object *obj;
> +	const char *attach_name;
> +
> +	obj =3D prog->obj;
> +	if (!obj)
> +		return libbpf_err(-EINVAL);

[Severity: Medium]
Is this internal static function improperly invoking the public API error
wrapper libbpf_err() instead of returning a negative error code? Because the
internal function wraps the error, errno is set prematurely, and the public
API returns an unwrapped error result.

[ ... ]
> +/*
> + * This function must be called after bpf_object__load_progs.
> + * Dynamically-loaded program data is initialized on object load.
> + * Post-load initialization is not supported.
> + */
> +int
> +bpf_program__load_dynamically(struct bpf_program *prog, int extra_log_le=
vel)
> +{
> +	int err;
> +	struct bpf_object *obj;
> +
> +	obj =3D prog->obj;

[Severity: Medium]
Can this cause a segmentation fault by dereferencing prog before verifying =
it
is not NULL? Expected behavior for libbpf public APIs is to handle NULL
arguments gracefully (as done in bpf_program__unload_dynamically).

> +	if (!obj || obj->state < OBJ_LOADED)
> +		return libbpf_err(-EINVAL);
> +
> +	if (prog_is_subprog(obj, prog) || prog->load_type !=3D BPF_PROG_LOAD_TY=
PE_DYNAMIC)
> +		return libbpf_err(-EINVAL);
> +
> +	prog->log_level |=3D extra_log_level;
> +
> +	err =3D bpf_object_load_prog(obj, prog, prog->insns, prog->insns_cnt,
> +				   obj->license, obj->kern_version, &prog->fd);

[Severity: High]
Could this lead to a file descriptor leak if the program is already loaded?
The call appears to unconditionally overwrite the prog->fd memory location
without closing the previous file descriptor.

> +	if (err) {
> +		pr_warn("prog '%s': failed to dynamically load: %d\n", prog->name, err=
);
> +		prog->log_level &=3D ~extra_log_level;
> +		return err;

[Severity: Medium]
Are we missing a libbpf_err() wrapper here? This return path directly expos=
es
a raw negative error to the caller, which may leave errno improperly set.

> +	}
> +
> +	prog->log_level &=3D ~extra_log_level;

[Severity: Medium]
Will this bitwise operation permanently corrupt the user-configured log
level? If the user previously set bits in prog->log_level that overlap with
extra_log_level, those original bits would be incorrectly cleared here
instead of being restored to their previous state.

> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826181825.1826=
541-1-andrey.grodzovsky@crowdstrike.com?part=3D2

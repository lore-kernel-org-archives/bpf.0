Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEB821FF23;
	Sat, 17 Oct 2026 14:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792248229; cv=none; b=kK+Kaseyt0VG2dcOyzBLIpehkZxzeIyb2vRcRMd6qqhzx54g4YE5fnOwBCOFUxXdbYWjXORHM988aZGKu6ARdXOzQyhrj20lSQ7WVPcpdz8P/RtMyzCZbjqdH501jV9QIBUfLIMl/tdS2PsLXGwdgPXV/jEoHL6I7soGy6pzz70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792248229; c=relaxed/simple;
	bh=99XmoOt2679q8lw2rTMuW1xaaHNxRZl2xa2M9pe2/JI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=PVBVfs8GEq859V/l3EY8Gh+dPo+OPK8GckwI7PPV3dNVat+cpG3JrOx+X/x6dD0jr0Pve/M2KNftSrcFxuTPFLuifZy9TYNqxAvMTbhhKfR5BuZN50VBOWgo90+maNMBOvhWNYUVm+EA0fiAhROhM4mFtkooHsKETjcKTRzCZZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VN3hhKaa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VN3hhKaa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CD91F000C4;
	Sat, 17 Oct 2026 14:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792248227;
	bh=k9fxlHtW65kWr79ODEPuy+lkPMlwHCZ0876+PhpW8fM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VN3hhKaaGUz5IffeSDDmZLYdCsc+uKAc1xpqSjyHOJlihc97NhoJnNjh1qfy44CKJ
	 Jg8oN1VgS7ZVvJIZR4HMNENRbtd968iYCwAg1KbKbZsM4nqQARFsfUH/+PGkbL9liF
	 FMgxhk5wfBNM9orJrtXjtiuXGQeI4iDFSz7hmw+XVYnIAbO34ShTQVv3eEOI3aOhjH
	 9eFeHqD7NUaVyh9ki+m4T6chpQU0krvrFEdQRHmdhzQ2ct4v9wouXj3uCW5ziWvepi
	 shRvvAFdFsnf3GD5voNWgtl4MjQYxGMWPFhoJRqpflbXq0rpyKH9CIKEoI7kYgKvHo
	 8V5Po0IMTODsA==
Message-ID: <sashiko-outbox-175565@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 5/6] libbpf: Add bpf_link_create_log API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261017142649.51047-6-leon.hwang@linux.dev>
References: <20261017142649.51047-1-leon.hwang@linux.dev>
 <20261017142649.51047-6-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 14:43:47 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] libbpf: missing OPTS_VALID() check for log_opts in __bpf_link_cr=
eate()
- [Medium] libbpf: bpf_link_create_log added to released LIBBPF_1.8.0 in li=
bbpf.map
--

commit 5adb04f5088a9ab6aa21d83e4c9370c13ebdaab6
Author: Leon Hwang <leon.hwang@linux.dev>

libbpf: Add bpf_link_create_log API

This commit introduces the bpf_link_create_log() API to pass struct
bpf_log_opts when creating BPF links without modifying struct
bpf_link_create_opts.

> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 17e73e443bc7a..eb127d71f3c83 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -788,9 +788,10 @@ int bpf_prog_detach2(int prog_fd, int target_fd, enu=
m bpf_attach_type type)
>  	return bpf_prog_detach_opts(prog_fd, target_fd, type, NULL);
>  }
> =20
> -int bpf_link_create(int prog_fd, int target_fd,
> -		    enum bpf_attach_type attach_type,
> -		    const struct bpf_link_create_opts *opts)
> +static int __bpf_link_create(int prog_fd, int target_fd,
> +			     enum bpf_attach_type attach_type,
> +			     const struct bpf_link_create_opts *opts,
> +			     struct bpf_log_opts *log_opts)
>  {
>  	const size_t attr_sz =3D offsetofend(union bpf_attr, link_create);
>  	__u32 target_btf_id, iter_info_len, relative_id;
> @@ -965,7 +966,7 @@ int bpf_link_create(int prog_fd, int target_fd,
>  		break;
>  	}
>  proceed:
> -	fd =3D sys_bpf_fd(BPF_LINK_CREATE, &attr, attr_sz);
> +	fd =3D __sys_bpf_fd(&attr, attr_sz, BPF_LINK_CREATE, log_opts);

[Severity: Medium]
Should __bpf_link_create() validate log_opts with OPTS_VALID(log_opts,
bpf_log_opts) before passing it to __sys_bpf_fd()?

Currently __bpf_link_create() validates opts, but not log_opts:

tools/lib/bpf/bpf.c:__bpf_link_create() {
	if (!OPTS_VALID(opts, bpf_link_create_opts))
		return libbpf_err(-EINVAL);
}

When a caller passes a malformed struct bpf_log_opts (such as an invalid sz
or non-zero unknown trailing fields) to bpf_link_create_log(),
__bpf_link_create() forwards it directly to __sys_bpf_fd(), which accesses
log_opts via OPTS_GET() and OPTS_SET() without checking OPTS_VALID().

For comparison, bpf_map_create() validates log_opts before calling
__sys_bpf_fd():

tools/lib/bpf/bpf.c:bpf_map_create() {
	log_opts =3D OPTS_GET(opts, log_opts, NULL);
	if (!OPTS_VALID(log_opts, bpf_log_opts))
		return libbpf_err(-EINVAL);

	fd =3D __sys_bpf_fd(&attr, attr_sz, BPF_MAP_CREATE, log_opts);
}

[ ... ]

> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index eeba4072a5dac..990e2f926ecc3 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -458,6 +458,7 @@ LIBBPF_1.7.0 {
> =20
>  LIBBPF_1.8.0 {
>  	global:
> +		bpf_link_create_log;
>  		bpf_map__attach_cgroup_opts;
>  		bpf_prog_stream_open;
>  		bpf_program__add_flags;

[Severity: Medium]
Should bpf_link_create_log be placed under the LIBBPF_1.9.0 stanza in
tools/lib/bpf/libbpf.map instead of LIBBPF_1.8.0?

LIBBPF_1.8.0 is already succeeded by LIBBPF_1.9.0 at the bottom of
tools/lib/bpf/libbpf.map:

LIBBPF_1.9.0 {
} LIBBPF_1.8.0;

Adding bpf_link_create_log to LIBBPF_1.8.0 exports the new symbol under the
previous version node rather than the current LIBBPF_1.9.0 development cycl=
e.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017142649.5104=
7-1-leon.hwang@linux.dev?part=3D5

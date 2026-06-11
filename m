Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AD53C1091
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 11:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781178800; cv=none; b=l4UwYEVgUOm/sLtbicAqdOGf68itD0lM+LJLv4N9bASJEfRIdIvLiYgHvXtTvd1DD/iLoa2e1K/wxVv9boF/S1au4AbatMrxPTqhcNv3V5y98YxQb+zpjF9JzGpbd/dXtgrf4/JLOR4INeUVBJdaQsC+tfGhCZHjnzG6VC5uh1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781178800; c=relaxed/simple;
	bh=FtxmyKFjgrAAI3dShoT5YtLlh+qN09sCypQxep2Efk4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fc+BRMslrX4wPiwDhMLXIbMZA0H8HSDFnSewejXr7nDIsMfK6ydGf/B+nDRgrwDAm9Vm/+mxxTaQBC1WFXtiiwXbncpiWnP0nIPrlH6Jc7AO4fixcglrevD7aM1buj0cliat2og/3TFNwzaMVjqRrQGyOC1lUv6qs+X40tCPU4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIUNYLf5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIUNYLf5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B5F1F00893;
	Thu, 11 Jun 2026 11:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781178799;
	bh=iuQNdlDNY8tB67Lvm1YXTYHX/dOVsGXu4pHfTBa8/zY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WIUNYLf5nO/28t0tm6Xj4D85Yqs1sgIjDsCflhP869kiWVl6GtUQR00Rm4IgYRNa1
	 V+fynzr4dO8uyB+NqRygzPIoucDNq+CW0o09OS7APT3epeQzEXrQDJwMwKMZhcBqiN
	 EgOwcwNw0BZmQo6D69Nt+u+haEj5Hd1FsQvMqGTD9Rqwjt0Ivwx0TACSZCzPDu7duq
	 +F+KsBt4cSPOeSzRCCtwSzZBJQnHxSI6358QiU1EXPHTbJVilwR7cIJjcg/AaIiHic
	 If6s3UbPwEV3pCldgzafT0nPoOq/UKncV06Qs2O0KJaS369Q3wQFH1ytUgrck4wv45
	 6y7QfrGFqkT/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 bpf-next 4/7] libbpf: Add path_fd to struct
 bpf_link_create_opts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260611114230.950379-5-jolsa@kernel.org>
References: <20260611114230.950379-5-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 11:53:18 +0000
Message-Id: <20260611115319.56B5F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] The kernel-side implementation for processing `path_fd` is compl=
etely missing.
- [Medium] The high-level libbpf API for uprobe_multi was not updated to su=
pport `path_fd`.
- [Low] The patch references a non-existent `path_fd` field in `union bpf_a=
ttr`'s `uprobe_multi` struct, which will cause a fatal compilation failure.
- [Low] The `path_fd` field is incorrectly typed as `__u32` instead of a si=
gned integer, breaking proper semantics for special directory file descript=
ors like `AT_FDCWD`.
--

commit f8c10c02ad07ee86163cb02487766ca5ac58a262
Author: Jiri Olsa <jolsa@kernel.org>

libbpf: Add path_fd to struct bpf_link_create_opts

This patch adds the path_fd field to struct bpf_link_create_opts and
attempts to pass it through the kernel attribute interface for uprobe_multi
links.

> libbpf: Add path_fd to struct bpf_link_create_opts
>=20
> Adding the path_fd field to struct bpf_link_create_opts and passing it
> through kernel attr interface.

[Severity: Medium]
Are there missing kernel-side changes in this patch? The commit message
states the field is being passed through the kernel attr interface, but the=
re
are no corresponding changes in sys_bpf() or bpf_uprobe_multi_link_attach()
to extract and utilize the path_fd parameter.

[Severity: Medium]
Will this feature be exposed to the high-level libbpf API? The path_fd field
was added to the low-level struct bpf_link_create_opts, but the user-facing
struct bpf_uprobe_multi_opts and bpf_program__attach_uprobe_multi() do not
appear to be updated to support it.

> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index f37e3416f61a5..96819c082c772 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -842,6 +842,7 @@ int bpf_link_create(int prog_fd, int target_fd,
>  		attr.link_create.uprobe_multi.ref_ctr_offsets =3D ptr_to_u64(OPTS_GET(=
opts, uprobe_multi.ref_ctr_offsets, 0));
>  		attr.link_create.uprobe_multi.cookies =3D ptr_to_u64(OPTS_GET(opts, up=
robe_multi.cookies, 0));
>  		attr.link_create.uprobe_multi.pid =3D OPTS_GET(opts, uprobe_multi.pid,=
 0);
> +		attr.link_create.uprobe_multi.path_fd =3D OPTS_GET(opts, uprobe_multi.=
path_fd, 0);

[Severity: Low]
Does this assignment cause a build failure? It looks like the path_fd field
has not been added to the UAPI union bpf_attr for uprobe_multi.

>  		if (!OPTS_ZEROED(opts, uprobe_multi))
>  			return libbpf_err(-EINVAL);
>  		break;

[ ... ]

> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 012354131cf66..7534a593edae2 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -444,6 +444,7 @@ struct bpf_link_create_opts {
>  			const unsigned long *ref_ctr_offsets;
>  			const __u64 *cookies;
>  			__u32 pid;
> +			__u32 path_fd;

[Severity: Low]
Should path_fd be defined as a signed integer, such as __s32 or int? File
descriptors intended for path lookup need to support special values like
AT_FDCWD (-100), which will wrap around if stored in an unsigned 32-bit
variable.

>  		} uprobe_multi;
>  		struct {
>  			__u64 cookie;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611114230.9503=
79-5-jolsa@kernel.org?part=3D1

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF49413621
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103020; cv=none; b=XjbN6W/uZuAPcYgFAn/c3lZhFH6wDhTwsiqnzNXph0oZLZ3F/PFvw9Raulf8sMZiS9LsdLH8YFvlHnr5atN41NPp8E9ckinpBNZhQh7oPESq0V++V3rLwVpgd462Hs/ol/E/8JRt5UtsnEiQi/oaop7pd4N6JWlRA+EIWAqZOyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103020; c=relaxed/simple;
	bh=Ran0zMpRXsJRyuTK86wJkUePRHg2E99dkxUquH/arqI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MjsLYChN1nvG84u/kDIwMgkRwJOmOS8PeziQ/xxnwL+jvSJMyE6JLaC/GfebPz66BULTgu48Zi/oc/TdF4XKzKusKViifgMnTsWab5tEMyb2Ku7Rb+mW9mzfpNL/a6eWASyDunCvDn+JAon9P3OT4xyKsFcOqsiIvhRKITUqOpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQRaUz/L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQRaUz/L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4791F00893;
	Wed, 10 Jun 2026 14:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781103019;
	bh=2Jz2u5Ml/pbdzPc5ikrZdMw8YQdKpulrZuRO3ZRUnrE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kQRaUz/L+OW84I8dPqYP6TtX4NtKnWSkpzwcpflB6FXQHttRrbzUniPDV93BbBwmy
	 0SQiuHBeX75Lf7pIX8aGmlMQXbz4DJn3CrYLwo9y5FIpLq3dx/tVInUmK3uVeFy3cy
	 isINtw2axx9xy5c0riOKdHDbhuJQZoapgpUNmW4yhb+TKw8Wnwm94+AB1z3RSY1/Eg
	 tXCZ4/8b7ODy7bxl2uv1vV/vzmrVLOOGKEY7wSjmDrN+xHJbyojwjDJNtly8H0kK2S
	 Py7Mw5kEEWqcULwtdKW051wfi2UI+wSmMQU1BV12WD+LwXrLu9QkgX8ayGiCq99AEz
	 NtBtUzaZlvIRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 bpf-next 3/6] libbpf: Add path_fd to struct
 bpf_link_create_opts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260610143627.804790-4-jolsa@kernel.org>
References: <20260610143627.804790-4-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 14:50:18 +0000
Message-Id: <20260610145019.7F4791F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Compilation fails due to missing `path_fd` in the `uprobe_multi` UA=
PI struct.
--

commit c73ec6f8d6c5a6bb4c8a75f70c333cac0d6d30d4
Author: Jiri Olsa <jolsa@kernel.org>

libbpf: Add path_fd to struct bpf_link_create_opts

This commit adds the path_fd field to struct bpf_link_create_opts for
uprobe_multi. It passes this new field through the kernel attribute interfa=
ce.

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
Will this assignment cause a build failure?

Looking at the UAPI header in tools/include/uapi/linux/bpf.h, the
uprobe_multi struct inside union bpf_attr doesn't appear to have a path_fd
member:

	struct {
		__aligned_u64	path;
		__aligned_u64	offsets;
		__aligned_u64	ref_ctr_offsets;
		__aligned_u64	cookies;
		__u32		cnt;
		__u32		flags;
		__u32		pid;
	} uprobe_multi;

Should the path_fd member be added to the UAPI bpf_attr union as well?

>  		if (!OPTS_ZEROED(opts, uprobe_multi))
>  			return libbpf_err(-EINVAL);
>  		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610143627.8047=
90-4-jolsa@kernel.org?part=3D1

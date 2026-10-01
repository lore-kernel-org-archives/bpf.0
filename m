Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3645D25B0B7
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 13:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862385; cv=none; b=rJHZNanqaQaHfN5ifI6SYrSHD1416bBLykXs6dtlxWxDSyzh2DUSeL+6aYQVwUM8CNiU7YdB4WKArgr5LHU64LT9OglmMvJvezsPjxs4RitckVAGpk5tX/739m2T8VcO4aG1Bvocj6/Tz84Xu60+vQLX2uO4ic3+Kb4t1K0wcWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862385; c=relaxed/simple;
	bh=Fov2Qo92bekFXSLeCx7F9zjciqrhOywc6RtWd7chAUk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tKVdBZ+EVjXiD+2A4wafOefAu2vxIipIS9zL+L0frMGjRxsbLTVKaTkx4IuHuDQpbOe3090FHmvnUEtmOsgESddPh6ymBRtlhb0kVxrHH5GxLXMMoh7WJZ5xxdtmJKkRH80ZWwEAs2GtpUh4Mt+88JA52ODnAWC+Gty8dQ88Acs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyVr5n5d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyVr5n5d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A071F000FF;
	Thu,  1 Oct 2026 13:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790862383;
	bh=T85QPSrsllnBLoUQ4XGR54+s76Z4bYv/bGI58eIqMHU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FyVr5n5de1/gv8GXsYXnSXMT8YBRndjSYPwvHcPDuW1pFMcKqJGZKSozwpCnBJtwd
	 OzGDGcgoYrBHqAnRbTddFHinytQSgxv6ih5dEAYZyvFAI4CmdwXXJfblLtzoYBNpwB
	 I269KK5tWW/moprEmoAZMQQ5vEFjVoHGBaXcmQEj1Y3Zb0WK+Br+QDjCkSZwBgwb0K
	 2HRICtje0kvxvCddZvYOlWQf4N+Csgqo3P1LwLAnoV9qOhXjO23JWTrYoTPRa2VGkh
	 ktIHf1Ks4BGxS314Xkq7d86iWKGyEinjTtnFsJqjd5l1TdG0Og2+qfKa6v/KYtX62a
	 sbEIDu7u2dG/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v8 15/22] libbpf: Add cleanup_info to
 bpf_prog_load_opts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261001133125.1344001-1-yonghong.song@linux.dev>
References: <20261001133006.1335369-1-yonghong.song@linux.dev>
 <20261001133125.1344001-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 13:46:23 +0000
Message-Id: <20261001134623.B9A071F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: ABI breakage due to reuse of padding in bpf_prog_load_opts
--

commit 71e2541e0b207ab646c97a6cfe861ce9bf16fe7f
Author: Yonghong Song <yonghong.song@linux.dev>

libbpf: Add cleanup_info to bpf_prog_load_opts

This commit introduces an exception cleanup table to the bpf_prog_load
options. It adds cleanup_info_cnt, cleanup_info, and cleanup_info_rec_size
to struct bpf_prog_load_opts and propagates them to the kernel in
bpf_prog_load.

> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index b49822d212aed..b4031f62bdee5 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
[ ... ]
> @@ -370,6 +370,10 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
>  	attr.fd_array =3D ptr_to_u64(OPTS_GET(opts, fd_array, NULL));
>  	attr.fd_array_cnt =3D OPTS_GET(opts, fd_array_cnt, 0);
> =20
> +	attr.cleanup_info =3D ptr_to_u64(OPTS_GET(opts, cleanup_info, NULL));
> +	attr.cleanup_info_rec_size =3D OPTS_GET(opts, cleanup_info_rec_size, 0);
> +	attr.cleanup_info_cnt =3D OPTS_GET(opts, cleanup_info_cnt, 0);
> +

[Severity: High]
Does this OPTS_GET macro read uninitialized padding from older applications?
When an application compiled against an older version of libbpf passes its
opts structure here, the sz field will be set to the old struct size.

If the old struct had padding at the end that the new structure replaces
with cleanup_info_cnt, OPTS_GET might think the field is present because
the sz value includes the padding, causing it to read stack garbage.

>  	if (log_level) {
>  		attr.log_buf =3D ptr_to_u64(log_buf);
>  		attr.log_size =3D log_size;
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 826d9cc9ab65d..cbe56ddc8cf7d 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
[ ... ]
> @@ -128,9 +128,14 @@ struct bpf_prog_load_opts {
> =20
>  	/* if set, provides the length of fd_array */
>  	__u32 fd_array_cnt;
> +
> +	/* exception cleanup table, from the .bpf_cleanup section */
> +	__u32 cleanup_info_cnt;

[Severity: High]
Does placing cleanup_info_cnt immediately after fd_array_cnt break the
size-based backward compatibility check?

Because fd_array_cnt is a 4-byte field, the struct bpf_prog_load_opts in
older applications likely contained a 4-byte padding hole at the end to
align with the 8-byte size_t type.

An older application would pass an opts structure where sz includes those 4
bytes of padding. Because OPTS_HAS evaluates if sz >=3D
offsetofend(struct bpf_prog_load_opts, cleanup_info_cnt), it will evaluate
to true. The library will then read the uninitialized padding left by the
older application as the cleanup_info_cnt value.

If the padding contains garbage, the kernel could reject the program load
or fail unexpectedly. Could this be resolved by placing cleanup_info_cnt
after the pointer, or by introducing explicit padding?

> +	const void *cleanup_info;
> +	__u32 cleanup_info_rec_size;
>  	size_t :0;
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001133006.1335=
369-1-yonghong.song@linux.dev?part=3D15

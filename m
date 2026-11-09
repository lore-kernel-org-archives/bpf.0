Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235000;
	b=jFCmHmWSHy9JPwdpjoPNooOkVkWs24XGheaHdq1UdIG3pZ0LG53X059irnao8QBbkyRI
	 VeErEwRQcKkKfuVr6eduq6q2E/MYQHb1tFQWlrcmX15w3UpttOPlJhT6+C0MfeH7vs/Nv
	 /dFLkvC/F9/El26/qN5OcBNTxHBiPZGEn+ixj4vqd+jibKQr477xTP08wghos8w+ZRHVb
	 MVg5/i+bt1nPA+kodKXOJzh1H1BGJ0MnsjxdY15YAZr0ErMC1zaO7ywHDhQYJxhwQluDa
	 5BMmcXrYviuQtc0H8X7C+qKe/e9hXdVDib2ZnwypVL8QvV3dZJnGRqUH2/yv5wZ90gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235000;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FR/WOVZDjfvPbuIiHzHtJHb0ozhdiY3qDT1t5Es/riA=;
	b=cmNYa5UafCgzy5RhxupDQ7P9CFHElBbHYRNHjdLkCYBF9h/3zKgK2bVExtZAk4zZzUqZ
	 SFKNylLbipZvscygLNO4/KHo/dbX+E3Xyw0MJPANtqfA4LC1/ZJnskyOaooGK/ZIGR1it
	 wglfklXVir9yLHVzXPtjfqpjcuS/uqiU8Ek50auscTrbbj+DnyVNRsu7f+6l6ZCdc1hKf
	 2kYtv+55xXx7FbJMIRAGeU3CdoqRcFbveqQpL8OoO/ivH1Ov86G9IwARar9vbkgRYvbUG
	 k2hADRfH0TVJ++O9iiK4wQX73suW8cCptTvxFGBWgBkNB0cyfpw/XZMXFwx8+Fc3Ylg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EppgOMT0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F04606A31C;
	Mon,  9 Nov 2026 14:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EppgOMT0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569B71F0089F;
	Mon,  9 Nov 2026 14:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794234999;
	bh=FR/WOVZDjfvPbuIiHzHtJHb0ozhdiY3qDT1t5Es/riA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EppgOMT0rAnePbGVmZVTvvAmUmyzwRlozb0aY9DysATH9Esmp7+aMH9rjHZBWoTwK
	 nmoTmNI/s2tZ8X6msepM4WxuuRWvoBlSobihI7UALFFWrbkEVAABGATlsHe0Al6nGP
	 URhMktchF/X+PLWwI7kdmHYIGscZFsghyEvbrQ8pJEL1AJy3NcY5Aq49zT0lFjBZ1E
	 SuI6in/cYT1Sslx+eoqaK0U72t8uZezEx/6S0LFT0iOtXxP3PqNg/CddIessxv/xgd
	 E9ugpO3z6ooeZ7Vlz85bGXbJk4NJ/NDOAJHdkNO+uq1ChtfgUFoWSEYhhIHfPdPPFn
	 g6CEo0kV9QZPA==
Message-ID: <sashiko-outbox-205120@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 5/9] libbpf: Add log_opts support for
 BPF_TRACE_ITER
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261109140816.5196-6-leon.hwang@linux.dev>
References: <20261109140816.5196-1-leon.hwang@linux.dev>
 <20261109140816.5196-6-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 14:36:38 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Low] libbpf: missing OPTS_ZEROED() check for BPF_TRACE_ITER in
  bpf_link_create()
- [Low] libbpf: unreachable iter.len check in bpf_link_create()
- [Low] libbpf: deprecated iter_info fields used in
  bpf_program__attach_iter()
--

commit 254d03820df80f0d29b270cec3be5cafe9178fe6
Author: Leon Hwang <leon.hwang@linux.dev>

libbpf: Add log_opts support for BPF_TRACE_ITER

This commit adds iter.info and iter.len to struct bpf_link_create_opts so
that BPF_TRACE_ITER link creation can pass iterator parameters alongside
log_opts, while keeping the legacy iter_info and iter_info_len fields for
callers that do not use log_opts.

> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 38dcb31e8c0ed..174a8bfaf6638 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -808,11 +808,6 @@ int bpf_link_create(int prog_fd, int target_fd,
>  	if (iter_info_len && attach_type !=3D BPF_TRACE_ITER)
>  		return libbpf_err(-EINVAL);
> =20
> -	if (iter_info_len)
> -		iter_info =3D OPTS_GET(opts, iter_info, (void *)0);
> -	else
> -		log_opts =3D OPTS_GET(opts, log_opts, (void *)0);
> -
>  	/* validate we don't have unexpected combinations of non-zero fields */
>  	if (iter_info_len || target_btf_id) {
>  		if (iter_info_len && target_btf_id)
> @@ -821,6 +816,16 @@ int bpf_link_create(int prog_fd, int target_fd,
>  			return libbpf_err(-EINVAL);
>  	}
> =20
> +	if (iter_info_len) {
> +		if (OPTS_GET(opts, iter.len, 0))
> +			return libbpf_err(-EINVAL);

[Severity: Low]
Can OPTS_GET(opts, iter.len, 0) ever be non-zero here?  When iter_info_len
is set, the preceding if (iter_info_len || target_btf_id) block has already
verified OPTS_ZEROED(opts, target_btf_id), which rejects any non-zero bytes
in the union following target_btf_id, including opts->iter.len.

> +		iter_info =3D OPTS_GET(opts, iter_info, (void *)0);
> +	} else {
> +		log_opts =3D OPTS_GET(opts, log_opts, (void *)0);
> +		iter_info =3D OPTS_GET(opts, iter.info, (void *)0);
> +		iter_info_len =3D OPTS_GET(opts, iter.len, 0);
> +	}

[Severity: Low]
Should bpf_program__attach_iter() also be updated to populate
link_create_opts.iter.info and link_create_opts.iter.len instead of the
deprecated iter_info and iter_info_len fields?

tools/lib/bpf/libbpf.c:bpf_program__attach_iter() {
    ...
	link_create_opts.iter_info =3D OPTS_GET(opts, link_info, (void *)0);
	link_create_opts.iter_info_len =3D OPTS_GET(opts, link_info_len, 0);
    ...
}

Because iter_info shares a union with log_opts, calling
bpf_program__attach_iter() with link_info !=3D NULL and link_info_len =3D=
=3D 0
causes bpf_link_create() to take the else branch above and dereference the
union bpf_iter_link_info pointer as struct bpf_log_opts *log_opts in
__sys_bpf_fd().

[ ... ]

> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index fe3b7fd8512bd..2ac143fd1102e 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h

[ ... ]

> @@ -478,6 +482,10 @@ struct bpf_link_create_opts {
>  			const __u64 *cookies;
>  			__u32 cnt;
>  		} tracing_multi;
> +		struct {
> +			union bpf_iter_link_info *info;
> +			__u32 len;
> +		} iter;
>  	};
>  	size_t :0;
>  };

[Severity: Low]
Does case BPF_TRACE_ITER in bpf_link_create() miss an OPTS_ZEROED(opts,
iter) check?

tools/lib/bpf/bpf.c:bpf_link_create() {
    ...
	switch (attach_type) {
	case BPF_TRACE_ITER:
		attr.link_create.iter_info =3D ptr_to_u64(iter_info);
		attr.link_create.iter_info_len =3D iter_info_len;
		break;
    ...
}

When opts->iter is used (so iter_info_len and target_btf_id are 0),
trailing bytes in the anonymous union after opts->iter overlapping larger
members such as uprobe_multi are not checked for zero, unlike all other
union members in the switch statement.  Also, opts->iter.info and
opts->iter.len are read in the !iter_info_len branch even when attach_type
is not BPF_TRACE_ITER.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109140816.5196=
-1-leon.hwang@linux.dev?part=3D5

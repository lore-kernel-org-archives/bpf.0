Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C325833B6F4
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 04:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789707442; cv=none; b=IzQnrWs4Y6OaYW/nLY0hbBUTxbqyXB5WaJ8RYpXU2tgd1CHex3vYxs/U3FoBCDv6q/cRDSantcjhnV95YRDpLWmV4GtPyt87rWUxlG6DJG8x2PHCq3GuAkVzPkPMRAOyQBXFgZNSfoGbQdZpKDsSDY5kXEF/aq46/ZM6VPV125c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789707442; c=relaxed/simple;
	bh=qsiZobY26Yh7hx67lo+zEDKEnuqRRMOIttp4lN2P0fk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jDpipImEgBxBHvzExPFE16j9JjL4CbG8QJGAi26ONJmBclu7l8NXG3MZ09vgXf17EvKHlo54JhjzXPFqUcEa369+6S2IiDQm9EMYbKuaRQWxyc34YWzEpZ4+4J/sfAkcFS6BJ4JW9sQCUdr7twQRjdZeB6mcB6+GmBv2K9iyjHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNItaVjW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNItaVjW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFA01F000FF;
	Fri, 18 Sep 2026 04:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789707441;
	bh=/BFYyj3Eh2sYdG+cX3EzK4U/1VJRv568INNJFNAszh4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VNItaVjW8BHEQK+Gj52FwUKw9JlZkGbEKJpE3oKNCgaDpQIRe3PlARGLwmFQy8g9i
	 t8CWMCGu/L2qXKpmWefJXsbx/xO8ZVCZj3wOzQnyBlS4MuuKvgPYtzu+l+4l3WSmhq
	 yaPSgPtgW1QfxmG84txjunvIMH2kUfCIpfnYHvd0VNgz5HmK05QihsL4ti/vEDA8L7
	 6VvI3sXiSQWFzlG+y4Fo/u0BlhNjlNK32pdTSBLdiUH24x/9m5EDZkMwKr5X+Mt8Ac
	 uW0dEfbZl7AWbNtBgXa2deU9z5zue0WJ9RiXgGW9F7Kl0pr4s0cd2dddmW+lJ0k429
	 O/7tkSvIouPqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 14/20] libbpf: Add cleanup_info to
 bpf_prog_load_opts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260918044311.3291504-1-yonghong.song@linux.dev>
References: <20260918044156.3283973-1-yonghong.song@linux.dev>
 <20260918044311.3291504-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 04:57:20 +0000
Message-Id: <20260918045721.2DFA01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] libbpf: missing E2BIG fallback for cleanup_info breaks forward c=
ompatibility
--

commit d67b69538e39a329708fcc9fa943f0ad05afaa05
Author: Yonghong Song <yonghong.song@linux.dev>

libbpf: Add cleanup_info to bpf_prog_load_opts

Let a caller hand the kernel an exception cleanup table. Extend struct
bpf_prog_load_opts with cleanup_info, cleanup_info_cnt and
cleanup_info_rec_size, pass them through to BPF_PROG_LOAD, and grow the
attr size bpf_prog_load() computes to cover the new fields.

> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 96819c082c772..bcf490570961c 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
[ ... ]
> @@ -370,6 +370,10 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
>  	attr.fd_array =3D ptr_to_u64(OPTS_GET(opts, fd_array, NULL));
>  	attr.fd_array_cnt =3D OPTS_GET(opts, fd_array_cnt, 0);
> =20
> +	attr.cleanup_info =3D ptr_to_u64(OPTS_GET(opts, cleanup_info, NULL));
> +	attr.cleanup_info_cnt =3D OPTS_GET(opts, cleanup_info_cnt, 0);
> +	attr.cleanup_info_rec_size =3D OPTS_GET(opts, cleanup_info_rec_size, 0);

[Severity: Medium]
Will this break forward compatibility for bpf_prog_load() if cleanup_info
triggers an -E2BIG error?

Later in bpf_prog_load(), there is a retry loop to handle -E2BIG when the
userspace-provided record size is larger than what the kernel supports:

	while (errno =3D=3D E2BIG && (!finfo || !linfo)) {
		if (!finfo && attr.func_info_cnt &&
		    attr.func_info_rec_size < func_info_rec_size) {
            /* try with corrected func info records */
            ...

The loop condition and body don't seem to include checks for cleanup_info.

If the kernel returns -E2BIG because of a larger cleanup_info_rec_size,
won't this hit the else { break; } block or skip the loop entirely, causing
the load to fail instead of retrying with truncated records?

> +
>  	if (log_level) {
>  		attr.log_buf =3D ptr_to_u64(log_buf);
>  		attr.log_size =3D log_size;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918044156.3283=
973-1-yonghong.song@linux.dev?part=3D14

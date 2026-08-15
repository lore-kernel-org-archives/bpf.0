Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DA633F37A
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 08:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786782740; cv=none; b=aSRrfQRBvz7/tquZ+s3YtO1bP5Km8+9J+tWHCfUNqRSvyYpxSuA7M8mxf5lMPTOJJRd56SSTKLco9mX+d0wVR8dc1l8LN1W53XpI5GP12mF7w6rK2GpR4t4rMh0idM81a86LKGMyzTIh1ZdHPSSOn1sTL6ZvEQRjULBOIh5o/K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786782740; c=relaxed/simple;
	bh=+ys8D4YvLMtk5wOP0KSmCkH4Wm6X5nDKPrfYhcONKPI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K6PIap9cZ6mk5g8uQEo/qQiRaU2LbngQquOCcc8gEjRMphm7DkmkC8lcEYxF9tyeiayimgJz3GySAoYWeKBH34msiAe721uU2WkStsMtavVYtZvCnW1MOJoQwByi4cPkftGf86K2BsKHNeLiB23hZUWOgfR/gBwgP+QZn+SNtso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEP1xdbw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEP1xdbw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD911F000E9;
	Sat, 15 Aug 2026 08:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786782739;
	bh=Ds/rr3GFWQXyDBtQERaW3DgLDf5e4qHCJjx7QGbum+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CEP1xdbwAD2gbVbozQACMJm1X6vM29Vy3NBpNKP9Stm+pDysFERXA2hIWpOqWiR6+
	 ZwfRkqvLN4L56ArIXkaLvAmpkwImuAn0NekawaMFz2yGwEGBaT5CbFNBeEDZAdWiTJ
	 3rqEJ1Mou7jRkZStlNYCENVUNWdkd+Hh/tCV6rz4UlIp3iGMvanpm46+uL1xXOWAF2
	 /bv44DkQft2+jIKUoFPnab6pbGlpkembZfzM99jMUrmgaPRZd9LZriH4IpdH5ynEe6
	 gN+Vl97/rtASPsWVTgBYfXd6dWpbtkh8pv17m1NxQziXc49o1Bv/C0YjXxFK3ZBTcd
	 +nw8CsJAAQZ/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 2/5] bpf: fix stream capacity leak in
 staging path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jianlin Shi" <shijianlin11@foxmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <tencent_B9A612466A5F8D64DA61B448344B570F5905@qq.com>
References: <tencent_C919BB32458A4DAD645A68F441345B971E05@qq.com>
 <20260815081920.609936-1-shijianlin11@foxmail.com>
 <tencent_B9A612466A5F8D64DA61B448344B570F5905@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 08:32:18 +0000
Message-Id: <20260815083218.ECD911F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbounded memory growth caused by pushing zero-length strings, whi=
ch completely bypasses the BPF stream capacity limits.
- [Medium] bpf_stream_vprintk() fails to cap the return value of bstr_print=
f(), causing valid truncated logs to be entirely dropped (returning -ENOMEM=
) and improperly injecting NUL bytes when lengths match the buffer size.
--

--- Patch [2]: [PATCH bpf-next v3 2/5] bpf: fix stream capacity leak in sta=
ging path ---
commit c8e97cb1d20310041c929271dc5ec88dac514fc8
Author: Jianlin Shi <shijianlin11@foxmail.com>
bpf: fix stream capacity leak in staging path

This patch fixes a capacity leak in the staging path of BPF streams by
accounting for the string length only after a successful push. It also
updates the string formatting to use vscnprintf(), correctly capping the
staged length to the truncated payload instead of the theoretical format
length.

> diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
> index 0b157ec4e38eb..ef5a7b06ffcb1 100644
> --- a/kernel/bpf/stream.c
> +++ b/kernel/bpf/stream.c
> @@ -316,17 +316,19 @@ int bpf_stream_stage_printk(struct bpf_stream_stage=
 *ss, const char *fmt, ...)
>  {
>  	struct bpf_bprintf_buffers *buf;
>  	va_list args;
> -	int ret;
> +	int len, ret;
> =20
>  	if (bpf_try_get_buffers(&buf))
>  		return -EBUSY;
> =20
>  	va_start(args, fmt);
> -	ret =3D vsnprintf(buf->buf, ARRAY_SIZE(buf->buf), fmt, args);
> +	/* Cap to the written length, excluding the trailing NUL. */
> +	len =3D vscnprintf(buf->buf, ARRAY_SIZE(buf->buf), fmt, args);
>  	va_end(args);

[Severity: Medium]
This isn't a bug introduced by this patch, but since you are fixing the
length truncation here, I noticed a similar issue in bpf_stream_vprintk()
with bstr_printf():

kernel/bpf/stream.c:bpf_stream_vprintk() {
	...
	ret =3D bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt__str, data.bin_args);
	/* Exclude NULL byte during push. */
	ret =3D bpf_stream_push_str(stream, data.buf, ret);
	...
}

Does bstr_printf() return the theoretical untruncated string length, similar
to vsnprintf()? If the string is truncated, couldn't this attempt to push
out-of-bounds capacity or inject NUL bytes into the stream since the return
value is not capped?

> -	ss->len +=3D ret;
>  	/* Exclude NULL byte during push. */
> -	ret =3D __bpf_stream_push_str(&ss->log, buf->buf, ret);
> +	ret =3D __bpf_stream_push_str(&ss->log, buf->buf, len);
> +	if (!ret)
> +		ss->len +=3D len;
>  	bpf_put_buffers();
>  	return ret;
>  }

[Severity: High]
This is a pre-existing issue, but I noticed a potential unbounded memory
growth when pushing zero-length strings.

Looking at bpf_stream_consume_capacity() and __bpf_stream_push_str():

kernel/bpf/stream.c:bpf_stream_consume_capacity() {
	...
	if (atomic_add_return(len, &stream->capacity) >=3D BPF_STREAM_MAX_CAPACITY=
) {
	...
}

kernel/bpf/stream.c:__bpf_stream_push_str() {
	...
	elem =3D bpf_stream_elem_alloc(len);
	if (!elem)
		return -ENOMEM;
	...
}

kernel/bpf/stream.c:bpf_stream_elem_alloc() {
	...
	alloc_size =3D offsetof(struct bpf_stream_elem, str[len]);
	elem =3D kmalloc_nolock(alloc_size, __GFP_ZERO, -1);
	...
}

If a BPF program repeatedly calls bpf_stream_stage_printk() or
bpf_stream_vprintk() with an empty string format (len =3D 0),
bpf_stream_consume_capacity() will add 0 to the capacity tracker, bypassing
the BPF_STREAM_MAX_CAPACITY limit entirely.

Meanwhile, __bpf_stream_push_str() still allocates structural memory for the
log element via kmalloc_nolock() even when length is 0.

Could this allow a BPF program to bypass the stream capacity limits and
continuously deplete kernel memory by flooding the log with zero-length
strings?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815081920.6099=
36-1-shijianlin11@foxmail.com?part=3D2

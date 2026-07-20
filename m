Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2452C21F1
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 05:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784525197; cv=none; b=lxDEJTTdLRstFZqmHq+aHznUK/7GH03NaXwcGEOSB5WcJZ/p/VPue0xzXGcuKawCNpL1ztcTEGGfGcrLH0VsxibX7bawV3FgDJTGILCX1G81XJfl4HWkNIi8nGMmZCl2xiaNOue4DMyP3kgJh45gThz9xrcWfnGUqL12QhyfmWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784525197; c=relaxed/simple;
	bh=BHfrF6KHIxF4uC9GWLtnRHG8uodkt9GoOHUixAuzgVs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kUUe+R9Moq6zU70FEIddXbHcbK4ORA66x2TIOj9RWXI0d0TwffWqFhTT27LaGPqS8C/8oU2uAUznPaEZMqo+NvYZ+QwwjARyzVgDXi06S2uYuxBjelP7t+Zz+nh9A5tsKafaB61/B0NgVkiUdNCTVhEJxR+xujoE/ZtRMVkiaAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dd0KPihC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dd0KPihC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE55B1F000E9;
	Mon, 20 Jul 2026 05:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784525195;
	bh=6ggyYqDj4VWwomak7JFWA0TBtr/Y27R8m0Ytc+mDH5o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dd0KPihCk1KkaS7aV2pKEEztkJ0+54fC08RcH4GbAi6haJWcgunjMmy3cM7X3O8fB
	 03EizCP6ZF5AdaY2JUuT0nmU1YPEdTlROdGa4xu8W8pMKayraHCwG9sb15OvK+uCSk
	 vLIomT27eLRk1H8tOih3FToXdBGpJOamOb/4c8CK3vUFNesBOCcdtfYlYQY4My8OYd
	 I3RzTzsSylAbLyVpuF0/7dy0JpXiZyfCvaF9kauGvN20DR9hH3fhsFX/HRKYSbCZx0
	 Uv70VRqAWqBWZetL1QL86J9TDGZ0YMNhriKcW7YbuQeM1tlE0boUeVDsdyOz3Ng+zy
	 eqCwDSoUJ0vfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2] bpf: roll back stream capacity when
 allocation fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jianlin Shi" <shijianlin11@foxmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <tencent_C919BB32458A4DAD645A68F441345B971E05@qq.com>
References: <tencent_E69EAE29327E25B3548A9AF3F4FA289A6806@qq.com>
 <tencent_C919BB32458A4DAD645A68F441345B971E05@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 05:26:35 +0000
Message-Id: <20260720052635.BE55B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fixes a capacity leak in `bpf_stream_push_str()` when st=
ream element allocation fails, but misses an identical leak in `bpf_stream_=
stage_printk()`.
- [High] `bpf_stream_read` drops successfully read data if a subsequent `co=
py_to_user` fails, violating API contracts.
- [Medium] Log messages are entirely dropped and return an error instead of=
 pushing the truncated message when the formatted output exceeds the intern=
al string buffer size.
--

--- Patch [1]: [PATCH bpf-next v2] bpf: roll back stream capacity when allo=
cation fails ---
commit 3fa8598d2b8afa51091cf463bee21d3c9f140975
Author: Jianlin Shi <shijianlin11@foxmail.com>

bpf: roll back stream capacity when allocation fails

bpf_stream_push_str() accounts the string length before allocating a
stream element. If the allocation fails, the length remains charged even
though no element is queued and therefore cannot be released by a reader.
Repeated failures can exhaust the stream capacity permanently until the
BPF program is freed.

Roll back the capacity charge when creating the stream element fails.

> diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
> index be9ce98e94692..4b8a74b9162e1 100644
> --- a/kernel/bpf/stream.c
> +++ b/kernel/bpf/stream.c
> @@ -79,7 +79,14 @@ static int bpf_stream_push_str(struct bpf_stream *stre=
am, const char *str, int l
>  {
>  	int ret =3D bpf_stream_consume_capacity(stream, len);
> =20
> -	return ret ?: __bpf_stream_push_str(&stream->log, str, len);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D __bpf_stream_push_str(&stream->log, str, len);
> +	if (ret)
> +		atomic_sub(len, &stream->capacity);
> +
> +	return ret;
>  }

[Severity: High]
This is a pre-existing issue, but does bpf_stream_stage_printk() suffer from
the identical capacity leak that this patch fixes here?

Looking at bpf_stream_stage_printk():

kernel/bpf/stream.c:bpf_stream_stage_printk() {
    ...
	ss->len +=3D ret;
	/* Exclude NULL byte during push. */
	ret =3D __bpf_stream_push_str(&ss->log, buf->buf, ret);
    ...
}

If __bpf_stream_push_str() fails to allocate memory, ss->len remains increm=
ented.
Later, bpf_stream_stage_commit() unconditionally consumes this erroneously
inflated ss->len from the stream capacity:

kernel/bpf/stream.c:bpf_stream_stage_commit() {
    ...
	ret =3D bpf_stream_consume_capacity(stream, ss->len);
	if (ret)
		return ret;
    ...
}

Since the failed element isn't in the log, its length will never be release=
d,
which could permanently leak stream capacity over time.

[Severity: Medium]
This is a pre-existing issue, but what happens if the formatted output exce=
eds
the internal string buffer size?

Both bstr_printf() and vsnprintf() return the number of characters that wou=
ld
have been written, not the actual number written.

For example, in bpf_stream_vprintk():

kernel/bpf/stream.c:bpf_stream_vprintk() {
    ...
	ret =3D bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt__str, data.bin_args);
	/* Exclude NULL byte during push. */
	ret =3D bpf_stream_push_str(stream, data.buf, ret);
    ...
}

If the string is truncated, the un-capped return value is passed as len to
bpf_stream_push_str(). Since bpf_stream_elem_alloc() has a strict bounds ch=
eck,
it will reject the allocation and return -ENOMEM.

Does this mean the entire log message is dropped instead of safely pushing =
the
truncated message prefix?

[Severity: High]
This is a pre-existing issue, but does bpf_stream_read() permanently drop d=
ata
if a subsequent copy_to_user() fails?

In bpf_stream_read():

kernel/bpf/stream.c:bpf_stream_read() {
    ...
		/* Restore in case of error. */
		if (ret) {
			ret =3D -EFAULT;
			elem->consumed_len =3D cons_len;
			break;
		}
    ...
	return ret ? ret : len - rem_len;
}

If copy_to_user() fails on a subsequent element in the loop, it breaks and
unconditionally returns -EFAULT.

Since elements that were successfully read in previous iterations have alre=
ady
been popped and freed, returning an error instead of the number of successf=
ully
read bytes hides the fact that partial data was consumed.=20

Will retrying the read operation cause the previously read data to be
permanently lost?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_C919BB32458=
A4DAD645A68F441345B971E05@qq.com?part=3D1

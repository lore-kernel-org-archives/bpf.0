Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FE530F958
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 08:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786782735; cv=none; b=mqw/Jxct8HxVvtAh2aBGygBBXjwRZ/Y9iHniLg6ArGRGuSm3MlFKrHq6X8FeDUcIpKHh+y8bqFwfZyJ3Yj7gg/W8F5Rt/jMugvkzRIRMsjVbDm3A9IEMAEdOUL+0/liAYbcB6b09H0P5guaQIHJD/RvuRaP5dJlHfpdazFMXNq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786782735; c=relaxed/simple;
	bh=ZZqMr9uIqBFCFYO1gsTFw6HcsUihp+l6dg5cCDFtDoM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NrScDThEDI6p8wWUg0d4xGcnWZDpqak043VVoddQ5oWLtiGGAHqKy6AJaL0OqgGdSi/nn27jekOQBxnHNxV1zCfGIi6YozEPY8i4EJbHkHqttcnEveVgqGcbvkdFJ9cJ+9YbKnfjZEPl69GBdhGboIq0OWfMmwWPKpnqTv0WCFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZOMRqk+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZOMRqk+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C1A1F00A3A;
	Sat, 15 Aug 2026 08:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786782733;
	bh=6304U613YeY/QsCs4eTRL8IijZIvPiOjnXGWxD8ww3o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oZOMRqk+JCKEWctERRYP8RKsBShNqMqhAk/D1P6pHp9KkkyOgEgpaDPfpWJLURron
	 kGlcXgZWlUrH8aIxb5mse4D3IIvv8JvPbh/9r9/sT8Md+7ruHWYUvfAm8ugvaR6sdn
	 LyoCeFoAe9q557Pz7cDUBHhBVolOhhy2y8AOpJECQ3vPJ0G2SzQLEUcrig4Qx074k5
	 WJYhsDXnC3NW4/VI9eB/rTtO4AHOUWapIlaQyMZqp+13ts/x9g5ByaZgHT9WHvTzk0
	 /fSC0mmqQHGj5HQ791msIJuq4Anaf8HIltactRW9lywaqPDPcRttRUi5bPBvJNwYwi
	 qWQXh4v7W+i5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 1/5] bpf: roll back stream capacity when
 allocation fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jianlin Shi" <shijianlin11@foxmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <tencent_6B540E4B95A9AD4DBF8C928942E95A23AB0A@qq.com>
References: <tencent_C919BB32458A4DAD645A68F441345B971E05@qq.com>
 <20260815081920.609936-1-shijianlin11@foxmail.com>
 <tencent_6B540E4B95A9AD4DBF8C928942E95A23AB0A@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 08:32:12 +0000
Message-Id: <20260815083213.54C1A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch addresses a stream capacity leak in `bpf_stream_push_str=
()` when element allocation fails, but leaves an identical leak in the stre=
am staging API (`bpf_stream_stage_printk`).
- [Medium] Unbounded return values from `vsnprintf()` and `bstr_printf()` a=
re passed directly to stream push operations, leading to inadvertently drop=
ped messages and aborted stack traces.
--

--- Patch [1]: [PATCH bpf-next v3 1/5] bpf: roll back stream capacity when =
allocation fails ---
commit 057b94c20f902b9cfbc6a855c11361e82913b675
Author: Jianlin Shi <shijianlin11@foxmail.com>

bpf: roll back stream capacity when allocation fails

bpf_stream_push_str() accounts the string length before allocating a
stream element. If the allocation fails, the length remains charged even
though no element is queued and therefore cannot be released by a reader.
Repeated failures can exhaust the stream capacity permanently until the
BPF program is freed.

> diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
> index be9ce98e94692..0b157ec4e38eb 100644
> --- a/kernel/bpf/stream.c
> +++ b/kernel/bpf/stream.c

[ ... ]

> @@ -79,7 +77,14 @@ static int bpf_stream_push_str(struct bpf_stream *stre=
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
> +		bpf_stream_release_capacity(stream, len);
> +
> +	return ret;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but since you are fixing the
capacity leak here, does the stream staging API have an identical leak?

Looking at bpf_stream_stage_printk() in kernel/bpf/stream.c:

    ss->len +=3D ret;
    /* Exclude NULL byte during push. */
    ret =3D __bpf_stream_push_str(&ss->log, buf->buf, ret);

Here ss->len is unconditionally incremented even if __bpf_stream_push_str()
fails. Later, bpf_stream_stage_commit() consumes this inflated ss->len
from the capacity:

    ret =3D bpf_stream_consume_capacity(stream, ss->len);

Because the failed element is never added to the stream queue, it will
never be popped by a reader, which permanently leaks the capacity. Should
this be rolled back similarly?

[Severity: Medium]
This is also a pre-existing issue, but while reviewing the length handling,
could the unbounded return values from vsnprintf() and bstr_printf() cause
dropped messages?

In bpf_stream_vprintk():

    ret =3D bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt__str, data.bin_args);
    /* Exclude NULL byte during push. */
    ret =3D bpf_stream_push_str(stream, data.buf, ret);

And similarly in bpf_stream_stage_printk():

    ret =3D vsnprintf(buf->buf, ARRAY_SIZE(buf->buf), fmt, args);
    ...
    ret =3D __bpf_stream_push_str(&ss->log, buf->buf, ret);

Both vsnprintf() and bstr_printf() return the unbounded number of
characters that would have been written, even if truncated. If this length
exceeds MAX_BPRINTF_BUF (1024 bytes), passing it as the length to
bpf_stream_push_str() or __bpf_stream_push_str() will cause
bpf_stream_elem_alloc() to return NULL.

Instead of pushing the successfully truncated string, the entire message
is dropped. Furthermore, in bpf_stream_stage_dump_stack(), this -ENOMEM
return causes the arch_bpf_stack_walk to prematurely abort. Should the
length be capped before being passed to the push functions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815081920.6099=
36-1-shijianlin11@foxmail.com?part=3D1

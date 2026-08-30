Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9737A34DCE4
	for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 09:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788083228; cv=none; b=gNNe0VnyktBrcdPoJQjfAaA7NeACStxrT6i4DzOWeTqrdBcklSYX2zcz88SHXI+SFTFB+Cv0LVSmFyz9CSlBPiFUQMDwEHY9iXpNIppkiNgZf5CHnG3VgTRTi0BSfKsAESwBtRVfkMIuQMo/GZl8+/WKQXiocxTRKyKnCo+Q8UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788083228; c=relaxed/simple;
	bh=0MpRxnrYO+aPZQ8nWFgGZH5t7kOhxbCgYmBeENfQCVo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=diUDItGDMqzLxNufCdgJfy5H5YaW+oZxC6IB2jvPtZv1+JcvIIhbuiR/nflx/qfzLKRag8t6bWhz3IYoB+IKCqd2Mc8hcW+utnhCcBFKxEGZ3f65TWbanuBU8VEn28D5pNION9ymPyPrjB6TqrJcV1KeHmMS8bMIniPl9GsO7M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4bnf8zT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4bnf8zT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2651E1F000E9;
	Sun, 30 Aug 2026 09:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788083227;
	bh=uKeskgGjc6uOTD1sQbG6nyizr0ywAHDdjMC1jD7l5Pk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f4bnf8zTq/wSysksPBmTKTXJjHnQ/iYJqGSFtXncR72SHd4DkRzGluGpPgukoy8xi
	 11UJhWZzkXKayRnXcI0YjnofPWCVYX+bc00GK89Gw+r2hOTvYW2s6lO+G5h5qF/5ci
	 Fv7cc7g4YBOdoQaJdq80QM+ejGMihJC35Xc/AVwVOhLwcKothUDXMq+O3Izg3uio/X
	 EyEBIq05tQbXqRbS+wzCdNkEwqOl3AUh6/ipntn77YEAfRlnxV0+MAKQUu/P6+y5YN
	 Ie944rWk/cvXahyVR8LuHGQ7bQqrTI8W+luIuIa//RzKrST2fw3dqOGysKbDe07+f5
	 3JzrPpN5p9T5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 1/6] bpf: Add file descriptor interface for
 program streams
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260830093514.4105972-2-memxor@gmail.com>
References: <20260830093514.4105972-1-memxor@gmail.com>
 <20260830093514.4105972-2-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 09:47:06 +0000
Message-Id: <20260830094707.2651E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Race condition in bpf_stream_file_read() leading to premature EO=
F and data loss.
--

commit 15d530fc84e28348bbaf5fc7ae04276f6622bc6f
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Sun Aug 30 09:35:06 2026 +0000

bpf: Add file descriptor interface for program streams

This commit adds a BPF_PROG_STREAM_OPEN command to return a read-only file
descriptor for a selected program stream. It supports blocking and
non-blocking reads, as well as polling, and handles program teardown by
marking the stream dead and waking up descriptor users.

> diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
> index 2b80a0599865e..d3dbb1aca792f 100644
> --- a/kernel/bpf/stream.c
> +++ b/kernel/bpf/stream.c
[ ... ]
> @@ -215,6 +220,102 @@ int bpf_prog_stream_read(struct bpf_prog *prog, enu=
m bpf_stream_id stream_id, vo
>  	return bpf_stream_read(stream, buf, len);
>  }
> =20
[ ... ]
> +static ssize_t bpf_stream_file_read(struct file *file, char __user *buf,=
 size_t len,
> +				    loff_t *ppos)
> +{
> +	struct bpf_stream *stream =3D file->private_data;
> +	int ret;
> +
> +	if (len > INT_MAX)
> +		return -EINVAL;
> +	if (!len)
> +		return 0;
> +
> +	for (;;) {
> +		ret =3D bpf_stream_read(stream, buf, len);
> +		if (ret)
> +			return ret;
> +		if (READ_ONCE(stream->dead))
> +			return 0;

[Severity: Medium]
Does this code have a race condition that could lead to premature EOF and
missing the final stream events?

If a reader thread gets preempted right after bpf_stream_read() returns 0,
but before checking the stream->dead flag, it leaves a small race window.
Concurrently, a BPF program could emit new data and then be immediately
destroyed, which marks the stream as dead.

When the reader thread resumes, it will see READ_ONCE(stream->dead) as true
and return 0 (EOF) immediately. Would this cause the reader to completely
miss the newly published data that was emitted just before the teardown?

> +		if (file->f_flags & O_NONBLOCK)
> +			return -EAGAIN;
> +
> +		ret =3D wait_event_interruptible(stream->waitq,
> +					       bpf_stream_has_data(stream) ||
> +					       READ_ONCE(stream->dead));
> +		if (ret)
> +			return ret;
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830093514.4105=
972-1-memxor@gmail.com?part=3D1

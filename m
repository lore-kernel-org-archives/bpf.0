Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D66403B02
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 05:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790313325; cv=none; b=g2sDvDCHGz34uVtR6ZrqLKlywwMnfBt2EImIGC1fj4kYfAts/KvmcXrOK3hD2Pu+bU4CTxepMnUDqK/takMn4YTjSvPsUu/VGkM5eYvQH+YBit4QYPrUC5v2yVufXybNdrt+uu7eARJLDmZOM9zGpAoEj2/FFXiyoeyNIIaWuKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790313325; c=relaxed/simple;
	bh=W81+hjCdv3qvZ2jwTl0KWTZ+UF44Zts2zqll153kS7I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qnVhITKNFyK6KvyT6+TQbDUG6l6+M/qttUFDsh+wkW5dxJiH+2AEnU8Joj/7JuzUd2mObgHmmRhMcs++04+e6KSeizPDp8Av9p2B5dwxiq7/MatlRQuC8BVEF1jv1pvdbhbx9VXzBhw1paCe4QGZlUrTH+FWBscCbHrqz4S95rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGjjZQSu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGjjZQSu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8D41F000FF;
	Fri, 25 Sep 2026 05:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790313321;
	bh=/rq8hE1iWepGPqqPYtQrt/4KCe7JrylOpWLH1OdEL5E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JGjjZQSuyqgP8XKnWayK7n1liYo/Os5TfYaXjnapW0R9JiZ6fzeDFTQC9/egQ1Qam
	 6iAheUGICVmvFBJwqeZs8morJwIT4YPVMfOJgXNNTXB+G+PMyl145IsSRQ4Y3WFB0H
	 AiOuVQ0pvPrOu8Wi70n1tzv+tZ3HPR9cagbSsc43KD0CixVSeiKGVla5BElWmrVe/A
	 sFG0x6PvIrxKCAL02eUuyLEm0VrIf7atyw7RdSjtfRM4M4NXTQi+BzanCz/W95f41o
	 dUGiS0jc4Ee8+ora/7h4MIY90JEwlIFsB6mgL19k5ng4YjiuFnCwdN6OZGnWg0Gu0B
	 apzjDyzkAuvEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 4/5] bpftool: Add option to wait for program
 stream output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260925045536.1480933-5-memxor@gmail.com>
References: <20260925045536.1480933-1-memxor@gmail.com>
 <20260925045536.1480933-5-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 05:15:21 +0000
Message-Id: <20260925051521.7D8D41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: bpftool deadlock in exit_stream signal handler
--

commit 482ed48b5d6910c6aec52e854a7926f6f16ce58a
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpftool: Add option to wait for program stream output

bpftool prog tracelog { stdout | stderr } PROG dumps the output buffered
in a program stream and exits, which is all BPF_PROG_STREAM_READ_BY_FD
allows. Waiting for further output means rerunning the command.

> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index 24e40dfab4690..5e27b22444f25 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -1119,21 +1119,66 @@ enum prog_tracelog_mode {
>  	TRACE_STDERR,
>  };
> =20
> +static void exit_stream(int signo)
> +{
> +	exit(0);
> +}
> +

[Severity: Medium]
Since exit_stream() is used as a signal handler for SIGINT, SIGHUP, and
SIGTERM, is it safe to call exit(0) here?

exit() is not async-signal-safe and attempts to flush open stdio streams.
If the signal interrupts the main loop in prog_tracelog_stream() while it
is executing fwrite() or fflush(), it could try to acquire the same
non-reentrant lock, resulting in a deadlock.

Could _exit(0) be used instead to avoid this deadlock?

[ ... ]

> +	/*
> +	 * Exit from the handler like the trace pipe variant does. A flag check=
ed
> +	 * between reads would miss a signal that lands before read() blocks and
> +	 * only end the loop at the next print.
> +	 */
> +	for (i =3D 0; i < ARRAY_SIZE(signals); i++)
> +		sigaction(signals[i], &act, NULL);
> +	while ((ret =3D read(fd, buf, sizeof(buf))) > 0) {
> +		fwrite(buf, sizeof(buf[0]), ret, file);
> +		fflush(file);
> +	}
> +	if (ret < 0)
> +		p_err("failed to read stream: %s", strerror(errno));
> +	close(fd);
> +out:
>  	fflush(file);
>  	return ret ? -1 : 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925045536.1480=
933-1-memxor@gmail.com?part=3D4

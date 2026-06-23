Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B161B1F3B85
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782225507; cv=none; b=Dp9sD81x1s3a8ORWiUQlIuOvRXpcO+ZLnuh1VlaO5OmQSU2DUwqSRksTtmNdZeiDo1eGcbbudiuE+GQJhNMbSiieOZ9SE5v7b+FAsK4Q9zCMYXfN5Pi02H7IMHqrmdQ2OawE8rsowpcP/TQplPm5KTkHNtMY6RGXDIEfKaKRkKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782225507; c=relaxed/simple;
	bh=JixWKG5hMVqnbOVUvjkIdNhhEuV8yU/XT6SQBVk9vDI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C0tQ1gRr07WWrRVsRfDO6cFdj6YYUvpnrmy9qrTnTx8CZBD3O8YB9oDohmEQnZbGF/OWsp3x1TNodbEx1W5rSVd3WE4d7IxBF8s40ntw1ihl+4OJuIVG9cQqoun7OKrB3H0dA379JAIu7XEFmqbMAj+R7zTzMBi0/Y5sfsTR4xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odHo5esB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odHo5esB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336821F000E9;
	Tue, 23 Jun 2026 14:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782225506;
	bh=+csNI7uZjeO7dJhmov/zQRf0TAeXmm1Ln5+6v+x5/SE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=odHo5esB9LDAgYhsbfBnD+rHbdlaaTm3uBx52Cb938jMt6OkQtDDYQsclUoQ23O73
	 vwcs+OKRU1y2K5ulRoXtr0S9AQX+MCrgqbPE2X0OR2t9/bBL6p4dAb/RzvKlVcHqiT
	 N4cC3AH6H826Njq4mA75/ohYdYR1JQk0iAsyCnCHEHOaE5W/tml9L2ChYKSjyGPrvf
	 f2acAKOin3aWoabQ5tcWzWUF6B93wY6m8YQc324EDa4EgZnDpOj5P66ezYodq/1Lhi
	 OA8lBFvJXMIKaSmFZohSrRnYKUxqHMy3SjgL4zsZtGL9DfNQOrDIoxaF5B7vPVpOJE
	 OJkE2UNgk0lAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 bpf-next 3/3] bpftool: Add tracing_multi link info
 output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260623142417.275892-4-jolsa@kernel.org>
References: <20260623142417.275892-1-jolsa@kernel.org>
 <20260623142417.275892-4-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 14:38:25 +0000
Message-Id: <20260623143826.336821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The patch references non-existent `tracing_multi` fields in `str=
uct bpf_link_info` causing a build failure, and the corresponding kernel `.=
fill_link_info` callback is missing.
- [Medium] Dynamically allocated memory for `ids`, `addrs`, and `cookies` a=
rrays is leaked if the subsequent `bpf_link_get_info_by_fd()` call fails.
--

commit 1c150871ddc705d0719c83498c9983e353211882
Author: Jiri Olsa <jolsa@kernel.org>

bpftool: Add tracing_multi link info output

This patch adds support to bpftool to display tracing_multi link details.
It updates both the JSON and plain text output formats to show attached
functions, addresses, and cookies.

> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index bdcd717b0348f..db780ee398206 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
[ ... ]
> @@ -1114,6 +1217,39 @@ static int do_show_link(int fd)
>  			goto again;
>  		}
>  	}
> +	if (info.type =3D=3D BPF_LINK_TYPE_TRACING_MULTI &&
> +	    !info.tracing_multi.ids) {

[Severity: Medium]
Will this break the build? It appears the tracing_multi struct is missing
from the bpf_link_info union in include/uapi/linux/bpf.h.

Also, it seems the kernel side might be missing the .fill_link_info
callback in bpf_tracing_multi_link_lops (in kernel/trace/bpf_trace.c)
to export this data to userspace.

> +		count =3D info.tracing_multi.count;
> +		if (count) {
> +			ids =3D calloc(count, sizeof(__u32));
> +			if (!ids) {
> +				p_err("mem alloc failed");
> +				close(fd);
> +				return -ENOMEM;
> +			}
> +			info.tracing_multi.ids =3D ptr_to_u64(ids);
> +
> +			addrs =3D calloc(count, sizeof(__u64));
> +			if (!addrs) {
> +				p_err("mem alloc failed");
> +				free(ids);
> +				close(fd);
> +				return -ENOMEM;
> +			}
> +			info.tracing_multi.addrs =3D ptr_to_u64(addrs);
> +
> +			cookies =3D calloc(count, sizeof(__u64));
> +			if (!cookies) {
> +				p_err("mem alloc failed");
> +				free(addrs);
> +				free(ids);
> +				close(fd);
> +				return -ENOMEM;
> +			}
> +			info.tracing_multi.cookies =3D ptr_to_u64(cookies);
> +			goto again;

[Severity: Medium]
If the execution jumps to again: and the subsequent call to
bpf_link_get_info_by_fd() fails, does this leak the memory allocated
for ids, addrs, and cookies?

Looking at the error path earlier in do_show_link():

again:
	err =3D bpf_link_get_info_by_fd(fd, &info, &len);
	if (err) {
		p_err("can't get link info: %s",
		      strerror(errno));
		close(fd);
		return err;
	}

It returns immediately without freeing these arrays if the second
syscall fails (e.g., due to a concurrent increase in function count
or link destruction).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623142417.2758=
92-4-jolsa@kernel.org?part=3D1

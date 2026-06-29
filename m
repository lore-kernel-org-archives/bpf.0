Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9762A3BBFCC
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744832; cv=none; b=D1xXXh1QQyzUvyOJKqxDZ/0mZwK8uEpxTMotaKdZE9N5r6uzmyP4WiBq67u6vUPsf7AIX+xKkzHVq9lfg9aLSIUQ9GC1SBF/wVAmozuzCeEOdNOqpM7xbesZkKBc7QF2cG1Zhn2YhegG8t3MsPsSb0zl6n8tNfv1l7mp5WoKJ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744832; c=relaxed/simple;
	bh=Uci/oW4VVPrIxlQHar7U9IfyzGXQ+1zSsgOiEAf2dPY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jVJLagF3QOvDdaUlndObyZ2wakWo+OgboKEHC5O8yUxmYWlWbtwcxv+DBF/5RpygZ0CmsbDa1xeBts8FbWsC7hUZ1DpPzJsEj/yixyJXYFUfjPiOPkLPpMUyWwVzQTsPJ8KVaYLhCi0Kj2wCX3SOW87s5ne9c8qW+EPwMwaKfbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRwX1bdv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRwX1bdv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E241F00A3A;
	Mon, 29 Jun 2026 14:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782744830;
	bh=wJgPppV0dYG6zxSuuilj1tLiSASQ9PJXtJcjfAI1NV0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oRwX1bdv8DfdXCSkOnm5TmBpmpH25mAyCjf3dgMvPPpS9Z5CX/7CBkPXuIg1zqqmX
	 JJ1G5inSXuQKSAtrehRjh0/j8FpryDtzH3qbRWNqzb7VlwnYxC70AURZCnSj3Qv91Q
	 /KOjO9cQRX2ZdTRodO0SQi+An0hYKbpomItsB7YfHREy2iDYi3rzUPVXwMRW4XTWTe
	 3vT4Zj0AgWcw58F9qKPEo0i3kyEiK1nNLglUI4Qz471US5iMfdaIxI9tRKSbbREpQM
	 r245wECnySzoFy0o2jWJ7fiDZRpdn0la4WR4F8K5HHnnacqjdjEZL3rrhAxJNV8V25
	 MUlrG4ijt1Kaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 bpf-next 3/3] bpftool: Add tracing_multi link info
 output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260629143844.862369-4-jolsa@kernel.org>
References: <20260629143844.862369-1-jolsa@kernel.org>
 <20260629143844.862369-4-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 14:53:49 +0000
Message-Id: <20260629145349.F3E241F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The kernel does not implement `.fill_link_info` for `tracing_mul=
ti` links, preventing `bpftool` from querying the data.
- [Low] The patch references `tracing_multi` in `struct bpf_link_info`, but=
 this member is missing from the UAPI header, leading to a compilation erro=
r.
--

commit e1b00f15ceb03dae490ba9269f47251c966b9424
Author: Jiri Olsa <jolsa@kernel.org>
bpftool: Add tracing_multi link info output

This commit adds support to bpftool to show tracing_multi link details
such as attach type, btf_id, address, cookie, and function module.

> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index bdcd717b0348f..eb0ba9d716924 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c

[ ... ]

> @@ -1114,6 +1226,26 @@ static int do_show_link(int fd)
>  			goto again;
>  		}
>  	}
> +	if (info.type =3D=3D BPF_LINK_TYPE_TRACING_MULTI && !info.tracing_multi=
.ids) {

[Severity: Low]
The patch references tracing_multi in struct bpf_link_info here, but looking
at include/uapi/linux/bpf.h, there doesn't seem to be a tracing_multi member
defined in the union. Will this cause a compilation error when building bpf=
tool?

[Severity: Medium]
Additionally, it appears the kernel-side bpf_tracing_multi_link_lops in
kernel/trace/bpf_trace.c does not yet implement a .fill_link_info callback.
Without that callback, will bpf_link_get_info_by_fd() fail to populate the
requested tracing_multi arrays (ids, addrs, cookies) for the tool to displa=
y,
even after the UAPI is updated?

> +		count =3D info.tracing_multi.count;
> +		if (count) {
> +			ids =3D calloc(count, sizeof(__u32));
> +			addrs =3D calloc(count, sizeof(__u64));
> +			cookies =3D calloc(count, sizeof(__u64));
> +			if (!ids) {
> +				p_err("mem alloc failed");
> +				close(fd);
> +				free(cookies);
> +				free(addrs);
> +				free(ids);
> +				return -ENOMEM;
> +			}
> +			info.tracing_multi.ids =3D ptr_to_u64(ids);
> +			info.tracing_multi.addrs =3D ptr_to_u64(addrs);
> +			info.tracing_multi.cookies =3D ptr_to_u64(cookies);
> +			goto again;
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629143844.8623=
69-4-jolsa@kernel.org?part=3D1

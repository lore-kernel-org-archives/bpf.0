Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F0633E7;
	Wed,  4 Mar 2026 23:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772665345; cv=none; b=sCxT2P1fNiL0rqMpv3EX7JjVYFLlq4HfMicr/KR7Tp04rGExdapFwsqaEeQsXjDxMRo1PN9D2yJiq4fcrr1LPypwpoGOj24TPhzlUtS1AWQ/JXXMdrS/gfYIcTylhYsobVKxpAFPU1kCinZyPu75WAinU5cfwx1tcxZacV2f27Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772665345; c=relaxed/simple;
	bh=u1NfSY35by47P0/YCqMrT0lJkr2PeQpLUpsYKv1KQd4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=reu8YeEjX6jlnKhXnAXOG6XyvID1i4mce6XZrTfzzIgWjYan4oLV0JOqDMggZXHkD/6XqzfNO85Nfm8uWY1fHmgsYH+oQF3o7RgHZwYKFmnHE1QKh7dy2cvxwhG2gepu38Vq6gxrPM6llS7elNBipBntrcCcl/R9MRMLox9JqRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3QRoeCQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3QRoeCQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1565FC4CEF7;
	Wed,  4 Mar 2026 23:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772665345;
	bh=u1NfSY35by47P0/YCqMrT0lJkr2PeQpLUpsYKv1KQd4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=B3QRoeCQWBCtiptBHMG5oEmGNsULw2ORW11Ux2CahcXbqN2EcOAh7sIrxXzG4RdJg
	 QgWwNEO+2KZmuCN/q+kE/IIbTz+dNyR3NGhEdtzy/Ie6Wd4cygyqCQUszE7/bOrf+Q
	 vIljaEYL64V2B4aM10vHTbzSsuNXlHC1NdNbwcsKpINqcK2vytAURdDxVznnrAavBr
	 w1fjHmVkrPfPCS10Y3wkl30PC4EklHFAnFffvxEQgJ5IJV+l0gjLnxr3vJYIwygVRS
	 D95re1TmAgakE7Pbth3LYqKapbdxD2OEMBoNHL6nWenVfO200/MLcB2lbARiUBwR+G
	 3NEKcO4P2n6tQ==
Content-Type: multipart/mixed; boundary="===============0981801880176658555=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <625b9bd61d08db7a0cdff51817fe64752c1901d360d73455b609516a0b611d3d@mail.kernel.org>
In-Reply-To: <20260304222141.497203-16-jolsa@kernel.org>
References: <20260304222141.497203-16-jolsa@kernel.org>
Subject: Re: [PATCHv2 bpf-next 15/23] libbpf: Add support to create tracing multi link
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  4 Mar 2026 23:02:25 +0000 (UTC)

--===============0981801880176658555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> The provided <pattern> is used as 'pattern' argument in
> bpf_program__attach_kprobe_multi_opts function.

The function referenced here should be
bpf_program__attach_tracing_multi, not
bpf_program__attach_kprobe_multi_opts. This was noted in v1
review.

> - bpf_program__attach_kprobe_multi_opts must either have
>   pattern with module spec or BTF ids from the module

Same here, should be bpf_program__attach_tracing_multi.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> +struct bpf_link *
> +bpf_program__attach_tracing_multi(const struct bpf_program *prog, const char *pattern,
> +				  const struct bpf_tracing_multi_opts *opts)
> +{
> +	LIBBPF_OPTS(bpf_link_create_opts, lopts);
> +	__u32 *ids, *free_ids = NULL;
> +	__u64 *cookies;
> +	int prog_fd, link_fd, err, cnt;
> +	struct bpf_link *link;
> +
> +	cnt = OPTS_GET(opts, cnt, 0);
> +	ids = OPTS_GET(opts, ids, NULL);
> +	cookies = OPTS_GET(opts, cookies, NULL);

Should this function validate opts with OPTS_VALID() before
calling OPTS_GET()? The comparable
bpf_program__attach_kprobe_multi_opts() does:

    if (!OPTS_VALID(opts, bpf_kprobe_multi_opts))
        return libbpf_err_ptr(-EINVAL);

Without OPTS_VALID(), a caller passing opts with sz=0 would have
ids, cookies and cnt silently ignored rather than getting -EINVAL
back.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22692622038
--===============0981801880176658555==--

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0847733E7;
	Wed,  4 Mar 2026 23:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772665344; cv=none; b=A634Ls14drTUexrZpce5tlmE3oXN/RHQOliMiDi5tGohTDuQTot+DXqn2f6bknrLxc4yiIBkFeZbzOV2m+GcDCzz/kaOohH4mypbkoIZrMZaLVEVQ6KnUJSrReP4QC2pNB9ih08KFf7Yb3V96fsByTWGLa5dCJ8FcSrCk0uP9WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772665344; c=relaxed/simple;
	bh=14w0H0D4IOL8C58C3D5YJEOdb4HSBovzHbsYWC0iLL4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Hmjg3RawwdaAX6AsdDnN58GAtemxDUkSphnnwUsgdjtpuRX+6IyyqDBvS0Q2O3ZgqfYPo5VlMBK/4ObeqZ34vy1FHH7X/2Pt8k2YW4InuCL3w7a90x71PiR8HH67JzZrsScYWMV+FOJA5RedRuXrUXE7ulogGZHS3yw2c1t+9Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsIYMIj2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsIYMIj2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D0DC4CEF7;
	Wed,  4 Mar 2026 23:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772665343;
	bh=14w0H0D4IOL8C58C3D5YJEOdb4HSBovzHbsYWC0iLL4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=UsIYMIj2bu5zJVXrvQF6+0gY3sQwYIqLQOBuctPFTJmcoxWl7v83KFWKIzbYlKjzg
	 H2szivDI0B+ugh4eFHJDDCg0WoZjPusE16di65n/lTk4/w6GzE1E0vHbyl/qm3Mo9W
	 51kS2EzU39mkk5R/tEiqo0KdkvA5ZMX228nYaBKDLKndnjwC0EixhFMd8VTxB/qtax
	 4sHkRq++3y0p7bMhugtzZpH7HIK/IBsXnsbciugKXSxDto+g5SpWhyJWvXRd2rXO5O
	 Qt3cigIY/wMgoI3jBqP9d4hH/MlfAxeAxiNJyetqja8zevudPm4wkULc26Vsu5Odo8
	 kKDCtJiUlFJRQ==
Content-Type: multipart/mixed; boundary="===============4579780349641946905=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ac763f388094863ef5c4d3a60d5606ea40406f66c91006fc9dd0e47573154a72@mail.kernel.org>
In-Reply-To: <20260304222141.497203-15-jolsa@kernel.org>
References: <20260304222141.497203-15-jolsa@kernel.org>
Subject: Re: [PATCHv2 bpf-next 14/23] libbpf: Add bpf_link_create support for tracing_multi link
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  4 Mar 2026 23:02:23 +0000 (UTC)

--===============4579780349641946905==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c

[ ... ]

> +	case BPF_TRACE_FENTRY_MULTI:
> +	case BPF_TRACE_FEXIT_MULTI:
> +	case BPF_TRACE_FSESSION_MULTI:
> +		attr.link_create.tracing_multi.ids = (__u64) OPTS_GET(opts, tracing_multi.ids, 0);
> +		attr.link_create.tracing_multi.cookies = (__u64) OPTS_GET(opts, tracing_multi.cookies, 0);

Should these use ptr_to_u64() instead of a raw (__u64) cast?
The ids and cookies fields are pointers (__u32 * and __u64 *
respectively), and every other pointer-to-u64 conversion in
bpf_link_create() goes through ptr_to_u64():

    attr.link_create.kprobe_multi.syms = ptr_to_u64(OPTS_GET(...));
    attr.link_create.kprobe_multi.addrs = ptr_to_u64(OPTS_GET(...));
    attr.link_create.uprobe_multi.path = ptr_to_u64(OPTS_GET(...));

The ptr_to_u64() helper casts through (unsigned long) first,
which avoids implementation-defined behavior and compiler
warnings on 32-bit builds.

> +		attr.link_create.tracing_multi.cnt = OPTS_GET(opts, tracing_multi.cnt, 0);
> +		if (!OPTS_ZEROED(opts, tracing_multi))
> +			return libbpf_err(-EINVAL);
> +		break;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22692622038
--===============4579780349641946905==--

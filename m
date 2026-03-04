Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C492376489;
	Wed,  4 Mar 2026 23:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772665350; cv=none; b=G1HL5Dr+IzTvAAlCxaKe80SyaFONYJy5rzKXyLyHppoWWRMqtkNq2UMOat12TCLaaHTrZUp4AnhT1+3nUyOxA8a1COb2FmhkrxH0F1S7tz6zlTE0+Q9VT7VniI4CC0mZzDrjSx3MAn/J1XbIMD73Av821WKf6MhFiDtuvYBi4AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772665350; c=relaxed/simple;
	bh=0TcF/RsjyyQPPtNdhqAImFiYcmb7mVI8Sfuc2SbOvrw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=dWQMYeVPGYernY53YizoGlEsItHcDNuN2AdK8w0kPnnHCijIL4fgCe/yrB2PG2qEcR71CAD4l8uwHE0C1bhNgQENXyC3yxhvbg+YRk+lJ4Q6ZJknWqen6h5WilBzEm5Xl3SYm8BZLQRFFBsFNgSQnXeEMulSsC8l/qVr4Scr5e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcrZXueU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcrZXueU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D2FC4CEF7;
	Wed,  4 Mar 2026 23:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772665350;
	bh=0TcF/RsjyyQPPtNdhqAImFiYcmb7mVI8Sfuc2SbOvrw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ZcrZXueUaHAI9MLvWIuSIXjIEtMCzVgfgvHg4tGeWpEl+sZWOWpo7oEG9rNphyB+O
	 0NTi+0TUDLq+aTkB9qezwgDqkGh8S2VEIYwNn1Qe4O6RQHRD+aM/jhpF8tpkpBW2Ri
	 4310UMfFjNqKGBpn0rv/jdU2Yq0+skdLWbzbeGbHTvr3GgQCc/cgGA+IrexKMB6apf
	 wAsXwMKrlnQmkQcEvlAXVml6NXFxP8ZLl2X66RqmYi1vGqZqaVgUpFoxS0fU4j+oO1
	 9Y//h/iwxwcEwoZLQFUNVstbQpXi13ZN1i1raACiOpmTbOvbeBdFvhdWwppSdTO87J
	 PsGPUweCfmTMQ==
Content-Type: multipart/mixed; boundary="===============0637284388219767298=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e0a34750677c3cfbc461c9653f39b1d8388c1e3ca8a95e918e380e61999adf51@mail.kernel.org>
In-Reply-To: <20260304222141.497203-10-jolsa@kernel.org>
References: <20260304222141.497203-10-jolsa@kernel.org>
Subject: Re: [PATCHv2 bpf-next 09/23] bpf: Add support for tracing multi link
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  4 Mar 2026 23:02:30 +0000 (UTC)

--===============0637284388219767298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c

[ ... ]

> +int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
> +{
> +	struct bpf_tracing_multi_link *link = NULL;
> +	struct bpf_link_primer link_primer;
> +	u32 cnt, *ids = NULL;
> +	u32 __user *uids;
> +	int err;
> +
> +	uids = u64_to_user_ptr(attr->link_create.tracing_multi.ids);
> +	cnt = attr->link_create.tracing_multi.cnt;
> +
> +	if (!cnt || !uids)
> +		return -EINVAL;

Should attr->link_create.flags be validated here as well?

Both bpf_kprobe_multi_link_attach() and bpf_uprobe_multi_link_attach()
reject non-zero flags:

kernel/trace/bpf_trace.c:bpf_kprobe_multi_link_attach() {
    ...
    if (attr->link_create.flags)
        return -EINVAL;
    ...
}

Without this check, userspace passing flags != 0 will be silently
accepted, which would prevent using the flags field for future
extensions since old kernels could not be distinguished from new
ones.

> +	if (cnt > MAX_TRACING_MULTI_CNT)
> +		return -E2BIG;

[ ... ]

> +#else
> +
> +int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS) && CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS */

Minor: there is a stray ')' after CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
in this comment.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22692622038
--===============0637284388219767298==--

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37A9320CD3
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 23:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773272454; cv=none; b=qJNfGYDQUaTahHuf+8KhsbQHNFHg3+j/bpJeVhjAQ2KT8eCeaOkN+wtYIE0/4BqXHE0WQnnsqn4Vn+ReZoHHnfy2w/IPWQRQgOjKR7vquy97Jw19KZYLvO7zipWIHMGNAFoDcDYc/JzhgU+u+Npq06dlBpXmQ1uaLbEmWPn6W+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773272454; c=relaxed/simple;
	bh=uuD6bF4q52efV5P0zLnNBT2udPLOiyMEku4lzBHT5I4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ItIENOfD8yOYOJUR11kFNYn5Qx1hYymBWh2wMnNGymDXLhtqB/UcapOTOCxaP7DofTOMB9HvVoRaVgtyhF8eyTbjTrH47gO1LSUXtTxA4tlnk46E47nsj8d4b61OofiCpGCoCbvzFZwr4RVYVEhyBH/BPOnSeg5kSMdehwgh+KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=db+QdiVE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="db+QdiVE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F022AC4CEF7;
	Wed, 11 Mar 2026 23:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773272454;
	bh=uuD6bF4q52efV5P0zLnNBT2udPLOiyMEku4lzBHT5I4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=db+QdiVEinTHfdiuVcd9fuCgPX1bu3pW3pBMFW9nQtz5fuUHq/3PPZvZIyaFetaNE
	 +ZHjtZAzEBFK+airOgZ6xsj109AXVi2dBt8/WH4HlFtbbmraW7j5fAHSLvazn4TVFt
	 XbzRZF8/fCdKlgKUoNq326rHyk8nxUdwT9UDluk+ERgHou18LQuyUhXMQbPlmW63qc
	 K9sipcH0/m7rMhTvP0uoytddvMP2IUc++xR/3HtKaQBsStIN3bwFUtvByiHg2prlOZ
	 NHAwx7RctfrSQFr81RYkoBc8A/g6e5kN7+ckCkBlbP4uKPJggY43inKm0xH//i1U1j
	 YHEw9/0r51SBw==
From: Puranjay Mohan <puranjay@kernel.org>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>
Subject: Re: [PATCH bpf-next v3 3/4] libbpf: Add tp_btf.s section handler
 for sleepable raw tracepoints
In-Reply-To: <20260311-sleepable_tracepoints-v3-3-3e9bbde5bd22@meta.com>
References: <20260311-sleepable_tracepoints-v3-0-3e9bbde5bd22@meta.com>
 <20260311-sleepable_tracepoints-v3-3-3e9bbde5bd22@meta.com>
Date: Wed, 11 Mar 2026 23:40:49 +0000
Message-ID: <m2eclqj5oe.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> writes:

> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add SEC_DEF for "tp_btf.s+" section prefix, enabling userspace BPF
> programs to use SEC("tp_btf.s/<tracepoint>") to load sleepable raw
> tracepoint programs. This follows the existing pattern used for
> fentry.s, fexit.s, fmod_ret.s, and lsm.s section definitions.
>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

Acked-by: Puranjay Mohan <puranjay@kernel.org>

> ---
>  tools/lib/bpf/libbpf.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0662d72bad20..7b65869f5c8e 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9863,6 +9863,7 @@ static const struct bpf_sec_def section_defs[] = {
>  	SEC_DEF("raw_tracepoint.w+",	RAW_TRACEPOINT_WRITABLE, 0, SEC_NONE, attach_raw_tp),
>  	SEC_DEF("raw_tp.w+",		RAW_TRACEPOINT_WRITABLE, 0, SEC_NONE, attach_raw_tp),
>  	SEC_DEF("tp_btf+",		TRACING, BPF_TRACE_RAW_TP, SEC_ATTACH_BTF, attach_trace),
> +	SEC_DEF("tp_btf.s+",		TRACING, BPF_TRACE_RAW_TP, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
>  	SEC_DEF("fentry+",		TRACING, BPF_TRACE_FENTRY, SEC_ATTACH_BTF, attach_trace),
>  	SEC_DEF("fmod_ret+",		TRACING, BPF_MODIFY_RETURN, SEC_ATTACH_BTF, attach_trace),
>  	SEC_DEF("fexit+",		TRACING, BPF_TRACE_FEXIT, SEC_ATTACH_BTF, attach_trace),
>
> -- 
> 2.52.0

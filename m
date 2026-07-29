Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FA01DDC07
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 09:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785318125; cv=none; b=CX9+LWCT+16/jKpnIfhBjOKTUh91qAs0UiKmjtkS8W2y3YVcFTbb8RVRuRjDhLMh4E7jv/pqR2+HdqE09z1viK4KfkXeKf0DwZhdXAcafMMO6masvAPHTnUkQXIGFYWEYjSniFmh3BuQhQBbd60QaeszgRYc+C0+N77LqM6XmfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785318125; c=relaxed/simple;
	bh=J/fDNQQuFco6MdxTguqqdquvp+Q2RzUjnsVUmPCMshA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uswL8yqDeW6+x2VNvBD8yBbVuqKfnmf0tD3teqF3ZtiaoXj8hlcyMCW2eI2u/RAF994xmNH38/CMRl0NRIkDE//NOM3oTa6k5gwmFlmn4NI61/TgnlhGFY3R7cehi7HnEpdW3UdixYts28Tkb0lhkOTCWWMp3CU+doanhWfEauo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgsFOdVv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgsFOdVv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E5B1F00A3A;
	Wed, 29 Jul 2026 09:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785318122;
	bh=+IzggYMJe1yBUHdmRhgMvkLPgXqmAA/k3KzU7AMA5Bg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=OgsFOdVvJSxPUVt+0dUTQZH37pwsWte8TDXyh5N/pblWqhpKbQhmBM3mbhqbLpC+q
	 +SMs9ooCg3u31BvH8LN2CkmyVMLZE5yFj9en4XIlXrPAxQioQQxhJHKrcYS1q822t+
	 DDOEG4r5lAXsyzY9mdjc8/tUo+TfK/D9t1KvDjawQnFzBoaYXrpz09CYTkT56u1pBW
	 bwKX/miDvbg6Qg25CRxDdd3N+sXTQrOr8himMlSr36TU69aEVX/o12ixRbucc9N0XY
	 B1uiIMj/uMsvTSinOEiUupKsebjJl7NBhcRN6A0z++KRX8RJYXaRIq/kQS4M+EY/u9
	 D81d6XXudEKpA==
Content-Type: multipart/mixed; boundary="===============2784815537815203087=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dd41555c6d2b250898a2b307d853d956f00aca31b6deb021ab72dc4e3c05f940@mail.kernel.org>
In-Reply-To: <20260729083807.1588544-5-jolsa@kernel.org>
References: <20260729083807.1588544-5-jolsa@kernel.org>
Subject: Re: [PATCHv2 bpf-next 04/11] bpf: Use stack id functions instead of __bpf_get_stackid
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,qmo@kernel.org,chen.dylane@linux.dev,info@starlabs.sg,contact@arnaud-lcm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 29 Jul 2026 09:42:01 +0000 (UTC)

--===============2784815537815203087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 366195b08c79a..43b1e5436047d 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c

[ ... ]

> @@ -674,6 +675,7 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
>  	   struct bpf_map *, map, u64, flags)
>  {
>  	struct perf_event *event = ctx->event;
> +	struct stack_map_bucket *new_bucket;
>  	struct perf_callchain_entry *trace;
>  	struct stackid stackid;
>  	bool kernel, user;
> @@ -701,7 +703,6 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
>
>  	if (kernel) {
>  		trace->nr = nr_kernel;
> -		ret = __bpf_get_stackid(&stackid, map, trace, flags);
>  	} else { /* user */
>  		u64 skip = flags & BPF_F_SKIP_FIELD_MASK;
>
> @@ -710,12 +711,22 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
>  			return -EFAULT;
>
>  		flags = (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
> -		ret = __bpf_get_stackid(&stackid, map, trace, flags);
>  	}
>
> +	ret = stackid_fastpath(&stackid, map, trace, flags);
> +	if (ret != -ENOENT)
> +		goto error;
> +
> +	new_bucket = stackid_new_bucket(&stackid, map);
> +	if (new_bucket) {
> +		trace->nr = nr;
> +		return stackid_install(&stackid, map, new_bucket, flags);
> +	}
> +	ret = -ENOMEM;
> +
> +error:
>  	/* restore nr */
>  	trace->nr = nr;
> -
>  	return ret;
>  }

This isn't a bug, but since the goto error label is reached when
stackid_fastpath() succeeds and returns a valid stack id, would out: read
better here?  The next patch in the series uses out: for the same pattern
in bpf_get_stackid().

Also, stackid_install() doesn't look at trace, so could the trace->nr = nr
restoration be done in just one place?  Right now it appears both inside
the if (new_bucket) branch and under the label.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30437558115
--===============2784815537815203087==--

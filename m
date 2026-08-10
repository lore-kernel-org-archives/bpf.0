Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BEB39CCFE;
	Mon, 10 Aug 2026 07:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786346180; cv=none; b=AzkCWqFMpvQMwTyoXClVyMgxKAVpLCXPHCDHJcpuLn9vVky7wyFnRRUomvGU7HgHTm0eAAGwvg0sqa4XQX4e/xaAbDJci9mi+rNADSzWWkoTEHsPvg3HnY1MzqTrA1nQrQlB0/SxWEhvwWjLthECacYToDrKxB8IZCZliYkDbw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786346180; c=relaxed/simple;
	bh=5UKj23PCMwcGL2wgibD9zmtEFzkWBqAcfirW25jeNzg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Mgp2y5zPnWhaqP5uaUTy8Nb00fe4u8+aekBnkafmZUtvK5CnFYk3APezhI2vu8HiQoIJ2IhVHkc64cjpmd9SSjMqWEJvGVUOBWoUgZgjQIh5rJf6vJ1dCaF+3uXkNF3DL08ofEYVjJPmkfCkeD+YX3AKoi9VFrcpt8Ma4rLonVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXM+YfxJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXM+YfxJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0F41F000E9;
	Mon, 10 Aug 2026 07:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786346178;
	bh=XGZS6zaoK1gd47CROOedFj3B+qCf/afPSXRtLfXYh/Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nXM+YfxJHP/vCrf6lJPDteSiVPILv4R1aVjjAgIQFZ4tve4jRpCzNnU3XClA2A8sK
	 0s3svjKleSwhbXg4ZCKSLE3uS3IEGH/RgPKOvagVVOuD8f14kr3d7+IPAEDLStiIEe
	 sMNs39U9AAfSxR+0aQHRi0czgTxOGUfJcviQl917j7siDQCzmitb4qfOYqRWjyrkNN
	 14AkmmLrVo9DRZrc5X7n66wCFtig8MMUkYJ8c9TgpaorG9qcRgbBVm9l4MR3ZVhMsI
	 toE7zC77vaPIcR4DZGXWFQsQW/2t6hiaDrO4vLPBHPTKqiGEXJPHfjeANJMfBTE5V+
	 9T0OKBf8SEcrg==
Content-Type: multipart/mixed; boundary="===============5113020057206339078=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f4de541e7b23a1990f50389f83010b2d70ff4d97a3cd408d18f89c5cd22492c9@mail.kernel.org>
In-Reply-To: <20260810061329.224276-1-hui.zhu@linux.dev>
References: <20260810061329.224276-1-hui.zhu@linux.dev>
Subject: Re: [PATCH v4] bpf: Fix UAF in bpf_trampoline_multi_attach_free on update failure
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,kpsingh@kernel.org,matt@bobrowski.net,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org
Cc: zhuhui@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 10 Aug 2026 07:16:17 +0000 (UTC)

--===============5113020057206339078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index b4a10c9878cf..f4e8d372253a 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1518,8 +1518,8 @@ int arch_prepare_bpf_dispatcher(void *image, void *buf, s64 *funcs, int num_func
>
>  int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
>  				struct bpf_tracing_multi_link *link);
> -int bpf_trampoline_multi_detach(struct bpf_prog *prog,
> -				struct bpf_tracing_multi_link *link);
> +void bpf_trampoline_multi_detach(struct bpf_prog *prog,
> +				 struct bpf_tracing_multi_link *link);

[ ... ]

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index e07af35ed040..90b70ea0d370 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c

[ ... ]

> @@ -1756,7 +1766,8 @@ int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
>  	return err;
>  }
>
> -int bpf_trampoline_multi_detach(struct bpf_prog *prog, struct bpf_tracing_multi_link *link)
> +void bpf_trampoline_multi_detach(struct bpf_prog *prog,
> +				 struct bpf_tracing_multi_link *link)

[ ... ]

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 891897f8a1b3..29260951aa87 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3687,7 +3687,7 @@ static void bpf_tracing_multi_link_release(struct bpf_link *link)
>  	struct bpf_tracing_multi_link *tr_link =
>  		container_of(link, struct bpf_tracing_multi_link, link);
>
> -	WARN_ON_ONCE(bpf_trampoline_multi_detach(link->prog, tr_link));
> +	bpf_trampoline_multi_detach(link->prog, tr_link);
>  }

This isn't a bug, but would it be worth splitting the return-type
change into its own patch?

The int-to-void conversion of bpf_trampoline_multi_detach() touches
both bpf.h prototypes, the definition and the bpf_trace.c call site,
but is independent of the old_image lifetime fix that the Fixes: tag
refers to.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31362089875
--===============5113020057206339078==--

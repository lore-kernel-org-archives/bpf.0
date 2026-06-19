Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCEC3624D3
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 21:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781905615; cv=none; b=i2xA40nJIGQcPlUhHrK4c1bf5hmkqMC1E62nNoYddSMFyPWXx4qp8qhcmLV28afTSScx3/4BkIWUOP2wXUJuOB9kF4Sz6SEhFs1GRwCItYrCeAX1jRgDzT62PaeXdWb7SgCNZoTCDcuepagoN1TwLRMoxtKfn9qPPoJgpK649b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781905615; c=relaxed/simple;
	bh=oBJAoNoXkHS5pF/bjAp9R4CuspA17auJbjYi00/vgIE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=W8s8UDrZwCLBdgkXxevsPDGyX/ggJsNODRCjGciR7bnZ9GWazjU8DArhQVjbJGs2GebHpOROGbHaNAb5uPjG5B4em0QjX3pViPQRer0Q9C7/dPax2HZgUipp462TG66YGD/agywnF35X7ZARzDcuLI9t8e4ATbdLbK2X/l4FcMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObUQpoES; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObUQpoES"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730801F000E9;
	Fri, 19 Jun 2026 21:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781905614;
	bh=TwzHMpTIIHUUiUTUUU6U8yvupheF8yvD+8ktQpnlj9g=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ObUQpoESYwUKbx8zJD9zgN94tMbee4S6dZMxoH43ZMqJaTzDUQivNIPLvzYYyElA5
	 thfWCVXy8jhkrEjO4gSmwJ+HDQhkKXlzlnbAIjCRZcNqR0Kj+b7W0EcYPEJNWslJQR
	 Y8N9NqqVmwx8pQ1q0lsinpPcgDv75B/vMt0p3XfwWQd90SPgZQebxnZUqmfJXGbKxD
	 3JJbCZxRMltHX6ZJmq0GMU9kctCTGai99qpirkXfkMTp73zIoPeR36r90+u2zm+/eN
	 b8D3iQOLXR4PDb0HNsdsrvBFTasi8bU/m5PCKr0U1f5dDINEqlgaC39vyCMcb+fLwP
	 90sNz0UZghfMw==
Content-Type: multipart/mixed; boundary="===============2108751603862916422=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <baea52b2aa37a163def1f125dfebcfb8bf8896f914cc0cf6946093f5fa35ed60@mail.kernel.org>
In-Reply-To: <20260619205934.1312876-3-memxor@gmail.com>
References: <20260619205934.1312876-3-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 02/17] bpf: Add source and instruction diagnostic context
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 19 Jun 2026 21:46:54 +0000 (UTC)

--===============2108751603862916422==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 15ae7c43f594..6f08bf383c11 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -8255,6 +8255,17 @@ int btf_type_snprintf_show(const struct btf *btf, u32 type_id, void *obj,
>  	return ssnprintf.len;
>  }
>
> +int btf_type_snprintf_show_name(const struct btf *btf, u32 type_id,
> +				char *buf, int len)
> +{
> +	struct btf_show show = {
> +		.btf = btf,
> +		.state.type_id = type_id,
> +	};
> +
> +	return snprintf(buf, len, "%s", btf_show_name(&show));
> +}

btf_type_snprintf_show_name() is added here and declared globally in
include/linux/btf.h, but I cannot find any caller in the tree, and a
forward search over the rest of the series did not turn up one either.

Is btf_type_snprintf_show_name() consumed somewhere later in the series,
or is it added ahead of a caller that did not land?

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index a18fd5aa395d..534a7bc58781 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c

[ ... ]

> @@ -38,7 +177,6 @@ static void bpf_diag_log(struct bpf_verifier_env *env, const char *fmt, ...)
>  	bpf_verifier_vlog(&env->log, fmt, args);
>  	va_end(args);
>  }
> -
>  static void bpf_diag_print_wrapped_prefixed(struct bpf_verifier_env *env,

This isn't a bug, but this drops the blank line between the end of
bpf_diag_log() and the following function, so the two now abut with no
separator unlike the other function pairs in the file.  Was that
intentional, or could the blank line be kept to match the surrounding
functions?

> @@ -103,6 +241,287 @@ static void bpf_diag_vprint_indented(struct bpf_verifier_env *env,
>  	kfree(buf);
>  }
>
> +static int bpf_diag_line_width(unsigned int line)
> +{
> +	int width = 1;
> +
> +	while (line >= 10) {
> +		line /= 10;
> +		width++;
> +	}
> +
> +	return width;
> +}

This isn't a bug, but bpf_diag_line_width() is a hand-rolled base-10
digit counter.  There is already an int_log.h:intlog10() that does this;
could that be used here instead?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27848712882
--===============2108751603862916422==--

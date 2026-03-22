Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADCB36826D;
	Sun, 22 Mar 2026 02:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774145665; cv=none; b=mhnwXzJmIUDqDMS5ilC+qJLjejBlF4dPnqcRJHCGwaXESP15XNAL+udH06V5hZvE1yTXo8NjhfGMfPtNWr9LDQyObs8Be+AwjH+6EMYvFdJHUQZU4Wr0vVfe5Ap76Gjm48F1HwO0uKSGOPBYro8c9xZ8SFzQ0R6+hbcCFMZrahU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774145665; c=relaxed/simple;
	bh=15LtSrMbO+4zppNOiphuTaqoBsJ8Br+hPF1Xrky7JBo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=MUndEbNSFySxxoLoDUf/AO5OYt2YRbupEb/M8EYVyA/jgAz1HS24rsD5ZYP9W8tbnmwk4QpCfzVVOEBAMF3P2J+8y/ZBImBwsfiaIM5quq1szYFjTpcPf6TK0N9fxHzIeumci22MEBAHtBRaMBGMUm7NFmk6e7FX8CwyHQmOJh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LL2s7ggs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LL2s7ggs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EF3C19421;
	Sun, 22 Mar 2026 02:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774145664;
	bh=15LtSrMbO+4zppNOiphuTaqoBsJ8Br+hPF1Xrky7JBo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=LL2s7ggscFg5V1sRZTGntO4Wl4g2rEbg76J5JTmPLTdMKL6aPEnBh6VphatMFCWXL
	 ocEdB77wCcv9qji8J6fxcOWHAzdU9JEYrjEY5qsPzcck9zaCuCU5vdUXxcebMRlS46
	 wbKZVhh/WKQeSH1i7rOxP/v3bSAYKlfOFSD+iYOVguuQlCkAp+NtTUH+yje5jTs0nk
	 Yg+y/jKj2OK5qK6K8B/crNc81HDy6lBEqiZH2uNawhQJ9YKaO2cp0kJaYZJ09uzaMm
	 H3hXU3BvkZ9SsGyqx/kWZFv+pZ7XmQcBMCtVgg0kdufzxF3685qMUcLthQSngQ3A7p
	 9INLlgI2gyLsg==
Content-Type: multipart/mixed; boundary="===============6203560646426951199=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1857be3473d584037af17e3026d9b1e1d16a78486c9be63174ea4553aa9db9f8@mail.kernel.org>
In-Reply-To: <20260322014402.8815-7-piliu@redhat.com>
References: <20260322014402.8815-7-piliu@redhat.com>
Subject: Re: [PATCHv7 06/13] kexec_file: Chain the stages into a pipeline
From: bot+bpf-ci@kernel.org
To: piliu@redhat.com,kexec@lists.infradead.org
Cc: piliu@redhat.com,davem@davemloft.net,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jeremy.linton@arm.com,catalin.marinas@arm.com,will@kernel.org,ardb@kernel.org,horms@kernel.org,kraxel@redhat.com,vkuznets@redhat.com,prudo@redhat.com,vmalik@redhat.com,kernel@jfarr.cc,bhe@redhat.com,dyoung@redhat.com,akpm@linux-foundation.org,bpf@vger.kernel.org,systemd-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 22 Mar 2026 02:14:24 +0000 (UTC)

--===============6203560646426951199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/kexec_bpf_loader.c b/kernel/kexec_bpf_loader.c
> index af16f7b685d9..7f7884411e2c 100644
> --- a/kernel/kexec_bpf_loader.c
> +++ b/kernel/kexec_bpf_loader.c

[ ... ]

> @@ -301,6 +305,23 @@ static int kexec_buff_parser(struct bpf_parser_context *parser)
>  				vfree(ctx->kernel);
>  				ctx->kernel = decompressed_buf;
>  				ctx->kernel_sz = decompressed_sz;
> +				if (fill_pipeline) {
> +					int i;
> +
> +					for (i = 0; i < MAX_PARSING_BUF_NUM; i++) {
> +						if (ctx->next_parsing_buf[i])
> +							continue;
> +						ctx->next_parsing_buf[i] = decompressed_buf;
> +						ctx->next_parsing_buf_sz[i] = decompressed_sz;
> +						break;
> +					}

After this, both ctx->kernel and ctx->next_parsing_buf[i] point to
the same decompressed_buf allocation. When next_parsing_buf is later
promoted to parsing_buf in process_bpf_parsers_container(), there
are two independent references to the same memory.

If the next BPF stage issues another KEXEC_BPF_CMD_DECOMPRESS for
KEXEC_BPF_SUBCMD_KERNEL, vfree(ctx->kernel) frees the buffer while
parsing_buf[i] still references it.

The KEXEC_BPF_CMD_COPY path avoids this by allocating a separate
copy with __vmalloc(). Should the DECOMPRESS path do the same to
prevent aliased ownership?

> +					/* No enough parsing slot */
> +					if (i == MAX_PARSING_BUF_NUM) {
> +						ctx->kernel = NULL;
> +						vfree(decompressed_buf);
> +						return -ENOMEM;
> +					}
> +				}
>  				break;

[ ... ]

> @@ -313,6 +334,22 @@ static int kexec_buff_parser(struct bpf_parser_context *parser)
>  		if (!p)
>  			return -ENOMEM;
>  		memcpy(p, buf, cmd->payload_len);
> +		if (fill_pipeline) {
> +			pn = __vmalloc(cmd->payload_len, GFP_KERNEL | __GFP_ACCOUNT);
> +			if (!pn) {
> +				vfree(p);
> +				return -ENOMEM;
> +			}
> +			memcpy(pn, buf, cmd->payload_len);
> +			for (int i = 0; i < MAX_PARSING_BUF_NUM; i++) {
> +				if (!ctx->next_parsing_buf[i]) {
> +					ctx->next_parsing_buf[i] = pn;
> +					ctx->next_parsing_buf_sz[i] = cmd->payload_len;
> +					break;
> +				}
> +			}
> +		}

If all MAX_PARSING_BUF_NUM slots are already occupied, the loop
completes without storing pn anywhere, and the allocation is leaked.

The DECOMPRESS path handles this case with an explicit check:

    if (i == MAX_PARSING_BUF_NUM) {
        ctx->kernel = NULL;
        vfree(decompressed_buf);
        return -ENOMEM;
    }

Is a similar overflow check missing here for the COPY path?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23393379437
--===============6203560646426951199==--

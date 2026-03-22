Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D9E37DE9E;
	Sun, 22 Mar 2026 02:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774146395; cv=none; b=VY6+deCFgZmDOc79kuWBgdLCRtPsKYxgLjHe8dSv4It8uUCTndnaDohhWl7Irkz5ZBSXgGrBsimTYdIOoW7XjnwShUUFiJXWSL0fBq86Z4OQu481ra3+ME8IqUSTNoq5VSkxKjX+17YbuOEDuDqD0p1IcfOuoZF6yYIDDDMBL+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774146395; c=relaxed/simple;
	bh=e28PPferGzosCU+i58JNVBT0CDCpiwBcPUUhQVfPpa4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=aeF6hv7sisP5s/A3+krBKzTEZOPnWyS9r5tCUU8fKMq2b796tidOl0XsROz9cmfj8E96utJ552RoNNbvllnTwMGZoNUd34Q+PNivtpiFPAK+/ZPvxXjjPMVHhPvEw3uaFXsgPlE/g+7ZfSmbYn9m08j9HFahIJ+EAX5apwucIjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrfLxNMm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrfLxNMm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68215C19421;
	Sun, 22 Mar 2026 02:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774146394;
	bh=e28PPferGzosCU+i58JNVBT0CDCpiwBcPUUhQVfPpa4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=lrfLxNMmIAVERtQCvrBbbT2rJgEZ3n+ml/bVFya/R7T8MXMVnpb0VEZnlh4xoUuJN
	 uYVt6vk+SfjkrKgD48TaBD7o0kCfyoEHDiH3l1CAmOuMY/rXJGjqy2CqpmXtZ+Vzah
	 JjCuFhkoHYsP4t0/ct05fLANvhSuqxjIsaiC2NPu6vOs1iUsrKFi1hSFklRO38UEH9
	 a9uuj1FhstylH3gPXcOmA72EoOeaFdBjwj/7PJi3hDMc7H/CpY1B1eKyf2qxu+p690
	 IYX/zs4PIjJCPVWRT+sSezoPRFv0LfKQa0RmmRglBMrlL91u/CMyvZykXs+BL7v7f6
	 YxvKwiBqGCZug==
Content-Type: multipart/mixed; boundary="===============7741034310972575734=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9fc6a101fc0aff669aab2270d9287b55e63b44993778536303843b6155af1283@mail.kernel.org>
In-Reply-To: <20260322014402.8815-5-piliu@redhat.com>
References: <20260322014402.8815-5-piliu@redhat.com>
Subject: Re: [PATCHv7 04/13] kexec_file: Implement decompress method for parser
From: bot+bpf-ci@kernel.org
To: piliu@redhat.com,kexec@lists.infradead.org
Cc: piliu@redhat.com,davem@davemloft.net,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jeremy.linton@arm.com,catalin.marinas@arm.com,will@kernel.org,ardb@kernel.org,horms@kernel.org,kraxel@redhat.com,vkuznets@redhat.com,prudo@redhat.com,vmalik@redhat.com,kernel@jfarr.cc,bhe@redhat.com,dyoung@redhat.com,akpm@linux-foundation.org,bpf@vger.kernel.org,systemd-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 22 Mar 2026 02:26:34 +0000 (UTC)

--===============7741034310972575734==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/kexec_bpf_loader.c b/kernel/kexec_bpf_loader.c
> index bd1800a76782..c79fb777d51b 100644
> --- a/kernel/kexec_bpf_loader.c
> +++ b/kernel/kexec_bpf_loader.c

[ ... ]

> @@ -73,8 +74,243 @@ static int __init kexec_bpf_prog_run_init(void)
>  }
>  late_initcall(kexec_bpf_prog_run_init);

[ ... ]

>  static int kexec_buff_parser(struct bpf_parser_context *parser)
>  {
> +	struct bpf_parser_buf *pbuf = parser->buf;
> +	struct kexec_context *ctx = (struct kexec_context *)parser->data;
> +	struct cmd_hdr *cmd = (struct cmd_hdr *)pbuf->buf;
> +	char *decompressed_buf, *buf, *p;
> +	unsigned long decompressed_sz;
> +	int ret = 0;

[ ... ]

> +	case KEXEC_BPF_CMD_DECOMPRESS:
> +		ret = parser_cmd_decompress(buf, cmd->payload_len, &decompressed_buf,
> +					&decompressed_sz, ctx);
> +		if (!ret) {
> +			switch (cmd->subcmd) {
> +			case KEXEC_BPF_SUBCMD_KERNEL:
> +				vfree(ctx->kernel);
> +				ctx->kernel = decompressed_buf;
> +				ctx->kernel_sz = decompressed_sz;
> +				break;
> +			default:
> +				vfree(decompressed_buf);
> +				break;
> +			}
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
>  	return 0;
>  }

Should this return ret instead of 0?  When parser_cmd_decompress()
fails, ret holds the error code, but the function discards it and
returns success.

bpf_buffer_parser() in bpf_buffer_parser.c propagates this return
value back to the calling BPF program:

    ret = context->func(context);
    ...
    return ret;

Returning 0 here means the BPF program sees success even when
decompression failed.  It would then proceed to send
KEXEC_BPF_CMD_DONE, setting ctx->parsed = true, causing kexec
to complete loading with a missing or undecompressed kernel image.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23393379437
--===============7741034310972575734==--

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EFB37D10F;
	Sun, 22 Mar 2026 02:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774145670; cv=none; b=rYveBQuF+Treat7tAKRJ+n2aGyGb6GnaVE6BkBwyU2LuDg/pqn6IWrflSaHeVDjsajybQdIyyH/UzYSmSg1byULp/HbJHbw/9TQ2ZcuXLmcre1vOsC+8WkXPPb9h9xlqDINIfsJmcufQKbA3iyjfsywkk5j+J+V+Q6JfsWCeVc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774145670; c=relaxed/simple;
	bh=KM27ZStv54d4ev0F7eUGi5mKasxRcuFt8w61iI2z5fg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Wd6yyIRFA4ep7EhFeetkl+RAGPGJtFewzIPrq4hvyf9TFbhm1YmrFT6lZyhCF4XH7YivqxZy4xMPW9rg/MJWWd2ougvw33aQcPHmFjYVbFUmLPSCJXIujeq/Acs7WmGRK7j1xuW5RLn0wkDauAl2y/hripCo3sKkyrlVVylQQqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxUq1vhp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxUq1vhp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06289C19421;
	Sun, 22 Mar 2026 02:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774145669;
	bh=KM27ZStv54d4ev0F7eUGi5mKasxRcuFt8w61iI2z5fg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=oxUq1vhpeCZwtX+7Kq7V3QSY/lojQ+xfQP0pcoqot5QvXw7dV/4rDeQc4Fmrmz261
	 bTZRS/mvj5oQHnT1L/FgCE9DX2A6ylnaoFZyYsiDjfmbgFI++GWJJSx0li5dtrXa5X
	 f0jRGsbVhjksG7iR8ZJ5iQ/zXJFt54xyL9EPHQ8vBKj0YCKmycjTCIHilcxZgai7+2
	 lPD9Ojg6dtgDhgW+9MiZnpR8YqmnhoYSyM12LtNBNchwxx9hOLrbge4ALx9VWZnKrZ
	 pCfOGXtBQiPGyUYRLbuTQsK2Fs44b/oZRUcxkKk0JdHwZhVoK8nqoF68AHgYNQj68b
	 rrPtttxnisexQ==
Content-Type: multipart/mixed; boundary="===============8611594194516260872=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <08c0a3bb712e08a8889996a1e4e8c4539eb02a393e237d67e3179364c054fddc@mail.kernel.org>
In-Reply-To: <20260322014402.8815-3-piliu@redhat.com>
References: <20260322014402.8815-3-piliu@redhat.com>
Subject: Re: [PATCHv7 02/13] kexec_file: Use bpf-prog to decompose image
From: bot+bpf-ci@kernel.org
To: piliu@redhat.com,kexec@lists.infradead.org
Cc: piliu@redhat.com,davem@davemloft.net,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jeremy.linton@arm.com,catalin.marinas@arm.com,will@kernel.org,ardb@kernel.org,horms@kernel.org,kraxel@redhat.com,vkuznets@redhat.com,prudo@redhat.com,vmalik@redhat.com,kernel@jfarr.cc,bhe@redhat.com,dyoung@redhat.com,akpm@linux-foundation.org,bpf@vger.kernel.org,systemd-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 22 Mar 2026 02:14:29 +0000 (UTC)

--===============8611594194516260872==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/kexec_bpf_loader.c b/kernel/kexec_bpf_loader.c
> new file mode 100644
> index 000000000000..bd1800a76782
> --- /dev/null
> +++ b/kernel/kexec_bpf_loader.c

[ ... ]

> +#include <linux/bpf.h>
> +#include <linux/filter.h>
> +#include <asm/byteorder.h>
> +#include <asm/image.h>
> +#include <asm/memory.h>
> +#include "kexec_internal.h"

Are asm/image.h and asm/memory.h needed here?  I could not find any
symbols from either header used in this file.  asm/image.h only exists
for arm64, loongarch, and riscv, and asm/memory.h only for arm, arm64,
and csky.

Since CONFIG_KEXEC_BPF has no architecture dependency, enabling it on
x86 would cause a build failure from these missing headers.

[ ... ]

> +static int process_bpf_parsers_container(const char *elf_buf, size_t elf_sz,
> +				   struct kexec_context *context, int depth)
> +{

[ ... ]

> +		/*
> +		 * Give the BPF prog a clean slate so context->parsed reliably
> +		 * reflects whether *this* invocation succeeded.
> +		 */
> +		context->parsed = false;
> +		/* This is the hook point for bpf-prog */
> +		kexec_image_parser_anchor(context, (unsigned long)bpf);
> +		disarm_bpf_prog();
> +
> +		/* Free the old parsing context, and reload the new */
> +		for (int i = 0; i < MAX_PARSING_BUF_NUM; i++) {
> +			if (!!context->parsing_buf[i])
> +				break;
> +			vfree(context->parsing_buf[i]);
> +			context->parsing_buf[i] = NULL;
> +			context->parsing_buf_sz[i] = 0;
> +		}

The comment says "free the old parsing context" but the condition
appears inverted.  !!context->parsing_buf[i] is true when the pointer
is non-NULL, so the loop breaks at the first populated entry and only
calls vfree() on NULL pointers (which is a no-op).

Should this be if (!context->parsing_buf[i]) instead?

[ ... ]

> +int decompose_kexec_image(struct kimage *image, int extended_fd)
> +{
> +	struct kexec_context ctx = { 0 };
> +	unsigned long parser_sz;
> +	char *parser_start;
> +	int ret = -EINVAL;

[ ... ]

> +	if (!validate_elf_bpf_sections(parser_start, parser_sz)) {
> +
> +		ret = kernel_read_file_from_fd(extended_fd,
> +						0,
> +						(void **)&ctx.parsing_buf[0],
> +						KEXEC_FILE_SIZE_MAX,
> +						NULL,
> +						0);
> +		if (ret < 0) {
> +			pr_err("Fail to read image container\n");
> +			return -EINVAL;
> +		}
> +		ctx.parsing_buf_sz[0] = ret;
> +		ret = process_bpf_parsers_container(parser_start, parser_sz, &ctx, 0);
> +		if (!ret) {
> +			char *p;
> +
> +			/* Envelop should hold valid kernel, initrd, cmdline sections */
> +			if (!ctx.kernel || !ctx.initrd || !ctx.cmdline) {
> +				vfree(ctx.kernel);
> +				vfree(ctx.initrd);
> +				vfree(ctx.cmdline);
> +				return -EINVAL;
> +			}

[ ... ]

> +		}
> +		return ret;
> +	}
> +
> +	return -EINVAL;
> +}

When process_bpf_parsers_container() fails, or when the
!ctx.kernel || !ctx.initrd || !ctx.cmdline check triggers,
ctx.parsing_buf[0] was allocated by kernel_read_file_from_fd() but
is never freed before returning.  Does this leak the buffer?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23393379437
--===============8611594194516260872==--

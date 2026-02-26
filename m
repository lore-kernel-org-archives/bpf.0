Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13B73624B0
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 13:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113088; cv=none; b=o5gZczcC5wlr9Y01qorHYzw44pHLfi0QKyTf15r93Ep3lQBlvYYgSiuB2GZfi2KrjUA/5dftjoUMcuEp+7bSy/cOkwAZ5Us+72dEM2ZeNvTYtURq5UxPglB8DJ5TD1Nv67rwvaOzkam+WmzYVDJ4YWDz1qnFMcbJ5DuQs8QBksQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113088; c=relaxed/simple;
	bh=FXF/EZisEZkN2tIdE8N9kJA89adAdH+7J80t/xp9+4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UGFjAPB/XwVssA+KZCNGzesQYVhuE8KoCpXRbK7m1AZrFEtMVH0nq+I+W+692CWFaNQcSs6YR970VWuxNw19SfQ8ZzRQGdACxeFNsDYLcWN+Ii/JqQ5QAdilFFVv9lUH5Mg1S3Wsoi0fU4zI0jcvEb1eG51tI9lYdT3ZCx9Yt38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UhVOhYDd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UhVOhYDd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772113084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xa0ZfxYyv4zHUToxsERixm69ne0BA2dtlNERxeC8jao=;
	b=UhVOhYDdnURMkAezkP6VXG/yHzOkpj0rW9LhN2p6vqjhwFgfqyPNCNCWmRgbdZeXpLpCNH
	eViWy/Z34Vk3Q3Egac2aQFmHLBgfX+X9ebHC0+vekRiPZ6sprGxS8bPV3UVBISYUCN0EoE
	ZSv2Ef1MBpKvPdAOUyKcusQ3aJRNQlI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-oW_UghdSNl6lrqpHzPoquA-1; Thu,
 26 Feb 2026 08:38:01 -0500
X-MC-Unique: oW_UghdSNl6lrqpHzPoquA-1
X-Mimecast-MFC-AGG-ID: oW_UghdSNl6lrqpHzPoquA_1772113077
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8206619560AD;
	Thu, 26 Feb 2026 13:37:56 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.44.32.93])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DB86D3000218;
	Thu, 26 Feb 2026 13:37:47 +0000 (UTC)
Date: Thu, 26 Feb 2026 14:37:43 +0100
From: Philipp Rudo <prudo@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, "David S. Miller" <davem@davemloft.net>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, Jeremy Linton <jeremy.linton@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Simon Horman <horms@kernel.org>, Gerd
 Hoffmann <kraxel@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Viktor Malik <vmalik@redhat.com>, Jan Hendrik Farr <kernel@jfarr.cc>,
 Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, bpf@vger.kernel.org,
 systemd-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 04/13] kexec_file: Use bpf-prog to decompose image
Message-ID: <20260226143743.7e963ba9@rotkaeppchen>
In-Reply-To: <20260119032424.10781-5-piliu@redhat.com>
References: <20260119032424.10781-1-piliu@redhat.com>
	<20260119032424.10781-5-piliu@redhat.com>
Organization: Red Hat inc.
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Pingfan,

On Mon, 19 Jan 2026 11:24:15 +0800
Pingfan Liu <piliu@redhat.com> wrote:

[...]

> diff --git a/kernel/kexec_bpf_loader.c b/kernel/kexec_bpf_loader.c
> new file mode 100644
> index 0000000000000..dc59e1389da94
> --- /dev/null
> +++ b/kernel/kexec_bpf_loader.c
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Kexec image bpf section helpers
> + *
> + * Copyright (C) 2025, 2026 Red Hat, Inc
> + */
> +
> +#define pr_fmt(fmt)	"kexec_file(Image): " fmt
> +
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/list.h>
> +#include <linux/kernel.h>
> +#include <linux/vmalloc.h>
> +#include <linux/kexec.h>
> +#include <linux/elf.h>
> +#include <linux/string.h>
> +#include <linux/bpf.h>
> +#include <linux/filter.h>
> +#include <asm/byteorder.h>
> +#include <asm/image.h>
> +#include <asm/memory.h>
> +#include "kexec_internal.h"
> +
> +/* Load a ELF */
> +static int arm_bpf_prog(char *bpf_elf, unsigned long sz)
> +{
> +	return 0;
> +}
> +
> +static void disarm_bpf_prog(void)
> +{
> +}
> +
> +struct kexec_context {
> +	bool kdump;
> +	char *kernel;
> +	int kernel_sz;
> +	char *initrd;
> +	int initrd_sz;
> +	char *cmdline;
> +	int cmdline_sz;
> +};
> +
> +void kexec_image_parser_anchor(struct kexec_context *context,
> +		unsigned long parser_id);
> +
> +/*
> + * optimize("O0") prevents inline, compiler constant propagation
> + *
> + * Let bpf be the program context pointer so that it will not be spilled into
> + * stack.
> + */
> +__attribute__((used, optimize("O0"))) void kexec_image_parser_anchor(
> +		struct kexec_context *context,
> +		unsigned long parser_id)
> +{
> +	/*
> +	 * To prevent linker from Identical Code Folding (ICF) with kexec_image_parser_anchor,
> +	 * making them have different code.
> +	 */
> +	volatile int dummy = 0;
> +
> +	dummy += 1;
> +}
> +
> +
> +BTF_KFUNCS_START(kexec_modify_return_ids)
> +BTF_ID_FLAGS(func, kexec_image_parser_anchor, KF_SLEEPABLE)
> +BTF_KFUNCS_END(kexec_modify_return_ids)
> +
> +static const struct btf_kfunc_id_set kexec_modify_return_set = {
> +	.owner = THIS_MODULE,
> +	.set = &kexec_modify_return_ids,
> +};
> +
> +static int __init kexec_bpf_prog_run_init(void)
> +{
> +	return register_btf_fmodret_id_set(&kexec_modify_return_set);
> +}
> +late_initcall(kexec_bpf_prog_run_init);
> +
> +static int kexec_buff_parser(struct bpf_parser_context *parser)
> +{
> +	return 0;
> +}
> +
> +/* At present, only PE format file with .bpf section is supported */
> +#define file_has_bpf_section	pe_has_bpf_section
> +#define file_get_section	pe_get_section
> +
> +int decompose_kexec_image(struct kimage *image, int extended_fd)
> +{
> +	struct kexec_context context = { 0 };
> +	struct bpf_parser_context *bpf;
> +	unsigned long kernel_sz, bpf_sz;
> +	char *kernel_start, *bpf_start;
> +	int ret = 0;
> +
> +	if (image->type != KEXEC_TYPE_CRASH)
> +	        context.kdump = false;
> +	else
> +	        context.kdump = true;
> +
> +	kernel_start = image->kernel_buf;
> +	kernel_sz = image->kernel_buf_len;
> +
> +	while (file_has_bpf_section(kernel_start, kernel_sz)) {
> +
> +		bpf = alloc_bpf_parser_context(kexec_buff_parser, &context);
> +		if (!bpf)
> +			return -ENOMEM;
> +		file_get_section((const char *)kernel_start, ".bpf", &bpf_start, &bpf_sz);
> +		if (!!bpf_sz) {
> +			/* load and attach bpf-prog */
> +			ret = arm_bpf_prog(bpf_start, bpf_sz);
> +			if (ret) {
> +				put_bpf_parser_context(bpf);
> +				pr_err("Fail to load .bpf section\n");
> +				goto err;
> +			}
> +		}

I'm not sure this works as intended. In case a .bpf section exists but
bpf_sz is 0, the function will skip arming the bpf-prog but still
continue. That doesn't look right to me. IIUC a zero size bpf-prog
should be an error. Or am I missing something?

Thanks
Philipp

> +		context.kernel = kernel_start;
> +		context.kernel_sz = kernel_sz;
> +		/* bpf-prog fentry, which handle above buffers. */
> +		kexec_image_parser_anchor(&context, (unsigned long)bpf);
> +
> +		/*
> +		 * Container may be nested and should be unfold one by one.
> +		 * The former bpf-prog should prepare 'kernel', 'initrd',
> +		 * 'cmdline' for the next phase by calling kexec_buff_parser()
> +		 */
> +		kernel_start = context.kernel;
> +		kernel_sz = context.kernel_sz;
> +
> +		/*
> +		 * detach the current bpf-prog from their attachment points.
> +		 */
> +		disarm_bpf_prog();
> +		put_bpf_parser_context(bpf);
> +	}
> +
> +	/*
> +	 * image's kernel_buf, initrd_buf, cmdline_buf are set. Now they should
> +	 * be updated to the new content.
> +	 */
> +	image->kernel_buf = context.kernel;
> +	image->kernel_buf_len = context.kernel_sz;
> +	image->initrd_buf = context.initrd;
> +	image->initrd_buf_len = context.initrd_sz;
> +	image->cmdline_buf = context.cmdline;
> +	image->cmdline_buf_len = context.cmdline_sz;
> +
> +	return 0;
> +err:
> +	vfree(context.kernel);
> +	vfree(context.initrd);
> +	vfree(context.cmdline);
> +	return ret;
> +}
> +
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 0222d17072d40..f9674bb5bd8db 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -238,7 +238,14 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  		goto out;
>  #endif
>  
> -	/* Call arch image probe handlers */
> +	if (IS_ENABLED(CONFIG_KEXEC_BPF))
> +		decompose_kexec_image(image, initrd_fd);
> +
> +	/*
> +	 * From this point, the kexec subsystem handle the kernel boot protocol.
> +	 *
> +	 * Call arch image probe handlers
> +	 */
>  	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
>  					    image->kernel_buf_len);
>  	if (ret)
> diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
> index 8e5e5c1237732..ee01d0c8bb377 100644
> --- a/kernel/kexec_internal.h
> +++ b/kernel/kexec_internal.h
> @@ -39,6 +39,7 @@ extern size_t kexec_purgatory_size;
>  extern bool pe_has_bpf_section(const char *file_buf, unsigned long pe_sz);
>  extern int pe_get_section(const char *file_buf, const char *sect_name,
>  		char **sect_start, unsigned long *sect_sz);
> +extern int decompose_kexec_image(struct kimage *image, int extended_fd);
>  #else /* CONFIG_KEXEC_FILE */
>  static inline void kimage_file_post_load_cleanup(struct kimage *image) { }
>  #endif /* CONFIG_KEXEC_FILE */


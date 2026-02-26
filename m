Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CA8364035
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 13:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113075; cv=none; b=NG0sJc8tpzgV7tp+Etus3nyXvYCkUC+TSQKnkT3sYOz6jQ+xSPZxzcXy8FV/vvPqG69qYvR28/t2kRpBSZ4joxzoDQNjsSdSNpaiNicDlodtHf6SzW5/h0ZgTZ4QJcyyL5GGINxq8vJ7HpCi4hZMwUqxLoOSh2JFEJiCQbZyOWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113075; c=relaxed/simple;
	bh=IYB0n/+/IomDSp7SOztMzmwWY4V/EBjoHudfS2A8u6I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HY6t/fgLZihospFtXSsQxcQCL6RgIA3LNKpXi88neVfDV3xPP7/kB/E1FyzSLEXtMgiaZoCHJ+LrwBgh+rLkpYZngeU+Srty+ybe9F/Gdd8FQpMbNwYnK/Hw3oWXD3xORGaCd6+9CxMDjTtOvBUxGULkyFnSmvDcevSEeuqk/ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YdXHYh7x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdXHYh7x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772113072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3eWwAMPVsNlYzbt9jqcCV9wZlXvhXXjV0haFsXZmtXA=;
	b=YdXHYh7xZwNfSTuDywROg2zxZbi6ddQkyNUdVAhXvlzAmdK12BKE7S4+gUg7XVp6Rehhs7
	QiCkZ27K8BXIv82PdJgshUZcII3eCS672WwbjmPxFJtIoVWcr/ohICXypRSmUtIqaDVL02
	lom/zlKh9jZJqM2cJ/mFTKXzqc9D4OE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-RoFitFaWPbaCQG9nJCx8ug-1; Thu,
 26 Feb 2026 08:37:43 -0500
X-MC-Unique: RoFitFaWPbaCQG9nJCx8ug-1
X-Mimecast-MFC-AGG-ID: RoFitFaWPbaCQG9nJCx8ug_1772113061
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F09F21956048;
	Thu, 26 Feb 2026 13:37:24 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.44.32.93])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CD3811800666;
	Thu, 26 Feb 2026 13:37:15 +0000 (UTC)
Date: Thu, 26 Feb 2026 14:37:10 +0100
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
Subject: Re: [PATCHv6 02/13] kexec_file: Move signature validation ahead
Message-ID: <20260226143710.42ba1843@rotkaeppchen>
In-Reply-To: <20260119032424.10781-3-piliu@redhat.com>
References: <20260119032424.10781-1-piliu@redhat.com>
	<20260119032424.10781-3-piliu@redhat.com>
Organization: Red Hat inc.
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi Pingfan,

On Mon, 19 Jan 2026 11:24:13 +0800
Pingfan Liu <piliu@redhat.com> wrote:

> Move the signature validation at the head of the function, so the image
> can be unfold and handled later.

besides what the bpf-bot already mentioned.

What do you want to achieve by moving signature verification in front
of probing the image? Do you want to avoid calling
arch_kexec_kernel_image_probe twice? It would be great if you could add
the reasoning why the change is needed to the commit message in the
future. Not only to make review easier but also to document it for the
future.

Thanks
Philipp

> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Philipp Rudo <prudo@redhat.com>
> To: kexec@lists.infradead.org
> ---
>  kernel/kexec_file.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index eb62a97942428..0222d17072d40 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -231,18 +231,19 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  	kexec_dprintk("kernel: %p kernel_size: %#lx\n",
>  		      image->kernel_buf, image->kernel_buf_len);
>  
> -	/* Call arch image probe handlers */
> -	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
> -					    image->kernel_buf_len);
> -	if (ret)
> -		goto out;
> -
>  #ifdef CONFIG_KEXEC_SIG
>  	ret = kimage_validate_signature(image);
>  
>  	if (ret)
>  		goto out;
>  #endif
> +
> +	/* Call arch image probe handlers */
> +	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
> +					    image->kernel_buf_len);
> +	if (ret)
> +		goto out;
> +
>  	/* It is possible that there no initramfs is being loaded */
>  	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
>  		ret = kernel_read_file_from_fd(initrd_fd, 0, &image->initrd_buf,


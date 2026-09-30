Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89153366057
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 07:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752074; cv=none; b=XBa2HdAcS5rgPI+LSi/M/OAGEU+Yel+z2ZvyFN4HrXVQZBaO+Eb+D4erz8j5K/iZlRP1MnGl0cSjrz5PgILFrZDj5CQW+uOfU1WBZ031Ebyy4Dy3x2GJ7LN7dxshvdTgbHMX9QP+3wP5NSVQYLGnXh8FJYgAZICZ3mWdLpjOd10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752074; c=relaxed/simple;
	bh=rtEvlpc5RFKwgsy5Faq1Dvca+J9Y2+1PDgdNAuQ81Ko=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCIZMBiGOx0Yda9Emmh6A7sIBQX39KPxW9pSwkpz1+LBDlz1LhP8W8YVvQ6lan6sIPxD942fCIfoFcCm0MH145yQgWsydvZQxGE7xRjcMgS2w29qTGPovzMibyoyp0Qjjdwk8PHrxj2xA8mGaEVgvIyRDYaiPQnntklrur4sQbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Szt92RVN; arc=none smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Szt92RVN"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6acb8b78d6cso2072210a12.2
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 00:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790752070; x=1791356870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yPxo5oIesTw/2A8ukKykJpHFhPhcqo3C0UATOY1SYVs=;
        b=Szt92RVNxsQONHzDiByv/n6PzMGv6h4y6UjVPybFbLRgpjjr8QfsRew1uLr9hQLYxx
         v70iODpytwPPiZYybLrv13lZWJUfKQw07NWrpb+D7hNlOLrXmxPPFWiy1WUI9OceA/sK
         I25m64P9h0V38DW/pjKltS3kqj2FjuAo5ymbtKRxkG8XCSrYjUvotKHL2+yE3F9rKsjz
         Q3+0TLkQl8cLx+wRkjEesdTx9do2aCfAijl1cwDEibmvR8j9goP/sE1l+ksr3fFFp6AT
         NMdtazOwUg0Yw4UG/z79KEpHrmSYqR8lYQZNc4as5C53Cf9aSkDxPTbRJxJCL9HlEaCv
         Y7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752070; x=1791356870;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yPxo5oIesTw/2A8ukKykJpHFhPhcqo3C0UATOY1SYVs=;
        b=ADDLhlrzaElNBX1InQILstq8qv1f55svKv5AKh+QpazNXeN7IiNKNt8hAGPRccoPnj
         eh4gVq+MOJpfRXJmGz2ZkbmggRQZM2kQgfumFagaX3hW8VlEM3dzNOAFKSkg0jNFT7Q4
         6qboOggiDTvCOJnYuFh1gYGySdzdAaPYYwzekzhpxYcgPv0LQ4xCFnvV5GBqnbFlxQ3+
         uL+nMWVx8xPMkyBrf3OjqA49Ef9IbUPqrQOIt+xnLaD5gSYjbkT0FQVYuWfqwsVP/cRP
         MjVCYYneRjcI8U3a9bS8SC3vKgKdkQ9LEe9Lb4u7AtbMWMVIVbhDHGaJL4jQCH4ow/pp
         TG5w==
X-Forwarded-Encrypted: i=1; AKwUvBxZUCvJ4pywA2C8+VfQRWP1wFaUIdcfbYT8RBwJzmX9jOcfxOyPzAZztEPzI69rGiobBao=@vger.kernel.org
X-Gm-Message-State: AFq9FYKiIyErpTeu2SApzt0WVDgW1v5PIVWyTz/namqTprMDFEaBfIXz
	1aa46Xw/2AWjHqxK1RWNcTjIO/H1vC4VNCksMD04QJ4t44LWVmW/T8bO
X-Gm-Gg: AYBFou2uXFdRvBCFH+AO6oEpmAsQLgi6A4nUAEvFQE35dmXmrhUcEONGGnirhQDypt4
	wNjicXNNwAf9COjvg2PmSIPbPNyL8FaG0c0OkGeo7xP/NM1J5yKOSWoPj6IIeQs4skA9reCI9NZ
	Nq4z6yVDvg30RnmWvExQJ+GXxrVfQX3LIR9PDGN7UJEMHkzseVQ0c0aSaFY4LZUhaNBrEx7sUlt
	6sUZN0NWmRjrD3Xhcm10WuI7f5vnn0XusQ1uGd+0MNQpsL8SHQXF14VihEGqrepKWYmlwaQeufm
	Kt+cjGdZRhqcz9NVKN9MrmM0tNpYaOjqoM6jJYdpQJw0l92+24JDOomwncHyJHXBezueT/aLKrD
	bfoIM7f4bxCefyKPiuPkVS/vaJlwjw0Xjo+s2E6FsEapSHt4XLdQ+XWg0aXhRC6oZ6IMm93q6kn
	sIziYrWExZIeQWrMpJWfpWw+87lo1bPSNdpU9spUlNWC/03tncTOWznvQyaA==
X-Received: by 2002:a05:6402:4613:b0:6ae:160a:58a6 with SMTP id 4fb4d7f45d1cf-6ae19963b9cmr194812a12.36.1790752069491;
        Wed, 30 Sep 2026 00:07:49 -0700 (PDT)
Received: from krava ([173.38.220.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ae1558d9b5sm325750a12.17.2026.09.30.00.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:07:48 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 30 Sep 2026 09:07:47 +0200
To: Mark Brown <broonie@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>,
	Florent Revest <florent.revest@linux.dev>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the bpf-next tree with the bpf tree
Message-ID: <ary1Q48NrlD4i_Zf@krava>
References: <arvRs4KdojDnW1O6@sirena.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arvRs4KdojDnW1O6@sirena.org.uk>

On Tue, Sep 29, 2026 at 03:56:51PM +0100, Mark Brown wrote:
> Hi all,
> 
> Today's linux-next merge of the bpf-next tree got a conflict in:
> 
>   arch/x86/net/bpf_jit_comp.c
> 
> between commit:
> 
>   17637e1a581a2 ("bpf: Skip detached progs in trampoline images that are still in use")
> 
> from the bpf tree and commit:
> 
>   29fcf9ce4bbdf ("bpf, x86: Use global buffer for trampoline size generation")
> 
> from the bpf-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This

lgtm, thanks

jirka

> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> diff --cc arch/x86/net/bpf_jit_comp.c
> index 6bca87457e872,6c7a0578760e7..0000000000000
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@@ -3817,25 -4152,15 +4158,15 @@@ out
>   int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
>   			     struct bpf_tramp_nodes *tnodes, void *func_addr)
>   {
>  -	struct bpf_tramp_image im;
>  +	struct bpf_tramp_image im = {};
> - 	void *image;
> - 	int ret;
>   
> - 	/* Allocate a temporary buffer for __arch_prepare_bpf_trampoline().
> - 	 *
> - 	 * We cannot use kvmalloc here, because we need image to be in
> - 	 * module memory range.
> - 	 * Since it must be writable use execmem_alloc(EXECMEM_MODULE_DATA)
> - 	 * that returns writable memory in the module address space.
> - 	 */
> - 	image = execmem_alloc(EXECMEM_MODULE_DATA, PAGE_SIZE);
> - 	if (!image)
> + 	if (!trampoline_size_image)
>   		return -ENOMEM;
>   
> - 	ret = __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE, image,
> - 					    m, flags, tnodes, func_addr);
> - 	execmem_free(image);
> - 	return ret;
> + 	return __arch_prepare_bpf_trampoline(&im, trampoline_size_image,
> + 					     trampoline_size_image + PAGE_SIZE,
> + 					     trampoline_size_image, m, flags,
> + 					     tnodes, func_addr);
>   }
>   
>   static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs, u8 *image, u8 *buf)



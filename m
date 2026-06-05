Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F099E3D6CB1
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780671191; cv=none; b=T57DXJZeYJt+bxkwtXYhINpm8tqONOaiBSMG0wwCdI9BMt7ZAFwcVMKB0tBAT6fWEsuM1c/DAwpqb3+pUXkoGFln3xtgHWOgxXazAp+cN2sp+baIG5JPjA3rBrAWI9HCiwb3roCDKtAU1rwFMomRAd0xS6CEh17gKISHN1w+tmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780671191; c=relaxed/simple;
	bh=Wg5H4kxszJhetdqAMcJTwCtiKVFs+xzbAv5W3PH85Gw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAz+GaFguJJu4fW0EKVEiL1N4gQGnundtqibtjAbtFZTqeeU13FEwh66cX99Kqmy+f45m1P6d8MR3EzNsg/QPdIgYXb55vZkgOSbS6n3LjZYaaxEENC6JgQjStVKx5moaHziXz2nguiiYrNw4jn4Auwwp6n+9tETZHHYkmN3aV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrI9fmqj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrI9fmqj"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490b4e1ade7so22058335e9.0
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 07:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780671188; x=1781275988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AQEYz+Hxtfq15tCqRrunz/Be0bmJ8CYHlt5C2sRVJQ8=;
        b=jrI9fmqjRX4U6SIidTf0TLGV3SLMnV9tHiWFUSSV6K2gXFLBx0swxvycUn0FIjjpEB
         C/GbQf0ORtnuiJdIh95jo9UOhyT/ePn+Tq7GPeuin12thBJAAz0RRxAILV8JZ75kfMIk
         oofp1WGk1zAbfRZ8jrqnO/MWBVWKyGjpC8n0ttX6MY+gxq4+7ERyT2wWyAN45ldhNKTk
         co/zrvMiO+1TahrX6YAuNURp+Kdc727fH09ws5Ncg/YpBDNVM6tpGD9RKpHTKx44VwrG
         HRhOn6yDN4Z7JPtQvhUmc8X9NHYq3vpkp4eJ6rIE8xx0bLYBw7qcFbqmFFWTs0ZFZus4
         QA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780671188; x=1781275988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQEYz+Hxtfq15tCqRrunz/Be0bmJ8CYHlt5C2sRVJQ8=;
        b=bVNSuPKtz/Wrv0ZdxUGlPSWwyYqXS2Aafshs68BzQ1G+qx8TkFpZ43qdstaLOHMNOz
         tyCyv2QiGunIR6sRdNwH1RcrvvblnvQv8lu5b/Yamfj4PTADZvvGB2KLvGMOVprcfK9I
         a/QoxFSGK41tkDWz5h5IsvknphUIVJ2gNFD/64ya9Cy+PKE+BMTcF0Xsf9LT7gkxc8DK
         cRVmtXbM1QcyJUiAdApY7TBUwc6EUNvMQTpMxWROLU2820FPq52rysfBUWSPUQlJEcSg
         KT0tuTKFAAV6jOJS7qiLEcYdGinQfeIDo3wVGMT/6m/VG3DXo8AZigiK9Vf7ZxCY2JHx
         ijGw==
X-Gm-Message-State: AOJu0YwN8IilMkUHaWNBRtxTIIomLzLJDHBFt7WrLqE0q0KhT3+2sW5D
	NbRq4L6SayhsB+pe1SK0qg5T/1nKib/qki9qIH2g1CZXz73oWaC/2mWe
X-Gm-Gg: Acq92OG9mn6LnGcAXKiBy/kCvIoQp9eF72UlOb8AU8wGZns+0mOXOkLrragNRet29jQ
	9P8BGWT0L4OxZ3V4INa5ipa79W88T5EKo6qJEZet4c1+8oIQv+8tSOWQBfGus90aYBK36qp+fIV
	KpIxd6YURP5MuNzf2tpGR7cLZkfWPBKTSmoJAnibsEdpNq9u6pywosQf/W64+XoMKZVLfhzoq+n
	LB1KrY3Up4Bz7Ty3nZFdyPgJFcReyGSl3gJR+kcPD/VuHDht3qW4MfS8b/wJ5CZBsWGhY0l95uS
	Vrvm9FxTDhMWsPXmSari1jTvzX9w2GdeJiM5tPTcyEC8tbVtxdYwoQvy2IxFKGOnFWqbtRwiHr1
	/F9iqAqc5e5DrkUxIfczMn7lFzRl5KEQtKxX/CNiP0lAKh6R0IcywYQpUiAtj31FiaeV9KrkdCo
	91RfWuPqRVTx1OxefQYDM6lHxy1o4=
X-Received: by 2002:a05:600c:a009:b0:490:6869:ef13 with SMTP id 5b1f17b1804b1-490c25d4cd3mr71941105e9.14.1780671188225;
        Fri, 05 Jun 2026 07:53:08 -0700 (PDT)
Received: from krava ([2a00:102a:500c:91cf:1ba6:923d:a12b:976d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d2f22fsm26508075e9.1.2026.06.05.07.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 07:53:07 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 5 Jun 2026 16:53:04 +0200
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	memxor@gmail.com, daniel@iogearbox.net, eddyz87@gmail.com
Subject: Re: [PATCH bpf-next] MAINTAINERS: BPF: Add self as reviewer and run
 parse_maintainers.pl
Message-ID: <aiLi0CGUza3NLdnL@krava>
References: <20260604184252.9917-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604184252.9917-1-emil@etsalapatis.com>

On Thu, Jun 04, 2026 at 02:42:52PM -0400, Emil Tsalapatis wrote:
> Add myself as a reviewer for the BPF subsystem. While at it, run
> ./scripts/parse_maintainers.pl --order and reorder the BPF-related
> entries in the file accordingly.
> 
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  MAINTAINERS | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index afae76600fc6..87ac5cafb55b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4811,12 +4811,13 @@ BPF [GENERAL] (Safe Dynamic Programs and Tools)
>  M:	Alexei Starovoitov <ast@kernel.org>
>  M:	Daniel Borkmann <daniel@iogearbox.net>
>  M:	Andrii Nakryiko <andrii@kernel.org>
> -R:	Martin KaFai Lau <martin.lau@linux.dev>
>  M:	Eduard Zingerman <eddyz87@gmail.com>
>  M:	Kumar Kartikeya Dwivedi <memxor@gmail.com>
> +R:	Martin KaFai Lau <martin.lau@linux.dev>
>  R:	Song Liu <song@kernel.org>
>  R:	Yonghong Song <yonghong.song@linux.dev>
>  R:	Jiri Olsa <jolsa@kernel.org>
> +R:	Emil Tsalapatis <emil@etsalapatis.com>
>  L:	bpf@vger.kernel.org
>  S:	Supported
>  W:	https://bpf.io/
> @@ -4826,7 +4827,9 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
>  F:	Documentation/bpf/
>  F:	Documentation/networking/filter.rst
>  F:	Documentation/userspace-api/ebpf/
> +F:	arch/*/include/asm/rqspinlock.h
>  F:	arch/*/net/*
> +F:	include/asm-generic/rqspinlock.h
>  F:	include/linux/bpf*
>  F:	include/linux/btf*
>  F:	include/linux/buildid.h
> @@ -4838,17 +4841,15 @@ F:	include/uapi/linux/filter.h
>  F:	kernel/bpf/
>  F:	kernel/trace/bpf_trace.c
>  F:	lib/buildid.c
> -F:	arch/*/include/asm/rqspinlock.h
> -F:	include/asm-generic/rqspinlock.h
>  F:	lib/test_bpf.c
>  F:	net/bpf/
>  F:	net/core/filter.c
>  F:	net/sched/act_bpf.c
>  F:	net/sched/cls_bpf.c
>  F:	samples/bpf/
> +F:	scripts/Makefile.btf
>  F:	scripts/bpf_doc.py
>  F:	scripts/gen-btf.sh
> -F:	scripts/Makefile.btf
>  F:	scripts/pahole-version.sh
>  F:	tools/bpf/
>  F:	tools/lib/bpf/
> -- 
> 2.54.0
> 
> 

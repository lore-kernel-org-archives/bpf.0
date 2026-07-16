Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694DD40A933
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784203897; cv=none; b=kgu7HdMu3LdHIqTo+mwlUDTEcuhbLGPqFHbCt/XndPTQi8n9Nk3nOWu2+dbCfffnYC2d5X7FEF762PxKZhyenEuzmOjLJ2FLVpUoGD7lIYp9v0OWfrGXDQUp4CKUQp69J+0x/G0y2+EThTs2sO3EsSuwFM/e7mlEW8q4ScBPf3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784203897; c=relaxed/simple;
	bh=f4ymZDRnM/pw2VyZ1qu8vLFhL7O6J9NcYCmD2FxFklc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcwbSvd31ZavKvk2ZLXIIOuqcpxbvSH/wqas6xKJPY5kL7GsGnTX7ArR930hZKsvZdd2kmv4+crydbw3oYaJrSkBOSSKZrt32ETKQeA6NEBSnTsQqPIynA0Q7SnIBFE8zWubvysOCh0wDgeOFn/RK+xoQNd64mHZ2APzz6FF6Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUjHL2SR; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUjHL2SR"
Received: by mail-pj2-f4.google.com with SMTP id d9443c01a7336-2cc6207127aso31975525ad.1
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 05:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784203896; x=1784808696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G03SpxBcPbiMEuaQ6fjP36nhBHuuXkxtx53kuYQhpfE=;
        b=lUjHL2SRpkAruFw6Y6T9UbM63Jp4clqBBo/TSQgT7ZiTye/Q70Om7BleTRY3pk7FCW
         9BGrAp7mO6Qf5rrfxlu1gEx13S9N2TCZMxA4PTPZqI6ritGU8NAjQr+4dFoFs3esaFQy
         oJOMthyh+Mn3cZ7/ZuoYE5IkplCj0pY0/O+wfBiZdh5ZPmrhe80rwB+QyNQ6FU2xJZ5Y
         HR6eFQWSvn1K4EKcY1lI+mxCYGMkj6LbFQjeE/nRnvYOPkjmCt/o1vFRJd9qqyp3q1SN
         GX56nIcQ/+QWxefy591uLeibSxonzgXkfD0pTdlB0hRK5JVFHklG4q1tJJwLYvgH6P2F
         u3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784203896; x=1784808696;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G03SpxBcPbiMEuaQ6fjP36nhBHuuXkxtx53kuYQhpfE=;
        b=UV/qgBMkFHzDMDbEflFmS0MYstbed2ojrLTe/LrNCvKYqjZrt0QoQQooE4fgLlTyrn
         tBMkuOp4iLolj57j92vvqau2yQfK0lb2Hlvve6s80yBImt/2YnTsuyzR+ccVYBjf+sqD
         r33jCdjC0Jh/XrHQvfKP4uXZaicU0QY9Z/8J+hJBJCExiRcqFaE36EkGKaW4AhhBbnem
         wH1h0E/cK34cxG4eCaQq0K3JB/U1qUwcLvI7LDHq9/vz519efNcAodGdpxOogLRwxcla
         hfaIA2G2J6PTSAXDfHkCDrfTRhxLTSzfu9shIIufjH8CxgQ63qk/zkMgy+I/mwqRgC6J
         BL1w==
X-Forwarded-Encrypted: i=1; AHgh+RrDWZOvMGgLApq+OaDTqchDhRJoTD4+qyWl9paaXlpWRQmc3rRMar7b5NI/PFNu0JIdaBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/4leg4yUf1boNHGetJvl0bt5HW9yjFsqfrMuGW/0C9Gp6RTxp
	+8z1YHfTtDv7Wy1sQVJhm7DbtP+TQElAaY36Hw2ewP2tfWRixuk6+ID1
X-Gm-Gg: AfdE7cm7WsoAPgS6WDqdgigXfTtvqesp5y53y1vmkDQSpJAvc65IlV1Qj25RurdAVAv
	pmV9J9eIaIR7MPK58i3JlzxpGQguMEUGMVH7OzZ0K9nUcD09U1ebRLBWLAtzAk4R/1KBAJZEJXY
	dlO/9Wk0sSxMyt1L0CnnHBGm7vjJwN4CRD53AmNxR7HISjorh6wWuSEhSocsZ8lBib9E3V81+Kp
	YDRI2x1HMAPorffB4uxMuYzhDfn73heX/KbBLX7FZfITW8Sp/CYDJpw8HFoqvqnMibCdhj5sTzZ
	AXGga/MAMUL4Q1tE8Tv276BY5aEieh3DI9UveaiRal+REemsijmQCx0x1I6SzPZo1E4PkpWPel4
	PJeyl3JXo+CEtGBV5j7d5lWR73H8mI5MUmVpvudxUUQ1kc9y4bWvzotVWI7oNfE+UoKw/c38=
X-Received: by 2002:a17:902:da81:b0:2ca:e19c:986 with SMTP id d9443c01a7336-2cf03c7c756mr62714505ad.1.1784203895554;
        Thu, 16 Jul 2026 05:11:35 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:46::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf106b271asm19005705ad.64.2026.07.16.05.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 05:11:35 -0700 (PDT)
Date: Thu, 16 Jul 2026 05:10:12 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com
Subject: Re: [PATCH RFC net-next 1/6] bpf: Introduce per-packet metadata
 storage for BPF programs
Message-ID: <aljJ1u-_1CBBF8Ha@devvm7509.cco0.facebook.com>
References: <20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com>
 <20260714-bpf-meta-inside-skb-ext-v1-1-5871c07a8dd6@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260714-bpf-meta-inside-skb-ext-v1-1-5871c07a8dd6@cloudflare.com>

On 07/14, Jakub Sitnicki wrote:
> BPF programs attached at different points in the network stack have no way
> to pass data between each other on a per-packet basis, other than by
> stashing it into a shared BPF map. xdp/skb->data_meta works for XDP-to-TC
> handoff, but is not available to programs running at later hooks like
> cgroup/skb, sock_ops, socket filters, tracing or LSM.
> 
> Add a new skb extension (struct bpf_skb_ext) that provides up to 256 bytes
> of per-packet storage. Size is configurable at build time though the
> CONFIG_BPF_SKB_EXT_SIZE option. The storage is embedded inside the
> extension chunk itself.
> 
> Expose the storage to BPF programs via bpf_dynptr_from_skb_ext() kfunc.
> The caller passes BPF_SKB_EXT_F_CREATE to allocate or COW (unshare) the
> extension and get a read-write dynptr. Without the flag, it gets a
> read-only dynptr to the existing extension, or -ENOENT if none exists.
> 
> Guard the feature behind a new CONFIG_BPF_SKB_EXT option.
> 
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
>  include/linux/bpf.h      |  10 ++++
>  include/linux/filter.h   |  26 ++++++++++
>  include/linux/skbuff.h   |   3 ++
>  include/uapi/linux/bpf.h |   5 ++
>  kernel/bpf/helpers.c     |   7 +++
>  kernel/bpf/log.c         |   2 +
>  kernel/bpf/verifier.c    |  10 +++-
>  net/Kconfig              |  20 ++++++++
>  net/core/filter.c        | 129 +++++++++++++++++++++++++++++++++++++++++++++++
>  net/core/skbuff.c        |   3 ++
>  10 files changed, 214 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 7719f6528445..6b918a5b61bf 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1484,6 +1484,8 @@ enum bpf_dynptr_type {
>  	BPF_DYNPTR_TYPE_SKB_META,
>  	/* Underlying data is a file */
>  	BPF_DYNPTR_TYPE_FILE,
> +	/* Underlying data is a bpf_skb_ext chunk */
> +	BPF_DYNPTR_TYPE_SKB_EXT,
>  };
>  
>  int bpf_dynptr_check_size(u64 size);
> @@ -4209,4 +4211,12 @@ static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 all
>  	return 0;
>  }
>  
> +#ifdef CONFIG_BPF_SKB_EXT
> +
> +struct bpf_skb_ext {
> +	u8 buf[CONFIG_BPF_SKB_EXT_SIZE] __aligned(8);
> +};

Can we do a dynamic size from the start? Say, some sysfs knob, 0 by
default. Once written, it's locks in the size and can't be changed.
Then your new 'flags' field can be used to indicate whether the area
actually has been allocated or not?

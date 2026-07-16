Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC6F41B8E4
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784203899; cv=none; b=StqhPxpmo7ZF4iXYuXWyqIXNw1XOvWdRnZJLq50toYXCOhTqHYlcbFJnBIOimUwoZ3lo/TE3p6PQ3Ib4+bgt9veMx6ooFc/2v/0U/NQgOS6smVJv1ffDzmbF9LxGjqMDFwolJMlfDERLgtHXJl8/gXO4NICdZyzP/2RkcauVrus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784203899; c=relaxed/simple;
	bh=ficmtKuo7z7vZ8G39pNmXFCtmwsRKePX95J90ttlbg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtKeReQcrKhx87IIUWTojX9v+cWSXeURDdQ4Tbk0w5nspajrgIQALu/qj85LeM886hhKg+ztxOgxFhpjVe1aJkWIGOPDkM0mRPeQ5Z2KhYF7vdeVdJ4ViTyt09bIIhZsh3y4faatIOIZhZwO1K6CGC1+tkzsXDKRtnIKa34AcVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTIor5XP; arc=none smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTIor5XP"
Received: by mail-pj2-f3.google.com with SMTP id d9443c01a7336-2ce7ac92dfcso25349955ad.1
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 05:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784203897; x=1784808697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W6mgtFDEnWRLf8qUl6KQcn7fDeFTCrbz36aB9g0zHLo=;
        b=NTIor5XPrvQFsSFa8q2AU/l83sBKGnAlCVivydJu4+WGIZjnhISkTZNCtpXtcJLk7C
         TGjtikdtSuctZ3G4huI+0hVFeDSqgWp8i3HKyaLnaohgs4erMyx7Rcu2FP29RXwpd/xL
         a3GuijaHV67fRLwLYYaiEYkec9Dk187KSKb3+fkrzzdYuD2C1RycQhsQVods7KFV6PpY
         2qAi0ApvB18mAXNqB110BmvJZh2/vwFc2+Y5IvD0t8bkbpnAjroUExYVMzJfYx065I9H
         QqWe4PBkxiAgOTcIOIfOw1j3wdjbSqMNgKgAnuUNivQhh7QvtEjS/fSJE+0AU6+xeHyv
         n6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784203897; x=1784808697;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W6mgtFDEnWRLf8qUl6KQcn7fDeFTCrbz36aB9g0zHLo=;
        b=BewNSgHjklv2hZua2NNXb8eT72KqyHujEVc7dG5gbDAbefR9yGyToPTfX4seQpK8ll
         8RFPimOoqbDmi1pdK1lVeWeppG57pb9b1mZPL91pywfVgE79BjB/3U2CLlguvtIjAML4
         qZlbjiFvJCsEqrgv47eyUH++JQVyQlniUsaY3UUgQ6jmbQev+f/kYmaAu0jEJjqAzfTr
         l/l7E4Y4B/Bq6TLBwyeZvF7a+AJ/Oe1/SMv4/QichwDiRP1rCpW7HhPha+aymULjk8aO
         rpmwwNFWArTEGNJ4+9mtPMWdtrkzFVqOXuIloSd/5+Z3aNOwYuLS27qGLNiR3FBTwg4U
         HApA==
X-Forwarded-Encrypted: i=1; AHgh+Rrp/XWkJApiFl/0XSD3XSpDjmdOQsLqrgbFHy+cub64fyfGY2N2KULDbMX+mD26dJPCtuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4mYHHdPGXTy5r72aRA73v/qp/xV8p8EVoTcxe8vrJzqQKjy+1
	qrOshrXBLV9A9ieTzIgSpn9uSd9LD1K2hW/uNXDaex3pHpD3pbE10TQH
X-Gm-Gg: AfdE7ckvrsqanCSC4NHlIAHYrT1aAwxSUfYf1KJAEyJNkX13E7t6AUbyiKxIpgCTRWq
	+mRlMUNvb/fvih6D2eqIe4Bao734TkBXAK0lgC0g1EDUS62AH0BiJ7mWmm598Qa/8zha1UW5r6m
	br5WrPR9R0g5bT5AjwWxJLFp38SSbO/15ebyn6qjhK8OFGil0aKag1mCx9rhOGeQ/dzjEsNLcVP
	jfh+VcufPQb5fcNGGX2zM0+m2f10daPgIQZS80/6CoBqDO8y7TxxlG4cW37D7v23piyiItP+FP5
	TsO+udYrKqMcTd4Hle3njxpvpD8I0zqDrCeLgHdz9/MuF46P5/l3W0zkCy8t2Xwk2aWE/bHuTGa
	zzQvVXr9+ND4jB4qg/bcsIRA6mVh5RQpzOOsA14XdJL0KB0vYXCuqz9X85yqT4IKVgRCdvw==
X-Received: by 2002:a17:903:3885:b0:2c8:1c05:16aa with SMTP id d9443c01a7336-2ce9e9b0f2dmr221502645ad.19.1784203896731;
        Thu, 16 Jul 2026 05:11:36 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf106de4b7sm19146975ad.69.2026.07.16.05.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 05:11:36 -0700 (PDT)
Date: Thu, 16 Jul 2026 05:11:30 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com
Subject: Re: [PATCH RFC net-next 3/6] bpf: Allow skb extensions to survive
 packet scrubbing
Message-ID: <aljKKt6nCB3fjFVA@devvm7509.cco0.facebook.com>
References: <20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com>
 <20260714-bpf-meta-inside-skb-ext-v1-3-5871c07a8dd6@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260714-bpf-meta-inside-skb-ext-v1-3-5871c07a8dd6@cloudflare.com>

On 07/14, Jakub Sitnicki wrote:
> skb_scrub_packet() drops all skb extensions unconditionally via
> skb_ext_reset(). It runs on tunnel encap/decap (ip_tunnel_rcv,
> vxlan_rcv, etc.) and cross-netns forwarding (dev_forward_skb).
> 
> This makes it impossible for a BPF program to pass metadata via
> bpf_skb_ext through a tunnel or across a netns boundary. The extension
> is always lost at the scrub point.
> 
> Introduce skb_ext_scrub() which consults each active extension before
> discarding it. Extensions that request preservation are kept while the
> rest are torn down. When the extension slab is shared with clones, COW
> ensures isolation. Replace the skb_ext_reset() call in
> skb_scrub_packet() with skb_ext_scrub().
> 
> Expose the opt-in mechanism to BPF via the BPF_SKB_EXT_F_NO_SCRUB flag
> for bpf_dynptr_from_skb_ext(). A program that sets this flag when
> creating the extension signals that its metadata should survive
> scrubbing.
> 
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
>  include/linux/bpf.h      |  1 +
>  include/linux/skbuff.h   |  2 ++
>  include/uapi/linux/bpf.h |  3 +-
>  net/core/filter.c        | 11 +++++--
>  net/core/skbuff.c        | 82 ++++++++++++++++++++++++++++++++++++++++++------
>  net/ipv4/udp.c           |  2 +-
>  6 files changed, 86 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 6b918a5b61bf..a46ca53c5b27 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -4214,6 +4214,7 @@ static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 all
>  #ifdef CONFIG_BPF_SKB_EXT
>  
>  struct bpf_skb_ext {
> +	u64 flags;
>  	u8 buf[CONFIG_BPF_SKB_EXT_SIZE] __aligned(8);
>  };
>  
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 584d8440d352..66afa5489007 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -5063,6 +5063,7 @@ void *__skb_ext_set(struct sk_buff *skb, enum skb_ext_id id,
>  void *skb_ext_add(struct sk_buff *skb, enum skb_ext_id id);
>  void __skb_ext_del(struct sk_buff *skb, enum skb_ext_id id);
>  void __skb_ext_put(struct skb_ext *ext);
> +void skb_ext_scrub(struct sk_buff *skb);
>  
>  static inline void skb_ext_put(struct sk_buff *skb)
>  {
> @@ -5132,6 +5133,7 @@ static inline bool skb_has_extensions(struct sk_buff *skb)
>  static inline void __skb_ext_put(struct skb_ext *ext) {}
>  static inline void skb_ext_put(struct sk_buff *skb) {}
>  static inline void skb_ext_reset(struct sk_buff *skb) {}
> +static inline void skb_ext_scrub(struct sk_buff *skb) {}
>  static inline void skb_ext_del(struct sk_buff *skb, int unused) {}
>  static inline void __skb_ext_copy(struct sk_buff *d, const struct sk_buff *s) {}
>  static inline void skb_ext_copy(struct sk_buff *dst, const struct sk_buff *s) {}
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 3eee4467422d..02da170205de 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7734,7 +7734,8 @@ struct bpf_insn_array_value {
>  
>  /* Flags to control bpf_dynptr_from_skb_ext() behavior. */
>  enum {
> -	BPF_SKB_EXT_F_CREATE = (1ULL << 0),
> +	BPF_SKB_EXT_F_CREATE	= (1ULL << 0),
> +	BPF_SKB_EXT_F_NO_SCRUB	= (1ULL << 1),

Do I understand correctly that you do prefer the NO_SCRUB mode? Any reason
we need to have scrub mode? If it's all produced/consumed by bpf, maybe
we can just carry this data unconditionally instead of having a SCRUB/NO_SCRUB
option?

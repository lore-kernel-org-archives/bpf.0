Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D4F400E0D
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787759025; cv=pass; b=roYB9lg5qfw8A8WpNvRKRXaJ2z0LEgBzuzzegfndNczh7J1r4hpZCo4zTqtMWAm60PgtGo23cfLAshvtUtM65aOcYPMqA8tKIBewtaqEzOU41sssH1em3XIzYTfd7Dubv52SgEZIX97yXSvHaF+/4rezYeybuZa96UogiKX5HiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787759025; c=relaxed/simple;
	bh=t+UZJG+GzsSQuOgLA31dorYvO2F8pVYT+Y4HWV4K/Bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2e4lht39fkwwXABu+oXZO/0pKDGyTL0snzV77m4eaSM0LHcB2CHifhcCnli/j1ConLcdKkrg20IbKv3CxYWSKh5TOtwIrZB6rpRtB9qQk/YwG9jri0UHBCfX5BnUkKaq74RtWRHxNTktBM2aB9z0S6QJV09yJvSBSU1atdUCgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sq08v3ls; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sq08v3ls"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-52f1a320162so2573101cf.2
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 08:43:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787759020; cv=none;
        d=google.com; s=arc-20260327;
        b=TLr23NhWxA1cS6i5L2IwZYelrlGqW0W/pOcsUWkkqTIwqKJLPSPKAdPm5ZtFsvmccm
         1AHw+6AlnnEWz0vAJUhcCB+/ULhxAoErDpkHQsnNqA3hzRS7yOlvyE41vttxPCJBDV1C
         FbXg48q4/4KgckSTi84AwZPYpatU+9OZaO5Tb4Lb5dfv1k/jc/+WZyYltJ/S5UlxLfKa
         MvNz8UtPOmxs75VzQ85AquG5bwVZfu3aoIghTQWNuES7h9GLPKudFx4hKATc5rl0eoln
         hYhueR/WL34jG7W98x5xpyTz+GBFTIqxehICSSdVj/1MgFCgnEtvrD1yWqYTE5a5MPFY
         gaAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UVSjhIziBnajqA7H4PUHZrhD1u9T6d8YmCozPYiqoT4=;
        fh=FoAOeS+ex0ebq/rg62KWWKAztsoxE7wJvgXuDWuy8ZU=;
        b=Shx0sZN1CM+KVN3I8d1g38sOAn34UeganBEIMKvoo05IzoTHt10sPZvd7u6BP/oxm1
         6gSnx0e/o/CXnCwiKBNfkAP+R9AiRXc0EMZ6F3KV0TgULNM+MozTRZy6sJnlv5zsDIwj
         0Wqwh+mDgdLAPMBZT/yQeXIYvEwBjCt0F605ToeFUKW38K2tLjmV9a9S9mrlej1HtRxU
         heooX9iTlW/bCBJOteAjsXqO+LdV0TEKzo/MZSRQMEdso0Q+sCah/MVFLS2vEbZqUkXy
         ALPoDOiA3ye8ZhYzmzz+jEiPjjx9I9s2DeV9gqrfDe65rqtO7tf7MSplvVtRaeUbXA81
         OPEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787759020; x=1788363820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UVSjhIziBnajqA7H4PUHZrhD1u9T6d8YmCozPYiqoT4=;
        b=sq08v3lsVH1MUXBCYBCk+GmN3jJsBgpTgxTV9kvMCJy24rFlGhmv6zRYHL2E/GnWvV
         L4YCrmvdMQpFlBnCeUs6xMZR5r7lnAQbYUzki5lLAMqeIf20eQDnXuhjjm7rFfxIeOeO
         1LvuwkbHU3sPG4/3I5FwkRe89FK8Jk2iRkta+7sZud2GT/nvMNmaSMz1G9YWkQDAnRtn
         rMm0P2zYz3djEBL2fSIPTvKtik1D1qaZLRbW3O/ctNId2HomrvHulnxXQBPV4OSk1Yg9
         O9DuxOkS5sk3k2TqOsKiAo1mDI0zXFGPBBaXBqHlZGJpiV2YYcCFpxUGi0/RPARDJ9oL
         ZvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787759020; x=1788363820;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UVSjhIziBnajqA7H4PUHZrhD1u9T6d8YmCozPYiqoT4=;
        b=QGfnRu9fNno8HRQN3L2q0UPpGWrGKOWGD/iU9d4he3tTYiFpziHLr0Hndu18XjbrC7
         +zV1MosT2Hz0uqcmwUnevAvwy8tqLeruDmGamtpV4KGdSIYjiks+WorWLOVoY3SC+uBK
         0o0+/5n1vN5HV+OSiQHse4rMrCpJqZvfxGzgJgPQ4LDoRIClseBUsuPrRTZxjaM6yyBY
         4QMOKqbEF8YzPjJ6IGOsjt/kSCWvZfQcuPzeKN8hHfY05ZEsSA64Nx8uL45aaUt1aHby
         xIx+w+yw7lcc2XpEPhgijiyWgFHI2+Zz/u2nKAzyhsaENFL9GW8ApizNmOTf2vsrx6mV
         lCHw==
X-Forwarded-Encrypted: i=1; AHgh+Rp8WJokdNHwO2aK+mBBoVTHk1Q1oIoePi385rX2HrZFhyz+VvDO9HwuTqpFXFk0o5VYsBM=@vger.kernel.org
X-Gm-Message-State: AFuF++l7CHVPVy6WM50kvYfRC1RV6o5JjWMFdWkTSscacnscwicbGXna
	786OaEiyOjKlCLVSC4X4L6Y09qmsFF87/KimWdMV1oQReZRu2Q5WmO3Ixxlw/18eGRNWpeBupf4
	9iYPeHUzyfakk0iJBCOtgfxqtG5pBGF/jCZqwdHnv
X-Gm-Gg: AR+sD107pa7l7Tm8IXoPSLjHrv2+w4G3Vz3UNKQuu577BmhLSsJeAkscUk9qXFJUeK+
	P9YRtfbLpnwBT/6OGJc/P11NUMjUAUpNZ7Ny1f0RQi2dxiw+uD8aKRjJfEidsBewgKOSikFGlB6
	ffesC2XhkDU98nDtUBHd9+Z3QpuEp+D/rUD6KPkn6EzzbkwdAMRdEO5ZBpiNyDt8MBUa5OmJZQM
	bzBhZH82MYGLrtTi866ExNnKhFV+ij0DnaL9y4yIrSBwIWeQ3Jw+z2JPY7WTWU+vHPUo5U0AJDQ
	owtEIMj4gG+RY7OfyHpyxbboDtKoeg08wkjnXvTkkq9Zxlm8Fin6DW9OdJemM741mUF6wOhAQO8
	dLnr3SVi2/YLBMItrqsZNY6KuMqoZ52haetPoH1rRW0Bxvalc7RwMrcoD2wE=
X-Received: by 2002:a05:622a:1e15:b0:52b:4c5a:5844 with SMTP id
 d75a77b69052e-52e4232333emr81680181cf.20.1787759019324; Wed, 26 Aug 2026
 08:43:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826135252.3091193-1-florian@schauer.to>
In-Reply-To: <20260826135252.3091193-1-florian@schauer.to>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Aug 2026 17:43:25 +0200
X-Gm-Features: AcwNN1UPcaNMSfJEESXZg0-2cY-GKNHw_shclvxV2PmWjE2AEs75WcK4lyzHWtU
Message-ID: <CANn89iJ7p5P-Ryufr1MBCcYEnzDTMBJbLjNiTNGsVuktMNQOcA@mail.gmail.com>
Subject: Re: [PATCH net] page_pool: keep frag_offset aligned for odd-sized requests
To: Florian Schauer <florian@schauer.to>
Cc: hawk@kernel.org, ilias.apalodimas@linaro.org, netdev@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 3:53=E2=80=AFPM Florian Schauer <florian@schauer.to=
> wrote:
>
> page_pool_alloc_frag_netmem() rounds the requested fragment size with
>
>         size =3D ALIGN(size, dma_get_cache_alignment());
>
> dma_get_cache_alignment() returns 1 unless the architecture defines
> ARCH_DMA_MINALIGN, which DMA-coherent architectures such as x86 do not.
> There the ALIGN() is a no-op and pool->frag_offset advances by the raw,
> unrounded size.
>
> A single caller asking for an odd size then leaves frag_offset misaligned
> for every fragment carved out of that page afterwards.  The pool is share=
d,
> so the damage is not confined to the caller that caused it.
>
> The per-cpu system_page_pool used by generic XDP hits this.
> skb_pp_cow_data() allocates data fragments with the raw packet length:
>
>         size =3D min_t(u32, len, PAGE_SIZE);
>         truesize =3D size;
>         page =3D page_pool_dev_alloc(pool, &page_off, &truesize);
>
> and later calls page_pool_dev_alloc_va() for a new skb head, which
> napi_build_skb() installs as skb->head.  Once frag_offset is odd that hea=
d
> is misaligned, and so is skb_shinfo(skb) =3D=3D skb->head + skb->end.
>
> struct skb_shared_info begins with an atomic_t dataref, so the increment =
in
> __skb_clone() straddles a cache line.  On x86 with split lock detection -=
-
> fatal for kernel split locks by default -- this panics the machine:
>
>   Oops: Split lock detected
>   RIP: 0010:skb_clone+0x154/0x1e0
>   Call Trace:
>    <IRQ>
>    raw_local_deliver+0x1ed/0x2c0
>    ip_protocol_deliver_rcu+0x54/0x1c0
>    ip_local_deliver_finish+0x85/0x100
>    ip_local_deliver+0x67/0x100
>    __netif_receive_skb_one_core+0x85/0xa0
>    process_backlog+0x87/0x130
>
> Reproduced by attaching any generic-mode XDP program to loopback and
> opening a RAW IPPROTO_UDP socket, which makes raw_local_deliver() clone
> every locally delivered UDP packet; ordinary DNS traffic then triggers it=
,
> roughly once per 2500 clones.  Observed on 6.12.101 and 7.1.8.
>
> Tracing page_pool_alloc_frag_netmem() over one such run shows the
> amplification -- two odd-sized requests, nine misaligned offsets:
>
>   requested size & 7:   0: 17035    5: 1    7: 1
>   frag_offset & 7:      0: 17028    3: 1    4: 1    5: 1    6: 1    7: 5
>
> and skb_pp_cow_data() returning heads that were aligned on entry:
>
>   head 0xffff8f4c86aeac00 -> 0xffff8f4c53a9a9c4 (&7=3D4)
>   head 0xffff8f4d6a8a42c0 -> 0xffff8f4c4f7b7a45 (&7=3D5)
>
> Round the fragment size up to at least the natural word size so fragments
> are always suitably aligned for the objects callers build on them.
> Architectures needing a larger DMA alignment keep it.
>
> This also makes the remainder computed in page_pool_alloc_netmem(),
>
>         *size =3D max_size - *offset;
>
> aligned, since max_size is a power of two -- which fixes the matching
> misalignment of skb->end.
>
> Verified with a controlled A/B under QEMU/KVM: same tree, same config, sa=
me
> compiler, same rootfs and identical traffic, differing only by this patch=
.  A
> SEC("xdp.frags") XDP_PASS program on lo plus UDP datagrams larger than
> max_head_size drives skb_pp_cow_data()'s fragment loop, which passes raw =
packet
> lengths to the pool.  Measured at the return of skb_pp_cow_data():
>
>                           unpatched   patched
>   skb_pp_cow_data calls       40800     40800
>   misaligned skb->head         1120         0
>   dataref at line offset >60     80         0
>
> The last row counts the accesses that actually fault: skb_shinfo()->datar=
ef
> sits at head+end+0x20 and is a 4-byte atomic, so `lock incl` splits a 64-=
byte
> cache line only when that address lands at offset 61..63.  All 80 occurre=
nces
> were at offset 61; the panic reported above was at offset 62.  Eliminatin=
g the
> misalignment removes every one of them.
>
> Same class of bug as commit 3bed3cc4156e ("net: Do not allocate page
> fragments that are not skb aligned"), which fixed the older
> netdev_alloc_frag()/napi_alloc_frag() allocators.
>
> Fixes: 53e0961da1c7 ("page_pool: add frag page recycling support in page =
pool")
> Signed-off-by: Florian Schauer <florian@schauer.to>
> ---
>  net/core/page_pool.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 1234567..89abcde 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -1065,7 +1065,14 @@ netmem_ref page_pool_alloc_frag_netmem(struct page=
_pool *pool,
>         if (WARN_ON(size > max_size))
>                 return 0;
>
> -       size =3D ALIGN(size, dma_get_cache_alignment());
> +       /* dma_get_cache_alignment() is 1 on DMA-coherent architectures, =
so on
> +        * its own it cannot keep frag_offset aligned.  Callers build obj=
ects
> +        * on these fragments -- skb_pp_cow_data() turns one into skb->he=
ad,
> +        * where skb_shinfo() must be aligned -- and the pool is shared, =
so an
> +        * odd-sized request must not skew every fragment that follows it=
.
> +        */
> +       size =3D ALIGN(size, max_t(unsigned int, dma_get_cache_alignment(=
),
> +                                sizeof(long)));

Perhaps the comment would not be needed with something more descriptive.

size =3D ALIGN(size, max_t(unsigned int, dma_get_cache_alignment(),
                      __alignof__(struct skb_shared_info)));

Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC483A452A
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773741868; cv=pass; b=UWR0MxBeoT8uHIXyLxBOwXhIL7XYAwxeqwfjVUiF9O7Y5YG6kwxKK5+WHYsQrF85xUKQb2ygbv7UebOJLt4m6svBGpsSIHKJfSS81sCg57lMVFaWpaOmZhif2DCFSUO/omyjxH69unkiVMcCVLvcorGJFhDJ30WNdRlVBL0CSCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773741868; c=relaxed/simple;
	bh=VMcaJiK0n+Mh3FmYhue0PD5uIx7SxJhXZnJ+mVJvuvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mcKTER1EJdZNT6YOwOXaHPQYvsch0HeJZOfj7OXLYUEWPi+BLnBbZ3PKncy+QOMZMhHLAx6vVPw+8Cwwbm/Cc+n/x/QFgu6IQ+xVU59EYx7K1trxICGq7ltfiVcFmH0Y6hIWxniUpusboiiuBZjVB/blmazBTZDjwEaNi8dv4HY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p0Bg2Nmm; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p0Bg2Nmm"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64ad9238d8fso6318901d50.3
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 03:04:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773741863; cv=none;
        d=google.com; s=arc-20240605;
        b=Z11lhQ2tzYw8LrhcL8sdQFIip1GMjd6vlh8DFajP1macESmtvIa5Sgmv7H296URuNB
         IEi3qG/nTF4fNUqvzo74U1NnRAqngrDrqPgp6x6BEBKMDmBoBrHO377QhNmXwmjmSnMy
         iWcMAFnEu3/awzWzBJ1NvXtfiChy+S9lW0CTQfNHyiIcfCU9J6RsVFWGsn1i3Z46IIUC
         hJG6xoQo9gh9aiixQGgFNKcfHTmRHsjZyOfZNT8O79AxncVMbXJCIORuRQxmQVYc+AW2
         472eAfQq8FEiKUX9vuGHSsCQmaWaih4EiNkslmHTBYOlAMxUnTKNpq7yqtGCFYY0lBg2
         ZXPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sJ1Pc/1QKu2lLSHomCR6iKHtySw3Kp4fd1PA2wd2pgs=;
        fh=7z1N7yadSF2JiG63fnkhCzx7tGtRN1h0NKkZl29g3OA=;
        b=RFLHKeLngxCG+jJBYdKi+/7e2a2suc9/Zj8tAx8haeRSXKrcXuKyMZi2ANqmt6Y94T
         xM/KnEnrWoopF6o9ODRijcLMcQJ3suT29rdTLsZoYb9cR3QlTKuA+hvejcFxBmM6Y32T
         EHmnqMaPkpTlEBewWjGLG9ktkk4/wvt2htDpnaO5DMlEYwmboUIBol2+YFYj7Ec+bK6q
         iqtpq57JHu7Vv+3bRHEqhTawn0e4o8CNVnCvI7LIugtIr3gpMjgthxMBEUy8l74XfzmX
         fGnYLtM6U3aPK9w0N6/JfJlDZ2XDH4uMCduT22wW9zTE19Fiyx5sDRA16QFijRElh6cj
         T5sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773741863; x=1774346663; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sJ1Pc/1QKu2lLSHomCR6iKHtySw3Kp4fd1PA2wd2pgs=;
        b=p0Bg2NmmIKyboHpUMRTohcqtKsgqmTRvZ6VESwm3wzUXCUZTLvpR4pW87SLwEVZAXO
         a715hwTYDcQ66YJ5E6tCxRSczk0n8vIUf+XWJF99Dw0Ou63ItdoeBlBpZY0K+PSMqeuT
         GzR92G1MbpDNpHNgsm2UAbxHCeLxx4Cxo8oiKu80ohZ2DTt38SO3zx4YzoW9OR3xksI7
         wfFP74KJwfNquWCf2cF485aw5B6/Ex2p61WNpIjLwwoBDNyvmTYf29QePQQH5Kyrv1xN
         vnGdCFk3u5Vu7dOuyf6cZtxL8AQOaDbDMpOq4/2KoD8pDV36foKhVoAo5kuh1OaCqZAC
         +kAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773741863; x=1774346663;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJ1Pc/1QKu2lLSHomCR6iKHtySw3Kp4fd1PA2wd2pgs=;
        b=rr82BmWXeUEBzcIW4C2Ly1v6pVCbIAVGiigV0LsjeP5PNxuiTDf3+EDAwXUy8QQpyf
         e0v6/7SW5JvJ3zdjL5EBliK7tOxipxCPmziPUrxNN/06dKJrF0xNO105fQpmo26hN11a
         Vu3By0n3xuo43eQxQvHeTld+zSrm6Tewm018YI3FhCUszsRXcx++aSGTWl2xcJTPsw9z
         1FugZL3dyKhK2vMj7IFLmXZGY4jsrzP9udl8UquFHMzwjh5GiLjwmi0rZSTfquPCU4xj
         DxN+U8O3Wo/05D/h8oF1rA4TlyMy48XoqK1EpWjsdBCmMLx7C6dgTaCgBehwbGWB0mXu
         k8sQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1nFAqL0E3At6zthZiT/gcrDXpdoosyEmJQfobFsFR426gHm36NA/aIY7ZaP15hE+shg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIBwLP0R0uGsiejiLfq3frku6Nq+6bCslJWTWwzZx2X27t0TpY
	UG5flS9uBxr5LBjXYOIYxsPKiLdqeSpE8jTUt9K/lMDNu81r0RKAU1mTryY+QcYJrnETIoSi4DL
	HHLyZB010WmInzoVeb4cQeBvUDWQPVOs2a0nVRUAc9w==
X-Gm-Gg: ATEYQzwhi5KbjanE6uYdeKmJO/PErnWZWRULdVExD8py9NF56dNKW661RAvU7Z77Jl/
	AGmMvNu6DCqCuilJDtBhbkmJVUGk/AiQHe5o9g3m4psehV9u0LGb0ihs0UPRwqfhEDf1fDiCkUU
	3oO2TENJL+hGnM5TO4ZQ5jAYSf62lUEc07P98rjPxNFgCV6rYr8n+j1iHbdm2aWI1esdq5kQtmj
	R2HP2DYHy+IaZw8wAahhL2HjZHVsqPHImF3kjM3dUxYbPtqBtSWdYUaW8s2JA34yjSP3FG57WYS
	7mJi2+EYuyn9ELREKrcWjH6W8QZOM6A2cLvqtGtJGCjEELpXtz3ub/VL9EqjNJ+hYFh+/YzZtSQ
	cDaVaXjlU21E02Ao4AlHJ5Q5WJ0Y+1wFJM8eQMOGJ2b+DjUya71sQZEoE9HFxd2TAV4BSd+pgEC
	PHGxEK9BfaRC939eLhaiI9TnPvbv47FTLHXxAxpr/xg8Z59li/sOYf6owod38Fk90NMJ9qGO6a3
	yOVs8PqtCKeXpgZF1o1E8ileDzunNhHKY9s9U8sEpYw2ePM5xgoICM8hHqEPUYRLIahgAIAlFhP
	FqTp1JSj/yVz28RfTvp1fQD+rvknBTlrgkYlo3aGl/1H
X-Received: by 2002:a53:df4f:0:b0:64c:ea3d:a895 with SMTP id
 956f58d0204a3-64e6306d33fmr11868511d50.61.1773741863199; Tue, 17 Mar 2026
 03:04:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316222901.GA59948@system.software.com> <20260316223113.20097-1-byungchul@sk.com>
 <ebd00055-d4aa-4612-8bf3-ef0a308512f8@kernel.org>
In-Reply-To: <ebd00055-d4aa-4612-8bf3-ef0a308512f8@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 17 Mar 2026 12:03:47 +0200
X-Gm-Features: AaiRm50_gMBZxX2vRtFxvpOCPSPD6sNew1gAwSuCX31B_IpupUaMwz2w2jjcEa0
Message-ID: <CAC_iWjKXvfJuVn_uGgj4SsPsZnvMMepd7BesZcXgRYDPm9yUhg@mail.gmail.com>
Subject: Re: [PATCH v5] mm: introduce a new page type for page pool in page type
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org, akpm@linux-foundation.org, 
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Toke Hoiland Jorgensen <toke@redhat.com>, linux-kernel@vger.kernel.org, 
	kernel_team@skhynix.com, harry.yoo@oracle.com, ast@kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, john.fastabend@gmail.com, 
	sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, 
	mbloch@nvidia.com, andrew+netdev@lunn.ch, edumazet@google.com, 
	pabeni@redhat.com, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org, 
	ziy@nvidia.com, willy@infradead.org, brauner@kernel.org, kas@kernel.org, 
	yuzhao@google.com, usamaarif642@gmail.com, baolin.wang@linux.alibaba.com, 
	asml.silence@gmail.com, bpf@vger.kernel.org, linux-rdma@vger.kernel.org, 
	sfr@canb.auug.org.au, dw@davidwei.uk, ap420073@gmail.com, dtatulea@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hi Jesper,

On Tue, 17 Mar 2026 at 11:20, Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>
>
>
>
> On 16/03/2026 23.31, Byungchul Park wrote:
> > Currently, the condition 'page->pp_magic == PP_SIGNATURE' is used to
> > determine if a page belongs to a page pool.  However, with the planned
> > removal of @pp_magic, we should instead leverage the page_type in struct
> > page, such as PGTY_netpp, for this purpose.
> >
> > Introduce and use the page type APIs e.g. PageNetpp(), __SetPageNetpp(),
> > and __ClearPageNetpp() instead, and remove the existing APIs accessing
> > @pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
> > netmem_clear_pp_magic().
> >
> > Plus, add @page_type to struct net_iov at the same offset as struct page
> > so as to use the page_type APIs for struct net_iov as well.  While at it,
> > reorder @type and @owner in struct net_iov to avoid a hole and
> > increasing the struct size.
> >
> > This work was inspired by the following link:
> >
> >    https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com/
> >
> > While at it, move the sanity check for page pool to on the free path.
> >
> [...]
> see below
>
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 9f2fe46ff69a1..ee81f5c67c18f 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1044,7 +1044,6 @@ static inline bool page_expected_state(struct page *page,
> >   #ifdef CONFIG_MEMCG
> >                       page->memcg_data |
> >   #endif
> > -                     page_pool_page_is_pp(page) |
> >                       (page->flags.f & check_flags)))
> >               return false;
> >
> > @@ -1071,8 +1070,6 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
> >       if (unlikely(page->memcg_data))
> >               bad_reason = "page still charged to cgroup";
> >   #endif
> > -     if (unlikely(page_pool_page_is_pp(page)))
> > -             bad_reason = "page_pool leak";
> >       return bad_reason;
> >   }
> >
> > @@ -1381,9 +1378,17 @@ __always_inline bool __free_pages_prepare(struct page *page,
> >               mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
> >               folio->mapping = NULL;
> >       }
> > -     if (unlikely(page_has_type(page)))
> > +     if (unlikely(page_has_type(page))) {
> > +             /* networking expects to clear its page type before releasing */
> > +             if (is_check_pages_enabled()) {
> > +                     if (unlikely(PageNetpp(page))) {
> > +                             bad_page(page, "page_pool leak");
> > +                             return false;
> > +                     }
> > +             }
> >               /* Reset the page_type (which overlays _mapcount) */
> >               page->page_type = UINT_MAX;
> > +     }
>
> I need some opinions here.  When CONFIG_DEBUG_VM is enabled we get help
> finding (hard to find) page_pool leaks and mark the page as bad.
>

You mean we get debug messages about the leak right? Nothing is
silently freed with that config enabled.

> When CONFIG_DEBUG_VM is disabled we silently "allow" leaking.
> Should we handle this more gracefully here? (release pp resources)
>
> Allowing the page to be reused at this point, when a page_pool instance
> is known to track life-time and (likely) have the page DMA mapped, seems
> problematic to me.  Code only clears page->page_type, but IIRC Toke
> added DMA tracking in other fields (plus xarray internally).

If we can reliably track and release the pages, I think we should do
this regardless of CONFIG_DEBUG_VM being enabled or not. But the
question is how did that leak happen? Is it a misuse of the API from
the driver?

Thanks
/Ilias
>
> I was going to suggest to simply re-export page_pool_release_page() that
> was hidden by 535b9c61bdef ("net: page_pool: hide
> page_pool_release_page()"), but that functionality was lost in
> 07e0c7d3179d ("net: page_pool: merge page_pool_release_page() with
> page_pool_return_page()"). (Cc Jakub/Kuba for that choice).
> Simply page_pool_release_page(page->pp, page).
>
> Opinions?
>
> --Jesper

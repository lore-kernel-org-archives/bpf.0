Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BEE39D6D7
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 12:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774268220; cv=pass; b=Xf3BfFSu7vi+FeGCkzvFwWzGR+w3t7IDR951I78RvriWg2N0s6aLsz//DpvGEypef4CZA/aSDFroXoMREQzXIKsm+Zbgwr6Nn8KeBgvSc+jWjiMDXwVbmTUyD4iuIr1nNcryJ5Cmm3LsixNImmMcow2e9uTmpvgZH0WhHc2nfu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774268220; c=relaxed/simple;
	bh=8RXOKVdkvBzCAmtN9XWtZUMFoXBo6XNuhmfrV+73dck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avDJLovIcw7dQFDLEV5sT2vfbX/m1xTwN3Atg53KvXRS3QaopDygYqN+5yABaJPLr/9fsVl5IGtqtwZMvr9UBJ7MViaGxCJeweqgbwTA9PpfmexUHMoW1iLecWXJT+oqgoFqHZjBn7t7Oj5vdIWde8HdRa/FLkfam7Cps8otNhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oXG3VfAC; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oXG3VfAC"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79853c0f5b9so22071687b3.0
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 05:16:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774268218; cv=none;
        d=google.com; s=arc-20240605;
        b=Szh5BupoRUyHajALmAdRjhrVDlLvg4YffuOc4HYuCz48gtXP0zD1TVANhIz3vrWdXQ
         2RAjRomhQMDB9koU3VJ61nNIGB89sy4+NP919Taxpwxzv4Y1k41/S+QVug1sy6jda90U
         9P9hqrjd/R6JdrOXxCYS0bYsIANVnfpVwkEhmn5QkI6gqSn+MzSLaQosYXZ2ymJ9eBjf
         2b9E8xtm+7cRm1hCtoSWqoxzXVk8M7w7w+bg4xWZh39KGrrFC0IRRrgpO1Cb9UvoOV2g
         eWy++LdEoUe6JhAifMr3ydpYFBCSIEVOf3LpREelUi0q9vym2a7818VOTzxRG/E5ZIeP
         cuIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MWkmFbrIVsjT8V/hemxMRS0whR7xwhOiVNLmrbQRIkQ=;
        fh=MB4IHfHxqOHiMNwdPkEWuTL8bGJZznMuDQ3sULuYuQE=;
        b=UX4ks3tYLzKdfY6nfzAO3TiOvWcBah8Me3iV/qEBt0/l1e1+mXmCdHUodZ9OjCMa9C
         ZV/1sEbqD8m6d8GaDze6ljqEPt1oGyri/2gBTXwjPwhz1+NQdLjLl0irQGMBH65TewIh
         /B8BdihZXZZ2I8vTgItJV1lRZ+n13sS0xw/ArIZW7djdj2xJ6Z1IuyEhbhSKjYx0a0ou
         gkYPWUbGXudunalIWJo1XaTko/VFaKd2Hvp/sIC/rzTD70svsCqliW9ajpx3PkMV4gZ0
         eB4t5a91fNSWl8kxaPzTuqMYK1P79Rm3MVUbSg6OJtdx0qwoFaRyRIphTktg5dNUxBNb
         OL1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774268218; x=1774873018; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MWkmFbrIVsjT8V/hemxMRS0whR7xwhOiVNLmrbQRIkQ=;
        b=oXG3VfAC4LKCyEAzdDhO6NpewxX2S3tvKQa/0F8umwy7BPUIzxHKByL4SJ+/NuvwtN
         01s1JM6LQERBKh2I1SCO0TeaGP8MPTwpgC0sZQr9fwnZ1TFtUojLEx6xYHZQY/1F59zK
         X/xr12CzWDsstfe0dkvHHwceUlmTWqeRvxdO5jtiABTjr/hurLVzIGm3dZJSRL8wbU8I
         6qAeDrPUv4CpPIc7Pd6SutsTygeBMiWJ2mVKzQadbhGpye02XlsIjNzqXBzXFD7xXxky
         eJ1cJw+UEouuY5YWaIZ136g2Rs6mhxqLXhXnKOTxZsmDgHAOih7AkiSeYCYjdMDak7sp
         hgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774268218; x=1774873018;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWkmFbrIVsjT8V/hemxMRS0whR7xwhOiVNLmrbQRIkQ=;
        b=SRWz+UKWRk/GvWUMNJ1LpSDEz9zq6Dre490WS2gy2gf0t4nodizWlSlQaLU0zv4R3x
         3f7p9gfTwV/tJkpKUP02xTOOZHbheQ9EBWFnFN+elU2kC2z3t//vIw0iN9NceFMyO5zt
         p7sxC8j5fRLj2fZvC3eSVwjtzs4sAbzCveuD9kcU3cVjE9msgHkITPkHjTZPbQNG/LV6
         g6aGoBl43vZfbzZY3Xxt+B/FsCaATGcd1N24YCE3fhnnEaCubjzAu7/tVIG+QepeHKu2
         UUIKGvdufqqH77SBbF6z2Fu6kKcm4uXLKayJ+QQT0/CriCXUlJ4xGEch9bnD8NYRvBbc
         SWQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjK9u0oDjSlwmj5cq/ADlOiIko94mFjH2Nn7kOA425hObwRX1BWReULcjYly/jOywfatY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx66leAVSe2ah7MSxh228+ju4u3Uest/Mk6h+yX4xUWxQhNnSw9
	nxv0B/E/AFRCiVRIbxaJ/kSdJu5enAquVkBbC1k/QmecGq9f/sU91ubNlymGwOGPU2Q02C9Bboz
	J+JObNCM8k3EwyIvGEWoMuWP4lkggcA5C8P0m1mAy1Q==
X-Gm-Gg: ATEYQzz/9KoH/qwYJR7RREYiStsqapvL5Ksd9L3QgTmXL/4oPMmNU3mTmBaUAfwRc7L
	KCBNlbuKzX/7l5FypG1hdzxyFFlkLM+QP6B3YvDrCUE2lLiPA6Tc5uS23zkfU80q3wMkgkUToLR
	aNVsVOatvP+y9iB9OWSMynYixcJgMykdGVQzIBgTUW78o5/mXEl1+/2sFVWnGNRWzg8wm9uyCt5
	ZFtOVtPmwL9DdQ74Cvho3TVNKYRyhVfYhsNNWpJVHREZb3LWH7tQX8er1sGdViqwVcWI/9wTc1+
	k6oFnh2v6kI3MVnoBdDgs6MRCCIsh2uFMP82hc2e5Z8oHH7wJukUVF0LSfjq5rPdk9+PMWBztFY
	+W3CM1jB+lnHllVDEmggLciEtWeiFiFN7U7zl+7eywlCAl6wvAtOpd5W45+nqxkM6LzbM08+kRs
	GY3duBPYO1SW47rxiSqMWSDOoNLjSft1j4gdJ+FKFEIytXwOWrRlyhbpF2fiWe+0UKAdVyot+mm
	dJQUPBondR+1eRhYdbA5AfXPoy/2h8MyQHaAqWyDBsAvbguzoS4MWyM6CQw5oWR03GYmbXrcWwz
	YrQRJy+aNENN/zHbuHdln37W5vT38fXMQj1oOdTH6Qu8AFdyYlqI6Yg=
X-Received: by 2002:a05:690c:1b:b0:79a:bb8b:e9d8 with SMTP id
 00721157ae682-79abb8c0ddcmr16991927b3.50.1774268217399; Mon, 23 Mar 2026
 05:16:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316222901.GA59948@system.software.com> <20260316223113.20097-1-byungchul@sk.com>
 <ebd00055-d4aa-4612-8bf3-ef0a308512f8@kernel.org> <20260318020223.GA69943@system.software.com>
 <b48275da-a3cb-4621-82fa-c2a83f1e24b5@kernel.org>
In-Reply-To: <b48275da-a3cb-4621-82fa-c2a83f1e24b5@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 23 Mar 2026 14:16:20 +0200
X-Gm-Features: AaiRm50BWIH2-tUvBrhcp6LVf1TFjq6A8vCDpCMci7VezVPJXkSVFBGlyHvsvAw
Message-ID: <CAC_iWjL4RhuK16pDM7bQhrkOgHa54R_6S0zGgwSdc_n+yKCcUg@mail.gmail.com>
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
	sfr@canb.auug.org.au, dw@davidwei.uk, ap420073@gmail.com, dtatulea@nvidia.com, 
	Daniel Dao <dqminh@cloudflare.com>, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Mar 2026 at 13:44, Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>
>
>
> On 18/03/2026 03.02, Byungchul Park wrote:
> > On Tue, Mar 17, 2026 at 10:20:08AM +0100, Jesper Dangaard Brouer wrote:
> >> On 16/03/2026 23.31, Byungchul Park wrote:
> >>> Currently, the condition 'page->pp_magic == PP_SIGNATURE' is used to
> >>> determine if a page belongs to a page pool.  However, with the planned
> >>> removal of @pp_magic, we should instead leverage the page_type in struct
> >>> page, such as PGTY_netpp, for this purpose.
> >>>
> >>> Introduce and use the page type APIs e.g. PageNetpp(), __SetPageNetpp(),
> >>> and __ClearPageNetpp() instead, and remove the existing APIs accessing
> >>> @pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
> >>> netmem_clear_pp_magic().
> >>>
> >>> Plus, add @page_type to struct net_iov at the same offset as struct page
> >>> so as to use the page_type APIs for struct net_iov as well.  While at it,
> >>> reorder @type and @owner in struct net_iov to avoid a hole and
> >>> increasing the struct size.
> >>>
> >>> This work was inspired by the following link:
> >>>
> >>>     https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com/
> >>>
> >>> While at it, move the sanity check for page pool to on the free path.
> >>>
> >> [...]
> >> see below
> >>
> >>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >>> index 9f2fe46ff69a1..ee81f5c67c18f 100644
> >>> --- a/mm/page_alloc.c
> >>> +++ b/mm/page_alloc.c
> >>> @@ -1044,7 +1044,6 @@ static inline bool page_expected_state(struct page *page,
> >>>    #ifdef CONFIG_MEMCG
> >>>                        page->memcg_data |
> >>>    #endif
> >>> -                     page_pool_page_is_pp(page) |
> >>>                        (page->flags.f & check_flags)))
> >>>                return false;
> >>>
> >>> @@ -1071,8 +1070,6 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
> >>>        if (unlikely(page->memcg_data))
> >>>                bad_reason = "page still charged to cgroup";
> >>>    #endif
> >>> -     if (unlikely(page_pool_page_is_pp(page)))
> >>> -             bad_reason = "page_pool leak";
> >>>        return bad_reason;
> >>>    }
> >>>
> >>> @@ -1381,9 +1378,17 @@ __always_inline bool __free_pages_prepare(struct page *page,
> >>>                mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
> >>>                folio->mapping = NULL;
> >>>        }
> >>> -     if (unlikely(page_has_type(page)))
> >>> +     if (unlikely(page_has_type(page))) {
> >>> +             /* networking expects to clear its page type before releasing */
> >>> +             if (is_check_pages_enabled()) {
> >>> +                     if (unlikely(PageNetpp(page))) {
> >>> +                             bad_page(page, "page_pool leak");
> >>> +                             return false;
> >>> +                     }
> >>> +             }
> >>>                /* Reset the page_type (which overlays _mapcount) */
> >>>                page->page_type = UINT_MAX;
> >>> +     }
> >>
> >> I need some opinions here.  When CONFIG_DEBUG_VM is enabled we get help
> >> finding (hard to find) page_pool leaks and mark the page as bad.
> >>
> >> When CONFIG_DEBUG_VM is disabled we silently "allow" leaking.
> >> Should we handle this more gracefully here? (release pp resources)
> >>
> >> Allowing the page to be reused at this point, when a page_pool instance
> >> is known to track life-time and (likely) have the page DMA mapped, seems
> >> problematic to me.  Code only clears page->page_type, but IIRC Toke
> >> added DMA tracking in other fields (plus xarray internally).
> >>
> >> I was going to suggest to simply re-export page_pool_release_page() that
> >> was hidden by 535b9c61bdef ("net: page_pool: hide
> >> page_pool_release_page()"), but that functionality was lost in
> >> 07e0c7d3179d ("net: page_pool: merge page_pool_release_page() with
> >> page_pool_return_page()"). (Cc Jakub/Kuba for that choice).
> >> Simply page_pool_release_page(page->pp, page).
> >>
> >> Opinions?
> >
> > This is not an issue related to this patch but it's worth discussing. :)
> >
>
> Yes, looking at existing code, you are actually keeping the same
> problematic semantics of freeing a page that is still tracked by a
> page_pool (DMA-mapped and life-time tracked), unless CONFIG_DEBUG_VM is
> enabled.  You code change just makes this more clear that this is the case.
>
> In that sense this patch is correct and can be applied.
> Let me clearly ACK this patch.
>
> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
>
> > Not only page pool state but any bad states checks are also skipped with
> > is_check_pages_enabled() off, which means they are going to be
> > suppressed with the off.
> >
>
> Sadly yes. I'm mostly familiar with the page_pool, and I can say that
> this isn't a good situation.  Like Dragos said [1] it would be better to
> just leak to it.  Dragos gave a talk[2] on how to find these leaked
> pages, if we let them stay leaked.
>
>
>   [1] https://lore.kernel.org/all/20260319163109.58511b70@kernel.org/
>   [2]
> https://netdevconf.info/0x19/sessions/tutorial/diagnosing-page-pool-leaks.html
>
>
> > It is necessary to first clarify whether the action was intentional or
> > not.  According to the answer, we can discuss what to do better. :)
> >
> Acking this patch, as this discussion is a problem for "us" (netdev
> people) to figure out.  Lets land this patch and then we can followup.
>
> --Jesper
>
>
>
>

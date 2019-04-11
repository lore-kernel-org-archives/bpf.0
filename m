Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA4CC10F13
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 05:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE34E20850
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 05:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KuhgQQOo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfDKFru (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 01:47:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52753 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfDKFru (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 01:47:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id a184so5010466wma.2
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2019 22:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NsCapcvrCzX4whjtOibbL7+C3EUhdfca/Vmv19BdkYA=;
        b=KuhgQQOovM8ZUnMHr91dNUFWsLmMjt6SNVGtnMCNsfOAehl+nE26yjO3TX+mXx7J8k
         FSIOVM9lcIEauIjoPZvUCDOZtjleedlcAv1BxCnopqexB2huze9ztO/N/ug/1d8BFMqv
         TJwRt9IyHgSgnvHwNwwR5SWocX/wtGhi7ZyBizey0KTgP5YT4N2VxZyysmYEKVsbklK9
         Thq6YmnmbLW6ax34mdwyE5qKWP2vYKIDCavXxJeXVkbfbzB42269tnc0MxFiJKFUGKRM
         /C32+RBIIQw9DMCBIoeBAmZOPgTJYOK5/3P26B8JkUwN24hSeWdx2KMfMohxHusluZHo
         JtZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NsCapcvrCzX4whjtOibbL7+C3EUhdfca/Vmv19BdkYA=;
        b=LrGluBBhFz9S9OrfdM9VaHXaWSiaZnXEIo06cPg9/XyxNLd6rEyATpvMvejahPDUXW
         uHeHFDdU7P68/irXZ5CnU4UgkI8Xr3Rmk2OZM5V6TM6iI5Sk6vuEMJnZCtdKzTRbdtCO
         KPWjYKdZ2MeWjCzNJ7COLzWPd/Gj1tDhe6EehOhVCE9MhyIjO9wTx+eSMYNWBR7lPZGM
         X2lUogz2epnbYfJGE+Sbjpvi3hSxGh0MCQ+KSLv34nSc2s7uXIYGPARFQNwkvuzF11D+
         3CtTks2OvWVLen+zzuVXz/ZRhZzkAxz1E8/9fXZVfMvJf5y62HZfWqgYD5jQ9CeMJT/N
         R0hQ==
X-Gm-Message-State: APjAAAUxJjM/dYlMbYlCXuPAy0DyFoo+mCtiq3sTht8kQcS6RDJHs/Eu
        NuFjBDMK+eU7hkDyk7dj6CyRDg==
X-Google-Smtp-Source: APXvYqxI60J1J/+/+Wnw+jr7v5BFYK8Vy3XwCLZEqT4/0TQ+dvXmFZXOBIjLi0J1zcQfhdrDHfJylw==
X-Received: by 2002:a1c:7512:: with SMTP id o18mr5429967wmc.68.1554961668574;
        Wed, 10 Apr 2019 22:47:48 -0700 (PDT)
Received: from apalos (athedsl-165181.home.otenet.gr. [85.75.188.219])
        by smtp.gmail.com with ESMTPSA id n6sm9677429wmn.48.2019.04.10.22.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 22:47:47 -0700 (PDT)
Date:   Thu, 11 Apr 2019 08:47:45 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     netdev@vger.kernel.org, Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, bpf@vger.kernel.org,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>
Subject: Re: [PATCH bpf-next 5/5] bpf: cpumap memory prefetchw optimizations
 for struct page
Message-ID: <20190411054745.GA1763@apalos>
References: <155489659290.20826.1108770347511292618.stgit@firesoul>
 <155489663807.20826.15883373865371166146.stgit@firesoul>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155489663807.20826.15883373865371166146.stgit@firesoul>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 10, 2019 at 01:43:58PM +0200, Jesper Dangaard Brouer wrote:
> A lot of the performance gain comes from this patch.
> 
> While analysing performance overhead it was found that the largest CPU
> stalls were caused when touching the struct page area. It is first read with
> a READ_ONCE from build_skb_around via page_is_pfmemalloc(), and when freed
> written by page_frag_free() call.
> 
> Measurements show that the prefetchw (W) variant operation is needed to
> achieve the performance gain. We believe this optimization it two fold,
> first the W-variant saves one step in the cache-coherency protocol, and
> second it helps us to avoid the non-temporal prefetch HW optimizations and
> bring this into all cache-levels. It might be worth investigating if
> prefetch into L2 will have the same benefit.
> 
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> ---
>  kernel/bpf/cpumap.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index b82a11556ad5..4758482ab5b9 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -281,6 +281,18 @@ static int cpu_map_kthread_run(void *data)
>  		 * consume side valid as no-resize allowed of queue.
>  		 */
>  		n = ptr_ring_consume_batched(rcpu->queue, frames, CPUMAP_BATCH);
> +
> +		for (i = 0; i < n; i++) {
> +			void *f = frames[i];
> +			struct page *page = virt_to_page(f);
> +
> +			/* Bring struct page memory area to curr CPU. Read by
> +			 * build_skb_around via page_is_pfmemalloc(), and when
> +			 * freed written by page_frag_free call.
> +			 */
> +			prefetchw(page);
> +		}
> +
>  		m = kmem_cache_alloc_bulk(skbuff_head_cache, gfp, n, skbs);
>  		if (unlikely(m == 0)) {
>  			for (i = 0; i < n; i++)
> 
LGTM 

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

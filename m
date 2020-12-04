Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC1EC433FE
	for <bpf@archiver.kernel.org>; Fri,  4 Dec 2020 23:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 357F422B4E
	for <bpf@archiver.kernel.org>; Fri,  4 Dec 2020 23:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgLDXZQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 4 Dec 2020 18:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgLDXZQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Dec 2020 18:25:16 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC04C061A51
        for <bpf@vger.kernel.org>; Fri,  4 Dec 2020 15:24:36 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id b5so183690pjl.0
        for <bpf@vger.kernel.org>; Fri, 04 Dec 2020 15:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dp4a4I+CGeFhV9BXWLgWJG8THoDXEJYYnGVTWyWsFu0=;
        b=bXts64vtazkEv2OjbCqbdaD9U8GVsVJnQmEDL9b6088YJRpesI6caMXbOdtWkpdB+Q
         19RLwmCuAsjnnGiofDhFpbgMy8T09aytIJIG2joIsHqotjSr+Cz/uMhhX4cFbVONxbMk
         0hpY+kDJNklJHHxbNr53xeznEV6SgeWq20JQ1u5ISV2jkdoYwoGpLbcJFNwKv33/vWqW
         iNFPk7ZHhFqpYSR8ywqZHipoQUewxd8aT1ckSZpYhwm9mpNewavasN5LTwD/nbyiQuLm
         FhK7CBHyZDs7vG0xBtF5KCvfD6dM9NAcjWZrLyZNLjGi9wF1+vIR9MAekJgtxj1lU/z6
         plng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dp4a4I+CGeFhV9BXWLgWJG8THoDXEJYYnGVTWyWsFu0=;
        b=X/KU5EtFSOIYRz25+CvHNAAcn/yu66DNdL7dAfY8qoq/tT0asZcG9nEMSApi7fmADI
         5jw4hsIcyXNR67sNZFUW2HZGCiBvTaFlWsKi1Ny5Vzrtix6ZnEl1jjms1HKRveSfzapv
         8D0DatUJYe4lvOgFuqx2Os8ZjC3is0NSZ63T/itA620I+zA8mfewPTRnEeUExaAzLxZf
         Ur3FKtQLv9f+9B+UWs8+0g2bpNqsIt99COinfi3wu4HqTGPZ/290mmNwnDChD3AUZKK8
         6I+NwgJNX4u9M3m3lflaUwsuuebgbjHNivnhJVvSjVPa8EvHfCWsnRH3zxoTwVea7t20
         d2wQ==
X-Gm-Message-State: AOAM530CTDgWSFmAvcBwICEBxuRtpj/Cv0V5OY3E+ws7Ak3vWTVQ+lkM
        0iihYJa0jI4XBziDO7MT78JaIg==
X-Google-Smtp-Source: ABdhPJze8kI8LCo+CNtM8rZfjc3ETpwe4yoo4ibkkStpdGcu1RwnDl8O28MicEKOlPuVWLpM0VL5uw==
X-Received: by 2002:a17:902:bcca:b029:da:61e3:a032 with SMTP id o10-20020a170902bccab02900da61e3a032mr5822157pls.63.1607124275801;
        Fri, 04 Dec 2020 15:24:35 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id t16sm4921930pga.51.2020.12.04.15.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 15:24:35 -0800 (PST)
Date:   Fri, 4 Dec 2020 15:24:28 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     akpm@linux-foundation.org, jeyu@kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, luto@kernel.org,
        dave.hansen@linux.intel.com, peterz@infradead.org, x86@kernel.org,
        rppt@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, elena.reshetova@intel.com,
        ira.weiny@intel.com
Subject: Re: [PATCH RFC 01/10] vmalloc: Add basic perm alloc implementation
Message-ID: <X8rFLHGSqJ7JCZ/N@google.com>
References: <20201120202426.18009-1-rick.p.edgecombe@intel.com>
 <20201120202426.18009-2-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120202426.18009-2-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 20, 2020, Rick Edgecombe wrote:
> +struct perm_allocation {
> +	struct page **pages;
> +	virtual_perm cur_perm;
> +	virtual_perm orig_perm;
> +	struct vm_struct *area;
> +	unsigned long offset;
> +	unsigned long size;
> +	void *writable;
> +};
> +
> +/*
> + * Allocate a special permission kva region. The region may not be mapped
> + * until a call to perm_writable_finish(). A writable region will be mapped
> + * immediately at the address returned by perm_writable_addr(). The allocation
> + * will be made between the start and end virtual addresses.
> + */
> +struct perm_allocation *perm_alloc(unsigned long vstart, unsigned long vend, unsigned long page_cnt,
> +				   virtual_perm perms);

IMO, 'perm' as the root namespace is too generic, and perm_ is already very
prevelant throughout the kernel.  E.g. it's not obvious when looking at the
callers that perm_alloc() is the first step in setting up an alternate kernel
VA->PA mapping.

I don't have a suggestion for a more intuitive name, but in the absence of a
perfect name, I'd vote for an acronym that is easy to grep.  Something like
pvmap?  That isn't currently used in the kernel, though I can't help but read it
as "paravirt map"...

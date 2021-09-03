Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE191C433EF
	for <bpf@archiver.kernel.org>; Fri,  3 Sep 2021 08:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D514060FD7
	for <bpf@archiver.kernel.org>; Fri,  3 Sep 2021 08:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348197AbhICI3b (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 3 Sep 2021 04:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348314AbhICI3N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Sep 2021 04:29:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61A5C061760;
        Fri,  3 Sep 2021 01:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=++jm6oY+bJJxusAX097iIXvKnGM0fjw8N41n/TI3ISY=; b=ils+FN/bFNcs+IBDKlS7DNCP2B
        srlVriyw9vZaH9rLy2nFJVzSHspBEAWpe2fnOS4rTENRRQXMo+8pTpCk5Y47zVHQcd0GWqeD+wkN1
        lMMJ6sJmcS7UIlHzZ3+LTqdAOsINinU6QMmhZxqlW+69vWGuCLrMskghcApastuTRlYhXkdwz6rOn
        uO/uXt/JixCfNOeJEJZh/avEvp6q8faMW29OnbrLYC9h2ydadcU4UglVJTLk5b/dR+/Hfd2X1BOlb
        fnZqFQ7qf2ZPgQ0/vbJWtj7YI+HO/MZrdDZ/gkK7S9LJc9vB7SZXfv1hKUTAkX9LY0EOM4mxMs63Q
        /rj+GLHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mM4YN-000JKU-HS; Fri, 03 Sep 2021 08:28:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6107630024D;
        Fri,  3 Sep 2021 10:28:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5225D28B658E6; Fri,  3 Sep 2021 10:28:02 +0200 (CEST)
Date:   Fri, 3 Sep 2021 10:28:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        mingo@redhat.com, kjain@linux.ibm.com, kernel-team@fb.com
Subject: Re: [PATCH v5 bpf-next 2/3] bpf: introduce helper
 bpf_get_branch_snapshot
Message-ID: <YTHcki5RLZIIGqbk@hirez.programming.kicks-ass.net>
References: <20210902165706.2812867-1-songliubraving@fb.com>
 <20210902165706.2812867-3-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902165706.2812867-3-songliubraving@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 02, 2021 at 09:57:05AM -0700, Song Liu wrote:
> +BPF_CALL_3(bpf_get_branch_snapshot, void *, buf, u32, size, u64, flags)
> +{
> +#ifndef CONFIG_X86
> +	return -ENOENT;
> +#else
> +	static const u32 br_entry_size = sizeof(struct perf_branch_entry);
> +	u32 entry_cnt = size / br_entry_size;
> +
> +	if (unlikely(flags))
> +		return -EINVAL;
> +
> +	if (!buf || (size % br_entry_size != 0))
> +		return -EINVAL;
> +
> +	entry_cnt = static_call(perf_snapshot_branch_stack)(buf, entry_cnt);
> +
> +	if (!entry_cnt)
> +		return -ENOENT;
> +
> +	return entry_cnt * br_entry_size;
> +#endif
> +}

Do we really need that CONFIG_X86 thing? Seems rather bad practise.

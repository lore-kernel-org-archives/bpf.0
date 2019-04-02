Return-Path: <SRS0=V8Hm=SE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26008C4360F
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 17:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF14B2075E
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 17:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFINn9k5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731655AbfDBRjc (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 2 Apr 2019 13:39:32 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39450 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731544AbfDBRjc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Apr 2019 13:39:32 -0400
Received: by mail-pl1-f194.google.com with SMTP id b65so6619046plb.6;
        Tue, 02 Apr 2019 10:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tj8iji6n+LMbFCjuyA8v1OCcZSg05LaMjCZF6T6++as=;
        b=jFINn9k5+Bjz1YDqj5EW71Ebo7XWao494jYXi8nEIJfOEpMTi/eAFVZAL2C4Xk7Kf0
         vIK4Oyz9A3Q13QXAoP2GNkpnh3pSYfFFcGC+noDeKp8EqhkkxKfid7tc6U+qY6sU0yCU
         m24FC1SS7NOCCWwxhDhULazBYrAHS9i/6Mn/McsYEPm1bHct2yYvg7T+jfGr+ezi+a9a
         xOpvkLyRz5d73fPh+0AJDGvrgZeRlWgyndN6U79xU/+IR/9hC3rp/YUoc876yVKBDJxs
         HNq7eCcYxieT5EIeUBJgzxL+dwCa0hsUS4zkPx2tzzDo0/gARGLbihp91NiHyCXS1rJ8
         anEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tj8iji6n+LMbFCjuyA8v1OCcZSg05LaMjCZF6T6++as=;
        b=lJO4emAF4n0eSWlsSe9vhosMZuFAaI6+nyJ7f/NqRvDqF4Oo6R12VB9AAbCiYvoVs8
         oroxhrRqG3YrE1FkOjwO60+zTVSDsalmX78cb5HiZF81lnUiEsEHtKeAL1Q3uC7fvw8n
         sWmxFNsD8AFVHeE5lUK9tdyPQ4Eodt9h0bgSIwUE6+5Quj13Bgk50noGZlSjRO0EEVxM
         Dlh/aP0knZZiCwrD0PVwD/FPb4QrEgaCBvR4/NH/Sk8RbLm2zzo7Fph8D/I6Y0L5wLTU
         Q+ddSctWX5ZYlySARxh4MH8Q4GKwHfYXjqmCIbQHhAX8YBqydqAPe/LtUm47zJIYgCxz
         2SLw==
X-Gm-Message-State: APjAAAXW42UNTXg7Sw5yPOHeY/+HIChNUj6yEOdoApjN/Arz5OSh18CM
        iUCcpXU6A+PABhvHwa4WWGE=
X-Google-Smtp-Source: APXvYqzBRoy9sZn1tMB2jkd7sfmBOI71Ep53uyZS2gIn/fMRU28R1Ul3eZeCrWdk/GmsMG7Xja5/wA==
X-Received: by 2002:a17:902:2aca:: with SMTP id j68mr24760542plb.233.1554226771382;
        Tue, 02 Apr 2019 10:39:31 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::1:1fef])
        by smtp.gmail.com with ESMTPSA id a13sm15913107pgw.91.2019.04.02.10.39.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 10:39:30 -0700 (PDT)
Date:   Tue, 2 Apr 2019 10:39:29 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Paul Chaignon <paul.chaignon@orange.com>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Xiao Han <xiao.han@orange.com>,
        paul.chaignon@gmail.com, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf] bpf: report verifier bugs as warnings
Message-ID: <20190402173927.pvqprcbjk42km3mc@ast-mbp.dhcp.thefacebook.com>
References: <20190402115811.GA6303@Nover>
 <a79d7f5e-637e-df0a-e99c-beea05eca1d7@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a79d7f5e-637e-df0a-e99c-beea05eca1d7@iogearbox.net>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 02, 2019 at 04:37:19PM +0200, Daniel Borkmann wrote:
> On 04/02/2019 01:58 PM, Paul Chaignon wrote:
> > Three checks for verifier bugs were introduced in commit f4d7e40 ("bpf:
> > introduce function calls (verification)").  The bugs were reported as
> > incorrect programs instead of kernel warnings as the present patch
> > implements.
> > 
> > Signed-off-by: Paul Chaignon <paul.chaignon@orange.com>
> 
> Thanks for the patch, I think these WARN_ONCE() are a bit out of context though,
> meaning it lacks additional information about the program in kernel log once we
> actually manage to trigger it which we'd otherwise would potentially have had with
> the verbose() log. And from a program debugging pov, it makes it harder after this
> patch when verification log would suggest that all is fine. Looks like we already
> have a few WARN_ONCE() in verifier, they should probably be converted to verbose()
> as well to be consistent. If we really want to have a kernel warn, then lets add a
> helper macro verbose_and_warn(...) which will trigger a one-time warning, but keeps
> the verbose log intact as well.

I think they should stay as verbose() messages and some of the WARN_ON
should be converted to verbose().
I don't think there is a need for verbose_and_warn().


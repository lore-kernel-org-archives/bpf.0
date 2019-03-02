Return-Path: <SRS0=p5ic=RF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D85CC43381
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 19:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24DB620838
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 19:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRlUig/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfCBTQP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 2 Mar 2019 14:16:15 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44751 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfCBTQP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 2 Mar 2019 14:16:15 -0500
Received: by mail-pf1-f195.google.com with SMTP id a3so521866pff.11;
        Sat, 02 Mar 2019 11:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ra9yiimYN++3tmIcracFo4QooX2aqnPadUaRuQ+mnLk=;
        b=RRlUig/8kitxn3Xm3bY8jaSUonjgJc8V8xQTlQhCF6c3Aw1FnM11mdtFxPixnufQN7
         lwNHQt6dyb6nElAreWFKb84520OCAZzapLWiRiVrgo1J/JGmL5W9f5pSRliXcqLUyXtp
         dTkSayQdmR83nWV3y1iff+zGeZ/sr78nAyvevKWqf2nMvlo6f2zxS2KQz9iqAREl2lCj
         B5a9O493NUb6WJDqR8RS6bl08vFdYstJ9Dvq2WM43JEOhvNLRB9qAf12GobGW2NwP/EX
         ZMSXXbInwJsQftjwVOvGFZkcLSDYulw9Unc3AiQIETL96s0nM6ZdiBD040/ktA55BwxS
         u3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ra9yiimYN++3tmIcracFo4QooX2aqnPadUaRuQ+mnLk=;
        b=NJD1nMmGjHk3Mwvns6ap5+9I9gSGWXm8bnQVce8oOtvK8U+d45jYfYNoyV3uMl1B2F
         6YHH1n5fzlrGT6MDyzb3C9XF3aAQYyrr3+gCeaHbGzyKvOC2sLG3TW5rxbH0JvUFEyLe
         2jfDMuniDmooaVjdOQW05sNfRQ3sQpHFWfrISxkpwGvC1qiIGQr8VRjT5MN8rsn1AMwi
         Acfs/EdBOAVLrfqorl3VssfiTtsDrlS97ihK2tOWBUOhn7tgdNKsD32ekGY8DVuxJqp3
         PnP8ADEPGxBl9qiqzkdxWRNOKC5O9Vx+wEirjJCK/79F7tAaSssGXCkdOweNLnQbZC2t
         ziwg==
X-Gm-Message-State: AHQUAuZCOyQOZub8zOht1Cz6N/1Qu+kZFDCVO20MiQpzUh+ZOSNOScQD
        LLi1fgKuITtEKTKUKFY8fiQ=
X-Google-Smtp-Source: AHgI3IY6Knk48HYosIh9Q70zXBiO/KxQybTgVsAOMTJwu4JNsR4zLehkBxi4PcP9fVjA/Mq8Lis43g==
X-Received: by 2002:aa7:9289:: with SMTP id j9mr12143033pfa.130.1551554174584;
        Sat, 02 Mar 2019 11:16:14 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::6864])
        by smtp.gmail.com with ESMTPSA id b6sm2999193pgl.49.2019.03.02.11.16.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 11:16:13 -0800 (PST)
Date:   Sat, 2 Mar 2019 11:16:12 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
        ast@kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH bpf-next v3 0/7] selftests: bpf: break up test_progs
Message-ID: <20190302191611.i2cikjrosuslocum@ast-mbp.dhcp.thefacebook.com>
References: <20190302034219.99480-1-sdf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190302034219.99480-1-sdf@google.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 01, 2019 at 07:42:12PM -0800, Stanislav Fomichev wrote:
> Recently we had linux-next bpf/bpf-next conflict when we added new
> functionality to the test_progs.c at the same location. Let's split
> test_progs.c the same way we recently split test_verifier.c.
> 
> I follow the same patten we did in commit 2dfb40121ee8 ("selftests: bpf:
> prepare for break up of verifier tests") for verifier: create
> scaffolding to support dedicated files and slowly move the tests into
> separate files.
> 
> The first patch adds scaffolding, subsequent patches move progs into
> separate files.
> 
> In theory, many of the standalone tests can be migrated to this new
> framework as well. They get the benefit of common CHECK macro and
> bpf_find_map function which a lot of standalone tests need to redefine.
> 
> v3 changes:
> * respin on top of commit ebace0e981b2 ("selftests/bpf: use
>   __bpf_constant_htons in test_prog.c for flow dissector")
> * put bpf_rlimit.h into test_progs.c instead of test_progs.h
> 
> v2 changes:
> * added cover letter, added more description about file structure

Applied, Thanks


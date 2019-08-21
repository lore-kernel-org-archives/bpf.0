Return-Path: <SRS0=qicS=WR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5128CC3A5A1
	for <bpf@archiver.kernel.org>; Wed, 21 Aug 2019 17:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22330216F4
	for <bpf@archiver.kernel.org>; Wed, 21 Aug 2019 17:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="Fa8t/Ogm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfHURLx (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 21 Aug 2019 13:11:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38101 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729470AbfHURLw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Aug 2019 13:11:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id e11so1670871pga.5
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2019 10:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9sz1HR21ZNE/lPIudnqu5o8TGKBNgdHKG73vNNFPHmI=;
        b=Fa8t/OgmzCblhcW0o6sC00GT6IWfbpGePL4EyWVNYxnE/d7D5mascN+XlC6W8gby/a
         4N3J2BHr0Babr0Pxsx35uRY1AtMJJJoQ8TrWovKBrj2GXlC6VaAniCWZ/DW8zvPlM9NQ
         kBUKWMx0Y64Epfq1IjN0pOEBGg/3N+cfcXw0pzw1Be4Nca15oSz6I8M7AC1wpbo7YWY1
         rHbM0yAneaqcjJZj4Rr4Acf1XpK6H0wdgW9Uj5lhAYZ+xc4K3R36q0qy2afILO8PVkfK
         CwVUDa8Qn4kvVnP6OZvHoxHmeW6i8+c6aFqmhdXkJRAEpbktbhh/LHHfJh87sq1zjwAL
         f0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9sz1HR21ZNE/lPIudnqu5o8TGKBNgdHKG73vNNFPHmI=;
        b=gbSSAvUgiIZKBpzc8GGOFJA42bPUOZXMpLXXsGopsebEHybywiwerHN7sq9Wt66ML9
         +HSKS0mf+2ogsuwBIjuh7i2Qn6WZOFVZ6AXqUrSW0+myrPGYgkYTa3PsNBXelB/bvZJp
         cBhs9BzCdCsfnqXTmyN73Byz862h+KGc/hO4U5Bue66bZfiput/ZGBv/RVLirhpWCQ9d
         U++mF0R/fEAXH+UEAbQwKzYc3jK1ohNen2ZG49fRRF752oPzzSbZJCWly5JkagBZ+QOp
         HzB5AJkvf6sIZ01iAx9ZU9MH+OVaL02YkdCP/h+66wVDuQjdxJE4GiCJ3c89k9QVwcbo
         W1Qw==
X-Gm-Message-State: APjAAAXpzJuDXnws/A6+0DWT1KZerooii39mATMtQwaUHjpIRjGxdPCY
        MbtMKfVXK2nmD+YHF3Dn4F2cYw==
X-Google-Smtp-Source: APXvYqwNbinWRLDaw/4XOTedS/RCr7a66kyyVucgBrujmrtc7pTYrKC0fMNgAqm78QEGRgDF5xVmFQ==
X-Received: by 2002:a63:f907:: with SMTP id h7mr23839670pgi.418.1566407511350;
        Wed, 21 Aug 2019 10:11:51 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id z13sm23374626pfa.94.2019.08.21.10.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 10:11:50 -0700 (PDT)
Date:   Wed, 21 Aug 2019 10:11:49 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, davem@davemloft.net, ast@kernel.org,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH bpf-next v2 2/4] selftests/bpf: test_progs: remove global
 fail/success counts
Message-ID: <20190821171149.GA1717@mini-arch>
References: <20190819191752.241637-1-sdf@google.com>
 <20190819191752.241637-3-sdf@google.com>
 <5248b967-2887-2205-3e59-fc067e2ada33@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5248b967-2887-2205-3e59-fc067e2ada33@iogearbox.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 08/21, Daniel Borkmann wrote:
> On 8/19/19 9:17 PM, Stanislav Fomichev wrote:
> > Now that we have a global per-test/per-environment state, there
> > is no longer need to have global fail/success counters (and there
> > is no need to save/get the diff before/after the test).
> 
> Thanks for the improvements, just a small comment below, otherwise LGTM.
> 
> > Introduce QCHECK macro (suggested by Andrii) and covert existing tests
> > to it. QCHECK uses new test__fail() to record the failure.
> > 
> > Cc: Andrii Nakryiko <andriin@fb.com>
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> [...]
> > @@ -96,17 +93,25 @@ extern struct ipv6_packet pkt_v6;
> >   #define _CHECK(condition, tag, duration, format...) ({			\
> >   	int __ret = !!(condition);					\
> >   	if (__ret) {							\
> > -		error_cnt++;						\
> > +		test__fail();						\
> >   		printf("%s:FAIL:%s ", __func__, tag);			\
> >   		printf(format);						\
> >   	} else {							\
> > -		pass_cnt++;						\
> >   		printf("%s:PASS:%s %d nsec\n",				\
> >   		       __func__, tag, duration);			\
> >   	}								\
> >   	__ret;								\
> >   })
> > +#define QCHECK(condition) ({						\
> > +	int __ret = !!(condition);					\
> > +	if (__ret) {							\
> > +		test__fail();						\
> > +		printf("%s:FAIL:%d ", __func__, __LINE__);		\
> > +	}								\
> > +	__ret;								\
> > +})
> 
> I know it's just a tiny nit but the name QCHECK() really doesn't tell me anything
> if I don't see its definition. Even just a CHECK_FAIL() might be 'better' and
> more aligned with the CHECK() and CHECK_ATTR() we have, at least I don't think
> many would automatically derive 'quiet' from the Q prefix [0].
CHECK_FAIL sounds good, will respin! Thanks!

>   [0] https://lore.kernel.org/bpf/CAEf4BzbUGiUZBWkTWe2=LfhkXYhQGndN9gR6VTZwfV3eytstUw@mail.gmail.com/
> 
> >   #define CHECK(condition, tag, format...) \
> >   	_CHECK(condition, tag, duration, format)
> >   #define CHECK_ATTR(condition, tag, format...) \
> > 
> 

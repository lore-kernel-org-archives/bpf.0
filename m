Return-Path: <SRS0=GcXc=RS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B7AC43381
	for <bpf@archiver.kernel.org>; Fri, 15 Mar 2019 20:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7229A21871
	for <bpf@archiver.kernel.org>; Fri, 15 Mar 2019 20:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="nTY6LLUY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfCOUTD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Mar 2019 16:19:03 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:35881 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfCOUTD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Mar 2019 16:19:03 -0400
Received: by mail-qk1-f172.google.com with SMTP id k130so6313497qke.3
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2019 13:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=vNLDsK+ITLhpfAB6mtF9ySzLgKMY3pHfBPREp1xBa/I=;
        b=nTY6LLUY6Ss4xi+HFpGgTfAAyaxyfwELjx1x25iG42LUXKh7K55P4S2gTla9zIji2m
         9X3TbMuTMU7kJm/LmZ/l+dsJ1UsWXfS757w7UzMqRT529eAeADoc/rWhleyu5ONlznN6
         sr7XfrvlW/SuKTey7p7Ch72g8OQ3FCzdWgEzlTcBo4wOy/V8yCFLT6Op+nUFB/0QZaKo
         O1LaUbSbOWw+ECwEh5salOf2FsiP2HyeaojS4gEqFA/vJj1mu+pLMV8fWrV4+yBzN9yz
         XCKNNenbfI+quZlDkteFyn6CqzhMFoZBfDxNjXEwETTkxHHDAW6hvNQQVcpPHoFnM0Ew
         EgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=vNLDsK+ITLhpfAB6mtF9ySzLgKMY3pHfBPREp1xBa/I=;
        b=jUpN9ZR4zlrepQEaQF95BDOQH/FH3zgI1t4jGpExRvEUZt0DJz8ZmJ4Ap1kdnszgy7
         Yi55zC29U8SPvXwRQQSRTztV6i3PzvWR+YHuhpWCf8BKPs7nRISnNPQfiJu/QHURrzlg
         CaTbdVONDoczFIY7qs2ZUwmcpHpKo9zmb93r55SLQyuWOF7qAFy3nWMxNSxozeTbWbuJ
         qwQbnDAM+GmJLB1hdYVclCQ8F+BAF3YGKWL4CA1meTaASnRAQicDBMur687w8d50lIbC
         c/fYt9wSOrye9q4p/c5Y6S0Dlx1Gf4oudKjzy9ikXGKtHFYVuUFs1xBum17q75TcZN6y
         b3/g==
X-Gm-Message-State: APjAAAWT5cN8rpXGUBf2wg78qDuzex+B8AiN96dccV/30lCcjPAl6E5c
        LzTg5sjR9N3JPZ1xtn6lEf76ZVDh87E=
X-Google-Smtp-Source: APXvYqzY1rTB1OOveOworq4w6imnggaBei/dDYxE7HKZRVmdxy1bije06vWQLMiC/jYTmDjlSgSSVQ==
X-Received: by 2002:a37:4cc3:: with SMTP id z186mr4325657qka.260.1552681142143;
        Fri, 15 Mar 2019 13:19:02 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id h11sm2216650qth.13.2019.03.15.13.19.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 13:19:01 -0700 (PDT)
Date:   Fri, 15 Mar 2019 13:18:53 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Stanislav Fomichev <sdf@google.com>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] bpftool: Allow referring to maps by its name
Message-ID: <20190315131853.13f45a70@cakuba.netronome.com>
In-Reply-To: <20190315195142.GB22548@kernel.org>
References: <20190315183211.GB24482@kernel.org>
        <20190315121632.246824dc@cakuba.netronome.com>
        <20190315195142.GB22548@kernel.org>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 15 Mar 2019 16:51:42 -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Mar 15, 2019 at 12:16:32PM -0700, Jakub Kicinski escreveu:
> > Please do keep the current model of name val, IOW dump map *name* pids..  
> 
> I don't have a problem with that, but what would be the problem with
> supporting both:
> 
>   bpftool map dump name pids_filtered
> 
> and:
> 
>   bpftool map dump pids_filtered
> 
> And for that matter, even:
> 
>   bpftool map dump id 30
> 
> And
> 
>   bpftool map dump 30
> 
> Ditto for 'pinned'?
> 
> I.e. less typing, the tool can be smart enough to figure out what is
> that is being asked, i.e. is it a number? Try first it as an 'id', etc.

It's error prone, we have excellent bash completions and accept
prefixing (bpftool m d n pids_filtered), so typing should not be 
a problem.

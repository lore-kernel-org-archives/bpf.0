Return-Path: <SRS0=otRl=75=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6886CC433DF
	for <bpf@archiver.kernel.org>; Tue, 16 Jun 2020 06:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43CB120734
	for <bpf@archiver.kernel.org>; Tue, 16 Jun 2020 06:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VN3v2vWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgFPGA7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Jun 2020 02:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgFPGA6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Jun 2020 02:00:58 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA92C03E96A
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2020 23:00:58 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id a45so800380pje.1
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2020 23:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oVJ+WWTiAQFJ5lo3kGIwxsaIQ55gsub3o6JFM7EGzzw=;
        b=VN3v2vWsvdb+JAqJjrCWopnj8pCuaARbhbnhwznBBLuHtDdC9Dx3Fmv88T8oNE74oU
         Lp0X/E8oIsOYu41zcGNdXlH54BpQ5q3inGmupc7e/hZSvcugXFm9ZXG9c2iO58JFUbte
         4HdumfE/OGBEL8n5RemQTKC1hKcHHgWy4p/F4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oVJ+WWTiAQFJ5lo3kGIwxsaIQ55gsub3o6JFM7EGzzw=;
        b=Z0WQL5p/KOH7pbD0GN9n1UQ32mxAkY/okWAtWFPNi9HENFL1XC6n3BOfzatW9FP7gT
         FFRKfydT6Bt8idJnIEzi6WFg+ohXcojbFQVtqZuH1UPbxTNo4wtcmJuHMLXJpsv9a2uG
         G9VTC7WptSsgHIrcWfRed1fPcoEcHB2SDhW6fo66jHgzSbUzoQJ73Myh3dZfX1h8xHnd
         0tauz3NcbyhPgjBTZIzYUv7CcgBSLiiwOD6wwDiLCTDir4/9QOsrbcAfhRRKL04R/53H
         NWGkNDCoWWf8RgUfpK80otMSZztCWHbNdnwiP04kfX16WqNWrHB3+q4L7fEuV/3p1nXB
         AeDQ==
X-Gm-Message-State: AOAM530LbMwdfKWaI9Utsq7fKHgIfWI0vQMKAIapBAcLziUqztrrqZ4u
        r9aUHQ+hVsHbcX18gG3aCglCYA==
X-Google-Smtp-Source: ABdhPJzSoJucjBbu09dpaOjpONHtNhGpMwgkpd5utGgPOZZi5d/rZHyXM7oIEj1E6nQyE4OJFSCYhg==
X-Received: by 2002:a17:902:b690:: with SMTP id c16mr493854pls.273.1592287257786;
        Mon, 15 Jun 2020 23:00:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j8sm1207615pji.3.2020.06.15.23.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 23:00:56 -0700 (PDT)
Date:   Mon, 15 Jun 2020 23:00:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Lennart Poettering <lennart@poettering.net>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "zhujianwei (C)" <zhujianwei7@huawei.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Hehuazhen <hehuazhen@huawei.com>,
        Christian Ehrhardt <christian.ehrhardt@canonical.com>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: Re: new seccomp mode aims to improve performance
Message-ID: <202006152255.514C33D1@keescook>
References: <c22a6c3cefc2412cad00ae14c1371711@huawei.com>
 <CAADnVQLnFuOR+Xk1QXpLFGHx-8StPCye7j5UgKbBoLrmKtygQA@mail.gmail.com>
 <202005290903.11E67AB0FD@keescook>
 <202005291043.A63D910A8@keescook>
 <20200601101137.GA121847@gardel-login>
 <202006011116.3F7109A@keescook>
 <20200602124431.GA123838@gardel-login>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602124431.GA123838@gardel-login>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 02, 2020 at 02:44:31PM +0200, Lennart Poettering wrote:
> We have that actually, it's this line you pasted above:
> 
>         SystemCallArchitectures=native
> 
> It means: block all syscall ABIs but the native one for all processes
> of this service.

Gotcha. And I see this now as I'm working on the code to generating
bitmaps automatically.  After systemd-resolved applies the 26th filter,
the "compat" bitmap goes from effectively a duplicate of the native
syscall map to blocking everything.

after filter 25:
...
[    5.405296] seccomp: syscall bitmap: compat     0-4: SECCOMP_RET_ALLOW
[    5.405297] seccomp: syscall bitmap: compat       5: filter
...
[    5.405326] seccomp: syscall bitmap: compat     380: filter
[    5.405327] seccomp: syscall bitmap: compat 381-439: SECCOMP_RET_ALLOW

after filter 26:
...
[    5.405498] seccomp: syscall bitmap: compat   0-439: SECCOMP_RET_KILL_THREAD

So that seems to be working as expected. :)

-- 
Kees Cook

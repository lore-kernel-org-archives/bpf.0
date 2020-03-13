Return-Path: <SRS0=iznb=46=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1080C10DCE
	for <bpf@archiver.kernel.org>; Fri, 13 Mar 2020 02:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF30206F1
	for <bpf@archiver.kernel.org>; Fri, 13 Mar 2020 02:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTihegLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgCMCjd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 12 Mar 2020 22:39:33 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40006 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbgCMCjc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Mar 2020 22:39:32 -0400
Received: by mail-pl1-f196.google.com with SMTP id h11so3489227plk.7;
        Thu, 12 Mar 2020 19:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rs1oqWipH70EqXQPZoCyLHHvdHZcK5yX7KipafNzHgo=;
        b=fTihegLmnOtNBXny+Jn9Qu7R+3y3R1QNpb0QRLf4CwbwNTK8BGA3OtJLKMtEbQGZ2u
         MUZ56T++lciXe6odpK+LWItTj42+GZxM2dRa+LEnSr3Tk6D1Oj+H2p2gMgnSTlbyXHQj
         NLIsDFTlsrjyt8sM9MRN8NyGrO566G+kOdAkkqKEqrVMXMMoJQzC72ul2b8jJntKDzJb
         Ha3n3Ar0FuJoIy32b+bsyFUviu3OWz7LFdGe12KbNtA+IKMAUXPLss5d24QNHdvdvv4Q
         VVnpRT9w1rFHG3+RkCE6EEBAu1q/81Q5onKd4GaKh6mVPfa1llv03VRqg5c6jh+R8lSS
         ke0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rs1oqWipH70EqXQPZoCyLHHvdHZcK5yX7KipafNzHgo=;
        b=n5pvriatbKrzaM4K5F1DehISWCcfiT1SL6OQN9wGzg+MpE4kPwiHsqgVWPyPM4XGMo
         Cc9BolSm/FF6G5ulQhdkx7yoJKPOP00jze03/1V6KhPIZsS7EhWBAtSn6LLyiNnlmfj7
         x1IgzNaAUG0Ttf/iaI0/9CUBUDsQZQmGSuyapJ6/jr/wQZ5eDkI1WRmvW/WZj4wRzZ0j
         /TgZzKjv4HsNLWXGDPm6y5nrH+UbMJyDHgnzeFthee2XVhmzIQs9qI3/pBeqDRzzCQL7
         5nZa7jc1EVN57bkfmmD/dhC0uSx7ZE5rKSfXJqYqjiwggyB8i2BxlA1/wGUQkSOSxwuv
         Plzw==
X-Gm-Message-State: ANhLgQ3PbiCX4ZfDf4R0KRyIIIp0XSNoyKNccQQ+buUYwY1oPtpwNJZn
        CHOGameH7e78c0O4QooLAC4=
X-Google-Smtp-Source: ADFU+vtN4yL9qUHvbzyq1p40z4iEFHQlcLn80n6s/5i495YXE7lv6/J6aTYMCfxZ/XdpuzZm1zEv8w==
X-Received: by 2002:a17:90a:a48b:: with SMTP id z11mr7487175pjp.1.1584067171717;
        Thu, 12 Mar 2020 19:39:31 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:400::5:df27])
        by smtp.gmail.com with ESMTPSA id f4sm20951554pfn.116.2020.03.12.19.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 19:39:30 -0700 (PDT)
Date:   Thu, 12 Mar 2020 19:39:27 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>,
        Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Jakub Kicinski <kuba@kernel.org>,
        David Miller <davem@redhat.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Song Liu <song@kernel.org>
Subject: Re: [PATCHv5 00/15] bpf: Add trampoline and dispatcher to
 /proc/kallsyms
Message-ID: <20200313023927.ejv6aubwzjht55cf@ast-mbp>
References: <20200312195610.346362-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312195610.346362-1-jolsa@kernel.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 12, 2020 at 08:55:55PM +0100, Jiri Olsa wrote:
> hi,
> this patchset adds trampoline and dispatcher objects
> to be visible in /proc/kallsyms. The last patch also
> adds sorting for all bpf objects in /proc/kallsyms.

I removed second sentence from the cover letter and
applied the first 12 patches.
Thanks a lot!

> For perf tool to properly display trampoline/dispatcher you need
> also Arnaldo's perf/urgent branch changes. I merged everything
> into following branch:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/kallsyms

It sounds that you folks want to land the last three patches via Arnaldo's tree
to avoid conflicts?
Right?

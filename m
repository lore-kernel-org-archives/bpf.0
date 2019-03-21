Return-Path: <SRS0=yvf5=RY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2E5C43381
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 22:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB5B21916
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 22:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfCUWeu convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Thu, 21 Mar 2019 18:34:50 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51099 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfCUWet (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Mar 2019 18:34:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id z11so361251wmi.0;
        Thu, 21 Mar 2019 15:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=Gns+13VgxJz/q+t/aAGUVi/LwnQbj42C8Xpm7jAQue4=;
        b=Rjc0LHF5peVQ9OYYbckQY/BzkGGhqhcVnJQhpwfdL8BN2IeRaAcIll7xWD5At4Sqh2
         aoJNqHp3lbVHvfx7NXEjDTkiJ5QvAQitangPNQD73wHJc36rvHWAbnL4wVkRuAwskKAe
         zONJFCL/bHMmTppbTGTAlzyaHG4/lgnOXaw6NaSIjrDbBqz+lv26LEqmy1VsQOYSlcpo
         KtZhKRbwgNnDNprCyP14UkjVXapcg7VeRkijfcgJ/+yG82dqxxR/MdGs/0mVEcdUuZeb
         Xuk25xILAzrrYELVqYcEwmXEfG3ILZf4Jarg4xECzOIulaQN8JFVeR7nxvcoaBekEHGn
         jxjw==
X-Gm-Message-State: APjAAAU72zMnhXWytSwejfBNy1CKQd+wAh1+mZ31YHCcZyGRTL0dzClk
        zdluIIV/j+23QDtPTlNVvR4=
X-Google-Smtp-Source: APXvYqwwN+/Ltq/ykJPSR2nM3Mp0XeBQzdj1WkTNE9iq83ge+x2eKGrYj5rgDWsxOP022+PzEJ4r3Q==
X-Received: by 2002:a1c:c907:: with SMTP id f7mr924681wmb.39.1553207687515;
        Thu, 21 Mar 2019 15:34:47 -0700 (PDT)
Received: from localhost ([2a01:4b00:f419:6f00:b00c:66c8:99df:336])
        by smtp.gmail.com with ESMTPSA id p12sm4472398wrt.4.2019.03.21.15.34.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 15:34:46 -0700 (PDT)
Message-ID: <1a8149d1327109cdd2d65c4d1674b9fa932ed3d8.camel@debian.org>
Subject: Re: [PATCH bpf-next v4] tools/bpf: generate pkg-config file for
 libbpf
From:   Luca Boccassi <bluca@debian.org>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrey Ignatov <rdna@fb.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        bpf@vger.kernel.org
Date:   Thu, 21 Mar 2019 22:34:46 +0000
In-Reply-To: <80186d7b-ff21-e81f-1320-5916ecfcc99b@iogearbox.net>
References: <20190319210639.6282-1-bluca@debian.org>
         <20190321102531.31810-1-luca.boccassi@gmail.com>
         <20190321160042.GB13709@rdna-mbp>
         <20190321220107.pcvf6e23kun4gj7r@ast-mbp.dhcp.thefacebook.com>
         <80186d7b-ff21-e81f-1320-5916ecfcc99b@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2019-03-21 at 23:19 +0100, Daniel Borkmann wrote:
> On 03/21/2019 11:01 PM, Alexei Starovoitov wrote:
> > On Thu, Mar 21, 2019 at 04:00:46PM +0000, Andrey Ignatov wrote:
> > > luca.boccassi@gmail.com <luca.boccassi@gmail.com> [Thu, 2019-03-
> > > 21 03:26 -0700]:
> > > > From: Luca Boccassi <bluca@debian.org>
> > > > 
> > > > Generate a libbpf.pc file at build time so that users can rely
> > > > on pkg-config to find the library, its CFLAGS and LDFLAGS.
> > > > 
> > > > Signed-off-by: Luca Boccassi <bluca@debian.org>
> > ...
> > > > diff --git a/tools/lib/bpf/libbpf.pc.template
> > > > b/tools/lib/bpf/libbpf.pc.template
> > > > new file mode 100644
> > > > index 000000000000..0ecd334c109f
> > > > --- /dev/null
> > > > +++ b/tools/lib/bpf/libbpf.pc.template
> > > > @@ -0,0 +1,11 @@
> > > > +prefix=@PREFIX@
> > > > +libdir=@LIBDIR@
> > > > +includedir=${prefix}/include
> > > > +
> > > > +Name: libbpf
> > > > +URL: 
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > > > +Description: Linux kernel BPF library
> > 
> > github/libbpf/libbpf is a true mirror of kernel's libbpf.
> > I think if we start shipping libbpf.so from kernel and from github
> > it will be very confusing to the users...
> > Which one is the true libbpf?
> > Also the package should mention the license.
> > And the license for libbpf is dual lgpl/bsd.
> > But if we point to the url above it will not make much sense.
> > I think the packages URL should point to github/libbpf/libbpf
> > and packaging scripts should be in github only.
> > 
> > Daniel,
> > what do you think?
> 
> Looking at [0], I don't see where license would be part of the
> keyword. Given
> this is just a pkg-config file where folks using it care mainly about
> the
> needed cflags/libs, it would make sense to me to ship it and have it
> under
> tools/lib/bpf/ in kernel tree (since this is distro independent). If
> the URL
> and Description causes confusion, I would probably just remove the
> URL field
> since it's not mandatory either. And description, I'd put something
> like
> 'official BPF library' or such, so it's generic enough.
> 
>   [0] https://autotools.io/pkgconfig/file-format.html
>       https://dev.gentoo.org/~mgorny/pkg-config-spec.html#keywords

I assumed the license referred to the file itself, so I added the SDPX
comment. It's not too uncommon for pc files to have the license comment
at the top.

Removed URL and changed Descriptin in v6, thanks for reviewing!

-- 
Kind regards,
Luca Boccassi

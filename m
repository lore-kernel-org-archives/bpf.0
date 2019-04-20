Return-Path: <SRS0=qOzI=SW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0393CC282E1
	for <bpf@archiver.kernel.org>; Sat, 20 Apr 2019 00:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B0921855
	for <bpf@archiver.kernel.org>; Sat, 20 Apr 2019 00:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6lD08BR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfDTAaF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 19 Apr 2019 20:30:05 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36952 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbfDTAaF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Apr 2019 20:30:05 -0400
Received: by mail-pl1-f193.google.com with SMTP id w23so3232827ply.4
        for <bpf@vger.kernel.org>; Fri, 19 Apr 2019 17:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=crl0pHAvdqXo/krf5Kfg+ZUHhaI76BxKiIHb1kMe+cg=;
        b=m6lD08BRC7fu1/DpO4DrvnVbGiOvd5dHlsFNlr8ONtdu+MHExfmd9k456581yqvybg
         7tSo6/QsbZTzGk182JriLBy3zlItQmO5XLJJagY14FYEg9B5Z+YOBtupuA6T3lFSiMfm
         TgNnQUEM0ldJHM4LBT0XbXp5JqfEPQ6JnaPFFbJJMK6t1/pwncPytLvnCVzXWV0Dd9Ic
         KiwO6fby3N9xb6kdQPZ19A+1lAPYL3ZTCOGqEKk20655H7KW4jq81L/AlxTEof740/QQ
         Ozx+ogXuS7fnOOqMRooUlrl/fFI3i+jamYLY/179P2AwuYai00yhqcDSFv7U/zT5yAnn
         6V7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=crl0pHAvdqXo/krf5Kfg+ZUHhaI76BxKiIHb1kMe+cg=;
        b=bUXvTsRK9kOIkJMzBOzyiHRYiXWD2B8ZRj4jwhBbzMPXjn3p3VP66GPrmd5yZbEc/I
         ZPBxEyX88XyS7vp8CSTflXKaA+4hQzO3/h4jo4HMUrEwRVtuGCKVvX8U/4TOUd6s6XyA
         NL37umK03JKk2L5LGbYh/YeJ4bpjYfRUQQoJoIG3p7VO2V63TLsECgnHVqF6AXXLPywG
         ZzsDaLtMb7Ldk1uwRuZMvZFtBDyhvob+5/aJf2VDbhEoQLcwG1ZJQmQbTLLwFEGzuEku
         5kDXrnc0s3BzFd9Pxvo/QY5GnXH1Awfrrl8CVjzA/vWQhlERgXFG58rdzl4GKI5A+UTl
         jrQg==
X-Gm-Message-State: APjAAAWBjyxHOGAHKNPd1/LkYIQrp6InYlsdfl/olo3UcY+etOX4cjvz
        JXOTF5jIGGlncHWL+GRCtBQ4ecHQ
X-Google-Smtp-Source: APXvYqwas5Rl0Z5guQItV3X0jjlD2ay3DL28c4XRz7RO2IyVIKDPnNjI3EX6tmMq92LBR8n6YVRwgg==
X-Received: by 2002:a17:902:29c9:: with SMTP id h67mr6795059plb.114.1555720204376;
        Fri, 19 Apr 2019 17:30:04 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::6f64])
        by smtp.gmail.com with ESMTPSA id g67sm8206051pfg.94.2019.04.19.17.30.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 17:30:03 -0700 (PDT)
Date:   Fri, 19 Apr 2019 17:30:02 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     "Ananyev, Konstantin" <konstantin.ananyev@intel.com>
Cc:     bpf <bpf@vger.kernel.org>
Subject: Re: FW: BPF_PSEUDO_CALL question
Message-ID: <20190420003000.rxahvtjoih7gcnah@ast-mbp.dhcp.thefacebook.com>
References: <2601191342CEEE43887BDE71AB9772580148A95A96@irsmsx105.ger.corp.intel.com>
 <2601191342CEEE43887BDE71AB9772580148A97E27@irsmsx105.ger.corp.intel.com>
 <CAADnVQJoo7vSaCCFGpTgrQmCw4Cq-FcLhPtzr=YNaZ7y31ahLg@mail.gmail.com>
 <2601191342CEEE43887BDE71AB9772580148A9869C@irsmsx105.ger.corp.intel.com>
 <CAADnVQKuwL2j7-gOB9fEJ3CQydkPPgr8fT7FT_pzrOTBE=b5Cg@mail.gmail.com>
 <2601191342CEEE43887BDE71AB9772580148A99F8B@irsmsx105.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2601191342CEEE43887BDE71AB9772580148A99F8B@irsmsx105.ger.corp.intel.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 19, 2019 at 11:16:31AM +0000, Ananyev, Konstantin wrote:
> 
> 
> > > > >
> > > > > Hi Alexei,
> > > > > I posted the question below on llvm-dev mailing list, but there is no answer so far.
> > > > > As you seems the author of BPF_PSEUDO_CALL in LLVM (and linux kernel) thought might
> > > > > be you know the answer?
> > > > > I looked through the patches, but didn't spot anything myself.
> > > > > Thanks
> > > > > Konstantin
> > > > >
> > > > > -----Original Message-----
> > > > > From: llvm-dev [mailto:llvm-dev-bounces@lists.llvm.org] On Behalf Of Ananyev, Konstantin via llvm-dev
> > > > > Sent: Wednesday, April 10, 2019 7:37 PM
> > > > > To: llvm-dev@lists.llvm.org
> > > > > Subject: [llvm-dev] BPF_PSEUDO_CALL question
> > > > >
> > > > >
> > > > > Hi everyone,
> > > > > with clang 6.0 and onwards, for the following code:
> > > > > $ cat t6.c
> > > > >
> > > > > #include <stdint.h>
> > > > >
> > > > > extern int ffx1(const void *p);
> > > > >
> > > > > uint64_t entry(const void *p)
> > > > > {
> > > > >         return ffx1(p);
> > > > > }
> > > > >
> > > > > clang -O2  -target bpfel -c t6.c
> > > > > generates for the call BPF_PSEUDO_CALL instruction:
> > > > > entry:
> > > > >        0:       85 10 00 00 ff ff ff ff         call -1
> > > > >        1:       67 00 00 00 20 00 00 00         r0 <<= 32
> > > > >        2:       c7 00 00 00 20 00 00 00         r0 s>>= 32
> > > > >        3:       95 00 00 00 00 00 00 00         exit
> > > > >
> > > > > Is there any way to force clang to generate proper BPF_CALL instruction,
> > > > > i.e: 85 00 00 00 ff ff ff ff (as it did in older versions)?
> > > >
> > > > older version of llvm generated broken code.
> > > > there are only two call flavors:
> > > > - call imm -> calling particular kernel helper where imm==helper_id
> > >
> > > Ok but in the example above, is it possible tell to the llvm that
> > > ffx1() is actually a kernel helper with id==X?
> > 
> > here is how it works for helpers:
> > static void *(*bpf_map_lookup_elem)(void *map, const void *key) =
> >         (void *) BPF_FUNC_map_lookup_elem;
> > 
> > User space can hack similar thing for any integer and any name.
> 
> Thanks a lot.
> Yes, such approach would work.
> Though it means that user will need to define exact id for the each  helper function
> and keep it always in sync between bpf programs and bpf execution environment. 
> Probably not a big deal for kernel when all helpers are well defined and restricted,
> but might become messy for user-space where each app might want to have it's
> own set of helpers.
> My thought was - might be it is possible to say to llvm that it is a helper function
> but with unknown id that will be resolved dynamically at bpf load time.

I'm not sure what exactly you're proposing.
For local functions llvm will generate relative offset with pseudo_call mark.
That is api and cannot be changed.
Support for calling external functions is currently half way done,
since relocations are there, but could be buggy, since
there is no kernel/libbpf support for it yet.


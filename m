Return-Path: <SRS0=GcXc=RS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D390C43381
	for <bpf@archiver.kernel.org>; Fri, 15 Mar 2019 22:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB28218D0
	for <bpf@archiver.kernel.org>; Fri, 15 Mar 2019 22:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="ISb8iLfa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfCOWF4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Mar 2019 18:05:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36319 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfCOWF4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Mar 2019 18:05:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id p10so429744pff.3
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2019 15:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tZR3NvyvgI9FAd6NHSH76G6CMuZEuWEAU0R2dPeChg4=;
        b=ISb8iLfa8FTnI885XEbGnSRWKny4r0Nn4JMF0T7kKBzWQ1rjJX9npj78erz3SO3uSD
         oFmi9NF/9Jaxn0Bqw7lbP3rCWgOef++DEiY1rXTMHfS1DsaEQXEuVj377C0nH6gh+2s7
         eDe6/laL3VispluO9nMQnkdCeJATO5+0QvJFWpMqeoinfyHLmTPxV0W46fcpfRyFl57r
         PCkz1SjCa5812ZGfynTsIp32bILwIv6Owj2b9oTKuU6QCy77kgK79Zc/LiZMEgHKneCm
         Mb/4Lw8X4szAg8C3nfAAO1pG5bM8HnG1Bs3OO+/rEclUki45hDf25aSN/TV/UFlATtcj
         UISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tZR3NvyvgI9FAd6NHSH76G6CMuZEuWEAU0R2dPeChg4=;
        b=odVuM02TvQCQmk3yX3rsrrGrkhGWh2V7+PNaYjEWrYoppSUZL7MCYYo3l+k6vereun
         dacFbuiu5GiyzqaF4e8BQDqwBz8cUDP9GVLLsdy4HucqYDJWKufZpPLIzl52/jzCiSxL
         ITfG+NeRfuzhs3ZTE5MojHkz8m0mGx/ibh2S2ysvsyJEtUqT5sLjOxDOQh7m3BYf0RXs
         EHz0udYtRpBKgRlUIkJ90GrTYiFJMijotJY8uyNHVeNS9FVaJ8onGMHu6p4p7cwXsTAq
         qLaJ2BgbBx/RlSjpTo+PD7LfKbL3pUg/QvOhoHucetMxfsWvW+ydbKsCqufN4Pd05VRc
         4RZQ==
X-Gm-Message-State: APjAAAWcElEEtwlsRVug3LiGOfZlhEQ/ErxH++30Sw0h3LTwHrFjorLR
        342UmSgfIJMligWEsJVGgEn+RCdwR68=
X-Google-Smtp-Source: APXvYqxtiVG38E4EKOUGJRR/kirQR3IXXnGELJWrHcdgCVK7SHRG7c0SB2xVpo8Tkum9Akl1tPICwA==
X-Received: by 2002:a65:6554:: with SMTP id a20mr5632137pgw.170.1552687555620;
        Fri, 15 Mar 2019 15:05:55 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id q86sm8761255pfi.171.2019.03.15.15.05.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 15:05:54 -0700 (PDT)
Date:   Fri, 15 Mar 2019 15:05:54 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Ivan Vecera <ivecera@redhat.com>
Cc:     netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] selftests: bpf: modify urandom_read and link it
 non-statically
Message-ID: <20190315220554.GA7431@mini-arch.hsd1.ca.comcast.net>
References: <20190315200414.32346-1-ivecera@redhat.com>
 <20190315200847.GC5481@mini-arch.hsd1.ca.comcast.net>
 <2dcdc11c-4d04-4b0e-ddb7-04d969d04651@redhat.com>
 <20190315205652.GD5481@mini-arch.hsd1.ca.comcast.net>
 <1595006055.9467881.1552686646726.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595006055.9467881.1552686646726.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/15, Ivan Vecera wrote:
> 
> ----- Stanislav Fomichev <sdf@fomichev.me> wrote:
> > On 03/15, Ivan Vecera wrote:
> > > On 15. 03. 19 21:08, Stanislav Fomichev wrote:
> > > > On 03/15, Ivan Vecera wrote:
> > > > > After some experiences I found that urandom_read does not need to be
> > > > > linked statically. When the 'read' syscall call is moved to separate
> > > > > non-inlined function then bpf_get_stackid() is able to find
> > > > > the executable in stack trace and extract its build_id from it.
> > > > But why? Do you have some problems with it being linked statically?
> > > > 
> > > Dependency... you don't need to install static glibc to compile the bpf
> > > samples. Shared libc is available everytime.
> > Oh, the distros that do -devel _and_ -static packages :-)
> > 
> > So your patch essentially adds a call, that leaves a trace on the stack
> > with our build-id. I guess that works as well.
> 
> Without that additional call this does not work and build_id selftest fails.
Oh, yeah, I was just trying to clarify why it fails without -static and why
your patch makes it work for non-static :-)
You can put more details in the commit message; you'd have to resubmit
whenever net-next/bpf-next opens anyway.

> 
> I.

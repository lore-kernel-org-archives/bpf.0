Return-Path: <SRS0=+eov=SG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AC7C10F0E
	for <bpf@archiver.kernel.org>; Thu,  4 Apr 2019 17:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83814206DD
	for <bpf@archiver.kernel.org>; Thu,  4 Apr 2019 17:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbiimbUm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfDDRpt (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:45:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33201 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfDDRpt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Apr 2019 13:45:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id k19so1601025pgh.0;
        Thu, 04 Apr 2019 10:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hN5MisEH26xNq0u9qGXa8JP8UKlnpEsMWO9aDU/CRK0=;
        b=GbiimbUmR9V7EOPdvKcX7aWddu/A9XiuFtp2nlVdUKqjf5ONAAjtjEmW4kK1/+5TDr
         NV/UEfMbVVcZE2M35icq9YmKMFAZ3UorJ2ZUemySFETIx5FR941S7feEN0Co9en+NaMH
         N7OiUOMIUVuV8uglfhPxh+o24mEkfx2Q2/Blu/6Cv9k1QDEJ6bMo2O35uRgCLbSt95Ho
         U0ZAe8U3a+zhLlg3ad4Dlhj2V9btWQTxe/HyVxpp5Ib7USowazTHEdQ0Qmr2m2/WyPxY
         GHvNhP47HiS/28f/YG9Pk+IIUy315potV3dxG/IWCFKXOWjfFGhZ0xF3lrXPRJXIPcgf
         vwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hN5MisEH26xNq0u9qGXa8JP8UKlnpEsMWO9aDU/CRK0=;
        b=DE+Esnf+hPA04uYjOOdr3gpHayEvBUR/KViZmtYqfKOMxq+nK6LxvSc/iUZygMiBY+
         6BInJIeYKcYBS+qjVjWeUYeRzB/S+aVhLflx+1WHWMIumiTJCZ5NaKllAgN9STc6hNDt
         sMUW25hoCr+McTVIwRS5Dvq5il799PPSYO3hEMRMW8gx6hIVtEhKnYbDuC69oXAatgeq
         LCEXnvAfY4dtQiK3rLQXK6iRxvMDlLBIgjQAVhkH+9gLSjVYqzxVvOew3d0h2VmTc3fW
         Cqz94vve4f6y4sbxhvz0U0/3X0IIgqBEntax/L3ad9MXOVMaJN7hQA98FCB4ISl967to
         F5uw==
X-Gm-Message-State: APjAAAW5OiCHvKR7SGH6vNhjRWzp5KD7y8z+P9Yg36vdwxuUndGNZuOq
        EHYJ1PVfPyOFiRrYx73pk78=
X-Google-Smtp-Source: APXvYqzwrx7JJUIHRtqA4X5Uobzq4a/FKbL01X7v+V4fcYPAnC1lQhMVoNsCi4GwX1Wx+KkvKRY0Eg==
X-Received: by 2002:a65:6259:: with SMTP id q25mr7186558pgv.103.1554399948808;
        Thu, 04 Apr 2019 10:45:48 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::3:bfce])
        by smtp.gmail.com with ESMTPSA id f63sm22820452pfc.180.2019.04.04.10.45.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 10:45:47 -0700 (PDT)
Date:   Thu, 4 Apr 2019 10:45:46 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Edward Cree <ecree@solarflare.com>,
        Paul Chaignon <paul.chaignon@orange.com>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Xiao Han <xiao.han@orange.com>,
        paul.chaignon@gmail.com, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf] bpf: report verifier bugs as warnings
Message-ID: <20190404174544.lt4yuo7aykjss3px@ast-mbp.dhcp.thefacebook.com>
References: <20190402115811.GA6303@Nover>
 <a79d7f5e-637e-df0a-e99c-beea05eca1d7@iogearbox.net>
 <9d809442-b652-f68f-70e7-8be703c97244@solarflare.com>
 <20190403173029.lfwhblklss62yone@ast-mbp.dhcp.thefacebook.com>
 <4c5e5a55-5d53-f8cc-3628-9e20eb4137b0@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c5e5a55-5d53-f8cc-3628-9e20eb4137b0@iogearbox.net>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 04, 2019 at 12:41:32AM +0200, Daniel Borkmann wrote:
> On 04/03/2019 07:30 PM, Alexei Starovoitov wrote:
> > On Wed, Apr 03, 2019 at 04:52:40PM +0100, Edward Cree wrote:
> >> On 02/04/2019 15:37, Daniel Borkmann wrote:
> >>> If we really want to have a kernel warn, then lets add a
> >>> helper macro verbose_and_warn(...) which will trigger a one-time warning, but keeps
> >>> the verbose log intact as well.
> >> +1
> >>
> >> Any time the verifier detects that its internal invariants have been broken,
> >>  logging a warning is the right thing to do, just like any other part of the
> >>  kernel.
> > 
> > It's not black and white.
> > As I said I don't think verbose_and_warn() is necessary.
> > 
> > Messages like:
> > verbose(env, "bpf verifier is misconfigured\n");
> > are technically 'broken internal invariant', but it shouldn't be a warn.
> > 
> > Whereas this:
> >         if (WARN_ON(regno >= MAX_BPF_REG)) {
> >                 verbose(env, "mark_reg_known_zero(regs, %u)\n", regno);
> >                 /* Something bad happened, let's kill all regs */
> >                 for (regno = 0; regno < MAX_BPF_REG; regno++)
> >                         __mark_reg_not_init(regs + regno);
> >                 return;
> >         }
> > should stay as-is.
> > It's a warn, and verbose message, and clean of regs.
> > Similarly:
> >         if (WARN_ON_ONCE(ptr_reg)) {
> >                 print_verifier_state(env, state);
> >                 verbose(env, "verifier internal error: unexpected ptr_reg\n");
> >                 return -EINVAL;
> >         }
> > is a warn and more than just a verbose message.
> > 
> > verbose_and_warn() doesn't fit these two practical cases of warn + verbose.
> > Hence I see no reason to combine warn and verbose into single helper.
> > They're perfectly fine being separate.
> 
> Sure, I think that's okay as well; was mainly thinking to keep some of these
> WARN wrt broken internal invariant such that tools like syzkaller will actually
> generate a report w/ reproducer if it ever hits these (as opposed to just ignore
> them due to ignoring such logs in general).

That's a good point. People and bots react to kernel warnings.
My concern with generic WARN though that it adds unnecessary taint,
module, stack, register dumps that are useless to debug the verifier issue.
Also some folks use panic_on_warn and imo that is complete overkill
to panic the box when integrity of the kernel is sound.
When verifier hits such corner case it rejects the program and completes
cleanly. Worst case there will be memory leak, though unlikely.

I think we need special verifier_warn() helper that will do
pr_warn("WARNING: CPU: ..."); or whatever else necessary to capture
syzbot and human attention plus a message to ask folks to report bugs
to bpf@vger and include bpf program that triggered it?
Register and stack dumps shouldn't be in the warning.


Return-Path: <SRS0=8xVa=6M=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE37C83000
	for <bpf@archiver.kernel.org>; Tue, 28 Apr 2020 22:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD50220575
	for <bpf@archiver.kernel.org>; Tue, 28 Apr 2020 22:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmAh1I2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgD1WeK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 28 Apr 2020 18:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725934AbgD1WeJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Apr 2020 18:34:09 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4A0C03C1AC
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2020 15:34:08 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id r17so24782lff.2
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2020 15:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lw6s2LBsN4EtzRTMVsuXgcqom607s3gDHVYTRRtIXeY=;
        b=mmAh1I2imDXmWG4Sq+WkuKkK/m1iPrSBPsaNH/iQ6CzmoYZzodPzhTS2WGDYFwjeER
         OO026QkhEgTJQujQxzo9iWBHqos+BGqS+SQKZrBkHtgH4gNKauBO/JOOemHh9cd597wQ
         d5GsXfFCr97/5idzXPfFmYhxF5pJGt6nyERJn5bfV8wy3uMzRn7GPZ82F3N97n4Lie2j
         zFZ7k9fexGGjLsX3iSEC/6dItIYd7Ap5vM2WlO5koi9+pI0Wet3PrpbO+waXB5F8dxc/
         6KeTnJlAT+VfCvw0qR2k/+xJsnYqdeYSFJWXorm92hhgr9jbvjtu5TzPSgPdNHKh5tXo
         VEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lw6s2LBsN4EtzRTMVsuXgcqom607s3gDHVYTRRtIXeY=;
        b=Z80xkadYGSV0SI+S+9W3bgFqe8cZjKW6tBTCU/SLA/0qMvyDN4AaB7KQ7lgcpov0Im
         kKsxccroVWdxb6AdSVvNqouqKI5zs5quIsZjAU/RrHrSnhLEVHLYfkZQCpZUZQStUiru
         dCzcVyK/1hE76GL5NX13HwLlq51Vtpp7tvDeg9WOy2eEUl6MyHVRnG3Eyz/f40JB4wf5
         q/tBStvEoeKu7+1LzzntExZCrrp3V8e5gDddHMj5l/zPAw1DE+QqsD6Cr2JdtT4s0E2p
         okT3s9wh/32Dat1L0QmFvId+evHzz7ZDksmm9R9wRkCg8nPuFeea/IpHtLeNyfweqW53
         I46g==
X-Gm-Message-State: AGi0PuY0Pkpn4AH8VZWS9CEGMrQFHnKC6tUybRrDOtjGmQN8RcRfmFYm
        SSNszXVwgAEo/MDnhq2Z6DZEltyuPET9XdFCXD8=
X-Google-Smtp-Source: APiQypI8FvM01Fzv+Q/pdh2YyBqwI9B17H7e6KsSA15Q25mBiXf25TjpF29Owj5O62CjK183uGVIeTyyfH+PsKlrEec=
X-Received: by 2002:a05:6512:304e:: with SMTP id b14mr19456991lfb.119.1588113246670;
 Tue, 28 Apr 2020 15:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <4c14c01e-be39-817b-ca8c-200690ac4caf@intel.com> <1b8051db-20af-73ab-179e-8818bee7c7ee@fb.com>
In-Reply-To: <1b8051db-20af-73ab-179e-8818bee7c7ee@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 28 Apr 2020 15:33:55 -0700
Message-ID: <CAADnVQKFMpw+VJODvcOrq2Fnb6e-prV5cSQapWc96iRWOt8gzA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] [tools/bpf] workaround a verifier failure for test_progs
To:     Yonghong Song <yhs@fb.com>
Cc:     Ma Xinjian <max.xinjian@intel.com>,
        Alexei Starovoitov <ast@fb.com>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        "Li, Philip" <philip.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 27, 2020 at 11:14 PM Yonghong Song <yhs@fb.com> wrote:
> > -       int ret;
> > +      /* a workaround to prevent compiler from generating
> > +      * codes verifier cannot handle yet.
> > +      */
> > +      volatile int ret;
> >
> >          if (ctx->write)
> >                  return 0;
>
> Right. This is related to alu32 mode. The detailed description
> https://lore.kernel.org/bpf/20191107170045.2503480-1-yhs@fb.com/
>
> We are still working on this, either a verifier solution or a compiler
> workaround.

Thanks for the report.
I pushed the same fix for progs/test_sysctl_prog.c into bpf-next.
Now test_sysctl passes.

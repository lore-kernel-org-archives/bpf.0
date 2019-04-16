Return-Path: <SRS0=hZ0g=SS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147CFC10F14
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 16:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9344205ED
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 16:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnXABL68"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbfDPQNB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:13:01 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35179 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfDPQNB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Apr 2019 12:13:01 -0400
Received: by mail-lf1-f68.google.com with SMTP id j20so3603236lfh.2
        for <bpf@vger.kernel.org>; Tue, 16 Apr 2019 09:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hSBZgEuckU37y5hP+aq+czk+qQoN/c6jcl8bOgpj4IU=;
        b=EnXABL68hmQIH8B9f+1UDmkcYBRhXP858AeCbIbBeCmS4RcxmLTDLtLiAKtpIR2UD7
         gBReQsi7D1edBHaV3CU12dEBaMoWkeI/9qCKfON5tQdfDGmp96K/BMX0dERge7F3pIHa
         2ZTb2ekz7lU01BzxdWPzjiUFMzXt+aceKcQcJ3Ti64P42PHUnSylKF4YBIIjdqcr0I6M
         BHZZr1w3dlao3Mu/Rt10kzk4dVsh2pey1jZtBp9kNLzyFWyoH6YPNO/inmlhtPWYxbt3
         Z0/RgDulUALE81U1rjy6bT69kiS1124L4k2j+Yu9KNdXz2eD0Q7pZU3LhBAnoKPEEm7l
         0gjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hSBZgEuckU37y5hP+aq+czk+qQoN/c6jcl8bOgpj4IU=;
        b=DaAsaaSlL1IKBruTmG5Sza98DuyNp9/Zi1RNDInQrq8FP0wma9JJE7ZKh6YV1c3YTY
         HwyBmHqswZazTJMO9K3RfDAI3jIkqSe4fmvQ4NWXHL120sc/jYHRy1rbt5POhkTFU1ox
         v2bB7msISy51CB8eNLfCnVOws6qmUa4R7A+qkOWkgxjbcEcpTPvtNRG3zWUEJMppMXB8
         LshJcpabblWasWyHoJUMLfLvns5D2V10qQk7MGfboh59F4q7ALNm4J/ZO2goeuPLcc3f
         /+Y2OTYDbfGSYnOn/0P8xwVL2VqIiShF1RwSudVLS5WOKkV9vDWt/qZz0uvlBnC1DEVN
         4uLg==
X-Gm-Message-State: APjAAAVXr9lZiWjp3SghANh0WMHufSmr+gLZPKna1WOuBq1Batk0ZHqK
        N7SggGpKlssStsBK08dYA9VVQxgBX//EzEUU2DU=
X-Google-Smtp-Source: APXvYqwW6KwgOO0rQ9Ip5Zvw9wKg62DmrGp+9IapkCE13PAa2KGjIvresRKCClZVdBAKYpRmadvMZ3+TpbxOjj8QSMw=
X-Received: by 2002:a19:ca02:: with SMTP id a2mr15065463lfg.88.1555431179031;
 Tue, 16 Apr 2019 09:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <2601191342CEEE43887BDE71AB9772580148A95A96@irsmsx105.ger.corp.intel.com>
 <2601191342CEEE43887BDE71AB9772580148A97E27@irsmsx105.ger.corp.intel.com>
 <CAADnVQJoo7vSaCCFGpTgrQmCw4Cq-FcLhPtzr=YNaZ7y31ahLg@mail.gmail.com> <2601191342CEEE43887BDE71AB9772580148A9869C@irsmsx105.ger.corp.intel.com>
In-Reply-To: <2601191342CEEE43887BDE71AB9772580148A9869C@irsmsx105.ger.corp.intel.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 16 Apr 2019 09:12:47 -0700
Message-ID: <CAADnVQKuwL2j7-gOB9fEJ3CQydkPPgr8fT7FT_pzrOTBE=b5Cg@mail.gmail.com>
Subject: Re: FW: BPF_PSEUDO_CALL question
To:     "Ananyev, Konstantin" <konstantin.ananyev@intel.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 16, 2019 at 7:34 AM Ananyev, Konstantin
<konstantin.ananyev@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Alexei Starovoitov [mailto:alexei.starovoitov@gmail.com]
> > Sent: Tuesday, April 16, 2019 2:01 AM
> > To: Ananyev, Konstantin <konstantin.ananyev@intel.com>; bpf <bpf@vger.kernel.org>
> > Subject: Re: FW: BPF_PSEUDO_CALL question
> >
> > On Mon, Apr 15, 2019 at 5:13 AM Ananyev, Konstantin
> > <konstantin.ananyev@intel.com> wrote:
> > >
> > > Hi Alexei,
> > > I posted the question below on llvm-dev mailing list, but there is no answer so far.
> > > As you seems the author of BPF_PSEUDO_CALL in LLVM (and linux kernel) thought might
> > > be you know the answer?
> > > I looked through the patches, but didn't spot anything myself.
> > > Thanks
> > > Konstantin
> > >
> > > -----Original Message-----
> > > From: llvm-dev [mailto:llvm-dev-bounces@lists.llvm.org] On Behalf Of Ananyev, Konstantin via llvm-dev
> > > Sent: Wednesday, April 10, 2019 7:37 PM
> > > To: llvm-dev@lists.llvm.org
> > > Subject: [llvm-dev] BPF_PSEUDO_CALL question
> > >
> > >
> > > Hi everyone,
> > > with clang 6.0 and onwards, for the following code:
> > > $ cat t6.c
> > >
> > > #include <stdint.h>
> > >
> > > extern int ffx1(const void *p);
> > >
> > > uint64_t entry(const void *p)
> > > {
> > >         return ffx1(p);
> > > }
> > >
> > > clang -O2  -target bpfel -c t6.c
> > > generates for the call BPF_PSEUDO_CALL instruction:
> > > entry:
> > >        0:       85 10 00 00 ff ff ff ff         call -1
> > >        1:       67 00 00 00 20 00 00 00         r0 <<= 32
> > >        2:       c7 00 00 00 20 00 00 00         r0 s>>= 32
> > >        3:       95 00 00 00 00 00 00 00         exit
> > >
> > > Is there any way to force clang to generate proper BPF_CALL instruction,
> > > i.e: 85 00 00 00 ff ff ff ff (as it did in older versions)?
> >
> > older version of llvm generated broken code.
> > there are only two call flavors:
> > - call imm -> calling particular kernel helper where imm==helper_id
>
> Ok but in the example above, is it possible tell to the llvm that
> ffx1() is actually a kernel helper with id==X?

here is how it works for helpers:
static void *(*bpf_map_lookup_elem)(void *map, const void *key) =
        (void *) BPF_FUNC_map_lookup_elem;

User space can hack similar thing for any integer and any name.

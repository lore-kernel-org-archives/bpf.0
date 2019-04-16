Return-Path: <SRS0=hZ0g=SS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C503C10F0E
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 01:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1659B20818
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 01:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOfzBauF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfDPBBj (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Apr 2019 21:01:39 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40341 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbfDPBBj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Apr 2019 21:01:39 -0400
Received: by mail-lf1-f67.google.com with SMTP id a28so14564733lfo.7
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2019 18:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=cbZQQd1qzv5/7tHmKeT/sLzmIszu1MsPHCnJkgTHUy0=;
        b=gOfzBauFFQTxupAMYEhwdrASfzvzwV0CuIMYSkoHDpjazzbl7YYfVdkpExqfv/IUAJ
         KISmasE1E4YcqSCTlea2HfeT5CNSS/yaox6G6ffbei1DMAB6LtnRBWVeOdZx5NFcgSzs
         tascJ/k4P7u4YDHiKiJNrWYvDXhy3gHHB1OE5qqyhblWBQvarXXN47QlClYRH75/rZZ2
         r9kQ9hR0QUIGYfFvYVD0piNJ2WiuQmYqhJTjCKq/uDuNZRQQ/VegOZOXWEa+pBnKt11r
         JI89YyA42kw8Ei+tz0pvmuTTWMtZkEgP3YLlN3T96U7l4uknhhYyOgmxXLbE9jWlou86
         ixjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=cbZQQd1qzv5/7tHmKeT/sLzmIszu1MsPHCnJkgTHUy0=;
        b=s5P5brpKiT+wag96DE1cESryLpgJY6w8HGIhHLqNFSFaO2KQWdLvEhL3efSpJ0e8u9
         SMsV5cBs4W9Lb1jDKARHI3J2PNv4oXq1/QEAPounoXaDQFvhrlAo4Er1kUumgmRahlw0
         3beArKsityAbwSG5wKE6gNb0G1UiYUQEs+cTRDlojlu5XKNdXDvylooW0YQDJGm5s28Q
         B1mD0FZ8cY+BlIkvmJEOGtisPvjaBZ2EBj7D2ZvSbkayqglVOVFtebDovlsMKABr7D7Z
         uNXhHBqJkkDZ+qv2MubP/oX/PXe3C07FGxuu83DgWWWWht4G2WMgX1HVOq0q2B7Z1zJQ
         WZzA==
X-Gm-Message-State: APjAAAVc1Mootsv36hqmL3ebjvFDP1xKDaV5t2kGB6ppwa7bxa2ViU0I
        ++httfIjUcRuaNC3xMuaqjfCOaQaufn89IzcySk=
X-Google-Smtp-Source: APXvYqz6CWYsAvB0xFxIPOXmArnPuL9pMYe6v5iSEdZ3bWJCtiPDG4brg2jaMawG3edBTfUMFJ6omQuIbXyV+sEzpjk=
X-Received: by 2002:ac2:592b:: with SMTP id v11mr18563345lfi.85.1555376497078;
 Mon, 15 Apr 2019 18:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <2601191342CEEE43887BDE71AB9772580148A95A96@irsmsx105.ger.corp.intel.com>
 <2601191342CEEE43887BDE71AB9772580148A97E27@irsmsx105.ger.corp.intel.com>
In-Reply-To: <2601191342CEEE43887BDE71AB9772580148A97E27@irsmsx105.ger.corp.intel.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 15 Apr 2019 18:01:25 -0700
Message-ID: <CAADnVQJoo7vSaCCFGpTgrQmCw4Cq-FcLhPtzr=YNaZ7y31ahLg@mail.gmail.com>
Subject: Re: FW: BPF_PSEUDO_CALL question
To:     "Ananyev, Konstantin" <konstantin.ananyev@intel.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 15, 2019 at 5:13 AM Ananyev, Konstantin
<konstantin.ananyev@intel.com> wrote:
>
> Hi Alexei,
> I posted the question below on llvm-dev mailing list, but there is no answer so far.
> As you seems the author of BPF_PSEUDO_CALL in LLVM (and linux kernel) thought might
> be you know the answer?
> I looked through the patches, but didn't spot anything myself.
> Thanks
> Konstantin
>
> -----Original Message-----
> From: llvm-dev [mailto:llvm-dev-bounces@lists.llvm.org] On Behalf Of Ananyev, Konstantin via llvm-dev
> Sent: Wednesday, April 10, 2019 7:37 PM
> To: llvm-dev@lists.llvm.org
> Subject: [llvm-dev] BPF_PSEUDO_CALL question
>
>
> Hi everyone,
> with clang 6.0 and onwards, for the following code:
> $ cat t6.c
>
> #include <stdint.h>
>
> extern int ffx1(const void *p);
>
> uint64_t entry(const void *p)
> {
>         return ffx1(p);
> }
>
> clang -O2  -target bpfel -c t6.c
> generates for the call BPF_PSEUDO_CALL instruction:
> entry:
>        0:       85 10 00 00 ff ff ff ff         call -1
>        1:       67 00 00 00 20 00 00 00         r0 <<= 32
>        2:       c7 00 00 00 20 00 00 00         r0 s>>= 32
>        3:       95 00 00 00 00 00 00 00         exit
>
> Is there any way to force clang to generate proper BPF_CALL instruction,
> i.e: 85 00 00 00 ff ff ff ff (as it did in older versions)?

older version of llvm generated broken code.
there are only two call flavors:
- call imm -> calling particular kernel helper where imm==helper_id
- call pseudo +-off -> call another bpf function
there is no arbitrary call support yet.

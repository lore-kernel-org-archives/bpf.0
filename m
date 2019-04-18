Return-Path: <SRS0=qXn4=SU=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15DCC10F14
	for <bpf@archiver.kernel.org>; Thu, 18 Apr 2019 05:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1CCD21479
	for <bpf@archiver.kernel.org>; Thu, 18 Apr 2019 05:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDU78u/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbfDRFzm (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 18 Apr 2019 01:55:42 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40963 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfDRFzm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Apr 2019 01:55:42 -0400
Received: by mail-oi1-f194.google.com with SMTP id v7so695927oie.8;
        Wed, 17 Apr 2019 22:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+c00hv0VFtvPdZjbyIpUhzKSGraJKCvqrNEpFV9/CDU=;
        b=CDU78u/70Bn9Kka72ID4QJC4Y5XatlHC8R4gtssHWpeG7i/NbqjFnXUYmNnQoOJBPv
         XQCvmT3BzRirUAQ6Y9GrhPIFbiWiwmtYZYp4DMO7mbF4ch3u2rkipzBkC7ek4/n+27il
         is90JJkJniBc9AfXu6YMT5va0m4Irx2XdLYEewsYKbOWMbL8KN8h81wLdx8+NkdvX6Tk
         /VSi5MZs8kRSYq6ndicCcaCZGs3Ekq21kOIpXXb8/GJ00dcT4fZ18DYIwzpnkefO0CdG
         0RBYuUunf1/YDaER7/4bmoKoASBF+z8zNJ03gVxzB047lKzfCbTm1mur5A6PXjPmBOYE
         7JMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+c00hv0VFtvPdZjbyIpUhzKSGraJKCvqrNEpFV9/CDU=;
        b=fYfTWI+5pPuvMImQvICOKS2F2fweUaB1CZXJOGkW44ZXMCn5r7aTxavyBbvxrjocjR
         5UyGZGrx/mTEe/YUIlkTocED/LJeiaLhjkW1sOlskfeYOmIDW458rFF6G+xUPhNtlnrx
         Myxw1BUfe3gtk2fCh1osFUlWsvHuRAM9EQN/W3MoEhmcZKUKAhyi1tBg2KGglX9sf3/E
         BET32Vmfsx+vWRXfW87tnOFkpSBSPs7DeyAMnaNNqWUdQGwMt2zBCrS4hAHBU2esZ2OQ
         ZA4tUWh74aUrNHMtfgQUJXdQ3KSwt0xmdjx8jnUItEnShWR3K8qlfMWlIhPuRD1RdUya
         jtvQ==
X-Gm-Message-State: APjAAAWgQWHg6w/9GM7PN5WIw7iUyJ+cZZdYBd/z54fPpSCLbBQtiiGa
        ScNLPc3p0vEm0//C1n73Cwdww+QS8Wg1fYnogwg=
X-Google-Smtp-Source: APXvYqxgHrT9qc3Bvetn2hw/RpvQ9/w9xKVr7NXSkxrb5XlVLPHmBaZ2HChXVWI5mvvi6dnvqVHkIK7XAdHSrl+Nn7A=
X-Received: by 2002:aca:f511:: with SMTP id t17mr777910oih.115.1555566941476;
 Wed, 17 Apr 2019 22:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190418115748.0b0aefdc@canb.auug.org.au>
In-Reply-To: <20190418115748.0b0aefdc@canb.auug.org.au>
From:   Magnus Karlsson <magnus.karlsson@gmail.com>
Date:   Thu, 18 Apr 2019 07:55:30 +0200
Message-ID: <CAJ8uoz1T5xzx+RhJ=NZQ-WJhawE765ncMQUPMD9uGWHMeiuqOQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Networking <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 18, 2019 at 3:59 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the bpf-next tree, today's linux-next build (powerpc perf)
> failed like this:
>
> In file included from xsk.c:32:
> libbpf_util.h:49:3: error: #warning Architecture missing native barrier functions in libbpf_util.h. [-Werror=cpp]
>  # warning Architecture missing native barrier functions in libbpf_util.h.
>    ^~~~~~~
> cc1: all warnings being treated as errors
>
> Caused by commit
>
>   b7e3a28019c9 ("libbpf: remove dependency on barrier.h in xsk.h")
>
> I have applied the following patch for today ... please fix this.
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 18 Apr 2019 11:54:56 +1000
> Subject: [PATCH] suppress warning in tools/lib/bpf/libbpf_util.h
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  tools/lib/bpf/libbpf_util.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf_util.h b/tools/lib/bpf/libbpf_util.h
> index 172b707e007b..a54eb2cdbdd6 100644
> --- a/tools/lib/bpf/libbpf_util.h
> +++ b/tools/lib/bpf/libbpf_util.h
> @@ -46,7 +46,7 @@ do {                          \
>  # define libbpf_smp_mb() asm volatile("dmb ish" : : : "memory")
>  # define libbpf_smp_rwmb() libbpf_smp_mb()
>  #else
> -# warning Architecture missing native barrier functions in libbpf_util.h.
> +//# warning Architecture missing native barrier functions in libbpf_util.h.
>  # define libbpf_smp_rmb() __sync_synchronize()
>  # define libbpf_smp_wmb() __sync_synchronize()
>  # define libbpf_smp_mb() __sync_synchronize()
> --
> 2.20.1
>
> --
> Cheers,
> Stephen Rothwell

My apologies, I will fix this. I just have two questions first so I do
not mess things up.

* I see my commit in bpf-next but not in bpf. As I submitted it
against bpf, what was the reason it was applied to bpf-next instead?
Unfortunately, I forgot to add "Fixes" tags to the commits, so was
this the reason? I view 4 out of 5 of these patches as bug fixes, the
last one being an optimization.
* Do you want a separate patch for this fix or a V4 of the original
patch set? Against bpf-next or bpf (with Fixes tags)?

Thanks: Magnus

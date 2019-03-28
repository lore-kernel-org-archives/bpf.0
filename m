Return-Path: <SRS0=idkB=R7=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D833C43381
	for <bpf@archiver.kernel.org>; Thu, 28 Mar 2019 16:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E0320823
	for <bpf@archiver.kernel.org>; Thu, 28 Mar 2019 16:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7rGY1JH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfC1QAI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:00:08 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35534 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfC1QAI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Mar 2019 12:00:08 -0400
Received: by mail-qk1-f193.google.com with SMTP id a71so6176172qkg.2;
        Thu, 28 Mar 2019 09:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1ANN3+Ang5qb++Fi9W3ZJhgbdN5eQJD0LAopSrOfW0w=;
        b=A7rGY1JHZ32ZdpRsvX/xE/PegF+u1/HI0uyZc6Ybp5aj431o+cnbSVvjuU9QXZb+C6
         1y0KYNF4x0S0CmBnZ5SL3AikGMpn83ATGBgBPEQt2IY0J1Vlthm89oFVP5JIaAzhwxOy
         +PCbtVbDXeJZGhKtYxj7qXTh9ys1LmFgUo8UOk4haYx+GrGwJqVr/dPj4rgJsPWH5aXQ
         Za08RN4hCBD5OtUPewVFNY08mDLwwDNWWfunGY6ZwzIXwGpuo9Y8f932DGN5F5C5ny+/
         zIYh/jaqn/rXwq5t7CeQOCju3XmDK9n6HptB7O9MxnXPPdSqKOt/X8aUdNwSq+TRdXqb
         jPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1ANN3+Ang5qb++Fi9W3ZJhgbdN5eQJD0LAopSrOfW0w=;
        b=WbZwtksuvmk+vc9d1bNQxZ8I9iao+iFwSbPq7d/5qbqpriKq+XLHEOHu4Wqd+RE+h5
         csVHxrp1ajqP5MihWtQt9lXPAW39PjgIMGaMiQptIpYWTkKsr9LTkjjUyz5057XCexlx
         97nSSDsz3iOxREpU7WZ6rWC47GXQrkWNU07Oi22dcMzejgG354t5/75oQEodgj4Jqp1V
         0sqQ57knNnbSmujuzQChCCG+nw14PRXZSvGF3nkiD6EDJ8q7re2z8f/yR4ygd8qhS15d
         DY96EqIqREvmZvOlqU4dZiu+Hd5fslp9B7ug7fEEUbISjysXKpbtfrqCAZhc25VwK1ic
         f+wg==
X-Gm-Message-State: APjAAAUUdumW/IwQmCEyio4D2da3mHT9sKcdNDMkZ3RTek4r3/Q9M3Ax
        F9gLszf/Q7EdM0rdnvsT+AoZugQheMncVHekOO0=
X-Google-Smtp-Source: APXvYqy/zgMm8L72GRF9G6MbtDU0iFsfaFxYJnxReeCDAG6aUleH515sRJ4gjmr/SX/vLcJY1k0e9Dqwn0g6Zfy6Hw0=
X-Received: by 2002:a37:478b:: with SMTP id u133mr34193283qka.280.1553788807480;
 Thu, 28 Mar 2019 09:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190327135114.17026-1-bjorn.topel@gmail.com> <4bca355e-379c-fb41-0168-1889dba912c4@iogearbox.net>
In-Reply-To: <4bca355e-379c-fb41-0168-1889dba912c4@iogearbox.net>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Thu, 28 Mar 2019 16:59:55 +0100
Message-ID: <CAJ+HfNiySCcZ+541Tunn3C=MeA-wysJcVor8z_xfrwowGYXqow@mail.gmail.com>
Subject: Re: [PATCH bpf 0/2] libbpf: minor packaging fixes
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        bpf <bpf@vger.kernel.org>, Ye Xiaolong <xiaolong.ye@intel.com>,
        "Zhang, Qi Z" <qi.z.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 28 Mar 2019 at 16:39, Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 03/27/2019 02:51 PM, Bj=C3=B6rn T=C3=B6pel wrote:
> > The DPDK project is moving forward with its AF_XDP PMD, and during
> > that process some libbpf issues surfaced [1].
>
> Great to hear!
>
> > This series address two, minor, packaging issues for libbpf. The
> > header file xsk.h was missing from the instal_headers target and
> > libelf was not included in the libbpf.so (shared library) build.
> >
> >
> > Thanks,
> > Bj=C3=B6rn
> >
> > [1] https://patches.dpdk.org/patch/50704/#93571
> >
> > Bj=C3=B6rn T=C3=B6pel (2):
> >   libbpf: add xsk.h to install_headers target
> >   libbpf: add libelf dependency to shared library build
> >
> >  tools/lib/bpf/Makefile | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
>
> Looks good, applied, thanks (also fixed up various typos in the commit
> message while applying).

Thank you for fixing the typos!

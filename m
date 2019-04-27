Return-Path: <SRS0=xnNa=S5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766C5C43219
	for <bpf@archiver.kernel.org>; Sat, 27 Apr 2019 16:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42BD9206C1
	for <bpf@archiver.kernel.org>; Sat, 27 Apr 2019 16:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIye4mZe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfD0QRW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 27 Apr 2019 12:17:22 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34303 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfD0QRW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Apr 2019 12:17:22 -0400
Received: by mail-lj1-f196.google.com with SMTP id s7so2922725ljh.1;
        Sat, 27 Apr 2019 09:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vRoeEA8kVzn1ZzacaHMvuFmHtORZlL9I6dCzN3lueQY=;
        b=DIye4mZeGXINzVldhHQjDePVKtG7T6FIbBKgI3pKXeWvEnvAMAaB8ey03um7rC5dQF
         Kc7yEfU0XlQRqvMgAvAOW9J/cVzYJVB6PUzuYA9kREa14B6S4mnYksWhRv243eduZ168
         W5b5wWRQicUr+VEUgw4BYai91f1pSxw3QfTQOAPekSbD5BJC0FuwLvfrvQ0R/zkxrrFy
         4SbpVxKeJa2WpULrWhohjfY5z46iY8I2WwhiB/Fyxg/WAbN9ZR3FBoOfKMrF3qYOeUz3
         EL4MgN6Q7/QXfwfa268b0aOi3ZU916Af10f0ID5KHaEPVkc0rOtDerwTQFUaxnvjZX2w
         I6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vRoeEA8kVzn1ZzacaHMvuFmHtORZlL9I6dCzN3lueQY=;
        b=ByHjRZbgg7rAYAiS+fbCj9RTsXfrd4IZDJcBgEaF/eTuLrGGN5g1Ix8dEB+x0dDRp4
         L7rJz3t75BiQ4Vu4kctZFEsOtoGVju6X4BIbMCumzKs0hHw8hcs+QMCZ1zlZoRN4s8tI
         yFYi4pXNwSI0nqhYP3ThElSSazVohEfujtIiAz4ry0vhKbklY46QRXBd4e8abxel3Ukr
         Ugs79xtWapVLwMdVILBt/gzZRT40V2jTlCdxXxzygIWL1TGzWfpokSI6BkgDUWLp3ivL
         FWe+ElYDqZzvxTLh9LsxnESp9OQisjpkiJJqYeKESv6X+aA1hkkOyOJFMpC5RuV8xhWp
         9P1g==
X-Gm-Message-State: APjAAAVFazZ1H3+h0VIsnDhjBzx0SY7MfntOOk+g5/Aa38DHsH7cS98H
        Iloq/vQZfKKFfdxLNMlLU3AN+8hKzoF6n+3PGFQ=
X-Google-Smtp-Source: APXvYqzt2ArQx0XpzM9DyoRp1sr3sbSAw0TTIYmMBYs8bRSYO13sSj5YLHe2O1MjcSSCJzPty1bFRkvcY7+EQMatfqs=
X-Received: by 2002:a2e:9213:: with SMTP id k19mr13171994ljg.118.1556381840328;
 Sat, 27 Apr 2019 09:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190426233938.1330361-1-kafai@fb.com> <f0489bd3-1b30-7a50-4ec4-9b5e95459149@fb.com>
In-Reply-To: <f0489bd3-1b30-7a50-4ec4-9b5e95459149@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 27 Apr 2019 09:17:08 -0700
Message-ID: <CAADnVQJ86=C6iMq=-oDLa8NucipZU+W2-Hk1dH-zynhr2D1f9g@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 0/7] BPF sk local storage
To:     Yonghong Song <yhs@fb.com>
Cc:     Martin Lau <kafai@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Kernel Team <Kernel-team@fb.com>,
        Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 27, 2019 at 9:01 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 4/26/19 4:39 PM, Martin KaFai Lau wrote:
> > v4:
> > - Move checks to map_alloc_check in patch 1 (Stanislav Fomichev)
> > - Refactor BTF encoding macros to test_btf.h at
> >    a new patch 4 (Stanislav Fomichev)
> > - Refactor getenv and add print PASS message at the
> >    end of the test in patch 6 (Yonghong Song)
> >
> > v3:
> > - Replace spinlock_types.h with spinlock.h in patch 1
> >    (kbuild test robot <lkp@intel.com>)
> >
> > v2:
> > - Add the "test_maps.h" file in patch 5
> >
> > This series introduces the BPF sk local storage.  The
> > details is in the patch 1 commit message.
> >
> > Martin KaFai Lau (7):
> >    bpf: Introduce bpf sk local storage
> >    bpf: Sync bpf.h to tools
> >    bpf: Support BPF_MAP_TYPE_SK_STORAGE in bpf map probing
> >    bpf: Refactor BTF encoding macro to test_btf.h
> >    bpf: Add verifier tests for the bpf_sk_storage
> >    bpf: Add BPF_MAP_TYPE_SK_STORAGE test to test_maps
> >    bpf: Add ene-to-end test for bpf_sk_storage_* helpers
>
> Looks good to me. Ack the whole series.
>
> Acked-by: Yonghong Song <yhs@fb.com>

Looks great to me as well.
Applied to bpf-next. Thanks!

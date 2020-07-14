Return-Path: <SRS0=I/LR=AZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5490C433E2
	for <bpf@archiver.kernel.org>; Tue, 14 Jul 2020 17:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E20D22518
	for <bpf@archiver.kernel.org>; Tue, 14 Jul 2020 17:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDn39TUD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgGNR1L (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 14 Jul 2020 13:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgGNR1K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jul 2020 13:27:10 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67260C061755;
        Tue, 14 Jul 2020 10:27:10 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b25so24066858ljp.6;
        Tue, 14 Jul 2020 10:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d/v3ugtaoaOeeCDKdWeSP04gWYycv9xDFMo0+OwVZsM=;
        b=FDn39TUDnLKv2d3Ic2pcY6nNJA/xhkRxFHyu2KS4n7eCDG4cjRWF/hnudKre0WGtAp
         /VxeI5+inK5qrnjaBzbN60SSGJzH41KkNcPAqZw21nTXZUn/t5OtOpo9GP68LGsASR6P
         Si+HlMcqW9h+qrOBRsraX9NOcEKN2iQVa5bm8gnXEHYlDcE5acn3dJ5ewpRp/+7gaUsW
         cunNmQLFQjk5B2lrEki3SnH3k307EDA6d0znIRpnZLZtUDryhrTnpU9shR/hNmQ+r4of
         hafCs7rO6/V1aFLT/NiAcN//7VDN7d3vttE3TiNodWV5FZXtrpXNhni6v8v1wbq5cv/y
         azYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d/v3ugtaoaOeeCDKdWeSP04gWYycv9xDFMo0+OwVZsM=;
        b=cuh82uXqKaCiy+BRgBR5G/YojY9WOZ5rn2FCnUXv+JOOozaEutuZlHxcQcVgoYHSqG
         nnhxpctnp8Rz+cH5sAuusVyABvp2meOlQibvXLT2rLh9T+yj+IFflfFs1hEYkHEYzdDk
         mOZDqU2xieZOpX54r2KInJi1l9fdxqdGDcpdp/GqC+0vw02PTEZJoftHvnkaTnmWzdid
         TIAg6DLrM+R/Otk7P9Rnk8MZ1n3550eN3Dndkqv1WB1RrHdaO0v/0Y57bWFjE0/eWW6M
         K29gmcJXwC9G6a0z1Ic+3QlAnIGxccNXNMHpyQcNoZSxlduTeJPjw+QgmL9ypgQUPMR7
         70Hw==
X-Gm-Message-State: AOAM530k7Vlpm+Vht1Lh4pWryfzD3mpSGRnQzX5DwCsUECpmDTTKbjhi
        0Swus4T5eZICHT4BvxVracIsLdNko1WFQ1LaBMncNA==
X-Google-Smtp-Source: ABdhPJyd9I670SmqM+mvNNHi3ybvzs0STgRsdsxofdqoNWMlagrYZDBy9Q68A31RJydfx/+AxeDsDb+sKaM+e4mO2oc=
X-Received: by 2002:a2e:9a4d:: with SMTP id k13mr2944671ljj.283.1594747628856;
 Tue, 14 Jul 2020 10:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200714102534.299280-1-jolsa@kernel.org>
In-Reply-To: <20200714102534.299280-1-jolsa@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 14 Jul 2020 10:26:57 -0700
Message-ID: <CAADnVQ+w_93sZuk-gRbFWYCL9_ocPxD1OmhcCcX3mZ4qD7kayw@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf: Fix build for disabled CONFIG_DEBUG_INFO_BTF option
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 14, 2020 at 3:25 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Stephen reported following linker warnings on powerpc build:
>
>   ld: warning: orphan section `.BTF_ids' from `kernel/trace/bpf_trace.o' being placed in section `.BTF_ids'
>   ld: warning: orphan section `.BTF_ids' from `kernel/bpf/btf.o' being placed in section `.BTF_ids'
>   ld: warning: orphan section `.BTF_ids' from `kernel/bpf/stackmap.o' being placed in section `.BTF_ids'
>   ld: warning: orphan section `.BTF_ids' from `net/core/filter.o' being placed in section `.BTF_ids'
>   ld: warning: orphan section `.BTF_ids' from `kernel/trace/bpf_trace.o' being placed in section `.BTF_ids'
>
> It's because we generated .BTF_ids section even when
> CONFIG_DEBUG_INFO_BTF is not enabled. Fixing this by
> generating empty btf_id arrays for this case.
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Applied both to bpf-next. Thanks for the quick fix.

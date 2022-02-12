Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B70C433EF
	for <bpf@archiver.kernel.org>; Sat, 12 Feb 2022 00:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354455AbiBLAmf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 11 Feb 2022 19:42:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239705AbiBLAme (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 19:42:34 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD22D7F;
        Fri, 11 Feb 2022 16:42:32 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id i10so8140774ilm.4;
        Fri, 11 Feb 2022 16:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k4k6rNvzVlXDXj/ubK40ftAwf2hZfA9zC7YgyyIJAyo=;
        b=hFueVid8GSKqWdJGgHt8Bd4lrOtcriPaOVGMSo+BYZXNLujD/ObXWh087Abbj3YFyA
         yuh/oaptN7B9wuKZ2mN0FfWthwbtzKRYYMwgDc08o3cRA/6mPCz63E4NCLXb/k6q/lVX
         /na9+Yg2+ejPkIIbqL/2TOwT6TU3JApDzlpH3u4+NOcJuqrxk7vscUveHLfhXf5FigJ+
         pYyhE1gLBYji1cIsXnIC0mFrcfB09x9K90BX/dzOx9w5PTDTqv0Xi6rXfxayd1nNHHMf
         hu3A6k+DKTUDIV7jf5zTK1Z4Hry958+G1Qc6leF+btJySdRhrQJyo5Wl7f/28uvhRNv/
         AmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k4k6rNvzVlXDXj/ubK40ftAwf2hZfA9zC7YgyyIJAyo=;
        b=LPzyia3NtPiKPeglse9yVQcGgCF0m0QbRjCLm7WvEDeqiPFV/3LoLerzrpNbLla49O
         6BJFmxaDYHhwp3iFML4dAzWZbLpcwU03XyJmfR8Om8eWEM/XTXInwh90BGfNjP25NwIC
         /wbmF/i7QlwosuWC3OcLlR9wSENj2nXRLDxNFwlS0uAnQ8CR7p0aemq1PTWTGtwjhnio
         FXhgCStcE4qcr5LOp0Uu+mrMa2EFPXiz5hFlmNFe+gYeq5EHEGztQ91BiAzQ47PklkJR
         pyhaoM0AFYDMNW+TuM0+CZBElp+5BSGuXvzZ/r07MfisieD+QQzrJeXEO/x+d11Z/Zx3
         yolA==
X-Gm-Message-State: AOAM530YKwR9leVNkjmcD0KLxBcdpjgqnd95agGiwyn1LMVOOM2LByWM
        73Ye8vL/FxfqJknuP/6PzBou/zMWwTpgFyz3g/pecwrY
X-Google-Smtp-Source: ABdhPJwOmnRoW/rXVjysqh/EPhM8gdeeMFON7F8w8lLocmH7IWn821xj9LY0ZqiREXpDFCi/iEjEGlFWHnbD2QAJfD0=
X-Received: by 2002:a05:6e02:1bcd:: with SMTP id x13mr2216910ilv.98.1644626551920;
 Fri, 11 Feb 2022 16:42:31 -0800 (PST)
MIME-Version: 1.0
References: <20220209222646.348365-1-mauricio@kinvolk.io> <20220209222646.348365-2-mauricio@kinvolk.io>
In-Reply-To: <20220209222646.348365-2-mauricio@kinvolk.io>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Feb 2022 16:42:20 -0800
Message-ID: <CAEf4BzbEPEFEzdShpPgPyA=aYj5UJwbC=Dod=yrcqWAzPUuqgg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/7] libbpf: split bpf_core_apply_relo()
To:     =?UTF-8?Q?Mauricio_V=C3=A1squez?= <mauricio@kinvolk.io>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Rafael David Tinoco <rafaeldtinoco@gmail.com>,
        Lorenzo Fontana <lorenzo.fontana@elastic.co>,
        Leonardo Di Donato <leonardo.didonato@elastic.co>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 9, 2022 at 2:27 PM Mauricio V=C3=A1squez <mauricio@kinvolk.io> =
wrote:
>
> BTFGen needs to run the core relocation logic in order to understand
> what are the types involved in a given relocation.
>
> Currently bpf_core_apply_relo() calculates and **applies** a relocation
> to an instruction. Having both operations in the same function makes it
> difficult to only calculate the relocation without patching the
> instruction. This commit splits that logic in two different phases: (1)
> calculate the relocation and (2) patch the instruction.
>
> For the first phase bpf_core_apply_relo() is renamed to
> bpf_core_calc_relo_insn() who is now only on charge of calculating the
> relocation, the second phase uses the already existing
> bpf_core_patch_insn(). bpf_object__relocate_core() uses both of them and
> the BTFGen will use only bpf_core_calc_relo_insn().
>
> Signed-off-by: Mauricio V=C3=A1squez <mauricio@kinvolk.io>
> Signed-off-by: Rafael David Tinoco <rafael.tinoco@aquasec.com>
> Signed-off-by: Lorenzo Fontana <lorenzo.fontana@elastic.co>
> Signed-off-by: Leonardo Di Donato <leonardo.didonato@elastic.co>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  kernel/bpf/btf.c          | 13 +++++--
>  tools/lib/bpf/libbpf.c    | 71 ++++++++++++++++++++---------------
>  tools/lib/bpf/relo_core.c | 79 ++++++++++++---------------------------
>  tools/lib/bpf/relo_core.h | 42 ++++++++++++++++++---
>  4 files changed, 109 insertions(+), 96 deletions(-)
>

[...]

Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BE6C43334
	for <bpf@archiver.kernel.org>; Tue, 21 Jun 2022 18:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiFUSod (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 21 Jun 2022 14:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiFUSob (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 14:44:31 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DD629346
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 11:44:31 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id h23so29327808ejj.12
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 11:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2XgJgEMaRQ6uLS5e6Nrfc0BIVvUlSGGb6fq4smQ2+UY=;
        b=b26p518cPTBUn6iWLqzqcwNZhN8FDZEeFa2Xmtjc5h7pe3cAqxEFyxNMuq4RiQ0lM/
         On/0Y1Dzy/dRw6ZK64enxn4Z9MkqAl+BYQfXsLMj1munSWD4vMiPHu4yIfMAyUWi3X4E
         zbL0lxT4PD2nFdjgzva7Xs99AEKjxMUR5KXagwpFrjguSBcSxfDDpatw9A8D3xWRxTDu
         t0pmu5OHh6bz9y2t307mC3WL+6GxAKEvM23SUHTTjA0IROG6SXFi7QNkRt76NIGaa76h
         KeqZ0b+nfO7vyOFor19fE6SLsqioutxmUp7QFcmQNOQ2l/cZhfgOG1AkACtq68CzJ5vm
         wUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2XgJgEMaRQ6uLS5e6Nrfc0BIVvUlSGGb6fq4smQ2+UY=;
        b=KBkB8/NHxCuDkmxaYqcIYos9bJ4wm8NzkL9Y237SvUJepymqajEm1syZUKhk90acRL
         9M7fxLhYune7L931CGzlBTZJt07a7B00xPfZN3OdxVAeYhfter8FAQF7ci7GQWW7Ec2z
         6tRDAiHUkY2VNFI8f5nUSo1CT9tn1DQoYt+IQ88F2JI1lCI8bgdxCuLRVkM+v0HODy0d
         sFahBjOwhIFtYrjYfla2kS1u4czALL+E3seY8HOTxfslbwV4nPD2gNVToM256YJcQjeM
         j3vHWyWx/iOIawQvqqhM1Fn4zmQKlLCFxdIS0Nt1QBhKZpOG8Vsqg0PgC9Y82r86jhxd
         0FzQ==
X-Gm-Message-State: AJIora8FQgQzW5i/GLL6xjBDQy1KqXe2FwoljBrkOngHKlMNjJ2O2VBa
        sjiBjbyy+K1/Rmj6fcT3Hat+Yz7TgrRNBM58bvg=
X-Google-Smtp-Source: AGRyM1sWOxevOvjd1KIcSgXIs8bifCHlxnO6jOvbhx6q63Wja/e5TpgLRQ5xNhfuslx5QBIuFanVJKhpBgLTD71Demc=
X-Received: by 2002:a17:906:7488:b0:722:d6af:eaf0 with SMTP id
 e8-20020a170906748800b00722d6afeaf0mr7201776ejl.708.1655837069581; Tue, 21
 Jun 2022 11:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220620231713.2143355-1-deso@posteo.net> <20220620231713.2143355-5-deso@posteo.net>
 <20220620235919.q4xsy7xqxw2rrjv3@macbook-pro-3.dhcp.thefacebook.com> <20220621164556.4zh5yajzlvf6mglo@muellerd-fedora-MJ0AC3F3>
In-Reply-To: <20220621164556.4zh5yajzlvf6mglo@muellerd-fedora-MJ0AC3F3>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 21 Jun 2022 11:44:17 -0700
Message-ID: <CAADnVQJKiiFafS5R3-3RmKCRNxWzLuqhqyahRN=eyM4dsg07-A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/7] libbpf: Add type match support
To:     =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 21, 2022 at 9:46 AM Daniel M=C3=BCller <deso@posteo.net> wrote:
>
> On Mon, Jun 20, 2022 at 04:59:19PM -0700, Alexei Starovoitov wrote:
> > On Mon, Jun 20, 2022 at 11:17:10PM +0000, Daniel M=C3=BCller wrote:
> > > +int bpf_core_types_match(const struct btf *local_btf, __u32 local_id=
,
> > > +                    const struct btf *targ_btf, __u32 targ_id)
> > > +{
> >
> > The libbpf and kernel support for types_match looks nearly identical.
> > Maybe put in tools/lib/bpf/relo_core.c so it's one copy for both?
>
> Thanks for the suggestion. Yes, at least for parts we should probably do =
it.
>
> Would you happen to know why that has not been done for
> bpf_core_types_are_compat equally? Is it because of the recursion level
> tracking that is only present in the kernel? I'd think that similar reaso=
ning
> applies here.

Historical. Probably should be combined.
Code duplication is the source of all kinds of maintenance issues
and subtle bugs.

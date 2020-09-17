Return-Path: <SRS0=dFgW=C2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A6FC43464
	for <bpf@archiver.kernel.org>; Thu, 17 Sep 2020 23:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C825E208E4
	for <bpf@archiver.kernel.org>; Thu, 17 Sep 2020 23:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600385255;
	bh=TAt15TsSrMGN6mCCoJC+SrYRfG+RQ4dUa+I1Lf1b9dY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ARO/RoEjxdP9/ICkZ/8Hfu0M9wmWd1FeAzjEiClMnXESFGgcDnICXDZaai1Dliu1v
	 LyZmWbGM0BwosbXVkhp5Hq5w5TfLPj/cSofNc/FnwWRdpConLUK+x1/0IoCWXfdXDs
	 3ENpthvWxGGrdHDpxnaIXO+XDwB8fOcSuUtj1n8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgIQX1f (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 17 Sep 2020 19:27:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:57496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgIQX1f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Sep 2020 19:27:35 -0400
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56CF32137B;
        Thu, 17 Sep 2020 23:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600385254;
        bh=TAt15TsSrMGN6mCCoJC+SrYRfG+RQ4dUa+I1Lf1b9dY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kiadUYoTzFcKjOH9WVAVKJOgGvvR4fUbaUftEQdhTr85mQID74MED8w5xqJLNCrs8
         +7haqPt5FSuaJJtGA+7grtwAQDhJMdqp+P3BH+F8zbrr/ZJSXmjiWFaM4pvLHeWOtI
         Z1ElPN0ReQivDHXOImM+/36Z11eC04FC95v1kxlQ=
Received: by mail-lf1-f50.google.com with SMTP id y17so4053757lfa.8;
        Thu, 17 Sep 2020 16:27:34 -0700 (PDT)
X-Gm-Message-State: AOAM533P3HBYe6F8rgizP/shCxFxElsk80aOz3/r+0CBWWr6jnV4FuDl
        rxplxAO/W8OJe5rG1isbmS7/jmJRSFs7Xq6vZBk=
X-Google-Smtp-Source: ABdhPJy2LNAUGROp9wcndbIKAKcdFbFpd00XB7SAzGI+Ld3qp7bAnOgBuKJx7+yndvub7hHyU2cmfRmdbsQa+g8CqYA=
X-Received: by 2002:a19:8907:: with SMTP id l7mr9741246lfd.105.1600385252612;
 Thu, 17 Sep 2020 16:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200917115833.1235518-1-Tony.Ambardar@gmail.com> <33dd4a10-9b2a-7315-7709-cd8e7c1cd030@isovalent.com>
In-Reply-To: <33dd4a10-9b2a-7315-7709-cd8e7c1cd030@isovalent.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 17 Sep 2020 16:27:21 -0700
X-Gmail-Original-Message-ID: <CAPhsuW62F8CkQbrZpg-YEA+qyZ7=ra+aRwMaxEyU6zKBqZRCnQ@mail.gmail.com>
Message-ID: <CAPhsuW62F8CkQbrZpg-YEA+qyZ7=ra+aRwMaxEyU6zKBqZRCnQ@mail.gmail.com>
Subject: Re: [PATCH bpf v1] tools/bpftool: support passing BPFTOOL_VERSION to make
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Tony Ambardar <tony.ambardar@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 17, 2020 at 7:58 AM Quentin Monnet <quentin@isovalent.com> wrote:
>
> On 17/09/2020 12:58, Tony Ambardar wrote:
> > This change facilitates out-of-tree builds, packaging, and versioning for
> > test and debug purposes. Defining BPFTOOL_VERSION allows self-contained
> > builds within the tools tree, since it avoids use of the 'kernelversion'
> > target in the top-level makefile, which would otherwise pull in several
> > other includes from outside the tools tree.
> >
> > Signed-off-by: Tony Ambardar <Tony.Ambardar@gmail.com>
>
> Acked-by: Quentin Monnet <quentin@isovalent.com>

Acked-by: Song Liu <songliubraving@fb.com>

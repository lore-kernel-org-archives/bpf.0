Return-Path: <SRS0=7UPC=4O=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8119C4BA24
	for <bpf@archiver.kernel.org>; Wed, 26 Feb 2020 18:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5802465D
	for <bpf@archiver.kernel.org>; Wed, 26 Feb 2020 18:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582743303;
	bh=UsPSLRot6Sz7N6Du1xP8bHnROj7bI20BC9G/STQLhJk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JaGHHDwZQF4P3pEgSuuvwGRAH8OKP1t7g0HC/gato3wmTUG2qt9oApzvLE/P+LwzK
	 0gRxQaniX7sa3KLQxJ9AIec7E5tw0RVbbJCOinTwnsxUA/dS6jXdrVIIBfgtmu4K64
	 Si1JI2cZKy9YejbKF9EiAhHsCz+/dPK3CYEvhSX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbgBZSzD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 26 Feb 2020 13:55:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:41982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbgBZSzD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Feb 2020 13:55:03 -0500
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0A7124670;
        Wed, 26 Feb 2020 18:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582743302;
        bh=UsPSLRot6Sz7N6Du1xP8bHnROj7bI20BC9G/STQLhJk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xkvJdPQFqhLTg0qVhOAO1uoulBem7I5h58aD5dg94JO9Y79DFrkxgrwcW+8vS3huD
         CU5RWIW/Agka07GPl5H8ac2hjg47slUmE34KvUpx2gQ2OrzBRyL1pKfod4maMluURq
         9xEySuPjnIL5YXGK/L2TMudXZDFNKUvQ06rBAwNM=
Received: by mail-lf1-f51.google.com with SMTP id b15so129755lfc.4;
        Wed, 26 Feb 2020 10:55:01 -0800 (PST)
X-Gm-Message-State: ANhLgQ0p9kp8x0XajEvUEoNHW2haDU0YuaS2UL3QkcyjkbvC9GXJF8qK
        eof0TW84sNAtXIMOM2R/LzQ7QjCQZY1IGsdyKQ4=
X-Google-Smtp-Source: ADFU+vtt+AwJJAMQeSNCii2v9AvugDj/HxerECNpPw7wrDrFFsJUybiNHdmzFLy10LL/a3xZOQkTwAd5ysVxtvH7y1A=
X-Received: by 2002:a05:6512:6cb:: with SMTP id u11mr33967lff.69.1582743299825;
 Wed, 26 Feb 2020 10:54:59 -0800 (PST)
MIME-Version: 1.0
References: <20200226130345.209469-1-jolsa@kernel.org> <20200226130345.209469-3-jolsa@kernel.org>
In-Reply-To: <20200226130345.209469-3-jolsa@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Wed, 26 Feb 2020 10:54:48 -0800
X-Gmail-Original-Message-ID: <CAPhsuW58iB1=32sOXwB5cY2ATbV7n2GPZ0ihXFXmj8EUVXMsTg@mail.gmail.com>
Message-ID: <CAPhsuW58iB1=32sOXwB5cY2ATbV7n2GPZ0ihXFXmj8EUVXMsTg@mail.gmail.com>
Subject: Re: [PATCH 02/18] bpf: Add bpf_trampoline_ name prefix for DECLARE_BPF_DISPATCHER
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Jakub Kicinski <kuba@kernel.org>,
        David Miller <davem@redhat.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 26, 2020 at 5:04 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>
> Adding bpf_trampoline_ name prefix for DECLARE_BPF_DISPATCHER,
> so all the dispatchers have the common name prefix.
>
> And also a small '_' cleanup for bpf_dispatcher_nopfunc function
> name.
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Song Liu <songliubraving@fb.com>

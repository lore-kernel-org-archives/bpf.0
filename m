Return-Path: <SRS0=9mof=BI=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A694C433DF
	for <bpf@archiver.kernel.org>; Wed, 29 Jul 2020 21:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 482F82070B
	for <bpf@archiver.kernel.org>; Wed, 29 Jul 2020 21:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596058200;
	bh=uaBHlb+/DK7ID4xmv9w7ZAnkLGuB3Gvu9gOKa+1I2NM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kso6HTaM6pHq7IV/nRXYEbX7AIxNqjYEE7an0J16yH3cy1FnalE41UsGsHDY2jQRy
	 01iweIQottaCLrhvFW407NmdPmTqhyeoRWGDyugWZ8ul3QcO4ChXN28wU3IjKenQ8i
	 X1+N5bYo003vv94Rf2xebJ61jH76Oec7NzLiR/Sw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgG2V37 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 29 Jul 2020 17:29:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgG2V37 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jul 2020 17:29:59 -0400
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B9DF2070B;
        Wed, 29 Jul 2020 21:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596058199;
        bh=uaBHlb+/DK7ID4xmv9w7ZAnkLGuB3Gvu9gOKa+1I2NM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Pm+DA+czSBR6PccrWY7kW4/MBdCb2hJcjtGRigiE0DhiLh5NGleOoVgUvG3MB8g59
         4pbr/ixN8WQ58pRpcRny/3wBE2/ggvFKAYY9s+FeThupfrIopshO+hrqrCWSbLrcu9
         8nHfBiOgUqiDG8tcb6M991MpiV7yZyjAZ0cZ9hwo=
Received: by mail-lj1-f182.google.com with SMTP id q7so26647009ljm.1;
        Wed, 29 Jul 2020 14:29:59 -0700 (PDT)
X-Gm-Message-State: AOAM531/c+j5LsYFW1O+V0ozVz9nTxkGEykU9htPS8MXnXMNp2N1njbu
        5rgchVDx8WX8xWBYLisqdzU+0VGvs+jsJl9LKnI=
X-Google-Smtp-Source: ABdhPJxXd2CIxbtKxtJVA07SnTe9GaS5F3gJXTXl01Qpq/8jl/nlx06w13Ypf6oFf5arvieiXJgrzj2x7+p2xRqkFzE=
X-Received: by 2002:a2e:3003:: with SMTP id w3mr134829ljw.273.1596058197453;
 Wed, 29 Jul 2020 14:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <159603940602.4454.2991262810036844039.stgit@john-Precision-5820-Tower>
 <159603977489.4454.16012925913901625071.stgit@john-Precision-5820-Tower>
In-Reply-To: <159603977489.4454.16012925913901625071.stgit@john-Precision-5820-Tower>
From:   Song Liu <song@kernel.org>
Date:   Wed, 29 Jul 2020 14:29:46 -0700
X-Gmail-Original-Message-ID: <CAPhsuW77ifBOovgEHi=5LpyOkksFnDHSjYzbgjAjgpPP2-VMhQ@mail.gmail.com>
Message-ID: <CAPhsuW77ifBOovgEHi=5LpyOkksFnDHSjYzbgjAjgpPP2-VMhQ@mail.gmail.com>
Subject: Re: [bpf PATCH v2 1/5] bpf: sock_ops ctx access may stomp registers
 in corner case
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 29, 2020 at 9:24 AM John Fastabend <john.fastabend@gmail.com> wrote:
>
> I had a sockmap program that after doing some refactoring started spewing
> this splat at me:
[...]
> least reported it so it must a fairly rare pattern.
>
> Fixes: 9b1f3d6e5af29 ("bpf: Refactor sock_ops_convert_ctx_access")
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>

Acked-by: Song Liu <songliubraving@fb.com>

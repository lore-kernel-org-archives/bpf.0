Return-Path: <SRS0=CYzr=X5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6447BC4CED1
	for <bpf@archiver.kernel.org>; Fri,  4 Oct 2019 17:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3515D21D81
	for <bpf@archiver.kernel.org>; Fri,  4 Oct 2019 17:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0IC1K0P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388428AbfJDRxf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 4 Oct 2019 13:53:35 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34357 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388195AbfJDRxe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Oct 2019 13:53:34 -0400
Received: by mail-qt1-f194.google.com with SMTP id 3so9740238qta.1;
        Fri, 04 Oct 2019 10:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XZtPrAuiyJow88xMJcgaW2oGIpQkaG6LyvDnnhFC908=;
        b=I0IC1K0PJvUuKC9eZ+WY49NbkALLddx7G3URSB0o8HusFSIY2hVILSebarp0s5ZoeB
         R0yezv6zjfLTg/5dFgIGXaM2/JHEFkUfIJOt0OCXizJSsUaG36D5Rr2yQ0krxvkTvrPT
         WTwjPZNqgiPiXD0Dpci4VM1HtPoo0AEPhRuYrwuyAKEnO9QASCYH9xOfoVkTAA/o7IjB
         rfkssMvYXtpUp/LpbcDqs2NMqvq/XXXdG8c9UR5MZZSFV4zoZ8smuqjMtR5chctDguGD
         5vsROsyHWulhGMxNrPTrN7YkZCJgNewG5XHS5xDeVZJZMTF+xc5KP/f32J4k5kPhbTk0
         14fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XZtPrAuiyJow88xMJcgaW2oGIpQkaG6LyvDnnhFC908=;
        b=m+usZCdsLfa9UgRgGBg8iLeUmoM/o046YRXvSzYdHGsv6titwSjKBIGFDjYJ+Q7dLh
         o15ezyb9B4EPW2H1ziPVexxXIts9gHQGCOXylCCdxePovuP9+KVQ6f0f1qIUOaV2BjxA
         MpYUqjeMYgZkiuONaWJEVELDQN6QoPq2tye/tY4ez8mZy6N7YOi0ljNd0VMxYkEczWWw
         TmKwTf2hlVGAZO6fv9zUIjYdSZmoRkSwlkALqyqWmSaSmZXlFfgqC7BRB2M5c7JsyX5Q
         +1DUvmLLyyn4fEYvXF9R1k9WSZ2b7bKGOnM3CX+yF+n6ThgENS1Dif9ojDHK/ht1oRYj
         qlaA==
X-Gm-Message-State: APjAAAUMODXG7fCcrQWDnTTmePMC7f7EP7/r78q6rIIRVYVgj5TUil8A
        /swxHEtIu6CK6Q3Ztx2bznViFjpFsVR4fbNiqS0=
X-Google-Smtp-Source: APXvYqykZtTePGrXzDyF0uJ1d3l98isG+Z4F2EB5FFRtHnRgeS1A2/vR+i72fl3ua3Ephx4PVb314qmXWv/xshvk6Ow=
X-Received: by 2002:ac8:37cb:: with SMTP id e11mr17615377qtc.22.1570211613271;
 Fri, 04 Oct 2019 10:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191004155615.95469-1-sdf@google.com> <20191004155615.95469-2-sdf@google.com>
In-Reply-To: <20191004155615.95469-2-sdf@google.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 4 Oct 2019 10:53:22 -0700
Message-ID: <CAPhsuW6-mdSLFDUdGL1eh2n2Wx32GDsvjCSSyv1dxom1g=uUow@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf/flow_dissector: add mode to enforce
 global BPF flow dissector
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Petar Penkov <ppenkov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 4, 2019 at 8:58 AM Stanislav Fomichev <sdf@google.com> wrote:
>
> Always use init_net flow dissector BPF program if it's attached and fall
> back to the per-net namespace one. Also, deny installing new programs if
> there is already one attached to the root namespace.
> Users can still detach their BPF programs, but can't attach any
> new ones (-EEXIST).
>
> Cc: Petar Penkov <ppenkov@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Acked-by: Song Liu <songliubraving@fb.com>

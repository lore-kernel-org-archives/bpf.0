Return-Path: <SRS0=Ijne=BG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F64BC433E3
	for <bpf@archiver.kernel.org>; Mon, 27 Jul 2020 21:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CC6720792
	for <bpf@archiver.kernel.org>; Mon, 27 Jul 2020 21:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595883786;
	bh=1FXX0DmeDOPmuqYa0d5iK7Cesjiyd/VF/y/ujga9uJg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0e/LelIIoAPlXLvagdatFvOYaHlLCdvhUfSa3OwH/JwFvBfp/GqvroXxcvmFqhdaN
	 WV+Dlks06/uH6LCcrsJrRj2xHB43D+AKMlhkWjiXPh5uSxy6wRT48z2M5ktVaPhP3B
	 qYTWCYWQ7V04a8md1FNT7voYo/qCB9PPQAvpZ/4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgG0VDG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 27 Jul 2020 17:03:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgG0VDF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jul 2020 17:03:05 -0400
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3047820729;
        Mon, 27 Jul 2020 21:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595883785;
        bh=1FXX0DmeDOPmuqYa0d5iK7Cesjiyd/VF/y/ujga9uJg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Au9x1QkiXiIp72pzS6gDY612z1fLvWqYBh/j8Z6Ya2mJQHdT/LuhHs1F7aEPen8xo
         X2/RPYCszlwXCaRNJvLNWIrxILitbnfm6HAMTnOiyQUzrpdCwlmeLqjzXOhAL/MWe0
         TYmHj32FPjOdKsNS/arr49RtrMPxoGI897NOGb2c=
Received: by mail-lj1-f171.google.com with SMTP id s16so3574445ljc.8;
        Mon, 27 Jul 2020 14:03:05 -0700 (PDT)
X-Gm-Message-State: AOAM533SQP/YFDLzv+KgmuviMWSa22MA0K9yI0wkzVkNw45YoxqGsmVE
        txJb03qaInryJGrHvzA3fdZyWF5xyTqlkxF1N0E=
X-Google-Smtp-Source: ABdhPJwTJ/A/UkrLkp/KUTbyBeTC43fg3iIMCR0XQZfDJ4INYZw4oGb9K0Qr56LQnZtJT//ukFydzcx8qZagLmBlLd4=
X-Received: by 2002:a2e:3003:: with SMTP id w3mr11124287ljw.273.1595883783568;
 Mon, 27 Jul 2020 14:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200724011700.2854734-1-andriin@fb.com>
In-Reply-To: <20200724011700.2854734-1-andriin@fb.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 27 Jul 2020 14:02:52 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4M1TOccZvLE5Ppv06amn-ST1WBYhtFRsScJX_0yE9Ojg@mail.gmail.com>
Message-ID: <CAPhsuW4M1TOccZvLE5Ppv06amn-ST1WBYhtFRsScJX_0yE9Ojg@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: fix map leak in HASH_OF_MAPS map
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 23, 2020 at 6:17 PM Andrii Nakryiko <andriin@fb.com> wrote:
>
> Fix HASH_OF_MAPS bug of not putting inner map pointer on bpf_map_elem_update()
> operation. This is due to per-cpu extra_elems optimization, which bypassed
> free_htab_elem() logic doing proper clean ups. Make sure that inner map is put
> properly in optimized case as well.
>
> Fixes: 8c290e60fa2a ("bpf: fix hashmap extra_elems logic")
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>
Cc: <stable@vger.kernel.org> # v4.14+

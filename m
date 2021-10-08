Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0ECC433EF
	for <bpf@archiver.kernel.org>; Fri,  8 Oct 2021 06:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CDB16112D
	for <bpf@archiver.kernel.org>; Fri,  8 Oct 2021 06:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhJHGHh (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 8 Oct 2021 02:07:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229511AbhJHGHh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 02:07:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 86E8661108
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 06:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633673142;
        bh=bCQij0i0U5aXg2iEmI41SPl2cN0TOty2gAj9xOF4DLc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YHSPcFFrtisd01HV8vaih74nrDHXwO98VGazF9K++oV5DvPYCNciDcaDPYG3lCkqW
         t5fx3SUgC2FNTiZ6fwQCKrGuYRb5OEZuGRRFTH5r4hjfHulv3lpp91BUa+hwJQpQmQ
         BBcM6m+tZxYxlbn7a+15goZooJ4Bd26of8RgXDOCruBjNmz3AosfRY5uTdPf4jS4nQ
         MOXYHIjcp9LFt3GyoWiaGHIg/3Pf2Zz4WE74oKF7M804CHBdKgvEibZVUTJu2P3nsa
         9iphgtPmUEwZfeIt9U+MEbE7ht/eC79u/AEc1B/6hax1ThlH1prwI7sl3Q8nekmTN5
         idHEMAUMvn4Cg==
Received: by mail-lf1-f45.google.com with SMTP id u18so34465549lfd.12
        for <bpf@vger.kernel.org>; Thu, 07 Oct 2021 23:05:42 -0700 (PDT)
X-Gm-Message-State: AOAM531QG78zot+uQd2WI+SxSNsPQyrNhItAsjyr77u+/3xsciAuTamw
        7xAP3rrXCBLW6hH+U5nwEErkJjOkaWgdva5000s=
X-Google-Smtp-Source: ABdhPJws1Tmn3r8EOIm5ntnzi9o/ph5BaNaPwJk6HsFMFVOEEClTKNxrEImD3pFtTu8/DWHOo60JRmzCIzlTzZXf9Vc=
X-Received: by 2002:a05:6512:1052:: with SMTP id c18mr8456842lfb.223.1633673140838;
 Thu, 07 Oct 2021 23:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211008000309.43274-1-andrii@kernel.org> <20211008000309.43274-6-andrii@kernel.org>
In-Reply-To: <20211008000309.43274-6-andrii@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Thu, 7 Oct 2021 23:05:29 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6dtMf16fPVycS18hUjiBaxGL+kmeP6rmqNhz9d2cyjRA@mail.gmail.com>
Message-ID: <CAPhsuW6dtMf16fPVycS18hUjiBaxGL+kmeP6rmqNhz9d2cyjRA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 05/10] bpftool: support multiple .rodata/.data
 internal maps in skeleton
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 7, 2021 at 5:04 PM <andrii.nakryiko@gmail.com> wrote:
>
> From: Andrii Nakryiko <andrii@kernel.org>
>
> Remove the assumption about only single instance of each of .rodata and
> .data internal maps. Nothing changes for '.rodata' and '.data' maps, but new
> '.rodata.something' map will get 'rodata_something' section in BPF
> skeleton for them (as well as having struct bpf_map * field in maps
> section with the same field name).
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Song Liu <songliubraving@fb.com>

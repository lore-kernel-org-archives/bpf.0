Return-Path: <SRS0=Avyz=2G=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A291C43603
	for <bpf@archiver.kernel.org>; Mon, 16 Dec 2019 22:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA4E2176D
	for <bpf@archiver.kernel.org>; Mon, 16 Dec 2019 22:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btTd7jPL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfLPWzF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:55:05 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37369 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfLPWzE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Dec 2019 17:55:04 -0500
Received: by mail-lj1-f194.google.com with SMTP id u17so8658500lja.4;
        Mon, 16 Dec 2019 14:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lrzuhjxp0zAZUjMHHYvKguqtABQq0xHgy1lxD52avf4=;
        b=btTd7jPLAcdkJz9dTp90gP9fNsnLYnyV++ugAYsGmgRWviI5ca7ZAItO5ipjO6PbLX
         ik+Ez9j3bsjRZRy6T7LLN5RhbWAvfXMLtrGtq3937TZGF6ze8ap3gZlkctFXzr/BhZPx
         vnw8a+pOUYlpkYr1ItM/xcDCIzIDZZxZ5VOKZ826/amJKo99QVy0f/zJzWR82o+6pzP6
         QmvQ9dQI7Sj9WWfaVu1sDbCcEh2vNfsJ4XwdnpgFQIjNAjD5+2wunKR8dTuHABtlS7D6
         +QiysmjpmKheMdPoTgZ0F4ZMMJwNo9mjHkktdK9UzCTTG5mmpFJumkKzmiEltsa6ILn9
         Ot/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lrzuhjxp0zAZUjMHHYvKguqtABQq0xHgy1lxD52avf4=;
        b=HteYPF76Dkmcpv0+WCKRT/V7YmFXODSnYF6p44PJ2MNdIbS1uKKuwQjVcs6SihWP2I
         Drpn9wwO31dvJj4MhGRUNd05c52L/dJFpHoXM736K8w/+T19JNWNdbSx/Tk42zdFwCaf
         oEI/cldTON64uLgojlEvEBhY8GvoA3q8rb/3glZ788SrHGSx9zFuDn8UuGQgyrd6JaX2
         clhxWXa/0l3td1gkEQpJfkungmG5ZgOBU7g9Y9JKcqxvHQ2ih0uHNbx7WxFEsPkBwoS1
         wkAW5nsKSHeFoWg538frPh8tXK+G6gCaMNBMnj8YvR1C1cjgGjCVxsED/Urs+gnJVBA/
         RMMA==
X-Gm-Message-State: APjAAAXqIHVij5D7M2Qfzvhhs0bSVZb0Kio4Z6to8LJUkNV+42euwIhr
        Qw4FV8/WDKtoSs97nIe/41FRjc3ed9USfg6vk0s=
X-Google-Smtp-Source: APXvYqz6gwfCpec1pxGO73zbCSu6EMN5IosHbaw02TEnn7+4hK1VRYLSBHvZpfX9Zy7CYTdzq6SBSljLKmYb8+C6ebw=
X-Received: by 2002:a2e:9d85:: with SMTP id c5mr1070135ljj.51.1576536902451;
 Mon, 16 Dec 2019 14:55:02 -0800 (PST)
MIME-Version: 1.0
References: <20191216181204.724953-1-toke@redhat.com>
In-Reply-To: <20191216181204.724953-1-toke@redhat.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 16 Dec 2019 14:54:50 -0800
Message-ID: <CAADnVQJTkUeMSsaLdpyqXhB3CMkD4P1NRPmjWA=iuyLpYbu-Lw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: Print hint about ulimit when getting
 permission denied error
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 16, 2019 at 10:12 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>
> Probably the single most common error newcomers to XDP are stumped by is
> the 'permission denied' error they get when trying to load their program
> and 'ulimit -l' is set too low. For examples, see [0], [1].
>
> Since the error code is UAPI, we can't change that. Instead, this patch
> adds a few heuristics in libbpf and outputs an additional hint if they ar=
e
> met: If an EPERM is returned on map create or program load, and geteuid()
> shows we are root, and the current RLIMIT_MEMLOCK is not infinity, we
> output a hint about raising 'ulimit -l' as an additional log line.
>
> [0] https://marc.info/?l=3Dxdp-newbies&m=3D157043612505624&w=3D2
> [1] https://github.com/xdp-project/xdp-tutorial/issues/86
>
> Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
> v2:
>   - Format current output as KiB/MiB
>   - It's ulimit -l, not ulimit -r

Applied. Thanks

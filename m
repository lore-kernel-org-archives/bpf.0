Return-Path: <SRS0=eM+6=2A=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B32C43603
	for <bpf@archiver.kernel.org>; Tue, 10 Dec 2019 19:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B06E2077B
	for <bpf@archiver.kernel.org>; Tue, 10 Dec 2019 19:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUWXI4V6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfLJT76 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 10 Dec 2019 14:59:58 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41507 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfLJT76 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Dec 2019 14:59:58 -0500
Received: by mail-qk1-f194.google.com with SMTP id l124so5591434qkf.8;
        Tue, 10 Dec 2019 11:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ftjTNhVzo9C0Y9p3ygakz6BrTC5EY3OeVFYVC2Ii2XE=;
        b=TUWXI4V65rdrQ1gUSTZWqBEY5KTwtTo09Xhb3zp5257LWMJ31/xkWSA+ybgEHyvSlp
         k+uB0LUeO6gXfYJNKluFwkmgwdbtGvUeHXNzGDA63yCf1+2Xq5OmHNWrkBUNU+6FFL6J
         Nj9Ewnkt88irThW1Ul4WBu1lsyifz1E0mQmW8wdeLNaSgw1XVOzdyXdeVwbcw7g5ZlAQ
         djyNuSOJnO/LTua9iIVsdWorcks7bXcgLAgAOUzD7kzedT1s9azmFrdbQ13mygpsa562
         t9bM+kUkzFWFqDya+Xs+LtOiw54zQ5ggxE1SitJ+Ei2vwDfZXbJRyOWCpLbjMXtd7CJ/
         WSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ftjTNhVzo9C0Y9p3ygakz6BrTC5EY3OeVFYVC2Ii2XE=;
        b=OvBafFz2jtGZc67CJQLCEIfUtHMATnI9cDpmQA8Y5udBBszg8mwSOuQtLWAou6fZnm
         cAYqqZMlft6O7qoysotCU/nhLM6/HTUKZuUuXByHv+6RqKgtwUwn178mcggogFTOOMXL
         oFhdz8zUXG4OQJP5RpI/BgPrE4XM0nA6vIGvnkODiAZSFTHLdkWIBHGpuLaN5Zk8ry9l
         MiZNAyhl95GLlnFn1dcqsvJnQqmWwTbGfIg3RvTi4wQU0y4h8PzJMoSq02Z8QT+IHxsh
         s2wdRhQ62oQ5vnIm04iVRU2NVdV3L2Y85WVL9hEYwi0fLxIrgkAwVcAT61Ua/x7tsCqz
         IEag==
X-Gm-Message-State: APjAAAWoiIJoxYH67AjrWkHh/vcnzLOD9tFQdk7F+5FwrYcwsiWUmfSi
        BNSb7M279WJY/JLF/mBcDVe92fWFyw++LZ34UUcufo4g0i8=
X-Google-Smtp-Source: APXvYqwzmXumLbnjLluk8LZmQQzn5FiGF0EmyEBzA5IYMhlOMnAk39r8nYnd1NjQEuKg7Ob2v+JndIB4Vn3ntLvHMj4=
X-Received: by 2002:ae9:ee11:: with SMTP id i17mr31532763qkg.333.1576007996694;
 Tue, 10 Dec 2019 11:59:56 -0800 (PST)
MIME-Version: 1.0
References: <20191209135522.16576-1-bjorn.topel@gmail.com>
In-Reply-To: <20191209135522.16576-1-bjorn.topel@gmail.com>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Tue, 10 Dec 2019 20:59:45 +0100
Message-ID: <CAJ+HfNhN+0n1XAZ8-fvH9EDL44aEAfuhWHKOPzqfoavM9h+-nQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/6] Introduce the BPF dispatcher
To:     Netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Edward Cree <ecree@solarflare.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <thoiland@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 9 Dec 2019 at 14:55, Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> =
wrote:
>
[...]
>
> Discussion/feedback
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> My measurements did not show any improvements for the jump target 16 B
> alignments. Maybe it would make sense to leave alignment out?
>

I did a micro benchmark with "test_progs -t xdp_prog" for all sizes
(max 48 aligned, max 64 non-aligned) of the dispatcher. I couldn't
measure any difference at all, so I will leave the last patch out
(aligning jump targets). If a workload appears where this is
measurable, it can be added at that point.

The micro benchmark also show that it makes little sense disabling the
dispatcher when "mitigations=3Doff". The diff is within 1ns(!), when
mitigations are off. I'll post the data as a reply to the v4 cover
letter, so that the cover isn't clobbered with data. :-P


Bj=C3=B6rn

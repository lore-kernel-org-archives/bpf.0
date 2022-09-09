Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE985ECAAD3
	for <bpf@archiver.kernel.org>; Fri,  9 Sep 2022 22:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiIIW5s (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 9 Sep 2022 18:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiIIW5r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 18:57:47 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CA7F16D2
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 15:57:42 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id r18so7361950eja.11
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 15:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=PtLFLJeE2GMPaXEVScSdD7FSxoijWWCezVmDMe8b0Gs=;
        b=WluYTKEBmp3LpF+M0CuKveabrN1sfkWMd7xNQUUyvqEVbGm7bRFfJT71NMmp46poke
         l8+MnxBeleiRQ4F+O40UbKoQElSDBVql6DINrxdTwmuUf+i+rlBHvffk/AMyW1SY8QZK
         wyeWh3tLKZeaawzz0b2DPO9R+v9idvf9gdxnC6eRErnvx8PWnjQQ40PCCFwuth0s+CJu
         QX7fcwMT+hY0lnGctSjLo86fabLNEADJ2dUIcT9hA2CoEjLMs+nL/GCU10YU83XinbaV
         I8+bFDjjZYhsVswNNuBDRmFVh8wD9DcK4ViDAEfuhUMaOrIXhvJ+WCQDtQ0T2F/f0YEH
         9Orw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PtLFLJeE2GMPaXEVScSdD7FSxoijWWCezVmDMe8b0Gs=;
        b=zoLsN83r3dinOy6MmXiP9BfkzcgmHGb+TH5LbX7+lY+pL3INF9eSnVKh74f3MHGelc
         g2eXxHXnaSCKsIfCzMK0OXFegqT3EGuZrjwWp5wa7ott0LVnBEYAUxiPUCUV8P+16g/X
         ovTaa+IJhobPG2ww9F/yvLiVSmlIUEfIpIaeDZxAaROLN9CkqdzMnn+VDzD35qr+XEDk
         k+XAbtL/XERt5lY98hk3kT35zC8Eoick3pOjhXozZCaLUbvhJ6G/J1L1+sgAjn0Xyuub
         zmVn6g7aRWRoQCKJy4PauV2tvqToLll+1HWYz1+4uCLvvkov6D6YAbXR6LYZ3Zh8hMHQ
         JIiQ==
X-Gm-Message-State: ACgBeo049926s4rVmJPBEwSyrWKD/w37B5PKyy5xNXvxhkuFOZngK/vK
        u6z0j7JztB8GrDMSY5SO/+FESyh7jj8QFHjarfM=
X-Google-Smtp-Source: AA6agR4mjl4alnhptlG70zDtWDXOpB03ZVwSlIec+X1Cv6fUDO3Ngt3/pGV2T7yFnKPq8EXUM8ZF9uR4nP31bdUfao0=
X-Received: by 2002:a17:907:a04f:b0:772:da0b:e2f1 with SMTP id
 gz15-20020a170907a04f00b00772da0be2f1mr8556177ejc.327.1662764260584; Fri, 09
 Sep 2022 15:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220904204145.3089-1-memxor@gmail.com> <20220904204145.3089-22-memxor@gmail.com>
 <311eb0d0-777a-4240-9fa0-59134344f051@fb.com> <CAP01T76QJOYqk4Lsc=bUjM86my=kg3p6GHxuz3yXiwFMHJtjJA@mail.gmail.com>
 <CAADnVQJ6-kEE=_kHgyth_O3rUVHzJuNhS2MWhjQQed4wHzPpnA@mail.gmail.com>
 <CAP01T74-Bc8xLihXcoer8fOoSoQQ1dddJ1FGOVdRPRa92RRPyQ@mail.gmail.com>
 <CAADnVQLJP8YyYx5+mCBuSyenAfQDyXxDP8wfuDYCoZtO6kpunQ@mail.gmail.com>
 <CAEf4BzZL9GS0oAfkY1h4C9u1_XCzj-HTnKY9KHj+PX+h66TL3g@mail.gmail.com>
 <20220909192525.aymuhiprgjwfnlfe@macbook-pro-4.dhcp.thefacebook.com>
 <4b987779-bae0-dcd9-2405-e43f401bf5ad@fb.com> <CAP01T75voazy_BfqRzQKkLLt7k57LnYXNbu-E05jBKcsTkda3Q@mail.gmail.com>
In-Reply-To: <CAP01T75voazy_BfqRzQKkLLt7k57LnYXNbu-E05jBKcsTkda3Q@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 9 Sep 2022 15:57:29 -0700
Message-ID: <CAADnVQJS0NBMdy=MhFgFud1DbSex4ej56DO7QDYDHQmR5QuW6A@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 21/32] bpf: Allow locking bpf_spin_lock
 global variables
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Delyan Kratunov <delyank@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 9, 2022 at 3:50 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> So compared to the example above, user will just do:
> struct bpf_spin_lock lock1;
> struct bpf_spin_lock lock2;
> struct bpf_list_head head __contains(...) __guarded_by(lock1);
> struct bpf_list_head head2 __contains(...) __guarded_by(lock2);
> struct bpf_rb_root root __contains(...) __guarded_by(lock2);
>
> It looks much cleaner to me from a user perspective. Just define what
> protects what, which also doubles as great documentation.

Unfortunately that doesn't work.

We cannot magically exclude the locks from global data
because of skel/mmap requirements.
We cannot move the locks automatically, because it involves
massive analysis of the code and fixing all offsets in libbpf.
So users have to use a different section when using
global locks, rb_root, list_head.
Since a different section is needed anyway, it's better to keep
one-lock-per-map-value for now.

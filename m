Return-Path: <SRS0=wk2/=5P=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11505C43331
	for <bpf@archiver.kernel.org>; Mon, 30 Mar 2020 22:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96D320733
	for <bpf@archiver.kernel.org>; Mon, 30 Mar 2020 22:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pXuibOOf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgC3Wuk (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 30 Mar 2020 18:50:40 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39978 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbgC3Wuk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Mar 2020 18:50:40 -0400
Received: by mail-lf1-f68.google.com with SMTP id j17so15632683lfe.7;
        Mon, 30 Mar 2020 15:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sPkC0XX2iBY0yYjGTnxVOP9pK5BC05S2dgxzKmJdJTo=;
        b=pXuibOOfcPQhiq1oPWkObgd3ZMnVXAQW8uQSnrPw/JWoHBlyBLNDK6gaXLx30b708/
         cfC3n8Oda3JFxmGQZTecF3aawPmu41X85VwPl0KlzOv8x8/acv6ShqnhlFsaVVprGdWl
         4VD5YXEwqzJdokpg/gVbawTJxuINwLgu8/tTRqGjBqNbj5gSSZ2FSq00S4lf8SnvCKJ7
         n3OGtaczbWFBg5+5AuhmlosmRf2JWpL+Ul4did/NMA547Zvcel78l9V6m2DhW9WsQg9D
         5KHThkZ37OUJmwBiCzMXHvtA+7Qh3S1RWB77kRx2/1+gr5PZ2Y8iJkSoBnfn7/CJivr3
         upwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sPkC0XX2iBY0yYjGTnxVOP9pK5BC05S2dgxzKmJdJTo=;
        b=DzOfMsq87l28Xj5nhoUtNYIwZwf0L0dcMOpF8XmdrjyHFmnkNpvnk5i5nNbn5seacl
         VgLLv23R4tZqevRHAOcSZiNfYBfeeQDeq7wU5LV2QjfUnvQk5Acuj+MA/+3gyY0/oorm
         QD+APhIKHWQmPh09ZOMV52G8SHljKdk53vU4azZIL7mp33HrkBUopDBvJwUAMbIzavAD
         M+Jt4h7NsRC8O3BrhFZCcOgZ46DUIo1ak3oupOxR821zorXFkop7hmVW5C20hU2MJuw7
         PfmtiLW4UQeF2PwCQh0/C6A/KICaMIFSvFFRe+TsVH1bLCK+XWDHIz6llEBfGIU5wXex
         bhpw==
X-Gm-Message-State: AGi0PuZwvqWexOEMF6KQSCShV3IcEN+KT5c+tEHtQo0M9+ASZE6Psnvl
        FObSijlEjuI2kO5MDHtcW+fPSGgQQ4x+fLocoFo=
X-Google-Smtp-Source: APiQypKxUPGWoBW3ts7L57YJ6uczfJxRayL8vb/b8LSxkZUaCAugjMtkhd1CegqX9+BxTWZHzjE0lTJr3FBF3lGbolQ=
X-Received: by 2002:ac2:418b:: with SMTP id z11mr9432593lfh.134.1585608635677;
 Mon, 30 Mar 2020 15:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200330030001.2312810-1-andriin@fb.com> <c9f52288-5ea8-a117-8a67-84ba48374d3a@gmail.com>
 <CAEf4BzZpCOCi1QfL0peBRjAOkXRwGEi_DAW4z34Mf3Tv_sbRFw@mail.gmail.com> <662788f9-0a53-72d4-2675-daec893b5b81@gmail.com>
In-Reply-To: <662788f9-0a53-72d4-2675-daec893b5b81@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 30 Mar 2020 15:50:24 -0700
Message-ID: <CAADnVQK8oMZehQVt34=5zgN12VBc2940AWJJK2Ft0cbOi1jDhQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 0/4] Add support for cgroup bpf_link
To:     David Ahern <dsahern@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrey Ignatov <rdna@fb.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 30, 2020 at 1:46 PM David Ahern <dsahern@gmail.com> wrote:
> release. As it stands it is a half-baked feature.

speaking of half-baked.
I think as it stands (even without link_query) it's already extremely
useful addition and doesn't take anything away from existing cgroup-bpf
and doesn't hinder observability. 'bpftool cgroup' works just fine.
So I've applied the set.

Even if it was half-baked it would still be applie-able.
Many features are developed over the course of multiple
kernel releases. Example: your nexthops, mptcp, bpf-lsm.

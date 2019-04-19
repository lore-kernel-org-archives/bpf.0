Return-Path: <SRS0=ErZJ=SV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F50C10F14
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 00:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583C921736
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 00:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdRxHdRj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfDSAC6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:02:58 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35580 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfDSAC6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Apr 2019 20:02:58 -0400
Received: by mail-lj1-f193.google.com with SMTP id t4so3344690ljc.2;
        Thu, 18 Apr 2019 17:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ITXqI5WOYeR+KXjHzsIC/yC/FjZfKgMpS+Cur4077/I=;
        b=GdRxHdRjtcx20o0DcdZz/g26jhyhYTvt8JzrqQQD765HoWMnEFzFiDyRUaywHtFIIu
         yfYA5mdltkuvR0lwmuCBB+VZ8H2yxiOVeI04kRpix/GIGH27V2jPrgE02PVofWvCFcaN
         FJKb9aFC3F9KXpGmOYNEkun3d/Sa1XbT1uygfxIY/LDqHlYbaLMV0LXTnqSDBRgm/l1A
         L4TI+cKPxFW7GLt1t8Tb4FmsPYX0hiwjhBxZUzv8RBZr2hQXfGFabiVFDypWaPqwpKDw
         GCOFAe3d9ESGYR20lGfeM6OiJiIQUxab2Cp/G2/smy5H4SF2W9IIu5x4PUJTu/6VSsjO
         uJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ITXqI5WOYeR+KXjHzsIC/yC/FjZfKgMpS+Cur4077/I=;
        b=ZdBO0Zc2BFVptKetVKiGMNoG4kOfGS/EsiQFUdBtD+aJDzOuvxd11UB5x/N+5G05wq
         vpuzV61y49eYFVCiGho0GyCAHE7NRv2nv0S4sbymLMV4E1ZWs25hepvO+JacieyEmIOt
         DghZyq6QH/as7T75A+V2ahouN2LDqjxpptwqEbP22okiJm38loeo6vmAI7oEf0LpvHJO
         /Iztqi+XP+diz8szTvcDNtgUm6XSGaf0vlIqRzDLH7EQUpS5NBvZnDPjAFmH8ncxm0gR
         lwx1o2kztbZNCu4kaBxQ2EVc82UJoe/7WmErFrH4OKI3FtThwNEuFQuzIY6AVW8I7nGY
         se+w==
X-Gm-Message-State: APjAAAUpPldGJARiU2XhR1IwvUGkkpd+MSro3xPqYW4gwten6iW71aic
        Agn3VEkzP9NA+XfEGzR06XJao+ZepYC7XlVJSzY=
X-Google-Smtp-Source: APXvYqzvxOLc23wHhFEJgzgDPclM/qKBWcnzQkiU3XmbD8H9KnF6vJ8Vp2PFyT5JDpfzpZKT+Uj9A3tFLVl/ApARiVw=
X-Received: by 2002:a2e:2e04:: with SMTP id u4mr478810lju.37.1555632175687;
 Thu, 18 Apr 2019 17:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190418234752.214364-1-sdf@google.com>
In-Reply-To: <20190418234752.214364-1-sdf@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 18 Apr 2019 17:02:43 -0700
Message-ID: <CAADnVQ+bSULGfRB0RuC_wn5+K4AE8-vA8GG70fnHW1wU8-Ypog@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: move BPF_PROG_TYPE_FLOW_DISSECTOR
 documentation to a new common place
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 18, 2019 at 4:47 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> In commit da7031491786 ("bpf: Document BPF_PROG_TYPE_CGROUP_SYSCTL")
> Andrey proposes to put per-prog type docs under Documentation/bpf/
>
> Let's move flow dissector documentation there as well.
>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Applied. Thanks

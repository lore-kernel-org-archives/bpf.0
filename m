Return-Path: <SRS0=eni5=ST=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D763C10F12
	for <bpf@archiver.kernel.org>; Wed, 17 Apr 2019 05:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17F6F2073F
	for <bpf@archiver.kernel.org>; Wed, 17 Apr 2019 05:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KZbFTHQV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbfDQFVK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 17 Apr 2019 01:21:10 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:38806 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfDQFVK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Apr 2019 01:21:10 -0400
Received: by mail-yb1-f194.google.com with SMTP id w206so8670205ybg.5
        for <bpf@vger.kernel.org>; Tue, 16 Apr 2019 22:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KmDfsKBZkgJxOdxVkSbZy7RTuS7VEMH8EXDPWW7zC44=;
        b=KZbFTHQVh1ZMcamktLtddSesAFEgjZ3lF+QsbIiwkoUUriiDpMzp8PPfNDd0VjDW+O
         /gMcpmeMXPQDB22tRWrU8sUyeAtId9egcpg98PD9PgM3LB35yHm9qPnggc6yXFq8bi2t
         9g/y6Hmo9bgmxMn/gPCDD9VYEkEGeLoJ6cDGyvFwzOwoVHHGQ0Ab6b0XjrXYM/FX3VwR
         6xvjkqiFusGcFK5DQe1iIX3K5qypwctUcpkXnLZDaVO+8RVFQ+Sx2RZbw9py7+9Kzd2U
         1q+GY4qaOfa0MCTVHwI5iQ2Ayw6MNsropBscilngXxDK6s81WXSYe5MBrdhAl8HqUxS/
         XrHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KmDfsKBZkgJxOdxVkSbZy7RTuS7VEMH8EXDPWW7zC44=;
        b=rovruS0gv+Qq2axWt8BPUUB5v2O+l6yCAq8yjBQI0fMa8gW/cD35LVIIucPREYgh5j
         r7pG252aBNtYGWcSDnHr5UyaWZkqah6ti5GkrioMWb7RcqAm0L+qy0Fh3j6tnWMWl/6o
         gkqoSoFZM2qvrQryBwxhsf42cxb1h3TOP3jcmgcnrRAUKATdmBzPOSGAY7E5mAoOQPPQ
         SHF8qgJrKgE5Y4XoULDcvCeDEcen+BoO82Fspnm6ayEusg0OJBDPsg04+Wq3qiH0NDD/
         Jq9n8B9s5Y8CukYAArDEHbr8ymZ44p0HB5hok2lFkyli/B6j0fUFHjb15NnjZUM6RZ81
         O6PA==
X-Gm-Message-State: APjAAAUUjC+hyhdjNFBjMx4q5xSftqUlsdKbrs8MpCSGoC+152zs/3IZ
        eyjJs4DxyMYPdlsMqzzlNKbB5eDUso7mdnR8WPzWTg==
X-Google-Smtp-Source: APXvYqwleL2WyABCo5pHnXT651DZjAOZfZ4e/A7y/W8Gv3GUNqlo7WkPXF3tOQkWUuDPO5OOfUfpNXgU2VLY6kdMKI4=
X-Received: by 2002:a25:1254:: with SMTP id 81mr70460587ybs.237.1555478469683;
 Tue, 16 Apr 2019 22:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <155508158877.23650.13330504000013024259.stgit@firesoul>
 <155508165793.23650.5590462213777770722.stgit@firesoul> <CAADnVQ+cCKsszq3YZt_f6o+HfpsQEcY1J3yJmkDzm9Pvb2+PLg@mail.gmail.com>
In-Reply-To: <CAADnVQ+cCKsszq3YZt_f6o+HfpsQEcY1J3yJmkDzm9Pvb2+PLg@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 16 Apr 2019 22:20:58 -0700
Message-ID: <CANn89i+YQE5-Bi6AGiuQikxmk3Q0kuJU0d3rPeWiS4QGOd-70w@mail.gmail.com>
Subject: Re: [PATCH bpf-next V2 2/4] net: core: introduce build_skb_around
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Network Development <netdev@vger.kernel.org>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <songliubraving@fb.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Edward Cree <ecree@solarflare.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 16, 2019 at 8:01 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:

> It looks good to me, but I'd like to see Eric's Ack before applying.

This seems just fine, thanks !

Acked-by: Eric Dumazet <edumazet@google.com>

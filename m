Return-Path: <SRS0=nDT5=2E=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA963C3F68F
	for <bpf@archiver.kernel.org>; Sat, 14 Dec 2019 00:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18932253D
	for <bpf@archiver.kernel.org>; Sat, 14 Dec 2019 00:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpcfUo+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfLNAAi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 13 Dec 2019 19:00:38 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:44073 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLNAAh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Dec 2019 19:00:37 -0500
Received: by mail-pj1-f68.google.com with SMTP id w5so378281pjh.11;
        Fri, 13 Dec 2019 16:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vtZIomLUQgnY+ds/9AYYekCSfpy7LmIWuX6Gn6ODVVo=;
        b=LpcfUo+tyezj+z3ExmYnqDwp8HX1J/uKI0rukmj/W4yn8sUt5Wad9D6i2fNMOaWFa3
         LE/mHwZD21C5t3GEkoVL15vxOHxsaYsWHMNPTGsKdbC/6Vpeb+AYQVSn5uJCECxH5xTf
         sdB/lJUYxMjeygdD0b3iXeMlRj7Bs8A+sqHEf2V0tyglLz64uhivUX2/7Yy/dlRg33YW
         74bYkZ3Ck3hAlQobLzLpLimWVbeF/Ijefz8GT47oVqeBA+ZlOsnYpDStA9vFjOMdOtQb
         SwBBEgdOLJxo8210oQ5KLVrJkExkH2bA6L6OtOWMcVIFXPsJoJZPIYW+olDXB/Esn0kR
         AFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vtZIomLUQgnY+ds/9AYYekCSfpy7LmIWuX6Gn6ODVVo=;
        b=ZPznHsMj+BYd8tojWshmwGq7YB4QUnPkFeN0+FHtpVwDZQZQqU0LZCRLuIzfSFVpiy
         O6Src4RGfDU1mozwH3hogn8DlCz5OVZLVhc5wIAaa1AIKtWhFdTW55Gj1WVyWiIaVOiT
         NfeZd/5K13kivh2P6XTYUHZ6ZUX6tICmIf+GGofTqT+IEV7Kf6PsxTdVx0Sc9Cw7gr19
         cE8zOF2SVXBotNEv/fc9LtS0FkUyO+zlFz1yQrJwLQvwnwcODWkisoBZLniywyq1/Wfo
         CD3c4956lyF7+qvQIkmZM7aS/U8coa8ldt/YpTqCTEmll65etsL9FxpBBf93Af9k1crL
         Tkvw==
X-Gm-Message-State: APjAAAX+hFZnKI/e8EYmoNpk0/YHwM9crJuAUeb4UGoKcrYP2kiLDwwM
        Vi6hKxKfYHRBzqu4hWDFMokjQqT0
X-Google-Smtp-Source: APXvYqzfsC0exBwik685eVWcd6/Yp16/LnoPLoVvJQWFi0QHcOJy4KoXDPKWYpe/Gn5Of7dkcypY7w==
X-Received: by 2002:a17:90a:5d95:: with SMTP id t21mr2544941pji.31.1576281637210;
        Fri, 13 Dec 2019 16:00:37 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::de66])
        by smtp.gmail.com with ESMTPSA id e16sm7061839pfn.59.2019.12.13.16.00.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 16:00:36 -0800 (PST)
Date:   Fri, 13 Dec 2019 16:00:35 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com,
        daniel@iogearbox.net, andrii.nakryiko@gmail.com, kernel-team@fb.com
Subject: Re: [PATCH v3 bpf-next 14/17] selftests/bpf: add BPF skeletons
 selftests and convert attach_probe.c
Message-ID: <20191214000034.nx3fisagqxxdk3lt@ast-mbp.dhcp.thefacebook.com>
References: <20191213223214.2791885-1-andriin@fb.com>
 <20191213223214.2791885-15-andriin@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213223214.2791885-15-andriin@fb.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 13, 2019 at 02:32:11PM -0800, Andrii Nakryiko wrote:
> Add BPF skeleton generation to selftest/bpf's Makefile. Convert attach_probe.c
> to use skeleton.
> 
> Acked-by: Martin KaFai Lau <kafai@fb.com>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  tools/testing/selftests/bpf/.gitignore        |   2 +
>  tools/testing/selftests/bpf/Makefile          |  36 +++--
>  .../selftests/bpf/prog_tests/attach_probe.c   | 135 +++++-------------
>  .../selftests/bpf/progs/test_attach_probe.c   |  34 ++---
>  4 files changed, 74 insertions(+), 133 deletions(-)

Nice diff stat.


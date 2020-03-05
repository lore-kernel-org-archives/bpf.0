Return-Path: <SRS0=ocPE=4W=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39C2C3F2D1
	for <bpf@archiver.kernel.org>; Thu,  5 Mar 2020 12:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5812072D
	for <bpf@archiver.kernel.org>; Thu,  5 Mar 2020 12:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SnrGpmyw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgCEM7v (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 5 Mar 2020 07:59:51 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54190 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgCEM7u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Mar 2020 07:59:50 -0500
Received: by mail-wm1-f65.google.com with SMTP id g134so6191166wme.3
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2020 04:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=BDLV6PLbP0Mbup850SiL/bbqnuIzDy40c6BaqbrcGcA=;
        b=SnrGpmywt/cvVP1fZCtcBHPB5d8+8dm0V0ntHAdI7UFr1ax9spzhZuh1pHe3HGrHJ9
         +v0ADkEq/cIEBMtUAKWnEOyLjKsP/Dc6bLKZxUVvWeY/RZNeaJjFjHn3LROANEGzes0Y
         rPT7kaVdSzGNbJDb3/1WkDBrMgOEwN+zvzjz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=BDLV6PLbP0Mbup850SiL/bbqnuIzDy40c6BaqbrcGcA=;
        b=q1wPA8ZJTnBgW5HTJnMKx+euYreHv8Ev9IjKkEeBqNJmScydhQEkyHQ7B548q4mklL
         JLzMNjjrhPYqVJPLhFKTN5Ifefr0QkfrM32YCIpFSV6usvXQUYI+TghCX4asMQEspj+I
         X9yg5xaqnG1uMMYdrlPVLP20oL50EWPW3JXvvTi05IalZ65Cq5y8leCHUPI4CRyHUfvZ
         V/Qz4OsKzoDhWayZJ+mmfWEzjdqekB1ZtziKOX5OhGdWZnMftGIW9WzMUcXzNnLOBvkm
         RREUAuwJsypvnl36nwVWs1lufyohMU7ts27Y6MyiNzaZn8cQxMmCt0TCbCShMG6ugMxG
         xdjQ==
X-Gm-Message-State: ANhLgQ0l1COdmIRylMcDvOi9JpIUws0Nax6yI2nb0J2pvfYwGfGSgbzp
        2N96iK0vXIHH5NqygCup8LFfAw==
X-Google-Smtp-Source: ADFU+vsoQwEpiZI7Ls+BXZaQFjzKp34I4DKmwKzaSPAlKEbnaIt/z9q6IsYwHM3SMzeZQD5PCswf0Q==
X-Received: by 2002:a1c:2d4f:: with SMTP id t76mr9350046wmt.60.1583413188677;
        Thu, 05 Mar 2020 04:59:48 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id b18sm45274715wrm.86.2020.03.05.04.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 04:59:47 -0800 (PST)
References: <20200304101318.5225-1-lmb@cloudflare.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     john.fastabend@gmail.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 00/12] bpf: sockmap, sockhash: support storing UDP sockets
In-reply-to: <20200304101318.5225-1-lmb@cloudflare.com>
Date:   Thu, 05 Mar 2020 13:59:47 +0100
Message-ID: <874kv3yn24.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 04, 2020 at 11:13 AM CET, Lorenz Bauer wrote:
> Thanks to Jakub's suggestion I was able to eliminate sk_psock_hooks!
> Now TCP and UDP only need to export a single function get_proto,
> which is called from the sockmap code. This reduced the amount of
> boilerplate a bit. The downside is that the IPv6 proto rebuild is
> copied and pasted from TCP, but I think I can live with that.

This turned out nicely, IMHO. Thanks for reworking it.

-jkbs

[...]

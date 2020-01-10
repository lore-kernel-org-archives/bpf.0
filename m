Return-Path: <SRS0=J/LN=27=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50864C33CA4
	for <bpf@archiver.kernel.org>; Fri, 10 Jan 2020 13:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF2120721
	for <bpf@archiver.kernel.org>; Fri, 10 Jan 2020 13:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Ua35ReYL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbgAJN1d (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 10 Jan 2020 08:27:33 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:46239 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbgAJN1c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jan 2020 08:27:32 -0500
Received: by mail-oi1-f170.google.com with SMTP id 13so1780158oij.13
        for <bpf@vger.kernel.org>; Fri, 10 Jan 2020 05:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AUwd8glpr6kfXtb89k6x9PBA9ykDSCHrcjOXwyj5hTA=;
        b=Ua35ReYLIwp5dAjcfnRe5d717jLPnKQgnOXgwoQa55EKXMOyC62yk19zvYaYTRpOk9
         W3EkIJ8KAInm0Gi/SBabPmttucc5vhWdBkJCWmCCM2YFIRGDXIl0x1owC9dTR7zBbJaV
         WWz4MAs/RlsTY82k3bvZe1mgkRTBbDbwbYdhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AUwd8glpr6kfXtb89k6x9PBA9ykDSCHrcjOXwyj5hTA=;
        b=lyIUvrf+0OtUBIM4z0pXXk1Fnm2GzGqB+/OCYFcmvyywcxuWfJNMYa8+yd8YVE0mBI
         icPY6ym9Cvnrg10vo7UkN7rs0vOI0/a0Ecszp2YCuky3ylKbJ7ugylutqSMQ75vmxcFj
         4E7FYBM60EhBbKkbRHcq4Ahmte79D0niihh13fST5xcJK8jXhbrR20RPP+uCzv7pPdUH
         p8SZM8kfKn8xJ+7HgysFueuHAwrLCuz4rnAqeqbe2chtGiiTQsPT7MK8o31PdqizI/2v
         3s8qTErj8l0LePBV8M6eIhsojpuIfmi879CID0T+/uuqAVjQ5fA8fi6lLP7t8Bz7RDol
         o4mw==
X-Gm-Message-State: APjAAAULu4sDPd342SUkpn5s6AOB53wfzOR1h5t4NKciW/z9Ypwcgmtu
        x1JmLySOCm4f8v5Hbl4nKe7vt9sLZ2mgdLeRhCl2vw==
X-Google-Smtp-Source: APXvYqxEQdRC03cg2f9SLLL9UIZBDwiOjLVn6ykjZjCp6YeJgL1s35yJA44vdEuwG59QZYLKKl73qp4FjS+FnaXcQI8=
X-Received: by 2002:aca:b60a:: with SMTP id g10mr2064783oif.102.1578662851371;
 Fri, 10 Jan 2020 05:27:31 -0800 (PST)
MIME-Version: 1.0
References: <20200109115749.12283-1-lmb@cloudflare.com> <20200109115749.12283-2-lmb@cloudflare.com>
 <20200109182335.um72tp73krvvubnl@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200109182335.um72tp73krvvubnl@kafai-mbp.dhcp.thefacebook.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Fri, 10 Jan 2020 13:27:19 +0000
Message-ID: <CACAyw98A_Y1r0S9jDQds332whureyxRRZCDhFbXV6Bo9NsG4NQ@mail.gmail.com>
Subject: Re: [PATCH bpf 1/1] net: bpf: don't leak time wait and request sockets
To:     Martin Lau <kafai@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Joe Stringer <joe@isovalent.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@cloudflare.com" <kernel-team@cloudflare.com>,
        "edumazet@google.com" <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 9 Jan 2020 at 18:23, Martin Lau <kafai@fb.com> wrote:
>
> Would this work too?
>         if (!sk_fullsock(sk) || !sock_flag(sk, SOCK_RCU_FREE))

Thank you for the suggestion, this makes the patch much nicer.

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com

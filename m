Return-Path: <SRS0=YBMC=RZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAF9C43381
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 02:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EADC221900
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 02:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Kgx9nIsg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfCVCws (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Mar 2019 22:52:48 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40474 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbfCVCws (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Mar 2019 22:52:48 -0400
Received: by mail-oi1-f196.google.com with SMTP id 3so645517oir.7
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2019 19:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S1Xnazlv7OVfL2ZW+APAAAZ3eQjve+f8ol79G8W2wYc=;
        b=Kgx9nIsglrYbdVowwLjHbaLcv7a8CZVN07Kc6H8IwkxI02rIDyRsD7e7eoK+JQ+Rkl
         ntUpVOMC2rinvtmv6VkbyT8xwwfIFRhBIW+1nSHmkUE2bbCSEvctj9gNLFbdFeGw6hNk
         5+W5pXB3Tmh4GwDsJINymSfTx0G9MwgnarCIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S1Xnazlv7OVfL2ZW+APAAAZ3eQjve+f8ol79G8W2wYc=;
        b=o/t4nlxMOdM1DkPQNmhMcL+q3IJ2qbeuGazbIPahi+AEBdJDGB6SQGa25nGPj4vAKC
         k2sbuRxodko0aMOBh4fcC6ICvXyWJB/hrsrvqFDYwCC6MpZFOBAuaUaSkhk6qA5tBRE8
         aUboyBMuTR0RmLBz6ggzUsq9yfFaMmxr7Cj56QqmNsOEWg86fjBtqh9Hctht29XdYFwT
         eVFwjZLa1cJ9fenIg9wTdixJKjuBgKxr4h+kk8aR9ysJuq+lXi24pZRTage215k3i+85
         Sa9/LgANdFm8lacejIgH57MYQsMPIoH3mGU4u9DvuFYrNwpFjr+Jhk8kO6ffYhbWUUlg
         o63g==
X-Gm-Message-State: APjAAAVNdCaV0HvTTCc0I1MbMLkkU1qfPcdIDhxdyuizpY9aawVHBcVH
        n7ytZqZOTwzExdJkHGcc7k7T2g5fLf3V05K94rvvAQ==
X-Google-Smtp-Source: APXvYqx7ZUr5njXWKbIl8ZFUayndT9hpHZ5y+AMn95gUYEoNnklFwqt9Mpore/RZ1kuoxs8tu4e5wxEDCWKOX//4AFo=
X-Received: by 2002:aca:318a:: with SMTP id x132mr345546oix.172.1553223167584;
 Thu, 21 Mar 2019 19:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190319102103.7380-1-lmb@cloudflare.com> <20190322015406.26453-1-lmb@cloudflare.com>
 <20190322015406.26453-5-lmb@cloudflare.com> <20190322020646.mnrpce2i2ooe6shi@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20190322020646.mnrpce2i2ooe6shi@ast-mbp.dhcp.thefacebook.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Fri, 22 Mar 2019 10:52:36 +0800
Message-ID: <CACAyw98+yNdnajU7bWJ56=ZmfgaLpDN0E4VFDEWKq6=HP_Z2Vg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/8] bpf: add helper to check for a valid SYN cookie
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Martin Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ha! I did that because __cookie_v4(6)_check is marked GPL only. I'm
happy for the helper to be more permissive if that is possible.

On Fri, 22 Mar 2019 at 10:06, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Mar 22, 2019 at 09:54:02AM +0800, Lorenz Bauer wrote:
> > Using bpf_skc_lookup_tcp it's possible to ascertain whether a packet
> > belongs to a known connection. However, there is one corner case: no
> > sockets are created if SYN cookies are active. This means that the final
> > ACK in the 3WHS is misclassified.
> >
> > Using the helper, we can look up the listening socket via
> > bpf_skc_lookup_tcp and then check whether a packet is a valid SYN
> > cookie ACK.
> >
> > Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ...
> > +static const struct bpf_func_proto bpf_tcp_check_syncookie_proto = {
> > +     .func           = bpf_tcp_check_syncookie,
> > +     .gpl_only       = true,
>
> you really want your employer to open source the load balancer :)
> Fine by me.
>
> The series applied to bpf-next.
>


-- 
Lorenz Bauer  |  Systems Engineer
25 Lavington St., London SE1 0NZ

www.cloudflare.com

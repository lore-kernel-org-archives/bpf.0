Return-Path: <SRS0=Kw1S=Q6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E80C43381
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 23:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0430206A3
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 23:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSDvyu8N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfBWXLT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 23 Feb 2019 18:11:19 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44850 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbfBWXLS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 23 Feb 2019 18:11:18 -0500
Received: by mail-pf1-f193.google.com with SMTP id a3so2737127pff.11;
        Sat, 23 Feb 2019 15:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LsaBM5vPqcfYW8NkSpm2GIEH1prHpJRY4rzTwGfACDQ=;
        b=bSDvyu8NbmkQyZkHI6TwWTrSXqqhjg7wEP5uZXim2tvk6eVsCInjYznp0nzpSsQC5Z
         RS6F29jEKpBOk84NKMcsKbITZRcNbkZzr9u4QCUuMvXWxFBpDYCTMGSBozdL5wdOL3kD
         ys3nLYc+QCzBjlReoQ8qQCrUuxJJ0PtO/UMSvbBG03hmBztJ8O3IXoZz93pyyAnTnK9K
         7PdUdP3RiP4KZsQ9wFYqxyxm9pxQp7nPFgKbTJoFXgkL9BipGboDlcWNkOuhvzXvMndB
         4aB5lKhw3O1T2LQFEa+5pka7WGHC0l+fN1I3mFTBkwVLZYBAWsDrIvP0UbQEbf5Pd6PB
         VKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LsaBM5vPqcfYW8NkSpm2GIEH1prHpJRY4rzTwGfACDQ=;
        b=KlN9Nd1HnkK0Cx9JMBBxq4q5jd/bj+e/aitkKeIOacynVvDIYEGPx0hf+YJhiy4Div
         kNpdVDgpz01ZYldiJjtLUK4oEfJ3rmpcFkLPWvb8On4fxBO7mIOVOMBh/w3128MOamo4
         Cjmxb7wAGgimI3b8dCCy7ZzSmZj50fMRBSCIZnO8uDY6dYSD8KiHlwQ8mcSZyM2XD02X
         4Z/HOuz7n0NKPCWMsncOxfr2uef1VAVJI+mvUUrYG/0jwsPveP0TyLTCgBwx+4JHS7Xk
         rvBr+Yq3cCDDHfcEXxh1lCBrbgMXYC8L02VCMbM3hpEC+t7mcte6YfuedJPxYTNWLuG4
         pouw==
X-Gm-Message-State: AHQUAuZWOUkLC68lojbiNYgFrUVCwYyZw0igrVnBbrLq17hobl0Sep9m
        D1flcnIxWQP7k4xu/jRy2uY=
X-Google-Smtp-Source: AHgI3IaadYDTNyMDkid5omWhPTmhJjT2QsYJOdnUvU+LW7/kX/I3Puhj0daI4bnNYps5tjGnWBPnMQ==
X-Received: by 2002:a63:f74c:: with SMTP id f12mr10744765pgk.195.1550963477757;
        Sat, 23 Feb 2019 15:11:17 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:227a])
        by smtp.gmail.com with ESMTPSA id q18sm6538902pgv.9.2019.02.23.15.11.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 15:11:16 -0800 (PST)
Date:   Sat, 23 Feb 2019 15:11:14 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf <bpf@vger.kernel.org>, Lawrence Brakmo <brakmo@fb.com>
Subject: Re: [PATCH bpf] bpf: properly check TCP_CONGESTION optlen
Message-ID: <20190223231112.7dzt7ws472k6ajb5@ast-mbp.dhcp.thefacebook.com>
References: <20190223190709.61558-1-edumazet@google.com>
 <20190223203808.f2r54xz2z7j2gecg@ast-mbp.dhcp.thefacebook.com>
 <73905026-571a-867d-43eb-3d9b36f6c39c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73905026-571a-867d-43eb-3d9b36f6c39c@gmail.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 23, 2019 at 12:48:53PM -0800, Eric Dumazet wrote:
> 
> 
> On 02/23/2019 12:38 PM, Alexei Starovoitov wrote:
> > On Sat, Feb 23, 2019 at 11:07:09AM -0800, Eric Dumazet wrote:
> >> If caller of bpf_setsockopt() is silly passing a negative optlen
> >> bad things happen.
> >>
> >> Fixes: 91b5b21c7c16 ("bpf: Add support for changing congestion control")
> >> Signed-off-by: Eric Dumazet <edumazet@google.com>
> >> Cc: Lawrence Brakmo <brakmo@fb.com>
> >> ---
> >>  net/core/filter.c | 5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/net/core/filter.c b/net/core/filter.c
> >> index f7d0004fc16096eb42ece3a6acf645540ee2326b..6a5d89464168f2f35f43986c1dbc0446c9390a3c 100644
> >> --- a/net/core/filter.c
> >> +++ b/net/core/filter.c
> >> @@ -4194,8 +4194,9 @@ BPF_CALL_5(bpf_setsockopt, struct bpf_sock_ops_kern *, bpf_sock,
> >>  			char name[TCP_CA_NAME_MAX];
> >>  			bool reinit = bpf_sock->op > BPF_SOCK_OPS_NEEDS_ECN;
> >>  
> >> -			strncpy(name, optval, min_t(long, optlen,
> >> -						    TCP_CA_NAME_MAX-1));
> >> +			if (optlen < 0)
> >> +				return -EINVAL;
> >> +			strncpy(name, optval, min(optlen, TCP_CA_NAME_MAX - 1));
> > 
> > Unnecessary.
> > The verifier guarantees that optlen > 0 because
> > static const struct bpf_func_proto bpf_setsockopt_proto = {
> >         .func           = bpf_setsockopt,
> > ...
> >         .arg5_type      = ARG_CONST_SIZE,
> > };
> > 
> 
> Even on 32bit kernel ?
> 
> The suspect thing to me is the min_t(long, ....)
> 
> optlen is an integer, why do we need to promote to a long ?

I think the code is actually fine as-is.
I bet it was copy pasted from do_tcp_setsockopt
where similar min_t(long) is used to match strncpy_from_user() declaration.
Here min_t(long) or min_t(int) or min() doesn't matter.
I would keep it as-is to avoid noisy patches.


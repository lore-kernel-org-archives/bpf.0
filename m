Return-Path: <SRS0=Kw1S=Q6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45305C43381
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 20:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F08920651
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 20:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2KNFLm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfBWUiN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 23 Feb 2019 15:38:13 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40708 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfBWUiN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 23 Feb 2019 15:38:13 -0500
Received: by mail-pg1-f195.google.com with SMTP id u9so2673035pgo.7;
        Sat, 23 Feb 2019 12:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xhdlEOOFstFb0iWnKzc3GFFMg+gxQbNMa7jTwXuSgcw=;
        b=i2KNFLm4yEsGV1mMj03+t24PuaZ3/GPKeN99eqErtyRMetWz06cL9e3XHAoeZIhUqE
         Yr2+oI5HL0recWTyCuXnRE1hcY7zhQKSJ7FUKn71/ta+aAlTHvpw2UE12tnIDJq29SDL
         xECCkCWNEiAJogdI/kfik4Z/uyC44LPFMg8osSWkVhKkqkVLnFJ9jBsnqXzVc3WXPVQa
         MfVEs5z23h9k/ecBw6Ga6eoYRevZUSoly4c2UrWIFD1a1r10zTHGq2U3CGo7cwsVtaI+
         8byrxKHhW2TOXGKzBR0xzLNdApmkYqidsUXFab8Rd7QKQ7rQemMo4NlUiTkDhLZy2uLK
         H+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xhdlEOOFstFb0iWnKzc3GFFMg+gxQbNMa7jTwXuSgcw=;
        b=WmP3q34vcf5wFdU4R6DeiVI3C8I1KcpNsf0iNOkWoW3CSnphSYI2+hGwToAVHCHnql
         Q1c6frGp3vlRMvkmlwQ7lQt9QRBR+wIVBcMMoqt1COOwb0tC/Ej7HY+ISem5KIxqyF2U
         Freea4O41v0yUps23TdzwpWe6L6YYtAKFhl8tV1yClZRydM/lnhL+sNinExnbU/Eru9U
         czgMR/hpDKUJDOn18LjHEfDlsYfdT+OWSLYQ6zAPFhFStgNXWaC5AYydLVButCoPQylV
         VbRrtbIs9VJWHfzgfu5zqd/xcI2pMgzpC+AvhybVUijzb8a7lxd9G4v1LHDnBlbbNan9
         +Niw==
X-Gm-Message-State: AHQUAubLTPo00lpNUcdjify7qt/vbjB4+yhkDwBcVjgMlfWOq/PKSHzg
        zplnz4UDBXbwEsLXhwjs9QY=
X-Google-Smtp-Source: AHgI3IbqGAD3X1sg8vT4S5T2c934edevakGVn8VAcc5k8jrQM5t1AOQJ0e+eqz+icQxcqtubhCa1sA==
X-Received: by 2002:aa7:838b:: with SMTP id u11mr10933113pfm.254.1550954292480;
        Sat, 23 Feb 2019 12:38:12 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:79ba])
        by smtp.gmail.com with ESMTPSA id 11sm7034243pfn.7.2019.02.23.12.38.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 12:38:11 -0800 (PST)
Date:   Sat, 23 Feb 2019 12:38:09 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf <bpf@vger.kernel.org>, Lawrence Brakmo <brakmo@fb.com>
Subject: Re: [PATCH bpf] bpf: properly check TCP_CONGESTION optlen
Message-ID: <20190223203808.f2r54xz2z7j2gecg@ast-mbp.dhcp.thefacebook.com>
References: <20190223190709.61558-1-edumazet@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190223190709.61558-1-edumazet@google.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 23, 2019 at 11:07:09AM -0800, Eric Dumazet wrote:
> If caller of bpf_setsockopt() is silly passing a negative optlen
> bad things happen.
> 
> Fixes: 91b5b21c7c16 ("bpf: Add support for changing congestion control")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Lawrence Brakmo <brakmo@fb.com>
> ---
>  net/core/filter.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index f7d0004fc16096eb42ece3a6acf645540ee2326b..6a5d89464168f2f35f43986c1dbc0446c9390a3c 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4194,8 +4194,9 @@ BPF_CALL_5(bpf_setsockopt, struct bpf_sock_ops_kern *, bpf_sock,
>  			char name[TCP_CA_NAME_MAX];
>  			bool reinit = bpf_sock->op > BPF_SOCK_OPS_NEEDS_ECN;
>  
> -			strncpy(name, optval, min_t(long, optlen,
> -						    TCP_CA_NAME_MAX-1));
> +			if (optlen < 0)
> +				return -EINVAL;
> +			strncpy(name, optval, min(optlen, TCP_CA_NAME_MAX - 1));

Unnecessary.
The verifier guarantees that optlen > 0 because
static const struct bpf_func_proto bpf_setsockopt_proto = {
        .func           = bpf_setsockopt,
...
        .arg5_type      = ARG_CONST_SIZE,
};


Return-Path: <SRS0=xp9Q=RK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4CDC43381
	for <bpf@archiver.kernel.org>; Thu,  7 Mar 2019 13:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC392081B
	for <bpf@archiver.kernel.org>; Thu,  7 Mar 2019 13:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tw4lFA4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfCGN5U (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 7 Mar 2019 08:57:20 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40244 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfCGN5T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Mar 2019 08:57:19 -0500
Received: by mail-qt1-f193.google.com with SMTP id j36so17113657qta.7;
        Thu, 07 Mar 2019 05:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CMcyL2d6xCUFRVYSyZvPMYxSu6A3u6MlB7yfhtDN2S8=;
        b=tw4lFA4Wu8/D8XlDYmsn9v1FMpX5Bv5NPObHrJ9jaRkLJKgJPJg2U9I/E8dJuD6R7D
         CqRVtIPmI5vHoOWfai2ZxK92zG/LFTzGuIPVSWCcAu4+/+L+J9jQpgGW7sVbtNKkagdg
         9U+qGxr6FVS3OBOGTlIbs+wK4/rXq7YbcOe5DwtplVpSczvO4vvdLSElu6Pj8p+5WcRx
         j7Fl1yK39fQpdwlH+BbvHhxS2A8smWIq8NBDNlsQFg5AhU+/jnx0OVDnSy27T1dB5a3/
         xnMc42GqL1ef6aeNfWiGtNVc31oKbAvpnWWiQxu3bGktj92rcHxIn8q/ovLXK359ns3k
         hoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CMcyL2d6xCUFRVYSyZvPMYxSu6A3u6MlB7yfhtDN2S8=;
        b=iYhYzfZja4THzTThdkndGb5loYks7IupBmUSZxzjgKcKJe0V7Xc9pr62+paAq0XUjS
         c4i+vG++9jl5zFTDP7b3VZS9TKzGJ8HvoRjd2bKetZIBkGX/paB48ZIXPoNxdoBLTEr+
         W0WUum0ZQv95in/A6V5LJeBgShSeqmn27s0jQbJPL+NAeAVVuvk50oTp1up5/EQAb39v
         L7rxXPE+hJTJVZutSCHqrRfAWAASMfVwGuk/KOaU2a13zlTqr33hLhGJThYwiQMak9lL
         MW6N8z1hszl5f9LBy13hTnjScHpQiiesY3MLa2jOCDmgQbe6IZ/hBn7pxfG4pdg20gBE
         F0ew==
X-Gm-Message-State: APjAAAUkMpfE5Wl6q2kfig5rs7iWLCUqulllLb0NBcbncFtM7c0/O9Bf
        Kkdq5yfTyXHdi7pegcDJqzk=
X-Google-Smtp-Source: APXvYqxfbbxnzq8eIj6KUc3iPxTqL9/tgpk+H5HP+F/AQJgP8LoeW05qqvgPI5tgvtoBIVphI1zLVw==
X-Received: by 2002:ac8:22d4:: with SMTP id g20mr10220513qta.50.1551967038456;
        Thu, 07 Mar 2019 05:57:18 -0800 (PST)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id g33sm2848904qtk.44.2019.03.07.05.57.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 05:57:17 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B76B04039C; Thu,  7 Mar 2019 10:57:13 -0300 (-03)
Date:   Thu, 7 Mar 2019 10:57:13 -0300
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     arnaldo.melo@gmail.com, andrii.nakryiko@gmail.com, ast@fb.com,
        yhs@fb.com, dwarves@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 pahole] libbpf: update reference to bring in btf_dedup
 fixes
Message-ID: <20190307135713.GU13100@kernel.org>
References: <20190307001408.4041372-1-andriin@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307001408.4041372-1-andriin@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Mar 06, 2019 at 04:14:08PM -0800, Andrii Nakryiko escreveu:
> Latest version of libbpf has btf_dedup() fixes preventing it from stucking
> in a loop on allyesconfig kernels.
> 
> v1->v2: 
> - use git reference from github.com/libbpf/libbpf instead of personal fork

I had already fixed this up, end result is the same as in this patch.

- Arnaldo
 
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  lib/bpf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/bpf b/lib/bpf
> index d5fa415..cb658e9 160000
> --- a/lib/bpf
> +++ b/lib/bpf
> @@ -1 +1 @@
> -Subproject commit d5fa4150f0c3a36e3ce458e1301531bd2edbf74d
> +Subproject commit cb658e9724e3c34973eee913b1ff0cb9c50b8e53
> -- 
> 2.17.1

-- 

- Arnaldo

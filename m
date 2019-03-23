Return-Path: <SRS0=dHw9=R2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4348C43381
	for <bpf@archiver.kernel.org>; Sat, 23 Mar 2019 00:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDE62192D
	for <bpf@archiver.kernel.org>; Sat, 23 Mar 2019 00:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="qmhSxnQc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfCWA76 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Mar 2019 20:59:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46896 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbfCWA76 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Mar 2019 20:59:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id a22so2582678pgg.13
        for <bpf@vger.kernel.org>; Fri, 22 Mar 2019 17:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v4eR9AXPwjo/zAdPH0W9i5VXZlciyXu7tlzn2PkmNlo=;
        b=qmhSxnQcrS9pZALlYJZqWp8iPQLJSTtIVgvfjlIO24JQOX6snsIlgdhlfNUhRpCult
         RrnmSV+miTN144kWywmaMfMw1FRipV9+/U5VUgBCTwVguU4Q88yMBitd+hp8gG98t3Ey
         RJ9LqhNHYpIl5XFj/stR4bBYmY8Gr9Q9Kg3lu8OrG6Bvl9buSe/nmNykmOL/SwbO4MFo
         vO9oXG9gac+h1TAw/4IWrSHx0HPcis9JZPL1niFRr4nCLmXdxPgLTbHjaxzaF8N/ZNsm
         a1Q4N3KTaSBKE+yx7mN8FkG+kD/VX/XkfCf0B07/Rx0zumPhSYDll2NPHvY2YXWLzFIx
         0S2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v4eR9AXPwjo/zAdPH0W9i5VXZlciyXu7tlzn2PkmNlo=;
        b=kOo/xqGFiLqv4LnPZxKVdTDHm+5IsWLbfUgV1c0NGrInDZrpqtiXwvFT17nxhMs3SB
         zxwqlvoLHiK2C/s25MZsF9pHYCW/Uma8EeQ9b9RF9SEq9VUf+ezZkP03xXUkj9M8iUqA
         jAYOfw7jGpQzJkNLStdKQHTVcLMLs19F7bVUDfdvZzjCab3VZu4LWTswzwSYISWGZbM2
         5WMeJ9veSZ1Z0wmiIU4TpHgBws5GQRnr+a8uyFqkFky2+gZ3oRoxagyS5NrvMRPhwCm9
         LHJ0YUyDhWc7XMhiFVVFX9nsz0LHDM4rcqAkvKlz3Ftz/dUlpMWPxd0H4ZD7VbarNabg
         4b4g==
X-Gm-Message-State: APjAAAVRu5h5HEft1BR+3ok/x4cWjOo+gDPTKYIJWLE5ypaTcX5y8aM+
        iDIRQxT7nvtgOt9hL1BM5NJXTA==
X-Google-Smtp-Source: APXvYqytCGVa6TSkemWu035kjrMYHG1cSAgUCikYwU3GzSa5RuBGSVErlcyrkGRZIwsO5Zdn9IXH0Q==
X-Received: by 2002:a17:902:7892:: with SMTP id q18mr2539141pll.163.1553302797278;
        Fri, 22 Mar 2019 17:59:57 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id e2sm14331831pfa.64.2019.03.22.17.59.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 17:59:56 -0700 (PDT)
Date:   Fri, 22 Mar 2019 17:59:55 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     ast@kernel.org, sdf@google.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH bpf v2 0/2] libbpf fix up and clarify version info
Message-ID: <20190323005955.GX7431@mini-arch.hsd1.ca.comcast.net>
References: <20190323004911.604-1-daniel@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190323004911.604-1-daniel@iogearbox.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/23, Daniel Borkmann wrote:
> First one is fixing version in Makefile and shared object and
> second one clarifies bump in version. Thanks!
> 
> v1 -> v2:
>   - Fix up soname, thanks Stanislav!
LGTM, thank you for a quick fix! For the whole series:

Reviewed-by: Stanislav Fomichev <sdf@google.com>

> 
> Daniel Borkmann (2):
>   bpf, libbpf: fix version info and add it to shared object
>   bpf, libbpf: clarify bump in libbpf version info
> 
>  tools/lib/bpf/Makefile   | 42 ++++++++++++++++++++++++++++--------------
>  tools/lib/bpf/README.rst |  1 +
>  2 files changed, 29 insertions(+), 14 deletions(-)
> 
> -- 
> 2.9.5
> 

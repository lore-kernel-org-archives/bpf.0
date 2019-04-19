Return-Path: <SRS0=ErZJ=SV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93168C282E0
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 21:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A623208C0
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 21:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="nSTCPbRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfDSVQF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 19 Apr 2019 17:16:05 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:47057 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbfDSVQE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Apr 2019 17:16:04 -0400
Received: by mail-yb1-f196.google.com with SMTP id m5so2417773ybk.13
        for <bpf@vger.kernel.org>; Fri, 19 Apr 2019 14:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xvy7HgBvQxPibDqza6Jr3TiPxxT6rvAWs37Ags1f7Lo=;
        b=nSTCPbRYTEIgxw3cmo56NSkRNdXMdM8TxOjPmyhJa2EQ4UQRMD9rngl7EeAWnrJ06+
         Znr24aaUkdR9VwJjdlMz525Q0oWwrax9QtbBK1DUhARf1bORZZPdtrg+oDbhDel/MMgV
         Ss6LbCv/HAHrtKP8lXyqA/7s6icsJgb/cjem0JHZI+EjR9GgNrLnmDCwV5TT6VvalDd8
         vDrbGRzIU1T2sAjuGk0xucYqVezDuMlQ7f0Qe1+KdDUiulVCWXm9PGQ4Tw6eKpxVEr3X
         bPlPnwlarzhuKS22Unvy+sJrunqN/jjXeYToKHL2gpgoP62sYQjHWyFQEDoqC/xybjPb
         xa8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xvy7HgBvQxPibDqza6Jr3TiPxxT6rvAWs37Ags1f7Lo=;
        b=V/vt87drf6AjK+hB2WD0hswRY2vqkfCKKECqJCj2dGWmgIncf2WSDHNmu4NQYHNoai
         17xlPAWDuLCLhICQeLfAR7GRw4FX/ybdk7HCYhm/3MM/Y9EAlkDPibP2nzJFfgrXV6CW
         lGbo3aNLDumceZrwku3jug26gyEEFk42kJBY3XvDorfUCIRUabifyo0hdQSj81ZLQZbi
         HY3A5JqwyAl2u8ubz1txP/AeJZHkbd+2q/0lInhvfltVbom4eGFQ973ZDLUyUZp/ncFM
         MqoMfr6Pmy10gIJb2ef4mFAIWPr+XqmuSBLAW+mlLinS6HKpGmr/cXW0MLgLXe0nHsqp
         vufw==
X-Gm-Message-State: APjAAAWQ6ZZlfCGMwHBgB0NOu00Quzeq2vmlHBrRzinG55jIBF1R0NDd
        cTp9y303kR+ukpKl+34QTCNkZw==
X-Google-Smtp-Source: APXvYqwIKKJWngdm9zOVWZd6SWqoGyLx5nOQ+b8mY7u5jXE3U1TCkhaA37xIAh23KYlT23+3w4RhBQ==
X-Received: by 2002:a25:378f:: with SMTP id e137mr5114437yba.326.1555708563953;
        Fri, 19 Apr 2019 14:16:03 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1c6c])
        by smtp.gmail.com with ESMTPSA id 139sm1981177ywk.83.2019.04.19.14.16.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 14:16:03 -0700 (PDT)
Date:   Fri, 19 Apr 2019 17:16:01 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Matt Mullins <mmullins@fb.com>
Cc:     hall@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: Re: [PATCH bpf-next v3 2/5] nbd: trace sending nbd requests
Message-ID: <20190419211600.5dvflqu6ryvjgwjg@macbook-pro-91.dhcp.thefacebook.com>
References: <20190419210409.5021-1-mmullins@fb.com>
 <20190419210409.5021-3-mmullins@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419210409.5021-3-mmullins@fb.com>
User-Agent: NeoMutt/20180716
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 19, 2019 at 02:04:06PM -0700, Matt Mullins wrote:
> This adds a tracepoint that can both observe the nbd request being sent
> to the server, as well as modify that request , e.g., setting a flag in
> the request that will cause the server to collect detailed tracing data.
> 
> The struct request * being handled is included to permit correlation
> with the block tracepoints.
> 
> Signed-off-by: Matt Mullins <mmullins@fb.com>
> ---

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

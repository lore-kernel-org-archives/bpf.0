Return-Path: <SRS0=5FJy=2I=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25741C43603
	for <bpf@archiver.kernel.org>; Wed, 18 Dec 2019 03:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E46DE206D8
	for <bpf@archiver.kernel.org>; Wed, 18 Dec 2019 03:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owHW/8YI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfLRDFc (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 17 Dec 2019 22:05:32 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42074 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfLRDFc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Dec 2019 22:05:32 -0500
Received: by mail-pg1-f193.google.com with SMTP id s64so419595pgb.9;
        Tue, 17 Dec 2019 19:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ohfyr+zZvxbHch88tHdJFopb0g8Us055PRfGJqR30WE=;
        b=owHW/8YIXzqQX0nUEf3GIrtCHHNnpZOUiJ7HAnxpXSHsZDssJTu/dIoURIK4xRkIqJ
         vgQMvNAUEAT9TnuCf5hy5r0foEbRS+gjlezXaKbwij9AjY8/uf6eKHXkeSor+yRa5lzS
         KXWxDqB3bhMCex/fiL4WbfzvFKyoe345zDGvXwu7aLYileQqI07nX7oQfEemU+0VwCo3
         GHcVBcHgEYyz7rVrddEERDhIccAjL71zxfP48vpRJbkB3X4+MhAUsfE/u4kc2dJBhXOj
         KPbcz9IvleAsr8j8ogQozwDJI1figlBgDZMjHsSV3HLW5zmPt5ezQ2WQJZj5q4+4qcAE
         0LiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ohfyr+zZvxbHch88tHdJFopb0g8Us055PRfGJqR30WE=;
        b=AyGutshZ9RIty82/UYr7t4ZBSPNS8LlizlAcCNS2sdXaIBlbGLdd4qXd1IQpOTIhWa
         hREv3hKzPwPAgaZkPIAibJh0pUw/VzNmhS4monb2dXwMzebHjA5niy6ToKnfbG6/gqNy
         wr6i4uwME+addBn3yCRd9bLCoTBumQRKmz82fYk8z6HHaWDBDxRj+pu1rWBwMmLXl/Rr
         31kkecRi27HBC4Pw2HUg5jxofO7nXGnvHUUrUJqpxllp7HE6hMrlk7RIOnW9UdL9OsbM
         OX5WesCVTObEGsOdaduc6Qt/L7iWcEtwngb85CthZZk1XjsmzNUTvaumVvAXme5PXx81
         Waqg==
X-Gm-Message-State: APjAAAU26bO/+HDiYX9oFup/syeoxDGZSKi9H1Ocn/rEZRaH6SKm2+ko
        xkYAL25RmAugHF6SAUBQL4Al8r23
X-Google-Smtp-Source: APXvYqwPSDpf/83WQKadKJs8w1lTR6a8zHoYFrlDWKzgi1MJpiJxScoUq9zLCHW6OZdFpkVYbtNvEw==
X-Received: by 2002:a62:ea13:: with SMTP id t19mr386199pfh.189.1576638331480;
        Tue, 17 Dec 2019 19:05:31 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::fb75])
        by smtp.gmail.com with ESMTPSA id a19sm532713pfn.50.2019.12.17.19.05.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 19:05:30 -0800 (PST)
Date:   Tue, 17 Dec 2019 19:05:27 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com,
        daniel@iogearbox.net, andrii.nakryiko@gmail.com, kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 3/3] bpftool: add gen subcommand manpage
Message-ID: <20191218030525.lhxuieceglidv3jf@ast-mbp.dhcp.thefacebook.com>
References: <20191217230038.1562848-1-andriin@fb.com>
 <20191217230038.1562848-4-andriin@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217230038.1562848-4-andriin@fb.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 17, 2019 at 03:00:38PM -0800, Andrii Nakryiko wrote:
> Add bpftool-gen.rst describing skeleton on the high level. Also include
> a small, but complete, example BPF app (BPF side, userspace side, generated
> skeleton) in example section to demonstrate skeleton API and its usage.
> 
> Acked-by: Yonghong Song <yhs@fb.com>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  .../bpf/bpftool/Documentation/bpftool-gen.rst | 302 ++++++++++++++++++

Please test it more thoroughly.

  GEN      bpftool-gen.8
bpftool-gen.rst:244: (ERROR/3) Unexpected indentation.
bpftool-gen.rst:285: (ERROR/3) Unexpected indentation.

Patch 1 probably needs foo(void) instead of just foo().
I think some compilers warn on it.


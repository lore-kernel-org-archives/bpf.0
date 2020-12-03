Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EE6C19425
	for <bpf@archiver.kernel.org>; Thu,  3 Dec 2020 18:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C48721D1B
	for <bpf@archiver.kernel.org>; Thu,  3 Dec 2020 18:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbgLCSdr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 3 Dec 2020 13:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgLCSdq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 13:33:46 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA70C061A52;
        Thu,  3 Dec 2020 10:33:06 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id e5so1571821pjt.0;
        Thu, 03 Dec 2020 10:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wTm4MsPFchb7Zj9BUbI1foUgKuinG+YS4/akILLACGI=;
        b=oFHZJaCwvNrf19hvnXoxTH3x8KSsk9R3Dwq8Mm+/rZ+XPPN4Sz1ODI3kJMI1SjX5Xj
         huAgu8QJzpzhYP9WfiBCD6JnUTBR1bON4+6mFmjwe1VT6hhkQtXb04cIGg1YhomJv2nI
         rO5DR8+8qCXRX19tEa6nNfTFA0GXpkAlyYxX0NgKeLWONHLa8N8guQpwbsQofVDPePcj
         sAEUm+3I8LhAd2pjM+GsXPpZfV35k52Orm7SQaL61mr6R+gIjUuvKohS+shnza981oc/
         rrst+0URTeK9QzBXczRb1I+cFbk47CeZOHMxFTzah1lRn0AdGzonBk8S3gW+9/rkOAhl
         +hWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wTm4MsPFchb7Zj9BUbI1foUgKuinG+YS4/akILLACGI=;
        b=Sj1iXm7Pw03eF6fj0GMqdOHOyBCXGfAYeQhqRHOAUyT5rudrWunG+x+DSrQYVvHbDd
         1e5y/KM2Sn+Gd5euQWkdFVKACQZq0pS4o8anUGTJwGn05bb3C2ARDKXNcPbInBelfgrv
         n3IIHrJ0uDD4JgUCyh0Ug/SZmbAFkD3pgUrpnD6JypN2A93oBDiAtu82OwlWkBPZyutV
         p8L5vtv9bAKcvW0HD2yOPXxGvGcErre2itp9Zd+bktyh52n7Vfw3D6jAUdfa8GNX0Z1N
         niW49WfzqJWy1kp7H6I7FXcmlCstPgGCvHRjXzpVVYiNS/IensEJSpEWgH8p9vFcqtIU
         OjCA==
X-Gm-Message-State: AOAM531O1QqchHZ3obvDPcOwFWvLbUnxCdCi+VLpyovdvoIR3j+Y99oG
        mld4TwM4j+cCOsOdM4tvPcg=
X-Google-Smtp-Source: ABdhPJxrD51vyIQ/hqEsn93ffMPY6H5K+fqlNL+jNZcv4BF/YBukJX+y/Kp9rQZ0iRK+/xGGyhHkrA==
X-Received: by 2002:a17:90a:930f:: with SMTP id p15mr381847pjo.73.1607020386076;
        Thu, 03 Dec 2020 10:33:06 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:400::5:a629])
        by smtp.gmail.com with ESMTPSA id x21sm2448717pfn.196.2020.12.03.10.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:33:05 -0800 (PST)
Date:   Thu, 3 Dec 2020 10:33:03 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
        ast@kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH bpf-next] selftests/bpf: copy file using read/write in
 local storage test
Message-ID: <20201203183303.zv6aqwqtamkhne4p@ast-mbp>
References: <20201202174947.3621989-1-sdf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202174947.3621989-1-sdf@google.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 02, 2020 at 09:49:47AM -0800, Stanislav Fomichev wrote:
> Splice (copy_file_range) doesn't work on all filesystems. I'm running
> test kernels on top of my read-only disk image and it uses plan9 under the
> hood. This prevents test_local_storage from successfully passing.
> 
> There is really no technical reason to use splice, so lets do
> old-school read/write to copy file; this should work in all
> environments.
> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Applied, Thanks

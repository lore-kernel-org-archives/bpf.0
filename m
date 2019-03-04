Return-Path: <SRS0=/NIo=RH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2C6C4360F
	for <bpf@archiver.kernel.org>; Mon,  4 Mar 2019 20:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39059206B6
	for <bpf@archiver.kernel.org>; Mon,  4 Mar 2019 20:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="YqpQ+fke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfCDU5T (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:57:19 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36231 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfCDU5T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Mar 2019 15:57:19 -0500
Received: by mail-ed1-f66.google.com with SMTP id g9so5392564eds.3
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2019 12:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lfs+edcsPqw9VdJpJJBfthDSqQJQ/Sz5ubtx/mb4vh0=;
        b=YqpQ+fkeYZyVDLUcP9Ep9pLbZ8qQy74vGru3GEz7x+EITVVUdssO7jIDOH/zHy7n7Y
         6wrhYx/c7Neo0odFfr2hFEKokugCzaXJZbdU1EdaooE+mAg7RIqQKOC7a7/cUA26i5uV
         MXDr0Bxx2rYW8RYGbzOvCxbqVzm9O5BRIZ9jv0Xi3J2ZLteKK6zSz2mLcs4SIrlSlQPT
         cGX+1NWUHpYgU52cYTZ1RBM/kUReljre6WchYXdaYzPmUj7RQILGRmrVzpWdqQfWC/pg
         B3gZoIt2Xb8cRjmYtKJMkneWyY4F7tr+RlpgVmLYmqBZE+5dF2H7lFSleSkarykaaIad
         dUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lfs+edcsPqw9VdJpJJBfthDSqQJQ/Sz5ubtx/mb4vh0=;
        b=NeUZEjARsn2IkcSoTp0rsJopfVuQb0CTvJgD+SXwEyXU4MAMQEb+WYX0Ep3ty3DiyA
         iRy7TBcT3gtruAxasLyLbeS6LhZzOYc52uyZKWRJEJIIMJD8vPu0SpjzbwrIXAq7st+V
         mO+A8P1yCmMreX2f1PMeR3SJqn4C2QZmlNsyKLKktFVmnemAh43Azzkx5Gh8s4P1wG2X
         L2muzgepydaSEj90TI3jE35QIqnqSi9Xy9i8HQi+4x2CJpIQPZGuC0lyqJV2PcyHYn5w
         kYC6PORhAsqg8K2YGtyDwKU2U8viYLuqw5mPV+OMQN7Hjq1f6hAy9mozcQmlHg2d5X3n
         4RPg==
X-Gm-Message-State: APjAAAXm7AGvaiYOBVKg0X/WBAWNTBXRMIlQe1t2K4XHhWoXiwNrANTD
        tWjr8t1NQr5+vObbvxeFOLNTYw==
X-Google-Smtp-Source: APXvYqxQfjzZvjgGr3Hbfl+w+e/Q1cgH44X+UrKJ/OKFJBx1Z/Or0s+H5GzLlu7uAMOVXQRdVCY29Q==
X-Received: by 2002:a17:906:860e:: with SMTP id o14mr9242259ejx.202.1551733037325;
        Mon, 04 Mar 2019 12:57:17 -0800 (PST)
Received: from brauner.io ([2a02:8109:b6c0:76e:3ddf:44fc:d22b:95ce])
        by smtp.gmail.com with ESMTPSA id w31sm2397479edc.46.2019.03.04.12.57.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 04 Mar 2019 12:57:16 -0800 (PST)
Date:   Mon, 4 Mar 2019 21:57:15 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] bpf: fix sysctl.c warning
Message-ID: <20190304205714.rhpgpp26rbaghs2i@brauner.io>
References: <20190304203443.1992942-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190304203443.1992942-1-arnd@arndb.de>
User-Agent: NeoMutt/20180716
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 04, 2019 at 09:34:12PM +0100, Arnd Bergmann wrote:
> When CONFIG_BPF_SYSCALL or CONFIG_SYSCTL is disabled, we get
> a warning about an unused function:
> 
> kernel/sysctl.c:3331:12: error: 'proc_dointvec_minmax_bpf_stats' defined but not used [-Werror=unused-function]
>  static int proc_dointvec_minmax_bpf_stats(struct ctl_table *table, int write,
> 
> The CONFIG_BPF_SYSCALL check was already handled, but the SYSCTL check
> is needed on top.
> 
> Fixes: 492ecee892c2 ("bpf: enable program stats")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Christian Brauner <christian@brauner.io>

> ---
>  kernel/sysctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 46a0d0a14a66..b3df3ab7ac28 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -3330,7 +3330,7 @@ int proc_doulongvec_ms_jiffies_minmax(struct ctl_table *table, int write,
>  
>  #endif /* CONFIG_PROC_SYSCTL */
>  
> -#ifdef CONFIG_BPF_SYSCALL
> +#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_SYSCTL)
>  static int proc_dointvec_minmax_bpf_stats(struct ctl_table *table, int write,
>  					  void __user *buffer, size_t *lenp,
>  					  loff_t *ppos)
> -- 
> 2.20.0
> 

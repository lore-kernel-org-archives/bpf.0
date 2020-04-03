Return-Path: <SRS0=JDc6=5T=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09450C2BA18
	for <bpf@archiver.kernel.org>; Fri,  3 Apr 2020 13:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9212078C
	for <bpf@archiver.kernel.org>; Fri,  3 Apr 2020 13:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585921102;
	bh=PC2IYsdht9e+jvsTcmuCw4auYP/a6NEOfdzSobgVLoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JB8s/U7gzlu/K/E1ZzfE0z4hHBOzCrqg5kb3nZRG4tlcaXoMSJ1r+kGKAy6gc4Atj
	 JCRtHfaKOX/PG5lv9UzrPU6l5tBHY7L+GE53wMCGbuGGOtLvNjpoEJOpIHMvn9aYxQ
	 GPTjS3fbdb3ro2XGILZaRWGfjGl4QrRwvpweTmIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390834AbgDCNiV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:38:21 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45901 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390770AbgDCNiU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Apr 2020 09:38:20 -0400
Received: by mail-qk1-f194.google.com with SMTP id o18so5083560qko.12;
        Fri, 03 Apr 2020 06:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kYnZHxpPGf7DaV2eyxdpVvKIQEJ0x8tV886Kl8XWxiA=;
        b=lrvUKqCgKFfiT00Eui7HGLx0wjeLy4R+GU/a2axO0G1VoL90GmeCpeKV+aGHLYBEnZ
         Syo4J2xHK1ckt26K8Que5Cq5POPiP25pcS5yM288zGSG276nU6nYUzm2EeIvBiOuKOY+
         kC7UxBeXCyDyXAphAhamhn7xgvNCl7p2hRM+6qW/7yBTAYHa5bo0Tq6QxyBV/r5JlDuC
         oo6iYqhiBeYusnpK1SIZlI2/wY/VVZd0rbIiicvHfb+c5zlvTS0v+80b4lNJlfkDAW87
         OvCHrn5h667rPGJbAE341oPeh/RbdJyEucU77d6z8wCc0T65DVrQyfRDcnPHpcDDmciV
         nmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=kYnZHxpPGf7DaV2eyxdpVvKIQEJ0x8tV886Kl8XWxiA=;
        b=MmmKhfilCkFvDD8Txx6ISyw2w1kJqKnFffMysh+bxKgzBV3gH0kOwgI8C4FtoWuV4G
         FU7Dl+pyMy00W+5cC96oEKz9lozjSJFuOUbLfpYxFvQKYEK/J4A5KsVClpklyZSz1Qoz
         fjtP9Z38nISfIV2xjaLaJ7Ho0bZD5nRC5/lnM+v/InV+tuQuFZv82f2rOsZBgPr3uwmy
         kWSW4w/NBA+raGPVi/+GdyReUCQrieEzOUWtJSiitmYj+2NP8n6+XGxCTbbDImWoEbOq
         Mqa2UlisCZd3MRsVC1LHaii6Hq5jSYWpS8OJ9pWp9tQcsfdpKw3CDySyBjngkEIspjvj
         7zuA==
X-Gm-Message-State: AGi0PubYo3Ngt1emZAWGLPMgjCEsKoysX57G6lF5Q5uXeoimgBVTDLaz
        KrlD4iLDggWv53IC5W5l4kc=
X-Google-Smtp-Source: APiQypL44cxfmuewwrpxwwbvpIKuvjPSzJvqGxjLEG8Ah2ndG4epcsnqs6WSVWBPiTG9XRxcx7UEZA==
X-Received: by 2002:a37:27cd:: with SMTP id n196mr9029422qkn.144.1585921099300;
        Fri, 03 Apr 2020 06:38:19 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::842b])
        by smtp.gmail.com with ESMTPSA id x6sm6182557qke.43.2020.04.03.06.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 06:38:18 -0700 (PDT)
Date:   Fri, 3 Apr 2020 09:38:17 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Dmitry Yakunin <zeil@yandex-team.ru>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        khlebnikov@yandex-team.ru, cgroups@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v3 net] inet_diag: add cgroup id attribute
Message-ID: <20200403133817.GW162390@mtj.duckdns.org>
References: <20200403095627.GA85072@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403095627.GA85072@yandex-team.ru>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 03, 2020 at 12:56:27PM +0300, Dmitry Yakunin wrote:
> This patch adds cgroup v2 ID to common inet diag message attributes.
> Cgroup v2 ID is kernfs ID (ino or ino+gen). This attribute allows filter
> inet diag output by cgroup ID obtained by name_to_handle_at() syscall.
> When net_cls or net_prio cgroup is activated this ID is equal to 1 (root
> cgroup ID) for newly created sockets.
> 
> Some notes about this ID:
> 
> 1) gets initialized in socket() syscall
> 2) incoming socket gets ID from listening socket
>    (not during accept() syscall)

How would this work with things like inetd? Would it make sense to associate the
socket on the first actual send/recv?

Thanks.

-- 
tejun

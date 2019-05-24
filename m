Return-Path: <SRS0=P0Qj=TY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E72C072B5
	for <bpf@archiver.kernel.org>; Fri, 24 May 2019 19:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22229206BA
	for <bpf@archiver.kernel.org>; Fri, 24 May 2019 19:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="RLRGO3UB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403871AbfEXTtM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 24 May 2019 15:49:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40105 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403826AbfEXTtL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 May 2019 15:49:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id t4so2829681wrx.7
        for <bpf@vger.kernel.org>; Fri, 24 May 2019 12:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=TILQc7IBK5DyshHhuRAvTZ5jpVohpFDdaxVo2uq40fQ=;
        b=RLRGO3UBIv00U/MbFztGZFpiFJIdtPq6fD6noY6L6V7fSXMbztpadGCJeI1G1CxZzt
         TO0Tv53vBas4TWP5LuwIjfsxk6HnDk2ImfdOnk7VE5eiLmQ6YAb0KxnEEEeNfRtc8Zlp
         dV+osneA3vU60BVlqROe9TGvno2xFMgd6qp7BzIBjHLAckVocRUqY959+AQhVrY78QNJ
         Yi2IyGjle9taDR2WUjWOXxOgLkUC0suzQZpM/+VTFSqWjta2KIJ0b9As+mK/IQNKSorC
         sa5rmS8FrEY+SM/GgfxlR1bKOTurv8td5NLENTkLs3i+/S8bcVkm80Ar8Wgm0zIm9b6I
         o40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TILQc7IBK5DyshHhuRAvTZ5jpVohpFDdaxVo2uq40fQ=;
        b=fhXWSeVGeTebvo1YJQfrnBP9tpDBt9mgeukRC57POgVPA+TjIY3LOoEprt4C1R5f9x
         TPK2Ce3myAieDlvu8c3pbV7HFj9nOku7yramoPPzun7EZJ3DxRrLoEs92U5k2J6l+fFR
         BN/aftXbLcRsw5otaxcwIbWxEg+Z6xq6WkTJ2SmQMQ8wyExcJYSkvlSoQ6kEcpDCgpz1
         AhBka8Cjj7BixMr1Z2UjuijLIRZmmXf+f9P+WEtD46eWyHWIvoIdbhEBFBbeFFT9s0XE
         EhzciM0R9gdOMvLgRdGTK4rKwe7e6+bV2EXNhs9AkvAbfZgAvqq4x8uXD8T7FtXKqzEp
         frQQ==
X-Gm-Message-State: APjAAAVA5iP49RrVBZOfZVFT9Qh2S4ZUmiaeU0dF50HOo+MkVMnRGtzr
        AiTvXhlpWqDNoKBpfVqV6/EiPg==
X-Google-Smtp-Source: APXvYqx5imuUZjVhb/5JdaC28L0UZVC65kPoyQrMSf4kltBLF2eQceu6mqsGs1LzFqNHTZQoc1zuBw==
X-Received: by 2002:a5d:4988:: with SMTP id r8mr1050597wrq.57.1558727350431;
        Fri, 24 May 2019 12:49:10 -0700 (PDT)
Received: from [192.168.1.2] ([194.53.186.20])
        by smtp.gmail.com with ESMTPSA id n4sm3958576wrp.61.2019.05.24.12.49.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 12:49:09 -0700 (PDT)
Subject: Re: [PATCH v3 bpf-next 12/12] bpftool: update bash-completion w/ new
 c option for btf dump
To:     Andrii Nakryiko <andriin@fb.com>, andrii.nakryiko@gmail.com,
        ast@fb.com, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
References: <20190524185908.3562231-1-andriin@fb.com>
 <20190524185908.3562231-13-andriin@fb.com>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Message-ID: <fd4e7c44-61c3-2194-c0c7-6bdd80d22309@netronome.com>
Date:   Fri, 24 May 2019 20:49:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524185908.3562231-13-andriin@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2019-05-24 11:59 UTC-0700 ~ Andrii Nakryiko <andriin@fb.com>
> Add bash completion for new C btf dump option.
> 
> Cc: Quentin Monnet <quentin.monnet@netronome.com>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>

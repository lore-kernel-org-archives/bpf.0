Return-Path: <SRS0=N9AH=77=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE8AC433DF
	for <bpf@archiver.kernel.org>; Thu, 18 Jun 2020 00:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE8542080D
	for <bpf@archiver.kernel.org>; Thu, 18 Jun 2020 00:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent-com.20150623.gappssmtp.com header.i=@isovalent-com.20150623.gappssmtp.com header.b="BW9NTClR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgFRAaW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 17 Jun 2020 20:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgFRAaV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Jun 2020 20:30:21 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F85C06174E
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 17:30:20 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b6so4194036wrs.11
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 17:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xII6XSCz2jFDqpfIO13B3lnPOpUp01byjrtugdY/4Gs=;
        b=BW9NTClRieTX1SjiyLnWfp593dWQ65ulFE5NOfI5veDHJOYhEYEJ5mbR6Pg6jlRbef
         F/fP1I2g6v4pYxa1B6E6tLAVQTzkH1780kZmzcUADIHU0fr9ZE23KhZHfF2Vx8kSTDmA
         CdhtD4SX2DtPfRKRdtGXUp0OZ2yKEJoPyXwOyO6jD4N++C/PRtBEJyDV/Ndbr3MdPvbE
         0bFS4QP5jQaYMY4gw1TnXOnyNTH6z6bxHc3oFtHPYJjf0owr0S/CpbircOE9j5vKjlqt
         799OAhLyGHjSLyqtD271+4ldJhR/S0kks0mq2cibGs+aPIqJytVyXvIyLnf4QFj53qvF
         M4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xII6XSCz2jFDqpfIO13B3lnPOpUp01byjrtugdY/4Gs=;
        b=R9JCMoUsuZ8PDJIMypP1p7QWMwkbyQDgDWJ+B+PefUpyVU9mZ4qGd1OCoWtnx8+vZT
         eLHol7ZMzg56VVrKT4jyJjxyY4gnLERJAkVSAvJbdeitgWJXqe6Ez4WmIrWh13ADJsqt
         jFDm2qJTA1DiTPObUP0i+7+9s6dWImXzNr7p+P8bOrqO2x0mvTmr1l+6+R4MR5mMlLsx
         LUlDudvtGPJLRMlFEt9qC77MTsDgydGfPU/S1ngyGC6T5yLcV/Qyf7Qqg6LgW4vLeaHR
         GDEeusG8xMW59hEVBRru0Wk/irnsaY20esd1XWFFpeE40Qysb4E+GZDqo7Ldi5I5KUq6
         2ayw==
X-Gm-Message-State: AOAM5337OE0Vjr2ZDXnI35dwOVfDkcKjDoFsubFKqRAe/Rt4h2QypGEP
        MOI5wJ4zxvwlxYnHXdS7JIQV5w==
X-Google-Smtp-Source: ABdhPJx8CJSpPYImFopNEWop5ASAPeKZiJDIkGBCSwidxE9mrttMpYc5bjCZNj+0b9LxaQJA9TfLcA==
X-Received: by 2002:adf:c707:: with SMTP id k7mr1707060wrg.382.1592440219374;
        Wed, 17 Jun 2020 17:30:19 -0700 (PDT)
Received: from [192.168.1.10] ([194.53.184.244])
        by smtp.gmail.com with ESMTPSA id g3sm1480699wrb.46.2020.06.17.17.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 17:30:19 -0700 (PDT)
Subject: Re: [PATCH bpf-next 5/9] tools/bpftool: minimize bootstrap bpftool
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com, daniel@iogearbox.net
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Song Liu <songliubraving@fb.com>
References: <20200617161832.1438371-1-andriin@fb.com>
 <20200617161832.1438371-6-andriin@fb.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <16c2fd4e-d05a-0860-262d-cd129ccac6d7@isovalent.com>
Date:   Thu, 18 Jun 2020 01:30:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200617161832.1438371-6-andriin@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-06-17 09:18 UTC-0700 ~ Andrii Nakryiko <andriin@fb.com>
> Build minimal "bootstrap mode" bpftool to enable skeleton (and, later,
> vmlinux.h generation), instead of building almost complete, but slightly
> different (w/o skeletons, etc) bpftool to bootstrap complete bpftool build.
> 
> Current approach doesn't scale well (engineering-wise) when adding more BPF
> programs to bpftool and other complicated functionality, as it requires
> constant adjusting of the code to work in both bootstrapped mode and normal
> mode.
> 
> So it's better to build only minimal bpftool version that supports only BPF
> skeleton code generation and BTF-to-C conversion. Thankfully, this is quite
> easy to accomplish due to internal modularity of bpftool commands. This will
> also allow to keep adding new functionality to bpftool in general, without the
> need to care about bootstrap mode for those new parts of bpftool.
> 
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>


Return-Path: <SRS0=5rgj=45=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960E7C10DCE
	for <bpf@archiver.kernel.org>; Thu, 12 Mar 2020 11:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E9220737
	for <bpf@archiver.kernel.org>; Thu, 12 Mar 2020 11:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent-com.20150623.gappssmtp.com header.i=@isovalent-com.20150623.gappssmtp.com header.b="nUwF//Pe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgCLLq6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 12 Mar 2020 07:46:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35925 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgCLLq4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Mar 2020 07:46:56 -0400
Received: by mail-wm1-f65.google.com with SMTP id g62so5932145wme.1
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2020 04:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HPUubc5PLfCOidwZFi8Nu8RG5U6jxniZ8hzkTbTv8XA=;
        b=nUwF//PeFlTEC2JYk/uFPYZxm7ostghy1vNSXANnRNXC6PhZaBhzZgi5L8J/0ooEP4
         5BdYZ6kJMYmo0PwpepnKDoarNfzb4aIoiHnGOYwFYT39xmNAuKoXcHOCknE+uP3tHXKV
         mDjYXgFny950DdD0z1Ap/AzV0i+V/aVnhG29h3aOg2BLp2jo6CJjMCYSx9wRDVyzoOqV
         wL/oaVWEi05DJpcPbwxlMzY7NRH7W43qrrPVvkQFruU9L5z2PgQL4X9RnW1ljLnHMF/b
         o98IRsy3wSbhN6DSJVjee3QOhHpoWoFpF3xolSnT/PHwDs8B1P1rpEgYICYZN/uNveyb
         shsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HPUubc5PLfCOidwZFi8Nu8RG5U6jxniZ8hzkTbTv8XA=;
        b=HkLOXXDfxYoPylBEn/Pd97rLytNQmVtitrBTi2pGbOnu2JQJ8BW3GoBR6RRfv/18bs
         NM3svKy7faqKrmlmItCm+++ubX29eGr1C1AFtqcsTB3EzfsMO4L2Xf+uQ7Hq8NVxNr8Q
         CHKeQp/AshKwk4yP58+t0+2eKfdhZwrB9PT/GhIn1d7oaeWHu5XCMds5AomImUGJCUyo
         LESWsCK1QYTAfdKokao0utsa/AnSurc+NKXy+SUB/yYCqbeyUMCkTo9uHwXGrjryqv+W
         DDyuOgFn8bhXu9lk3b+yfn5KY3nAVdQ60LUeVc698tFwDyhwNRI7KX349KfwEznTodNq
         /iDg==
X-Gm-Message-State: ANhLgQ3kaA33ucH15H9g+2ZMEhZytT1EPLzrh3lPOn+7VprLqlcVezNt
        H5GnzDUsJEx7spIM42+Oh4rRNw==
X-Google-Smtp-Source: ADFU+vuS9k2SgYkR8g6ojiUjCT9n7w+HLuR649RuOA/ffyhwsQdnWhhLWtNGqYYy/Ox4OHm8A208hw==
X-Received: by 2002:a05:600c:2252:: with SMTP id a18mr4679566wmm.51.1584013613007;
        Thu, 12 Mar 2020 04:46:53 -0700 (PDT)
Received: from [192.168.1.10] ([194.35.118.177])
        by smtp.gmail.com with ESMTPSA id l17sm13630855wmg.23.2020.03.12.04.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 04:46:52 -0700 (PDT)
Subject: Re: [PATCH v2 bpf-next 2/3] bpftool: skeleton should depend on libbpf
To:     Song Liu <songliubraving@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     john.fastabend@gmail.com, kernel-team@fb.com, ast@kernel.org,
        daniel@iogearbox.net, arnaldo.melo@gmail.com, jolsa@kernel.org
References: <20200311221844.3089820-1-songliubraving@fb.com>
 <20200311221844.3089820-3-songliubraving@fb.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <bf7fdd9c-f43d-1ef5-dad3-961a4534463c@isovalent.com>
Date:   Thu, 12 Mar 2020 11:46:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200311221844.3089820-3-songliubraving@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-03-11 15:18 UTC-0700 ~ Song Liu <songliubraving@fb.com>
> Add the dependency to libbpf, to fix build errors like:
> 
>   In file included from skeleton/profiler.bpf.c:5:
>   .../bpf_helpers.h:5:10: fatal error: 'bpf_helper_defs.h' file not found
>   #include "bpf_helper_defs.h"
>            ^~~~~~~~~~~~~~~~~~~
>   1 error generated.
>   make: *** [skeleton/profiler.bpf.o] Error 1
>   make: *** Waiting for unfinished jobs....
> 
> Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")
> Acked-by: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

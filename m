Return-Path: <SRS0=eg6P=T5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95ECC28CC1
	for <bpf@archiver.kernel.org>; Wed, 29 May 2019 09:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B4E20665
	for <bpf@archiver.kernel.org>; Wed, 29 May 2019 09:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="BQTKFzkB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfE2JSF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 29 May 2019 05:18:05 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37984 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfE2JSF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 May 2019 05:18:05 -0400
Received: by mail-wm1-f67.google.com with SMTP id t5so1034249wmh.3
        for <bpf@vger.kernel.org>; Wed, 29 May 2019 02:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PA7o+E5TanGr16h7Oy845fcFh8G+pAiv4rWZfkX/jjI=;
        b=BQTKFzkBVyyJw/5nn247Cer8dg7TyVU4wv8QAOoWRl6JTMAQiw4/zk8X4vUIF1K6jx
         +D3zHTTJGooSSEbfuVfNF0dS0ngrIO0j4I9Pi+O2U5OaTRhGoQlbNlUcab9smZ6t5+13
         8vNGft3DwvSM5GFWYLrT2a6i1Nk3ATXcEpu2sCce+v/M9QtHYMTs/HFqu4K5uamuDaHq
         cxRe79oMnpsUvNedfGL8IutjCEEX/lv2gTJkbJz7EYWhh253dkGn4fqBnI59KuAAPAn9
         SGy5qoKkjOURTS6WssbVC/74QFhP2T4nvRTmse2nVr465749SeP4T/XxMopmtV50r9up
         lrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PA7o+E5TanGr16h7Oy845fcFh8G+pAiv4rWZfkX/jjI=;
        b=qlIDBVy7Pe2DJVLg12gx1IEKQLsx5P9hGMid999TSML2skP4fn25gTOMD+WwSAUXIK
         u47bswRdghl9aAhMJfhBtpJwzLR8ioZodu1ICVm/3e2minlZW3KeEidHSJJyjHSyCfUJ
         naR+v2QvsJRw1X1iAMGTmo26QDhU8It2BPKCgXT/KhY11uPyD8tcV6/iKoOHVDBmQvN8
         Fi4WbpdBzJPSDhAGP7rCkP0SEoS0t0VO7Eoyq8tYRsZKTzqOW4Kxvsyx4AUi9pEYr73G
         xHiPzT8tuPNqA1cm5SPjOF9bFs3VV72bBtfzaL2R0YKVYMQKxfG/i8WHqpWdt5C8DF19
         /m+w==
X-Gm-Message-State: APjAAAU6/sIV3GhGG5rsZIkDVKs13YSdz456z0VBETyJo7aVYqYqbX5g
        fFtLAOAp82eSbyXu2UKwvqxlQg==
X-Google-Smtp-Source: APXvYqx3K5WS7jTcKEBdb+W1wgXo5qW2Emzn407GM/gllJHuwwpXz0Vlm0xarau4UMZnbVwPBod/aA==
X-Received: by 2002:a1c:4054:: with SMTP id n81mr4716322wma.78.1559121482805;
        Wed, 29 May 2019 02:18:02 -0700 (PDT)
Received: from [192.168.1.2] ([194.53.187.60])
        by smtp.gmail.com with ESMTPSA id y2sm4553438wra.58.2019.05.29.02.18.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 02:18:01 -0700 (PDT)
Subject: Re: [PATCH bpf-next v3 2/3] libbpf: add bpf_object__load_xattr() API
 function to pass log_level
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        oss-drivers@netronome.com, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
References: <20190524103648.15669-1-quentin.monnet@netronome.com>
 <20190524103648.15669-3-quentin.monnet@netronome.com>
 <CAADnVQJ_V1obLb1ZhkKWzuPhrxGBjJOuSbof6VrA6vxT+W463A@mail.gmail.com>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Message-ID: <d6c99b5c-8a88-f604-4ae6-76ccfb4aee49@netronome.com>
Date:   Wed, 29 May 2019 10:18:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQJ_V1obLb1ZhkKWzuPhrxGBjJOuSbof6VrA6vxT+W463A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2019-05-28 17:35 UTC-0700 ~ Alexei Starovoitov
<alexei.starovoitov@gmail.com>
> On Fri, May 24, 2019 at 3:36 AM Quentin Monnet
> <quentin.monnet@netronome.com> wrote:
>>
>> libbpf was recently made aware of the log_level attribute for programs,
>> used to specify the level of information expected to be dumped by the
>> verifier. Function bpf_prog_load_xattr() got support for this log_level
>> parameter.
>>
>> But some applications using libbpf rely on another function to load
>> programs, bpf_object__load(), which does accept any parameter for log
>> level. Create an API function based on bpf_object__load(), but accepting
>> an "attr" object as a parameter. Then add a log_level field to that
>> object, so that applications calling the new bpf_object__load_xattr()
>> can pick the desired log level.
>>
>> v3:
>> - Rewrite commit log.
>>
>> v2:
>> - We are in a new cycle, bump libbpf extraversion number.
>>
>> Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
>> Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
>> ---
>>  tools/lib/bpf/Makefile   |  2 +-
>>  tools/lib/bpf/libbpf.c   | 20 +++++++++++++++++---
>>  tools/lib/bpf/libbpf.h   |  6 ++++++
>>  tools/lib/bpf/libbpf.map |  5 +++++
>>  4 files changed, 29 insertions(+), 4 deletions(-)
> 
> This commit broke ./test_progs -s
> prog_tests/bpf_verif_scale.c no longer passes log_level.
> Could you please take a look?
> 

Indeed, I forgot that bpf_load_prog_xattr() would eventually call
bpf_object__load_progs() as well, where the log_level is now overwritten.

Fix incoming, sorry about that.

Quentin

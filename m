Return-Path: <SRS0=Gny/=WM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E84C3A59C
	for <bpf@archiver.kernel.org>; Fri, 16 Aug 2019 16:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4822077C
	for <bpf@archiver.kernel.org>; Fri, 16 Aug 2019 16:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="t4m+v2/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfHPQlJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 16 Aug 2019 12:41:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51940 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfHPQlJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Aug 2019 12:41:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so4532721wma.1
        for <bpf@vger.kernel.org>; Fri, 16 Aug 2019 09:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Aco6RlnDGHj3Ldvlxx9E7QBew9pXCsTOcrznKjN5B8o=;
        b=t4m+v2/YmsK/MKhAbTR4jbzSkJ7rpetP67sxw6u6NX3LkbS8j1Ni0rHPzPJJ2yB0n3
         6f29bbMagDwx2chCL5QOXny1Mex5kUC3TrMJLHQ7RYT98gVmuZRVxpZUdGXMzX5qAok2
         MWBHxLvAA0gsQwGVi/VeHyHVVr5hSi2xcdD/M0VlZpfDnLU33w+AVeBrHbSJntMUbVXT
         k3CjKymZEDvReShrXNqOEbzByoDwGN2qOlOl46tBOapgbup6OSPkU5vaxXzvEmm77IZr
         R6WmQC0re2ZfwW1O8b0XKcLx/CpXJleVSWRd2k8xS+EoNjVDQA8jYs3LStXE6/NOkgB2
         0LCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Aco6RlnDGHj3Ldvlxx9E7QBew9pXCsTOcrznKjN5B8o=;
        b=Cro83H9H0ocnGEsYsAEtXvl6A9HuLTb/W5YN+hJQ71HhiLX6z0yj59l49HSCUCyTHr
         ZbJVG5FJ43roHkpajLyPBCXX7A//LccVuWE2ckq9KP+klQqRb3QKZ8VrG5yrmw5e2cKx
         m8o7KWKeTtXKfbDdVpOQmhbdDzHpR2j9sOSULdEXgLMVJwkh0GgXDg/PrSyH/TLMaHFY
         9D/qlP/NGLQNT3UuONDuiWc9p4BxkW1N8GefZZfXW2cLyafdrE0M7HvLmQEYxDv7qicH
         9PCnKzCAtzUFoX2bpOh87pm+8F2paEMey0WQrjdLOzAEPDakOz+VT3QhN3B3XEWZ8nTl
         qzDQ==
X-Gm-Message-State: APjAAAVjM/JrldOuwMwJJsAfRVEKWcfPknMtn0AaDJ7cWM3YvNpSOHPU
        AgxAWL8d/TCDsUQT80DeoB/RPA==
X-Google-Smtp-Source: APXvYqz3gPhu2PqxetwNSRSNB9jAeiUSXpI7IpKwc+DNXDp++HPjsy07mF5n2fEpWEHvZU6TDMRUCg==
X-Received: by 2002:a7b:cf21:: with SMTP id m1mr8804898wmg.150.1565973667374;
        Fri, 16 Aug 2019 09:41:07 -0700 (PDT)
Received: from [192.168.1.2] ([194.53.186.47])
        by smtp.gmail.com with ESMTPSA id h2sm3761565wmb.28.2019.08.16.09.41.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 09:41:06 -0700 (PDT)
Subject: Re: [PATCH bpf 0/6] tools: bpftool: fix printf()-like functions
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        oss-drivers@netronome.com
References: <20190815143220.4199-1-quentin.monnet@netronome.com>
 <CAADnVQKpPaZ3wJJwSn=JPML9pWzwy_8G9c0H=ToaaxZEJ8isnQ@mail.gmail.com>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Message-ID: <10602447-213f-fce5-54c7-7952eb3e8712@netronome.com>
Date:   Fri, 16 Aug 2019 17:41:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQKpPaZ3wJJwSn=JPML9pWzwy_8G9c0H=ToaaxZEJ8isnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2019-08-15 22:08 UTC-0700 ~ Alexei Starovoitov
<alexei.starovoitov@gmail.com>
> On Thu, Aug 15, 2019 at 7:32 AM Quentin Monnet
> <quentin.monnet@netronome.com> wrote:
>>
>> Hi,
>> Because the "__printf()" attributes were used only where the functions are
>> implemented, and not in header files, the checks have not been enforced on
>> all the calls to printf()-like functions, and a number of errors slipped in
>> bpftool over time.
>>
>> This set cleans up such errors, and then moves the "__printf()" attributes
>> to header files, so that the checks are performed at all locations.
> 
> Applied. Thanks
> 

Thanks Alexei!

I noticed the set was applied to the bpf-next tree, and not bpf. Just
checking if this is intentional?

Regards,
Quentin

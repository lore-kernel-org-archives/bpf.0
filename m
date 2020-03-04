Return-Path: <SRS0=QYSm=4V=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12E7C3F2D7
	for <bpf@archiver.kernel.org>; Wed,  4 Mar 2020 23:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BFD20870
	for <bpf@archiver.kernel.org>; Wed,  4 Mar 2020 23:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583363375;
	bh=lzYSK+MEuk72nMhzqBd5bNzw6N8PHF0L/J1HXFibw0Q=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=bOJ4nKO40QuddwczN5fsDdLZnqERDutxUZ3czLI9jAlz3RMh3FtylDg07PiCAZiN9
	 5ze0n+GAQ6egfxhy5SXg7v+N+bHX8l7Syq7YbsLbzpgK4kPrXal71OwwBKGx5kgh+3
	 cPh0CN2P7vyndrdavUbxBOOhX44CBbIBSlrmrddE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388507AbgCDXJb (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 4 Mar 2020 18:09:31 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:33437 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388473AbgCDXJb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Mar 2020 18:09:31 -0500
Received: by mail-io1-f66.google.com with SMTP id r15so4390229iog.0
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2020 15:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LO4sFnLO2wiKWhH2CPGBBj7RnEjSWuWu+5bPaWGne3A=;
        b=GRUxsx43gpC2xVKP9oFcjdHOtdsoBEiZVqdYpYccGdnPmwDJ5vaIAUlkJkYEwM2cn9
         4iBt9rhv3B5SnI7cZpBxkf8bnsueotIEG7J6JKz6nkQSN7xuo7MqW2KmYc47CwuDZdqq
         UTfnBjMjiUEv9mQcXNkWTEDhbTK9axnU9qTYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LO4sFnLO2wiKWhH2CPGBBj7RnEjSWuWu+5bPaWGne3A=;
        b=MjZvpBs5ntbve3S7RX0sAzLglVTyrz1THOS7kqfVtlSZqIY1tUaitORL20GB96D42S
         XsrVLDJhZmrnAOSPOh0ogT4jw/FRRB03j2DWkvVe/MI5QibAU00k8J8sP8lOpSRC/br6
         iOnD7W5SImfJJ7clbXRnoSWj9B0FtRlgA6y+gk7/yXTbYkiaKR6PgNSe3BxKeBsgrNIE
         yASPSiEU5KfKDgfKxlXw6RjsFf73knuqBfITEUVfWvM7CQQ7Re2tlYc6VTAhvVDDZ/AP
         psJ2N4X7zuTBDPIcGJ0B1w9rLF641DwG2mGp/+7204ySDyYiX2XmKj09yBwPN7k2CtkV
         0ZUA==
X-Gm-Message-State: ANhLgQ0shIJZaQI0ib1w1unzbp12DtPU+g9QkYmTCGXu6IFP+CgaSqwh
        bABv2cKbPSYVxx5zfxXvAZnRaw==
X-Google-Smtp-Source: ADFU+vtyCpv8ORr2dtmq5bQJdqqW/cgZJGtUiAs4EcPOweiSbguRMZiA3Ga6HVFtBYEgjjU6+sp9Vg==
X-Received: by 2002:a5d:814a:: with SMTP id f10mr3969167ioo.7.1583363370669;
        Wed, 04 Mar 2020 15:09:30 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s3sm8163040ild.7.2020.03.04.15.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 15:09:30 -0800 (PST)
Subject: Re: [PATCH 0/4] Kselftest integration into Kernel CI - Part 1
To:     shuah@kernel.org, keescook@chromium.org, luto@amacapital.net,
        wad@chromium.org, daniel@iogearbox.net, kafai@fb.com, yhs@fb.com,
        andriin@fb.com, gregkh@linuxfoundation.org, tglx@linutronix.de
Cc:     khilman@baylibre.com, mpe@ellerman.id.au,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <cover.1583358715.git.skhan@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <408294cd-5c54-d8c2-1dce-7224699670fe@linuxfoundation.org>
Date:   Wed, 4 Mar 2020 16:09:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <cover.1583358715.git.skhan@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/4/20 3:13 PM, Shuah Khan wrote:
> This patch series consists of first round of fixes to integrate
> Kselftest into Kernel CI.
> 
> You can find full list of problems in my announcement I sent out
> last week:
> 
> https://lkml.org/lkml/2020/2/27/2221

Here is the lore link:

https://lore.kernel.org/lkml/3b3dc707-7ae7-955b-69fe-b9abe9ae26c5@linuxfoundation.org/

thanks,
-- Shuah

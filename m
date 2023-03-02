Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8590C6FA8E
	for <bpf@archiver.kernel.org>; Thu,  2 Mar 2023 20:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjCBUA3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 2 Mar 2023 15:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCBUAN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 15:00:13 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A1F4FAB1
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 11:59:06 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id f1so290032qvx.13
        for <bpf@vger.kernel.org>; Thu, 02 Mar 2023 11:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677787143;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOmepKjJm4UDTYOeJgqWRGcYVvrwIseA5Oi+dzRvTJU=;
        b=HvuATuLQsyiPsCXXIr8jxpQuxhv+4iUCRvNd+KAGVXdJ5ZOAEo4XClJT5C8mhVMzBI
         ubbRSRQNa/Oc24pJ/frQWVdwb8Ej5V1ppYpjEq6sTHKpwJGJuDqoevM2TENSLrGEcMMh
         mkrmDnjHXr3uOLdhVgl441+sMd+ASFAh718k5HpRqOsOG8Uh2C1Mi5LQ50YmqG3W+UMv
         TOom2bk58opkiuyBJPN9CdrMC5KdD0bjmkV/idNxtDylGBj+EFfaUvNla/tG9mdz4Mx3
         QOvyQlCnDWn/VynaWZyzE+1Tb/1H2mnYuaW6G5TbXKF+3XUrcmKzkZ6bUJ+fixKlMZW+
         uFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677787143;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eOmepKjJm4UDTYOeJgqWRGcYVvrwIseA5Oi+dzRvTJU=;
        b=kyPITFpN4YMqlY4mHGnZ0NUPyXoIioruIuqQt+spoLUaJcoRApL9xbhQ+fTir9wxvQ
         NYlJm8jRaAlJLufRm8+qunZyFT+cLzY0XXqRhh4JXFwQsYe+oZGj+qJS0jOmihQXGYum
         nAop5TwY6YjcXQYhvc5pkbOdZtrqdE91BCWXMYZKYf5v51DKc4EgiKs+rEP/J3PCzrcn
         s22MQb6J3DSa3SZFmnxTPjukJ8R25qbCKt/dsoWpCfST5eTqHUWGGxVHjPrlT9I5rzq5
         jLNb2vqmxMiJAjwGWkbVMxvz+DOUvq4J9jwzLiqL/90VBFS+ChHpBpTl4J3xOFHqnABR
         piRQ==
X-Gm-Message-State: AO0yUKV9cLVjdp7/qxWKErTcgKtSIIEer3i6ILUjH9KpmyrSTynTmH0l
        pW4UKeUwyMKmPCuV7jmTCPWSgm3tQhnxIEllCnQ=
X-Google-Smtp-Source: AK7set/gmLYfloYu2DPPX+3RLyd/x3vfiz+QVG6KisgpT2L2sdYmjv2M58tHJbeVsV40XC7T5o4Yqw==
X-Received: by 2002:ad4:5e8c:0:b0:572:80ea:5fc7 with SMTP id jl12-20020ad45e8c000000b0057280ea5fc7mr21946476qvb.41.1677787143129;
        Thu, 02 Mar 2023 11:59:03 -0800 (PST)
Received: from [192.168.1.9] (c-73-238-17-243.hsd1.ma.comcast.net. [73.238.17.243])
        by smtp.gmail.com with ESMTPSA id n67-20020a37bd46000000b0073ba2c4ee2esm268796qkf.96.2023.03.02.11.59.02
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 11:59:02 -0800 (PST)
Message-ID: <a5f37b39-64ad-57ca-cafc-124a318f44cf@google.com>
Date:   Thu, 2 Mar 2023 14:59:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Content-Language: en-US
From:   Barret Rhoden <brho@google.com>
To:     bpf@vger.kernel.org
Subject: BPF_PSEUDO_CALL function calls are not allowed while holding a lock
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi -

I'd like to be able to hold a BPF spinlock and call a static function 
elsewhere in my BPF program.

Depending on whether the compiler chooses to inline a function or not, 
I'll get a verifier error like:

	573: (85) call pc+126
	function calls are not allowed while holding a lock

I think that's considered a BPF_PSEUDO_CALL.

I can get around it by sprinkling  __attribute__((always_inline)) all 
over the place, subject to the compiler actually inlining my functions.

Would it be possible for the verifier to maintain the 
env->cur_state->active_lock.ptr state or something across those calls?

Thanks,
Barret


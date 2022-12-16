Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606CBC4332F
	for <bpf@archiver.kernel.org>; Fri, 16 Dec 2022 11:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiLPLBt (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 16 Dec 2022 06:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiLPLBs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 06:01:48 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DDD656F
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 03:01:45 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o5-20020a05600c510500b003d21f02fbaaso3829125wms.4
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 03:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5VoLFcXygeu1rPdOxD3yUrpijJadRRU610TmdVkHxJs=;
        b=plMskY3rZ0i8fJQ9wXlm2Q3Pg7cF1CORbPNRLZ5vPOfdvEaEwLUtEGUFpM7XR1uB2o
         WrTv8jiqE5icGf+W8w4REw3FGAgyPfDaAL4ktJudasX0eSBMpRWm3ntpdrPJftb0+pIB
         ShXb2i2Wq59SWRw4ngLqsGaHHvPIBR965vWEYGS+7JOep9Z5OUE0qPl/9kGpTTEcJ34V
         oU8vi76DJ99TMfrqqLshnuWczKVYbeFD8WbV1ByLjezHbDVTDgmzSqGinQEqFfAeAmAt
         8NjOonlG0PWMgeH53l3LoJ9t9Qso4yly1zu/xPBjTS0P3UEAcZTuv6A5XlBaVWVRO/q4
         3sSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5VoLFcXygeu1rPdOxD3yUrpijJadRRU610TmdVkHxJs=;
        b=LrB7rB5CpWQ+bsiXx8Bwl0dT0MJAPjgRdep4q1Tf0JtG70PTQmMveNqLJ+oH1L1uq1
         GD6zt2De/ZVNwHQUkuOGwHomqTEUIHiqR7UgNta3F/ZLmNFprOO7zmI+1aL+trVVv80l
         FndLRGFJYoT5drYgttaeAHJipIrAszjgt95PZRaDD3Qn4IxLpcw+6CJa8qP6enQzc2J2
         6iCreOg8z6Lm3++Qg87cR7pfgoxI8vIx6lE2TUrhgoOeJZ35Sxfmd30RySLvimHdz3KH
         4OzrK5QZLutP5PRTG/386oPyfCeZCU2WolLZQYR8ezbYDAOv8sbf/xQjEmK0jLy0p5zT
         oVwA==
X-Gm-Message-State: ANoB5pmwxc1zSQnm4t3nKjNbVzvs9/f882xPQ4cLwkXcbUbt1i7Nq5nJ
        ET5P7CbORJqTAecucVXILliqLYBpI25KEUIUYDU=
X-Google-Smtp-Source: AA0mqf4iUEIPpUM4P6rfvaZIz09yoaz68LhR/wHGcHHYQSof98DoPBmD3tGEZ5hLFifTiCLs6PQl9+K8qdXua9wNEYI=
X-Received: by 2002:a7b:ca59:0:b0:3cf:cf89:90f with SMTP id
 m25-20020a7bca59000000b003cfcf89090fmr568331wml.186.1671188504466; Fri, 16
 Dec 2022 03:01:44 -0800 (PST)
MIME-Version: 1.0
References: <20221214103857.69082-1-xiangxia.m.yue@gmail.com>
 <20221214103857.69082-2-xiangxia.m.yue@gmail.com> <73b9ef21-de67-e421-378a-1814ffbc263f@meta.com>
 <a0c44452-70b0-8b05-151f-932c3b9e2fb0@huawei.com> <406710d0-bd65-a6b0-a7b4-9fa8c72ccaa6@huawei.com>
In-Reply-To: <406710d0-bd65-a6b0-a7b4-9fa8c72ccaa6@huawei.com>
From:   Tonghao Zhang <xiangxia.m.yue@gmail.com>
Date:   Fri, 16 Dec 2022 19:01:08 +0800
Message-ID: <CAMDZJNXiA1dbzkq9MRTyqEj33TNJm5KNqk_H8jP+Ud9J+q-C_A@mail.gmail.com>
Subject: Re: [bpf-next 2/2] selftests/bpf: add test cases for htab map
To:     Hou Tao <houtao1@huawei.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Yonghong Song <yhs@meta.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 16, 2022 at 6:45 PM Hou Tao <houtao1@huawei.com> wrote:
>
> Hi,
>
> On 12/16/2022 6:41 PM, Hou Tao wrote:
> > Hi,
> >
> > On 12/16/2022 12:10 PM, Yonghong Song wrote:
> >>
> >> On 12/14/22 2:38 AM, xiangxia.m.yue@gmail.com wrote:
> >>> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> >>>
> >>> This testing show how to reproduce deadlock in special case.
> > Could you elaborate the commit message to show
> Sorry about that. Just hit the send button too soon. It would be better if you
> can describe the steps to reproduce the deadlock problem in commit message.
Ok, I will update commit message v2.
> .
>


-- 
Best regards, Tonghao

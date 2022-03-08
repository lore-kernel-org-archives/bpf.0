Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1323AC433F5
	for <bpf@archiver.kernel.org>; Tue,  8 Mar 2022 20:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239597AbiCHUYR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 8 Mar 2022 15:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237865AbiCHUYQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Mar 2022 15:24:16 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254A035251
        for <bpf@vger.kernel.org>; Tue,  8 Mar 2022 12:23:19 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id g17so67887lfh.2
        for <bpf@vger.kernel.org>; Tue, 08 Mar 2022 12:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rqOGo3ciopJ2oI0stTQvJF7Ig8aUa+V4++K4k3Vwshc=;
        b=V0tN9vBJi/q3izz1+UuYGTuWV2/NUOfOSRFTYOtoBRMzHrqZFW3G2e+cE/3fV1EOTR
         m20NLxOSluUr2ZfwM5hwImJYeUTH3VRr63u4TkYE2dQobSEO7GpHqVkwOEvhzKZacY6s
         /LNQCWMRE6ZQUL1MeYLInp8ADxGwTU/pO1ppzhiOvE7blkKNbHhJRhkrc24PKxoPLKqL
         PQzM2Mi+I3+wZajCNJa392e0Q/SZ5vaf9eXEbYGOBHxmAsvXIC7fehghC+lvTbuyilIy
         RumICqvAMtdB2ScAEwLEqtlTS3AYi8ZUMmW3sHyUibaJ5k5lyQSDUvc8zSRqbOI1SWLm
         p97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rqOGo3ciopJ2oI0stTQvJF7Ig8aUa+V4++K4k3Vwshc=;
        b=RjDVjh+Dr5g7MHaledOUxdzptZEWkNT0YgZe4A1N07I9Cc4ANflPezAGB2lsdG0k0E
         ET+fz/UmZb3Erzt7jAfT7XdoG401EdTwr/PxBEm+hGGwu7devTfF0RwhTE43g3cT4ier
         hPKAxIL1DaRv43qda9C1B+vddh7KJtea7b7PUSll9FkRRJxlJ1qz3GAStzTO2oV0TS37
         GC/pYLGHs/SV8+pAkjmjhkJnfvHyiaNPbATkjkhJiFdcym3Han34sV8YYzWif/OaNtgX
         DPILlnj4/izg//1/LbOz5MKhFo/WJSQKIEMC4p2zUG1opnl9oy1lmarN89XnFRpwKmyR
         93zQ==
X-Gm-Message-State: AOAM5331AEHj4v6JyG9V/8Jr1qKcH0KOFzFp6qiLtfOaYEZ+MVp/MKC0
        Aux8aW8Emnt4MQeuhvA3xBYOY++/+aNK4cin0Ec=
X-Google-Smtp-Source: ABdhPJySH0pYBnJWahKi6ab6ggug1cNXHsYB2gb/O6w83Q3qx4POo77ku+aqTE30kG78tcSIKgM2w9Nx5mzz3siba4I=
X-Received: by 2002:a05:6512:3242:b0:448:4a8f:6ae1 with SMTP id
 c2-20020a056512324200b004484a8f6ae1mr1636258lfr.665.1646770997188; Tue, 08
 Mar 2022 12:23:17 -0800 (PST)
MIME-Version: 1.0
References: <20211006185619.364369-1-fallentree@fb.com> <20211006185619.364369-6-fallentree@fb.com>
 <CAEf4BzaWi5FQsES5C72T6FgPbEdxqAfQGTArovY_d2KS_w6-=Q@mail.gmail.com> <CAJygYd2hwcKKZsfXa3eM_jT9WmcpUnmNzmkH1eMBU0MZwg=9NA@mail.gmail.com>
In-Reply-To: <CAJygYd2hwcKKZsfXa3eM_jT9WmcpUnmNzmkH1eMBU0MZwg=9NA@mail.gmail.com>
From:   "sunyucong@gmail.com" <sunyucong@gmail.com>
Date:   Tue, 8 Mar 2022 12:22:51 -0800
Message-ID: <CAJygYd37E0bSfXF_v88W4gmKfozNoFPmif6HEre7BYW4bq1gfw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 05/14] selftests/bpf: adding
 read_perf_max_sample_freq() helper
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yucong Sun <fallentree@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

the patch can still be found here  :
https://www.spinics.net/lists/bpf/msg47375.html

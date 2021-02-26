Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526B4C433DB
	for <bpf@archiver.kernel.org>; Fri, 26 Feb 2021 01:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20B3464EFA
	for <bpf@archiver.kernel.org>; Fri, 26 Feb 2021 01:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhBZB6J (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Feb 2021 20:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhBZB6H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Feb 2021 20:58:07 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CCEC061574
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 17:57:25 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id d5so6760558iln.6
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 17:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=6Ux10ihQPCqre/Nqgm87gc5BcZSiVqaIVtbeRrA89jw=;
        b=Z927EOOpS4Ww4athzNWk+q9otY7rcIKM5aKIzOv5IlKT36NJ9l2SE7zVaclVPTQB2M
         W/3pE8vk+L6nfDiW5HxMQ/k3Uis97/ZBEa/uSUpWRZ5RpkW52l9rpuZdJdt6SnHIj7uH
         /jXtCjIcTSLCdG2I+c9Sly2mLR+uXEqNwUSPtBq+MIdvAeOCX4epDs/n9SFRaIWZvjD4
         gteHITfeobBE04KIQjMcY59uVoA369+V8Orfg8MW9GyjT3s7JwxHi7lqYvssrDdJDWTZ
         frvHtPnrX7mMehuHydT5ufcwzccrn+gASWDqiOLqSArgoe6ywXg+nFyIENyhO0r8MGPM
         IWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=6Ux10ihQPCqre/Nqgm87gc5BcZSiVqaIVtbeRrA89jw=;
        b=TY/ih1wVAUVBJiuFhHbAFL0+FzGxZPj7BXGJdC2xUWyyBCftbVsjkJsuTI3jZWn0FF
         jZePk2n6OOHtOuMr+24p1U4+R+0lyi1K7rOeB57g4BeMLIf3IePctjBlZRMM1DCyyHb0
         ul5XxT/0rVACpPR40cUJ4PiZmaqtst6LsnGieuBcl8meTbCMkaNY4SmIyfo3rm7knbE4
         0yi5HSs2T/MXOUcMQO9VgXUoMDawA0vPFd7EaeQnVMeiz2IANKkVj74kAGtLPlyDuCsb
         11IXRvtMyFvMY1E056zGqVrhMDsFv3hgV5j+MASpUJ+fkcHAtzU3Zr4FoPMEVpKsVBmh
         GRxA==
X-Gm-Message-State: AOAM531BEM7yUhEdA/PWYxCmi5E45rRyar65doQRm4lqQzu0ab9OGbpw
        InCPl/g81ZBs5tkdRpk6gqE=
X-Google-Smtp-Source: ABdhPJz67TCW6W6V22IQuOHssUmCWlulI2S2etAJ3pKVlSfR5BEgrYG84HoQSTm/LcB26hyRSOyx8w==
X-Received: by 2002:a92:4a07:: with SMTP id m7mr492488ilf.51.1614304645030;
        Thu, 25 Feb 2021 17:57:25 -0800 (PST)
Received: from localhost ([172.243.146.206])
        by smtp.gmail.com with ESMTPSA id g3sm3602885ile.10.2021.02.25.17.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 17:57:24 -0800 (PST)
Date:   Thu, 25 Feb 2021 17:57:16 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <6038557c991ad_5c312087e@john-XPS-13-9370.notmuch>
In-Reply-To: <20210224234535.106970-4-iii@linux.ibm.com>
References: <20210224234535.106970-1-iii@linux.ibm.com>
 <20210224234535.106970-4-iii@linux.ibm.com>
Subject: RE: [PATCH v6 bpf-next 3/9] libbpf: Add BTF_KIND_FLOAT support
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ilya Leoshkevich wrote:
> The logic follows that of BTF_KIND_INT most of the time. Sanitization
> replaces BTF_KIND_FLOATs with equally-sized empty BTF_KIND_STRUCTs on
> older kernels, for example, the following:
> 
>     [4] FLOAT 'float' size=4
> 
> becomes the following:
> 
>     [4] STRUCT '(anon)' size=4 vlen=0
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> ---

If you do another rev it might be nice to note that with latest
llvm, latest libbpf, and this patch that older kernels (that were
failing with the float errors) will now start working correctly. I
assume for the this case the sanitize logic will just fix up the BTF
and everything will work as expected for the most part.

.John

Return-Path: <SRS0=4Daw=T4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F65BC072B1
	for <bpf@archiver.kernel.org>; Tue, 28 May 2019 08:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA36208C3
	for <bpf@archiver.kernel.org>; Tue, 28 May 2019 08:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="OyftP4zJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfE1IZI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 28 May 2019 04:25:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37587 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfE1IZI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 May 2019 04:25:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id 7so1786432wmo.2
        for <bpf@vger.kernel.org>; Tue, 28 May 2019 01:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=OXLAySmmEuRQc6rBVY3uAU8iwA38+cdB/7jMvXY9crc=;
        b=OyftP4zJNXJJJwFNCZ493Y1eA0Q+WLf2EK/YTRi7yFRlG4lglteL241ZXQh1njxTAH
         Qi1Su5WowIQ1xArmDuwgnoRFJkj5UD8mxLSlXyuOILoetvKJnpcQ8+RhZ/alqEQo85NR
         WRs+CHeIqXz8Ln+ucLym653kZv+zxJknYql/qY4TI+NtlrmK64ZOCIwrbFL/aU8FDcal
         fDBeLv8JDk2CqYX2FZmovi8+XYEU33SFPFmFseQaqzItRYzC5Mwnv6IDfeodLWmU6+2x
         Yva+5VnOFh65ccrdcbrZJGqTQF/+ZIBerd/hO/xuiJNasvzjY2Gw68EtvRuPpbKYIOkS
         VWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OXLAySmmEuRQc6rBVY3uAU8iwA38+cdB/7jMvXY9crc=;
        b=drOFqnCTDW696sT6aKucRu/smHA/UnQI7xvKkP3QVlnyLklYjkGfCLDm36vh7TB5mv
         fSi2QtJs03E8dZbfWWGdLic4k2oQC0MnSPzKrLJbvOKMXIsE+lhhnuajITk8QO+RdLg6
         MToVyBXfrOFIx/LjC4HTDHGXMwyxlUosrGgzz1erHL3Wz1P40HIJQ+MU9eQ463ngo1PR
         1r1/YrQYb++DVZPXa9KuJzcWk5gmXr6OoO+xm4m3s91crKV+kkrervdlKv0Y/fbnbxVg
         EMrpLLuATtONq2i7bqZKS/2e6Tn5tHfPev/+nmGPMLwEyNjv431096LN5SkPmBoyV7OR
         O4/Q==
X-Gm-Message-State: APjAAAVTpQg73g04kTr2PFuUxEiTYSq2Lf0fht/AQQBG6f3CsoiGq0gR
        Q29FlKpbpFErPB3vJFY7FUOiTg==
X-Google-Smtp-Source: APXvYqx4mue3/rXaZEAjR/1/x6k2pEzc0YsV/DfQrGV0bmOFgWftinFkQwlxlVl6nZHxwNdVJ71UQg==
X-Received: by 2002:a1c:448b:: with SMTP id r133mr2282485wma.114.1559031906462;
        Tue, 28 May 2019 01:25:06 -0700 (PDT)
Received: from [192.168.1.2] ([194.53.186.20])
        by smtp.gmail.com with ESMTPSA id k184sm4881771wmk.0.2019.05.28.01.25.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 01:25:05 -0700 (PDT)
Subject: Re: [PATCH bpf-next] bpftool: auto-complete BTF IDs for btf dump
To:     Andrii Nakryiko <andriin@fb.com>, andrii.nakryiko@gmail.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org, ast@fb.com,
        daniel@iogearbox.net, kernel-team@fb.com
References: <20190526000101.112077-1-andriin@fb.com>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Message-ID: <bcae60bd-d432-0fbe-749f-abe2dc742769@netronome.com>
Date:   Tue, 28 May 2019 09:25:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190526000101.112077-1-andriin@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2019-05-25 17:01 UTC-0700 ~ Andrii Nakryiko <andriin@fb.com>
> Auto-complete BTF IDs for `btf dump id` sub-command. List of possible BTF
> IDs is scavenged from loaded BPF programs that have associated BTFs, as
> there is currently no API in libbpf to fetch list of all BTFs in the
> system.
> 
> Suggested-by: Quentin Monnet <quentin.monnet@netronome.com>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>

Thanks!

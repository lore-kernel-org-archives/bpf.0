Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174DAC636D7
	for <bpf@archiver.kernel.org>; Thu, 16 Feb 2023 22:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBPW7i (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 16 Feb 2023 17:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBPW7h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 17:59:37 -0500
Received: from out-220.mta1.migadu.com (out-220.mta1.migadu.com [95.215.58.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15526593
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 14:59:35 -0800 (PST)
Message-ID: <68844823-bc3f-5523-c94f-e436515ee9fb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676588373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MqDk72dg8LXNgWz3wApmntIduo2gXzMT98C0pumpufg=;
        b=Gj2zKKzKF486qnL9JPTqEMU47kN6KLSe97iZoTqwvRlzvXR2V5B1T0/yJDXxH2gfY9SQDd
        oyyINn0GABoI2hitVbsDv+Io6IKSGCnFxbkS/YxXELyEhjUxlL94wDitLE5JMFgaSjIejC
        0uMdIoXXQ9swJXjep6PX6AaCOHlGHEw=
Date:   Thu, 16 Feb 2023 14:59:30 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 4/7] libbpf: Create a bpf_link in
 bpf_map__attach_struct_ops().
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org
References: <20230214221718.503964-1-kuifeng@meta.com>
 <20230214221718.503964-5-kuifeng@meta.com>
 <CAEf4BzZ8k04R4Y0FY2k6KoSPZdiYRJxcnA1qypi=Hk-JM8ppWw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAEf4BzZ8k04R4Y0FY2k6KoSPZdiYRJxcnA1qypi=Hk-JM8ppWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/16/23 2:40 PM, Andrii Nakryiko wrote:
> So this will always require a programmatic bpf_map__set_map_flags()
> call, there is currently no declarative way to do this, right?
> 
> Is there any way to avoid this BPF_F_LINK flag approach? How bad would
> it be if kernel just always created bpf_link-backed struct_ops?

It still needs to support the per-link behavior.

> Alternatively, should we think about SEC(".struct_ops.link") or
> something like that to instruct libbpf to add this BPF_F_LINK flag
> automatically?

I like this idea. Easier for users that is always link only. The users can also 
stay with SEC(".struct_ops") and decide later if BPF_F_LINK should be set 
depending on the runtime config and environment like kernel version...etc.

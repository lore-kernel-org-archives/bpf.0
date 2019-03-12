Return-Path: <SRS0=5gB9=RP=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0D8C43381
	for <bpf@archiver.kernel.org>; Tue, 12 Mar 2019 05:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A82214D8
	for <bpf@archiver.kernel.org>; Tue, 12 Mar 2019 05:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIiPZnQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbfCLFuB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 12 Mar 2019 01:50:01 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37970 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfCLFuB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Mar 2019 01:50:01 -0400
Received: by mail-io1-f67.google.com with SMTP id p18so1027433ioh.5;
        Mon, 11 Mar 2019 22:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8B63wN0RI7xq444XEQPkHffs7bAqRsYHtGgLo00xo38=;
        b=GIiPZnQup0KP61JNEegr8nFtk/TKU5fXyZwJjQIU9dxxyZsP2OHpHKXdLSK0UtAzXA
         WbkIepA2o+OdA8ymihlAEI9EuECu2JdpUEKM17c2oVd2pAWW2DmBJsLyK5tU8LnCQJlI
         44veubzQIS2FwVMohuY/astcchS5pJiASzLonvuMx/YDCIhJOzRv09PiTKWBWiUcvzvc
         fdrMuFK8+bSow0Ov9EhyiDTI0ghohUrb3tE8OkyQFSZ+scwOJrlM9Uap+ne2Rs0u31H9
         V+YEvgYbnQEvHRMT8IvFa35qAfHq781Hjrsh0yB2QWROfI6Cam+OXqcq4/ytwEj4kVQI
         yWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8B63wN0RI7xq444XEQPkHffs7bAqRsYHtGgLo00xo38=;
        b=Kmg2OdF9ufxVgZx2V1j3V2OcjMoca36HnIO1wNosmSq3EebI6hHEADwvz37v08oH9j
         vt4bV0wAe+M/v0yG5GPK+gJCGK0sqSoIAa8oWBrAHlEjgfHoj1sYxIhvFvvXdWHYj8Y5
         ZexFBwACNJQE2H87pGBxHYtHLHRKvbOJjLJJqBrgedHPEtlO5WtI9Egfch0KKLcpiUCV
         ZjlEipHudKq1gDupgjIr3dSa57lv16/GRyDyL8SyO7X12+Lbe7n3AedkWkEekYuUl/jt
         zkZ2R7B9d9aKbPaqeHzlzTusQLQMJbPclo2WJ1+aLkPIjqyuIAN4Bhs24s/cWdLVzqp6
         O2mQ==
X-Gm-Message-State: APjAAAVbCnGmspon53GYf2UZ4wUQNwBZwj9VQM90gkr8jmOLyRlogZ45
        svQ4y/EwL9jQq0NQU8bK7gd0BfOumKBaqMHyGC8=
X-Google-Smtp-Source: APXvYqwrumJLRKzXJDnBgdbyYyFXDRxwvk5LOLw7+bNgK4XNU5SbaPdO5c2oATcku95tYFGs0M6zLgsN8fxbpDNWmgA=
X-Received: by 2002:a5d:8784:: with SMTP id f4mr18268747ion.89.1552369800513;
 Mon, 11 Mar 2019 22:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190311193112.25527-1-m@lambda.lt>
In-Reply-To: <20190311193112.25527-1-m@lambda.lt>
From:   Y Song <ys114321@gmail.com>
Date:   Mon, 11 Mar 2019 22:49:24 -0700
Message-ID: <CAH3MdRXOtAhsLAE-9=JpSE=5b2mGjRmQaTnMdUmNv8S50FQa2w@mail.gmail.com>
Subject: Re: [PATCH] bpf: Try harder when allocating memory for large maps
To:     Martynas Pumputis <m@lambda.lt>
Cc:     netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, mhocko@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 11, 2019 at 12:32 PM Martynas Pumputis <m@lambda.lt> wrote:
>
> It has been observed that sometimes a higher order memory allocation
> for BPF maps fails when there is no obvious memory pressure in a system.
>
> E.g. the map (BPF_MAP_TYPE_LRU_HASH, key=38, value=56, max_elems=524288)
> could not be created due to vmalloc unable to allocate 75497472B,
> when the system's memory consumption (in MB) was the following:
>
>     Total: 3942 Used: 837 (21.24%) Free: 138 Buffers: 239 Cached: 2727
>
> Later analysis [1] by Michal Hocko showed that the vmalloc was not trying
> to reclaim memory from the page cache and was failing prematurely due to
> __GFP_NORETRY.
>
> Considering dcda9b0471 ("mm, tree wide: replace __GFP_REPEAT by
> __GFP_RETRY_MAYFAIL with more useful semantic") and [1], we can replace
> __GFP_NORETRY with __GFP_RETRY_MAYFAIL, as it won't invoke OOM killer
> and will try harder to fulfil allocation requests.
>
> The change has been tested with the workloads mentioned above and by
> observing oom_kill value from /proc/vmstat.
>
> [1]: https://lore.kernel.org/bpf/20190310071318.GW5232@dhcp22.suse.cz/
>
> Signed-off-by: Martynas Pumputis <m@lambda.lt>
Acked-by: Yonghong Song <yhs@fb.com>

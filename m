Return-Path: <SRS0=+tT9=35=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60E4C2BA83
	for <bpf@archiver.kernel.org>; Sun,  9 Feb 2020 17:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA9D20715
	for <bpf@archiver.kernel.org>; Sun,  9 Feb 2020 17:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sFUKdPO9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbgBIRSa (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 9 Feb 2020 12:18:30 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39515 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbgBIRSa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 9 Feb 2020 12:18:30 -0500
Received: by mail-lj1-f193.google.com with SMTP id o15so4461490ljg.6
        for <bpf@vger.kernel.org>; Sun, 09 Feb 2020 09:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iX/Cwymqqdc137iwGo9GrIAl1+HtFCOAKUHk7azo7/w=;
        b=sFUKdPO93vKYZEw/Ug0TorBuaULTB+Uw596VwGq84N61fjEmKVVtqeA1xgrFozmuU2
         t4Hr906mncO3lEM4knNauRFkz7lxi9OkRW8vMUA4xKmPmMqg8PIDYE8orwi/XEA5P0pz
         D70H67FMgivq0pq5Ra9CyBfYUfA4+HgOx8L1xi34ipbW+pkORxq4FAx6XUj4YwPmnfb5
         oDm4Fm8O9SmqRSwPTzoQQaYEMA3heSsqggV3Nnu63ZDv/SoBa13svFvS8d1MflbOg4ix
         5ff4rLLjpD3YlA5SkDC2t1QNgDcP3yNuOu3K8nq47bF2tsUKf6Il/Dka4R0t3M9kPHKd
         zRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iX/Cwymqqdc137iwGo9GrIAl1+HtFCOAKUHk7azo7/w=;
        b=tU6Kjc6JSSDIXyoESXPShelOX74sBRw3wvXAGoF+28y9/vpq+MPAmsC0i4jlH3aubp
         71cfQHypxtKD1Z1tHGhoXM1GRFE3vEsEfdrjkAVmC1hg3g3+MzU0c51vkbfCWCMiUb3Q
         fJwsI5e27p5h+QlcpcP4aZEFcWVAZsOW/uuhN7Z7svBnDJb5gGQnzmuaBo9u78Ef5/Eu
         cuWhGp+6o6TNIatWDnxphJoaHG+GCoYJuIQGNEAtDqaqm2Md6unJTdRpn8XbxmFMwbkn
         KzzACjUHVHdfU4S+DDCUs6R8/mDT+W5pTewMNCHQbx4RsjEEwCxyEIZ0/JOoyXLwuQmR
         V1lA==
X-Gm-Message-State: APjAAAXqZ39Dg3uea+TDaYqv8z8HLtbL9RWG4rQr2LWFaWtedVgrB7Ve
        ZqMm1kU1zZU8wEwmNmMcSC7T+11C6CeVhhKtUYzO9g==
X-Google-Smtp-Source: APXvYqyERfzIRnh/UXfObLOmFk7HYzVxiDdS8MmtBaFvyP0yHM3y5rLzZkIaO0+sLLsBQtyMm6TQpLy5ZjyByBduyOA=
X-Received: by 2002:a05:651c:414:: with SMTP id 20mr5307683lja.165.1581268708042;
 Sun, 09 Feb 2020 09:18:28 -0800 (PST)
MIME-Version: 1.0
References: <20191212013521.1689228-1-andriin@fb.com>
In-Reply-To: <20191212013521.1689228-1-andriin@fb.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sun, 9 Feb 2020 22:48:16 +0530
Message-ID: <CA+G9fYtAQGwf=OoEvHwbJpitcfhpfhy-ar+6FRrWC_-ti7sUTg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] Fix perf_buffer creation on systems with
 offline CPUs
To:     Andrii Nakryiko <andriin@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
        ast@fb.com, Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kernel Team <kernel-team@fb.com>,
        linux- stable <stable@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Leo Yan <leo.yan@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 12 Dec 2019 at 07:05, Andrii Nakryiko <andriin@fb.com> wrote:
>
> This patch set fixes perf_buffer__new() behavior on systems which have some of
> the CPUs offline/missing (due to difference between "possible" and "online"
> sets). perf_buffer will create per-CPU buffer and open/attach to corresponding
> perf_event only on CPUs present and online at the moment of perf_buffer
> creation. Without this logic, perf_buffer creation has no chances of
> succeeding on such systems, preventing valid and correct BPF applications from
> starting.
>
> Andrii Nakryiko (4):
>   libbpf: extract and generalize CPU mask parsing logic
>   selftests/bpf: add CPU mask parsing tests
>   libbpf: don't attach perf_buffer to offline/missing CPUs

perf build failed on stable-rc 5.5 branch.

libbpf.c: In function '__perf_buffer__new':
libbpf.c:6159:8: error: implicit declaration of function
'parse_cpu_mask_file'; did you mean 'parse_uint_from_file'?
[-Werror=implicit-function-declaration]
  err = parse_cpu_mask_file(online_cpus_file, &online, &n);
        ^~~~~~~~~~~~~~~~~~~
        parse_uint_from_file
libbpf.c:6159:8: error: nested extern declaration of
'parse_cpu_mask_file' [-Werror=nested-externs]

build log,
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-stable-rc-5.5/DISTRO=lkft,MACHINE=hikey,label=docker-lkft/11/console

-- 
Linaro LKFT
https://lkft.linaro.org

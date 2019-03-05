Return-Path: <SRS0=GR7L=RI=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E107C00319
	for <bpf@archiver.kernel.org>; Tue,  5 Mar 2019 14:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B192087C
	for <bpf@archiver.kernel.org>; Tue,  5 Mar 2019 14:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="tQFDoD/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfCEOMb (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 5 Mar 2019 09:12:31 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43584 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbfCEOMa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Mar 2019 09:12:30 -0500
Received: by mail-lf1-f65.google.com with SMTP id p73so5680512lfe.10
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2019 06:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=v7d/KTQk92weffa0xtXMnzMMsBqZm1l6isfdvZ3/Rq4=;
        b=tQFDoD/uWM2HOEC+ID4BJDruyHqShyvVxH50awVEZ97QELPGIWSrPZzQEvaItbWj5t
         gUD7z3aaT5fCqm9H9v6G+A+luGUYXWKN+Wwv5sdatbN3LcPVHpkN/hVEvOpOZPRZSApU
         DC5vBdir2BzaizZ1Auo0s0W4d3fpu8I82wONQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=v7d/KTQk92weffa0xtXMnzMMsBqZm1l6isfdvZ3/Rq4=;
        b=d9X4aG5GcvA5xCQJUqXf9WfXZ6HbT37Chp6MMCZJK9Vp+21PIU4bDhWJqPVxil4DoD
         jVWB1r92vAXTgr9VJtiec2OawBMHS3tWbFV4mMxM3exjIzgyq1ODmC2Pj38QjckPW81o
         I5u5AUA1YZBgSNb9opYis3CAEDQZ10NVKx/BVTlN89/0UkDiPYOOHMtRxxq9Q7xhbldV
         ub+3yJGb28MJYZYuR9zWeXW+tSOsZy0vSGLlRBj8R6bmfJkX7xAyCSlnYn9ZIphAeG0u
         jgTM57rpm8DVTgLrBZk3s/f5SW9wtbphDilXELlOFUi3ufb2n71eRFBzRxRh07Dr2BBE
         PGAw==
X-Gm-Message-State: APjAAAX+TqDLOY0yzCZqIoBxgnwT5CmLqH8mQKGHKXbnxeYY2T+5ME/B
        bH+39fRxLi/cCoL+PJRtkfHtNQ==
X-Google-Smtp-Source: APXvYqwwEFbz4x+xKIUWbeTMwOP8DWWP8krE27mINigDCGiMKbfGbEWDDlgSkbI6ia8xGJZXX/6jYw==
X-Received: by 2002:ac2:5230:: with SMTP id i16mr896827lfl.119.1551795148477;
        Tue, 05 Mar 2019 06:12:28 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id y12sm2132454lfh.32.2019.03.05.06.12.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 06:12:27 -0800 (PST)
References: <20190301210529.8218-1-daniel@iogearbox.net>
User-agent: mu4e 1.1.0; emacs 26.1
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     ast@fb.com, afabre@cloudflare.com, marek@cloudflare.com,
        bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: fix sanitation rewrite in case of non-pointers
In-reply-to: <20190301210529.8218-1-daniel@iogearbox.net>
Date:   Tue, 05 Mar 2019 15:12:27 +0100
Message-ID: <87lg1tz9ys.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 01, 2019 at 10:05 PM CET, Daniel Borkmann wrote:
> Marek reported that he saw an issue with the below snippet in that
> timing measurements where off when loaded as unpriv while results
> were reasonable when loaded as privileged:
>
>     [...]
>     uint64_t a = bpf_ktime_get_ns();
>     uint64_t b = bpf_ktime_get_ns();
>     uint64_t delta = b - a;
>     if ((int64_t)delta > 0) {
>     [...]
>
> Turns out there is a bug where a corner case is missing in the fix
> d3bd7413e0ca ("bpf: fix sanitation of alu op with pointer / scalar
> type from different paths"), namely fixup_bpf_calls() only checks
> whether aux has a non-zero alu_state, but it also needs to test for
> the case of BPF_ALU_NON_POINTER since in both occasions we need to
> skip the masking rewrite (as there is nothing to mask).
>
> Fixes: d3bd7413e0ca ("bpf: fix sanitation of alu op with pointer / scalar type from different paths")
> Reported-by: Marek Majkowski <marek@cloudflare.com>
> Reported-by: Arthur Fabre <afabre@cloudflare.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Link: https://lore.kernel.org/netdev/CAJPywTJqP34cK20iLM5YmUMz9KXQOdu1-+BZrGMAGgLuBWz7fg@mail.gmail.com/T/
> ---

Could you please queue it for -stable which has d3bd7413e0ca ("bpf: fix
sanitation of alu op with pointer / scalar type from different paths")?

Thanks,
Jakub

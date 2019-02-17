Return-Path: <SRS0=ogH5=QY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BB6C43381
	for <bpf@archiver.kernel.org>; Sun, 17 Feb 2019 02:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF3921917
	for <bpf@archiver.kernel.org>; Sun, 17 Feb 2019 02:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6AlMG2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfBQCva (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 16 Feb 2019 21:51:30 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45164 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbfBQCva (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 16 Feb 2019 21:51:30 -0500
Received: by mail-pl1-f195.google.com with SMTP id r14so6960643pls.12;
        Sat, 16 Feb 2019 18:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3VtGmJ0QsdsplF0J3zYRt8S+tPSCsY5BFBc5TjcPFs8=;
        b=I6AlMG2Jh7JiMNS0rrgBJvHUo84rIvm6d/oDiKQFcN1Ma6MLZnLCpulJYA09+trgvh
         KxtlHry0BFqM2oqHGII3zA7Au5cwcBeTu3MSmERFBT3CjSbXeB/ADn1lCkJvYVGOBGax
         ODqrQ/v6PE2sUGFGDooKFk39HIS4v1sdIjbZWSI5LtPMU+Ir1YTMj4xVy8sgSMTwzXi3
         7Pas5j2SDP3R6gVgRrP53ghCR63ENii63CAmHSz8pfTLNb2nEILhRjLrUqe8Pr/OpMZ9
         qe/bUa5czeAvio89VwkWHUzHMGp3Xl9XmZ/P5INyrcwUfk6T6v9e08nUyAc9l9BMhk/8
         dYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3VtGmJ0QsdsplF0J3zYRt8S+tPSCsY5BFBc5TjcPFs8=;
        b=hxiQbG+9tdf2MPei823bm4suntOZOeRvMkFIweubFNsAWiR1UxT5ZOGEnI/zJ6P+lT
         XIcJx/eXN7mkbbHrLmPma9bOOSRU5uM8P+bvIX3wThWgD/cX4mEL+L0gpCvXx1Ba7f/0
         mYDa4jD+Xo+bwQEUKnjN5eyHx8zHz9wMB7n1wM6X2sUyZc8b/+jmQs3pqjY2KZp29kW2
         7YfVx0CdrCjMQ3+i3OgAaGSrS0KOLQ36e0uCPWKAsvsb+wSZbeGbDGN1mSD0c/FWHJQg
         02TC/C8NDrJwBZRf/+nH/uWANvSCt6ITrRqBd3NheNfk+h0iukdcIOEwnU7T4heIqWwA
         Hycg==
X-Gm-Message-State: AHQUAuaoxlKg3jt+zXcqycPcCixpV0l5dbZSMUeyZFipr3ZLLzJV07fP
        gKflIAjQ7uxydAyWH7jvMiU=
X-Google-Smtp-Source: AHgI3IYQ+3WojB2TTMkL2ITU9q2s0oOB3rKVIKsxhz905/WCP2lFihEATZ/7WgJ5LYe0zKAI3Gg4aA==
X-Received: by 2002:a17:902:822:: with SMTP id 31mr16330180plk.290.1550371889478;
        Sat, 16 Feb 2019 18:51:29 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:1af4])
        by smtp.gmail.com with ESMTPSA id k3sm7797043pfi.129.2019.02.16.18.51.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 18:51:28 -0800 (PST)
Date:   Sat, 16 Feb 2019 18:51:26 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     andrii.nakryiko@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com, yhs@fb.com, ast@fb.com,
        kafai@fb.com, daniel@iogearbox.net, acme@kernel.org
Subject: Re: [PATCH bpf-next] tools/libbpf: support bigger BTF data sizes
Message-ID: <20190217025125.knxolelmokjxh543@ast-mbp.dhcp.thefacebook.com>
References: <20190216035218.342185-1-andriin@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190216035218.342185-1-andriin@fb.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 15, 2019 at 07:52:18PM -0800, Andrii Nakryiko wrote:
> While it's understandable why kernel limits number of BTF types to 65535
> and size of string section to 64KB, in libbpf as user-space library it's
> too restrictive. E.g., pahole converting DWARF to BTF type information
> for Linux kernel generates more than 3 million BTF types and more than
> 3MB of strings, before deduplication. So to allow btf__dedup() to do its
> work, we need to be able to load bigger BTF sections using btf__new().
> 
> Singed-off-by: Andrii Nakryiko <andriin@fb.com>

Applied, Thanks


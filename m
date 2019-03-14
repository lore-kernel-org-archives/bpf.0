Return-Path: <SRS0=VVzb=RR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E38C43381
	for <bpf@archiver.kernel.org>; Thu, 14 Mar 2019 21:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93EC12087C
	for <bpf@archiver.kernel.org>; Thu, 14 Mar 2019 21:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2GR6fZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfCNVBR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 14 Mar 2019 17:01:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41166 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbfCNVBR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Mar 2019 17:01:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id k11so4804698pgb.8;
        Thu, 14 Mar 2019 14:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dbgARtiVkGF0C9uxSjXAxjBxoDrb+XB+zYws39penP4=;
        b=q2GR6fZsHP7RCMIr3YnP2PR2HViotwTkof1Dbkx8d89v2Ii1gyOH5STaiVKKr5n7X6
         FI+7+EWg/5Knzr5j65p5CW11XTPcLjB0rPZyIxqz5C4S2KQdvhqg2sRAuMjZHeosUSH/
         tgW6YwfBLl1q+hqiNYjiMKj5KFSzsKZgBqBy5czQ7iRP4jqwC28ujIjmONDNrQ2moUNQ
         LyJFVZZw8P8D3FQLfIJJlsGmB5FQMyvan7B0kF7yzaJvX+ms8atmjR3eTWFXpPIkFssi
         wGwX7hvBkZMHPSa9h9JAxaHkeSqNl7FSLhB+chGmDGCtT/nfmJMt6SXUXyJjMUUYOdm9
         l8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dbgARtiVkGF0C9uxSjXAxjBxoDrb+XB+zYws39penP4=;
        b=tRF9gjmbVU7+3Vwyrv3CoRmNflulKmgNRtHgWH3G8kR+PbdtYRHtQmX4BgrwSBY6Jh
         6htcAuC5q552GjgWgX4MDsleYVUatKB3q+UWIataiw/HiaY+lQ0sqj2+QYuZPGfntPWY
         ZZMW6Fdmt5WKIgLAbNGN9Ng6uezkcRljfoy3VUMWGQ1SSBLdwZz/rbcMoRJcKEN/9ux3
         WfT3G11SiSKBKxfwckI8eYHhbRRTsTajjc+f9G0FOr20DfAzbgbpVl4g3g2dOdgR38G9
         ibiCmR6Xl+FT/4k/9GrgkShzjxnfi1+4mUCyxm7+fvNDi/c6ZAHHAimYo+mj5Pxiwv6h
         qZxQ==
X-Gm-Message-State: APjAAAXXp4F+8BLQahF1+MD2pODcu18TKmXvjLOkppdOOy5vY24RCrnP
        bGttafzwcDBTyvuMfPD1ID5U2qwo
X-Google-Smtp-Source: APXvYqwmaLOO7DB5Ud3j27QpVvwwD69lDH5K5+x/gOyDhUf7Lb/P+hSbjyWg9b7MCFeMvQ7J0BrCKQ==
X-Received: by 2002:a62:7042:: with SMTP id l63mr270136pfc.1.1552597276226;
        Thu, 14 Mar 2019 14:01:16 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:200::2:b1ed])
        by smtp.gmail.com with ESMTPSA id h184sm4155pfc.78.2019.03.14.14.01.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 14:01:15 -0700 (PDT)
Date:   Thu, 14 Mar 2019 14:01:13 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Edward Cree <ecree@solarflare.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Kernel Team <Kernel-team@fb.com>,
        Alexei Starovoitov <ast@fb.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 1/2] btf: resolve enum fwds in btf_dedup
Message-ID: <20190314210111.lveoorx7wfhq3cxa@ast-mbp>
References: <20190311004410.3896503-1-andriin@fb.com>
 <20190311004410.3896503-2-andriin@fb.com>
 <755d4871-f8a1-ec31-02bf-87ffe82cdd56@fb.com>
 <CAEf4Bzbo1_mCN4wnGV+G8ombYPmSBNMQG7Qy8729Ji7HaKxV3Q@mail.gmail.com>
 <4e224736-5174-17e5-f388-6c34276c0c24@solarflare.com>
 <CAEf4BzZCotM8s+o9Aav_j2Yn3AJ2zvNcFtz=cE3GDWQUp9o9Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZCotM8s+o9Aav_j2Yn3AJ2zvNcFtz=cE3GDWQUp9o9Rw@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 11, 2019 at 10:39:37AM -0700, Andrii Nakryiko wrote:
> 
> There is a GCC extension that allows to forward-declare enums:
> https://gcc.gnu.org/onlinedocs/gcc/Incomplete-Enums.html#Incomplete-Enums
> 
> Kernel actually has examples of using this (see patch description
> regrading irqchip_irq_state).

we've considered several different ways of either extending or changing BTF api
to accommodate this unforeseen C langauge extension.
All of them require patches for the kernel 5.1 and 5.0 and/or llvm,
so we've decided to proceed with the existing kernel code and llvm
and only tweak btf dedup logic the way this patch does.

I've applied this set to bpf tree.


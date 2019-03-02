Return-Path: <SRS0=p5ic=RF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801D4C43381
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 05:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439BA20836
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 05:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzGSaD+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfCBFaH (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 2 Mar 2019 00:30:07 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33624 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfCBFaH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 2 Mar 2019 00:30:07 -0500
Received: by mail-pl1-f196.google.com with SMTP id y10so12514396plp.0;
        Fri, 01 Mar 2019 21:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jUx7MO2IUjEx7atcPrcvhzgNngxgyBsYrZbLwC1Mjkg=;
        b=lzGSaD+Lr7SvaO64laITXI/HsSBQJQ/qFbgRsfxOOBQKv0Wf//peo9yOhuo6SQDK5y
         SyxIU4VZjqZCpcoffWLf7W3xoKlbQez/YslhiUXNSVCXLH5OVcO+XM/DZZ4qXkmzkViT
         YAbwGQghjsjlruztgAw+iTyFS0pMjcmGxFuSqUzWIP1QjzFDelv73U+c1ioGBqEs6OsF
         0P4vMYEyWw9MxxUZNrad18mQKDKvsMDP82wiGiHfDK74n0DhaGmaVQqezR/jg5Dgmgcq
         YyETnRNo1j9UHuBJGHoEzRQ6vDWK4kPRxKjaXi5zC/gYetk4HBW6vLRnWMCanWUrAB+U
         a7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jUx7MO2IUjEx7atcPrcvhzgNngxgyBsYrZbLwC1Mjkg=;
        b=DoG9IpSE2NzrGA+1ZPHv+VYosmLjVTRfRBSKWcwUEE9Z1Rie7FanYceHqTgKblaG1M
         e29cpATH4rsaR8dlwe2bOZre/K0BMLIOxx0MdZS8Ca0QQ6nQWL2y4cBpN3oavpYWdksl
         jqByeGFaeTElrBAlS2T6cpGKhJYZ3ZvA2ukd7G5PQ96WD1NGZJF/MfArK+C42+juunMQ
         cqWayRedD2nKEbXuG24RCw6pYHLhN3kgFaJezgReki/tF7Ot7QDphs8jvx7PJMHSHUKj
         A7GseJ0uUSBegDRHX6a4Tsdw9hd/lz34M5/1+XWsXZmIqdwfMclu7+S1w+jx6yMx6iCn
         aTsg==
X-Gm-Message-State: APjAAAWU/OlyCoVUYr5odwiMAYVo2+3jnIyYAkR+M/tqBlQegNx6+v1H
        eqvuF4PJMmsd45mn53UULM8=
X-Google-Smtp-Source: APXvYqw6ctd4C6PV0jSYP+xBQ/Kx15/QXkaU9YU9rsp0xqGY+YAHoAPbjqsjHzSSo+CHs7KpU0rUyA==
X-Received: by 2002:a17:902:778c:: with SMTP id o12mr9407121pll.112.1551504606238;
        Fri, 01 Mar 2019 21:30:06 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::d24c])
        by smtp.gmail.com with ESMTPSA id e131sm16597482pfc.62.2019.03.01.21.30.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 21:30:05 -0800 (PST)
Date:   Fri, 1 Mar 2019 21:30:03 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     ast@fb.com, afabre@cloudflare.com, marek@cloudflare.com,
        bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: fix sanitation rewrite in case of non-pointers
Message-ID: <20190302053001.4fhnluqubgt6vxfj@ast-mbp.dhcp.thefacebook.com>
References: <20190301210529.8218-1-daniel@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301210529.8218-1-daniel@iogearbox.net>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 01, 2019 at 10:05:29PM +0100, Daniel Borkmann wrote:
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

Applied, Thanks


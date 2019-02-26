Return-Path: <SRS0=L7vf=RB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF97C43381
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 06:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE31C2173C
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 06:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxNSohxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfBZGS2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:18:28 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:47078 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfBZGS2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Feb 2019 01:18:28 -0500
Received: by mail-pg1-f193.google.com with SMTP id 196so5679436pgf.13;
        Mon, 25 Feb 2019 22:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZlL1jZbIVel4hO4EO5q3Cpy0i+yOfXcwR1IwznnSvHo=;
        b=TxNSohxvBK4CnPkkR01Ieb3/pOO7uJL9XEDnX9WIteh8pM0mdudFt6ehk/HHJuMSy1
         ChaWni2SFzKw3fXx+OjGZSPXYn2kfL1oVFGtFPHXK+wT1reYyQspjUvCnMDfnTu0qhT6
         Xsu1SJ+9YGTe64VCG0JtdWF1aLOYYBxdAf9q7dMftPHsboCDLNotrZxFr3cg54bhC89v
         AYq9piCwkic/bZq+GXANK7yyYfmLZCfVvaZFJ5YyBKc/JEFruP1oCwGxt+jDWKKSKc3r
         7spuLRskJBperFLTE8Wlr/AIOQDLRwb6HgGWFnYsxyXX9hYYAVS2FNoduiAu3GkOZ4H3
         xXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZlL1jZbIVel4hO4EO5q3Cpy0i+yOfXcwR1IwznnSvHo=;
        b=Uma5L/uKupxeqTsss111rcJhlTHj4XE3+jyP8LcOvKzfZ9k3CmiI9nYuW5g3MKJTEF
         8arJVB4eIdYIvZn46gCFcPiabmPwsiTyQLYdvF/yq9M3MRgC9xCmy39OJUDZUG6pvBZm
         YzRt8PZdZeD6nbNfL88vm2uC84EF1T0CTNUG+8BS56yOg1ECtjeM20lAQSb6eOZ2hD8s
         zB+H88VL8dwKUvOlXLRYGw7J0rAQo/JNzCDuIVEZKDQ0IxMgyml/3uY67IZLjMXCBL6R
         4wx2z87hLjuRKjDDa8u5rMzyYrRbl13a0IVoeD+vvmrBXExNrtyQv9ZU/3NnMmlILEiN
         k7ZQ==
X-Gm-Message-State: AHQUAuZRXcPbeeZjGiWr8rBjnjuOxerugT38DbGAg33+o+IXIg5ZfShu
        6PQDEzmtBbo1QRkt/p1nlvc=
X-Google-Smtp-Source: AHgI3IbAoA60ppakcpdNKdu2dnVZ8L2J0ssf5YlYhoJfMLnG82j3oFlgzDrORh4DQPGxKfQ8DdIJ/w==
X-Received: by 2002:a63:2882:: with SMTP id o124mr23078569pgo.446.1551161907680;
        Mon, 25 Feb 2019 22:18:27 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:701d])
        by smtp.gmail.com with ESMTPSA id g3sm14824444pfo.125.2019.02.25.22.18.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 22:18:26 -0800 (PST)
Date:   Mon, 25 Feb 2019 22:18:25 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kris Van Hees <kris.van.hees@oracle.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH 0/2] bpf: context casting for tail call and gtrace prog
 type
Message-ID: <20190226061823.f7hfs7yojfuycqmg@ast-mbp.dhcp.thefacebook.com>
References: <201902251554.x1PFsD3w017626@userv0121.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201902251554.x1PFsD3w017626@userv0121.oracle.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 25, 2019 at 07:54:13AM -0800, Kris Van Hees wrote:
> 
> The goal is to further extend the BPF_PROG_TYPE_GTRACE implementation to
> support what tracers commonly need, and I am also looking at ways to further
> extend this model to allow more tracer-specific features as well without the
> need for adding a BPF program types for every tracer.

It seems by themselves the patches don't provide any new functionality,
but instead look like plumbing to call external code.
This is no-go.
There were several attempts to do so in the past, so we documented it here:
Documentation/bpf/bpf_design_QA.rst
Q: New functionality via kernel modules?
----------------------------------------
Q: Can BPF functionality such as new program or map types, new
helpers, etc be added out of kernel module code?

A: NO.

The answer is still the same.


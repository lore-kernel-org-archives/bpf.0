Return-Path: <SRS0=sv//=Q5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10869C43381
	for <bpf@archiver.kernel.org>; Fri, 22 Feb 2019 19:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3D1206C0
	for <bpf@archiver.kernel.org>; Fri, 22 Feb 2019 19:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="rdJTemqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfBVT1q (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:27:46 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:34744 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfBVT1q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Feb 2019 14:27:46 -0500
Received: by mail-pf1-f180.google.com with SMTP id u9so1551073pfn.1
        for <bpf@vger.kernel.org>; Fri, 22 Feb 2019 11:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=JLvUkFABOQ5zCKgClVsmgG5SiUV3k0oVK91zJzRfLhs=;
        b=rdJTemqGEezhT+19WFWhaixUiJAMb7LtyQ+VDnGVpoAm0mSeIbiNRcf/3ZvCi0egNa
         czioFrsSb1nSBIve2/3kONc3V1xDgdttIvjQfULZHirgXYGJ5chHZvXWAJuHV2h8H3AT
         0tsLEmRxTHK6cPNpE+tg4DyTQtKi66IQ6bsPCU2s5mZc+aqZjJGdV7RlbZiQ0bsj3DCp
         eGkTbN1FNQQ4khBXi812CSMGlVnvqQsu47VkGgkj1KWQ5msyoNQ4a9PMviO1NSfjxmOw
         dBdcjljjRUNE0XOVdY+RNWHfKTJEVSf5qvLA6BMuvS0i3ZOkLN3GSCvYwoSJGTpvZli1
         5teg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=JLvUkFABOQ5zCKgClVsmgG5SiUV3k0oVK91zJzRfLhs=;
        b=KFyfqHe6vA/VkwU6P7wU23lGiw8C9i1gPhT/kSxBYsAa0vYzl5MjMXo1W53vlTIkZI
         dn9AoE1kCfdubFgI8vdvsltSYIEPEYVbbrzrBqb8j11yxBfeX8XDHfCjDpLF4UVTdkCb
         +vl1uAw0vKAEwQoUCiGtLfJByW30i1Fd6zRyP5j3J5+JDmeIK0sL2h0MxTvy6PCSPoFa
         gRSn6AGly7r8M7alzqsJ8Ixi003z6KFMT0G8L+64+RGJWTovf8bI7NZxTg3c3cv7ZgHH
         fVLsK65xlUObdZpBk3cV+97OGvBZE+5dWqTWapLY6uWrLHGXEbFA3l6Pg+/TS0PpUE+X
         q/qA==
X-Gm-Message-State: AHQUAuaBRpW0zmIwNwa67Q25Q+ITKLGRWui8AfHd3njLUIXW/s5DBtEb
        TkHmUsH9uNxk7Tm0p58Dh1VUplgNyNI=
X-Google-Smtp-Source: AHgI3IY2eIn6N/Jx1oI9lY1+mPnSVGtCxRuuF43xgCbBa3RJPEwwmLrFaoPP1qfWL7noH7R1Y567IQ==
X-Received: by 2002:a63:ea52:: with SMTP id l18mr5509988pgk.317.1550863665253;
        Fri, 22 Feb 2019 11:27:45 -0800 (PST)
Received: from vader ([2620:10d:c090:200::4:eee8])
        by smtp.gmail.com with ESMTPSA id p6sm7908270pgd.69.2019.02.22.11.27.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 11:27:44 -0800 (PST)
Date:   Fri, 22 Feb 2019 11:27:43 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: [LSF/MM TOPIC] drgn, a scriptable debugger
Message-ID: <20190222192743.GA31597@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

I've already sent in an attend request for the I/O track, but I'd also
like to propose my project, drgn [1], as a topic for the BPF/tracing
track.

Basically, drgn is a more intuitive replacement for crash(8) which
exposes kernel types and variables to Python. For example, one can
trivially access common kernel structures:

>>> init = find_task(prog, 1)
>>> fd = fget(init, 3)
>>> fd.f_inode.i_sb.s_type.name
(const char *)0xffffffff862bf29c = "devtmpfs"

Since it's just Python, it's also easy to do more complex analysis:

>>> sum(1 for _ in list_for_each(fd.f_inode.i_sb.s_inodes.address_of_()))
491

I've been using this to debug issues in production at Facebook. Since
the project is relatively new, some of it is still in flux. I'm
currently rewriting the core components in C for performance reasons.
Next after that is improved documentation as well as stack trace
support, which is the biggest missing feature. Regardless, it's already
proven quite useful, so I'd love a chance to talk about it and gather
feedback.

Thanks!

1: https://github.com/osandov/drgn

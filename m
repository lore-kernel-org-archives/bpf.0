Return-Path: <SRS0=5gB9=RP=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B17FC43381
	for <bpf@archiver.kernel.org>; Tue, 12 Mar 2019 16:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B882054F
	for <bpf@archiver.kernel.org>; Tue, 12 Mar 2019 16:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="LnQHklFY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfCLQBt (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:01:49 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:40380 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLQBt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Mar 2019 12:01:49 -0400
Received: by mail-oi1-f174.google.com with SMTP id k11so1975761oic.7
        for <bpf@vger.kernel.org>; Tue, 12 Mar 2019 09:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=lCPO6aHHrTxnsEKjEQE93kCa2CHMaQzOH1xlmcOKjrk=;
        b=LnQHklFYdc6Bz9xhbXGVw9YKNQPW+6yVtbjJ9tg2SvGOci9gpmgAMznJ42fn/Usl9/
         ELic76eG01SLI5APFCpTaCAYteo0OBJRRqknl6jdCzVkipqEisl/e/kpMtsz8ubTDugD
         q5uBstsoq40FlAJP6rb2oVyFzkcfIFyfl2jrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=lCPO6aHHrTxnsEKjEQE93kCa2CHMaQzOH1xlmcOKjrk=;
        b=UQfi4wdhIe8VW53jWu4BDe5Azlcd811XGpiv5N5Fvlz4F3IB3txqwxxD8c1yBORFkp
         tte/BjmKyWryEOs7HDzZDUtrVGJp9KBu4lxA5y95eynO/NfoiT/IczpOZuR6fnR7wX2n
         7pK4PEsod3gdTvTS499FK42eOR2kuQQLbLxh6Dks3VoQ5gOV0a5WcCqas2wBg48BY/ww
         Q16KtSE6bqx+7qO8FKEXY/RXQL/Uczhr+elwEaxOj6xNjFMnolGaubcaeRKJucKV9BEy
         SBV1To0wHrMPUjQJQOBHvURI4L2Tbpt1AsTH9X2ucI4DJ104ktDRnhEDv6yyUmZ/oaA/
         zXSw==
X-Gm-Message-State: APjAAAX5DaCC9zT5PnFBtlgrOwNfRFUn4o9q1vIooltze/hkF2NVY9j/
        JNdfW/xsi860/ZArEw0BKsbGdbmFgCmuJSkocxTgLcT50U1HfQ==
X-Google-Smtp-Source: APXvYqz8gyCoKEi+l+sqFMaFMr1UEC4/zK/+et+cypEaWB5bilbeiGNSfCVetqXeq/XeRge2hDqoFKG01QZW6QoNNqI=
X-Received: by 2002:aca:e0c6:: with SMTP id x189mr2044297oig.78.1552406508533;
 Tue, 12 Mar 2019 09:01:48 -0700 (PDT)
MIME-Version: 1.0
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 12 Mar 2019 16:01:37 +0000
Message-ID: <CACAyw98JsBacLyjtLsj3XnikNbgNRmxhEHpRjzqdAk0=H4BbOg@mail.gmail.com>
Subject: [LSF/MM ATTEND] BPF track
To:     lsf-pc@lists.linux-foundation.org
Cc:     Alexei Starovoitov <ast@fb.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

I'd like to attend the BPF track of LSF/MM 2019 Summit. I work on L4
load balancing at Cloudflare, which uses XDP as a key component. I've
also been involved in our XDP DoS mitigation work.

I'm working on moving the functionality of an out of tree kernel
module into tc clsact / XDP and will contribute eBPF helpers to this
effect. Checking SYN cookies, possibly integration with TPROXY, etc.
As time permits I'll keep fixing small annoyances I encounter along
the way.

My focus would be getting acquainted with other contributors to eBPF,
and sharing the experience we've had using eBPF at CF. Specifically,
hitting verifier limits when generating code due to forced inlining
and tail calling, and patching eBPF at load time to en/disable code
paths because of missing global variables. Since we use / maintain an
eBPF loader written in Go (github.com/newtools/ebpf) I'd also join the
discussion around the one true loader and how BTF specifically affects
third-party loaders.

Best
Lorenz
-- 
Lorenz Bauer  |  Systems Engineer
25 Lavington St., London SE1 0NZ

www.cloudflare.com

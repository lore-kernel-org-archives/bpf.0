Return-Path: <SRS0=c+SL=Q4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF7EC43381
	for <bpf@archiver.kernel.org>; Thu, 21 Feb 2019 21:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1DE2070B
	for <bpf@archiver.kernel.org>; Thu, 21 Feb 2019 21:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfBUV6e (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Feb 2019 16:58:34 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:44734 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfBUV6e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Feb 2019 16:58:34 -0500
Received: by mail-wr1-f43.google.com with SMTP id w2so129993wrt.11
        for <bpf@vger.kernel.org>; Thu, 21 Feb 2019 13:58:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=YYBP/14j6XBs72qvfZuhhp5QlXd9v9JobnubN3uV1+4=;
        b=UUeFWgEkYHE8RNFuNfeA7iKlZDSLKzm49wwIDBVwnVgksYdC4UfeFO+Z7B6xzEtnQA
         mmRxvZ3gryFzjZPxot3jripISkNz+FP/+Dn2RgpKdyowbUQSnnrYQc9pn8stG9qfw1N8
         hFMZZYsSFY9MQ/1UPOR7rbu5uOJYTPJfrWv7Ep6bXRX/GQL8NeLLIO5/yaHyksVh05rl
         0yfqfv2/5npiNdgpvsPVAiJ0X0muG3gf3BTWCUO9S0AjZjLqKPPLKEO3pp+Wdj7ft92H
         UgNoTnxKbNoVakb11CoV2r9Sdoj1IMxZ9TnpLJRgOTwPR14Z4kDfaf8j4T1p2EJ4+r8e
         qRDw==
X-Gm-Message-State: AHQUAuYdRzj9o5tx1j71ihjMToBFMINjglt3cQjWtIzidr3DO+/TV90V
        mord5dGLZDG2SsAhQPWIms//kQBlpfcmoWefRqM=
X-Google-Smtp-Source: AHgI3IbARXIbJI18kFEVUjBODWM/KvlE7XnGxSk93YeWyteD1fDsMxa/UIqT9pF4nTOge7zjl0Yod4sFoWA8RnFtGa4=
X-Received: by 2002:adf:dd4f:: with SMTP id u15mr446861wrm.61.1550786312513;
 Thu, 21 Feb 2019 13:58:32 -0800 (PST)
MIME-Version: 1.0
From:   Joe Stringer <joe@wand.net.nz>
Date:   Thu, 21 Feb 2019 13:58:21 -0800
Message-ID: <CAOftzPg4xi4TetQ=F3Gs3EfuyhtYLbcZuDrZUaX3MJ-DXhLqTw@mail.gmail.com>
Subject: [LSF/MM ATTEND] BPF track
To:     lsf-pc@lists.linux-foundation.org
Cc:     bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        john fastabend <john.fastabend@gmail.com>, tgraf@suug.ch
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi folks,

I'm interested in attending the LSF/MM BPF track. I work on BPF stuff
for Cilium, including recent reference tracking/socket lookup
implementation in the kernel, and the kernel loader interactions.

In particular I'd like to be involved in discussing support for global
variables in BPF, ELF format handling with libbpf and loader
unification as these are all topics related to ongoing development in
the Cilium community, so I can provide some insight into how projects
may want to consume this functionality.

Cheers,
Joe

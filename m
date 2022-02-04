Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D8FC433F5
	for <bpf@archiver.kernel.org>; Fri,  4 Feb 2022 20:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236358AbiBDUNO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 4 Feb 2022 15:13:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33966 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiBDUNN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Feb 2022 15:13:13 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644005591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=F5BYqVjSFt6XgQYb77EyZi5WNA3/nfJAsu8wHW64pbM=;
        b=E1swWk6SxJt2J5HdKdw6mCyFuOaIBuYTsI5khsfd+jmdgy0W9R5eS58vvsbs41nISzQXxy
        JJRrTi+m6hCRrcp5Bk7To/jZsnusmRsrXAinpXWMy2vKu4Q8DtwKkdClEy42uRQrfdZh3i
        GI7M1jR3Ttru4mrz/psR1OOOBSIgzdR44nNEuElWZVbcG6A8qHhGcwx/caqFdHSyRbpjJZ
        r9JRL7h4ZTA1CXiJbGEPjHNzeWRe2SWg6d0lYH7QmZi1MxtfH12i0YgtAWM6klC7Sd7Stp
        eoycGFc/MuJ01LSE+8YaB8+7szfZzvZ/I7dlSPizuafPO8z98pbtI6X/Hik5AQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644005591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=F5BYqVjSFt6XgQYb77EyZi5WNA3/nfJAsu8wHW64pbM=;
        b=30flhkZCGa6Lir+jW9ayRw4lCawmt8uRC8alpxgpNOh4t1HCKpk0aynnspKYELaPu45ZSA
        xH5Sc4XNL2AVH/AA==
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Subject: [PATCH net-next v2 0/3] net: dev: PREEMPT_RT fixups.
Date:   Fri,  4 Feb 2022 21:12:56 +0100
Message-Id: <20220204201259.1095226-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

this series removes or replaces preempt_disable() and local_irq_save()
sections which are problematic on PREEMPT_RT.
Patch 2 makes netif_rx() work from any context after I found suggestions
for it in an old thread. Should that work, then the context-specific
variants could be removed.

Already sketched the removal at
   https://git.kernel.org/pub/scm/linux/kernel/git/bigeasy/staging.git/log/=
?h=3Dnettree


v1=E2=80=A6v2:
  - #1 and #2
    - merge patch 1 und 2 from the series (as per Toke).
    - updated patch description and corrected the first commit number (as
      per Eric).
   - #2
     - Provide netif_rx() as in v1 and additionally __netif_rx() without
       local_bh disable()+enable() for the loopback driver. __netif_rx() is
       not exported (loopback is built-in only) so it won't be used
       drivers. If this doesn't work then we can still export/ define a
       wrapper as Eric suggested.
     - Added a comment that netif_rx() considered legacy.
   - #3
     - Moved ____napi_schedule() into rps_ipi_queued() and
       renamed it napi_schedule_rps().

v1:
   https://lore.kernel.org/all/20220202122848.647635-1-bigeasy@linutronix.de

Sebastian



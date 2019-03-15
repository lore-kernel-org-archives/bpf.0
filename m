Return-Path: <SRS0=GcXc=RS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1610C10F00
	for <bpf@archiver.kernel.org>; Fri, 15 Mar 2019 19:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9010C21902
	for <bpf@archiver.kernel.org>; Fri, 15 Mar 2019 19:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qeml8KMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfCOTwK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Mar 2019 15:52:10 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:36862 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727449AbfCOTwK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Mar 2019 15:52:10 -0400
Received: by mail-oi1-f201.google.com with SMTP id x133so4511832oia.3
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2019 12:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=o99IPl+uG2EzV+A51yAxAJoGFkhXN8vGRgmKAMdYgSA=;
        b=qeml8KMlP7rmAvIxGUwmqXR6s58tv3WFmWASkki2NWsIADrbc1k8lfVc0+MTWbLpzs
         TVLOcfO6bk+g3/mT4x135nyZgaRh/a1cI0EJSPVigzGsRAp8PAEjxUHPFZAzqhmXZx4l
         8Q3KL5oxK5OHSh9sOaBJzftYgvN7gNgSHSwrNoWatq8tKEtYq3SVrekzbwazA+QWLKeH
         U6r1Zznc3OnEUZ0dR61U5DX56ScUlBeamodtGHalBVARU3JboxCMy3bCQIt/yf/PIiTQ
         7ti2uUkzpKUEL7B+2/dvfA9GvioOMJDdEfC7KsiAuJ+0KTfpgnd+IOQxpTKu3Bl4+qOo
         qSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=o99IPl+uG2EzV+A51yAxAJoGFkhXN8vGRgmKAMdYgSA=;
        b=Q4DrsUkaPHvJeZ7mHpnV3ShnddrkqPYWtEfhRd2iJujCnl1mQ0zu/Wk8Cr6RUslqEW
         19P3201SSEiEX1KSVJp7mN0lB/Si4FOORtPPVf2GElcfvGUcZyVMpaT6E2cmPnCggnTX
         1NNRWM4GUqg94c7y8+ptfneBNIrmHkxVGVntz8yfEEwF7YOYsGg6zkOFphRWxlc1tbcX
         4M5A5V0fCVpoCrwcYRMtgJA9x/qNk4Ng5aTnA3AW9oOCEg28V8K74+PRmBzWLkp59h+u
         tR/McKy7flzuekYcdXSe/8NfkBp+XkYl+AJMgEhm1kvfL7e5oezuoFAE3TlmkmW63BMQ
         S5dA==
X-Gm-Message-State: APjAAAV9OsvTAD5lwZD3yBytgq21bmXp/RXhNQpMU1FOWa9PswnxDU8J
        +9xUTXdsh3AeI0Xy+LTMI2zM+isNcbGoouas
X-Google-Smtp-Source: APXvYqxLoKEgsAEPjIF9NsjndQ5gVGqmokYLJoZMnp0FGqwROodj4iKJAPngQ8EF97Yh5xKIjIbFflxcHuXMaJlJ
X-Received: by 2002:aca:2409:: with SMTP id n9mr3111631oic.19.1552679529309;
 Fri, 15 Mar 2019 12:52:09 -0700 (PDT)
Date:   Fri, 15 Mar 2019 20:51:32 +0100
In-Reply-To: <cover.1552679409.git.andreyknvl@google.com>
Message-Id: <56d3373c1c5007d776fcd5de4523f4b9da341fb6.1552679409.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1552679409.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
Subject: [PATCH v11 08/14] net, arm64: untag user pointers in tcp_zerocopy_receive
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch is a part of a series that extends arm64 kernel ABI to allow to
pass tagged user pointers (with the top byte set to something else other
than 0x00) as syscall arguments.

tcp_zerocopy_receive() uses provided user pointers for vma lookups, which
can only by done with untagged pointers.

Untag user pointers in this function.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 net/ipv4/tcp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 6baa6dc1b13b..89db3b4fc753 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1758,6 +1758,8 @@ static int tcp_zerocopy_receive(struct sock *sk,
 	int inq;
 	int ret;
 
+	address = untagged_addr(address);
+
 	if (address & (PAGE_SIZE - 1) || address != zc->address)
 		return -EINVAL;
 
-- 
2.21.0.360.g471c308f928-goog


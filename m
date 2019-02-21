Return-Path: <SRS0=c+SL=Q4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30201C43381
	for <bpf@archiver.kernel.org>; Thu, 21 Feb 2019 23:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA55E20838
	for <bpf@archiver.kernel.org>; Thu, 21 Feb 2019 23:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgXwR9+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbfBUXcI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Feb 2019 18:32:08 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41675 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfBUXcI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Feb 2019 18:32:08 -0500
Received: by mail-oi1-f194.google.com with SMTP id e7so309422oia.8
        for <bpf@vger.kernel.org>; Thu, 21 Feb 2019 15:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=MIWVFBnI2z9eQo9s2KzyTu7GtbT14cTk8aaHMa8q3uc=;
        b=IgXwR9+tPRfzGSSEHqQPtDqbmK5/oP2Op5v6mZTCvywOSjLWmybgDoGhd/1AXKw3lP
         FWBOQIqoynHFhSne+YUXtupGHpT4o61Xnr5jvPe1omDX5Ct8qMl2VYm2XycZ6YdnqxIL
         lNqgcYqWXYpLBNOdgXgvJaeXaqj9XodWqQCRiBB5J2LFWt7ZtPKnIlSVKzcrrx85CSlx
         Lw+gN7d4IOTNtTR10dy40J7k3IslYLFUJtP+KvMKJkp7O3iiwveyHJZOZhfNCR54UsQi
         eyHVT2Zgw2iCpQDUE0PIuN5iOf+wiOwjOR7LXhzJs4b3uzNJEv4+/y8yiLoELzmneZJ2
         tHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=MIWVFBnI2z9eQo9s2KzyTu7GtbT14cTk8aaHMa8q3uc=;
        b=LFdeGuHZ2EZ6pO6TNcqq8BeWVRUauMWynZvOaw+YmLPnVySQ53i0m3bVHTWa00whZc
         8hX30O3Bnq60ORdZWoefyKL6nCnrLATcVeQTaCJnGvHiJzM77uws2VvaqxnlnSkj7OIK
         cdTdJAg4P9llyJF1os5KZgecE8/tQt0WChWca+iB2bXl3m41qX8/1Mp8jtqAOCmovQR0
         UIfvmnBejbl+xAxe8vCXbJkBrNVvt8VdocqMcvIo8eISP4X7z67YHn5Qfmo+J4a4vyoG
         x82X6Ms7K9RH5rklkKf/SFzpfaDt3lg8Xrzmr87Z+uO0WDdVmaYlEiraIZ2o1CDKnT07
         VEYQ==
X-Gm-Message-State: AHQUAubRqdCwJ2Bzl8oc3HSz8KFk/rWB38IX98dQQ2QyZVH4kmLbj47A
        WvEanC3uv9++ccoOyZSrckzlc89XNO3N0A2pn0o=
X-Google-Smtp-Source: AHgI3IaAHfdqpCjp9H+Zz+14vygtO4RRZDNPIhaQJZCh8SUIfgwVfVkXHGM1LMQ78lIwdFBx5C5J+eVcC0yTah1E6hY=
X-Received: by 2002:aca:6c04:: with SMTP id h4mr731571oic.10.1550791927565;
 Thu, 21 Feb 2019 15:32:07 -0800 (PST)
MIME-Version: 1.0
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 21 Feb 2019 15:31:55 -0800
Message-ID: <CAEf4BzYzBiRn1RQ14c2g8tq9QOwbptM8oWfisvRYLmZ2-w5Pgw@mail.gmail.com>
Subject: [LSF/MM TOPIC] Global variables support in BPF
To:     lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@fb.com>
Cc:     Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I'd like to discuss adding support for global data in BPF programs in
most efficient and ergonomical way possible, the problem I'm going to
actively work on. This functionality should allow customization of BPF
program behavior without requiring expensive recompilation (thus
supporting "compile once run everywhere" paradigm) as well as avoiding
overhead and ergonomics issues of using BPF maps explicitly for
similar purposes.

We are going to look at necessary changes to LLVM, libbpf and kernel
to support this functionality, as well as discuss questions around
APIs to manipulate global data from outside of BPF programs.

Also, as I've worked on BTF types deduplication, recently added to
libbpf and pahole, as well as general libbpf development and
enhancements, I'm naturally interested in discussing relevant topics
proposed by Arnaldo (BTF everywhere and its use from pahole/perf) and
Daniel (libbpf as a universal BPF library/loader).


-- Andrii

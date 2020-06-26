Return-Path: <SRS0=o7vX=AH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993ECC433DF
	for <bpf@archiver.kernel.org>; Fri, 26 Jun 2020 12:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 692D22078D
	for <bpf@archiver.kernel.org>; Fri, 26 Jun 2020 12:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2uy8vQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgFZMBn (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbgFZMBm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Jun 2020 08:01:42 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7302C08C5DB
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2020 05:01:42 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id f23so9537855iof.6
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2020 05:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=MtKclr9OdZMSb7vCn+NrvbF5zVlkKXs3UwV6lq9Pllc=;
        b=T2uy8vQukNBXNTsv+4cpZoACpNFa4osiZS0dBmaEiwsDyVxTRLaJBxZp74Sz4G3dFG
         Dm6lQ4G0lNcLXmNSCWc3fKaDo2yy91MgZIbfJmR1yHV0L+M1UHn4FeeM0YJhDxeYacMU
         443pE/fIE0WCuWjPBdgIZIn8gbj1triszhoDj6WA7Pl17jiuJUyTTXk+GeSRRMWfMaOT
         YAztdUKLd8w42OnB4gjQVs1okL8xrUVb2sk7OneQ7G/QVxBT4HKuqD7a65YGP/RxdaiG
         Cy6KnB3r0f4dcbdHQ3AX1u3PAEjxqQa+EcyUZDZBwk6skPk9LzXJLofEWmIBaGxwkRXD
         amhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=MtKclr9OdZMSb7vCn+NrvbF5zVlkKXs3UwV6lq9Pllc=;
        b=JoKrsvENN9kGWMNH6R79X5aX41GQFD56QzsVYKoi1OS55b/rJcVb1gaGPMd1KhVvVk
         KMpKiwzzGzW2HwD3N6FGLOGmBS/OU6zXQY45Bg4/L/TDDhTqo0xn2Go8X+C9drCgT1WP
         yFqsOUkkM7tCZP/UIoJ4o0SlUtzh04R9hB6lPjDvPhl0sBIKuYZtJrQfJIrrHnYGbkz9
         2PmN6SBa1ztKS2GqLg1K2NUUmEBhk36lYpcnWWf3aMuXHnxP5Pntoe6eAdPSBfniU+Dq
         Uoh7p3V9bWA8h85oqwY8mccLwkdFavqGX+0usXrw4cYNTrQNnUOe4wF96gOl8Qa7PtpG
         z3gQ==
X-Gm-Message-State: AOAM530hpo6NGzNiLGQ+Yh0UhHslH2E9qRgiAdDnCSGCUNpcxqyzDp9N
        5a2EPAUAYRE15zbwuKu0y0UjUkq9eZbnsuE46yfLRVihP6c=
X-Google-Smtp-Source: ABdhPJwP9LOKOphjy3ACeZU/uopnPMHzgXY3hYN2M9Wz5LEAQFR0ZMSRCj0UkbGJK1YoGp9IfnC7B0uUfFcwMywrBRI=
X-Received: by 2002:a02:a408:: with SMTP id c8mr3089950jal.59.1593172901462;
 Fri, 26 Jun 2020 05:01:41 -0700 (PDT)
MIME-Version: 1.0
From:   Simone Magnani <simonemagnani.96@gmail.com>
Date:   Fri, 26 Jun 2020 14:01:30 +0200
Message-ID: <CAP5XGZejdCVA0rk9ctj3=i_QPSDVzJem+nbzz6KVwJaGUS_8GA@mail.gmail.com>
Subject: [LINUX-KERNEL] - bpf batch support for queue/stack
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I'm Simone and I'm new to this community.
Lately, I've been working on in-kernel traffic analysis with eBPF and
the newest features released in the latest kernel versions
(queue/stack, batch operations,...).
For some reason, I couldn't help but notice that Queues and Stacks bpf
map types don't support batch operations at all, and I was wondering
why. Is there any reason why this decision has been made or it is just
temporary and you are planning to implement it later on?

Reference file: linux/kernel/bpf/queue_stack_maps.c (and all the
others belonging to the same directory)

Thanks in advance,

Regards,
Simone

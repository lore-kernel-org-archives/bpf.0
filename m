Return-Path: <SRS0=c+SL=Q4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C33C43381
	for <bpf@archiver.kernel.org>; Thu, 21 Feb 2019 19:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0925620665
	for <bpf@archiver.kernel.org>; Thu, 21 Feb 2019 19:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="H3YP/EV0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfBUTJN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Feb 2019 14:09:13 -0500
Received: from mail-pg1-f181.google.com ([209.85.215.181]:42971 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfBUTIx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Feb 2019 14:08:53 -0500
Received: by mail-pg1-f181.google.com with SMTP id b2so8458179pgl.9
        for <bpf@vger.kernel.org>; Thu, 21 Feb 2019 11:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jQKShVKAvkSFRl63y4+DHeSjjVZx2Y9ZQcdZ4CtD5/k=;
        b=H3YP/EV0Wd1QvUEvQhRF7A3GkhQ++sp963S13gh9Grf7mxtkkusHZJSeO60zsBkxcn
         6aFsHHNBQ2lZmcpfeHXgc9frbSOlJ2t9yhzHbDvPg4kXiDLEXdswMfG7da+cq2rSWa9F
         5QMqPNmW/V7mXpa9PL+nNb16W5pUOtq017m0KuwyOfd/0Z96G3/bICGo6iOXci0zpdcN
         OmINt49SV9O7U4ThEOMWW5gWg5ZcsfqqP9kKAMX4wq6D/kxIxwHvDgUChLSyXLGVdsmm
         TNGtHUVr2sfpg0owgOAvw2Gqk+oIB7FA1uNM0LgGLwNsAM5Cwc4I25JFIkVnHXsQkdvC
         EVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jQKShVKAvkSFRl63y4+DHeSjjVZx2Y9ZQcdZ4CtD5/k=;
        b=eaFCP9HEo0v92S+PqY2ke3629J2RZiMr6GXqpLYuKjeXG+ONGtiks3oZFCayVNoW+R
         nBZ8eg9E3rytdWWm2PWIrsd99CP4n5rUe4jYFnkmA3+3fu8J/lZUMq+koMFxKJWjYdJf
         3x/ew8eubI65i+vSzEGt5KWG6Y9Ly/quG/txWFjcft7aJr222fX9zYr27U3nPDbzd1dZ
         iyWnEcaabHPj6Smk1ZbUQ6F1qA8+sS3bbPgmoC1L4zSWfnBmC58qgpzereDuQTD16kNV
         M8WdLaRm5g97kGmswA8zW19VDIrfkdifTeZY3vUlFK6SQnhF2eRz9S0grE3KPYSxprb7
         ASJw==
X-Gm-Message-State: AHQUAua7aEOucCdAoohEJXCpBxGDqIDll1OfZzUfyhiFzYY42IJUTHOc
        GqZwBQpEJOPtNl9SZ9qXHeAhYdxyU1I=
X-Google-Smtp-Source: AHgI3IZmez7tmWN7Hm9GPWbgACBv/bwKUbUU3CZ91VxKK2gR67pZ71gxQF9JsQU8ijtrsdj/WA/SXg==
X-Received: by 2002:a65:609a:: with SMTP id t26mr19048pgu.411.1550776132512;
        Thu, 21 Feb 2019 11:08:52 -0800 (PST)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id j8sm30894588pfe.130.2019.02.21.11.08.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 11:08:51 -0800 (PST)
Date:   Thu, 21 Feb 2019 11:08:50 -0800
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     lsf-pc@lists.linux-foundation.org
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        sdf@google.com
Subject: [LSF/MM ATTEND] BPF track
Message-ID: <20190221190850.GE1928@mini-arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I'd like to participate in the BPF track of LSF/MM Summit 2019. I work
on BPF stuff at Google, I recently contributed to bpftool and BPF
selftests.

Topics I'd like to discuss:
* next steps for BPF flow dissector and how to reach feature parity with
  the C-based one (see my recent RFC)
* how to extend BPF test framework with additional metadata (we had a
  brief conversation about that at LPC)

I don't think my topics deserve a dedicated 30-minutes session, I just
like to talk to people in the hallway :-)

I'm also interested in general BPF direction and how we can apply future
potential features here at Google.

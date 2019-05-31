Return-Path: <SRS0=1DKN=T7=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7F8C04AB6
	for <bpf@archiver.kernel.org>; Fri, 31 May 2019 22:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04CEB26FD2
	for <bpf@archiver.kernel.org>; Fri, 31 May 2019 22:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=domdv.de header.i=@domdv.de header.b="gjAABlj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfEaWzc (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 31 May 2019 18:55:32 -0400
Received: from hermes.domdv.de ([193.102.202.1]:4496 "EHLO hermes.domdv.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbfEaWzc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 May 2019 18:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=domdv.de;
         s=dk3; h=Content-Transfer-Encoding:MIME-Version:Content-Type:Date:To:From:
        Subject:Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=CXeThhPH9KGVrQysZAt/3zG7VeAZmOaiNVRZg6HELOs=; b=gjAABlj8C7aHhvpMok3ANOsLfv
        Su+vyUZelxS7ZFVGc0bFHNvIs4AIoNc9WHrr5jmU4Pkk7rlHtCOXS467de9PoTXhTbzEg0+Jr850p
        WxDIMSMxwjnKaxIrA2PExpqemGw9EYIHieqUPlVm0qnk3WOKplYf7Vw3IlzNMAh1+tX8=;
Received: from [fd06:8443:81a1:74b0::212] (port=4704 helo=castor.lan.domdv.de)
        by zeus.domdv.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <ast@domdv.de>)
        id 1hWqQv-0002kg-D1; Sat, 01 Jun 2019 00:55:33 +0200
Received: from woody.lan.domdv.de ([10.1.9.28] helo=host028-server-9.lan.domdv.de)
        by castor.lan.domdv.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <ast@domdv.de>)
        id 1hWqQG-0006sB-DM; Sat, 01 Jun 2019 00:54:52 +0200
Message-ID: <f0179a5f61ecd32efcea10ae05eb6aa3a151f791.camel@domdv.de>
Subject: eBPF verifier slowness, more than 2 cpu seconds for about 600
 instructions
From:   Andreas Steinmetz <ast@domdv.de>
To:     bpf@vger.kernel.org
Date:   Sat, 01 Jun 2019 00:55:07 +0200
Organization: D.O.M. Datenverarbeitung GmbH
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I do have a working eBPF program (handcrafted assembler) that has about
600 instructions. This programs takes more than 2 CPU seconds to load.

In short, the eBPF program selects and redirects packets, does MSS
clamping and sends ICMPs where required for IPv4 and IPv6. The eBPF
program is part of a project that will be GPLed when sufficiently
ready.

I am willing to cobble something testable together and post it
(attachment only) or send it directly, if somebody on this list is
willing to investigate, why the verifier is having lots of CPU for
breakfast.

Please let me know if and how to proceed.


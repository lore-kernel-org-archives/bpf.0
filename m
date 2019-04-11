Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF25C282CE
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 02:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 613DF2133D
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 02:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="kbJ/2oWu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfDKCko (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 22:40:44 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34948 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfDKCko (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 22:40:44 -0400
Received: by mail-qt1-f196.google.com with SMTP id h39so5447021qte.2
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2019 19:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=kXZZA9Bi3AK7ryA1rETRecAyDH8h6VrQbFOZvJlEY/o=;
        b=kbJ/2oWuwO/UU7ihbF7ILRD8VjW9rqy3TS8PUn8GJztAcZWlS3QiupbtecvaBjdHMv
         Ay4PUG+JJ0G87QXZwZCRhkzfE0J5XbkKdWewQbOFAW9nzirIkOvPaVz2AbY8FTQW6PO0
         bqRTmumnvhqAW/K/zVYSLsSFNMRRr7W/qe2d9XvWwJ8TDOJXOpSa3/ut9VFklrBNW1km
         LqCOTqmnAb5KPVKg9MidCqcabJJndgsrXqn9DDLT5GOQuM+sVLEyYnUJ6RM6sULm/eGj
         Xzzdeb+Cv9MmJViMEwJv4ZP20zR2DqXbFlTO48KaA3gV5r0+SHLI8OR3zbajypbJ39ju
         thNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=kXZZA9Bi3AK7ryA1rETRecAyDH8h6VrQbFOZvJlEY/o=;
        b=ue4KcJU+2AcypTF0ms8dtN83TRMfXxJnXVEMosGf29gbwvjEk8l4Ciwt6yoZhN7xi9
         /9OF6NTtTBYrq8x+8AiEntUvUweg9XQoIDVUh/W9NDQ7ts+UnG+5rR1Sa6cYkD022zCP
         ea0/JSlN+iXOP8WttxPEgUehBw31/FfGVcaJhLNLxCEOdmlQG2IIXoZ7TqSd5nddzo4E
         UVST8uIq8ZkPYXT2puJD0MFUI5NZlHIqInFhoaT59rJXDVBal7ho7BaPqLSM+CIvSY6t
         tfzY+ehA8lNigKvE85cnCh6eOZ4iSAviaNEmx+n86xijTUjIu4PMivepcycpiz5q2xsP
         kDBw==
X-Gm-Message-State: APjAAAW6vygazD3gmijdytI27MJ944UoqQ6+M9DLOmjyXWYL/izHmzep
        e3VLAnGv/bt++OGtuymVdkIsfA==
X-Google-Smtp-Source: APXvYqyt2reef9cUfkrG3D4NIp2oAvfdvx22RFjChb87AiN93k4d/Woml0zU2B2+tlyCfrqfhHXWXA==
X-Received: by 2002:ac8:708d:: with SMTP id y13mr32647264qto.245.1554950443557;
        Wed, 10 Apr 2019 19:40:43 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id i33sm22554192qtb.64.2019.04.10.19.40.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 19:40:43 -0700 (PDT)
Date:   Wed, 10 Apr 2019 19:40:39 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [PATCH/RFC v2 bpf-next 04/19] bpf: refactor "check_reg_arg" to
 eliminate code redundancy
Message-ID: <20190410194039.4a850feb@cakuba.netronome.com>
In-Reply-To: <1554925833-7333-5-git-send-email-jiong.wang@netronome.com>
References: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
        <1554925833-7333-5-git-send-email-jiong.wang@netronome.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 10 Apr 2019 20:50:18 +0100, Jiong Wang wrote:
> There are a few "regs[regno]" here are there across "check_reg_arg", this
> patch factor it out into a simple "reg" pointer. The intention is to
> simplify code indentation and make the later patches in this set look
> cleaner.
> 
> Signed-off-by: Jiong Wang <jiong.wang@netronome.com>

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>

Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2002C4332F
	for <bpf@archiver.kernel.org>; Thu, 15 Dec 2022 04:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiLOE61 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 14 Dec 2022 23:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLOE60 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 23:58:26 -0500
Received: from mailgw1.comp.nus.edu.sg (84-20.comp.nus.edu.sg [137.132.84.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64C7C41981
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 20:58:25 -0800 (PST)
Received: from localhost (avs2.comp.nus.edu.sg [192.168.49.6])
        by mailgw1.comp.nus.edu.sg (Postfix) with ESMTP id AD91711A0FF;
        Thu, 15 Dec 2022 12:58:24 +0800 (+08)
X-Virus-Scanned: amavisd-new at comp.nus.edu.sg
Received: from mailgw1.comp.nus.edu.sg ([192.168.49.5])
        by localhost (avs.comp.nus.edu.sg [192.168.49.6]) (amavisd-new, port 10024)
        with ESMTP id Zk0Uael0eb-2; Thu, 15 Dec 2022 12:58:19 +0800 (+08)
Received: from mailauth1.comp.nus.edu.sg (mailauth1.comp.nus.edu.sg [192.168.49.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailgw1.comp.nus.edu.sg (Postfix) with ESMTPS;
        Thu, 15 Dec 2022 12:58:19 +0800 (+08)
Received: from soccf-srl-002.comp.nus.edu.sg (soccf-srl-002.d2.comp.nus.edu.sg [172.26.191.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: e0446373)
        by mailauth1.comp.nus.edu.sg (Postfix) with ESMTPSA id 3FB14601AF6A5;
        Thu, 15 Dec 2022 12:58:19 +0800 (+08)
From:   Shen Jiamin <shen_jiamin@comp.nus.edu.sg>
To:     olsajiri@gmail.com
Cc:     bpf@vger.kernel.org, nathan@kernel.org, shen_jiamin@comp.nus.edu.sg
Subject: Re: [PATCH] tools/resolve_btfids: Use pkg-config to locate libelf
Date:   Thu, 15 Dec 2022 12:57:52 +0800
Message-Id: <20221215045752.401871-1-shen_jiamin@comp.nus.edu.sg>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Y5pis0BEBZB7PsBh@krava>
References: <Y5pis0BEBZB7PsBh@krava>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thank you, jirka, for your comment.
Actually we can put that `LIBELF_LIBS` into `LIBS` directly.
I've submitted a new patch.

https://lore.kernel.org/bpf/20221215044703.400139-1-shen_jiamin@comp.nus.edu.sg/

Jiamin

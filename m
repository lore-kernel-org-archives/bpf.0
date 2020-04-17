Return-Path: <SRS0=FAFN=6B=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	PDS_TONAME_EQ_TOLOCAL_VSHORT,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54607C2D0EF
	for <bpf@archiver.kernel.org>; Fri, 17 Apr 2020 17:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C1D922209
	for <bpf@archiver.kernel.org>; Fri, 17 Apr 2020 17:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/h8drLp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbgDQRmd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 17 Apr 2020 13:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730080AbgDQRmd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 17 Apr 2020 13:42:33 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC55DC061A0C;
        Fri, 17 Apr 2020 10:42:32 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id w145so2481279lff.3;
        Fri, 17 Apr 2020 10:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=iIqCmbjo3btLLRsEBTP/I+sNGmj3KMb/QmTagxMLfsQ=;
        b=W/h8drLpD8CmGE0QatLNOawF5SGz4ixHzerscYS8BFmOIAAzF6TfWYW55Dnin11zyW
         ZAi6WHYd1ZO3bJWOLnqYJiJqXqcstfJ1JJU0c5h3+b8rFpj+ooVCGiy2JaT2uhDBCgyz
         ubGViAWHUGmrymAGwN/d1tDnEOI5IXmUc3qn9jc8tu2/W6t80ZqnQj3ikzcVKeBXOeuy
         4EdLbKD6AhuybXBb47Etk8EJvHYlx5j0Db99xhJNNpBL0i+Ouh8XFWCGwJTuM8An6QL1
         bNhWgY9XD9skcWcXI3dqJuJzSAf+ObteWkDX7bivC09COYjRrfAb+5KyuwsgL2ysbdGB
         H6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=iIqCmbjo3btLLRsEBTP/I+sNGmj3KMb/QmTagxMLfsQ=;
        b=EoWuO7Lq5IE+3WRJDUCFcpmUhEVkfqVEw+0p5hanhKz69ysU4kwjvkFmq3oldGeo/R
         woczdhPovoc8OHZYZenLXYk81CLMKn1PCNYGB8o/Cj8xX2twtNna7C5T4/EQu+CTmJY9
         CUMPOLQdeYs739ai/LjZEhf5vaNDGo6VRrYb7wK9h4CugfboRcDs9QfNEJDsyj9oUB9y
         uvbJeazbjd4Gwh6jddd93b6TdhCOu4U1q+0tyR6VZwDRd1ZCh3k5f4f7IRQoC4oPGZy2
         yvLJHwF8rKI/cQy3J07EaKe4mn4XAmtNi5TAiYSwp7dQb9ScG8ble576IB7m9Rt7ziKL
         3Qug==
X-Gm-Message-State: AGi0PuaqUAWqLjFtIv3F25+jiawOwYwZjSrbAMr3cdUNPU1WfBEXFFaD
        kJZSNfMMPAMEEO+nD+AcrAjMCqDEFb+vqkybUaxclA==
X-Google-Smtp-Source: APiQypKBdJQtfT3oJtXCPzzqHC6jlzZssogXBYfUpDO48NEEXMjlhEvvNFXeB6zST/r1dQszVAgjUonnYGZgTmBhwOk=
X-Received: by 2002:ac2:569b:: with SMTP id 27mr2852542lfr.134.1587145350816;
 Fri, 17 Apr 2020 10:42:30 -0700 (PDT)
MIME-Version: 1.0
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 17 Apr 2020 10:42:18 -0700
Message-ID: <CAADnVQKaRPsSp6CptpLVyv=QoXnkvnU6NxYWZ=faA9pxYJ5YQA@mail.gmail.com>
Subject: bpf-next is OPEN
To:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Looking at RFCs for bpf-next this release cycle is going to be exciting! :)

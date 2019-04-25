Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64764C43218
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 16:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8CD20878
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 16:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvdMc9fK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfDYQDD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:03:03 -0400
Received: from mail-it1-f170.google.com ([209.85.166.170]:37011 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfDYQDD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Apr 2019 12:03:03 -0400
Received: by mail-it1-f170.google.com with SMTP id u65so989680itc.2;
        Thu, 25 Apr 2019 09:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=cI29hMe0sthDBJz0ekCqPVz6P3kkzU6Ni7T4mkHb+Cg=;
        b=OvdMc9fKWUOPrYQ5GgocyB+0vdgdRsZ/jOSddTOisLSQ9sFviz0QX9vDhItMvfJWux
         RbQc7BpmotGQzm+j1gX14TXlj9zoW+Nx12NZSkQahJS5I/YXs0jn4uJPRIgLMOKzWPdx
         UEOU7E9WBA0u32tVV7d6c+9Sn1xgYibZ28yeKAnwhKrunTsDljF6Qd99u8c/AG2P+Qhr
         1zJo4KB/dOgmkJJmmzEn3N9ZXOtGbQdCf7Pjg3/hOBQR4T4+bTaUO8w3ClCQJImYks2W
         setgHmskZpl0B2sDFI+JNYZr9G/gkmhso3zdiqSecrftVqYM5dOF802hHpueIFUUJQYX
         TlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=cI29hMe0sthDBJz0ekCqPVz6P3kkzU6Ni7T4mkHb+Cg=;
        b=aukzdIK09/kg/LD9Dua8GZHm20bL61n7w3N9HzXmMCZSME2q8R7cBM44oQrSTcCQIM
         LSn7l4JQUzRm1Si0crEQza3njlKtktBs7yDZ5A5JXwiUR/TL7yGWvWHeVL9qvyE+y8xg
         f/iA1GpynCB4fgLoF/03xwwS2e5cZyQRAqGs2Z4klIdZQbWjc22vc/L4ZxzriAMzAjlW
         fE24JwjKqR21WqdPMcOZjXvci4BhyiTt7ogFhFnefKKlc6g0RAcycSEbkRpjqlwWvTjT
         7E2slpeaOsKwGfT4rOaBLq0Rhvb3a2j5TIFGOE6VCQ2OCHU51rUWjnuBPppvskv3yxlk
         T0uQ==
X-Gm-Message-State: APjAAAVZa8fUmRIewg8+JPxDwkWKftBJ8bSGcMooFQS+NNHoyVDFYZ98
        sOSiUE5BLV3UwHYnq/y2V4s=
X-Google-Smtp-Source: APXvYqzOcjSPwO7ZT/V639MT0zkNwRISVhJhv51rcFdwgFKVborU2yjPKn5IPGfb/CtJ1ni+krG4gQ==
X-Received: by 2002:a24:33c5:: with SMTP id k188mr4426679itk.157.1556208182652;
        Thu, 25 Apr 2019 09:03:02 -0700 (PDT)
Received: from [127.0.1.1] ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id y62sm3870975itg.13.2019.04.25.09.02.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 09:03:02 -0700 (PDT)
Subject: [bpf PATCH v2 0/3] sockmap/ktls fixes 
From:   John Fastabend <john.fastabend@gmail.com>
To:     jakub.kicinski@netronome.com, john.fastabend@gmail.com,
        ast@kernel.org, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
Date:   Thu, 25 Apr 2019 09:02:50 -0700
Message-ID: <155620799743.22884.8046772841813554446.stgit@john-XPS-13-9360>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Series of fixes for sockmap and ktls, see patches for descriptions.

v2: fix build issue for CONFIG_TLS_DEVICE and fixup couple comments from
    Jakub.

---

John Fastabend (3):
      bpf: tls, implement unhash to avoid transition out of ESTABLISHED
      bpf: sockmap remove duplicate queue free
      bpf: sockmap fix msg->sg.size account on ingress skb


 include/net/tls.h  |   14 ++++++++++++-
 net/core/skmsg.c   |    1 +
 net/ipv4/tcp_bpf.c |    2 --
 net/tls/tls_main.c |   55 +++++++++++++++++++++++++++++++++++++++-------------
 net/tls/tls_sw.c   |   13 +++++++++---
 5 files changed, 64 insertions(+), 21 deletions(-)

--
Signature

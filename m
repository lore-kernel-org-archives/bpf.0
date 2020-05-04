Return-Path: <SRS0=pWkb=6S=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2695FC3A5A9
	for <bpf@archiver.kernel.org>; Mon,  4 May 2020 17:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E370E20721
	for <bpf@archiver.kernel.org>; Mon,  4 May 2020 17:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxJr9oeC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbgEDRVS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 4 May 2020 13:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729777AbgEDRVS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 4 May 2020 13:21:18 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFD0C061A0E;
        Mon,  4 May 2020 10:21:18 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id x2so12000098ilp.13;
        Mon, 04 May 2020 10:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=tUSEwSXh8XVl3QH0MEWVOPc/xrRd2sKV2YwFOw1eFQI=;
        b=mxJr9oeCM07QvxB9jzZYDAQZMQHsP2epgm1aAdQ06XoWjOHr7ZmKsZSve6wcY1YXIl
         +MF8GrcLv8fRSlpNk8R6Yks8XiH6jMIF8SaScT9seKm43jESFANbLLbzrHJVpUZqCXTt
         HlTXNXyz6wMHhL1FGBUZdfsJrAU07CM+pc2h57L/rUthOdV7OHI16+47T991ssbnMg2a
         DyQ23DNSpuqIHHM9kxidugLjrJeSdtzvwor1W0O1eIm7BTy37juCP5RVqquJswWHiTjz
         rZIEC2oMQa3jbp1EX5e1nkDmRn7363STvNdsAy9de/2NFx2lPwCJkijKgDT9gUflNic9
         DGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=tUSEwSXh8XVl3QH0MEWVOPc/xrRd2sKV2YwFOw1eFQI=;
        b=nvbQc95EZ2BIk8/h4Xbek/uNCl4k2GJP9aO/3TDZ6AgnoV1/QLWTPF4rfomNTqGw+Z
         eAJMCCqyO9FhfzmuSaIGXqJe2DiM7atW+/oC327eJQ66sWKQyhFnDHiKlYwTStDtxz3X
         v+iwDnk61bnEQzXIToDXmUhwZTttmWQ8VJ8uh6T2dZae8j70viIsRD/3o4KTaFzpLBEt
         vwfOgxC93BGdI8VFzR6akjgEnUPW6ZKWK3tLcx2DROVNJVpqg0nVT/8a0Aj2DKkHuOcr
         1cv6e/7dcwsMXY/+Dz5vh7pQAgeCa+38abPBhPM4vWCoTkrIKOpJKx10I7wjaRAUkeNO
         4NeQ==
X-Gm-Message-State: AGi0PubefSp9o14q3/0DPyaijVsiRhM01prZY1YdI935K/+siqv3IsPJ
        KHtw8tGEi/BhGCAaxQTvKSU=
X-Google-Smtp-Source: APiQypIp64ebifabNDFE8DeWtM6rRqtw7pEc+SPcJjgF+LKnDmtPAjSOcoAiBL4LDueMSEZp1NeigA==
X-Received: by 2002:a92:8693:: with SMTP id l19mr18025696ilh.48.1588612877654;
        Mon, 04 May 2020 10:21:17 -0700 (PDT)
Received: from [127.0.1.1] ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id m14sm5471742ilq.68.2020.05.04.10.21.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2020 10:21:16 -0700 (PDT)
Subject: [PATCH 0/2] sockmap, fix for some error paths with helpers 
From:   John Fastabend <john.fastabend@gmail.com>
To:     jakub@cloudflare.com, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        john.fastabend@gmail.com, ast@kernel.org
Date:   Mon, 04 May 2020 10:21:01 -0700
Message-ID: <158861271707.14306.15853815339036099229.stgit@john-Precision-5820-Tower>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In these two cases sk_msg layout was getting confused with some helper
sequences.

I found these while cleaning up test_sockmap to do a better job covering
the different scenarios. Those patches will go to bpf-next and include
tests that cover these two cases.

---

John Fastabend (2):
      bpf: sockmap, msg_pop_data can incorrecty set an sge length
      bpf: sockmap, bpf_tcp_ingress needs to subtract bytes from sg.size


 include/linux/skmsg.h |    1 +
 net/core/filter.c     |    2 +-
 net/ipv4/tcp_bpf.c    |    1 -
 3 files changed, 2 insertions(+), 2 deletions(-)

--
Signature

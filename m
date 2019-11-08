Return-Path: <SRS0=EAyC=ZA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A25C17440
	for <bpf@archiver.kernel.org>; Fri,  8 Nov 2019 22:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCAC214DB
	for <bpf@archiver.kernel.org>; Fri,  8 Nov 2019 22:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWVvt2v+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfKHW4R (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 8 Nov 2019 17:56:17 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45050 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfKHW4R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Nov 2019 17:56:17 -0500
Received: by mail-pg1-f195.google.com with SMTP id f19so4922523pgk.11;
        Fri, 08 Nov 2019 14:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=NeDwWRPCiRvlbYlFMvqR9eZhY0QLmnukENZOzjm70gU=;
        b=rWVvt2v+3rXXoID1bPbL/tkLDi/IZZ8XgoCAxiOEaOhqx3/EdzCqQ0OFqr4Ey51zSH
         iog9v47LLPQaHd5QdIs4j6vtiI+YcH48JQnlYkJv6SRnZ7mixHPXVYTAe1kVyrmYgvMh
         dS2wjOCyhFGXEtuP0RBny7PMJtaWfr7J6jUKC92lWdwz6cdf+96XXyLC5uW5wyj/Qk9O
         2Va0alJtU5vCM/pSQ8tl9wOYA9WfiScw4tyBwqKMsCbqQWCsxsaSFaurPeOyd2kBtlxB
         9u5GwwFbsZJAI4KBVFv43etYIbNVUDJZAjRjV8Z73dWPLUiEi43zJ9rE9O1Y7JN/hX55
         dypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=NeDwWRPCiRvlbYlFMvqR9eZhY0QLmnukENZOzjm70gU=;
        b=Nsy376cAFkJW4cK/FPf6kisS3AmSDcX89/gcgM/k1KBpJ73jlyma6seO+xCw4uTIAr
         e2WABRmKwMVv/gfu4Fd4NR92vqZzfHIvTOnj3rqMIjqx7FoBnMDsQdnz6CmKckq75qy1
         1sZsCHB8ien6X4gaEpZLAGcHS8E6ZrxBR96BP1YYxapvnfVIM8Z3FWfEC5jWkhuXDcnU
         VIalOzUYZLX+sbpTOI57G1SO4t68jpM07+cLYCzAAeWNVozCDaFlvMv+bANF4uLQFUx1
         ZIYclXafe81M3PMdpmGiT4kCjh4SShIFftegWuwuPJgvjgpPHxUR/LCxZsrueadehY6v
         7HXg==
X-Gm-Message-State: APjAAAUSV4Co18zDFFHOmrKGmWX6A2iwurFLx2sBZQmqAXwGRuU3oX32
        fKx4Qf2YOWk0oLJ4IOWisuscvBmj
X-Google-Smtp-Source: APXvYqx83RG2ncMY4bWLw5nHfYAUQfpYCm853LnYZE/X2FcS2moK2Z3R4yReH5vwKHL8m68tLs9Yfw==
X-Received: by 2002:a63:4921:: with SMTP id w33mr14918640pga.237.1573253776445;
        Fri, 08 Nov 2019 14:56:16 -0800 (PST)
Received: from [172.20.40.253] ([2620:10d:c090:200::3:c214])
        by smtp.gmail.com with ESMTPSA id 76sm8066990pfw.75.2019.11.08.14.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 14:56:15 -0800 (PST)
From:   "Jonathan Lemon" <jonathan.lemon@gmail.com>
To:     "Magnus Karlsson" <magnus.karlsson@intel.com>
Cc:     bjorn.topel@intel.com, ast@kernel.org, daniel@iogearbox.net,
        netdev@vger.kernel.org, u9012063@gmail.com, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/5] libbpf: support XDP_SHARED_UMEM with
 external XDP program
Date:   Fri, 08 Nov 2019 14:56:15 -0800
X-Mailer: MailMate (1.13r5655)
Message-ID: <90122A08-8AF0-4B22-886F-C863D96D119E@gmail.com>
In-Reply-To: <1573148860-30254-2-git-send-email-magnus.karlsson@intel.com>
References: <1573148860-30254-1-git-send-email-magnus.karlsson@intel.com>
 <1573148860-30254-2-git-send-email-magnus.karlsson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7 Nov 2019, at 9:47, Magnus Karlsson wrote:

> Add support in libbpf to create multiple sockets that share a single
> umem. Note that an external XDP program need to be supplied that
> routes the incoming traffic to the desired sockets. So you need to
> supply the libbpf_flag XSK_LIBBPF_FLAGS__INHIBIT_PROG_LOAD and load
> your own XDP program.
>
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>

Acked-by: Jonathan Lemon <jonathan.lemon@gmail.com>

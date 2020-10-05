Return-Path: <SRS0=IKg2=DM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CE5C4363A
	for <bpf@archiver.kernel.org>; Mon,  5 Oct 2020 15:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A23220663
	for <bpf@archiver.kernel.org>; Mon,  5 Oct 2020 15:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqUI1eAy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgJEPyy (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 5 Oct 2020 11:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgJEPyt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Oct 2020 11:54:49 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C636BC0613CE;
        Mon,  5 Oct 2020 08:54:49 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id i2so2544750pgh.7;
        Mon, 05 Oct 2020 08:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BqkdVKCtHsNSqF/Og7FBsBE4qMp9jp0ZGyBA+fMz5ks=;
        b=HqUI1eAyKm5jQioMsTtQ8Lg0EF5dS6LJV6naajoWqlKLWk6M6GUO/h1DsotRw3ZWQ7
         hCvm3GUBYmmyCw1A0JY2HEZhp3adMkN9yVUYd2zKHSjl1xrj/lS7xrX9ICkgl0iLsjrH
         4yh7Bi/hhvMFv0JzrNI6mC90LAUQcDVa5N+0K8ddy1Qj6YaE8Wx0ZTJe/MML4f27+y6n
         cjG7TgIjgY8itxq/OPEt91Y8AjYW4FdsvbxFggaszz+taWdTLrG4bWMXduAF0+6x26jY
         HqMAN5vhmPEFhO0NnTKeAXuW1uNRFFeJnuOW297oJlz8TBrVzvE8fnsblsBn0sgUXRPh
         5t4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BqkdVKCtHsNSqF/Og7FBsBE4qMp9jp0ZGyBA+fMz5ks=;
        b=efYb1uT002Pau2ol0rzpFc1SgHmMaZ2VWBBPeXecYolyFy8uqukRlJNWUztZkGPoRn
         aOoNP0EvGLcVxwCT9ztATsZqybUlyq4PqsVU5srxKhzOEIWfFhDFey0KZKKxrHxVTdc/
         DpFRKUmzT1vwITwzTD1982syfiQ+iW57WBn/t7XRow9FEAtv6fuk/cgXy/ameDpjYERC
         NRPq9mb9y+pulLb5MMeXdH57PWxNCnO7pZ4B5UMU5igR3SpThPVBsSWZNGpnYGSLq9o0
         snwCSTqrGzQXP6PNfM6P03FHXX/LX+Yq3yeS5HPZ5PbRXZx0VPaKP16JasTh/UKt08rj
         AClQ==
X-Gm-Message-State: AOAM532X9s3IL9LKJF76Q1SzY9Mvot/jUPZovgQjCvJlMhAtcUKl8k2G
        LZx5hVpDm4+lRyTpT98vn0g=
X-Google-Smtp-Source: ABdhPJwajglKbXLiJskVArVqR9JeqRDLc5peOqyIW1kMnAWLq9FSq9p18X+qh0gpWvnyWJJPlIK+lw==
X-Received: by 2002:a63:ee46:: with SMTP id n6mr156788pgk.120.1601913289112;
        Mon, 05 Oct 2020 08:54:49 -0700 (PDT)
Received: from localhost.localdomain ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id j4sm288262pfj.143.2020.10.05.08.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 08:54:48 -0700 (PDT)
From:   Tirthendu Sarkar <tirtha@gmail.com>
X-Google-Original-From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
To:     daniel@iogearbox.net
Cc:     ast@kernel.org, bpf@vger.kernel.org, brouer@redhat.com,
        davem@davemloft.net, dsahern@kernel.org, echaudro@redhat.com,
        john.fastabend@gmail.com, kuba@kernel.org,
        lorenzo.bianconi@redhat.com, lorenzo@kernel.org,
        netdev@vger.kernel.org, sameehj@amazon.com, shayagr@amazon.com,
        Tirthendu Sarkar <tirthendu.sarkar@intel.com>
Subject: Re: [PATCH v4 bpf-next 00/13] mvneta: introduce XDP multi-buffer support
Date:   Mon,  5 Oct 2020 21:20:16 +0530
Message-Id: <20201005155016.9195-1-tirthendu.sarkar@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <5c22ee38-e2c3-0724-5033-603d19c4169f@iogearbox.net>
References: <5c22ee38-e2c3-0724-5033-603d19c4169f@iogearbox.net>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/2/20 5:25 PM, John Fastabend wrote:
>>[..] Typically for such features to land is to require at least 2 drivers
>>implementing it.

I am working on making changes to Intel NIC drivers for XDP multi buffer based
on these patches. Respective patches Will be posted once ready.

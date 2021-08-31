Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C17C432BE
	for <bpf@archiver.kernel.org>; Tue, 31 Aug 2021 23:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46FA760F6B
	for <bpf@archiver.kernel.org>; Tue, 31 Aug 2021 23:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbhHaXQp (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 31 Aug 2021 19:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbhHaXQo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Aug 2021 19:16:44 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE4AC061575;
        Tue, 31 Aug 2021 16:15:48 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id z1so1534967ioh.7;
        Tue, 31 Aug 2021 16:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=/Yzl5/BMo8mwjKU50+yBzRi98rqy/lPpaWE1eJAfHeQ=;
        b=RwkEf8EcaRfF/awyn7J+u+YVk12Z22YJEeNPWbFpmdvnhfZN4mvMQdTjVUNVVfTcZ6
         QlOJEgvGp6pjkQTB23DHQ/EpPonxsRSsSWLG2rU/7k6xhOnTfTtkWc6aIk+RboON5Cty
         bHfSl0BPBgiFLkLoYWQAN+WKm0W86Sbu2ECeL8DoJt4mUI0zXJgQUKG+bG9HyfUll1As
         dhbGS7xXNfTfLWLrkpSs7dhJqsGoc9rUzkGyzFZ6vxQ8dRChczUx/mudt5+3d3VPN1JZ
         Pa1SlAhN6Dy31NsaWUB1s/B5Xk/IWSTLx95EpYpIkIuoJtXCO9wpLJcTcswXvZwZT5a0
         6YQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=/Yzl5/BMo8mwjKU50+yBzRi98rqy/lPpaWE1eJAfHeQ=;
        b=jz/XlLGgxtmIUG2slOBWNwg9ieNxKsKEGDWTKQBIcUkThUEoGB/2kKOlUYIKPskDZz
         KYK2yxQNglk0G8MADu6o0e4G4Qp65edwcIw4pPLVDxHlsq9722RjWbhA1voEgRvzf/eG
         7VMqKWagQmo8jff/T6G6w46gWLe0ugbuslg/KOWX2MjtS5YgX618jFOWI2aeuW+lIBuN
         bTX4XGHRXBwjlFhZES0EcvKssRvJA/EBpDJhSCJ9Bu6N/ZdYFv5do0BwbztZ0RbpwO27
         3sM4gcLD3uyTu8bgjkjEt1gNi9o7azW9AgCLaAzYk9AcrDxJp6d1xItdTD53bXvHbjnr
         5ysA==
X-Gm-Message-State: AOAM5328M0AeCWKqsDRzL7jp+oFNM3Xc3h9O0+g1rvMKC/CJH+fa73Sx
        84qBx/CtxacpZPTYN6E3wMfs9TqJhgg=
X-Google-Smtp-Source: ABdhPJxzApBl6auHk4Bl+bGGc6rMbJCQWCGhVoUB7XQYLfXHHxJawCNHLI1jdFlsFGsIawz0Hx7c/w==
X-Received: by 2002:a5d:96da:: with SMTP id r26mr24790828iol.47.1630451748394;
        Tue, 31 Aug 2021 16:15:48 -0700 (PDT)
Received: from localhost ([172.243.157.240])
        by smtp.gmail.com with ESMTPSA id x10sm10979441ila.4.2021.08.31.16.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 16:15:47 -0700 (PDT)
Date:   Tue, 31 Aug 2021 16:15:41 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, shayagr@amazon.com,
        john.fastabend@gmail.com, dsahern@kernel.org, brouer@redhat.com,
        echaudro@redhat.com, jasowang@redhat.com,
        alexander.duyck@gmail.com, saeed@kernel.org,
        maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
        tirthendu.sarkar@intel.com, toke@redhat.com
Message-ID: <612eb81dcccfb_6b8720859@john-XPS-13-9370.notmuch>
In-Reply-To: <db0f23d369ba488c0ebd1f43dd283221be801fea.1629473233.git.lorenzo@kernel.org>
References: <cover.1629473233.git.lorenzo@kernel.org>
 <db0f23d369ba488c0ebd1f43dd283221be801fea.1629473233.git.lorenzo@kernel.org>
Subject: RE: [PATCH v12 bpf-next 02/18] xdp: introduce flags field in
 xdp_buff/xdp_frame
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Lorenzo Bianconi wrote:
> Introduce flags field in xdp_frame and xdp_buffer data structures
> to define additional buffer features. At the moment the only
> supported buffer feature is multi-buffer bit (mb). Multi-buffer bit
> is used to specify if this is a linear buffer (mb = 0) or a multi-buffer
> frame (mb = 1). In the latter case the driver is expected to initialize
> the skb_shared_info structure at the end of the first buffer to link
> together subsequent buffers belonging to the same frame.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>

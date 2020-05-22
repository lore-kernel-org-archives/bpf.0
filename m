Return-Path: <SRS0=QYON=7E=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72029C433DF
	for <bpf@archiver.kernel.org>; Fri, 22 May 2020 09:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52B2A20812
	for <bpf@archiver.kernel.org>; Fri, 22 May 2020 09:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="lty4Diqi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgEVJUd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 May 2020 05:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729174AbgEVJUc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 May 2020 05:20:32 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87607C061A0E
        for <bpf@vger.kernel.org>; Fri, 22 May 2020 02:20:32 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id s3so12199375eji.6
        for <bpf@vger.kernel.org>; Fri, 22 May 2020 02:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WH4Qdp5oLQZc/7+L5+wPyr1roUu55bqJeKNGQgd8MLw=;
        b=lty4DiqipJDHrb4nvvkHmBC2xMZgUXLdRSjIqRqNdChZkuBQZIQR4ZV+uI/PzxJUAd
         FdH66cQsxz3cDPk1s/TEKlutkZm/CeLwBsDx0Fq9+3GSdyw3grtljjz+sHAxIkK6u562
         SoDYOqcFN+CYpAYfEpH6nmap5QbE6tLgGS6bE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WH4Qdp5oLQZc/7+L5+wPyr1roUu55bqJeKNGQgd8MLw=;
        b=ZSSvxXIZenKwxwKyBKMytMTeX8Hj6GjRDE64M+vr5J44Wc37XVMDUQa/FWB4r7r/O9
         hzsuBe8S1aFAeov4z5PBvZ4mWMOk5HotG+WP+c/eqscC/VrFgxx3L23nDB4Iivw3lB9S
         68pzBDvjft1CNm/JfRXlRgwTxy8knit86GBNXa13FzbXesn8gLIQ33KEipKeIXbgb5Lb
         rPHXIdomWdnLadosn+w7P61HhEN3YRaYisuEo1SSigu9XtyzSRvVQqeN64vxq2cl0gCy
         U/sruZrhXpJeTbBGVqOSkHOFBkwKPQ6B6Io2YAsL+Z6cQWWMhpTcn45Hj/BJ5MLtkrzx
         fogg==
X-Gm-Message-State: AOAM530hohgs85qN2MOxb3cq3eF6Kiqdm5Ucg2/iKkRzdpR7kG9RbdAr
        AJrD3b0qjXOF2N+rbgeb8YHzRw==
X-Google-Smtp-Source: ABdhPJwGuHjXtaIs0W9VwFvwXDRaHc8Tv1HiTobG0pAyP/TdiHnJ0KZveY5wW6W3FShdqhdoQeVAfw==
X-Received: by 2002:a17:906:9383:: with SMTP id l3mr7238171ejx.520.1590139231136;
        Fri, 22 May 2020 02:20:31 -0700 (PDT)
Received: from toad ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id r21sm7159254ejs.48.2020.05.22.02.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 02:20:30 -0700 (PDT)
Date:   Fri, 22 May 2020 11:20:28 +0200
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     yhs@fb.com, andrii.nakryiko@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        lmb@cloudflare.com
Subject: Re: [bpf-next PATCH v4 4/5] bpf: selftests, add sk_msg helpers load
 and attach test
Message-ID: <20200522112028.42f56c1f@toad>
In-Reply-To: <159012150674.14791.15054968668193084791.stgit@john-Precision-5820-Tower>
References: <159012108670.14791.18091717338621259928.stgit@john-Precision-5820-Tower>
        <159012150674.14791.15054968668193084791.stgit@john-Precision-5820-Tower>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 21 May 2020 21:25:06 -0700
John Fastabend <john.fastabend@gmail.com> wrote:

> The test itself is not particularly useful but it encodes a common
> pattern we have.
> 
> Namely do a sk storage lookup then depending on data here decide if
> we need to do more work or alternatively allow packet to PASS. Then
> if we need to do more work consult task_struct for more information
> about the running task. Finally based on this additional information
> drop or pass the data. In this case the suspicious check is not so
> realisitic but it encodes the general pattern and uses the helpers
> so we test the workflow.
> 
> This is a load test to ensure verifier correctly handles this case.
> 
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---

Oh, that kind of "load test" :-)

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

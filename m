Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB1AC10F0E
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 18:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9424C20880
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 18:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="gTY0ZEYc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfDOSi3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:38:29 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32822 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfDOSi3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Apr 2019 14:38:29 -0400
Received: by mail-qt1-f196.google.com with SMTP id k14so20396349qtb.0
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2019 11:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=56w5f22EtjrVypvs36ZpGyPRA6eQcLxT7hki1kmi4u8=;
        b=gTY0ZEYc6BY7+crA4GMRglqH6K2+37USpUTp5jWcwHZiUQyJn99mlWOm6MSLppViw5
         mEqdp4RHcooL6il1MQJYtuqW/hLiF89dMwdDS+Dh42hTGZ+xsgQa+09LCZo5hHmvwL9X
         NJ7R9CwkGPznSxdekb7BNJoiFg1RZJ7w6M8J2U7pLyOIE6aWYsGpz+rCYB7gwMTYOFbD
         mXKEfdNI1GUhcFDfJQCyTtm4B45lOCdwOU8rJTBkb+IzTelYC1aFoxGIBiUiXScTCg5o
         zvzmWWCcQXTgrbHUuGXKprADXeBNm/Ae8HD/NhzMUyFYDBrU2grXZS9NmKzaFyyhvlYU
         JcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=56w5f22EtjrVypvs36ZpGyPRA6eQcLxT7hki1kmi4u8=;
        b=s/loG85c8iOefJAj/zPprYzGxbndvpXMMfrq4tG8uaIYXAoNtGLeYCrbv3qGEWk1e9
         xjTLpGhbZ7xaH0c5uxs5Cd68FqHszy/TebrqiyCC0YpApscCueNnX+z2snKiG4tTCTjz
         9L2+kEfQYrjxN6qsaV1iiFxIP4V1c3EghwWOwvL0jMRsxO4cXBytJgGVkDQ76I5KJs7v
         J1vwX/pHTP6GrI17GGUqdFMtJG49eHxguz4WLO5uk6U0wBQgPAvWUXg55G6B+N/weir7
         aGLfhouMTtW+i78zTcPDRmUoqSr5UTXsXDnvngySwcJBH/mGHX9xxfqwAU6h0qV3AC/Y
         EXRA==
X-Gm-Message-State: APjAAAWT9iXQ8MmmNT1H8TqCTKK0w9+ABgLBJJNeXU0IIMQilCTM/a9a
        DW0aqFIcQMbfSDsmruE2IKJzcQ==
X-Google-Smtp-Source: APXvYqy6+X+P8AWxDnO48g9NZr8pRbhpWxxIca85fVpl2dfJXqsW2Max7ilKiAX2kZKvdm+zmeaO0g==
X-Received: by 2002:ac8:3767:: with SMTP id p36mr63660983qtb.280.1555353508602;
        Mon, 15 Apr 2019 11:38:28 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id v30sm24786672qta.4.2019.04.15.11.38.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 11:38:28 -0700 (PDT)
Date:   Mon, 15 Apr 2019 11:38:24 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Benjamin Poirier <bpoirier@suse.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v3 bpf-next 1/2] bpftool: Use print_entry_error() in
 case of ENOENT when dumping
Message-ID: <20190415113824.3fba6dd1@cakuba.netronome.com>
In-Reply-To: <20190415071536.19287-1-bpoirier@suse.com>
References: <20190412030322.15494-1-bpoirier@suse.com>
        <20190415071536.19287-1-bpoirier@suse.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 15 Apr 2019 16:15:35 +0900, Benjamin Poirier wrote:
> Commit bf598a8f0f77 ("bpftool: Improve handling of ENOENT on map dumps")
> used print_entry_plain() in case of ENOENT. However, that commit introduces
> dead code. Per-cpu maps are zero-filled. When reading them, it's all or
> nothing. There will never be a case where some cpus have an entry and
> others don't.
> 
> The truth is that ENOENT is an error case. Use print_entry_error() to
> output the desired message. That function's "value" parameter is also
> renamed to indicate that we never use it for an actual map value.
> 
> The output format is unchanged.
> 
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>

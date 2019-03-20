Return-Path: <SRS0=US5c=RX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA25C10F05
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 12:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FCB2146E
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 12:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hD+f/vLS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfCTM4Y (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:56:24 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:40431 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbfCTM4Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Mar 2019 08:56:24 -0400
Received: by mail-pg1-f178.google.com with SMTP id u9so1744950pgo.7;
        Wed, 20 Mar 2019 05:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NKfckqdhcriPRZ8W45eiilObwgo0DkKsTgE/5NA7lbI=;
        b=hD+f/vLShZo6W+GphXnJWyshSj4ume3DMxNzeaF4HWCbVR5g/UeH5tneoC9aNt6HkZ
         +bh6ahkiTGJjFix7fdl6SMMQPzJFtjcox/1fWStNhaZZl6gVjEOxzVa+EdWGv3mqzAzk
         iPqgo2ITmeBqtWyfrvRTEpZAbmxAl+ksb7xkf/86lILD6oxRmdHuWTaU3hW8J9WDqbe+
         Ara91HWQqgkAbgbM9FFmGaPw8Seg2lDL1E6GtUxpMTrjC2J1Yic0RFWrexAkXoSz29eU
         tCp7VGIqPieDEBSSqX24iLPF/8MjdjDLPeI/NhjEb3d9+x19QzBySnvFj6sKmpJ1I6Tf
         q7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NKfckqdhcriPRZ8W45eiilObwgo0DkKsTgE/5NA7lbI=;
        b=GQJmHqdvepBTJmHQcOLi71yAmn3CvjClJ0QLhr+cCWi9HYtBuhRRLx1Al9npJa76Sq
         wOxHBMn6WKmTZ3+52SqAnAqVxW/ZANzYPbXZDhIfJtiA0jP0rue9n+fhm09ubugAuVLX
         98kX5q6UuvsRW7mGQ921dh3t7do4yJ+OXDYPhZJcOyeQgjBQDOgkNWUH5KXr71dcg3a7
         mwZgLeEdGM0cBQwF/KqwL79Wy75dHH86n67WzhtYrdMi0nyaNM9Kypg/r2dMV3Gdihkl
         zyTeL7Cs8S8iF7uAzPx4wBHHthYU3QiT4vWbPma9048L6EbE0dOWfjY+GtG+pK0H7FyK
         OWKw==
X-Gm-Message-State: APjAAAXMc9m3OrwMN/SH5Ew6d8x2Ro7vUiUDemZq0oD9eU2LR7u0Cunl
        CxjmFotf6M5mgkWmYSpKtJc=
X-Google-Smtp-Source: APXvYqyKobw0s0w8yvt+l8jq9qfwexZURLTt+6na3KkAw4iEodSGUBhsRRs8jX5Sn98DlEUyKcT5xA==
X-Received: by 2002:a17:902:7610:: with SMTP id k16mr8371459pll.215.1553086583205;
        Wed, 20 Mar 2019 05:56:23 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id h3sm2300442pgv.38.2019.03.20.05.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 05:56:22 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Wed, 20 Mar 2019 21:56:20 +0900
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCHv2 bpf-next 2/3] bpf, tests: drop unused
 __bpf_constant_foo defines
Message-ID: <20190320125620.GB11501@tigerII.localdomain>
References: <20190320125335.19621-1-sergey.senozhatsky@gmail.com>
 <20190320125335.19621-2-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320125335.19621-2-sergey.senozhatsky@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

And this one is the last one  -  3/3.

	-ss

Return-Path: <SRS0=US5c=RX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE99C43381
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 12:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242482184E
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 12:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgSyq1Xw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfCTMz4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:55:56 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:42570 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfCTMzz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Mar 2019 08:55:55 -0400
Received: by mail-pf1-f170.google.com with SMTP id r15so1869525pfn.9;
        Wed, 20 Mar 2019 05:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TpDsun/PMh1SOmIF1fwLdut9u/aRSNqHVCq+Nk3m63Y=;
        b=XgSyq1XwYPdExTbJ7t4liy11YMx1YhygMU6BHmrcjhFv0pzYewtAuRAfOkrhPJcW+S
         y9NRPMpfqfpdxGs/JRphC5sCAiFolBIl4bQC6mtAatn+RfFPo0LZSpIiEHYrmHBi/+eH
         t/giqR2GGwx3KZt8K/Vo6nbDtmE6p4r0FgSCk1ltpWf8BuIYnqsyyhCIh0gdvNgisVcr
         ucAcCW7PaNvcB2+cbhwfmZ2Y4/40SMP/Z0kcZJlcTNvTysldPi3B1oSFUWW2zCCJHKt8
         6BJUNgHk5jykQOalAbEq2012eeAI0ULm9GsgJNH5AhoHqCqUgeMaHGZM+sDcDmydt9er
         C8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TpDsun/PMh1SOmIF1fwLdut9u/aRSNqHVCq+Nk3m63Y=;
        b=i5ETYXDXiV5Q6f3eXzETTu6eSgXD839lxvOyYtACkQ5efwTmZ5VlhGFiZY4ulfCU54
         Ce6aCU9lJr0p7SzaivGj1bPZE1W9a9xFzM8a3ZirAzmpwHRhcJh5uJ5ddKBLHoK/dy/T
         lKqqzJ72auYJDwV3ktNW6VBxMcDvNrPASOsg7rHBN7buhzwYWx9v6u5yYa3bqefYFl4K
         er8t4c7VoXHMLY7phRzix4HJ+jfuIWMSb2m2m/3NMWKN42WoeyDKFGqAVeLVSWkU5S43
         R3zl7wi0AEimywp7atnlXb9Ct12bXuyzs6lQk9w+mgRYssAn/zDWre3NsqLWtfUhSdvt
         DEZg==
X-Gm-Message-State: APjAAAWnmAvoPKpcuEkPUQAzr3AsfLI+k3SfDXffqdIwpQsQ/ZoxfFCU
        Xbfd5ZWdZR1gaIi/VnXq/Yg=
X-Google-Smtp-Source: APXvYqy7Uywq2DK8tOnxW9P1QRi72yimkuO5hKsCQjNe9Hkq/2wQMXRgUpN0i+zEFqnUjgb7oyCgjw==
X-Received: by 2002:a17:902:e486:: with SMTP id cj6mr7793151plb.86.1553086554723;
        Wed, 20 Mar 2019 05:55:54 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id m10sm2365917pgq.42.2019.03.20.05.55.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 05:55:54 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Wed, 20 Mar 2019 21:55:51 +0900
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCHv2 bpf-next 3/3] bpf, tests: don't use
 __bpf_constant_htons()
Message-ID: <20190320125551.GA11501@tigerII.localdomain>
References: <20190320125335.19621-1-sergey.senozhatsky@gmail.com>
 <20190320125335.19621-3-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320125335.19621-3-sergey.senozhatsky@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yikes... This is actually - 2/3

	-ss

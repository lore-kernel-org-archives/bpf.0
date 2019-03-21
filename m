Return-Path: <SRS0=yvf5=RY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5019AC43381
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 00:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A28220835
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 00:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McEzwMHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfCUAeb (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Mar 2019 20:34:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39294 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbfCUAeb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Mar 2019 20:34:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id i17so3112529pfo.6;
        Wed, 20 Mar 2019 17:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7s7YHQjhAnDJVcYdqhFQbsnQIWfSmp9HtVXkUfSG/Q0=;
        b=McEzwMHjm9OfUQjzruTj2ASMsL/J9fUpkDKBScBSmjhEvvsmDC3lVj7Pz3LsGj137/
         EGdjAL8fJZrA2srK/FRa4zgH5HUGWlHqdGn9iDqtNP9mCInslqhx2gGL1oregD1FsGkv
         fZdo7xw+Ir809byBQ4cYF2NJQpeTglz4TZjt1jaFw2grgmF2JjqNt6+i7VbwtBI5/+YE
         n/v/CL4voKWnEAj5DOL/ykhwcEarorWGYhz1CC5gxb1OenQYorOOyYKf3Jvnj7bnmiZH
         684UtBzP8ezQa3aciq1mBOsbXjkpEgmpQILZ46cP061pGqnOu4u5AtJbJuJ1TiGf6bGw
         fTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7s7YHQjhAnDJVcYdqhFQbsnQIWfSmp9HtVXkUfSG/Q0=;
        b=EkkviZrojEQu+8ki7/afKo1zqbEjdhVW2SU0aDaB7rAhlEpoTtMIM8NpN4pEMVWTMC
         M7+9RywYtSOUl2v3Ha/cttgIS7ap0qWYXKV5txB1rGotwUtQkfQMaVVt7hj5Eh8chrND
         bPy3wqW4SsYBmVBhoHL5zDgwtJlX9mTGRPisIXj3rA5OvsTNylpgFvY6dA7lacKsjWTx
         uGKKudV1xdXnLmBkEfUeqsDtmZfbTsQ+5X5yAswnLhBfYQv5f3yaXqMo6X1uzuQcYNiP
         uT+epny7jG9n6K2+DRflf41kTMBUFU88IC9fCg3rEBIz9i+pHIO6C4MhmBRC0A0sEVf7
         FUsg==
X-Gm-Message-State: APjAAAWQArAuthhMU5cJsjU/7xIkC53TSjwgm/5u0DkP/zCPea1KbdCX
        C59CSfEP0mc6ij79r3dVHdg=
X-Google-Smtp-Source: APXvYqytL53/ohPpLzulbQ7otANXGjzoijHkGYxPmq5+NmTgRv5AgQUkJd2it6JjrvPfy7ajEXpJgw==
X-Received: by 2002:a17:902:f206:: with SMTP id gn6mr672501plb.58.1553128470324;
        Wed, 20 Mar 2019 17:34:30 -0700 (PDT)
Received: from localhost ([110.70.50.223])
        by smtp.gmail.com with ESMTPSA id d137sm4471217pfd.133.2019.03.20.17.34.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 17:34:29 -0700 (PDT)
Date:   Thu, 21 Mar 2019 09:34:26 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Stanislav Fomichev <sdf@fomichev.me>
Cc:     Yonghong Song <yhs@fb.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCHv2 bpf-next 1/3] bpf, tests: tweak endianness selection
Message-ID: <20190321003426.GB2097@jagdpanzerIV>
References: <20190320125335.19621-1-sergey.senozhatsky@gmail.com>
 <20190320171332.GJ7431@mini-arch.hsd1.ca.comcast.net>
 <4c6db4e5-8e77-2e01-a4ab-25808df2b857@fb.com>
 <20190320222759.GQ7431@mini-arch.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320222759.GQ7431@mini-arch.hsd1.ca.comcast.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On (03/20/19 15:27), Stanislav Fomichev wrote:
[..]
> > Inside kernel clang compiler header (linux/compiler-clang.h) does not 
> > define __HAVE_BUILTIN_BSWAP16__. So it will go to the "else" branch in 
> > the above. So I think it should work with clang + bpf.
> Hm, isn't it the opposite of what we want then? I think for llvm+bpf we always
> want to use the builtins to make it properly generate
> BPF_TO_BE/BPF_TO_LE instructions.

Oh, hmm, OK. I see your point now. bpf insn set for variables.

	-ss

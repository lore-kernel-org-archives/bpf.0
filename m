Return-Path: <SRS0=8xVa=6M=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3609C83000
	for <bpf@archiver.kernel.org>; Tue, 28 Apr 2020 16:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F54D2063A
	for <bpf@archiver.kernel.org>; Tue, 28 Apr 2020 16:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZikGz310"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgD1Qoa (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbgD1Qo3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Apr 2020 12:44:29 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC609C03C1AB;
        Tue, 28 Apr 2020 09:44:29 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 18so9723129pfv.8;
        Tue, 28 Apr 2020 09:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yg7QBJnhxZywCJE1FgiVcqq7iVH+KxcrQ4qH330m850=;
        b=ZikGz310giMar93vFuNzoRG4iT6yjubj/76B3lQbaQKBwtJo46ayookYlCRGF74XFA
         uUpCzhbvOnYbZBts5/w55pwufmVEsLpTJAOhikarc573fRNRH2kCGNbMrkL39lHgjJFV
         PcMjEYKyTEqpq2lGoN1gPFpoyJ8gvJza13Nrc3i2y3/lCgGkz8YEGPcA0mZm05oCqAXp
         afVPGgu5WMXxfU+ZM+km6okn9f+Xm7O+UrhqsQpGN+wnik4ThTv8FPW2B1W5CS7CJ50E
         bIYDL9R4zHgzdmjnnLO+H5YhFIVQWsEdPxFTZjIQxMNQfHsqgqd6VCPAtDLuUF6vHJSw
         xUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yg7QBJnhxZywCJE1FgiVcqq7iVH+KxcrQ4qH330m850=;
        b=rL+Z5/E955rDyUk8VWWg7lVmDFbI7cdqLuLNfNX6j461EWu54wIQ61UvrcJviAVZ6W
         3P+wPhRjsYMOPQOGsfW+bQAnoWw3GKIyIG+mK/57NzKS/5kLWDFgGOia5QtAuLhX58QR
         TovWvWyGqj2nlcESna23G9ytUPzsIhfez+9r1jVm87m69EJopVLPiuTFxDJqidph2T3a
         wnb0sWYcYlO10Prnt0bw45dR+gPahpbAa2/Mudf4GReeFGkwEIBe9iRB1mQkjen5YgBq
         EJ8HDr4FHm9JTSB12QBHp+QiSk1gTvgPlIgXLbIdWqfLPKtClD2o+kLHETwciTtu8K7g
         u+jA==
X-Gm-Message-State: AGi0PuaH77T+zvFuLmwMIhU1ysigVl0iPH3Hgoa8ibszseOpkrgLwJDG
        IVrx3mt2d45trVg6VnoiHB4=
X-Google-Smtp-Source: APiQypIi7H95uhoBbxuHhbXwFAOM65E2SmWkxACOKRWHUhgSvuUcGklPap9F3G+f3yOoH4VpxP0szw==
X-Received: by 2002:a63:615:: with SMTP id 21mr28286120pgg.22.1588092269366;
        Tue, 28 Apr 2020 09:44:29 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:9061])
        by smtp.gmail.com with ESMTPSA id b75sm2656750pjc.23.2020.04.28.09.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 09:44:28 -0700 (PDT)
Date:   Tue, 28 Apr 2020 09:44:26 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com,
        daniel@iogearbox.net, andrii.nakryiko@gmail.com,
        kernel-team@fb.com, Julia Kartseva <hex@fb.com>
Subject: Re: [PATCH bpf-next 2/6] selftests/bpf: add test_progs-asan flavor
 with AddressSantizer
Message-ID: <20200428164426.xkznwzd3blub2rol@ast-mbp.dhcp.thefacebook.com>
References: <20200428044628.3772114-1-andriin@fb.com>
 <20200428044628.3772114-3-andriin@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428044628.3772114-3-andriin@fb.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 27, 2020 at 09:46:24PM -0700, Andrii Nakryiko wrote:
> Add another flavor of test_progs that is compiled and run with
> AddressSanitizer and LeakSanitizer. This allows to find potential memory
> correction bugs and memory leaks. Due to sometimes not trivial requirements on
> the environment, this is (for now) done as a separate flavor, not by default.
> Eventually I hope to enable it by default.
> 
> To run ./test_progs-asan successfully, you need to have libasan installed in
> the system, where version of the package depends on GCC version you have.
> E.g., GCC8 needs libasan5, while GCC7 uses libasan4.
> 
> For CentOS 7, to build everything successfully one would need to:
>   $ sudo yum install devtoolset-8-gcc devtoolset-libasan-devel
> 
> For Arch Linux to run selftests, one would need to install gcc-libs package to
> get libasan.so.5:
>   $ sudo pacman -S gcc-libs
> 
> Cc: Julia Kartseva <hex@fb.com>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

It needs a feature check.
selftest shouldn't be forcing asan on everyone.
Even after I did:
sudo yum install devtoolset-8-libasan-devel
it still failed to build:
  BINARY   test_progs-asan
/opt/rh/devtoolset-9/root/usr/libexec/gcc/x86_64-redhat-linux/9/ld: cannot find libasan_preinit.o: No such file or directory
/opt/rh/devtoolset-9/root/usr/libexec/gcc/x86_64-redhat-linux/9/ld: cannot find -lasan

Also I really don't like that skeletons are now built three times for now good reason
  GEN-SKEL [test_progs-asan] test_stack_map.skel.h
  GEN-SKEL [test_progs-asan] test_core_reloc_nesting.skel.h
default vs no_alu32 makes sense. They are different bpf.o files and different skeletons,
but for asan there is no such need.

Please resubmit the rest of the patches, since asan isn't a prerequisite.

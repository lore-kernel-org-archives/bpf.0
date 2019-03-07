Return-Path: <SRS0=xp9Q=RK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9F0C43381
	for <bpf@archiver.kernel.org>; Thu,  7 Mar 2019 01:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0216020675
	for <bpf@archiver.kernel.org>; Thu,  7 Mar 2019 01:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cg/sVXlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfCGBDV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 6 Mar 2019 20:03:21 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:37292 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfCGBDV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Mar 2019 20:03:21 -0500
Received: by mail-it1-f193.google.com with SMTP id z124so13237845itc.2;
        Wed, 06 Mar 2019 17:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SyyXlWhMiAcInpSWzqYN3eeSlivANhBP5R3uQK1j5W4=;
        b=Cg/sVXlKfxo6i2bp8xr9HvzrxLz7cA6nSFhttmdubD3n5VvOWxuxEuTsJeqaMNCbp1
         hWdVEphXJChI5hA9usMdEAcDFzYh3vgsva7PRCR/j6c5sFkOVO/ElF5+Q5uLBcJeSKYE
         liSe2383Ve/19x61agBoKiQbiGZRb3qCuC+Pv4wwHOEtc8els6rZA0M0z+W+lyHDhR1Q
         6vjacWKLZnKyT/9BY6zs2Dm1X0LzOZigcLIvitUfYpoB85SdZGy98HM8LluWuf8dqmkG
         eTbx158AXtG/FgQi5p6RC5Ij4Nkwnqx3Gd80u5LyVZTtfpgHFO3y7FhzsPOmzobPYdha
         dlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SyyXlWhMiAcInpSWzqYN3eeSlivANhBP5R3uQK1j5W4=;
        b=Ehq+mb/K7SIvGxTjiuo6FR8iwUJVPal+MvsNk+R4Zlmuc+SKg0Lf857aTetVMtXsyz
         97smVsd9xIsMnCZWMpmYvHPP96OTMrMe7MpXk9gmwTUDZRJ+fKIDSu6yu5wKozXTs5zO
         UB20kZt1Iyr/4INTIl6ua+zcPTICITrm+GU+Qa4zyz5j/Di7PWQMYq34BAavgAbTLb8P
         YOaXfAlpJ9fTey3tCEZ7RknrjAcVq1QUU28YZyhN15W8UnSffuLKHgV7GOfbsrTe3wpG
         gb+XKJD+u406LoY5IRyuktRIj01T1XCMMxGwSfhGy3Es2ABc9Il1NKkhGzKqsxVCLXrU
         aztw==
X-Gm-Message-State: APjAAAWe2EmtnYJnjFbuQnB11IlODoLIiSpdiHlPdbaHB8MSK+MD2YWH
        hc/9rxhKfXOGR/pspXSJ+fPZ2U72bbafXLD4iO0=
X-Google-Smtp-Source: APXvYqz76hyb5n/KhMfbobT3gxDSqiqT7HkNFlvjUanmYFcrOdzuaqi9JwC0oY4BSBUz87vRpa1GKFfIhkABVhuoeTQ=
X-Received: by 2002:a24:2f05:: with SMTP id j5mr3479393itj.156.1551920600305;
 Wed, 06 Mar 2019 17:03:20 -0800 (PST)
MIME-Version: 1.0
References: <20190306195927.208503-1-sdf@google.com>
In-Reply-To: <20190306195927.208503-1-sdf@google.com>
From:   Y Song <ys114321@gmail.com>
Date:   Wed, 6 Mar 2019 17:02:44 -0800
Message-ID: <CAH3MdRWieJapBvXQGMRtvUSJtvNAST+x4XsdUMpjUK4ncYgXeA@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] selftests: bpf: fix compilation with out-of-tree $(OUTPUT)
To:     Stanislav Fomichev <sdf@google.com>
Cc:     netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 6, 2019 at 1:14 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> A bunch of related changes lumped together:
> * Create prog_tests and verifier output directories; these don't exist with
>   out-of-tree $(OUTPUT)
> * Add missing -I (via separate TEST_{PROGS,VERIFIER}_CFLAGS) for the main tree
>   ($(PWD) != $(OUTPUT) for out-of-tree)
> * Add libbpf.a dependency for test_progs_32 (parallel make fails otherwise)
> * Add missing "; \" after "cd" when generating test.h headers
>
> Tested by:
> $ alias m="make -s -j$(nproc)"
> $ m -C tools/testing/selftests/bpf/ clean
> $ m -C tools/lib/bpf/ clean
> $ rm -rf xxx; mkdir xxx; m -C tools/testing/selftests/bpf/ OUTPUT=$PWD/xxx
> $ m -C tools/testing/selftests/bpf/
>
> Fixes: 3f30658830f3 ("selftests: bpf: break up test_progs - preparations")
> Fixes: 2dfb40121ee8 ("selftests: bpf: prepare for break up of verifier tests")
> Fixes: 3ef84346c561 ("selftests: bpf: makefile support sub-register code-gen test mode")
>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
Acked-by: Yonghong Song <yhs@fb.com>

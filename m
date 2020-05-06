Return-Path: <SRS0=COpY=6U=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64DDC47257
	for <bpf@archiver.kernel.org>; Wed,  6 May 2020 17:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A6F721744
	for <bpf@archiver.kernel.org>; Wed,  6 May 2020 17:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588787537;
	bh=cXyxMf1Eb6Do/xWY/gsssZYFY7/P9CB2JNPGLKs1Lbg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vDAzZ822V28njVxcUppuJdT6OJpfTGzF4p0vJyVUnHYxFlN74VkiERXC4aJXWIGlr
	 eqwpBCY5s6dTgP8Ymh+vvx+acGk5T9QSHe3E7O3GxgF1FnNqD3LYLBEzZ/4EHJ2LSB
	 rbibnSfM7BrUFPKl2tzkUkxKoM7QnXpl9k4/7XRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729886AbgEFRwO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 6 May 2020 13:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729749AbgEFRwN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 May 2020 13:52:13 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2818C0610D5
        for <bpf@vger.kernel.org>; Wed,  6 May 2020 10:52:12 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id u4so2088430lfm.7
        for <bpf@vger.kernel.org>; Wed, 06 May 2020 10:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3iDM/PlD1cl2Emprrc8UkVlx+lvpjZ6KITj+kMZS4vU=;
        b=Onj6RpBSdppxiHflDIfnU8/+fh2nF8mikY4k8DOvMwZvX/ZFfIXNMSG/+sP3oK2sr9
         mIhcfJjCn3ECmIQwwRaGtud3qgvzJv+DPfXc8ePIDpNWfdp4Yhjfmi+BT3ywIKw7jV7e
         fK1DuRTDXTp/q9VjTTMWhXsXHEy4B8ih7FSH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3iDM/PlD1cl2Emprrc8UkVlx+lvpjZ6KITj+kMZS4vU=;
        b=OmTB7pHGdLB+4LC5z9ihe2m9wlAz7pFMHlU7DcrIn3wvGuihBNTD+M6QZ3027AP8sE
         z34JAPCPZQeWmoEqMYzmLZ5qPqtA7hbsMzRK6hFMlFS7xu97V6HvUsAhEhxxtKk+Eln2
         8h6N2EHdm+SlkrGfL8fUhaFqhZFL2CrqSHr8s3b+bYmUBWaOqLuks+k6GoyAY4kI3pHs
         5zwVNhvCGktShtjyve3wSpRTqxQaQTD7qwtQeUdNeHb7s3ukkz3CPbGwz0Ji+9hBm/dE
         QNtLK+38MsiIUMcp9k4hMO2HC5Fg/yeXxaXH3F2nb/+ImwRGkFV5vt2ciOuBeGEiqrNy
         Q6dg==
X-Gm-Message-State: AGi0PuZdrFlTTlQmNfJgaQ6SzMiJc+0vQyr6cNi/quFuP7sPf9rx8AsP
        0e9QGajSWd/0rUOZnmtD9Ycu9lqHRuo=
X-Google-Smtp-Source: APiQypIDHH45Gw1lqsYBRNu/uctgmMotUY9kFNKxRXoX/n+5u4Wn8H2Hq+t3Gz3Fff8Ctsgn/VlsDQ==
X-Received: by 2002:ac2:5199:: with SMTP id u25mr3161476lfi.80.1588787529758;
        Wed, 06 May 2020 10:52:09 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id y129sm2141915lfc.23.2020.05.06.10.52.08
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 10:52:08 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id j3so3321399ljg.8
        for <bpf@vger.kernel.org>; Wed, 06 May 2020 10:52:08 -0700 (PDT)
X-Received: by 2002:a2e:8512:: with SMTP id j18mr5893926lji.201.1588787527821;
 Wed, 06 May 2020 10:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200506062223.30032-1-hch@lst.de> <20200506062223.30032-16-hch@lst.de>
In-Reply-To: <20200506062223.30032-16-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 6 May 2020 10:51:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi6E5z_aKr9NX+QcEJqJvSyrDbO3ypPugxstcPV5EPSMQ@mail.gmail.com>
Message-ID: <CAHk-=wi6E5z_aKr9NX+QcEJqJvSyrDbO3ypPugxstcPV5EPSMQ@mail.gmail.com>
Subject: Re: [PATCH 15/15] x86: use non-set_fs based maccess routines
To:     Christoph Hellwig <hch@lst.de>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-parisc@vger.kernel.org,
        linux-um <linux-um@lists.infradead.org>,
        Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 5, 2020 at 11:23 PM Christoph Hellwig <hch@lst.de> wrote:
>
> +#define arch_kernel_read(dst, src, type, err_label)                    \
> +       __get_user_size(*((type *)dst), (__force type __user *)src,     \
> +                       sizeof(type), __kr_err);                        \
..
> +#define arch_kernel_write(dst, src, type, err_label)                   \
> +       __put_user_size(*((type *)(src)), (__force type __user *)(dst), \
> +                       sizeof(type), err_label)

My private tree no longer has those __get/put_user_size() things,
because "unsafe_get/put_user()" is the only thing that remains with my
conversion to asm goto.

And we're actively trying to get rid of the whole __get_user() mess.
Admittedly "__get_user_size()" is just the internal helper that
doesn't have the problem, but it really is an internal helper for a
legacy operation, and the new op that uses it is that
"unsafe_get_user()".

Also, because you use __get_user_size(), you then have to duplicate
the error handling logic that we already have in unsafe_get_user().

IOW - is there some reason why you didn't just make these use
"unsafe_get/put_user()" directly, and avoid both of those issues?

              Linus

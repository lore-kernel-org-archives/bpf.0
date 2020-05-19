Return-Path: <SRS0=8tVf=7B=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66FDC433E0
	for <bpf@archiver.kernel.org>; Tue, 19 May 2020 16:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EB1D207C4
	for <bpf@archiver.kernel.org>; Tue, 19 May 2020 16:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589906116;
	bh=k5cskPiRg2azYZesiHKpC+Uxfv5dSMfvTZXTYNV3j1o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GlZ2gOGvIX5yj25ErAg5QZIJPpv0a2nBD/NNpGGAAqbpcIeQuNm5aJz+/J31lmSsA
	 RNBaXebCXy35eoWXzmDjSb4gZGXTsZR/bzju30UoofijX8rrhoDupXvcQNkPr8HSE5
	 WYBZa46pV+PCnKWpFLIgLT54FVWhsOAcDZLsR/IQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgESQfL (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 May 2020 12:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729233AbgESQfL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 May 2020 12:35:11 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B80C08C5C3
        for <bpf@vger.kernel.org>; Tue, 19 May 2020 09:35:10 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id q2so384066ljm.10
        for <bpf@vger.kernel.org>; Tue, 19 May 2020 09:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=54tiBIP0EU7n2aZj7YIONdjaPqjtzHIpQK/HSrYUxTM=;
        b=BKlafAkH7UQm8tvxZZNMBXFgkeIFjR+sjrqKcA5zu8XfgLo2XsHzCIggLB+hau5PqY
         bXm4UtHx7/hgToK6wSRtXVRYfkosw2PzhwIv8qXaSb+oYyfc0spNrlQZmy04cFyxd8aX
         2/kuksBERD9XsYiDJcDnbRjB+/bFhGsJeMkcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=54tiBIP0EU7n2aZj7YIONdjaPqjtzHIpQK/HSrYUxTM=;
        b=SVRiFY8bwYo7z73TmYrkxN+AJmyF4+2ydJZ1lgMdqAQIJ6HYvU5DCgJJ0qYmf6PbJY
         8mu283wlaqB4to8NDuZVPAValDapTvIRRubE2of0SP7WhFi5fkF243WX9bbdMQfH4H7b
         TWqgx0Kh0JvmLFbyFF5h1/mkife9rIzLCm4rKAefOtPKlkjw5w0SqGGye60dmIRBa7Cx
         lOId7AIOIExxvWcCzjFYB5Qd71vCDvcwZkRQ7Bm+p//SDrQ6zPqZ+q2c7KpGXqRuHtx9
         ndGBqLRc5AkW7i+RMHzrG4V0NwEhMPqfNl4+9i7A+uavfSx0bT1nLnQ6cfcBolJIiuJO
         3bEQ==
X-Gm-Message-State: AOAM530YcZ/wrSoUk70ZySc4m5RofzdB5t0jkdFWJ/9uO/MBTXg3qoNb
        N4RW0Wz9rA0jv9D8qt9HuZ7AHLtmTsU=
X-Google-Smtp-Source: ABdhPJyWW/MX1QsRCFCCdgfUsCMPU/1fTDmltQiDPxUpAzktC3tEgvpBSY1hVUZ8xkkBA7TEyWctCA==
X-Received: by 2002:a2e:9b48:: with SMTP id o8mr175146ljj.130.1589906107817;
        Tue, 19 May 2020 09:35:07 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id s28sm1170847lfs.3.2020.05.19.09.35.06
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 09:35:06 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id h26so64959lfg.6
        for <bpf@vger.kernel.org>; Tue, 19 May 2020 09:35:06 -0700 (PDT)
X-Received: by 2002:ac2:5a4c:: with SMTP id r12mr1549357lfn.10.1589906105818;
 Tue, 19 May 2020 09:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200519134449.1466624-1-hch@lst.de>
In-Reply-To: <20200519134449.1466624-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 May 2020 09:34:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=whj0zVP-ErHcqGNrM0-bZ+TvSFAwpEd+pKFadZeFXj5PA@mail.gmail.com>
Message-ID: <CAHk-=whj0zVP-ErHcqGNrM0-bZ+TvSFAwpEd+pKFadZeFXj5PA@mail.gmail.com>
Subject: Re: clean up and streamline probe_kernel_* and friends v3
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

On Tue, May 19, 2020 at 6:44 AM Christoph Hellwig <hch@lst.de> wrote:
>
>  - rebased on 5.7-rc6 with the bpf trace format string changes

Other than the critique about illegible conditionals in the result
when doing that bpf/trace conversion, I like it.

                  Linus

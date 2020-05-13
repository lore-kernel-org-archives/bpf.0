Return-Path: <SRS0=rqwV=64=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46354C433E0
	for <bpf@archiver.kernel.org>; Thu, 14 May 2020 00:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F8E92065C
	for <bpf@archiver.kernel.org>; Thu, 14 May 2020 00:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589414401;
	bh=4WYyMaGWG9a9nFYDIlkg8Bpp7B8l0nT3fSfWhGSXUN0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OnhWWTjl/C+hVLnASh1Ko9DGqSA7kT+PwaBC/Z/7OJR5QWuhzNrnA4yf5RyJJ+Wdh
	 paoXYRId0LDQALAB5Y/s+SbfzuZUYYddUzG38+sxJlnpo+DiEl/M3hsqdYZCU9PxeJ
	 V0HJzti2nSFApGAhBxAyZ1k9gWGzPegEQfNZ/9Jc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732862AbgENAAA (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 13 May 2020 20:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732456AbgENAAA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 May 2020 20:00:00 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E20C061A0C
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 16:59:59 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id g4so1548245ljl.2
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 16:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fasYih196bvKUHb0YCxHna3fp2u2qNy7HWnYHVsQ+sQ=;
        b=fD3hyHvKHx/67q1VTFKCR74zDcE6394aAhGXhl0a0C48TMMb4AnhPQvs7IdErH6CX2
         um+ec95QL1F0EfXLmER3SmoJ0T+gygc4SnxysABRELnzBjVWudgYOLaUmLBf8bjna0/G
         B5XXX5vTTIkGXj8ZYK86YltWbiai+htzLW22s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fasYih196bvKUHb0YCxHna3fp2u2qNy7HWnYHVsQ+sQ=;
        b=qgLA21X7y2Vk7sBJG4xdMlaRaaRUhkOOC5YP06ttuI0+XWoR+sTmZgsbhX6AnIdCNz
         BtXo3+LtH91hGg+Yea481KOGiJeLYxwSCTyq7q6Oa4Cm445gKK1y65k5KAxKLE9PHJna
         29Vmj1NNCNJZtmjpV8xHRrpbO4JuBIJ1ynlq0grahw7Pc7f7IxbkRcc5xW5MyiBzRo12
         Fx1bVesjaLkJlC2xdNNeNtiGk9yEtRM+qAzLniZuEg6CpO6XaJV1BcUaWrKlWEdQ9JIS
         gwdx3yNfV/FsGXav+23TB6vWOYUT9WeQYir3rALkpB8XcOFafykQEEiU1gOdqWPFxu66
         jyTw==
X-Gm-Message-State: AOAM533gbz5uJxUQMOXqCy524w6fRb4O2gF7mhnyLfYBBmHl8mAdA5XS
        ZAHpyNKQBzqa3fHA83PLtyBU/R06PkI=
X-Google-Smtp-Source: ABdhPJyv6VdQ5rHobDQZmghKnKB9Lh3Kx5YjVEKiAU/9rvmO7hXxYtD2QxrYvFB4W+MkgV/czhbgBg==
X-Received: by 2002:a2e:954b:: with SMTP id t11mr935658ljh.98.1589414397681;
        Wed, 13 May 2020 16:59:57 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id r19sm485606ljp.68.2020.05.13.16.59.56
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 16:59:56 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id u15so1542613ljd.3
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 16:59:56 -0700 (PDT)
X-Received: by 2002:a05:651c:319:: with SMTP id a25mr857486ljp.209.1589414396039;
 Wed, 13 May 2020 16:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200513160038.2482415-1-hch@lst.de> <20200513160038.2482415-12-hch@lst.de>
 <CAHk-=wj=u+nttmd1huNES2U=9nePtmk7WgR8cMLCYS8wc=rhdA@mail.gmail.com>
 <20200513192804.GA30751@lst.de> <0c1a7066-b269-9695-b94a-bb5f4f20ebd8@iogearbox.net>
 <20200514082054.f817721ce196f134e6820644@kernel.org>
In-Reply-To: <20200514082054.f817721ce196f134e6820644@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 May 2020 16:59:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjBKGLyf1d53GwfUTZiK_XPdujwh+u2XSpD2HWRV01Afw@mail.gmail.com>
Message-ID: <CAHk-=wjBKGLyf1d53GwfUTZiK_XPdujwh+u2XSpD2HWRV01Afw@mail.gmail.com>
Subject: Re: [PATCH 11/18] maccess: remove strncpy_from_unsafe
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Christoph Hellwig <hch@lst.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
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

On Wed, May 13, 2020 at 4:21 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
>
> For trace_kprobe.c current order (kernel -> user fallback) is preferred
> because it has another function dedicated for user memory.

Well, then it should just use the "strict" kernel-only one for the
non-user memory.

But yes, if there are legacy interfaces, then we might want to say
"these continue to work for the legacy case on platforms where we can
tell which kind of pointer it is from the bit pattern".

But we should likely at least disallow it entirely on platforms where
we really can't - or pick one hardcoded choice. On sparc, you really
_have_ to specify one or the other.

                  Linus

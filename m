Return-Path: <SRS0=EAyC=ZA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBA1FC6195
	for <bpf@archiver.kernel.org>; Fri,  8 Nov 2019 19:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5052087E
	for <bpf@archiver.kernel.org>; Fri,  8 Nov 2019 19:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMoZuaIT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbfKHT1n (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:27:43 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:41074 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730416AbfKHT1n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Nov 2019 14:27:43 -0500
Received: by mail-qv1-f67.google.com with SMTP id g18so2651522qvp.8;
        Fri, 08 Nov 2019 11:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YCiFfwAsz3jI8QyUmFetebDnkj3FB//ysWJ3FbuOHfI=;
        b=HMoZuaITpmBVwBjMnL1RbLZw8dHsiSkzusLbl+wR/w1JJ1bMb8f25s+RH5xryV7pXA
         RLiOO86li4Qcd5Vzsw7tFHzvAIfwvhU3+NSGEOY1e9fKMMY9j1Fz4Xg9rLmWqGINLqzP
         auBoatSkAwMWpBJ5UJz5T2jkpkqqYM614aGQ5ry+M8R7+Qf1l2s00WpEPtAh9GsiqLOO
         0FalMvbLcxMH62Qe4dP1gtgSR9iBkfUF8OUxwQW+H3dQMFbhNgW2gmb0tkEgFl0BYJRw
         0qdbOuDsmdemN8z6PYFYkmwsogcwlPzCyeJiJEEM/ZF/ln0GXlhy8/e7K7eE1d+BqhwU
         6x5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YCiFfwAsz3jI8QyUmFetebDnkj3FB//ysWJ3FbuOHfI=;
        b=PTFNDKT+8SMSE1uMV82r/l1g4j/pNdTSZTQmkrjt7ebD2EjQSYSqpoAR4s6kmTDOd/
         GZ3S1R5KOicHcBNzhFDIW321udAce7y+V51ps7juBlx5sbU1oYkBx/3asU8yPe9aWYT3
         H7LO3pJJXHhJI7yW5SliT4MEbn5Q89Ts3/EZanxSoL304AtB+OY8zJl0GYVfRvFjpoBs
         xx4klo+QfDEpatXQ8XNraG1RcVZcd7QSSHgVkjEVmtckQ1OCHBRlNxeP7oFT1L4pGxBI
         SCRm9z/n2csvreJkVzwfimkKes7QzRvG1ac+F5kWhuJTEP/TNARDMw7GmICSNYdb7Dzm
         cOLA==
X-Gm-Message-State: APjAAAXNCe86Aw/zT7Tu+3N3+X213L8QzUix+AEBf1MAP+OIBt+SlNU9
        Hiq112Iy8uF51sxTDJPGKR39nNoprNCZ/vou7H4=
X-Google-Smtp-Source: APXvYqy/svYn4S0z5xspKA5NuNmR2iSLKRR9smk69KmIhEOG3GpQrn54/nx9pSFF9N7yWcQchN6n4pbECLQqFiJ8w0k=
X-Received: by 2002:ad4:558e:: with SMTP id e14mr10831334qvx.247.1573241261775;
 Fri, 08 Nov 2019 11:27:41 -0800 (PST)
MIME-Version: 1.0
References: <20191108064039.2041889-1-ast@kernel.org> <20191108064039.2041889-2-ast@kernel.org>
In-Reply-To: <20191108064039.2041889-2-ast@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Nov 2019 11:27:30 -0800
Message-ID: <CAEf4BzZFh9ZhS3EPCH7EPN1fb17jr7zCO15XGfi-rcU4wWJ_OA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 01/18] bpf: refactor x86 JIT into helpers
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>, x86@kernel.org,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 7, 2019 at 10:41 PM Alexei Starovoitov <ast@kernel.org> wrote:
>
> Refactor x86 JITing of LDX, STX, CALL instructions into separate helper
> functions.  No functional changes in LDX and STX helpers.  There is a minor
> change in CALL helper. It will populate target address correctly on the first
> pass of JIT instead of second pass. That won't reduce total number of JIT
> passes though.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Acked-by: Song Liu <songliubraving@fb.com>
> ---

Nice, logic is cleaner without extra gotos now, thanks!

Acked-by: Andrii Nakryiko <andriin@fb.com>

[...]

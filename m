Return-Path: <SRS0=rg0W=2C=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B90FC43603
	for <bpf@archiver.kernel.org>; Thu, 12 Dec 2019 00:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00102073B
	for <bpf@archiver.kernel.org>; Thu, 12 Dec 2019 00:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UM0eWWzl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfLLAOp (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 11 Dec 2019 19:14:45 -0500
Received: from mail-lj1-f181.google.com ([209.85.208.181]:42845 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbfLLAOp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Dec 2019 19:14:45 -0500
Received: by mail-lj1-f181.google.com with SMTP id e28so166256ljo.9;
        Wed, 11 Dec 2019 16:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vQQCMyoIjB+Fd2siIByi9VJ6nmwCdg3rPiP/NV6Kw/8=;
        b=UM0eWWzlvrh3AoDZn/jNkqqbzP8tTMenSmZyboh79fUZpR82dWF+a4qa6sbgb3awzh
         S+MpUUZagZ2fCla85Q2W65u4tObAxTrMvp55UcJOXt+jtjbLLxsc2eJwxtW0P12M7eP3
         +aflcLiPSZKNkIejJz40OLjLKwShB242+q2osEODWCF5fv74qQq3Nixc6LMiZR94/iDr
         fU2wxVwVvq1XxxI8SmHV1Z2Pevj+PxTjqFfFb/yB/SnThM8/nQ4QKkPCoVYQn1x1bzBE
         Y9zGDw9MLVQY1mJE+Sc7gaKOpJlwBfwI/ZXvXLQ93vxCuTunTDEPpkxtHIo7fScxjHUK
         Fwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vQQCMyoIjB+Fd2siIByi9VJ6nmwCdg3rPiP/NV6Kw/8=;
        b=kkBMyz8FYodg63D2wZeVZoWEu6r5ip7t1glf/p5ZC4JRK5ahMOO9DxGR2xwPYxwYag
         08XRBmGHoahlGmOFrJY6no4LksgFcZc3CGphSP2AnZtPy0beUICcvl8IAoYk8XbwBLL5
         98z74di30CJvk4j4NGmVkjkiYPBc+uFHhULlC7pFj5CKBSKWXgsBc4z4UWkHmds/J+t1
         /hURi//xzv4kyIU6j5ud/JlCMjmwLU9P56ks1NxPfDTa6Ms/FUBFo/b+ppiYWPSjJeT/
         am2cpOj8/ysx+tyO5lZyJRFcn22OgBsOJD7dbkutSSQGadNods8+dcy9ffkPZHU/fcRD
         IazQ==
X-Gm-Message-State: APjAAAWrxbmN66dOUkVLOk8jg+Qk9J4eShukHu/CsVkKo+uHOHtVheOJ
        btb26AepPcppJdK13iZoxlZL3cDL5ECEjK0V7GV8cg==
X-Google-Smtp-Source: APXvYqxRsonRoBCJtslI2Q9jjpATXiGbzhho41eRWoAXFtmXkTKqHMPj7zEeufMJsYSG3sAKyt/dLNcoZiQ+ifgZQCY=
X-Received: by 2002:a2e:3609:: with SMTP id d9mr3964063lja.188.1576109682909;
 Wed, 11 Dec 2019 16:14:42 -0800 (PST)
MIME-Version: 1.0
References: <20191205080114.19766-1-danieltimlee@gmail.com>
In-Reply-To: <20191205080114.19766-1-danieltimlee@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 11 Dec 2019 16:14:31 -0800
Message-ID: <CAADnVQKM5ddHhCG9FAMZaJ-4Xv8QQviPoBOh05fo47JJHw9-LA@mail.gmail.com>
Subject: Re: [PATCH,bpf-next v2 0/2] Fix broken samples due to symbol mismatch
To:     "Daniel T. Lee" <danieltimlee@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 5, 2019 at 12:01 AM Daniel T. Lee <danieltimlee@gmail.com> wrote:
>
> Currently, there are broken samples due to symbol mismatch (missing or
> unused symbols). For example, the function open() calls the syscall
> 'sys_openat' instead of 'sys_open'. And there are no exact symbols such
> as 'sys_read' or 'sys_write' under kallsyms, instead the symbols have
> prefixes. And these error leads to broke of samples.
>
> This Patchset fixes the problem by changing the symbol match.
>
> Changes in v2:
>  - remove redundant casting

Applied to bpf tree. Thanks

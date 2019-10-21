Return-Path: <SRS0=mFv6=YO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9302CA9EAF
	for <bpf@archiver.kernel.org>; Mon, 21 Oct 2019 19:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA8820873
	for <bpf@archiver.kernel.org>; Mon, 21 Oct 2019 19:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XSrQi1vI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbfJUTBw (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 21 Oct 2019 15:01:52 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42706 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbfJUTBv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Oct 2019 15:01:51 -0400
Received: by mail-lf1-f67.google.com with SMTP id z12so10989235lfj.9
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2019 12:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=PLOcZ03vS2EwYkFJj8DRoXWrjJmTGUnZtnTzndssys4=;
        b=XSrQi1vIm6ZFvXVRDwjxjlYFZBuGk6dczFvD8d2rnmL8q8A5UYHDLKiCZQ2Llm4fIM
         d9nFK/VVOyJKOa1ZRlqnOgXlUme68evtUG2Eq20ZqfZ9N3RQOnDdyi0Gla3vcDlC7IzV
         6ojlHpjsTyElAC3AovaNCWMxCdTw+UsHzERuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=PLOcZ03vS2EwYkFJj8DRoXWrjJmTGUnZtnTzndssys4=;
        b=o3oQz/SUz5saMtiee96KfiSoDxgo33HFjK1fVLBqdgZnCWbuP60i7/uau+UECNtGpo
         9t+NVfmkITmplN4yo9wnEm1y6GVhGslEc/TZXFcIEJZOisGb8wqyuyILkeuxlswBp9uu
         fmDWMmL5jRHIn5GyA3uWSX0OGk+44jSz4GizP0K24LpF5c6UBG3+u0TUGZANgwmRj/DW
         rOWDCrwKXaBtbVlluoAhHMWizjBD2iKPdQApv9RNpggLArrLY5Fh+46+Sqlo2P/+g3eH
         ZHvCRj5Qt2duU1d+kCNJgfbGgq+wsIklPkG1Bs4BDdOOpwYEFWzYdRu5yCnpWVEgQG1J
         ngow==
X-Gm-Message-State: APjAAAWj/BYwOxE/gDWBrSDNOLHUUd8NAL8uDIKAnLn9aHhEV8sU3B+N
        okkOHi10lJV7iq4d0poGZDVFQQ==
X-Google-Smtp-Source: APXvYqzA4yZnkeOQZqaobJL8WRSpadsYX3l+ahOhwgyEZK7fcdaoJbDqbV7TVda5soiN2pat/pzsVQ==
X-Received: by 2002:ac2:55b4:: with SMTP id y20mr16013272lfg.173.1571684508959;
        Mon, 21 Oct 2019 12:01:48 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id q16sm6847947lfb.74.2019.10.21.12.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 12:01:48 -0700 (PDT)
References: <20191021165744.2116648-1-andriin@fb.com>
User-agent: mu4e 1.1.0; emacs 26.1
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com,
        daniel@iogearbox.net, andrii.nakryiko@gmail.com, kernel-team@fb.com
Subject: Re: [PATCH bpf-next] libbpf: make LIBBPF_OPTS macro strictly a variable declaration
In-reply-to: <20191021165744.2116648-1-andriin@fb.com>
Date:   Mon, 21 Oct 2019 21:01:47 +0200
Message-ID: <87mudtdisk.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 21, 2019 at 06:57 PM CEST, Andrii Nakryiko wrote:
> LIBBPF_OPTS is implemented as a mix of field declaration and memset
> + assignment. This makes it neither variable declaration nor purely
> statements, which is a problem, because you can't mix it with either
> other variable declarations nor other function statements, because C90
> compiler mode emits warning on mixing all that together.
>
> This patch changes LIBBPF_OPTS into a strictly declaration of variable
> and solves this problem, as can be seen in case of bpftool, which
> previously would emit compiler warning, if done this way (LIBBPF_OPTS as
> part of function variables declaration block).
>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---

Just a suggestion - macro helpers like this usually have DECLARE in
their name. At least in the kernel. For instance DECLARE_COMPLETION.

-Jakub

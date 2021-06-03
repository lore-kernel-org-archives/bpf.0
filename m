Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1121C47082
	for <bpf@archiver.kernel.org>; Thu,  3 Jun 2021 18:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD369613EE
	for <bpf@archiver.kernel.org>; Thu,  3 Jun 2021 18:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhFCSDx (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 3 Jun 2021 14:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhFCSDw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Jun 2021 14:03:52 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D3AC061756
        for <bpf@vger.kernel.org>; Thu,  3 Jun 2021 11:01:26 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id m3so8208282lji.12
        for <bpf@vger.kernel.org>; Thu, 03 Jun 2021 11:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=r9MzWZjKPqmlOjFqE3Qrd2asRPZ12yoFNhArngWxvS0=;
        b=a2XVL0xjWzNmMVySfXwLhDZ042VdNWI/mlGbg22MHKi83/dz+Au4Lo1l0YBdZamgam
         xuXSHqdF20ibK57qRQhiaHCMniecGwlNSrpAECIGIhuca36POi8dJrgfjnoDQsLcpnE8
         WV8u/4nABeCFGdVQSoN5V50SiN67XfbEEbGfawVl7t+YsranSPk1XQvB4RDqnZA7TwP7
         tnQQzMiJyCxDEx3mHkbWKd2WXejigs4BFYhvbIbzRGr2LrfqxNR2pTO6ZxJM55srCPUe
         H3rM7iFJDXXB0thuv/XhdcJzXscGTE3sQep+UM6RHGwydrN84z67QddxUTYDXCQXJCaw
         x5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=r9MzWZjKPqmlOjFqE3Qrd2asRPZ12yoFNhArngWxvS0=;
        b=sY2zXOOlDdaPZ9h2UpSy0O4vmn3zIkfhTgyW9jVvfvU/60V942me2DUnTEEa05A4iT
         SRxE0b+azB6q3TLGRNOnAst8WKTVCjwAJQ0vjj9+irMwlEvY84GFTyl/laE7eIIGQoQI
         VRJSazCEL2N/mEJ/HBI4SbnJq/y7T+QBty6eev6Yu37PXfE3kPbTuQUX1pOmDAz+GQwP
         NI6GZEpak173FQFqZU8K57pLZI/9XD1abn1uXgm/ZcOASTf++vx821uioQema1gvGdCQ
         SV/rro2eyXv1wpcdhSoZ/JiwhU+ZXbAtg5tbH6UHeWxcnUBG0NJYF3J+nd6XDDBSAvW7
         Q+Qw==
X-Gm-Message-State: AOAM530729FnNzin/CGBYdhTo89EYSrqDHhiqZFFvTbC8hsh7aSa/lzW
        bl0Gz8PQmeWeIqO4vcEB0X7JVOhw1VaPdqfXmGBpZamFVRY7gZNcrrs=
X-Google-Smtp-Source: ABdhPJw+zfRWfok6+YxbTE26DXE2GMveQA8aBor2Kow6ZPPB1PILI5yW453kZANSzHAWUDf8y8TLuDLDggV6LemRZwU=
X-Received: by 2002:a05:651c:2001:: with SMTP id s1mr406240ljo.173.1622743284940;
 Thu, 03 Jun 2021 11:01:24 -0700 (PDT)
MIME-Version: 1.0
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Thu, 3 Jun 2021 14:01:13 -0400
Message-ID: <CAOWid-drUQKifjPgzQ3MQiKUUrHp5eKOydgSToadW1fNkUME7g@mail.gmail.com>
Subject: Headers for whitelisted kernel functions available to BPF programs
To:     Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I understand that helper functions available to bpf programs are
listed in include/uapi/linux/bpf.h and kernel headers can be made
available at /sys/kernel/kheaders.tar.xz with CONFIG_IKHEADERS.  But
with the support of calling kernel functions from bpf programs, how
would one know which functions are whitelisted?  Are the headers for
these whitelisted functions available via something like "bpftool btf
dump file /sys/kernel/btf/vmlinux format c"?

Regards,
Kenny

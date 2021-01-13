Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF569C433E0
	for <bpf@archiver.kernel.org>; Wed, 13 Jan 2021 19:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C62222DFA
	for <bpf@archiver.kernel.org>; Wed, 13 Jan 2021 19:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbhAMTKF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 13 Jan 2021 14:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbhAMTKE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jan 2021 14:10:04 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1D7C061786
        for <bpf@vger.kernel.org>; Wed, 13 Jan 2021 11:09:24 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id z20so1890121qtq.3
        for <bpf@vger.kernel.org>; Wed, 13 Jan 2021 11:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ShW6W2GfCPol/vtjmzz7VZ0R75AiI9JhfsfmedgtiWE=;
        b=RUfk7azP6WLVQCDqU4kaR3NPFC4wiTNwfR3eqLcH2ir4vUtwMlnecn/axvDpHQS/hY
         fX5aVkseZBI8zk3Glf0wm8CNIGKN84wkpqoK7Mv4xEyyPEzLOdu0jvNrD++ls+REVYI0
         HhFIG/3YBIT717fiUTPS67VpwJqJWRm0WhrSchNICnyo/lAN7lCDcDOTOUSm+8jMCmJ/
         Dv101cKTE9faccrrPSKAzPkDXn6oXmLIrdZCENrTPfewWT0nIcaUiu1t8Bo0JyuP+UF6
         0/77wcm2eiZ0rooDh73nlMb+043ufvq1v3z+HgAXnAHsUXkNfP4mr6DINKjFyrjUJfoO
         JMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ShW6W2GfCPol/vtjmzz7VZ0R75AiI9JhfsfmedgtiWE=;
        b=RHjRJ+o2vphi9XiPgCjYo3OslzGyISxZrFXPADq1InMsc5Fw5tM1wn3DjwppJvZXZY
         AodsVXdaG/7/sdTy0OirWaN2sF2oxL4HDUYT+SwQ31ZJug8/q2BL57gk1txhToihhkKZ
         m9a2HX+OB1Lq310ic8lJLeeFcspPUISjkGxqiucAMuk3cP92NQvQHhjBj2VBFmanHPUD
         1zGdKbEZGZ7wH8IK5ULtmyNj4Vo3x6Pq3C0nhDnADJZYNKyF7Y/s8deVhYBIBUMcDcrk
         gfs7vNNl8+48H8tUiWWTPkTFNmHf9QBR6qpoADHug1kF3/B9Rol3/Em0Uc2iRDN9Ln3X
         tcyw==
X-Gm-Message-State: AOAM531hWwLqmPwpKgfqcNzb8bWWCHD3/ScqA3AGpWJ0B8HZGZovlnQT
        yJp8hL0xhyEaYA6ShmYo3C5YQ2aOtI9NxFsq5+xuHw==
X-Google-Smtp-Source: ABdhPJyjJQr5ynIDR0BDsIxsLYilnz0Ev9UwFzzCAL8BFqz+NTn0b+FHMxob0smNfsGHaCnyr6V+peFhcrXJHqC4fTc=
X-Received: by 2002:ac8:41cf:: with SMTP id o15mr3732276qtm.98.1610564963465;
 Wed, 13 Jan 2021 11:09:23 -0800 (PST)
MIME-Version: 1.0
References: <20210112223847.1915615-1-sdf@google.com> <20210112223847.1915615-3-sdf@google.com>
 <20210113190158.ordxwkywagrrmqpt@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210113190158.ordxwkywagrrmqpt@kafai-mbp.dhcp.thefacebook.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 13 Jan 2021 11:09:12 -0800
Message-ID: <CAKH8qBuxroVphddnqshoB1wzq3yqDA5EjYBCHrESCEW6LOxpXg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 2/4] tools, bpf: add tcp.h to tools/uapi
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 13, 2021 at 11:02 AM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Tue, Jan 12, 2021 at 02:38:45PM -0800, Stanislav Fomichev wrote:
> > Next test is using struct tcp_zerocopy_receive which was added in v4.18.
> Instead of "Next", it is the test in the previous patch.
>
> Instead of having patch 2 fixing patch 1,
> the changes in testing/selftests/bpf/* in patch 1 make more sense
> to merge it with this patch.  With this change, for patch 1 and 2:
Ah, I messed up the ordering. Sure, let's just merge them together, will resend.
Thank you!

> Acked-by: Martin KaFai Lau

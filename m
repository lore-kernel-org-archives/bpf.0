Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1E7C4338F
	for <bpf@archiver.kernel.org>; Sat, 24 Jul 2021 00:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D11D560EB1
	for <bpf@archiver.kernel.org>; Sat, 24 Jul 2021 00:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbhGWXnO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 23 Jul 2021 19:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbhGWXnN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Jul 2021 19:43:13 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BBAC061575;
        Fri, 23 Jul 2021 17:23:45 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id h14so4744259lfv.7;
        Fri, 23 Jul 2021 17:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SYXm/LqphgtbOxvN7aATbnshiaBgzn0wuH/YjWk+EEg=;
        b=UU99xjtOsg0uszSLt9R49AcaflmcP/V18Jayya2PPQpu3/uWYa6s9oYhlsXr6YvX5T
         k9OaAY1K6SdznjYSROK7rlOndOjWQmrAeA2fXeH1bNfmuqkZUspc7UAQYiO5dv/7UkPs
         LuW+28zdqitLJj5KesMrXzVot0fVPlqM4k52UyO21AdC9mgZqtvCJhSKhhzM58kUkuK2
         TVkShFBhF3dZ8HGADFNtnQ9zlD8Iq7715dTptDeiC9AFOo8eTSOY/u3AoMJr6KJ0g6Dy
         Ebcgq6BKWdtGa3zd8J3moB1nS7nHFxi5PhWWxd8/gJrwVyHELUqFyCJJKBClGZ1JbRFp
         rhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SYXm/LqphgtbOxvN7aATbnshiaBgzn0wuH/YjWk+EEg=;
        b=gSFKxK55pawR/45B96XubxBpSZ7kcO0+/45u9+cQoMyk017P5sb906lDoPSV+JTx/R
         MJLOJpPOj90A/O+K17qWauHIXiC+h4VBkztutdEJ8ajh6Nq0JMPFFpX1kV2UngsExA3E
         meYxm9u6dLuhkUNtkPZj7u0ORIWVs/I8RDSrj/ikrbSP9VaJJxrGLQRHP/JHOKkbuXpg
         Il+tqS/T/oEZL4tliGlN1fhMsWn5SrpoSg/rMJUr6LQFRkdGRHMp6srTxTPa8mR8OuWM
         J2egZBJIMEfoNlUaf4ntAvyyPZMH0VPjnWMRBK3psZcY4s1ikYtHxb9M/ocn9kK6qo9h
         7jbw==
X-Gm-Message-State: AOAM530UKzU9dDN9KgbizhZjBdSr6jAH+X0I817FA4DXPR+PnXJeHWRV
        N9eSDg2NP5ZZJ20SIhUP0lihqpGi3R7OoJPYt7Y=
X-Google-Smtp-Source: ABdhPJxmFA5nEkKWwUUkPBYZj8yFalRLY2szHWIhI/oUza/FdTUuHQYpX39zQUhzA1AHWiI2baFOdPWg1nJHPnOCwvo=
X-Received: by 2002:a05:6512:3709:: with SMTP id z9mr4625983lfr.182.1627086223653;
 Fri, 23 Jul 2021 17:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210721000822.40958-1-alexei.starovoitov@gmail.com> <871r7q8hha.fsf@toke.dk>
In-Reply-To: <871r7q8hha.fsf@toke.dk>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 23 Jul 2021 17:23:32 -0700
Message-ID: <CAADnVQL3CSp9NASM-HLEKEuodEfKHjtU7mWDsrhJUCVy3R+V0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] libbpf: Move CO-RE logic into separate file.
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 22, 2021 at 9:02 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Split CO-RE processing logic from libbpf into separate file
> > with an interface that doesn't dependend on libbpf internal details.
> > As the next step relo_core.c will be compiled with libbpf and with the =
kernel.
>
> Interesting! What's the use case for having it in the kernel as well? :)

The main motivation is signed programs, of course.
Also there are other reasons:
- give the verifier precise path to the field in load/store instructions.
Currently it has to guess the field based on integer offset.
That guessing is random in case of a union.
- give the kermel ability to do CO-RE or symbolic field access.
The insn patching is a small part of the bpf_core_apply_relo_insn().
It can be done for x86 and any other archs just as well.
Imagine a true kernel struct randomization.
Not the existing one where gcc plugin does it at build time,
but the one where the kernel randomizes struct cred every single boot.
Or imagine kernel modules that are built once and then can be loaded
and run on a variety of kernels.

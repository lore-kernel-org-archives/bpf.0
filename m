Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F87C6379F
	for <bpf@archiver.kernel.org>; Fri, 13 Jan 2023 23:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjAMXlQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 13 Jan 2023 18:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjAMXlP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 18:41:15 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4868BF19
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 15:41:14 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id v6so12823476ejg.6
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 15:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCAiFRF/C37yJR4XlWKEUSkyju/eFF04qswZ/8cFCzQ=;
        b=OMCgOVTRPWoSAoFXLa+jRKUJUFsNV7T1/Wr00bEXkPZNrgmLRRDME+Twdp9bYhLePE
         vlk01422LRze6L/3S9Z7675TCxJ9WmRolnIH6YstmOVgXuBEl06iveGsJ3pupS9C0JM+
         F1AsS/KwCWOBSg9xLRTGClzILjKq7gCp8tjOR5X1kAK3FfZ9C7eAfZ69wC6/Xs4Gt9Y8
         s78W7EOGRBBxlf4pKBNOihtg1CYN3/rY03wv0KJ6XfhLs0aIyEN7C/qkJbcGSG2BIpoe
         8asSfpMCIlZB/2z6H1srja9qhd2AkjKV+XYyvCbtXXSQbz0tRqU7rtUHOhkz0lvaANOZ
         xleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BCAiFRF/C37yJR4XlWKEUSkyju/eFF04qswZ/8cFCzQ=;
        b=kk5sDOwveLz2AiJrioBaHLzZuSUidAVNn7+Ax9E0OAuDABIrMmTgSzSo0FEt1MCbFT
         npvbVDMiwe100VZ+dG+oL2JSiIaHC0+HCYGowbh39+3kzcQ1arBaJFpD75xGzMA+rmr1
         AwWua04XfXGhD/o/eLeU9joer3SVM4srHeQl9xM3IzJAPjZy7MCwZ6kKYBsuAENb1FgD
         JuNfdp3wAIQ2MaTOY9Ov+OyUpjP9W8xU5Gom9ISrQoGrnVrJGJJ56qbLhIUwimLJQf7Q
         b6NkIIIbXZ3LVoJUh2XLNqNciY0awGoABecYq9kREY25VcYn9QL/5p8QqbyHp7rel/7h
         Xn+A==
X-Gm-Message-State: AFqh2koSmeRY54jDCfzhJBejvkcxFwT1HFA7m5mfygjXT31//cuZpDj4
        JXQyLMB8coULEKgAI+n9gbccix0MyEVrzU/Dzhk=
X-Google-Smtp-Source: AMrXdXuj8rxk7EKzPKl4N8/moAYYLxaNSM8cIlp4OrHNSkQfSDOu4Gpd1gGyIW6RD8cZWNoDjQbxOalTrCbTDCtkkOU=
X-Received: by 2002:a17:906:2ccc:b0:7f3:3b2:314f with SMTP id
 r12-20020a1709062ccc00b007f303b2314fmr6559497ejr.115.1673653272567; Fri, 13
 Jan 2023 15:41:12 -0800 (PST)
MIME-Version: 1.0
References: <CA+khW7ju-gewZVNxopBi3Uvhiv8Wb=a-D4gaW3MD-NkUg0WSSg@mail.gmail.com>
In-Reply-To: <CA+khW7ju-gewZVNxopBi3Uvhiv8Wb=a-D4gaW3MD-NkUg0WSSg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 13 Jan 2023 15:41:00 -0800
Message-ID: <CAEf4BzYztcahNoFH_CvtWz_1dTA3SSYv+zOorsyP0TfX-2EdaA@mail.gmail.com>
Subject: Re: CORE feature request: support checking field type directly
To:     Hao Luo <haoluo@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 12, 2023 at 2:18 PM Hao Luo <haoluo@google.com> wrote:
>
> Hi all,
>
> Feature request:
>
> To support checking the type of a specific field directly.
>
> Background:
>
> Currently, As far as I know, CORE is able to check a field=E2=80=99s
> existence, offset, size and signedness, but not the field=E2=80=99s type
> directly.
>
> There are changes that convert a field from a scalar type to a struct
> type, without changing the field=E2=80=99s name, offset or size. In that =
case,
> it is currently difficult to use CORE to check such changes. For a
> concrete example,
>
> Commit 94a9717b3c (=E2=80=9Clocking/rwsem: Make rwsem->owner an atomic_lo=
ng_t=E2=80=9D)
>
> Changed the type of rw_semaphore::owner from tast_struct * to
> atomic_long_t. In that change, the field name, offset and size remain
> the same. But the BPF program code used to extract the value is
> different. For the kernel where the field is a pointer, we can write:
>
> sem->owner
>
> While in the kernel where the field is an atomic, we need to write:
>
> sem->owner.counter.
>
> It would be great to be able to check a field=E2=80=99s type directly.
> Probably something like:
>
> #include =E2=80=9Cvmlinux.h=E2=80=9D
>
> struct rw_semaphore__old {
>         struct task_struct *owner;
> };
>
> struct rw_semaphore__new {
>         atomic_long_t owner;
> };
>
> u64 owner;
> if (bpf_core_field_type_is(sem->owner, struct task_struct *)) {
>         struct rw_semaphore__old *old =3D (struct rw_semaphore__old *)sem=
;
>         owner =3D (u64)sem->owner;
> } else if (bpf_core_field_type_is(sem->owner, atomic_long_t)) {
>         struct rw_semaphore__new *new =3D (struct rw_semaphore__new *)sem=
;
>         owner =3D new->owner.counter;
> }
>

Have you tried bpf_core_type_matches()? It seems like exactly what you
are looking for? See [0] for logic of what constitutes "a match".

  [0] https://github.com/libbpf/libbpf/blob/master/src/relo_core.c#L1517-L1=
543

> Hao

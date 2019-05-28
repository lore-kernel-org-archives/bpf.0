Return-Path: <SRS0=4Daw=T4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A0FC04AB6
	for <bpf@archiver.kernel.org>; Tue, 28 May 2019 16:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09F12166E
	for <bpf@archiver.kernel.org>; Tue, 28 May 2019 16:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxsclumN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfE1Ql2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 28 May 2019 12:41:28 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40780 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfE1Ql2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 May 2019 12:41:28 -0400
Received: by mail-qk1-f195.google.com with SMTP id c70so9473919qkg.7;
        Tue, 28 May 2019 09:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Sw22RbJO5llThSNCX+zklv+NMNWTrjfSjj3TgbK2t4=;
        b=YxsclumNsExvthqYHFBofLlrJJuzhA6+4sBloeEiIfIFSt8Tp4DlKM9THDKFVzKnJM
         1E0woOE3lgGQ1WJJ+AhP6ykTN5B7UAHFmmngyMYyqN3dVF8Q41D7G71YQaoQObGAByk2
         yblOk8e94ZwvrbqKSOITC2SGHDW5IIL7yUAMgJJGo1+q5d6aGoFSCe8rnjBudTfYdjIH
         trEGobn1Ll/bl4rSLNZA8FHHCtHlR65of7Ci3cj0GKi8ibJO/XYYmqlcdrnwq5VCnMLw
         dPMtRNIQ7mgCwvqdpu1196Wv8ERr5eg0JzTP1VeVkTHXmMmJjYqsD8+lh9ojfN2pKvek
         hQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Sw22RbJO5llThSNCX+zklv+NMNWTrjfSjj3TgbK2t4=;
        b=C22xCtxBJckPkfvKu1jW5YDj1Zc+MMGA/DclljXaHgTxeCQ5BdIrfusIbH5dPwNbVB
         x3/XjyZ9fydUu1lD7DGZP6myffZOVnQL/72GlAbVhPgLeLR912LQsrgNloEgiw3D4lY0
         mk4+N1+egM8v7Txn0C8HcvR3GbTqEgVuIR1sYfDN00REwUOc3a7c0UE1W5UZs9mk3Q6H
         JWizkVXiX7F6ZTEpTp7lJcdbFUiH8rfrvZpwnxRlBEdLoITg7AXyXAEqjaBk4ozWmeMF
         mtQYPq1CaEOfjykrjs/TUo1KEwnPm8p0DNO4vcOAr87fATUIMLG78s7aTNpq7zLvl8Jn
         /gxg==
X-Gm-Message-State: APjAAAVcaRhUcYXBcMyLuknJMUrfss0qSwkzHJuMMYmtlcxdQPAcdCgM
        7nzvbnmKn3mVpkdmhJ5WXcttvEBJr8bwyyImkT0=
X-Google-Smtp-Source: APXvYqwrlu+BkL/yy7mL1ETKK0WOK+xOaWUFMNu3944pAGYoftdWFQnZcMrkHMSjsNqz110d9a+7p8xdVE7yLF//wTs=
X-Received: by 2002:a05:620a:1035:: with SMTP id a21mr24692543qkk.172.1559061687219;
 Tue, 28 May 2019 09:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190526000101.112077-1-andriin@fb.com> <f84a51a0-09d0-378f-024e-1600674182f7@iogearbox.net>
In-Reply-To: <f84a51a0-09d0-378f-024e-1600674182f7@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 28 May 2019 09:41:16 -0700
Message-ID: <CAEf4BzYcweMccX8UpPOoYkb=CPdSv_exGy3iO1=WUNRDp9Ej8Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpftool: auto-complete BTF IDs for btf dump
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 28, 2019 at 2:24 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 05/26/2019 02:01 AM, Andrii Nakryiko wrote:
> > Auto-complete BTF IDs for `btf dump id` sub-command. List of possible BTF
> > IDs is scavenged from loaded BPF programs that have associated BTFs, as
> > there is currently no API in libbpf to fetch list of all BTFs in the
> > system.
> >
> > Suggested-by: Quentin Monnet <quentin.monnet@netronome.com>
> > Signed-off-by: Andrii Nakryiko <andriin@fb.com>
>
> Applied, thanks!

Thanks!

>
> (Please add versioning in the subject in future, e.g. [PATCH v2 bpf-next])

Ah yeah, sorry about that, forgot to update --subject-prefix when
generating patch :(

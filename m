Return-Path: <SRS0=dKsF=3G=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7640C33CB3
	for <bpf@archiver.kernel.org>; Fri, 17 Jan 2020 04:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53BF2083E
	for <bpf@archiver.kernel.org>; Fri, 17 Jan 2020 04:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pvy9KYBi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgAQETq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 16 Jan 2020 23:19:46 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45412 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgAQETq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jan 2020 23:19:46 -0500
Received: by mail-lj1-f194.google.com with SMTP id j26so24982933ljc.12;
        Thu, 16 Jan 2020 20:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=imSKWoC291eohZgsrWD/LjCtAqZICIklk9Wyz8HO8IY=;
        b=Pvy9KYBiXH03e36P8s+6tBl671hsS8qjrJCk9h9JlzINU0ywwm5RcsoG7hIigjT2SM
         2P5K74yX7ecNg7TTMunbxjaZf4KOWnx+/D53phoBptlSM8egR54Z3zJZeRoMqQ8rQDzj
         4Fw5pyJnSQgUWiDVMV/s72o2EeD4jDQRMJrkEYZlXeC0O5p+nn6z/ENyW065b4HMkPOf
         lSpr/GFQDfVDWnAABrr4v3Og0F8FANk9hrcZx6nN5YDAJkcv7xp0sSOaABM7Y7nuaacA
         LGD81kItcNTSYNScfDU4WZejj3Z2Pgse3rej/r7gyBUuBPfNXo2RXEVcoYthRw0vWkgZ
         hIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=imSKWoC291eohZgsrWD/LjCtAqZICIklk9Wyz8HO8IY=;
        b=Y4m4rgJBs7f5/aBZtqu2cK8JWcEC/xswSqwauOKL3/ihZDODdVJyfrs4KbgJz9i4v0
         T2LcVFurJoXgeKZk8B14MOvObjhLBgiUByH+HOurAyr83XV9UNq7jcI2VIYUBbCsMkKj
         /TXURsXc52JzlEz6Mfi/tyd3x5H86WZHwJJvN3zhdsoi6V8MUnhL61xvSZhks3r7QCtK
         Nd7dmPzZookdKUx4i3NhObgydqm/nUz5SDEZ/kQdzxvYPtdDiQqTKFxxuXhxxQ9AArda
         y3/2LmC1iGgJ9BmLr5Ebm0I7XrMiuCFuuxg+BqjAePfU9CI007Yl30fsjeNtJKdMoW75
         MTWQ==
X-Gm-Message-State: APjAAAXN3TeAcnB1+7n8qsR3liVODhQQeP+wR3GXpWejZMT7ZbQdH6ku
        tBA6cejG7doT1517/DU+likaW9+uESiW79Fv3pw=
X-Google-Smtp-Source: APXvYqzSEUXMlBj6dlKaHS7YXkz2fO4BuQk4KT4Tx/YQFscvfB/UfytOxrU6dSOWVwLi/Mp+XD8M89vCtQocmhysvYI=
X-Received: by 2002:a2e:89d0:: with SMTP id c16mr4357865ljk.228.1579234783953;
 Thu, 16 Jan 2020 20:19:43 -0800 (PST)
MIME-Version: 1.0
References: <20200116145300.59056-1-yuehaibing@huawei.com> <CAMzD94T3TowoygCu3mAtd3WaZtSk1m1AVVpUHYB_bPAyE9QS3A@mail.gmail.com>
In-Reply-To: <CAMzD94T3TowoygCu3mAtd3WaZtSk1m1AVVpUHYB_bPAyE9QS3A@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 16 Jan 2020 20:19:32 -0800
Message-ID: <CAADnVQL_BwWCMGvxPjC-bFiSskhzDypRifQFRUmTZtWN11qx=w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Remove set but not used variable 'first_key'
To:     Brian Vazquez <brianvv@google.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Linux NetDev <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 16, 2020 at 5:41 PM Brian Vazquez <brianvv@google.com> wrote:
>
> On Thu, Jan 16, 2020 at 5:38 PM YueHaibing <yuehaibing@huawei.com> wrote:
> >
> > kernel/bpf/syscall.c: In function generic_map_lookup_batch:
> > kernel/bpf/syscall.c:1339:7: warning: variable first_key set but not used [-Wunused-but-set-variable]
> >
> > It is never used, so remove it.
>
> Previous logic was using it but I forgot to delete it. Thanks for fixing it!
>
> Acked-by: Brian Vazquez <brianvv@google.com>

Applied. Thanks

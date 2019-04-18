Return-Path: <SRS0=qXn4=SU=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCBEC10F0B
	for <bpf@archiver.kernel.org>; Thu, 18 Apr 2019 05:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7055921479
	for <bpf@archiver.kernel.org>; Thu, 18 Apr 2019 05:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqkPSMGr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbfDRFbj (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 18 Apr 2019 01:31:39 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44711 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729446AbfDRFbj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Apr 2019 01:31:39 -0400
Received: by mail-lj1-f195.google.com with SMTP id h16so746447ljg.11;
        Wed, 17 Apr 2019 22:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F6CA9FJf7+Tz0Jt7SqzUOXxE8qp984P+lhDyMBSLERM=;
        b=iqkPSMGrHS2YhIsCg+6be3zo94GhZ1bopSi/lvKUPK/3f7GiUt4WoHyJVMv8V8nHHA
         zlaLpLN/RsjJIX4M46sHqe4tOk+ZUmPydCuSQ1pGynmC4RtVYZ30klQhdpTfxy0qqajA
         UJi2Eyslld1i8Zvyi16AUcCUmdXUJ0+yR9CiP/tjILZkk9Cgf/FBrGfIBiQhABsJ9azv
         xIeXbpkC7u6X3c9BCTZa1oRw0Z3hiQwskQ2iLDR9RA1RZezQU62b6nWnyDu4nwyV7x+E
         EYqsPVDAHcAEWlALyyX1+DCc25ucV+xL6nuhZWOaq0HcBNE88iyrk1nUGaWPJoDWTpPP
         Mnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F6CA9FJf7+Tz0Jt7SqzUOXxE8qp984P+lhDyMBSLERM=;
        b=VoONejDZj9kUkBLDrxnvNpUJ7Z2rbucz30x4V/lRXLLXeB18H24ZklTcAKhMoHaTR0
         1TQd5I1a7X78ln1Ku+d6hwBfEOvjRDQugy46AOracUDo0na9pYpcaSAMx5ijDuFwFYOv
         TJxatgQUVgK6CU2WKLgJ5kdhE/dfD+YEHCLN8FqHWaNIi/4zb6PKgbU02gUp1rp7qAwd
         OOQeQ/aefaQlUqqMQ9QRKUWHxBLTqO6w1k0LFRXwoDYqnNGhfZnDclYJhzrLzSD2ObiP
         G+7NgdravW8actMTD4VfPyXj2SiL+SOJ+egKPGj5olamhK9NYB55teyDOj+Y4saJmiM3
         nLsQ==
X-Gm-Message-State: APjAAAVo2BReSvBoKmW9X8AUGWAcF6mpXnkJioGsaWp/dyUYMwqnXDTA
        DUN9N1p57Q8vJU79Ju/KeZpx4XDZvD/mtPPXzjU=
X-Google-Smtp-Source: APXvYqxDRGJRHMHZR5UEaCyrfZiulREjFAbyN0oXvCEuZsR9/q2lGyi0fGvT+kqu/Q3ylXKApkZ/3CxCYQY0YBYUfzM=
X-Received: by 2002:a2e:88c1:: with SMTP id a1mr8966333ljk.78.1555565496672;
 Wed, 17 Apr 2019 22:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190418052330.4180377-1-yhs@fb.com>
In-Reply-To: <20190418052330.4180377-1-yhs@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 17 Apr 2019 22:31:22 -0700
Message-ID: <CAADnVQLCx8FX83mST+=+x=QgCFQ+V276hc-D8ueh3hoTXbOsAg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix a compilation error
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 17, 2019 at 10:23 PM Yonghong Song <yhs@fb.com> wrote:
>
> I hit the following compilation error with gcc 4.8.5.
>
>   prog_tests/flow_dissector.c: In function =E2=80=98test_flow_dissector=
=E2=80=99:
>   prog_tests/flow_dissector.c:155:2: error: =E2=80=98for=E2=80=99 loop in=
itial declarations are only allowed in C99 mode
>     for (int i =3D 0; i < ARRAY_SIZE(tests); i++) {
>     ^
>   prog_tests/flow_dissector.c:155:2: note: use option -std=3Dc99 or -std=
=3Dgnu99 to compile your code
>
> Let us fix the issue by avoiding this particular c99 feature.
>
> Fixes: a5cb33464e53 ("selftests/bpf: make flow dissector tests more exten=
sible")
> Signed-off-by: Yonghong Song <yhs@fb.com>

Applied. Thanks

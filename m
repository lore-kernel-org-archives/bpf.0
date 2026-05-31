Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B61E3603DD
	for <bpf@vger.kernel.org>; Sun, 31 May 2026 01:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780191885; cv=pass; b=XhMbPRuvFmxop+xZZQQXIZNL2pn4gHOIt/idRi230BoCMYnsTdFNO5bg/5++J1rVbUbnYgURNpEU4X89CyPsNaQ1ZjMd4WXVYRuiTWUBnz3wWuVpeTG4kOxs4W9SOLEe6x8jgum86C+5KHKFa9T5wNYLUJhnw2B9JUvja71uOdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780191885; c=relaxed/simple;
	bh=JY17uG+peAbC3rGOIzWPUWF2GW6zXnCaUG0CsOCyQgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SH17UnYCXm9ZLXFPqFioFflN4UFXXifxk1dgkm57QRCBdmVD7r6z2GW6m4kxaWflvaTgZiNDUYGDiLxbnRts0CaHTCcNjAXcDJer/iRiUdeGU4ujowfvBSvvKT1Zd63oGdQGCfD/IolTTPvlCvji0uoMF4mYpzPdsF6lCE6eAGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=luxtQQ3+; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="luxtQQ3+"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-516d78ba1adso1231cf.1
        for <bpf@vger.kernel.org>; Sat, 30 May 2026 18:44:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780191883; cv=none;
        d=google.com; s=arc-20240605;
        b=U+V25p/3JiEmSWJ9nk0PhulSVPsHrbQSMRb1xEgh9fFRfctPi3tHtctIoCzlIOFu7r
         emSn1qqeZBPoC4/heC9uTt5bETPgwDzc736JPPHXXvhOoWr4q6lUuB5L0CewRE84RTyb
         1j7sKCaCJd8FlXxS/9hMN5023dFrQbZfl/kFsnnIByE+SgXwW6bmpja/W9z+XgChHDLC
         11oBuWdoPIH14a6HS5xss4q7YwQqxp1muMiE4gQ1j5pNJt/iCuUMoG1SzrwUK5tREpgJ
         +5aCypDmFETXST+47oWKcrLKLpkQWu9Um2DYvSA7WTE8T2+XOpHFzIdj6Z37SMEa98vP
         Ao0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ilFSrviVs31RIfLP4HkhrNfgU+I8AsONLzeZnzt4ues=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=hMdEVDY8IfseFXwIA3ZRtik4DwRSo89lqpBL0FsylDgIbb6RPxV4m7uJ8pUUquVFnk
         arPiPvz6rP/UGtlrYExc4quM2vZA3zfRhdM4tY+wu/w0T+QCR/tHotImGEHtBSRu8QIc
         aLfCJuBdqfPap2u9wCryWeaSIkR8xqykBTy78EbpmuUDwNmspWx85scX7+YTqVgsRLh/
         y7olUmt5wukPXorRyXY49aHY6Vst4MtCyHvwjyfq/idXtpzqbb5UfLEdyPr1OkRDsTe+
         Ir+qAy8i17unyId0RH0s3/N2OCRvgtCtqn8metXBhAlnNXeCzszAPpg+310pQlMs19M+
         cRrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780191883; x=1780796683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilFSrviVs31RIfLP4HkhrNfgU+I8AsONLzeZnzt4ues=;
        b=luxtQQ3+qE4eNyLa/xkhvPf9UtjLUOcpgG3zwjqFd1AH8PgnXrZWsVBYdPebIEhLUW
         Qw5JC7BFPA+3tmThzmgZkh4WqgUqp39ZUx4eRkQKy5MzamGTe3oK/BL/sgGZtCFoxH6K
         yzKmK7cX2JD4DCVE0EcurDayg8IcCSnKtYbXLtVRhjjrUzCScQBuQ9euvQ7xyv02CjFM
         Vz8wjDzENW0yIXMvxbafhBQNvH7j1tUVJ1VUA9B8QvvE9S9XGJssNVFwlKWf1siESu9O
         qTm3NPhE0H6sE4R3PfoGSuHUzHoLfVNwy8toLq4/iwmNoerCRrXHKbFNNX1dy8W99bHu
         JUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780191883; x=1780796683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ilFSrviVs31RIfLP4HkhrNfgU+I8AsONLzeZnzt4ues=;
        b=rbg4lLCG6DSe1tFTD6iQVCah8YrqGw2zExVBIdcxHbVB1HRkAGm1k+FJ5DY2EHwBnO
         ACUJfk0joNe4U40ZsNwSvvOyEd401wNEYGaVfBdukM+qmRTcQisUPH9l9fEXODtORdoQ
         7A410NfZcXy1L+BgA6jFzhwsIW4pJaH3a11NAR7zpaaoiOvVcu5Orswp1QjYZoQuu+87
         NgLNlt/uefLZZHu1Xrp3qoYDTDIsG9TZHpM2JUry82Amrlc7TIFwr7Sy8VNsEykcSIzZ
         Czdc60tfYyRjwobitCD7xE4YXx0jcZ34eVACTtHKCUtlHUboLm1adlvEunB98nOMiIkM
         tiIA==
X-Gm-Message-State: AOJu0YylCYTcP1aEU7rq1JYwktqoJOrzckgiuQE4bEjqj6UZoE5xAhj/
	wOH/s3btAsrdmYifdNdrZ82lP0ie+ub5KhMIqCvdziYsSDt2OxM7P648Q5Vngs+HYBQckFSJINx
	UNqY8ozMZzjQn/zqlL16ME9XCt0HIa9cJh33a+O2laORVKjGUDDJ0y8Pfz3Y0qg==
X-Gm-Gg: Acq92OF7CIzIN9oo+xqys7V2+8r6barJy+JC4eyc9KZOAdtsyQMWxtnvaG9wwEbm0aa
	6PBeoMOGAuEC/deUwmLN2Zu/T6Q+jjDbB4W8NIqDcik9fO5USRPf8YJQISlKvI7WZbM9pM3PSQf
	XwaI9x5pIUBGpAm0vaw8Txz7Vz8uNiVr0n/p7JLphaHU02AIn6sANBloJfdYkmV8Ev3vOxY6fzm
	Q5Bfe8guC9yZjIzRnwg8sp23ofoJaAhysNnkjgXDJ5W0UujeVKPF0ybuA9DyQ3gqS/AMMsA7GJD
	dBQiXtGmiwX5PspCZ91VKq71t9q0zoJa+r00ZcjuJJwmwjhYX4+xn23yPVc8nJfz
X-Received: by 2002:ac8:7f0c:0:b0:514:b17e:86f3 with SMTP id
 d75a77b69052e-5173b68d02cmr4528551cf.12.1780191882675; Sat, 30 May 2026
 18:44:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531004748.3567875-3-yuyanghuang@google.com> <20260531011110.F22BA1F00893@smtp.kernel.org>
In-Reply-To: <20260531011110.F22BA1F00893@smtp.kernel.org>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Sun, 31 May 2026 09:44:06 +0800
X-Gm-Features: AVHnY4IzCADml3zKoYSyRSrNWNuSsrTy9RPkMx5SVD7WrajH2eDmneCa7VMWDJQ
Message-ID: <CADXeF1HQCjVXqaqFEGLOicNOC6Nc-ki59Eyu2iaMhf+A6QFiMg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: add verification for
 BPF_PROG_QUERY attr size boundaries
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 31, 2026 at 9:11=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Critical] The selftest validates and enshrines an ABI-breaking kernel =
behavior where BPF_PROG_QUERY rejects valid queries from older user-space b=
inaries with -EFAULT.
> --
>
> commit a51bd156081fb623564c01426a789df272b5e924
> Author: Yuyang Huang <yuyanghuang@google.com>
>
> selftests/bpf: add verification for BPF_PROG_QUERY attr size boundaries
>
> This commit adds a selftest to verify that BPF_PROG_QUERY rejects queries
> with a user-declared size below the size covering query.revision with
> -EFAULT. It also ensures the query succeeds when given the full size.
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_attr_size.c b/t=
ools/testing/selftests/bpf/prog_tests/bpf_attr_size.c
> > new file mode 100644
> > index 0000000000000..4fbe56cb29d4a
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_attr_size.c
> > @@ -0,0 +1,65 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2026 Google LLC */
> > +#include <linux/bpf.h>
>
> [ ... ]
>
> > +#define OLD_QUERY_SIZE               offsetofend(union bpf_attr, query=
.prog_cnt)
> > +#define FULL_QUERY_SIZE              offsetofend(union bpf_attr, query=
.revision)
> > +
> > +static void test_query_size_boundaries(void)
> > +{
>
> [ ... ]
>
> > +     memset(&attr, 0, sizeof(attr));
> > +     attr.query.target_fd =3D cg_fd;
> > +     attr.query.attach_type =3D BPF_CGROUP_INET_INGRESS;
> > +
> > +     err =3D syscall(__NR_bpf, BPF_PROG_QUERY, &attr, OLD_QUERY_SIZE);
> > +     ASSERT_EQ(err, -1, "query_old_size_fails");
> > +     ASSERT_EQ(errno, EFAULT, "query_old_size_efault");
>
> [Severity: Critical]
> Does this selftest validate an ABI-breaking kernel behavior where
> BPF_PROG_QUERY rejects valid queries from older user-space binaries with
> -EFAULT?
>
> Older user-space applications (like an older bpftool) compiled with older
> headers will supply a smaller bpf_attr size up to query.prog_cnt.
> Previously, the kernel would accept this size, but this test now enforces
> that the kernel rejects these historically valid queries unconditionally.
>
> Should the kernel conditionally copy to query.revision only if the
> user-provided size is large enough, rather than breaking backwards
> compatibility for existing binaries?
>

The proposal in the patch is implemented based on the suggestion from
the previous review thread:
https://lore.kernel.org/bpf/DIUR88219HWQ.26T4D7ZX8CNTC@gmail.com/

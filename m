Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9305032AADC
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769540004; cv=pass; b=JE+olgDh1jLTXxL/gKIkSpCSSW8ceVb0zKLf+7D5f9GW8IYc2uqY6w0dWnoiCgs/PzW2HPzgOLZ+Z89F3j6wZ9lO4iOLYeLOUD5iuzh9/v9S/CyfcTdhAqMT5YA/+bPNoJvcJ05cT/9rmS7+iviXnvxIJU1HMe6yDbn6orXGviU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769540004; c=relaxed/simple;
	bh=Za2vWA8pgu6NjnY9Yb4l7dLB/C5iBCIKsmqjk31cA4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUFR70dMlQwLKwE9sloSwppD2c2uzrRYBdCq3MifkvPRXeNbDXOtMKIezSZjCHnNuL6mwAzTTiogrUoExuepJxCCC/w0RrKKax4ohKuX2LVHLm124r6AwyJgORseCn1/+91jFgtTQcZmt884yFU/w8k3FyT1mpi8KC9XzuiYhPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZM28Fxj; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZM28Fxj"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-432d2c7dd52so6088708f8f.2
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 10:53:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769540001; cv=none;
        d=google.com; s=arc-20240605;
        b=YsZcNM2T1zgT+rjhVPYeUFX93gOzWxux5p17urol+KqrZ9YLXql/NVIIg/Zdo1rjNS
         gZ6Fxu0KdlnnKzGpN7A2E3lItcWYNhk4gNlLelcsLuh4ba6J9VGo9LMKZG/Ed+JcM7qH
         s2OEzfxD6zzJcXw2syWQFGJhlB5W5Ao9YFIIoG5dqvh9zDhBwjNSVQJyxvuRxK15HHI2
         vmSh3uOMEHEUUUrqrjhp3Nl/hXUPTOmbWTNWddx97MbBNN/TOV5TDIwc2sranc07hPt/
         BWErwAJtSHLt8cAhONElJx2fgwb2pKoIlaLDAvY4tDgMY+n0990P1OThYhOxvH8ps+4q
         MUiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+LiXY9JpS/RsbhrhpV/AbZJd4v/MxuL6q0ixFd3r9So=;
        fh=IAqWqy3/s9gf0tCkXiJ0RQ19Sqg9rZCNP4lAWtQ35dY=;
        b=By8ZIpJ5tt8R4TZ1IeWCXiyEj8oln1D/T9ZlhbXC3yDasfYe0nZ+/QMZJCzpvkL2EJ
         gz/NEMGoH8ofb+e4uR/iwTJKosxzniF5UBYfVTgPAAI12/CdHML4LgUjyBvV9wNikOhP
         X3hPt0TI8stNx7BWvbsneszPZinCD02lCmsilFCalsRn60w9lTTvruirqQ5G5SHEe8hq
         1/zDIDO3MysPENxY0YE1Gp3NvHDFe9qAW4dPXksyFvUCHeOLI5Q/NhMhucsVQeLFnP8s
         fWZE2Z4VhaWsNnJP6ln0Q7P8+GJtSFZRAXgEQbl4bgjR9EizFbQtusEU+69L4qKJ1g2a
         cyIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769540001; x=1770144801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LiXY9JpS/RsbhrhpV/AbZJd4v/MxuL6q0ixFd3r9So=;
        b=iZM28FxjXFS152P3X19GphiqX74lDpl44s9aGKDTHyHX1So/88zM/OHAOi8SzMA94A
         gfMsVRziDc7eQ4oqO2VT1AURig/e+BTstGTdSDbNJihWF0EblzcVa2slz8C6C25xn3xg
         I1tpi2hJ3D57R/s2kntfZsLvor3hfVJ6PAxPXR6W6JBZuLKEBBIFlMCgJ1ODYmISQ2WP
         JkGlCLndmZj1D0gxIcO4Cc9QFt54jyuMN70bcp+YDyP8rzAq7rB5ri+a8XiCZyTV0k5b
         1KEBaMudcZB+vbx6PrjQ6DByrsyn7RL6ryiaLg2O/wOXqG0meqK4sgYMfMPiYvUbGVG5
         14zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769540001; x=1770144801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+LiXY9JpS/RsbhrhpV/AbZJd4v/MxuL6q0ixFd3r9So=;
        b=QMWBFda+Z7CuJWC0FKUIBAu9YGuZT+LU4F7mn7Ilh7wTxixnVX6OK8ctFkfFgjLumu
         MW4lYb5U8zgUTCTArItzzu+Sfk9jcvoP9s4HaeAkHRHUTy1fv1eKP9cIhdElIadt86QO
         UCjYekdZ+220frFX99I0THkvBp1rIhJfpP/7nJmRDyEWeJtTpT1casA20sHXkWQTCmBC
         tdsdGC1Ic0O++cnF8jAZrqjjavinP8OkXU4erFoUOtL5cqSc5XX9jI/2fMD5yzaTGVaY
         nUUqPoPK5Mo4Cq8ZiKgDWiYOWapia3OB4fWJvrk0CGsD/9d7zxlphFbl0byAVmaGqNdE
         d/wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO3WwNF1CoJY88fzk2r17jZpuzZtvc2BgSrZ5ZqeVlZiWJaAk2jP0iUE7rWRdvkXsiHcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSeX8zmQ4ImYyOPCjoTjfE67oWLgaIJQhD/m9z3q0KJNdO/sw+
	RThObl+KIsObeOBqzpbuCrKEtiPDi4UnIAodyAALJwjBn1qyWWJjqiiyilu9GFq0wwlISTeoKds
	DOUP5zL19ZQOuKI6OzSqlLHZCJlwYhSQ=
X-Gm-Gg: AZuq6aJQ+/wo4xivQKxHFHlJV5uhjmdVYkNDepLEMRdhoBL2IBNugMIAIDUhUtvX6VX
	+YFya2XAKoHjETvzGxglfNlDEZqJzLvDWXXQFpwcKaSr9Vckjbdgc+c/FgjZqwaWtnLsx5ISLt6
	KAZaCidxpP842OITxLy739GkvB30BzcD9jUOrmHYXVbthys7ctc8c2B2RSjM2HoMJ6CfoHs4B5W
	yBczjIT2o+4q8pVPABzfWPscV2yNUunMTB2CLp+Px3ZhR7Vrihzxoyt9EJ/cI58wp5sxrQZPgaL
	j5XBRP3gncK7OyG1TrWtTAjnnKsV5o9nW9VdiqmHSsIZPHNbj5pmiybOI4BkOrORlAtLWC+xwgZ
	+Le2+d48IHQgJhu+sSmdXqszy
X-Received: by 2002:a05:6000:2601:b0:435:dbe3:c6b1 with SMTP id
 ffacd0b85a97d-435dd07fd27mr4324133f8f.25.1769540000650; Tue, 27 Jan 2026
 10:53:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769470552.git.asml.silence@gmail.com> <b766b428ec90862d69c9ab843dc89b6d0a017628.1769470552.git.asml.silence@gmail.com>
 <CAADnVQJcoyJ1hmU_oUcjj=8ewPAPTOZ8eccTutSJWHFy2Xza=w@mail.gmail.com> <a61a73b4-01bc-4547-89de-7d70b0c86477@gmail.com>
In-Reply-To: <a61a73b4-01bc-4547-89de-7d70b0c86477@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 27 Jan 2026 10:53:08 -0800
X-Gm-Features: AZwV_QgopQFsBBBwVqRmdEm8ml3k4f5iPW8AsJ0FbSkXCz1em0y6pOFp3cn3QHw
Message-ID: <CAADnVQ+w1OEm7gFb04u6V=5LVw6VefNr_V2FuczBjtaOioH=Cw@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] selftests/io_uring: add a bpf io_uring selftest
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring <io-uring@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 10:42=E2=80=AFAM Pavel Begunkov <asml.silence@gmail=
.com> wrote:
>
> On 1/27/26 17:32, Alexei Starovoitov wrote:
> > On Tue, Jan 27, 2026 at 2:15=E2=80=AFAM Pavel Begunkov <asml.silence@gm=
ail.com> wrote:
> >>
> >> index 000000000000..7a170cb2f388
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/io_uring/types.bpf.h
> >> @@ -0,0 +1,131 @@
> >> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> >> +#include <linux/types.h>
> >> +#include <bpf/bpf_helpers.h>
> >> +
> >> +struct io_ring_ctx {
> >> +};
> >> +
> >> +struct io_uring_sqe {
> >> +       __u8    opcode;         /* type of operation for this sqe */
> >> +       __u8    flags;          /* IOSQE_ flags */
> >> +       __u16   ioprio;         /* ioprio for the request */
> >> +       __s32   fd;             /* file descriptor to do IO on */
> >
> > 1.
> > No need to copy paste. Just include vmlinux.h. It's there.
> >
> > 2.
> > drop KF_TRUSTED_ARGS from kfunc. It's a default now and this flag
> > was removed.
>
> Got it, will change both, thanks
>
> > 3.
> > add a runtime logic to check that the return value is either IOU_LOOP_C=
ONTINUE
> > or IOU_LOOP_STOP or instruct the verifier do it statically.
> > Otherwise it will be less convenient to extend to other commands,
> > since the way I read it IOU_LOOP_CONTINUE =3D=3D 0 aliases to any value=
 > 1.
>
> Is there a struct_ops hook that can help with that? check_return_code()
> has some hard-coded checks, but I can't find anything customizable for
> struct_ops.

yep. check_return_code() is the one and you're correct. It's not
customizable atm. Much simpler to do a runtime check for now and
improve through the verifier support later.

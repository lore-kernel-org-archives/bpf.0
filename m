Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D3B3DC4C2
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 18:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787338573; cv=pass; b=YvoFe0y16EKJGaXmMcJGoBgnGp+d2TBRYlHURYR5iz8txiFBEjROL+APknD+P7F66kvNkHMto0mDWRT/l3UeSRLmvmGHSKNYDVv3Xmsk85Z3bjB2KCBtpEMBOtaNIFygS8leBszzDrP3xFGn8v5K/tAGVjfwNZRR86ywNLiIBl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787338573; c=relaxed/simple;
	bh=mzJidH9Z4jxuuUj+CXMYu3n+LJDaJltgHopocBX/YA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pa/jRwC5jd2Hfi8Vvf9Dfl2fhtPFnk0VS/PjII6X7Tml51/HasFMq6fhBkO9jUeI62gFDDw6xDr36SKWHjSMhyOc3TRi8dtfRmnRQJOD0OflGAlIHykwE539I2dPYnJ25NdIIYwzIinti3Sz9S5O3ro/nmdGBjnGYzqmwqReH1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8J4qWsL; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8J4qWsL"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c9aea40d799so876973a12.0
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 11:56:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787338571; cv=none;
        d=google.com; s=arc-20260327;
        b=PqUQmtSm2gutSsbzMJxBB4vewBpe+UBbUCrp/Aeq/j+xCQCUNe5IIe50m5f5Fag2cE
         QF3h+yW39iHlvoyphg+EWwqLnT/yO1EqjpCaJFR9znU1EanO+nTK6FHzUxYP/SFxCUIp
         I47v1cySmpWMjQpxGLkKTuCQof5If0DshC1aqo9UZIgtJ8HlSzUAnQ4bFMF61h/3WvVO
         BkM2Y38zvr2If5Ths4uhRBy82ZFRK8rdTTiekvLBhs9/IB3sFDnTJTIQL2K497zchaQ0
         jx3e+4HC9n7USgMWp7CxSHCdBrZCzzJWVaQMHJqx7wK82ikj2M5M3zw6cn/SZpvuANXy
         X2Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QZChrTs2TY5qhvo4NTZDeb5uyLGhsO4JVZFUF4N2cyk=;
        fh=tYFYtt5hSexLAwIWlhIhkYPXFXORXllj8IRi+pgQkZg=;
        b=ee/VKtE3wC8mnt+CVzI59WaC4SNmfJGSyGyPFBCc/7fI97zvqPVNOduQToo5mm+vBt
         xcEfyA5EuruMY57vVlxBfSC5pVgA9fLHxbfDLoGY0voM8adJtQz0T1fkmfyi0zUgXDyL
         R2A2BeSMHGA/0LrRfaX7gfeKluTKBVX9Qz7kAvaG63KbuP8lKdKmb0EShtJBpongYqyo
         rpswns45sixcOHsPTQcU0ZI/9nTkiRt9BDuDEFeZWOdIXOv+pRcNYpV5TqiiDUF27qD9
         y2gupqVdslS/u7MbKeAYr3XycXISCahPE0BjJjN44aqgjpz0TFbMPuLXSlkYtR7jNuXe
         cJEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787338571; x=1787943371; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QZChrTs2TY5qhvo4NTZDeb5uyLGhsO4JVZFUF4N2cyk=;
        b=d8J4qWsLHTXSdLbhWL3d32BUIPeyhnXVfFTHZJfGxs3UA34xifzMCSIrWQlpAls3Rq
         MKObi+7Pg45DVRKk2xOEy7G+aJkY+7suzvAZ/SNuwjpTBH73jsiqVq91bhoqC3DfpbIx
         RA5VUOhhVZ42GEwndtItd2IlxBkLsqTaoXzx19IQ4i/nbbOxIqG11IoAqeX5ZOPOXGU7
         c2pJweQ/9BIpdPTznhiQwiprVw/w0BE6v3BBIu7HZYaOe6oA9crByHyjGCgogdb3eLmU
         oPiPy7muzb91ypMijp0lp4Pbi4mdtYhYgGrE8yhgumByNrSXxjvmpRp+LjeNDpDwWmtg
         QUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787338571; x=1787943371;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QZChrTs2TY5qhvo4NTZDeb5uyLGhsO4JVZFUF4N2cyk=;
        b=cVLwvbBL8WTwqXuHDle/HS514rj6k7wF7J+o0AMal/TVXbos04PsMB6Ipt1QZ4R70W
         6lqCt6W8Y1kChKXFl9NtmO/USdAMjl2g6F2MldcuZCHGCFwKAiYJqQkKWOxtAJTU4SQ6
         lR8vSmKNpwlwCjd7b+YZlrXlkrTQlwlX5Zy0e7veMSh63CXh6SXYW0Wj+BbZ68FCAaRv
         WFaUDecLB7CEpDfDOwSWXp1SUZKEe/G3aufT9Sw6a9f+qcHPooLm6fBkGpU/3S2tMW52
         1giIkLUowIEekr+x4rvvYPu5a914ByAmigpR/AU+NjywfI0u0WOj2bS921evQHmWXSYC
         NYBA==
X-Forwarded-Encrypted: i=1; AHgh+RoKVTwk6Ej3MEKA840jRDOPKNAoIY+/tPhP2/quOw69/XQ3Hc9QlCg9ylo7lDDPG1uhd2I=@vger.kernel.org
X-Gm-Message-State: AFuF++nTxj8TJeRosNZ8tSngIb2LRUWt571wEJPdeuhBye4d6lzFJZmr
	LoHvApk4zdVPCU/6FZKqvYb9vb4vxp5q2PAMcDV6gW92z3dK37sUh98wxvcTv+iWzVtU7sQRts1
	sk9FzFckrKnh2Cn3Z2l8ZAlzJBFuvdV0=
X-Gm-Gg: AR+sD10qOGrfPyiWwkSqoKrZSCKJLPPTva+AkdaN2NGNZSRQOdoBhPjvS5fiAW8W5HG
	B/yS76TcPPHqrgR+1ThDTZnlpJ5mBCwEHp/e5Q5nVO9Z2VgaOlGiA//i/OTSuExsOq1e8XMpFqj
	rklMJRtDvgeUD8VygyMI4sGnKlg4BqoAm58M4FIevj6YuaMEzcfeP/0dzE8j0sCI+90ser74M2Z
	8SCaLKVvdpvftgUq+ZrADquExJyVhDk+aOHNHhuCGTQpaWGJcTSSw2ZzYxY+XNynvRkrba08vOi
	IL9idV6K6Ii5xNxNKcVJlFx9vLBuAW/bageaBVdbagzZgU9ebl+7ilpNm1keAkgFa+T2JFUdswv
	uyhjOP9f2xRkWC4+ZFrI7xWYcdv3CH00i84+G
X-Received: by 2002:a05:6a21:1186:b0:3c0:eeb7:28b with SMTP id
 adf61e73a8af0-3cd2fea65b6mr16579968637.8.1787338571125; Fri, 21 Aug 2026
 11:56:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819090426.267-1-zhaofuyu@vivo.com> <20260819090426.267-3-zhaofuyu@vivo.com>
 <67d62b1943b093ac1eb16c9cc1ff38e0d5eda72b.camel@gmail.com> <d94fdb54-09b6-4d70-bfac-8483024e94ea@vivo.com>
In-Reply-To: <d94fdb54-09b6-4d70-bfac-8483024e94ea@vivo.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 21 Aug 2026 11:55:58 -0700
X-Gm-Features: AcwNN1UhAoOZSahXNfZhvGknDPaAHZ_CPsgNHBo8TzCukx_sWSywc7QatN5Q-uY
Message-ID: <CAEf4BzYkFPK37zaW10RBX04un5xuWs42gJ2pAtE0_iy2+X=58g@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 2/2] selftests/bpf: add tests for
 selective kmod BTF loading
To: Fuyu Zhao <zhaofuyu@vivo.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, alan.maguire@oracle.com, 
	andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	shuah@kernel.org, yatsenko@meta.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 8:51=E2=80=AFPM Fuyu Zhao <zhaofuyu@vivo.com> wrote=
:
>
>
>
> On 8/21/2026 8:10 AM, Eduard Zingerman wrote:
> > On Wed, 2026-08-19 at 17:04 +0800, Fuyu Zhao wrote:
> >
> > ...
> >
> >> +++ b/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c
> >> @@ -0,0 +1,196 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +#include <test_progs.h>
> >> +#include "kmod_btfs.skel.h"
> >> +
> >> +static bool btf_skipped;
> >> +static bool dup_ignored;
> >> +
> >> +static const char btf_skip_fmt[] =3D
> >> +    "libbpf: skipping module BTF '%s', not in kmod_btf_names\n";
> >> +static const char dup_ignore_fmt[] =3D
> >> +    "libbpf: duplicate kmod BTF name '%s' ignored\n";
> >> +
> >> +static int libbpf_print_cb(enum libbpf_print_level level, const char =
*fmt,
> >> +                       va_list args)
> >> +{
> >> +    if (!strcmp(fmt, btf_skip_fmt)) {
> >> +            if (!strcmp(va_arg(args, char *), "bpf_test_no_cfi"))
> >> +                    btf_skipped =3D true;
> >> +    } else if (!strcmp(fmt, dup_ignore_fmt)) {
> >> +            if (!strcmp(va_arg(args, char *), "bpf_testmod"))
> >> +                    dup_ignored =3D true;
> >> +    }
> >> +
> >> +    return 0;
> >> +}
> >
> > Idk what Andrii would say about this, but I'd rather add an internal
> > function akin to:
> >
> >   size_t bpf_object_btf_module_cnt(const struct bpf_object *obj);
> >
> > in libbpf.c and expose it via libbpf_internal.h (*not* via API),
> > instead of intercepting log messages.
> >
> > ...
>
> I think your suggestion is better. It also addresses the issue raised by
> the bot about potentially hiding other libbpf logs. I'll wait for Andrii'=
s
> feedback on this.
>

I would do neither and just not validate explicitly that we skipped
(or not) some module. Instead, I'd see if it's simple and maintainable
to do a functional test: try to attach to a func or have relocation
fail against a type of a test module you explicitly do not allow to
load. If that succeeds, bad. Also have positive and negative tests to
show this custom kernel module list makes a difference as promised.

And try to keep the boilerplate to a minimum with all this, don't go overbo=
ard.

> Thanks,
> Fuyu
>

Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0002C33BBC0
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 02:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772764001; cv=pass; b=r+sG//BoFwDqWhswYfDUH42DubbhVDFlOzcf6MhB1YvwOAKoqm+1IruM1fgJPmJhgYQxpfcv5XvRaXCPJpAxho49KMOoqQX11vqNxbn7QjEb9i0x8S27wWX5W5StsH/X/MgsVtyGdqRXa5Jz/yI08gIMtyakXrpTOc9MyKS68mU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772764001; c=relaxed/simple;
	bh=UDS74/xcl5OJssDWqd0By56d3wyNHRnEU5ge7nZTzOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NkFCjQ9WKNxfuhOR0kL3ooXembCHAYQTryD30bSISQyCePZp5svw0gaRqzAu5R6BnyX3l5WoSad9/7Ugas+4yVagLuM/Eb3eFgBxP7vX1hVIA/au7cLLdiSgJKTYdpGADTEwdqpa1/DZmZ7LJwvrUSHwcJcppn7HtaueanXd3Rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCoeVHLl; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCoeVHLl"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-483703e4b08so84788215e9.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 18:26:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772763998; cv=none;
        d=google.com; s=arc-20240605;
        b=TWh0+ZyF++YobVzm7Z49RttSY1+Xgz4Ssp9vMJXaxq804ocErfd2tVeFZJVwST9Eiu
         hW0prn3uicfcDoqXR4njV+xhWykNwlKecyXi92/ir9vPVSMfluuN2zrggVLX6NPfC7pF
         xPj15y53wd0jt2dSwZQJWEPRbD2jOdk70hFfJ/Eukrb/cXtgWaY31lckcu8RUXZhMdqg
         aEel68IGDp5UufEFArH9uOlBI6h03QwcoUfQFBfP7a0LjGTZi+fbaHuhU7LY9P0cNsME
         lJZym5g2/Zh4geLj5R/EuPameMoJj73bFlRNXg5z9+Zu1f51Cw5zv6MwWWD7BxIxKqAO
         TdBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n2TFpv0VKsV5EvrPnFDMEkG92wU7XaQFnZYIaCfU3hY=;
        fh=PhiV5KRFSUnxIlJyBJ9E9t5pHKhhXFjfdw1CpeHfBQg=;
        b=AyJj5yQpq2RliPfYY99drsySGFHzvgj+gad+ebW/kbpaogCSUTR7731oKwECaCC3LZ
         ZatrKh+5OcZQmIvZRwf0dGrHeW8QfPR6rC+eQ+Uvxccz/qPbcy5xa5g+1XpM+rfxL0Vo
         f3U8JwEJHzQQV0QnuD84+YjqxcHmO3TjEqKrD7rytKUagXLi757u1Q/vuvOSmM7WQXvR
         YeS1PUTofz+8TXCLZVpPUVO6GzKhNjN6FtaCB/gYsLB/T9RgXnVVDG2AC7uRe53sfsmm
         aSS7s6VDalr1LNtnbKEi60PJ2LUaUR0INfvGiiqq53gNIbV1dbXipD0OtAw81e8bs7hf
         KAQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772763998; x=1773368798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2TFpv0VKsV5EvrPnFDMEkG92wU7XaQFnZYIaCfU3hY=;
        b=bCoeVHLlKGpjeMl4Ft0xkufhr005Zq2eDvsNwKNtz+RmBjvASppqEZyXJsFX6qM3PL
         BmW9pASn8Til+msYU1Un8PADXEyoR/+XCQfnP/1c6RrdyX4f8mQUquQ8+X8PvRpvOIlo
         Kk7YkOEChpftNWoKt2D57DJbUlrI+ikTTvwcukUrwvfwbE9eFG2GyDPprXhi8v3MITyp
         3TrTRscYMx6qP5V3MnosmYH88Gea0upvTK6drLCMBsOd+BTRRad6Kvy3j+YTA4U/2mIu
         2Wkjrk05KbBLAERRSgLEQPvZ4yippLwTDKXpmQjoxO16emp7IJJC+N3H1AKTieG0DE3O
         1W0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772763998; x=1773368798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n2TFpv0VKsV5EvrPnFDMEkG92wU7XaQFnZYIaCfU3hY=;
        b=flxSqacL1A0bAw2rYK+Yl/6XKuWq7L5EXKIe9Wc1STvuMn06oqHQplb6l+rv9V8OvP
         xK4VrQ/2luAowDlljMogSeJA1LjA9XZFeNqKBGK+ofeGUa5UtziHkIfj4hFqn2d6+qRW
         aqr6RZ23LCZvNWxEEhUdiNfKqIjTFdZ4qmd37oyqhSDp4Kmr+6m7x9w8nC2GnuZXYrlt
         c0LjAwiMsbNCnxbwc/945jFSzE9M+QGKN5ejS54gKoDACov+ypW9nBcOggAr1pwRuE46
         +1ebSJInYeed1DdLnvM0bPmIh143wxsklSQWLfzFZLf6Asl8Vpn7HvNq4nUW7LfifT09
         8nqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj7dGK2uI8BLRnP9BN11FKmR/HK9zifAZUccwV67HaOZIsTbL1NVxzKXhmzd9Zf5Kn8eI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOWhv6WjSwd3prCIT0G7SZS5YPKYyAcy0fEQ5FIe9s/dqZu9dk
	Vff4Uym3DoD3nuWt8xCdDeHd0YuF+RNqiW/wJkBBvfbEW2TfmNgygZG14KIJoSB6KydgL/WnQ/U
	qJUcgSrfVMflfznZ38PShU8jirix155Y=
X-Gm-Gg: ATEYQzxeJlyXzXG//pEOhik07aa7/B3xrr7lFmUB0/+JtsG/xOzQ3xHVgHuXbfpS5Uk
	N7BcTHAm2bj1aOTJOXvQWlRi5XSA/5R78Xo4k4QerF4KdBB4Tg/fj3V+yHyWujXXrWJEnA9jVZC
	Z4/hj2F2iR/C/IdSxw8cIfnOCXsnjzDrAfH+iYQZUQ89iczF2EIJeopERv+bXRbY3EaMxeG8vCM
	shydWyDr/e3KbqKCqu1A3whP1TG9lrfTxQ1SQFrcJ3GDq94s6LwaJWvKydGhIVEJBbRRExt7l7L
	cIOJ9SB+i7rWCVFJaaIW+F3a/E5BuNbPlEG5Wgf2Y2azBpSFCxssv60HRPuuITFTSgEk4oiqEtK
	PdcDvE9eBIUB7KQkaWxI/ndp3vg==
X-Received: by 2002:a05:600c:154b:b0:47d:6c36:a125 with SMTP id
 5b1f17b1804b1-4852675edf7mr6731585e9.17.1772763998304; Thu, 05 Mar 2026
 18:26:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305222132.470700-1-varunrmallya@gmail.com>
 <12848362.O9o76ZdvQC@7940hx> <CAADnVQL7BpNh_WuR3bPKuVPeKLOgnkY+MUwDG2WgN1ZPtD734w@mail.gmail.com>
In-Reply-To: <CAADnVQL7BpNh_WuR3bPKuVPeKLOgnkY+MUwDG2WgN1ZPtD734w@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Mar 2026 18:26:27 -0800
X-Gm-Features: AaiRm53ltGWbt7YWlC9e3Ad6zWeS5FUC7pw7OoSNqS6AexwChHHTRiJSQkapvsg
Message-ID: <CAADnVQ+gA+4UHjz8BvN7fSRehZ9c0vdYGVJ4e01ecat3beCwAQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix const qualifier warning in fexit_bpf2bpf.c
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Varun R Mallya <varunrmallya@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard <eddyz87@gmail.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 5:40=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 5, 2026 at 5:16=E2=80=AFPM Menglong Dong <menglong.dong@linux=
.dev> wrote:
> >
> > On 2026/3/6 06:21 Varun R Mallya <varunrmallya@gmail.com> write:
> > > Building selftests with
> > > clang 23.0.0 (6fae863eba8a72cdd82f37e7111a46a70be525e0) triggers
> > > the following error:
> > >
> > >   tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c:117:12:
> > >   error: assigning to 'char *' from 'const char *' discards qualifier=
s
> > >   [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
> > >
> > > The variable `tgt_name` is declared as `char *`, but it stores the
> > > result of strstr(prog_name[i], "/"). Since `prog_name[i]` is a
> > > `const char *`, the returned pointer should also be treated as
> > > const-qualified.
> > >
> > > Update `tgt_name` to `const char *` to match the type of the underlyi=
ng
> > > string and silence the compiler warning.
> > >
> > > Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
> > > ---
> > >  tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b=
/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> > > index 23d933f1aec6..92c20803ea76 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> > > @@ -111,7 +111,7 @@ static void test_fexit_bpf2bpf_common(const char =
*obj_file,
> > >               struct bpf_link_info link_info;
> > >               struct bpf_program *pos;
> > >               const char *pos_sec_name;
> > > -             char *tgt_name;
> > > +             const char *tgt_name;
> >
> > I have been suffering from this build error too. So,
> >
> > Acked-by: Menglong Dong <menglong.dong@linux.dev>
>
> Looks like this patch was lost. Pls resend.

Ohh. I see it now. Your reply got delivered before the patch itself
and the patch went to spam.
No need to resend.

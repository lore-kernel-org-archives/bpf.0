Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9319175A8F
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 20:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773259882; cv=pass; b=mkoS5b3TBKYYQQ9oUeog16Q+u5+kXzkQLtJ5kK2KixMv/cueyQr/pJiOOUE2NqRLT8wV/fB94qKKWUsioY8Wmad9bAgvXKc7kH1W1jrqadakTeSq5sWvs6bdQUAeO6OWRvuZ5IWxGEJGrBOdGAKoNWgRfAukaghyVKRQL24VBM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773259882; c=relaxed/simple;
	bh=JBLO345+S9XrXFNW2YoDPZsRBR3hdD4cmIiYnWNmANk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGAKduX4d3/syVsFaAMsovAuCwDRfAmuwcRFyL68kRxM0eDJx//Uz5ifCEy3rK3drnJh3cseZc9aVIGT9Qx89Hw15MGSZX74FRnWD6H+EptsrlCW/wQacvd5oAcbg5vJx6YEBobiwuQMSIn7qO8bQqseiZFdcthYA9qRnAtQjOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nt0+G4tw; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nt0+G4tw"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439b6d9c981so218041f8f.1
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 13:11:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773259879; cv=none;
        d=google.com; s=arc-20240605;
        b=O/xmVV9SR+8N0MJ0HjRTbdCd4I8aMiKjow2lBbf/C6ZNMWAIXpyLWJlOohRQM+tLX1
         12D718R9DwbiXouLradA18we2SZ9kNGuf1tYegO8UBMYKtMSs/EVkmyuBdgU2wz2V1la
         YULKRgO/Jz0L6xzoA12f/5qK+jU4m2y/cmqETlZnFwF8HItrw29lOlC2crJlmhAQGORw
         g6RRd1LIBZxm08o18U6/JFDj0ECxSgvmzAGEqnZhNZAJRs45B/Xozb5p4W5ox4uobWN9
         RZL9iWlINjmwG1W4JT8vWmsKJLbK7AAsfHcfItMARVMSv5QXMjQJL19KEpwAGz6GYVxc
         hrOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EseT1hnQ62+LvGjpt3g7L4awuAgBAfDddMzVDpsX9lo=;
        fh=HVuTLhQwoxB2YUAuguyum7PNyVyrp2kJTZXqjjGH+QM=;
        b=O2lQjGFCwXsm/+ni/yEUzbqFbuM7z5D8FzpANNO4ff7s8WV2hPSmjjjFhyNiXaDPgM
         sYr3X3rlJ8ej88ezMB3fEb9nD+hGy7I3W4imVgOKPb7t5eLSVY09cl51FcfCQtT9/19P
         vpEOUNsOEa0kPpT0rOrqH6yG1FTp2xrrw87M+o7xu5LuIfH6wV9xFqulCMm4nKln8m14
         kx4jT7Sc4lMgdim+1/wVeeM8eUcXqC0QkPU6/+KB5WumLxbAb0Jc2StS/ROB9R6Fmbr5
         T0IfzW3lTwHG+8+PhYGbSeDIuENQEcoXDiZxjQgiW6v/HUG5eGZ+lCVP/HAPousr9j8c
         Wm+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773259879; x=1773864679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EseT1hnQ62+LvGjpt3g7L4awuAgBAfDddMzVDpsX9lo=;
        b=Nt0+G4twsD60K87Qbd/OmOwsbaIoIcK9pHaarrOkAiDAbpD0Tkoox8ooSJ2usjPvg+
         Pc2zy/QLm7T5+WShEg0IS5MIiKKBHhdcUCrPhOged6m1fyoUCY1KLGaAZRzzX3Lqn3pj
         LPYWJ+MUEhI/4e/ICJVREzwYq6NH2NDMzH9Ls4Ac8ndiyTNKpPX8ojparDyPCJbMrTDQ
         6l+uWcsUUJqrppr831fwxWrsjplKmXo9Sm1POlcIW9Kc6VcyhrB3T+jcmNp3wrQZHJLN
         GSBqzwlgjGa/0DKobEzhwsPr3uhBnJf6Y7YmSLB1W+wpJn7rAMW8K/ZpRhfyg4RU+pD8
         rY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773259879; x=1773864679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EseT1hnQ62+LvGjpt3g7L4awuAgBAfDddMzVDpsX9lo=;
        b=fIEyPe4gVC3kcjVZh1ecVJ4eYuBf+N48K2FFEsUmPl3vBnVMqhSO7Z6ycgfwGDGbVH
         LU7EqqL47n8K3uIyHx7cUpRUJHT/0m7I9W+IAyXqkPAyp4fV2bW8TcDwGDI7fxMO43hJ
         Xi9NQbMNfmGjD+ZnGbOLBYzjVAFFVYLS9nrWrhudFqL2M19b8qFhDl3p1Wpeff3UJlVh
         GkdYCsupeyRBl2zqpKWccJ5l5NfgR47GmVXo967vblQHsn3scNC9m0XZjWukZ0GU1dSc
         1rFlteqx69WC/I1FfPan7NMJ1gz3XEb2G1oVigl7ttPr3EJOgbg3D1SnPIMR64Qw2eLD
         f5hA==
X-Forwarded-Encrypted: i=1; AJvYcCVwKZsNHzjezHoeL0dxA422ogDdwAfJTseSVuq/psO3QHpnVjB40ycsWcpnZFMniuxC8vQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMQTZbTvbhQZkZPX1QoEyQWhPmNfx4F8HuCtP/T5BaAP3+7d1e
	UvIhI/MVma1JyJN9oLHxgMhzuL3AshfB5FcVYB86faUYLbjyXmhCGzeeNwbGzYFqHlDfdy2USm/
	qeTfTEtq8GPzAuX+84h/Jpsr6m2Pj7cc=
X-Gm-Gg: ATEYQzwTZtSGeR+NZKREUoyElT/L3kl16EdFhvRob/I5ZImCxE0kXPyUfvPVmt1i/LN
	/xpfA79U5kcyrKaLXaIwzr/tq6YG3WfKrtDnQwinxVTtjQXbdoG5iD0s2Pu8JqESOla38i5bmAT
	Rpsh21+UWW2R+GzfRvNLeAxRdk09mwzCQG/jKeAp0WdzB24jZLyeF9+U1E3V4faJJNb83sSo3w+
	9tUUyTZ34qMaYK4qjUNb7QPd3qvgaXWYoN8m0VVx/obeFrBFVXqZSgdoKt+hDI+AUEMsahVGI7B
	RtR9TfN9bhKireR7WAvVQ/Lbb8hz05+NOYgmVAV7gFcJQ2h147wt846yrkByGrhBXA8MbWocov5
	lkowT3VHuWPna3HQu5tWKdJv9RQ==
X-Received: by 2002:a05:6000:1886:b0:436:1597:7c7c with SMTP id
 ffacd0b85a97d-439fdf64e97mr1872250f8f.13.1773259878935; Wed, 11 Mar 2026
 13:11:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303131453.328674-1-hbathini@linux.ibm.com>
 <CAADnVQKuARvSirPjnTcSifLPunCiKC4Nenq0Mr61GpzbW5WxWg@mail.gmail.com>
 <bbf6a46c-37e9-4d8d-968e-a99bb12dcc14@linux.ibm.com> <CAADnVQ+4N4WWLxan_qibZ7HmONJyMZaP=RF+a9tMSPoz=0LqkQ@mail.gmail.com>
 <09b101af-9722-4c45-bda0-c8a3dd417c03@linux.ibm.com>
In-Reply-To: <09b101af-9722-4c45-bda0-c8a3dd417c03@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Mar 2026 13:11:07 -0700
X-Gm-Features: AaiRm52MBkV8zoxY8Kd4D7gtJGs6xSsnBy7_9iwlYcaSkrmO1185Sd5jCetVIec
Message-ID: <CAADnVQKXN9dABYf=T+rfgP2ngDRYC8+-rS8G-881EiEXdVQW-Q@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: improve test coverage for kfunc call
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: Eduard <eddyz87@gmail.com>, Vineet Gupta <vineet.gupta@linux.dev>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 11:03=E2=80=AFAM Hari Bathini <hbathini@linux.ibm.c=
om> wrote:
>
>
>
> On 11/03/26 9:32 pm, Alexei Starovoitov wrote:
> > On Wed, Mar 11, 2026 at 8:10=E2=80=AFAM Hari Bathini <hbathini@linux.ib=
m.com> wrote:
> >>
> >>>
> >>>> +
> >>>> +       /* Check zero-extension */
> >>>> +       if (val !=3D (unsigned long)a)
> >>>> +               return 1;
> >>>> +       /* Check no sign-extension */
> >>>> +       if (val < 0)
> >>>> +               return 2;
> >>>> +
> >>>> +       val =3D b;
> >>>> +       if (val !=3D (unsigned long)b)
> >>>> +               return 3;
> >>>> +       if (val < 0)
> >>>> +               return 4;
> >>>> +
> >>>> +       val =3D c;
> >>>> +       if (val !=3D (unsigned long)c)
> >>>> +               return 5;
> >>>> +       if (val < 0)
> >>>> +               return 6;
> >>>> +
> >>>> +       return 0;
> >>>> +}
> >>>
> >>> Overall this looks very useful.
> >>> I would expand with another test where a,b,c are s8,s16,s32.
> >>
> >> Slightly different approach but kfunc_call_test4/bpf_kfunc_call_test4
> >> cover signed arguments already?
> >
> > Ahh. Then may be tweak it to adopt similar fine grained
> > error reporting as your bpf_kfunc_call_test5()
>
> I Prefer this.
>
> Does the below change to bpf_kfunc_call_test4 look fine:
>
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index 48dcaf93bb9f..6237c2222633 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> @@ -760,8 +760,30 @@ __bpf_kfunc struct sock
> *bpf_kfunc_call_test3(struct sock *sk)
>
>   __bpf_kfunc long noinline bpf_kfunc_call_test4(signed char a, short b,
> int c, long d)
>   {
> +       /*
> +        * Make val as volatile to avoid compiler optimizations.
> +        * Verify that negative signed values remain negative after
> +        * sign-extension (JIT must sign-extend, not zero-extend).
> +        */
> +       volatile long val;
> +
> +       /* val will be positive, if JIT does zero-extension instead of
> sign-extension */
> +       val =3D a;
> +       if (val >=3D 0)
> +               return 1;
> +
> +       val =3D b;
> +       if (val >=3D 0)
> +               return 2;
> +
> +       val =3D c;
> +       if (val >=3D 0)
> +               return 3;
> +
>          /* Provoke the compiler to assume that the caller has
> sign-extended a,
>           * b and c on platforms where this is required (e.g. s390x).

While at it reformat the comment to proper kernel style.

the rest lgtm.

Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D98044CF44
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 16:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626372; cv=pass; b=WAXHdAmZVvhnG4JNDtB4wTKziwIjjXIJiF52/HpiZeB0Sgsxgoz9/aR475o6bfP0J7q10uyIkXD3r+sx8uq+w66nNaxjUDfVpy10Hv9LZhUS8eyQa9m6KhPcj/7WAMN8tG+yLFPuRxMoKgPq3WuTVvKEMpJmM8S3o0BVoNOkepI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626372; c=relaxed/simple;
	bh=8uDoBxR5qf+5tNtsgyPNdMc2uf8NWiIUFAqpGNdUaNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KEsuak02AxDpX+ZGljznlpGDz443pLWxpD291873enHdFSAi3S0uU/2/Th3Oq7/6GOUCQHmYQyjlCHMpEbXOKxEYKT8mS5HGJvHgfthUZrBxMMb+L1TTKqvUsbfIB/nMl5bvwKNRIiOFer73ODuVcQIs8nt4Xf8jzm2jDhrbJpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcJZ+WN5; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcJZ+WN5"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bf84a2b2077so561398066b.2
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 09:12:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781626370; cv=none;
        d=google.com; s=arc-20240605;
        b=ioJhB4XIQ2JTGdyVPOdswf/f92tiVYH6AFksck8um3YWI0CFK4x8CLi/fZsom7L9n2
         x2w3yydclWn9tHNfPYXAlcPuIxMlLQ4bjIfT+ILaZr3eUUF9kHiRD0IMnfsR2ocv3cjP
         qBUBP+31gGMYNgByrVlzqEdnlgXAEj0UYgHWB75fFmdkzjXTwfKR+4US97TxdcVW/oVu
         3J787IGMUMpdm5Bjvh8Pg6G654LylW99XX3pp5dMT4PEK+0HSw+mumPQDd9R5hLOYZRI
         bdF7R0QSGUYSJK1sHKbkdi/toYhPPMbJSqn6VK+BxChwbu0Awk4/8OTPT94erv6K5Ew8
         wcFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GKs2jxsRv9+LlDfAIsR7Q+9I5QhaQR7XKzFdmi7DHcA=;
        fh=j+e40Bt81QdfEgIKWYF3ExbmHAD/LYmp3f37npUdKzM=;
        b=Psu9AjwdQUxkn78434v6GZrB5XHT9IvljO4pXADAIQgALYgf9g5+Aa3Lq26fFU3feP
         f/RMAeGPlL+YRaiC7z+EsawbfD+6z4yPrRnWArWmK4Je5OCMcSlIX4PD0P6hIXK55O+3
         Tq/aREsunxaT01DG+rmblPNxEkKfqrVQiLIaT9jjREEqWclBqgE8O7+5QTmEf86uRjp5
         1CqFf+IBLWxu33xSiOADH0rRGviNhEOkMA+8GUA/AC0KkNUmqfXToGWAeexbp/8mDqEq
         JMqZfUk4YAKBO5gdSQeOmfiLbMzic4Wr74Unn/RcVCDf6GqEQvOpyDPUP6V4TO1fvVMD
         p3sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781626370; x=1782231170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKs2jxsRv9+LlDfAIsR7Q+9I5QhaQR7XKzFdmi7DHcA=;
        b=VcJZ+WN5/EAbPMQnY85H/d0pP4arZTs4ZCmMshSs8GV58FIupzAfINsnkQoF/Qiabk
         k3yEjbbIj3ur0vjtnXe1GH2vgdjv+Utp2sGEOL+cXagYvXTNXUcfP+WF7CkrOROek4yD
         bdq3KHG5fuQllLaa4qgF1arxDJdzvsSaQOBEctSulROyuFEQEnm2P/em3c7O+DK0tg8j
         TpJrVHoiUaw85TmIf31os53tkSbt+8fZi/hJIDrOBluscEhfSBbYM7LpXK0Mqoowz8yW
         Zj3ijT5BFP1WwBgWXM3Y5lyw6AUIh0GDoGjeU+6MeAI8gI1Kmv6KfYensHMrP3LNbgfe
         K2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781626370; x=1782231170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GKs2jxsRv9+LlDfAIsR7Q+9I5QhaQR7XKzFdmi7DHcA=;
        b=Iq3dlEGCvJpesrBRN1we9NRSzs4tztl2NMEZejwtlAqt/0CrKtN/cJer7BEEW6+Xq8
         VN6ly8wXoKDZk2kPZAHxzLxzT1fWQEFE3y9XTsVNUzdib8UlO6M6Fhjo/AkVwZKpxT49
         p0os+qZoVUFTqLeeEJT4/sQd6Of8AQ2pe7+3pzpBXpai+Pk8lvAUabG2XknUeH+mod2D
         jKPLwPG3OFDN1F8wz1ByLnKjOpWD3AKUsY4rPPigUYHFWoXf1EV+2uoFWg4uwQyPLzzw
         sRj+Dg0hg3Ah6siQ7nGN7mGOAvl6nmCfb7PaPZxGJBJRECLK3JhdtVO07AR3ATjK1dEo
         BN3Q==
X-Forwarded-Encrypted: i=1; AFNElJ8XKEBubg65XbdobLfLS3mUbZGD7j+j4nbWPCBpGZyvIZrDDAmcXF0L+CuZkUKRVdaVAN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YycL/fPnVEjEnXloLcThD7dyDH2I6mRFXyZOucHym19BGlsCHZv
	eA2++8pXJWm2aI4k/qvOf1C0kKaYiv1eO7U0FDsHQ7CH0EQT5DbUk58JmbKvMHv9byDhJJnvFf0
	X+kjVzjqunEyoly+prdIp3xGNAqvlbLg=
X-Gm-Gg: Acq92OH8q2VBWrkKD6NYPewRvTIyW7oKkhlg6sGxSe9XoHNggFy5Ta1lY/XBeQRxFsM
	L0QALaek4VrIk30jcKoKQLBvRNMBayeG1TH/oPKvH9k60ba8kRTVTkQejDGjVzOI6ql0Sr4zWAi
	BGnF4967t7+OFoYdoGBffCGJeaw9U5GE1kYNB6CcV/WwVlpkyNDsktyzvN/mhgclHVHnKpE0Sgg
	vIpplyut0PDwzE7teMf9LSGT7aWNLVhKgvbaMkenvkLWO+3t6Hej6Hzs1KIe6uW52+dbq4E/xbw
	if5fXifdsxdnqIheD28n3Q4=
X-Received: by 2002:a17:907:b03:b0:bee:875d:af12 with SMTP id
 a640c23a62f3a-c05a09bc11dmr25587266b.0.1781626369768; Tue, 16 Jun 2026
 09:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616155716.2631508-5-puranjay@kernel.org> <20260616160409.F321B1F000E9@smtp.kernel.org>
In-Reply-To: <20260616160409.F321B1F000E9@smtp.kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 16 Jun 2026 17:12:35 +0100
X-Gm-Features: AVVi8CdKaboq2XwNC4hu_WdVZt4UvvXDyGLLztXHu06VCQ07VL0tsmlmXy4Rvtk
Message-ID: <CANk7y0jV89r++T_nN21FTCiuA6Twx+LB3jv+BzEN3+rzyjypJw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] selftests/bpf: Adjust wasted entries threshold for
 ARM64 BRBE
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 5:04=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] The test skip threshold for `total_entries` was not adjusted f=
or the increased ARM64 overhead, leading to guaranteed test failures on har=
dware with 16 branch entries.
> - [Medium] The ARM64 threshold for `wasted_entries` provides zero margin =
for environmental variations, making the test extremely brittle.
> --
>
> commit 08ff160f53fde2f401cb063e6cbc84b6bc9a9970
> Author: Puranjay Mohan <puranjay@kernel.org>
>
> selftests/bpf: Adjust wasted entries threshold for ARM64 BRBE
>
> The commit adjusts the wasted entries threshold in the get_branch_snapsho=
t test
> for ARM64. It raises the threshold to accommodate the ~13 wasted entries
> generated by the ARM64 BPF trampoline compared to ~7 on x86.
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot=
.c b/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
> > index 0394a1156d99d..8d1a3480767fe 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
> > @@ -116,13 +116,18 @@ void serial_test_get_branch_snapshot(void)
> >
> >       ASSERT_GT(skel->bss->test1_hits, 6, "find_looptest_in_lbr");
>
> [Severity: Medium]
> Since this patch increases the expected wasted entries to ~13 on ARM64, d=
oes the
> skip threshold also need to be updated?
>
> Right above this line, the test skips if total_entries is too small:
>
>     if (skel->bss->total_entries < 16) {
>         /* too few entries for the hit/waste test */
>         test__skip();
>         goto cleanup;
>     }
>
> On an ARM64 system with a 16-entry BRBE buffer, the skip condition evalua=
tes
> to false, but with 13 wasted entries, only 3 remain for hits. This would =
cause
> the ASSERT_GT check to deterministically fail rather than gracefully skip=
ping.
>
> Could the threshold be adjusted to account for the additional ARM64 overh=
ead
> (e.g., needing at least 13 + 7 =3D 20 entries)?
>
> > -     /* Given we stop LBR in software, we will waste a few entries.
> > +     /* Given we stop LBR/BRBE in software, we will waste a few entrie=
s.
> >        * But we should try to waste as few as possible entries. We are =
at
> > -      * about 7 on x86_64 systems.
> > -      * Add a check for < 10 so that we get heads-up when something
> > -      * changes and wastes too many entries.
> > +      * about 7 on x86_64 and about 13 on arm64 systems (the arm64 BPF
> > +      * trampoline generates more branches than x86_64).
> > +      * Add a check so that we get heads-up when something changes and
> > +      * wastes too many entries.
> >        */
> > +#if defined(__aarch64__)
> > +     ASSERT_LT(skel->bss->wasted_entries, 14, "check_wasted_entries");
>
> [Severity: Medium]
> Does this threshold provide enough margin for variations in kernel config=
uration?
>
> The commit message notes there are about 13 wasted entries. Using < 14 me=
ans
> the test will fail if exactly 14 entries are wasted, leaving no margin fo=
r
> error.
>
> Minor variations like KASAN, PREEMPT_RCU, or different compiler code
> generation could add a single branch to __bpf_prog_enter_recur and cause =
this
> test to become flaky.
>
> For comparison, the x86 threshold is < 10 for an expected 7 entries, givi=
ng
> a 2-3 branch margin. Could the ARM64 threshold be relaxed slightly to pre=
vent
> spurious failures?
>
> > +#else
> >       ASSERT_LT(skel->bss->wasted_entries, 10, "check_wasted_entries");
> > +#endif
> >
> >  cleanup:
> >       get_branch_snapshot__destroy(skel);


This selftest is supposed to work with the standard BPF CI config and
setup which it does currently, it doesn't need to support all
different configurations and setups.

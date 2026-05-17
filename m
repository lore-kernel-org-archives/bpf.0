Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABC22A1B2
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 02:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778986061; cv=pass; b=s0WW9YT80k9YIOakvUa2PpdIdcdqYCejLF4AsZnFibauNNqpTY8ma+T6XVpRMpHhN7ukVVck8CyZsquTOa3nv9OKJ36sXncD4J4IhQo+AJrVzkIN5MUN6k2XSoIw4DJHZq53RoOKXHKxwJs/PoYJoXfYnfdYrviOWhDA/cnEzFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778986061; c=relaxed/simple;
	bh=ruqx+4ZpoANkvP/6wJDfU22hj3FN+CW5zvVfsEmdrPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ws7Vw97DUcDIsGQdQd8ne4EUlDSOertUhLWnMm2jkuM2ktFQadU4nHChNIZ5ERHFJ79pzbnM6VbswLqdArMr06BCMeLJLE34cXJfMrIHGVu4Ignyqaz8bvGHIqIGl3GXLyGfSEd7GQ0CTb52DCPno92pDTRN6VZIjI4pEirLS7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXKAJI8e; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXKAJI8e"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a88de2b52eso1614412e87.2
        for <bpf@vger.kernel.org>; Sat, 16 May 2026 19:47:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778986057; cv=none;
        d=google.com; s=arc-20240605;
        b=e7bYVDLk5NUpjoiQ1+LY2ew8d2IFY0QJ+b+qwGd4sYPEzKYPCEdlD8n2bGoEcmKV2u
         W3r0+x+DDUR0M9N1RIxWILfwiljl5yzQt3fdiNlDKGeZ/FqynjH6+La1R3EZnnss0B+5
         ovvTjb3dKPkq1Q310gMg0OL9KlJT1a4q7Sxg9aUAGLisSzIGwB6BOpDBegIDWEH3DWtg
         vD4g82ZkR1j/HTIOzJKOR6Mt4IAR2X67VycIU958eQz6DKzI4DFH4scTtNTybGC/n+0f
         IPFf5bPVe+2999L4Bda40rcDAphHBzLaOCjOIvRrNx6g7ASFWlAMXvJ0ttXqHhK+hOnz
         sH+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AkgMTYERqKYXQClsS+xJ7UBlWslErJcPF/+isJjeW08=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=GUagpI7JjujZeCTfKsC9ujaz7LQ82EzVSg1tkeZXSfdHjGs61i7NQPT/BHst56XNeX
         ZaR4JBxnGzFLdehGeUCLhOsySvlJ491fY0ukJE3BYV4n7L7lkW4uduBaxXn3G9eTUJTB
         EHXYKTsEKvMWGqFCNTODDIU4mMMeB+gtXSKOmZ/MktbiPCLOtvmqcj9M911Tw1okHal5
         YATy4BhkrDhZSObC7OO7OezsoRTUBGcwjE2e4rdeD7pmx/ZmdRfjsM6tv/yn0jfUBXC+
         XcHR9gDyhJ61wiXJsg0Q9u62R5r4xUkRynocfR4Teg9kJHW2bSRaXXrHCzx/8/UydBdV
         np9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778986057; x=1779590857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkgMTYERqKYXQClsS+xJ7UBlWslErJcPF/+isJjeW08=;
        b=hXKAJI8eSzJ+Xi7UpyS4fP8FiG4gtvr03gDbQPNghX8sPG98az7E9tAihReiaBVCR+
         bx7aW0XrhnXmCfdJ2nhWGddGK0aMlHKOLPKVnPt9GEMcwaQdLE70T9cTMchN1JqznQ4E
         CifVBBRd6zjyYfJ16Ml9ZZ55TVWeIzExS4xfzDhRmortfBvmBQWxMU5adnWoFf00mZfk
         6ztuwu1ckCaB4ejGE35SudoFo5uY4KVfDUAgGQ7Xf5uo5y4Yg9ym/uSWEUgMTrCqAhhw
         s08EMLcMK5L8w2RHB8jeVojthQK4H0jiAPvC8HrSUhAOeVbgin81K7Do4PkPibpksMEy
         kG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778986057; x=1779590857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AkgMTYERqKYXQClsS+xJ7UBlWslErJcPF/+isJjeW08=;
        b=nvDjUclZ4+fIxvIZKEqKuIph9sXkdeTj4SfaXRt0bUTC7OgRuDhu0ZMe+GYX6pG4c9
         cp1Tqe/jUihfiJQfvGS2T4/I5Z50WIA2T2tgL9hwuj33LjpN/cvkEa15Ie1BNz5tVSa7
         oX2/JkSOk3WARwTi3OHSrtiimNLNQbCMqCh1dBrCNY6gSlut5aTKOwXkynSJRpDcE95V
         jRNsfnriVTLmZViC6kmH0Oq4NWkFYmTb0JupVbeqgbtFp/9jp0Qt8n2JiRPUtr7x6lEa
         1SicV3L+PX3mOMRPOubLWgcVX5Kf4IflErBT28RURpA3MsarWxmoJ/0fujq2ISbMEDDv
         kRcw==
X-Gm-Message-State: AOJu0YyXGQ8PhWjcmi+awb4Exl/4K/c3ABl2CJ35xNevvsygexUl72DZ
	isvo3tDvD4oVKDLhcq/TO7rtiwMOC2gm+0WFWMycM4re3WYwpCMxtRFvP0E105IUGdxm8Bptfqk
	8NwoPBiD8O/lXY3/CC+fC6Ou8YbcmRjI=
X-Gm-Gg: Acq92OG3DfqXVo8sm8GqdVQa+TngqWOYBHxMA1AJDj4JYoaN8Ss+T0hBgDBzI0zt3DV
	Znbxdmr1OFuqZL1T+n/k7F4oKHE85ZErrzI9l07hGY7htsJz5McGN6uMr7B1YixEGh8/7cgPs+3
	YZ/E2nBD5pQhLeMRFPNhagU17Jv+eRke4S/0WP0uW/RwiJAt3/9TrgZ+Yog0mVirWfARQWDnGO/
	jZv81LXuI145/zUwFVAsyhK8XJKZLRw35UagnAtl1mdu0xA1j9rbHaDlHX4pKOvJXURwz+WmoWO
	NxUdfoHbqME7bMKtI15EEVhxPxR736e0kUJYdO4=
X-Received: by 2002:a05:6512:3984:b0:5aa:b6a:738c with SMTP id
 2adb3069b0e04-5aa0e746aefmr2780889e87.42.1778986057362; Sat, 16 May 2026
 19:47:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515123018.80147-6-kerneljasonxing@gmail.com> <20260516123128.BA67BC19425@smtp.kernel.org>
In-Reply-To: <20260516123128.BA67BC19425@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 17 May 2026 10:47:00 +0800
X-Gm-Features: AVHnY4L-iFokiRPqgurbcUPmAx3pih_JT3mO7CvkXys8G8Yfu1U15wZdD3zX83w
Message-ID: <CAL+tcoB=cW0tuoJLfoRKoNX2rYSTcF_c09nyZqq0ZZQEJHJP9A@mail.gmail.com>
Subject: Re: [PATCH net v2 5/5] selftests/xsk: fix multi-buffer invalid desc
 tests for drain_cont
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 16, 2026 at 8:31=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [High] Premature exit in the newly added `wait_for_tx_completion` drain=
 loop causes the test to silently strand valid packets.
> - [High] Clamping `outstanding_tx` to 0 in `complete_pkts` degrades test =
strictness by silently discarding unexpected completions.
> - [High] Unhandled `EOVERFLOW` error in `kick_tx()` causes spurious test =
failures when the kernel synchronously processes invalid packets.
> --
>
> commit 51fe3cee29ff3a261580a926424f8e6171690b0d
> Author: Jason Xing <kerneljasonxing@gmail.com>
>
> selftests/xsk: fix multi-buffer invalid desc tests for drain_cont
>
> This commit updates the selftests to account for the kernel returning CQ
> entries for dropped and drained multi-buffer descriptors. It clamps the
> outstanding TX count, adds a drain loop to consume extra CQ entries, and
> modifies test descriptors to stop drains at packet boundaries.
>
> >     - wait_for_tx_completion: add a drain loop that consumes CQ entries
> >       after outstanding_tx reaches zero. Ensure remaining valid packets
> >       are transmitted. This change is made because of patch 3 in the
> >       series adds a logic in __xsk_generic_xmit(): return -EOVERFLOW
> >       after detecting and handling the remaining part of the skb.
>
> Since the kernel now returns -EOVERFLOW after handling invalid packets,
> will kick_tx() abort the test when it encounters this new error code?
>
> kick_tx() is called by complete_pkts(), which checks its return value:
>
> test_xsk.c:complete_pkts() {
>     if (xsk_ring_prod__needs_wakeup(&xsk->tx)) {
>         ret =3D kick_tx(xsk);
>         if (ret)
>             return TEST_FAILURE;
>     }
>     ...
> }
>
> If kick_tx() does not tolerate -EOVERFLOW, this might cause spurious test
> failures when the kernel synchronously processes invalid packets.

This review was made on top of 0003 patch. It breaks previous usage
which means this review is no longer valid for the incoming v3 series.

>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/=
testing/selftests/bpf/prog_tests/test_xsk.c
> > index 7950c504ed289..488ace93ff663 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
>
> [ ... ]
>
> > @@ -950,17 +950,11 @@ static int complete_pkts(struct xsk_socket_info *=
xsk, int batch_size)
> >
> >       rcvd =3D xsk_ring_cons__peek(&xsk->umem->cq, batch_size, &idx);
> >       if (rcvd) {
> > -             if (rcvd > xsk->outstanding_tx) {
> > -                     u64 addr =3D *xsk_ring_cons__comp_addr(&xsk->umem=
->cq, idx + rcvd - 1);
> > -
> > -                     ksft_print_msg("[%s] Too many packets completed\n=
", __func__);
> > -                     ksft_print_msg("Last completion address: %llx\n",
> > -                                    (unsigned long long)addr);
> > -                     return TEST_FAILURE;
> > -             }
> > -
> >               xsk_ring_cons__release(&xsk->umem->cq, rcvd);
> > -             xsk->outstanding_tx -=3D rcvd;
> > +             if (rcvd > xsk->outstanding_tx)
> > +                     xsk->outstanding_tx =3D 0;
> > +             else
> > +                     xsk->outstanding_tx -=3D rcvd;
>
> Does clamping xsk->outstanding_tx to 0 mask underlying regressions by
> silently discarding unexpected completions?
>
> If the kernel correctly generates CQ entries for invalid descriptors now,
> could outstanding_tx be incremented by the total number of submitted
> descriptors instead of only the valid ones?

Yep, I'll fix it.

>
> Tracking total descriptors would allow the test to use the existing
> timeout-backed wait loop and eliminate the need for this clamping.
>
> >       }
> >
> >       return TEST_PASS;
>
> [ ... ]
>
> > @@ -1293,6 +1289,14 @@ static int wait_for_tx_completion(struct xsk_soc=
ket_info *xsk)
> >               complete_pkts(xsk, xsk->batch_size);
> >       }
> >
> > +     do {
> > +             if (xsk_ring_prod__needs_wakeup(&xsk->tx))
> > +                     kick_tx(xsk);
> > +             rcvd =3D xsk_ring_cons__peek(&xsk->umem->cq, xsk->batch_s=
ize, &idx);
> > +             if (rcvd)
> > +                     xsk_ring_cons__release(&xsk->umem->cq, rcvd);
> > +     } while (rcvd);
>
> Can this loop exit prematurely and strand valid packets?
>
> In asynchronous modes, kick_tx() wakes the NAPI thread and returns
> immediately. Because packet processing happens asynchronously, the hardwa=
re
> may not have populated the completion queue before the peek() occurs.
>
> If the queue is not yet populated, xsk_ring_cons__peek() will return 0,
> causing the loop to break instantly before the valid packets have actuall=
y
> completed.

Right, my local AI also spotted this potential issue when running in
the physical test env. So I added:
+       usleep(100);
+       complete_pkts(xsk, xsk->batch_size);

Thanks,
Jason

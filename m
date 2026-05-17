Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E6578F39
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 06:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778998563; cv=pass; b=anXlbnDQsCOz02nLnSMi2XzPulDbWSEQGSbCFRhUiqYdCNCY+FWZLCzY+fzCcXBjnXHYTufvp+NAkpaIyYVNSQJ+YOTZblC4OCJL1933ZDCkc83X+OXiNYK9nJD6bPg5zspafJBKjgTpyPTjmKXlvSsmj0iEi7/DI75xjMSMe3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778998563; c=relaxed/simple;
	bh=KQwepD6izLpoXVuCEseHVqNDIYjLt7x9FUc+tmd2nvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CmfDhJoP5n5Fr4tjdTBL4Zinsws1OeU4VSkTKKKDzjNV+yk9PraummeLgY36RkAmmC2XyeJHLk9/e6BPSrCry/S3Fip1tUiZ6d4IxSfbRgBtBGmV6wrJUAkKRmMywxkEBRVlphYfKwS2iGTF25chA6TZMB5taWVrcIXdASCT2A4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBHC27WL; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBHC27WL"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a8d1f43432so2033111e87.3
        for <bpf@vger.kernel.org>; Sat, 16 May 2026 23:16:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778998560; cv=none;
        d=google.com; s=arc-20240605;
        b=K/fFsmSbwqp9LyCT4TLRdaGBtS0kwXvSWwteuYkxoKI+SJ0hyDS60eexIWbOaJ11xO
         dKozRdC0wevXHatjkQ5mLRVrZ0Q+7kmbV128dXOuwuBfoGCKYA519yUCWjinWWkJw+ij
         SHCmbq06dSlr1PQIxja/w7FiOhm/aL0SrsXysLdfC5gQgchVMw2nJhmxbf2J6DP80fFE
         1nyIwRYtmMlKiVE7qnDZqDcG2X0vdNyPI1IirGmirje/tERaui1+3ysYprQ5nI26yqWs
         nSLNWk4pV1D4rg6OJKGXv/NaZwcPkkPX7Xdk53w7/Zlti+QBNc4NQzNmp5mmWQLV9cfV
         MeOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cZb6AJaZ1xadPD91ePgoZT8bZhlU06q0reAG9tkJInc=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=kQt45Jx7SuyCZgt42nb4QYa/QU5lN6RYeVXAk5J7UZo625e/DkrqXTf/CTdk/eHXJK
         rzv1O6ff7rU+GcNf/LFComsGYIguS+SRQJ1HpHqOVTXUd/5ghElKlUy8ahNIGWtE8Eno
         65DhnEiXNG7VmtK/0AAN54YxtHUTTu2LCzPMsADYXsHQCq+tn1UYrHNIhZAPlWWLgbes
         U05pm5ddk86QfeyLgf3NlRmGmj5VctVU9U7my3prgQoVZ91e9WuULNiiuioR4xqIkrlb
         eRkMFs8NVey71V5GqI2kBPtbxgnWGKtNVcPgaJxmKGynxX+G+TRQ2eMNP7L2gUmLPWZG
         GbDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778998560; x=1779603360; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cZb6AJaZ1xadPD91ePgoZT8bZhlU06q0reAG9tkJInc=;
        b=fBHC27WLVk6LHB8zKQsgC6hlMW/JuZWozVHRBDeJFehDUfZQB/sy9EhmeVTmjK8plP
         XFR37Gl+LnIFh4yqZffBzk/srnPg9fgqLhh/b0PdzkJ2f4rvhcXAQBDAdTurCdQdge9f
         yq6E2SD7FV9ZuhTm2ojT7MVSvgu/SGh/WeX4n5lzzCTYB1W/F1sjJjqexhXEhU43jfTC
         Gxt8FSxdcyE8FNXN0GYzs/piAJrdntCULSKNPBhN2AMn5U9+Qs+Fwi1nm4SyywCggSzY
         DPgzcTdSWg8nmbeAKIqHRhDc6yEuaL7Y4vOaUkP1XS33cp+DHGt3SiS/KyItmsLRVMnw
         lacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778998560; x=1779603360;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZb6AJaZ1xadPD91ePgoZT8bZhlU06q0reAG9tkJInc=;
        b=O1oWMZ7F+F9C1Zt5RMJdMVSB0/SEpQeY46UfSjQDx90Mv1StV7tqGeHNw/S1gRNL2J
         VHozpDC/Afvan1PXHzsefD7NqfeTleCEehOlQoVIXi9B0p18DtEJ0TgDlBagJPul4GsH
         BX0vH0DmqQ1gd6NIVK1C+lKNFPL11KdED+95AHtJAf1yy+isJY9WQYQOJRAjnZO98voA
         v2cjSlHonBFxptfViN1TtHXmysEkURnBJtkSimkUTN+rauUtogCrtfAoG97sLwtHIgjU
         VKCmVoBdszA4Yiy0tyqH+4HFAfE0/6VzrtX9+6Gm4JpCdcA4zgCzeKZBmFCWWnKnKLzh
         BR2A==
X-Gm-Message-State: AOJu0Yy6ggdxICuIexH67glGLqUB0nT+BD0PxdUXo+rO9WLOaooj8XvY
	anMgwYNgeORZGI79OptwaPr8xIw8ik5woNByXHBbKihhItLaoqvJoDUf1NDQrfp69wMLeeODFEM
	83b/SioFqV0dgqOKajNVe4MUMhpDqBoTTzmA6RzLpLA==
X-Gm-Gg: Acq92OEhwo9vk2A9wLIg6HWcoi549D1sZXHjoKpXN0ektdJkIlSWNcbGsyOkmgE+NS+
	1p+Xu3pcy2Uda8mLzk3wjQw9Z6TBo0f8FziF4BeZoaQ0q1oSWHp2CYq8dOXx3ZEeuljkzuWjj2/
	R+v7jt4QpvztbDRaPe2tKrp2LnRfopBOrKL3MhWnL8t7RvvwvRnknZkRlGB1pLza2BzjLBaNr6L
	o9emChddKVZUpAuSsGMv9uE8edp2xStorYp/C3syOq8PwK4aCfLNXt6JKm7IhuRg7RYkPn7DRVD
	x0Cp8A2kZv2YaoS3fhsl6d7V8p4+QOvb6ajEoyYwHIwQQNGRRw==
X-Received: by 2002:a05:6512:128a:b0:5a8:65ce:e83b with SMTP id
 2adb3069b0e04-5aa0e60cfadmr3117551e87.7.1778998559852; Sat, 16 May 2026
 23:15:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515123018.80147-6-kerneljasonxing@gmail.com>
 <20260516123128.BA67BC19425@smtp.kernel.org> <CAL+tcoB=cW0tuoJLfoRKoNX2rYSTcF_c09nyZqq0ZZQEJHJP9A@mail.gmail.com>
In-Reply-To: <CAL+tcoB=cW0tuoJLfoRKoNX2rYSTcF_c09nyZqq0ZZQEJHJP9A@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 17 May 2026 14:15:22 +0800
X-Gm-Features: AVHnY4IzglYJ7hA4FzDnVyoltczY2JD9hsjiM39e-19Twt4_xVRlot1zyCdw2n8
Message-ID: <CAL+tcoD0VbrgdZYv4Nj0kgvon6RUXnXbWjoxcgCQ6qPanqR+7A@mail.gmail.com>
Subject: Re: [PATCH net v2 5/5] selftests/xsk: fix multi-buffer invalid desc
 tests for drain_cont
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > > @@ -950,17 +950,11 @@ static int complete_pkts(struct xsk_socket_info *xsk, int batch_size)
> > >
> > >       rcvd = xsk_ring_cons__peek(&xsk->umem->cq, batch_size, &idx);
> > >       if (rcvd) {
> > > -             if (rcvd > xsk->outstanding_tx) {
> > > -                     u64 addr = *xsk_ring_cons__comp_addr(&xsk->umem->cq, idx + rcvd - 1);
> > > -
> > > -                     ksft_print_msg("[%s] Too many packets completed\n", __func__);
> > > -                     ksft_print_msg("Last completion address: %llx\n",
> > > -                                    (unsigned long long)addr);
> > > -                     return TEST_FAILURE;
> > > -             }
> > > -
> > >               xsk_ring_cons__release(&xsk->umem->cq, rcvd);
> > > -             xsk->outstanding_tx -= rcvd;
> > > +             if (rcvd > xsk->outstanding_tx)
> > > +                     xsk->outstanding_tx = 0;
> > > +             else
> > > +                     xsk->outstanding_tx -= rcvd;
> >
> > Does clamping xsk->outstanding_tx to 0 mask underlying regressions by
> > silently discarding unexpected completions?
> >
> > If the kernel correctly generates CQ entries for invalid descriptors now,
> > could outstanding_tx be incremented by the total number of submitted
> > descriptors instead of only the valid ones?

Well, this assumption doesn't always hold because
xsk_cq_cancel_locked() cancels the desc from cq. I confirmed this with
testing - switching to outstanding_tx += i causes 6 additional test
failures.

Since this series fixs the wrong behavior and publishes the
invalid/overflowed desc into the cq, outstanding_tx is no longer used
as the verification in selftests. But it is still useful, like as an
indicator on when to kick the txq.

Thanks,
Jason

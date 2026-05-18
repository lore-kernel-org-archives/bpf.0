Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3940A305699
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 09:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095989; cv=pass; b=btKCIGx3pFnqljwa3bgy2tS5DpK2WcacT1MQk5Bj8wd39qs3nPygHlVLVyQRIrloFfDIuqTHlS0/oYtblunqlAIIF9cwM0K3EQFCLlBSkkv2ahPH7QYSy2ewxFq2gHY/PQ8C5u2R7JgAZXRVR9yKs5kjOIw1xlQXPA8tZrroVt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095989; c=relaxed/simple;
	bh=CnwT4/j5fv+DeDtRFPNWlL8z+nuZTW/Y6juMWgr5UTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XLEdO6TGGTsEdh4j+Yntqn2hx9LeT5ztDOjucLPnTQ7JkxRzL7FaAVtn02SGGfWD3Z42GeROxCW8ljBfYP68dwIM4yjcGmf96/SonaLwc+OBTgE1wiquC0CBemy2kSq90rewGUbWP3VkksHxxD5zbSurIXro5TmX5fpwOIcy0tA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pQoRAauH; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQoRAauH"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a8dc2606a0so2206838e87.2
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 02:19:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779095986; cv=none;
        d=google.com; s=arc-20240605;
        b=N9s7Swz3afkbTHONXGUiTmVUfxWFFn0ReY6Ug96uPtXTne0m2jJ/B7dJKNOQlXK7hz
         dsA20iFPjTr3oSzsUiYIWPDucQP9sxx7fN7GzBxI8wGKSEDPrZYpiOTvGGrkTSJkD5I8
         5DY8PFjIFnfbQ5p7Gh53RytSmOFUyYcAO+KK9NHdXJ7vJLdkrm5nWMaX2lj2UVNHKGKm
         QQ4Ct73rFHD/IdL7dg6tPDlm4vsF5NTF9Ci1mD5BgVphU67qFvb6lC1AIRE0Iaaabr7s
         6E8oiqlxp9iEESII1aVqBxDlMIAPzijXwHwe7bLulaCFTP19PfavroPDJNgFMdnRt+D3
         G7ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8oKVlndyjRSm5d1QJ38g8kShcN69mqPrJOMQfWnQBQ4=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=lRpdxLnawu/s2ftgAcGXx5Vkw4QXpxvxDNtaRjgdUtbHdZfesNZ2ffMkv+KBYyMWGv
         c7RwG2AjdO7FIlA5Tsc/Qs0oCLkJScb8VPkC5m8ehGFJcEAuIw5E8HUpOW1qarHcj+ox
         2YufewXMmd3tn0tS3NEdMbu1dbCbqhO3NfqZSGnk6Ehm0uPO91bmsSAe1LAtUOeb7YOL
         KOkuJHP1zz2mqMkuK6NqzhNrOGCkz0Muw5SXm8EFeaz+DVY3HpRrxedoPW7HIptChDpc
         Tted41Edo50BoQ+jb0XHQbsHG+QLS9WnN0cuXILmB2WQYwD0ooLpw5riDFDJZ9P/4HfD
         GG+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779095986; x=1779700786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8oKVlndyjRSm5d1QJ38g8kShcN69mqPrJOMQfWnQBQ4=;
        b=pQoRAauHHN17HhVVSDDwXxBvjwMS9MQYYnzV/aJbYdo6/zK9XTTH9IPT0X9sia4gg9
         0QQW2Uq7UQSOccOh+2k8G6BPR+LwQYYbw7k25oPpCq9eTperXanQufWA8gXAYy1uWjpL
         o9qq04wkAUV8Pa2u9cCHv9MBsr3qRvBGjo5mIScO1f7aBbXbo1yMAvR5zecL7fYLIvTU
         yC1GDjb0CczhNOqudksAxVmxnDYMAqqVjK+Ki9nuYAW7wyz1/ih7ODW/7yNULG5C/4IY
         GMwEeqNkg8Umjkj01JjkK84+JSNxMJ6jblwk1ut5wiCRxSR1pBtmIsUEOO2sfPIWr83x
         VPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095986; x=1779700786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8oKVlndyjRSm5d1QJ38g8kShcN69mqPrJOMQfWnQBQ4=;
        b=spfXdTFxt+KUyqqYVvdpiGobTPdWLoVvJ243LtvD6R/jum+2JLdUzTiyTbRb3tVaPE
         dMCcZsKyLm6qZk4kYOLVycvDXNKkLrrD7ENWHbQJ3d8gaF9nngqOGV4jWwrlEMUyGc4q
         nmDkL8EdcOzL/ycODAqqj7oSEGQqXsb+c8vYthe1e2fHSH79MrMHqC9L85vow1QYoVou
         f/AuTKphV5UZdflJXbwYNYdeCWaOiCPjq6kDCtUsAuO7ujVkiLE2oT2rzNGGYWDkkQie
         yjkqL1rT/5uQ5SJsBoBvdia+WUeZNUNsMsewA1B7oF3J//qK5jP0bhpgWyJ37vAbIofw
         zvew==
X-Gm-Message-State: AOJu0Yyoh3CwqHr5k6l/uhqplSu+GmQWNI5tOY0j/S7el58StVfxv2aw
	ID3XBxJRCV0+B/lfxK6bZVbd/mv6nns61IdY6iaflaoAJL/J3Ig8eXS2fy11gk0EhwFyV1Y6/lt
	NflUFVe/qcSD3myuNz2Sr5dvEOX9vrsViL8+RztoKVXrA
X-Gm-Gg: Acq92OEG6q5btEeXBRw0Jiy9PwAaSXNJeXjwYgzQdZcrqAhCG4pj61dxhTF0NIjkXkf
	vHYlLVqe6/zLQIbhK5og3o3x2j1U4GarR6ZOyQNg/NrnD9vM24szh6EoBoliawAS6LUXh43PseU
	aSgjwv9IIE9R0JlP0OvP25JSJnNtxIPtX+nSr9n415k24UbpN2wtLvlAi1lQnqwnaZzDA/rKTC4
	hlvhf7MtaMTX2x10mvRhdfgmPmzJ8kbNZATSL9+/ugd4/3qAGTgqn08UcOY0SZoG+ULQXoxYdjo
	Gstmr000gJWvl9MFJzCd0TKw3/OTtdl2GnD9R7/r
X-Received: by 2002:a05:6512:400f:b0:5a8:97d7:8c45 with SMTP id
 2adb3069b0e04-5aa0e73f2admr3639645e87.36.1779095985952; Mon, 18 May 2026
 02:19:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517063311.28921-6-kerneljasonxing@gmail.com> <20260518063408.EEA18C2BCB7@smtp.kernel.org>
In-Reply-To: <20260518063408.EEA18C2BCB7@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 18 May 2026 17:19:08 +0800
X-Gm-Features: AVHnY4JpVNBI7i63KPNT8vcPuVNlZxz95g7r0WhIXmRC5pRncmxLmDuftdPRNG8
Message-ID: <CAL+tcoDzmU942WOxeX7j=fdn8Xd_itF55=bg0RMv32+Bfx_wbQ@mail.gmail.com>
Subject: Re: [PATCH net v3 5/5] selftests/xsk: drain CQ to wait for TX completion
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 2:34=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The racy drain loop in `wait_for_tx_completion()` can exit pre=
maturely and fail to drain pending CQ entries, leading to test flakiness.
> --
>
> commit 25f4d14929e097cf7028dd26ec4e4bae16aa1a5b
> Author: Jason Xing <kerneljasonxing@gmail.com>
>
> selftests/xsk: drain CQ to wait for TX completion
>
> This patch addresses test timeouts in xsk multi-buffer invalid-desc tests
> caused by dropped descriptors publishing their buffer addresses to the
> completion queue. It clamps outstanding_tx to zero to handle extra CQ
> completions and adds a drain loop to consume remaining entries.
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/=
testing/selftests/bpf/prog_tests/test_xsk.c
> > index 7950c504ed289..1f196c8ebc738 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
>
> [ ... ]
>
> > @@ -1293,6 +1289,17 @@ static int wait_for_tx_completion(struct xsk_soc=
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
> Could this drain loop exit prematurely? If the hardware or kernel is slig=
htly
> delayed in posting the remaining completions, xsk_ring_cons__peek() will
> return 0 on the first iteration, causing the loop to terminate immediatel=
y
> without waiting.
>
> > +
> > +     usleep(100);
> > +     complete_pkts(xsk, xsk->batch_size);
>
> Relying on a hardcoded usleep(100) and a single complete_pkts() call migh=
t
> not be sufficient if the hardware takes longer than 100us or if the numbe=
r
> of remaining completions exceeds xsk->batch_size.
>
> Would it be more robust to track the total number of submitted descriptor=
s
> (including invalid ones) in outstanding_tx instead of using a timeout-bas=
ed
> drain?

No, I tried before. It caused more failures of xsk selftests because
not all the descs are published in the cq:
1) address-invalid descriptors are silently dropped by
xskq_cons_peek_desc() via xp_validate_desc() without writing any CQ
entry.
2) only drain_cont descriptors and successfully sent descriptors
produce CQ entries.

Since we cannot predict at submission time which descriptors will hit
the drain_cont path, outstanding_tx cannot precisely track the number
of expected CQ entries. The do-while drain loop handles this gap. That
means this current impl is a conservative safety way.

Thanks,
Jason

>
> > +
> >       return TEST_PASS;
> >  }
> >
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517063311.28=
921-1-kerneljasonxing@gmail.com?part=3D5

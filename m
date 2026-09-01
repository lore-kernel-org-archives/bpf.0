Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6214F32B12C
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 07:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788249136; cv=pass; b=qe4XSmfrUHcGFSvUlHehMRDRCCz9RHAnIsqtK1w+yWhIU5iPadoN0b5XKz+jPjx3vUJCKjndz09Pw11dsq7X9kV3eQSIiz0yMCtlfyDQWRJUunaflafc/hhuZ23nbTfrv2ArD3ve/4///NkcEYITL3yQzqN0osI42E7VviGh1Lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788249136; c=relaxed/simple;
	bh=f2SvoaHMBY+e2yeANZCKiFHFNFiVIrmBjpjE6bEI1SM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9Z59xrbp1B77ZIz/zObyNvJlcClmyMcEN0OR5eAqGC36VZTUju8+ti5aqWtOK6Hovae9yxtJTNKrr2cbgeSfMqmHcG0BSd/MDq4JIviUNnAph9EAHYDeBeBONW2rjt19Sx8mCakUin3o0Hw79CI5/tTU+goLn1M/dgTTb94Oe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qzNv2LKG; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzNv2LKG"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b15dcaca31so3651099e87.0
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2026 00:52:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788249133; cv=none;
        d=google.com; s=arc-20260327;
        b=JB0Fb1r30DoatDGO+bkxC35ZygmLcj5Rx8ayy6NU3kau7duJXnsIhxDOm15sF2G49a
         wctHp6Kn6xpgVTIOv803Y1grX6fi+bFbdM1yI6bG4BjMKYkwQlpsIAVBGrGD0WqIVzEd
         w4ZGaOL7mIKPZXKq9YHwz4NKutujM9aABcVmA5Uee0/3MF+tQCsXnL5EzUJzTfJLHVDd
         O0dl2ywDMaTDanE6/nZ4ygDSsfOX+86tGvFNUIoHuo56FxkXhiougOZU8PoUVXMRv0ra
         G9Mzt0l0XGGtuwWq9HI8eI09bbopX2PXl8GtBb7x8kVOBuOagYvUTxiowCZXU31M5k5F
         ayxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f2SvoaHMBY+e2yeANZCKiFHFNFiVIrmBjpjE6bEI1SM=;
        fh=tv21s7YL6FZyNwd9tO/JhxTIerl7N1fcxLGUckKensM=;
        b=T9kNQcNnMNtLxhYevajA78kUgbL9b3eAanWaG1UVKeRkydCA9DnbN3un7xqA4QPXcO
         s/39ywUCBXhNxXVJorUTNLy5D3JePakcfJ5vQY3fcc5obn8D3I+T/VJd62SrWv1OIhNx
         dNpLU269PEQnyG7munKZb14H15jAtuZbUw+PaVfVQOSIqzUXIHRtchmb91clzcXQCKfl
         BzCk8ikPO0W9omH+uRYFF5apCUoa80zk/A9QYLMbCSBt9p1a65paxqJkLOLdgekl21xk
         WlfHVew3oWrxrYVdevCDZFFA40h/bOQKLBzIDmPPm8Vs/MqGAM+oKhGHpvw78iVszSYQ
         ecZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788249133; x=1788853933; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f2SvoaHMBY+e2yeANZCKiFHFNFiVIrmBjpjE6bEI1SM=;
        b=qzNv2LKGDZvj1zdDnLPE3PAKVegxutlBKDQwTM9GCP3UqCwBSX+A6UQsJeGw6XfpZV
         2lyPZW9CWeoCRZyBjg1QU/pt0u8PCkWBgSCE2g7VJQ4Pp8l2ET0Z8ITCsGLC6htCbNIN
         MO1uAztFG/KUoEqc1cpnhVFIWyd7w+fqytXQObDRg2cQKpaHyYd50rUlis/accxvFy27
         RRHSEi1DVTv7tszhx6foujhzCbxNJVB/ZWJeFsLeyavfS+jkAZwEtflJdBMKMSci0kLx
         RVt3BwmDu4/CXmikNeo6tvAKrvARpKffgwg8yVChVAPwqgB6R2GYZXRDcokIaeaWkA1j
         hihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788249133; x=1788853933;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f2SvoaHMBY+e2yeANZCKiFHFNFiVIrmBjpjE6bEI1SM=;
        b=p300j5xG37ev/Juc+yXY7tB7PIFvn+GevZSXBsyxnn95fFAl+oaBGFC/a4s0MwXD/u
         hN1au/e18I44CXOsQlI7jFJqPCo7/YthfWALfQV24Qbezhp7c/4qaYV+kPzjHdKQah3W
         OL1th9qR0xTUQ/LR5i7vhmj3epxnFxjSi1h21nDGqFtoooIQFMwfx9W8McG6/e8yAXRZ
         qJs4TRdb/yir/901Nl5euZxibJmRjXBhS0ire1mx/6i7TTTsKR4JrtyWY7VaWaATTTBZ
         CeQsPXiJ2gyjceykkAq5QzlF6of2K70VFzpBVg7idET+kQxgy2FdmxYIe/XkzhC5ayVn
         DK8w==
X-Forwarded-Encrypted: i=1; AKwUvBx7wjDyCPzKSSdmpPxQX6DA8iB1pTRwr0LYH/dDGfSjuZ635bxMduqS2FlNnIm2APJ61Ok=@vger.kernel.org
X-Gm-Message-State: AFuF++m1L6XFyL67HM/zV+TV+x6C5A0KWwrhX405VBo9XPnww159VDhh
	tIH1pUsqPNHdjaAZUD7nEkPEt0IIvm5eqWB3FiMQh1ymHBP5FOrEU0kasXYxA9pYH5KE4FF93q9
	XFR4yh+71prZ58jqUsDFmCa+at9Q1BzE=
X-Gm-Gg: AYBFou3hDw6MBZpV/jHUNkAMsz8/6Rqa6x2XU3yWtTl/kz6MsPsytBx5mo1eb4+cLee
	zNJnGC4S9KsLErqbd7EAbuSjpO1jOR664Nm1zcXIs37h/ayG0lK/edIUIDKznK1htgJjok49Uw7
	90kor6L8QGtT0nUvuCvZ+5vl2qKnWLzsT1eA+MUfE7CLAVwrDK1OMuyfoA77x2YjEK8qgk/P/rC
	xTf5nA412jDtWKxyHnJewVgbhZmNquqc6SFpKkhojRXFLV6TJsUzssKi0RqFnTyJVjtwbYipDA+
	9VA4KLc4Xt8JtYDqjVBSNvnABWRnZbHLs2hfCn46isiGPrgf0SwSg4SDDt6ef91Cp8HY05L677c
	SPgOqtjC1rvIDLTBlR3q8OUct/0dbEVk18l7i5IGAzzNEe4pWwNvNxMx2Kw==
X-Received: by 2002:a05:651c:19a8:b0:3a3:364:f789 with SMTP id
 38308e7fff4ca-3a3396a1515mr14100661fa.13.1788249132694; Tue, 01 Sep 2026
 00:52:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826012052.51028-1-kerneljasonxing@gmail.com> <20260831170241.42be3376@kernel.org>
In-Reply-To: <20260831170241.42be3376@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 1 Sep 2026 15:51:34 +0800
X-Gm-Features: AcwNN1V51y4KlWVOYUVZKbQZ-CUBVvL-G8CKpu_Nc1ByFljrfLbX5o3XONxfAYM
Message-ID: <CAL+tcoA43QntBFMCXcK5z5YPpRKKY5QDV7fv0zLhrL32trvWqA@mail.gmail.com>
Subject: Re: [PATCH net] xsk: set network header on skb at generic transmit
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 8:02=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 26 Aug 2026 09:20:52 +0800 Jason Xing wrote:
> > Fix this by calling skb_reset_network_header() in the common path to
> > cover both the copy and the zerocopy cases, so that network_header
> > points at skb->data and skb_network_offset() returns 0.
>
> But you're setting it to start of the frame so most likely L2.
> AF_PACKET seems to probe to find the true network header.

They differ in this aspect. Because AF_XDP unlike AF_PACKET doesn't
take the responsibility to insert a L2 header for the data that
application tries to transfer.

Probably you refer to transport header (skb_probe_transport_header).

> IDK. At the very least the commit message should be explaining
> why the fix is right instead of the slop explaining the path
> that triggers the crash.

Thanks for the suggestion. I'm going to add the comparison and more
detailed sentences about this.

V2 is coming soon.

Thanks,
Jason

> --
> pw-bot: cr

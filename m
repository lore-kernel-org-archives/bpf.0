Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A60F242D84
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 01:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773798213; cv=pass; b=qqBELl3xQSnMd8OZUWGMXrTNlU40uqcTHQvuvNhj+Oy6SRPKhLVU+HmK37SG74upRxaA3E55PJ3z6HnkE4Ladj2BzfZ1T0oh9XyAMV0Mb0oNcN/gf/jJTq/SVlveOqi291Y9Dreil7hOlhNUuDehPMMC5ZS8JzKsy/j6j01gguM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773798213; c=relaxed/simple;
	bh=7BhHAefvtC4T48LRxo6Nj3SRAcZH5mo7Y/wha2HxzMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FeNrZJik4mQKuQb8pFPb2o+GlFiwGg1hn5jRGknyeOvBFZ27xdwvRHYfJmXRz9f0GuSq7IgQOfC04xgqWPs7d208zMOb7sAWrFfCfp/g59/JIgElhVBiXhuJ319Dzrvwz4Zmrpq3hIR/7yngnatMSIIQatsOWKNpQYxiCn3OwIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHSpjTXP; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHSpjTXP"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439b9b190easo4583697f8f.2
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 18:43:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773798211; cv=none;
        d=google.com; s=arc-20240605;
        b=BR/RhWg4PTwHR0Ry5K5sXPui8NvKBu1j5KdbRiUKwhC7Fp69FFLWT2f2aFA4tzIFyb
         mEY+ChwgejMzE/Mi4IZJqzbUkpEnAgJWkTlT2HorX1pTj4rAORfKL28XhZ/l0ibEtp0g
         o7vuw574J5N2I18sQZr4UxmtqpjFzpapWhOT4Olyjd6KPS74bfYco60I0AvbXlHRjc1b
         gTBYJdStdQTOtMPQViG4JsAzHWqrVIKOV5yPdTCdiiJVhJsF3MeXO5Nc/9/ZjDw876Lc
         bizcxFeSd67M7ikvo5fVwxQyMEiO2wDEVrnmiZxxbbtcenJyc15hpobJA225BcUtgl7L
         ugmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7BhHAefvtC4T48LRxo6Nj3SRAcZH5mo7Y/wha2HxzMg=;
        fh=UPUnlkxD9KTuYv3lSQlDCdq8GBD0yKR3WyyqPTs0JvM=;
        b=eZmTNjrc6WPTw0iXUJqIXlar70VtuV6H9MOe0uGi/dGexkdIUVCy/s3tBPMMAZpD/u
         DLO9+N4QR+EVmASdGVdbP5GYTk3G3dr2GFxFNU/jHJ6ZwXiZHFiJhK13Dn8t0b8nIy9B
         d899ToeKGMiXhxIMXlv9To/oNRv0HKTlSUv7BbW40orS1se5f4AYnMvjl1+WfIEs0Ulq
         496+thvgSSWyf91NFN9gp5RgEfNopGXX2ajksOqgNW1rpHdZYlOk2UMl5jZQh/iFd8WF
         v4ud4E+plR57KIC0kbYbQTbnuactH4zAQekaMzYH1QRW6bJDF/aObCt85bVUxu8Bjc/A
         DRoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773798211; x=1774403011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BhHAefvtC4T48LRxo6Nj3SRAcZH5mo7Y/wha2HxzMg=;
        b=GHSpjTXPFvaLz6uwf6u/+NJ6ZO1UXT2ACXbGW5j9+yS2FmxIHzA/36qc2jcLhtSsaP
         WfGFkZ9Zd8cfgCi+3X/11E+SMh2iJ23UJx7uARUDYRWYCEjGAaQZzRs0qYWiRQUZ2sBc
         +VYvG2VdOHTZHDq/2fDeoLURGfa133bPs2yRNmEu6ygedlgZT1dFCFp2ENdlXyRCaK7p
         2FMk8Og9Y3jatgTRCzh2lvDhy4iHwzAzVXnXKOXKyXduKeSQ6TBVPCQKZ8hRSDYPdOd1
         R8GwIR3xUwYkmjdYcQS7q6VNw4XHNqsAM1J5ISrpadAyfs1elKHGYyxzzdkAhyulNPEj
         eHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773798211; x=1774403011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7BhHAefvtC4T48LRxo6Nj3SRAcZH5mo7Y/wha2HxzMg=;
        b=Gpm9PeVgjadhxJJEF2JZSRu3R7PJxp7eaOg7OMcPEg/xptalfuPEDi3E5FPR7Bvnmy
         +gVb0NU6DiVRONSpjrqyKZKRQ5kLtMHBEHPaf5jPaQvx/EcRId1YW8kFICcvTXB44wMj
         CGKDWH7mkSpKBt0wIodHzdbNdzmgUz80h8gP6QfIsFDujeCTQ6KJ9NiNN8dgAXU+ql8P
         ljMdh+r/5GOwQFFPklWGukNsBKB8t5cH2Lg8juPlafoj2ug3DhFa2Z8Vb7AtprdQckY7
         XYc71zTJeDjCRFAgTl34S9fuY8v8ucMk0T/1CHE56GY6h4au9+rDy+IdHgmRGl+GTLNL
         qofA==
X-Forwarded-Encrypted: i=1; AJvYcCV04ZuP8H0eTdDX88B9MfA4g6zm0v+c8pJeev8iXM43oA9jYuVMU13R23sZWlxhyTuKVdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi220a3+wzjy8aWw9vYB+F0vOCA+GfGZsS8uzOg+RS+uEH1VaV
	dUD0d5PJkmFlDtkzcUNwHaxfpjS4VO/JZ87WyGJ4R/Em/RGiT3K9pKvz+moZ1Yw3NqjLAYXJc78
	UL9utvfOPYPfQ/u+L9TuG/tt+8SIBNWM=
X-Gm-Gg: ATEYQzzlG04rP1PxPl/f4c+mpS/DUiEOZKQGi/Ignh1eGA9jX6TwgiUB1qfRGB1pnjb
	XyagA8qtVOKQUO9sAvtZqyNARk0NVl2IsogrURMqMtdaHNbn9tRKDYVT7MUcQIuLjARPQvNMpLP
	BaRJP9k3IjGkKEMDoyYSzJy8QNALnmKfs1RJT2M6OdDuCvom1Jyi/4htMcVZAZd9T53EfdHpaKh
	+nCSj09D9sZfrz9M7UCIauSiymk56Gj9ElX9WazlQnxw38ZYfH1GVfkoaaQsrDqCRi8xrgJximN
	LlqIfoTl45sQOl0Q0FYCiEB+CN2K5qoBCU6uclcPL7iIGEiCGnemkhAsjN6mldvHQXEO8zHrCA4
	hHlGDv5/5YAmYaMN28mJ+XCPn4obHVL9hXw9r
X-Received: by 2002:a05:6000:4301:b0:43b:45a0:9df6 with SMTP id
 ffacd0b85a97d-43b527c3c15mr2325324f8f.32.1773798210560; Tue, 17 Mar 2026
 18:43:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316140557.461288-1-maciej.fijalkowski@intel.com>
 <20260316171200.4b8a96a0@kernel.org> <CAADnVQJ=nryHHb5A3r77H6dzg=vzC97eHe8mCeBA=BMxa=+P5Q@mail.gmail.com>
 <20260317152045.58c719a7@kernel.org> <CAADnVQLZOUMGxNDwxhRzfx4finsF3aua31cggKpgTA6h0pjgAA@mail.gmail.com>
 <20260317182920.3f4fd8eb@kernel.org>
In-Reply-To: <20260317182920.3f4fd8eb@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Mar 2026 18:43:18 -0700
X-Gm-Features: AaiRm50CHiKH0_7o4GCtfMzrpMzNox7Sq7UK2x6XyWyGXlvcrY57K02HjenTgg0
Message-ID: <CAADnVQKYW3cmJoPJyDowXvg92crKcc0be=+3pR=DfPWLdCxaSQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] xsk: use __xsk_rcv_zc_safe for ZC
 multi-buffer Rx processing
To: Jakub Kicinski <kuba@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	"Karlsson, Magnus" <magnus.karlsson@intel.com>, Stanislav Fomichev <stfomichev@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 6:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 17 Mar 2026 17:57:32 -0700 Alexei Starovoitov wrote:
> > > > Do you guys need it in net-next in this merge window ?
> > > >
> > > > We have nothing in bpf-next/net so far, so should be fine
> > > > to take this patch into net-next directly?
> > >
> > > Somehow __xsk_rcv_zc_safe() landed in bpf-next/master f620af11c27b8ec=
9
> > > So I think we have limited number of possible moves now :)
> >
> > I wasn't paying attention. We can revert it in bpf-next and reapply
> > in net-next and probably route all future xsk patches to net/net-next ?
> > since it doesn't have much to do with bpf anymore.
>
> Maybe we should defer until the merge window and let it sit in Maciej's
> local tree for now. It's a tiny optimization, Maciej can resend in the
> next cycle.

or I can apply it to bpf-next/master and we start taking xsk via net-next
after merge window?

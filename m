Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7837B370D6F
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 08:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775117043; cv=pass; b=T4Zwf/LoNhqLz8EDtPZ9BPy/jKTBfeu1OSc/TjQtWdE5x0MibSzagV2QMTWfk+kUlFyHaWL1D2k1ESU0kYfMhQzpEfT4rqVDLANHukK+bfN4y+xHiZh6zL8hXsetTZONzeUTvF+pA5pFq9U2gUN5VVaaSEeEFXWuZWr02Ota2Es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775117043; c=relaxed/simple;
	bh=ZSJEDCqzQpNwg2Pez1uKarHOagG8B10XKu1G7yflVSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fKUjx3oTwbyro6CNOqecMc2HUV6K/cu+gjOR/N7JM8Rsp9EAW/POUtrPi45XI8TrBd4T8OYhoSazi/wo22boxfALiNf10idVstloDlo3PRwuRxIvvRfqxMI4FGuF4lByveUTJGBRKrp9P5SeFTLnE5GsERgWV4y4Ved83VO4ahs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NTzCRsRd; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NTzCRsRd"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8a08fa355a1so9386276d6.0
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 01:04:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775117041; cv=none;
        d=google.com; s=arc-20240605;
        b=HQGdj/ekqoqEljXwtMgtkOxYkoZuUGha0gnRCe5e4GlW3U/5WFi89PzXdYKQOq+dTB
         fiNJXy27NSN4puGSLWdK9HyW5oPqWVSjosl9FsncV0Xg+twQcNBo8or3b6jgnO5arhyc
         iQ8THurWxlqaHzXwRAEIDvLjqjYN/lmpsOg/eH2C6LLxtJFL2N9l7lyMh7FRjXlrE3gU
         ZSKC3pAHk8C0tfVia+Q5mqTUn22MoY48j8GSoLXAPjLSEA7/9Vt8ZGvrK5YhZyU4qz2V
         Bjok1mbevWxBgOB5Dx8UbGpCEwkYHvD9lE5OqQhgvcqCzX+HlNPxOTVgDaPA6toxVqCm
         +R1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZSJEDCqzQpNwg2Pez1uKarHOagG8B10XKu1G7yflVSc=;
        fh=403A50XH/BOKTPu/FMX8Dlzjfj/DMZqsRvofKePRJlQ=;
        b=lwdj9H6Va2n5Ub5E5QoTT7QghIBlfrdKFydAeM4tUKrj7ZyxZ+1eifkJncOf5bA3jG
         rSIGsdS+JJtLzYeggokQ+v2OMRtJX7ryoSXOl74rAf6G6ju64DRTl8OmHb+Myaw1XrQV
         CP/Ymu+m15cec9E9l2OFLSo4hNWgV5Y4RoIaNLwzYFL9S5Hbhi1FZgxjsTI+Rj1RZYxl
         6f12XyqQ0eL+PNTLctHz3Ndo5WViaHK8+BfNBJKVt8V4i+hGsTutLcNmTMgnVBWe+Ctf
         9/fnZNSIg2DYRYiB48CjX0OYtGuOLjg/DlgOLCJxpacrFZLetrTkejP5iwY+cy3DGAgP
         x8dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775117041; x=1775721841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSJEDCqzQpNwg2Pez1uKarHOagG8B10XKu1G7yflVSc=;
        b=NTzCRsRdumbqdN8cfcLLj2D6nbLedW3B85HzhykmZMiQ+PA4ePfugICmqRte5K5v2K
         +GzUVOJHZZ9+1sgedJvD+MZV/NnpKa00aHpV+q8uagaR/4J9kEsTnvJ7NGXBK27ByxSz
         braAX0GJcCswAYDdBBHB99ku9cznbi1EyJ5r6Bc2qx/HlJ9l5bGxEZxBwbmFUNPQ4HkW
         RgFUeQE/NXNnFQtEzihDAFaD8CHXkfjoWBKpuphjgXYU/QivQWjePwQ+CIowLMP6IYrj
         2qrwHR8/hKpyGdQm6CSBLEKdwYKZ0OUAwZKZN8Qbr/+1zIrnDattMrsNZDqf0IVfnY0X
         DtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775117041; x=1775721841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZSJEDCqzQpNwg2Pez1uKarHOagG8B10XKu1G7yflVSc=;
        b=pGnC25vZ+FQ0xIIXyNgAflM2H1u0wtZSg427XgvoSMmaNSLdnhYdMkd1m8V6u5p7Um
         q9lFcUQ2ZeY7P7gGix8vgYKWjBSOfTnrvUYYnCyyB+KXEbFNFwqi80rtnYY0JqRg+e8c
         Yn6bl6eWd69fzrq3LtEHP2bDogOmyhl3hd7XFv0F59P9C4hPVpDfn2htR2A4caaepvM/
         vdFmqymMIrpItPfWHgv7vVynOHpTq6iPY0ExRBzm+AnpFs/VAHVjLVDsH962yMDNQiu2
         bxIMPcw7MrmGZ1utWbfMeyGpMULoNa2bfGRPvjpkQrbCJ6vtBwsbRD++4TAMEa12KyEx
         Sz9w==
X-Forwarded-Encrypted: i=1; AJvYcCUcd64LPuDKNlLETqexgQDSbjbxTYu52d9UA64YcM1wBzjuEZwdPiu35XG/lhwVKTt4PPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZpLl81QO18WSiHc2lYokqSgbdi9PwrKWMHf0FSqgi9bKBl+08
	ddLc4Y7lv4DpJWT/aLpYQqRdqq5c1qwKmj705gpS6VxILmWopNRI9l4VdNyXrc1rkI0l0ucA1NV
	QEyYxQ8gWSJv3K7NvB0tmLSaNkvP8o4Utow03fKSh
X-Gm-Gg: ATEYQzxCScW/s7VV+ti2Vqn9NjQJFLZ39x0d7rFdmA77ALbITzUoqFHGQQDYC1SSuor
	BUloelDyOZM9+lA0QCqFr9lMtRLMfqGwAomACIUmyM3/fXjSgHvcHvC11rqyiPMFUk+cV+gljzA
	y7iE1UIUKuxpzOFcSJLxHhRaSP7NVEding+l/5aBenrjFeNH0lIIxG2b4rdHFwWlw7A/a4Nfk4w
	XHd0Cz88zddKlC5mEC7fkE3j+NMCXDcvD8KYORA6bVpeWIcDiaEQj/cZHTJJLSq97PnUKjiEfwu
	A/afFxdJzH7lmW7ArN4=
X-Received: by 2002:a0c:f099:0:b0:89f:d316:2b01 with SMTP id
 6a1803df08f44-8a437f104a5mr96099656d6.26.1775117040984; Thu, 02 Apr 2026
 01:04:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402033138.388574-1-jiayuan.chen@linux.dev>
 <CANn89iLdRZd-qO4tRpSGamHpggh=r5vM4xes5npYCnkwcNG89A@mail.gmail.com> <ad90b2a9-0f67-4796-94bc-9dbb76a575af@linux.dev>
In-Reply-To: <ad90b2a9-0f67-4796-94bc-9dbb76a575af@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 2 Apr 2026 01:03:49 -0700
X-Gm-Features: AQROBzC4i4XqI4fo-eKWxUd2Cc5ktCNVV0BavblbpRz-nP4ApUgDItg-uyKcNc4
Message-ID: <CANn89iLLwk9G6K8r=hOxsQQ2AsW751E+2pOoud9c-R+R-3i6hg@mail.gmail.com>
Subject: Re: [PATCH net v1] net: skb: fix cross-cache free of KFENCE-allocated
 skb head
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Antonius <antonius@bluedragonsec.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Michal Luczaj <mhal@rbox.co>, Mina Almasry <almasrymina@google.com>, 
	Eric Biggers <ebiggers@google.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Alexander Duyck <alexanderduyck@fb.com>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 9:15=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>

> If we no longer care about the cost of accessing a struct page in the
> free path, which the original commit was trying to avoid, this is
> indeed the simplest fix =E2=80=94 kfree() correctly handles objects via
> virt_to_slab.

We only have SLUB in modern kernels, kmem_cache_free() needs to touch it.

Using is_kfence_address() in net/core/skbuff.c is pushing too hard in
my opinion.

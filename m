Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE5A392C28
	for <bpf@vger.kernel.org>; Sat, 16 May 2026 23:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778972988; cv=pass; b=E0M+pbKB347sOQLJwjpxxgWATRGOiAErrhHWL3wBgN5JN5ipCbDp62EkV+JUwWcGzLrqUO8dyjO9i84iBNsmgiVwY62VLSHlUfCDLMz4qh2rO9r1lv3qaJuDycA51vYquXkI7kG0gZl/fb9Zxd2PDW9WobPfFQuSayqYxERXGtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778972988; c=relaxed/simple;
	bh=ySGuOJIt/e7vBgBZIongGFzCTMYGjbLTujd8HU4eMlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oREXu5NZ2CFzfHUPebIqneTuwVNMj622AcWhrjpwtEzKS1zTWTBPo6cTMCiAS4VhXTgq76HGojqnvnv9m6HVOT0fejCIacy6JkY5tfp6jsC5PDYdTmBveoFyl1oY9Jmdi4TL1aFWsp+0HkNVzq19+WytnbgDSSXLekQJthdDfio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmFOBnXb; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmFOBnXb"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso6294415e9.2
        for <bpf@vger.kernel.org>; Sat, 16 May 2026 16:09:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778972985; cv=none;
        d=google.com; s=arc-20240605;
        b=l3e5YTsXnlY3S7K8+WBbIxrVlu7tsH7+MlYmKZYvph+c4b+0Xw6Xib2V6kfL3fXhAY
         FzsL0m9Q6+4MMbLG3ruMmV3N9e0shO3rwv22ACXtPzcB+ETHXl8cz9kMZ7OuPZyzONR+
         ghUyTQx3dlhaSGTcKx+Z+Qfwu45W9FDDJ3cpekP7OK4diY6zPJ1+PQsflFNxTRrXLxOc
         YyvTR8+RYGd1QYaejmfJJ1WRAVyaR9Qfzd/XwrCMBZN8E2Q2xtge/KTqiMrpILXIjXdV
         RA/zkgOVf95LvboZv9wD31ZkE3/OQx2m4rRDphnHYdSyMs0pq98CUU/wK3xbE67RPoan
         PB/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WUv7HOC1avvqkmnJI3IpOuXaKMorA+E/q5T5MT6vt+4=;
        fh=n4T/eSrQcy47woypHUpBip4rhqK8p0gPHZzQYdTBvf8=;
        b=M0Ki0ZGuFpDDVd6pqwt4cm+qQJI/hzb6h3RZnH1XxWLFArOvVyKf88XSqVHc1o8Avd
         vJKwhGo+TkFFRwEpM73+G/Az2XKZsDu1C68ZKO2Mxx5Z7mOvljcWsvgscE306Yh0F1kf
         TnUD7702lS3i6uvMVXUMk55f/Jq/Dva3y/x2tbxJbUW0/SqnP5pBmsSUV39Kizo3J/dN
         CB1EU6M+kQQb3cSURF4w5CK/1Z3/8K1J+UdDkgtakvU+bVbx2MJg9/E/CRKsFNuOJU9G
         IpTB58h56KxiPl1kCknN2MzQJGjofMrpqprL6u7pfSmharjWOoHQ8oQPd03C3awa8veO
         visQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778972985; x=1779577785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUv7HOC1avvqkmnJI3IpOuXaKMorA+E/q5T5MT6vt+4=;
        b=VmFOBnXbf9BfLJfC7AeXcrWg+p6F7bPsfIYDu8aAd102z8cSC4F9rqLPrIO59oA23e
         IWChX/u8Mikk+MkzAHX5xB4K4XaGjIRNtyGGiJKrLkgPfnkdZFuC1FUthX69d8yVrbnZ
         LglFt2ILtZBP5fPdpxTb+J0Uoc425zeaeBFtxMlHkzOZwysstHmlTmPjCizcCoUTlQBt
         cRg73CAKQDDpe1eJBLmnnbtnTKRLoRSOpSReWPKjzzILW12S+eXc74+lslgn6pRTkW6m
         0hhEaGPd+awDsJM5FIfNt5jWnzUkl7FBBBrd/usBcQLRpcMf3HnY+nnYb1oDpJRxvYa/
         ElYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778972985; x=1779577785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WUv7HOC1avvqkmnJI3IpOuXaKMorA+E/q5T5MT6vt+4=;
        b=pnTkYCvbg3phNwx7Xjh5HfPcgaQXveQYx/GUlfQ9RStiRVuQFkMYxVS/p+HC6ICjsu
         DZVCmXfUEU6S4oW0uvbtYgMCbpT/SVIUYOlE/gks0GSqXMHnkX+R987a+8w2sc9FJ/DI
         pGK1tsQTxXjVI8Y3RqWxin+8UrcRifTeMUWwpQrabnw+s3Due+98w4h/XXCyNWk2ouyw
         xk/+4oF16JSEUzuCkh5eosOkAkSMJLXZC7Jjl1yct5T7oMaDfFPcO0cPc4wDsz/07RX9
         jOanKcop+IyuA/sMOPaZaxG+D6wdqrEY3IT46oc63MPAqlA6tWu9zwPD5rv2bvO9AVt3
         2fNA==
X-Gm-Message-State: AOJu0Yy7a17hpGTZl8x/hA6bpjbrUBDs5C52mxdJbgVZ4igIChDXZNvo
	KTJTyFZSVzq6/MmGRKzjlPshVAd9lUgtivQMGkfIf58wtthaKyUocAP42KHib+8MIkqbqXLWxAJ
	X9EMtWNeoV4/OHw3UhAPr3ztigWaTkz4=
X-Gm-Gg: Acq92OGYEf94oAAzrX9O4mKn/ECDpdDS9hSQ7DNHuPLlOyzo13f9s9wReNKEM0sCTNG
	Va08XfPiVUdlzsMv7YpFlLSM6Ri0p79qb/KKqcXHALGXOpazKCl0K+wke8DJ5OBoOiwnB0YYd4S
	L/emgXIe9YJEg0xzjYcAh5PUX+mKOngtTjJ0cKv3UvVw3XqBISX4rWl5arFq1ognP+CdrZF0esv
	phIE6beP87UXXASzp+UVT3CnH0HWuZKcTbEXOSR+nD0j/ge/sLqFQUvri2oLr3fxxSnhoZUCtaO
	hUYeo5FgRH5HyQnxV81PX7mVT+ScqEvdIsAaBudWsXP3EMyzyEXEsR/3z2i+MnHRhh+gLq4yMnp
	i90Eobf+oCpbOEuGc96jObb00TA==
X-Received: by 2002:a05:600c:8485:b0:486:fa35:aef2 with SMTP id
 5b1f17b1804b1-48fe5fcdec2mr139062365e9.4.1778972984495; Sat, 16 May 2026
 16:09:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516022426.2109698-1-memxor@gmail.com> <20260516022426.2109698-2-memxor@gmail.com>
In-Reply-To: <20260516022426.2109698-2-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 16 May 2026 16:09:33 -0700
X-Gm-Features: AVHnY4ItruqozK43bxZm20nl05atKIlkAqV5wei_VdsAOWCFmEZr5D4PaosbtzI
Message-ID: <CAADnVQLV2YKuLmZC3zUazKErT0xrkqV4Cs_1BSmXaFSPXLCxRw@mail.gmail.com>
Subject: Re: [PATCH bpf v1 1/2] bpf: Check global subprog exception paths
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 7:24=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Global subprogs are verified independently and are not descended into
> when their callers are symbolically executed. This means a caller can
> hold references or locks across a global subprog call that may throw,
> while the verifier only checks the non-exceptional return path at the
> call site.
>
> Record whether a subprog might throw in the CFG summary pass, alongside
> the existing might_sleep and packet-data-changing summaries, and
> propagate that effect through reachable callees.
>
> When a global subprog is marked as possibly throwing, push the normal
> continuation and validate the exceptional path immediately at the call
> site, avoiding a synthetic exception state and associated special case
> in the pruning checks.
>
> Fixes: f18b03fabaa9 ("bpf: Implement BPF exceptions")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf_verifier.h |  2 ++
>  kernel/bpf/cfg.c             | 13 ++++++++++++-
>  kernel/bpf/verifier.c        | 23 +++++++++++++++++------
>  3 files changed, 31 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index b148f816f25b..b2cc337ebe74 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -739,6 +739,7 @@ struct bpf_subprog_info {
>         bool keep_fastcall_stack: 1;
>         bool changes_pkt_data: 1;
>         bool might_sleep: 1;
> +       bool might_throw: 1;
>         u8 arg_cnt:3;

Let's move it up, probably next to has_tail_call,
to avoid conflicts with bpf-next.

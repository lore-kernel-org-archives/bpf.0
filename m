Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B5E301472
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 02:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775183006; cv=pass; b=PG9lo4JsGgP2Obq++/kaBqmrQuGUAhD3E457XABtTRFfytJU4XDxGRFY1zZd5Bd/jeNo82I5fBY2wj8KqWpAw5HcWL450ev9IRngv9yL12UJ5Cr3W25EsxrUme1BT7uWdYURQpk7Bs3nfh3p9wlL7KQw7UAy42lvHbUuvzvFnvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775183006; c=relaxed/simple;
	bh=QPNniyPcPD8NCEHVl1+tqiO6u9fwEmcwYqCSe4cH26w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOtGA8rwLDWnobm8Ng4sHikF998vedfhTVnYXEM21Q8uWRP8XlL/bUVU9i6gdWeO8gCwOxLHEfghYzGMtu/UObx7jAmPdIlXfQXim5TCVTGo1qN3v6223Bct7rnsUzBDMaHMI/hYGxgCCQPpih2Ko9rcJFCnqO2sA32YNiO9HAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IOVQiMgU; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IOVQiMgU"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7a469383e0bso7305677b3.2
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 19:23:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775183004; cv=none;
        d=google.com; s=arc-20240605;
        b=kt7vvDI8jmnLoAYSqhlbC5xEgB46dzGitbUgK2JLeN99VH/T2dufvc3bBel+rzW/YD
         /Yualw6okGHthhnxSaTLTjk/r6k/+yLXR37rog7wV6f4JPhm75ZHoIYLWipL3jDJUdlk
         dD8MdIJwwOj6GQ6clh4rn8jc7RcD7tFx210tEN2Tr02mOGEVVO7PmHrZw+kkruZLm4uc
         LEtAQscqs5oiL2fBmkld2ODKLxF4C7zWK/rPbi4fZ6vRihwmrm3ttGs0dNqVOKdbE11o
         pivMUUPXHSJIYNxsgyh2zM2hTcHjTlXyXMyoA6OlQ8l/VJwusUUlp0/GgH17pQjGRb93
         1VbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HIy8iHuqOlscN7DzgEOqWCvFHIn3PjfNELBdpX/HHL4=;
        fh=eb7oCUtX9Zrsl1pf7zQv7A9MBBUKpKPFUHganT0NmSA=;
        b=UeLV8JnaIkiTJfgCqetSpwhM0Po39KWDREvMO3Bx19gglPvRbrA3PosZuIQI/pz1Zo
         ulIVXyvXvPyQsBXbdlAo6DR1XTyJRR3gMJ1ET3T2cEm2hUMlZs9jcfpR9ebprf7S3B7s
         zNC298T+ZWe/czjtNK3J5tg8WtgMGM/NhRdiVoxaI7jrGOXIkOVB+nJC1Tt7X61QhDUt
         Mx3DYhTbbWz6VH7ZyeZosWm6iycPHcdKMuK3yvkan2DI6Yrj5/bdX99befQ/u1CNANy0
         J0bdHvdE+dvjRgKrgLyA0gnv9SSck76KDTboWUm8SmQcR+t5AgmSZqrVa2rELzaH/JFS
         42Iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775183004; x=1775787804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HIy8iHuqOlscN7DzgEOqWCvFHIn3PjfNELBdpX/HHL4=;
        b=IOVQiMgU1KjvK0aa8Omw7nl/AzNXB758nAWINmMvo9ICxyN4yTqkaQywzfiuSpKPV2
         FJTZjtKCPN9sAzdNOOxx7nlFNXCvrIthLdZxKe8QDsR0YyoZihiLlbb8040gSIYVPxjx
         13Chk7Oob+9fUdOxe/rxmNsJa3Q9q1flGnNJOtoe8yps2mNn2jrI/cHNf4Pbe6ncWfSF
         k6dLwT30b9orcCXYvUSfZ4MQWZhKOS/N7eN0XqFTtS8hfEgSYSbmNX7gaPRvj3DESkMA
         eTFQ3Ph9sDM4sY4gVcaZAc7pQBeJh7SqjrDXhWPhTyPMbw6usUyRlL71QWYWsYIXG7qS
         /8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775183004; x=1775787804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HIy8iHuqOlscN7DzgEOqWCvFHIn3PjfNELBdpX/HHL4=;
        b=Yye+SsiOjcHjAPrXsMmeGAfmaWTA9Vsyvlp4JDRNdHvTV1yziDPkbPF8CtGMUfArG7
         sPDpO8jvT03H4O1kYOfb/xXEEO+HCN1wOHGp/HrJsSnuEYnZAWsPyP80b1OiR6VAnEPI
         m3Pj6MWWPWRsC9TF1NgHr+J8a55U/BKm+Q7eWXuggVJ9OV7PUTmZ/EU8LBgOuP1E+pj1
         eKNjP4iOZS2EtAe4bK2wqa4DA+XQ3U9DhDHj0nBfT9rWQMN7ewV0mc4XIMh8dY81+3fz
         HB11uxgWCIeB19JyKhphFbZ3o54FUkP30LocVY/vm53RNUrGOREUKDIfD0z/bY6K04rT
         vQow==
X-Forwarded-Encrypted: i=1; AJvYcCVkMrLpNI6zisE42z7pJULzkXF+qdw6ml/AI4T9TxvoZlLh7OqFq5yLic4UFUt3j8J/4Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhl+DbJv+imH4mJxI45pv4mdaSC8MyZwWCvRMRegj3gM/zo74z
	1d4+imy1z3Fw8Vk2AGjORz/5IPbp5OeRsnSlGKaeIduL9NmaSCOtUc6RnUPnT4Cj8kQ4j812x0d
	j7ruLY/pplrl789iCR6cX1YsXqZZ+4mGKE6Isthjx
X-Gm-Gg: AeBDievjdAcIP8gbzvOwIusx4DgsUSh8rnmG6qjRbWeR9M3ck0VxgBm9atKS5Y1za2U
	gj/EgTg6Y5CpEr3sz82b5uUeesi2SUif7eVfGDtYb3rnfuFsjbDxVxVkp54MAqoPKxl1+kmMrrQ
	sJXZsztMwRMQ+V7MxHQkMn32Gl0/XBtyT30NBLhKmYE5A6pPx5KBODaOwP2+3jR4RC1VrUbwkv2
	G0c29Ct28WmbXPIr8HPlCqT0kkEgkcBfCSKsZEZW4k+6KYzRydpiBRQenffc0eqfmGQOENJAyPB
	RJVlSDo=
X-Received: by 2002:a05:690c:dc9:b0:79b:e346:980c with SMTP id
 00721157ae682-7a4d625504fmr16818907b3.12.1775183003286; Thu, 02 Apr 2026
 19:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403014517.142550-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260403014517.142550-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 2 Apr 2026 19:23:12 -0700
X-Gm-Features: AQROBzCrQfdIxhSDR4XDUfwsweTqox9rEdRUXCTR5rMIh44Ai2CNLoPe7QFj0bs
Message-ID: <CANn89iJru14aPMCXMHmsek1S5TH+sLkczJKUPpcfZHnYxR9KEw@mail.gmail.com>
Subject: Re: [PATCH net v2] net: skb: fix cross-cache free of KFENCE-allocated
 skb head
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Antonius <antonius@bluedragonsec.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Michal Luczaj <mhal@rbox.co>, Mina Almasry <almasrymina@google.com>, 
	Eric Biggers <ebiggers@google.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, Soheil Hassas Yeganeh <soheil@google.com>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 6:45=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> SKB_SMALL_HEAD_CACHE_SIZE is intentionally set to a non-power-of-2
> value (e.g. 704 on x86_64) to avoid collisions with generic kmalloc
> bucket sizes. This ensures that skb_kfree_head() can reliably use
> skb_end_offset to distinguish skb heads allocated from
> skb_small_head_cache vs. generic kmalloc caches.
>
> However, when KFENCE is enabled, kfence_ksize() returns the exact
> requested allocation size instead of the slab bucket size. If a caller
> (e.g. bpf_test_init) allocates skb head data via kzalloc() and the
> requested size happens to equal SKB_SMALL_HEAD_CACHE_SIZE, then
> slab_build_skb() -> ksize() returns that exact value. After subtracting
> skb_shared_info overhead, skb_end_offset ends up matching
> SKB_SMALL_HEAD_HEADROOM, causing skb_kfree_head() to incorrectly free
> the object to skb_small_head_cache instead of back to the original
> kmalloc cache, resulting in a slab cross-cache free:
>
>   kmem_cache_free(skbuff_small_head): Wrong slab cache. Expected
>   skbuff_small_head but got kmalloc-1k
>
> Fix this by always calling kfree(head) in skb_kfree_head(). This keeps
> the free path generic and avoids allocator-specific misclassification
> for KFENCE objects.
>
> Fixes: bf9f1baa279f ("net: add dedicated kmem_cache for typical/small skb=
->head")
> Reported-by: Antonius <antonius@bluedragonsec.com>
> Closes: https://lore.kernel.org/netdev/CAK8a0jxC5L5N7hq-DT2_NhUyjBxrPocoi=
DazzsBk4TGgT1r4-A@mail.gmail.com/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Eric Dumazet <edumazet@google.com>

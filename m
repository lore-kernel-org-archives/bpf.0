Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD06C348875
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 02:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775183336; cv=pass; b=dzPKgsxLc2NiNa81PJLTS3xMDtyoXKm2ZL+afqKB5wMP5k0vBdZb//vdIDMJmmMANmjL8UeTOv8W4WfoPZPuHTDC1XMG95JsfAqUBqAqFnKqncci/HVWBlr0tzJGGnsGXzMcI2q3UxQH6h/AiTo7BlBG+n2qe3T7FfRcd6wDUJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775183336; c=relaxed/simple;
	bh=o76MnSdOtxs+ye4fRbLK45EupBuuE8+zJXQlKKJrCi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J04BXAN7LPLm+Z0LDJVtPmD0h7cIBkBLvqThwS04I9YyZcEM6+IkdrcWT4rM8ZPlgGagMPQYz4QI1gTfLOOk2x9Wct2prcI1uXUVX8Jt14RzRkZB7ltcTVV6ZCakpxEz/gcl7AuTgXSXPtFcGguA41G4JV16PA6itf2sX2pSPLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PzznTkGY; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PzznTkGY"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79495b1aaa7so14966907b3.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 19:28:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775183334; cv=none;
        d=google.com; s=arc-20240605;
        b=GsfT2DA1yVXlRjOcfeXRV/FeQH+360sd21ZnFA4AvguoBkXnODz8+zKMwG6HCiHV+w
         SxWqPm+Tjsof6EBzsd3cT+25es0VIIpkz2eRLYOacFfqfN7ONeodlhpciqWr+UliVZaA
         BXhfd/uP20OepewKMUDEVIkyy9vNMB8VDTywyUfBn1XcZx5SunOX+TQA2XNT+2cAKqNq
         CVSV6e9yH+tNFkFlr+S+L6neqpN4AxBQoTVoMWs0BfHGebVZxvKLPUssT/1bvGcc49ne
         smb3LWibU7lIZeGDkVtw1fiqU5b6GZtFvVcHgEPrpyP+iTQfy6+zzd9IMnF3rRzNiVvW
         b9+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0XS+D/tqgKAhfModL3S+q9k/U37BM3GfjpI6/nfGSkg=;
        fh=y886F4/vmMCCgja6eabIk/UFNui2UGAzpxXLFdDaUpo=;
        b=ABBIwUdm7QEuN2D3oA33nzsLJZ1nU1BF9qfzYSyfQW3Gc5AtSdMRg4nkmj+lsyaRfP
         yXRzlhpTR+eFti5Gfe9BdVsW0qAiL1oFrgSw2H+AqyyYhL6j1xoi9N0/AjbhndymFOiq
         xv4+JtpcztZjcBJI1A5Sp8PdoWeLvsmcKhOkDRwxn+2wU+Hec1dUdyW0bj1VVDHr6vtz
         KaMIWi7+jt7g8HsUB1SiPYdsRL44kSkZT5IBSHMS190gCkD3Gl3eBWpVazjjFrfssQa+
         Ft5p06IvO/ymU8tvRjy3LrlMHXIH4YF/S5mqFtQSKhdAbRDU13S2caEqyX4tDHD1nehB
         pVcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775183334; x=1775788134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XS+D/tqgKAhfModL3S+q9k/U37BM3GfjpI6/nfGSkg=;
        b=PzznTkGYb4+FXvYwI7suFA4D0rrVfWkQixhm3kKw0Oaf/618qixCvgppqqG+5oxwY4
         vCAYWc8xf9EwuNgABchN891npHcJOEFQkQ8It28ehXh25VrJJCO9Yy4W1ozYn+2qm6of
         XtIRKhTCLjc/eu46tbVoqKqFW1uqr7afssxxvKv33pPIxgLEk70NfWDfRVpFUIqmsoKL
         Ac5o9V6R3ktxeCgsR639r+y4+0xdNZ0ZE3rC9x0F4yuT7EEWBRKIvPZLOS3ly6vh24fx
         Vvcb/M+NGDPUwxtSfqTgDtH9Ked6zB3GzTLWiHF68LqyPjKqm2qRNamGJbgDGJSm3Tgs
         Ky9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775183334; x=1775788134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0XS+D/tqgKAhfModL3S+q9k/U37BM3GfjpI6/nfGSkg=;
        b=KjLVfUjCMnh2H4M6okZrydefQ8JQ59/NGaYaaFj7rC11u6AEbdsXFOv/FbqOnNa3/C
         ny0vmbqxFBh0t5bqwJ5JA4nJ8AKOubM5q21yhurQvNfKziUTvMovk9KaDVGQlTj9r9Wf
         vF1i/ryI6zXAhpJTfne5F0svZ97WYeTwTBNHVYmZroLrxbfrT0Qy+UZtmAvmjN+Wn2b+
         +oBGk2N9ZWaIchw/ysoHCIWoRVNyRbir5L6ThHa5YbysdSJU7xv+jI0+mVEclVbcUK+c
         pij92H5AJLTO4xyoCN7iZw/UuS/gcfKcDhfk8asBwjiUcJT+7dZoAAb+SajUW2IV3AG4
         Qdkw==
X-Forwarded-Encrypted: i=1; AJvYcCXh+v/efep2BwylPgApIc6ZAx/Xpz8sL4QPs5KoJ3KGArb0zKxCUexCK/eioK4MUfxKrlk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1UFyvW78s39POrEJ3GsFSR3+W48KDC/Q6WTBT87MqjlrAs1lQ
	Bfgq6rJAd2UxwU5deasHfdfIt6wdsNvTr5U2kciEVuAwzbxnn+bSa48GtSPDwxUlplK+l+upySI
	CJGaNBd1mp9doOwrJ6nvwoagC872tPURFuF4PFS/x
X-Gm-Gg: AeBDiesKNVb2vgHNkEeGn9LCSwO35W8N2bqTyx5ImFEWxiILnQGhHGSvRLFmfyvOeOV
	IcDa6tKJz70hX0+AE6Kz8EUku3AUinxTHrNNQU0FATjzeQcmeQPZ6bqOB0mpnsplr0YsSNQUFUk
	ulOEjpQIXJT9hB0x8zhZDBjDbJQXEUuVgJnoEYSKPHvPOWTZH8tV8OaT+0xSVMNh9vWrzEavZPm
	RCn5eEzFr0wZbkvrPUcrXkf1vwsY/N34y6dUN2bsvrzDeTQ83L9BZxq/kmWsPZ2LHCdb2eAywsY
	z6HsgwZEx0elY9vqbg==
X-Received: by 2002:a05:690c:dd4:b0:798:3051:2f06 with SMTP id
 00721157ae682-7a4d6544998mr18085867b3.53.1775183333311; Thu, 02 Apr 2026
 19:28:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403014517.142550-1-jiayuan.chen@linux.dev> <CANn89iJru14aPMCXMHmsek1S5TH+sLkczJKUPpcfZHnYxR9KEw@mail.gmail.com>
In-Reply-To: <CANn89iJru14aPMCXMHmsek1S5TH+sLkczJKUPpcfZHnYxR9KEw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 2 Apr 2026 19:28:42 -0700
X-Gm-Features: AQROBzAvc4eSCrpxv7Dsz5Vt2of7OQ9lN3NLlQLvVJIiauIlJc71BlaoIe-DthU
Message-ID: <CANn89i+f=3o66Mr-O-c_w6t92=xU=qo4-mOuADDHvT9Ezatmkw@mail.gmail.com>
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

On Thu, Apr 2, 2026 at 7:23=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Thu, Apr 2, 2026 at 6:45=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.d=
ev> wrote:
> >
> > SKB_SMALL_HEAD_CACHE_SIZE is intentionally set to a non-power-of-2
> > value (e.g. 704 on x86_64) to avoid collisions with generic kmalloc
> > bucket sizes. This ensures that skb_kfree_head() can reliably use
> > skb_end_offset to distinguish skb heads allocated from
> > skb_small_head_cache vs. generic kmalloc caches.
> >
> > However, when KFENCE is enabled, kfence_ksize() returns the exact
> > requested allocation size instead of the slab bucket size. If a caller
> > (e.g. bpf_test_init) allocates skb head data via kzalloc() and the
> > requested size happens to equal SKB_SMALL_HEAD_CACHE_SIZE, then
> > slab_build_skb() -> ksize() returns that exact value. After subtracting
> > skb_shared_info overhead, skb_end_offset ends up matching
> > SKB_SMALL_HEAD_HEADROOM, causing skb_kfree_head() to incorrectly free
> > the object to skb_small_head_cache instead of back to the original
> > kmalloc cache, resulting in a slab cross-cache free:
> >
> >   kmem_cache_free(skbuff_small_head): Wrong slab cache. Expected
> >   skbuff_small_head but got kmalloc-1k
> >
> > Fix this by always calling kfree(head) in skb_kfree_head(). This keeps
> > the free path generic and avoids allocator-specific misclassification
> > for KFENCE objects.
> >
> > Fixes: bf9f1baa279f ("net: add dedicated kmem_cache for typical/small s=
kb->head")
> > Reported-by: Antonius <antonius@bluedragonsec.com>
> > Closes: https://lore.kernel.org/netdev/CAK8a0jxC5L5N7hq-DT2_NhUyjBxrPoc=
oiDazzsBk4TGgT1r4-A@mail.gmail.com/
> > Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Note: we can later in net-next remove skb_kfree_head() completely.

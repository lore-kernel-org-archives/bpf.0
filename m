Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F3432B110
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 03:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792122451; cv=pass; b=pBBh21bC0tN+AsURELQaF0JYr7DPnjC/7fSxbKPQ+yVWcdvxAthAoNHY2yIj4lW2zaM8p0FDk7+f/ZLvvgdUESfZstfpQEmJvKhH7jgG6KKdYK+Tc/iSGTvksEmni6BpJEOLGHC2pfJzkGQ4mNnfU+I4DKIPPjXfvOApDNX6Cak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792122451; c=relaxed/simple;
	bh=yIqaxTNLPE/vMy/0DU9sa+0IDVj0xY6z4OXgkTYvMWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lU8M/aFM5IFl/xklGcwtO8oOZREYYjklplRfRAFAuwXUj1bCt01Ek2PjkN3TaSLLNmFbPie0E1G+Vhz0lKyPSh8aB3AVlBQW4eO8ljJVn88160EPTZMF+ORpytucEoYSt0wkj7ir/UM+DGQGUFugPBpGkCezGHBtosMJ1IIqZQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WmSBu35N; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WmSBu35N"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-150ef97e790so3715c88.1
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 20:47:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792122447; cv=none;
        d=google.com; s=arc-20260327;
        b=no4kmeUsKBY8rGxXCOHsp/AA82i/g55Ss4xOtVONrAv/n+bHwe/cLIAy8gYSzZlZpN
         j8P3rViZFJADWTCgxAFEHtZ02kkCHhHnAvRO4zvJAyLyUimMawYIx3UOeEaPr1FAskmJ
         4wM7KUsmDmmp71etRG5kxehq7P3N8fykMySQrA776Lln1PW2uqT/k11EGDJV/IpiXebM
         G7xdMyLCqnKwTiIEdGMEwjwUipmS3kjmKu6lqLzeDH0U0/81UWf2hyKZMuTTmryUV/rx
         Ck+JIaudpLnUiaXZAYa2BzUjnIbOPxXG7/Pc5C8kRXz1FpezHKlm2QUSaqVOO4RfHKSL
         wlnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gh+SJsV9qd4zf8kFfRpYPnxqBTL6SxzjJrawXU6GjJ0=;
        fh=T0yY5ykO7n1DEx9DCkmbvUVhesaWqaokjr9qVM0PxmM=;
        b=nPMC5RunjfnqDeybYe3VTojU8nGrv7LHZ5leEu7C0bkF4j1ffvUrqlPMFgMrI8VdfF
         qujc7eT87+GvuZSRQKTQQBAOaBIBJY6ya4SzJodFk6eA096vfDHgB8jw/ynWEj2+1N0I
         dpcr8drsOIWJ2//Oc5clTQCJVqHeo5elIEQkb7Xm17XjqV9+xQRuE8YttIkkEq652R66
         jyXt7UHlp1b0rEwl7ZC+PiUoTm2UUl7ThkM2K5o0h0ENeRrU882mmZ9qzxfwOOm78m52
         h+wmAEK7no38/5wcAZvXWaRDMiARdDikLodR2G0uZR69BZIF0Ss0pXGi5KdolsysD51C
         Tn0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792122447; x=1792727247; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gh+SJsV9qd4zf8kFfRpYPnxqBTL6SxzjJrawXU6GjJ0=;
        b=WmSBu35NVeiQu31QNlzjhikocheGgXNjWUJNOfTnocjmaa9dLJL7rjYmck7Yb1z+U+
         7F/BcQN9418cJFFWZhiN289klcAdf7vY8RP6332r/zLY1eDQR3QDdxhuZpxo2G/g7aZa
         v5rtZxY/E5Y21UZmGxBMeG8ox/f0nEfZpgpNvnxMR10va55ZlfCLtmjRq1avhlVq78yu
         FDILCBHBPklvY5onHmwaR6NR/BOznHWKN7qnvyqNIBobtefQODk1/1rS3FsbRoks6qay
         uh6HOUzTvsNyYoVU+csC8enaQ5SbuNJ0SfX1ww1FJ/D0eVCBC9tcI7/RCsBopWWAD692
         YhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792122447; x=1792727247;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gh+SJsV9qd4zf8kFfRpYPnxqBTL6SxzjJrawXU6GjJ0=;
        b=kihu2B9zAkrHv4eqvGjlZwyvr0Rro+dewmVic81QfHcz3olrCyFGIri6j+7vXpDRBS
         IfzxC9dPaGhPz3ZV4LyNy7LwBk8XW3mlfACQa6A0Rd908AeZj4QyIHjMa1C5fmUXZUjJ
         bhld9TIQwSxJ/FotMTPwYpIIIGDcmuz8hIjGVKHPkSBQynsyX7+gh/Sozwdh4Gmz0VfQ
         Q6ZeqJBPUqnsUjX+5IleSUcumD6iosL4msW1XrdbTXYQaQtwM2vU3UNy4ZMCmWytc9ic
         tnaTAgosHsrCKMky1ZiQlqLYM5i1XG8zuDP6Wa7nVSt99tJcWg5PZOJfgxI4SndEVoW1
         H9Gg==
X-Forwarded-Encrypted: i=1; AKwUvBxyNQGtt7f4hacLw8u3lZ6h9RxNr7qO7OKR0EPayB3+UXBBP3TLrqud+n6/ksb6JueJ75I=@vger.kernel.org
X-Gm-Message-State: AFq9FYIK+3GaZxoAN94roRQwuOh8gf3rk4AFRIpZAvH+q75jQbyONu7H
	ceVlHjAQPee05DJekORY4qHZfh5cLAzx9SE4KQnkxHb/oEUecu9svg+ALj/Lx6RBKFYLRh3tbrL
	tgooo+3jjXZrGhbPLzdw4TKmkqjQMX9r2aLtkdQPA
X-Gm-Gg: AYBFou2JsWXpHoatngTbK8XrtKAd0cD4P6jU+Ab/yVJpqSrhgfm7oMMHAdJd1sy4MDQ
	JOT/v+n35XfIRqLBwDQhpkrUPmBZWFEcqMpJXenrmm7VcIHyYyv4isAEQQrN+1sdhLvHN7W2GC7
	iqQvxrW+YpFjzg1odP6bzcAMM2HqerCC/+lR/ZAvePrVEaK1dNogdQW7yd0Kwk7vZET1rjvKR5U
	KIp0tSQFE335DikWo5pBAO+iZAQy0vA8Uddl7kJj2oNQpegD2tAGv/uf/Q3mXrtRiE/3PWkfWre
	lVGXhsy8nOckzHbOhjYgHLAik86i5QggvHAQfcpPZHiXXmePjCLQKQ==
X-Received: by 2002:a05:7022:170c:b0:17f:fbc9:996a with SMTP id
 a92af1059eb24-182bbde9b6amr279955c88.3.1792122446355; Thu, 15 Oct 2026
 20:47:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014173945.373295-3-almasrymina@google.com> <179209665863.434549.6637198029989888049@kernel.org>
In-Reply-To: <179209665863.434549.6637198029989888049@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 15 Oct 2026 20:47:09 -0700
X-Gm-Features: AclHuK_vtqKDxgWFbxG4BSVZCPmFFjYvhXzuIZSuzOmkSqaPQBtSf8jQ4Wou4a0
Message-ID: <CAHS8izMnj6t5CX3THvGoorPa8krD1RvouXzKQpgZOkUMs8Bzow@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/6] net: skbuff: add napi_pp_get_page() and
 use it in tcp_recvmsg_dmabuf()
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, ayush.sawal@chelsio.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, tariqt@nvidia.com, horms@kernel.org, 
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	ncardwell@google.com, kuniyu@google.com, john.fastabend@gmail.com, 
	sd@queasysnail.net, ebiggers@kernel.org, kees@kernel.org, 
	aleksandr.loktionov@intel.com, petrm@nvidia.com, u.kleine-koenig@baylibre.com, 
	j.raczynski@samsung.com, wang.zhan@smartx.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 1:37=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>
> Low priority / nit picks for your consideration:
>
> - [Low] The commit message says that "no symmetric helper existed to
>   acquire" a page_pool reference, "forcing callers like=E2=80=A6
>
> --
>
> net: skbuff: add napi_pp_get_page() and use it in tcp_recvmsg_dmabuf()
>
> This commit adds napi_pp_get_page(), which takes a page_pool pp_ref_count
> reference on a netmem if it belongs to a page_pool, as the counterpart to
> napi_pp_put_page(). It also converts tcp_recvmsg_dmabuf() to use it,
> wrapped in WARN_ON_ONCE(), in place of the open-coded atomic_long_inc().
>
> > While napi_pp_put_page() releases a page_pool pp_ref_count reference on
> > a netmem, no symmetric helper existed to acquire one, forcing callers
> > like tcp_recvmsg_dmabuf() to open-code atomic_long_inc() on
> > niov->desc.pp_ref_count.
>
> [Severity: Low]
> Is this description accurate? A helper for this increment already exists
> in include/net/page_pool/helpers.h:
>
> static inline void page_pool_ref_netmem(netmem_ref netmem)
> {
>         atomic_long_inc(netmem_get_pp_ref_count_ref(netmem));
> }
>
> io_uring/zcrx.c already calls it in a similar zero-copy rx handoff:
>
>         page_pool_ref_netmem(net_iov_to_netmem(niov));
>
> Documentation/networking/netmem.rst also names page_pool_ref_netmem() as
> the API for holding a page_pool reference. The new napi_pp_get_page()
> calls it internally too.
>
> Compared with page_pool_ref_netmem(), napi_pp_get_page() adds the
> netmem_compound_head() lookup and a netmem_is_pp() check whose bool
> result tells the caller whether the netmem is page_pool backed. Later
> patches in the series seem to depend on that result, for example in
> skb_netmem_ref(), which falls back to get_netmem() when it is false.
>
> Could the commit message explain the page_pool membership check and
> return value, rather than saying no helper existed? As written, it is
> not clear why tcp_recvmsg_dmabuf() doesn't just call
> page_pool_ref_netmem().
>
>

Commit message is accurate. There is no helper that mirror
napi_pp_put_page(), only a hepler that unconditionally increaments
pp-ref and barfs if you give it a non-pp-page.

I think we're meant to ignore low (and sometimes medium) comments,
unless they're obviously correct?

--=20
Thanks,
Mina

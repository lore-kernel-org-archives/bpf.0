Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA233B9DB6
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 09:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788169345; cv=pass; b=fFXvuk4YzVt4Grq9Dqc4VDQs0QgGO/jU2208We831Jt8Rd9FSLwQfzMQeCvR52PtWJsw9VFZqDpPPbbdYXUHFDwbkcl4WlHn5a+Qmk3cbnWRd3HKYgHK7IoeEgG+BMP+TQfrlNvL//AJgJnkfECkydQ99uxbSy2Qur1lh+YlOgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788169345; c=relaxed/simple;
	bh=GsFumLSJL886GKpHbJf15kVOuP8UIgPLqNba42ST3sI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/lPdjk8Lwc53HIbLJHkIQzLnZH0klGr1Azz3zrmAqEwLcHWHCQCcyh21HVBmHu8Y1YAkThdntWYJXXVCcNhJ4s7NaHB5Uqfd287OYt+YHxmJFYve3gDCLiJMPOixS7486N0kzMPMh0PX5TGd272vuA5JWmfA/jLPe5k+w7yvqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NK7BHhtg; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NK7BHhtg"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c0006ea8eso32296221cf.1
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 02:42:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788169343; cv=none;
        d=google.com; s=arc-20260327;
        b=ZdWd8lC9WkNw7gE2Z7+/+oqIgFDHee5qhSy/J7H2f/5nRePy0gsFDNVj+WJ+VoSvK5
         7Q5zEE+blXCyFqtFEF1eee4QkkZEiSFQ2rPK3wbBS1ujZQmo1uPzKfaLKIysMjoqfgFI
         uAJkY5bR/CWdl2rrozrlhG8HqTgugQrpJlIyOx0/r0E7yqAUst7RJmRoUZ6FGalSFPlr
         7t+MYkr696CPShNI8xjHuNVrTItAVj19PWWeec6YrWcEq/plFrspQs+NpskkvS+/okjO
         Ve8q8Qu/bmEjY+QeCOg06glQkVBDAl4e8/Hw4gFiHVPcjLrZw64F3VLdexgmHBwqaExz
         n9Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Aes8E7ycjw85I1hPRVRNDb1VK1GawwcAPWMBLAtTYaU=;
        fh=7L6SJkCiUKkoclRQA/DTcUmN3UHAtIwoopOG3vDbA9o=;
        b=LN9j7oiZQ7sHYlBw3dy2JZyHtqg0HSqF/qgPwwSa0A1hMKOAyT4/AeL6zTa8OYweP9
         J3lR47pBjUGxp1V0vi9SUga8zL7xQ1WEuFvFmm2+iFuRZBv5a5XRNMwiICdDb187YWwM
         sS7M+dTbkRgaNpP1PG14IdOfsRJ3+g4hGekLFctsO8Hl6H2SkzEPSrpUtwoY8p5vQyGz
         oACR21cJeqJCWsTgJqVkFi8RxQ93Jrr0uztEpl5rMMVeevlTLKfFDbXIlN0J0xOwNjTi
         EWJ9fP1PO7fGaJ6pyx2WzPJ38/wdgdVZaTtIPNMfH7k7CWnc9gXZCtyKVChCVHFdPgh5
         AaqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788169343; x=1788774143; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Aes8E7ycjw85I1hPRVRNDb1VK1GawwcAPWMBLAtTYaU=;
        b=NK7BHhtgC0UyHwgjXi/TCvsS5Dh5V6XgICDYxPaWILlJibgmqnHvMcxXzH56o0g76Y
         jH4JYxdYMQQSOxhJUkH4dOtsDYvi5aQ/quFmUxVFhEQWG/1c+HI6B+CMWK4AsAp8pOcE
         G4p06HRJWrbHX59oXkYqRzJao4hlUhfnTFBj3PM3+c7f8tSO2Lx2A9/aip4NPSLH6l7O
         SEVOAa5+qE63zMNcZVez7mSYA4IVlQhkEZYU7+yjzKQlUG+fnpijYYSNcflGOuHKikR8
         36J/mwQ8yRReATf2RtnnmUm5+PXC5UChisBvt4H0VAiegTRO75QZQAWgPp7+ic9tNlgd
         WxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788169343; x=1788774143;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Aes8E7ycjw85I1hPRVRNDb1VK1GawwcAPWMBLAtTYaU=;
        b=qU6Nw33cl9vL6OKrRFbH18knVNRQ4A/Burp1wi5AwUt4j+rQ3lzQr1zkG36ILjwrfv
         dsuyOcUbmF8nESJr6Ns1aqZdNiKPHyMwAcrVKhV9K+u/jU8/R+HAaM0ckKm3JexFmGhg
         RfDuDVSlZJbZDGDSOXZx3DWPjMxOG5uP2Jb/HB37e3uljy7BZug5ptdNBFwEmCPnjIqK
         yaCLhvoyJyBZl1dR9qc83S/quVcZamd96u2sa9pK2RGEASH6HASgu+448La+qGDM2atW
         a/FY+ub4qv25tPJowHuP2gTpkeCZ8v1st+ToZpIYHPgHFyWbPspIhnkAXyoyWEn0lkpp
         InDQ==
X-Forwarded-Encrypted: i=1; AHgh+RpUoAHXxjWPRR67+s1hseiihlsbwA8kXRpOeThfJsM6QDMqkSttvR4EyYffTXycPn0HXcg=@vger.kernel.org
X-Gm-Message-State: AFuF++kuAui8uEjAOGe2B9PBCYcCmlvl++O4aUmzHmIJyTkdbfOShmHN
	HKt3AnvIMm/EG7r1uShDw9HjVCSeMkNet7mXKVKimSR5kT0015J3A0FXNzLwlbnEfzpNCy22nJL
	bOJfeWnDDqD8TtW/4YFlVjAMkt7QzVaepVI+NQn29
X-Gm-Gg: AR+sD10zJ9KDwlx+gRB5iC0x9l8/L4A6nvi34NRH2xksDkQRfhXzOV8OSGxyM9EvSZD
	wtVfY5l1Z7fbe/Ftgtmpcr15n6lZGs98fc+YzzCQNJTnCfrZqdhCQ/Ye+0TbeYYwxMX2763gGo2
	ozt7eGp9ahH/TbrmM8r22p68PU2EoUga3J9MoRt5Zmlok5dwxqbANPryrd6Lx1RKvya/TD1dIAL
	GZRYCQdWb+ueiLIj2Uie7SmsPHZYFrOo34FlN64wGctkJevIy8QJ9/dPNwF4TspOT4Qy+RfqjSF
	EjjkhHq8dZFM2ZmqWQoZxjeFr4LUwlkljp5xCYbXq9hssjR4fSc7Uk7LLRv3ksWMKpzhCIw2SiS
	lTmBYiLGpXbovnF6h5+5vVJem1i/0X7wZtzqvKmEkAN1J5B+QbK1gTQX+Sw==
X-Received: by 2002:ac8:6f07:0:b0:52f:ab8f:43da with SMTP id
 d75a77b69052e-52fb9693eb9mr350760701cf.37.1788169342525; Mon, 31 Aug 2026
 02:42:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828060822.2628276-1-florian@schauer.to> <8c7f834e-5701-4748-9a9a-fed78aa50198@kernel.org>
In-Reply-To: <8c7f834e-5701-4748-9a9a-fed78aa50198@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 31 Aug 2026 11:42:11 +0200
X-Gm-Features: AcwNN1XhZ8DtUPl2WaV0TDG5OJhey4REsDrNdGL196w5BGJaMuaw0J-qgC5r8ZY
Message-ID: <CANn89iKN=uj3+_nESHep7+3rurFw3S9Cqc+7mjFTztYEeXJsSA@mail.gmail.com>
Subject: Re: [PATCH net v2] page_pool: keep frag_offset aligned for odd-sized requests
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Florian Schauer <florian@schauer.to>, ilias.apalodimas@linaro.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me, 
	linyunsheng@huawei.com, Mina Almasry <almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 11:00=E2=80=AFAM Jesper Dangaard Brouer <hawk@kerne=
l.org> wrote:
>
>
>
> On 28/08/2026 08.08, Florian Schauer wrote:
> > page_pool_alloc_frag_netmem() rounds the requested fragment size with
> >
> >       size =3D ALIGN(size, dma_get_cache_alignment());
> >
> > dma_get_cache_alignment() returns 1 unless the architecture defines
> > ARCH_DMA_MINALIGN, which DMA-coherent architectures such as x86 do not.
> > There the ALIGN() is a no-op and pool->frag_offset advances by the raw,
> > unrounded size.
> >
> > A single caller asking for an odd size then leaves frag_offset misalign=
ed
> > for every fragment carved out of that page afterwards.  The pool is sha=
red,
> > so the damage is not confined to the caller that caused it.
> >
> > The per-cpu system_page_pool used by generic XDP hits this.
> > skb_pp_cow_data() allocates its fragments with the raw packet length:
> >
> >       size =3D min_t(u32, len, PAGE_SIZE);
> >       truesize =3D size;
> >       page =3D page_pool_dev_alloc(pool, &page_off, &truesize);
> >
> > leaving frag_offset odd for whatever is carved out of that page next.  =
Its
> > own head allocation is already aligned -- SKB_HEAD_ALIGN(size) plus the
> > XDP_PACKET_HEADROOM its callers pass -- so it is a later user of the sh=
ared
> > pool that pays: page_pool_dev_alloc_va() returns a misaligned buffer,
> > napi_build_skb() installs it as skb->head, and skb_shinfo(skb) =3D=3D
> > skb->head + skb->end is misaligned with it.
> >
> > skb_shinfo()->dataref is a 4-byte atomic_t at offset 0x20, so the
> > atomic_inc() in __skb_clone() straddles a cache line.  On x86 with spli=
t
> > lock detection -- fatal for kernel split locks by default -- this panic=
s
> > the machine:
> >
> >    Oops: Split lock detected
> >    RIP: 0010:skb_clone+0x154/0x1e0
> >    Call Trace:
> >     <IRQ>
> >     raw_local_deliver+0x1ed/0x2c0
> >     ip_protocol_deliver_rcu+0x54/0x1c0
> >     ip_local_deliver_finish+0x85/0x100
> >     ip_local_deliver+0x67/0x100
> >     __netif_receive_skb_one_core+0x85/0xa0
> >     process_backlog+0x87/0x130
> >
> > Reproduced by attaching any generic-mode XDP program to loopback and
> > opening a RAW IPPROTO_UDP socket, which makes raw_local_deliver() clone
> > every locally delivered UDP packet; ordinary DNS traffic then triggers =
it,
> > roughly once per 2500 clones.  Observed on 6.12.101 and 7.1.8.
> >
> > Tracing page_pool_alloc_frag_netmem() over one such run shows the
> > amplification -- two odd-sized requests, nine misaligned offsets:
> >
> >    requested size & 7:   0: 17035    5: 1    7: 1
> >    frag_offset & 7:      0: 17028    3: 1    4: 1    5: 1    6: 1    7:=
 5
> >
> > and skb_pp_cow_data() returning heads that were aligned on entry:
> >
> >    head 0xffff8f4c86aeac00 -> 0xffff8f4c53a9a9c4 (&7=3D4)
> >    head 0xffff8f4d6a8a42c0 -> 0xffff8f4c4f7b7a45 (&7=3D5)
> >
> > Round the fragment size up to at least the alignment struct skb_shared_=
info
> > requires, so fragments are always suitably aligned for the objects call=
ers
> > build on them.  Architectures needing a larger DMA alignment keep it.
> >
> > This also makes the remainder computed in page_pool_alloc_netmem(),
> >
> >       *size =3D max_size - *offset;
> >
> > aligned, since max_size is a power of two -- which fixes the matching
> > misalignment of skb->end.
> >
> > Verified with a controlled A/B under QEMU/KVM: same tree, same config,
> > same compiler, same rootfs and identical traffic, differing only by thi=
s
> > patch.  A SEC("xdp.frags") XDP_PASS program on lo plus UDP datagrams
> > larger than max_head_size drives skb_pp_cow_data()'s fragment loop, whi=
ch
> > passes raw packet lengths to the pool.  Measured at the return of
> > skb_pp_cow_data():
> >
> >                            unpatched   patched
> >    skb_pp_cow_data calls       40800     40800
> >    misaligned skb->head         1120         0
> >    dataref at line offset >60     80         0
> >
> > The last row counts the accesses that actually fault:
> > skb_shinfo()->dataref sits at head+end+0x20 and is a 4-byte atomic, so
> > `lock incl` splits a 64-byte cache line only when that address lands at
> > offset 61..63.  All 80 occurrences were at offset 61; the panic reporte=
d
> > above was at offset 62.  Eliminating the misalignment removes every one
> > of them.
> >
> > Same class of bug as commit 3bed3cc4156e ("net: Do not allocate page
> > fragments that are not skb aligned"), which fixed the older
> > netdev_alloc_frag()/napi_alloc_frag() allocators.
> >
> > Fixes: 53e0961da1c7 ("page_pool: add frag page recycling support in pag=
e pool")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Florian Schauer <florian@schauer.to>

Reviewed-by: Eric Dumazet <edumazet@google.com>
Thanks.

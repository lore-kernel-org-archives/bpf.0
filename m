Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACD7384229
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776875876; cv=pass; b=PW0lxprz5Y5ARYT1cyRdvu4dPeUXrK/KPDfXpBra4C4x9Otgckm4IvT1jDL9DvoLUOoze7bNiAiMcrDza4HUAMD32gBfj8hAEQdcNMyJXJELCRJgzgHVCcj8fkS1S2L371CYpYI6bGUMRTkeEggPtoKLl+jtxGZEqHgtZwirCuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776875876; c=relaxed/simple;
	bh=rGjuzTnqffiAxIUz5jJ763+/vcX4tKbZXHk/NyqMxzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hYAftsdt+P6SgrO9pGfCJpRiRYPf0/oN3GqCSK5CJBRNxG9lU6wCApIXNFa1EP4jsZYZ326KvtWpZgX/qV9fBXQOuxxCDB33ZcylGnOU9wIO86FDiOgPzWyoE8tWWAApnToaGpTLHEdtcCTHDMkd+vcVqDYnSOPUAEa1Wm08AKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZB8ohsHb; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZB8ohsHb"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2d832f2f44cso5211106eec.0
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 09:37:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776875874; cv=none;
        d=google.com; s=arc-20240605;
        b=KO9qyyVH37Aas5bOOWbaCcAKN+cddxjNGiTdvXzw6g9l5763WW+EVV55nw1mWBmQqb
         dBSrmwc/XubC0O4opJV7DdIYLtyiSurddNTZHNdzDy+EL0EkCzvo+fJ7bC8dd4TaZxqz
         CZdNgPpsV5h22333ajflYLKBJZ5q7QK4GFthLkq7dArFTzXYUkM7Gyp6u30jiwEwQnwo
         OaCLly5qsWyMYZPyTcDFX7YJiY3obQCQpH7odlA1Fbif7TVjI7wHGYbhT9cefiUqfXSG
         w69HJjIrUutTr+2Uxi69/DlcCFis4gkv1ByMpEt+ELmTsgonE825Nc0qKKCipQlLnXY/
         7uug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NqOrOUk1MLYhmJuehDDrG9eDODdEaY852b+08CC2TZc=;
        fh=rHttxYqCpyyDLHbAuUu0Kzp+USGDzzvuSdowFgl4bus=;
        b=hqHJQgd04R/B2JT2o0yx3TWZLDamJQhqdeS4urklReTaBMUDEHDmt+4a1C0vfYfQW0
         CCYPV5vNPFuxD+p5dQe4bmxmBohCnhQ2/SyvKuDndK0AbAHOnmiWD/JRjJGvAUXl4lak
         PC9YUWyK7woqRqCywt+vuSAUFGBR/9o1HELyzq3NYyRHdBrX2i12+qtYedADe2oE1flM
         AHjvT6uhNvzADYUQdugnA28b4vzF0PWe7PE06iiWhcl0kaNxTbfZ7YrdngTZs3PzJEF+
         5xQfMS0dsPlqWpuI1vihGiNUqYrkR9IrzdrZ4HIXckY1kEiU9qH595AvUCWR/M0XmtU5
         vxVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776875874; x=1777480674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqOrOUk1MLYhmJuehDDrG9eDODdEaY852b+08CC2TZc=;
        b=ZB8ohsHb3jpCaMzUxCzcMUOPdRWxPYzHwoAUUlUt8ZEJhLqQ9CNvuhS1GX3VfjSavR
         TfYcxGcO+Jxw/WkwHJjgciam+uVpnlDzTE7ZoJLTZ6uOiHNd1tLVTWa4ark8Ro1vsTH1
         yEk9LLAWPoZmDTuB67KU4MBcWbiLaFBNKXnq0V6Ojg+oDQWWnPlFVa5GG7FrokNMsA4J
         UhR4e8lXsKFuY8Y1OE5IOdvQkNhIdRSGVeqib7/guhK7T8k7b21TU1q6j+PxsfzFQCKn
         ELUbpdlapQMSCM7EyXtWqGwCjUKH0474+M2ADdm6UUBoIO7apI/Nt2zYxtU/c3Hw+Few
         x/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776875874; x=1777480674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NqOrOUk1MLYhmJuehDDrG9eDODdEaY852b+08CC2TZc=;
        b=sjd/X+Utdgx2J8GdtPQyVDkQw6YqnkeoKjP7bjw6u+fsbbpWdZdVLDjbdukTlorFws
         a0965WcU6NibEdBQhgZ8qPnrtTbXooaL+huiJZwajfEpju9pyrlcZk5fEzw5n1h8Mb+z
         KdOk/mbynveW82ImQhzYhgwJOt4i60tuIxcYKksC6lLsoE9tXPZc9RrLJ2L+iJkK2lVv
         l+AcIYBM82P68uXZmZVLW2SPKMKoIJjkeKEediGqCnIAp9x1f+ivns27y4h9wWL9owz3
         HtZ8FUhBFWTe7ngrtR538FiXgzSGoaNX3+p2gdey5P0tBSTdwzx1dTWic1ygYvT1biWb
         m5xg==
X-Forwarded-Encrypted: i=1; AFNElJ/AQfZ0ZrlOUVjQ5/gvBGYp+cTD5INJAnN5Btv8NEYDnbBYaZGFgaUxJtWIbrnEFr4moeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBV/mdEYYDkmXcaMcxyUQIz7YGL+ZrR1xuT9i6hXomefRFHeKw
	oq1qjdI3tkjicwi7Wl6cShO2M+Dmdn3PBc4W4LxB2D0KRVE17S+dvisrfj8aMUlUNCaM0mhCcVC
	jfjmwS1AlADGuj/VCsCP34ff3ukhg6vs=
X-Gm-Gg: AeBDiesSRVaACdWyHLYtLdw3y/e5HISZQxfGi6P+VwO4YATWGlFzQxq6dRn2NUfsTgY
	uBBIEFRts+VjXjIOyt4SmYlHvtqd3cRQdR/EKB7mqilfRw2tLQrNu7pB7I/CreMHxir6rxHR9rj
	JfKI+v9swnRAIw7GhFmBu4PWNOtwQUO3CCEhLd/DUM+0RFRAdPjy/yYxDAf6m1BaaLEhNBdg4HO
	5e4GZ23u3e8AD637jkVb4M5PxWHTK11r2uzikoRNYvumSjj1bOOp9OJhjAFnn5XRDWUOOD8hw6Z
	dGw7hxTGeGirKuJeQg==
X-Received: by 2002:a05:693c:2c84:b0:2da:44ac:6d17 with SMTP id
 5a478bee46e88-2e47873bd2cmr13631932eec.17.1776875873645; Wed, 22 Apr 2026
 09:37:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422033650.68457-1-kerneljasonxing@gmail.com>
 <20260422033650.68457-9-kerneljasonxing@gmail.com> <2e0e0e18-cb75-4638-9a12-5906de6a8308@intel.com>
In-Reply-To: <2e0e0e18-cb75-4638-9a12-5906de6a8308@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 23 Apr 2026 00:37:07 +0800
X-Gm-Features: AQROBzCJb-hsse55EN9VHp2l2OXgryyt-OS9eWVzC4SgEK6a_JBN4N7SWbH5hI4
Message-ID: <CAL+tcoDTXEsehprDHeO7P1pcqwu_US3Li-dm_YyGDAwu2aYZvw@mail.gmail.com>
Subject: Re: [PATCH net v3 8/8] xsk: don't support AF_XDP on 32-bit architectures
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 12:10=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Wed, 22 Apr 2026 11:36:50 +0800
>
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bit
> > descriptor address into skb_shinfo(skb)->destructor_arg (void *) via a
> > uintptr_t cast:
> >
> >     skb_shinfo(skb)->destructor_arg =3D (void *)((uintptr_t)addr | 0x1U=
L);
> >
> > On 32-bit architectures uintptr_t is 32 bits, so the upper 32 bits of
> > the descriptor address are silently dropped. In XDP_ZEROCOPY unaligned
> > mode the chunk offset is encoded in bits 48-63 of the descriptor
> > address (XSK_UNALIGNED_BUF_OFFSET_SHIFT =3D 48), meaning the offset is
> > lost entirely. The completion queue then returns a truncated address to
> > userspace, making buffer recycling impossible.
>
> What if we relax the restriction a bit? For example, refuse to configure

As to the bug itself, yes, It only affects the unaligned mode.

I wonder if we can support this after someone requires us to support
32-bit arch and use it in the real world, then we can use the previous
patch to complete the full support (which doesn't harm the path on
64-bit arch).

The code looks like this based on your suggestion. Just for the record.
diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index 58da2f4f4397..03417b04592f 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -177,6 +177,9 @@ static int xdp_umem_reg(struct xdp_umem *umem,
struct xdp_umem_reg *mr)
if (mr->flags & ~XDP_UMEM_FLAGS_VALID)
return -EINVAL;
+ if (!IS_ENABLED(CONFIG_64BIT) && unaligned_chunks)
+ return -EOPNOTSUPP;
+
if (!unaligned_chunks && !is_power_of_2(chunk_size))
return -EINVAL;

Actually I'm fine with either of them. Right now I'm not so sure which
direction this patch should take :)

Thanks,
Jason

> an XSk socket in unaligned mode if on a 32-bit arch? Or add a check
> under CONFIG_32_BIT like it was done in Page Pool:
>
> skb_shinfo(skb)->destructor_arg =3D (void *)((uintptr_t)addr | 0x1UL);
>
> #ifdef CONFIG_32BIT
> if (((uintptr_t)skb_shinfo(skb)->destructor_arg) & ~0x1UL) !=3D addr)
>         // WARN_ONCE or whatever + error path
> #endif
>
> I never used XSk on a 32-bit arch, but back when I was working on 32-bit
> MIPS 1G routers, I wanted to add native XSk support to the Eth driver.
> Sure, just for fun, now that we have cheap AArch64 and other 64-bit
> embedded chips, 32-bit embedded networking SoCs are almost dead, but
> OTOH, as you can see, other subsystems like PP still try to support 32 bi=
t.
> Especially given that this issue applies to only to the skb XSk path,
> not native in-driver implementations.
>
> >
> > Since we hear no one is using AF_XDP on 32-bit arch, we decided to
> > strictly stop supporting it at compile time.
> >
> > Closes: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp.ker=
nel.org/
> > Fixes: 0ebc27a4c67d ("xsk: avoid data corruption on cq descriptor numbe=
r")
> > Suggested-by: Stanislav Fomichev <sdf@fomichev.me>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/xdp/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/xdp/Kconfig b/net/xdp/Kconfig
> > index 71af2febe72a..819aa5795f50 100644
> > --- a/net/xdp/Kconfig
> > +++ b/net/xdp/Kconfig
> > @@ -1,7 +1,7 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  config XDP_SOCKETS
> >       bool "XDP sockets"
> > -     depends on BPF_SYSCALL
> > +     depends on BPF_SYSCALL && 64BIT
> >       default n
> >       help
> >         XDP sockets allows a channel between XDP programs and
>
> Thanks,
> Olek

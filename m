Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C1829D275
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 23:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776901576; cv=pass; b=O+qu+lJGcw7mDMQnquT+NeR7OuT9kzwm/c/7C7X03IYVFFsV43Un0L5xau6ZwZXAhHKHrPa9ezg9yntIKxkMw5lFbPKsjz2M1D3c6z/zyRjZt0O2cUCp9iNLE/nP7nRPTDqaMig92SBh3vQDzxUMJmxV/OuTfSXQ5EDHH6IdEZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776901576; c=relaxed/simple;
	bh=r85R57NVW8eSM/NE6sMPR1IjJ29w3fmDxqW/oYNi0ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UnN55dadimAcs27Rj7XKSWNz3vj8sPlyta1y8vt8AXijUELW9hWEryi0j4Z9dHdoLuxEe+wCnOx5wxadZZRMEJXQeCMX6wsI67p+0tEbOn8NZbPlFxdASC2Vo35GNfg1CeQjpV4YvzWwPQ2voSZgHJLpsNHglEDeQiEGRtJg1cM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEov8WDK; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEov8WDK"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a2b5ea59a1so8263721e87.1
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 16:46:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776901573; cv=none;
        d=google.com; s=arc-20240605;
        b=OjzuZYXzgVVj6TbdHFr+lg6PGJAWEfGRAEYuDSvVxn4g78GfubzKsyGyRDfIUh4h/h
         JxP+Vywmon/rAIxYYZiWuamVEIItCM9oxNT0PcK7qq6AsR068pZIf0Y4NIL/ujqBz+NH
         WXhtUdzkQt7OmE0eT9M+nQBxnbSxjjYqJw0FMjQh2GQCVupTmI3axplJ69m2DXMJa3Px
         aWghEQI2ycu2dOCU8xRvswN30ZPqytAjhZwMo23T1anE7xwq3VMg2eCCQGw6OST4XVs7
         if7+Ll2ji3wryMYsxEGblnTeBjXCXJXgXuiV+TKwB1kb9ODDkFyWVhin7GtAmJqQgl5f
         vdFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GVdJjNNn1/VkVF3ZLZB/9uFSUrjOsGK5ioRT6dmRAqE=;
        fh=XJeOediemY+32DkcU7EwWMRsAEN2P7WgDlSeTQe0P1Y=;
        b=dcV6njsQLUwDNW0AlvAzlaNaX3bPUx2w+ZNlkXTdrt775mMqUBMK+PZ0YKdYmN9btm
         l9j+G7YXUd9RPXQZ9SgcYA8+blh8uIDjOmq7vz3nxXSBji+mrp6SZM/qmiS5UsopZq8Y
         FzrKt2bqjIqfMGD1+NtT5y7TiKA6LsZtE88vrdYkdDLTusH7euCqU5rfZiNduYaYLxO7
         N+vzzenEEOMbC00yja1Xp05ODnjHQiiBARGcdsrr972o0bnHGFeoRbEJBAJv51lx5v9e
         IQi94GR4qcT7kkn4i/SLD88eajke70App/xMV5Am8C8t4HXmII5xh9ykqsxbRsY66Cua
         i5Fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776901573; x=1777506373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVdJjNNn1/VkVF3ZLZB/9uFSUrjOsGK5ioRT6dmRAqE=;
        b=LEov8WDKj597klFA7bnqipJ0uFLax7RlRjwccd8yOQDCwp4xFmWBUf8jV3Zll5S13Q
         Dk/QDEozJVBofGP6kJa3rN7MOABT5x1R7rrQ8gANflGPQvuVjt3Fs7IQ+AXNjRhSf1xl
         vwy5GmEbqlM3Vt402SxXSR86FmGR58oZi4raKZwBBa5WR00A/W7nLAiSddSddYrMnqbh
         SZ07wLLNJcdYkvXRJ6MxNFSHKCUj6KSh9k3s/Dnx9jYO/vWwOt8I5aw38bCiWWL8P9ta
         GmDo7FQVRUHC9EZgg4joiWETeinHS5N7VD9O04mKxLQD3Tr08JFHW21547aDkQ3hq53W
         diMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776901573; x=1777506373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GVdJjNNn1/VkVF3ZLZB/9uFSUrjOsGK5ioRT6dmRAqE=;
        b=ScyM9nMwCmKP3MxOBuYmYlguCZNvoKg1ptgaPNDkvIyvEsOza0ruSGAyKTzK5ymt7p
         JL97TuSceGxGkjvET6jMSJoZOCENLukm/rha45iwLc6XR6JTQ1XJUgdEB5PO/OYyHx6T
         Jhy7hXaefba69XGWMIYzLQaa1kK00gndgNLWl6SrjNdeoKf//S3N32DL27TutDfauk+H
         9BAhJWdmdtG/vRYeCAdtr0Na6j9LrL8KT8TjWNH5cDb8pmnSdrITi43mYDgzHsSZZV6i
         17PjgYhc/pL4dzTlq+d8JZ4cE5zKOwN3PpM2HUOmNW1PKQ4WFJ1w7fW/av/qdXKDajyV
         n/Gw==
X-Forwarded-Encrypted: i=1; AFNElJ/kqgo8L9hJ55N75rv9X3/jxIvyWYRzJvmJQB4S2FJFTar31GGrcHkU0aFFfqQjmKbYucI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjt5SwefGkxs/qWWxL24JXF0+TDorAVbQnvkKKiH+xbuqHGU2c
	/pDr+D01tvzzr/bFU09+SLa7OioV79WrDYuT1+X0FE8pUIKgIyHpgnuIXAS3G/rdnBsRZ1u3KFd
	YjOp/oAvCNTW5E+AZaMl/WLtw26xQocMUAi2qK43iZA==
X-Gm-Gg: AeBDievFDVEt0JvmYRtaLdJz9OuBUA0orLp6++b0ETKj2IN7fPeZ9Xb79aVCXVtWA1n
	Q7RAlVg1VSGBKeM70YbfGNkwHAFMopIcTuzgH8apeYor3vZrjG3WqFahVEB9b5VL9AOA8xrXTXO
	RdIQWRRgNByWQ4qzhVBtFJyOdLdPF3II/A6xVrtn+uenY1mD4cPtyDukLFfo9RDzhfQjmPQAtjI
	THzosmTt/+PLhBGt9viGpIW82lOdQP3hI+TpFKX1gWjzRJMHmZCiFqfi82b6RuIVQiW0Oc3ljGo
	BpWHW+hz12eI6PR4Mw==
X-Received: by 2002:a05:6512:3b08:b0:5a2:afbe:4aaf with SMTP id
 2adb3069b0e04-5a4172f63eamr7151436e87.21.1776901573109; Wed, 22 Apr 2026
 16:46:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422033650.68457-1-kerneljasonxing@gmail.com>
 <20260422033650.68457-9-kerneljasonxing@gmail.com> <20260422212741.50deeb06@pumpkin>
In-Reply-To: <20260422212741.50deeb06@pumpkin>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 23 Apr 2026 07:45:35 +0800
X-Gm-Features: AQROBzDDuAl2OSnLbOvFaE-XlTSEU46HN_-vyDfaJxynGIzlHMZSeJrJj2JfxfA
Message-ID: <CAL+tcoCMrtYR=938roeQ-q4j8LKcsUYxm_qSTPLCdYjBhD_urg@mail.gmail.com>
Subject: Re: [PATCH net v3 8/8] xsk: don't support AF_XDP on 32-bit architectures
To: David Laight <david.laight.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 4:27=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Wed, 22 Apr 2026 11:36:50 +0800
> Jason Xing <kerneljasonxing@gmail.com> wrote:
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
> I had a look at how this is used.
>
> I suspect that XSK_UNALIGNED_BUF_OFFSET_SHIFT can just be made smaller.
> The 'addr' isn't really a normal address of any kind, it is a really
> and offset into an array made up of pages of memory.
> The actual address (kernel virtual of dma) is generated by:
>         ptr->array[addr >> PAGE_SHIFT] + addr & ~PAGE_MASK
> (after removing the unaligned chunk offset from 'addr').
>
> It is actually quite likely that there are enough free high bits
> even in 32bit mode.

Interesting idea. But if everything is folded into a 32-bit area, it
means the size of umem is only 20-bit. 20-bit reflects that users only
put a max 1MB data into it. It might be too small to use?

Thanks,
Jason

>
>         David
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

Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B3234DCEB
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 23:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776901841; cv=pass; b=GiJKIgfX/UlrkCgLd54wvHuWy8V70ZzSFqZuBiSkyDrdkfFImclgdTi9imqFl6zNe9nVo2pl96XvkEigkMGKPfWU7Wg4N/bzd9IICUZfPlHj1JZEKCga9I573CWE6iYRHq05hfBMS/ae9TI0Gz28zGM/ga59Pt3uO906eHvi12E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776901841; c=relaxed/simple;
	bh=no9t7n7xzjKEdEguICJKP5JU4MmYUMLOYVDPqJvefng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=halopNT95rpWhi7B16Hew2CjNIt7q0ShcyyWII/Z26BvneGfwovLa6FOa7IA97b3rV2cQl2zyUC5RlGtXYIqqBBSmbz6IqVhVIfnhsJfJOjkofVvYLHePFbKfWWX/VS8Z9gkKKvcfBtbCJ/CJuPpcxJLkL27JTJz3901M2/WsFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6HkVjLm; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6HkVjLm"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59e4989dacdso6639338e87.1
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 16:50:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776901837; cv=none;
        d=google.com; s=arc-20240605;
        b=JhwLnOsx0Yd8BJ9OauVD6dtidQYpgYglAsG2B5oRnoveRctTV63RCQi5ipY8cV6kSS
         DfPwBYlJ7JILzPKAYj7CGu9BGT2v5uE8klYgABI5niefNKXqjjQITlK8qAw9O9ncgrOk
         wMWyX5IxrYR4o2ICOm21FEdB4mHlu6gami4ujXVQfxmdy+IM8SSt23bhIIDMz6TcD28H
         sAnOBziFmAnHDzM2WUHd2+WctFix7N3m1aQ9WH1Do7bBMaJ1TBAzlJaA1GoIlXeV4Ry/
         ExSUVzwKn/tsXgWd3CJxlfg/NWdYmM64NZqLNybjZyipQxn4NO4n+zGpXO2BozRZ8VIN
         kJjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rWKgodUk2lqfpq4zWor/YRrwGhepF6DjxbmcnZlGs+o=;
        fh=qPQx2/uYNX2MVth5TJWr1RAMcP3p458Q5mNdeDRS+zk=;
        b=RDJRbKOuIa8H0dD8Hf73GL4IIJJz/kzPyvEyomWCG4r9dxTaJzz6S0nuojnZBLCdAm
         a9gwBgPDwlcUTeGSKHdVD5KKeyE8J+kZVf/vJAOExSWT1IvPzsD5FaobsCnKfAUPDgJG
         dQr/DNm/ifiYSibqKPcV0pINM42RMQSWct+4ib4XU+eIn3wJ1M8KpZI/+urSulQnpuNn
         4Gl6xsSbEmgzO0mtr7QM7KdIdvlsrIKaStprPt8k9MP9EWcVBHWlcWNJZD5x9ML7IMSP
         DQBXoXtZ9nNKpxMhfDlAhggK/kAW31Wl4xmZwNr2Y58D+6TP8xfJqZBOGRI44d2jCPed
         E4sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776901837; x=1777506637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWKgodUk2lqfpq4zWor/YRrwGhepF6DjxbmcnZlGs+o=;
        b=g6HkVjLmOwBHp0HkoYLHuCWpWoEzGZxJ7CeeaKthWNW/qMUAWi7EeMJpZjz6BHnlkt
         uNL0+594dcuzrF4/JfmcxuLmtSQGR3o0MfQey5gnlzCoDbiIxAoEZkaq7PAfG0aIM1V9
         LN6KiqzcPauH4N3RMAfjKv3S/qB9DUz3RQBCNLkskQVay/1Zw9dcnAUkLi4vLJqEb2bv
         AO3EBn3ImHQDYvcA+ztCx5g+nGWaX85+4zL4HFyqoOVso5/3Spjy0w7OUu2lyRG3k9gQ
         LCCbWwP1SmiT08Ne8mY8sVlg93xfrmDwKMy6Uy+fGAI6mJK/+vXSrf/4lP3iOooWdNRH
         S7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776901837; x=1777506637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rWKgodUk2lqfpq4zWor/YRrwGhepF6DjxbmcnZlGs+o=;
        b=A15lc4+RXSfbcpCtjJ8P4eQdfYnoxgQ50nfxSG+61rCdyMyjHF0ozS3KhXbfiCCNTy
         0b8y7kk4mQqEECpJNg3pDVjaD7BFUrEK+PiP/hXuslWIfuqmDfykvtRdSoIpoBW7FH7Z
         0iDWwFXshbPBCz4HaqU+tSUZAl08v2mSavXDgHlH3Upw92EnrvBRIhRAyqbk8r9g0owN
         Z9HY+LZhjgVYVRYg2ig5GMU+HEJz0KntF1oNSeuq2UbJfe8kN0ZKRghnoXogx7ZAiYq2
         aM/9cbAjbsosZQ1x5aPJyG1AqLY8QMnVg6PFzjeY3PVoVP1DVnWHtH8QTv/2GywZt+DV
         KjfA==
X-Forwarded-Encrypted: i=1; AFNElJ8x25xNWNFp3LVOFbNJ3gLzLCydoj/ZLJ5d8gP6JPPyh9pfb+zbeEdfGrDJbT/wHyNQFOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YykkAjclvvY9j9oUIpLdpFOXiNwk8ZRjgiEPIjkRdhbNIxYx96H
	KPSdNzpSxtUNqb7udFQP551DlnIDiji7kBM7m1oNYGm/w5PY2iA4mVwocSmK53S9MBYY8NjKiso
	G6D2CBMGYXMyh0JwP4PgtB9isleolpXY=
X-Gm-Gg: AeBDietmBZAZ26dPwcQluX7awbiV2Kh+aF00uxJOkq9T5hLyL4Sy0rCOFw/+mO/rs80
	KlUUEKFmuxc4HaHjF5jCWP6N4xOgCZH98HgPqHHSQi3Ygu/HCNf6vuatGLG9IRDxqTQhbMS4lCb
	Fee81kFViqOZ6VtCHQPCC2dWin5y6SDVRQaUsElSpHrZJ9gvJJzyjt1BDcVGg6rRWHwGWLqgSWG
	WmmXBiEcX5OgOGkLhmHnESKtZfOw//25J64nvGlloBwgP6LVYZM0cpur2XJIcUnvYUUPDbSWwiq
	Z85TZ2K51MFNRGIWfw==
X-Received: by 2002:ac2:4248:0:b0:5a5:25ae:da23 with SMTP id
 2adb3069b0e04-5a525aedc8amr2944807e87.40.1776901836214; Wed, 22 Apr 2026
 16:50:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422033650.68457-1-kerneljasonxing@gmail.com>
 <20260422033650.68457-9-kerneljasonxing@gmail.com> <2e0e0e18-cb75-4638-9a12-5906de6a8308@intel.com>
 <CAL+tcoDTXEsehprDHeO7P1pcqwu_US3Li-dm_YyGDAwu2aYZvw@mail.gmail.com> <aej+JZyYwUrRXD6e@boxer>
In-Reply-To: <aej+JZyYwUrRXD6e@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 23 Apr 2026 07:49:58 +0800
X-Gm-Features: AQROBzDMd_qNuudyMnQatwNO4VL0bbzV4lQVlEWMg5FLlJOSPACqvRq_xd0u3xQ
Message-ID: <CAL+tcoBH9qm0Ce=vBuCResVEbC_9a1D2VofTW73Uo+t519Ui0A@mail.gmail.com>
Subject: Re: [PATCH net v3 8/8] xsk: don't support AF_XDP on 32-bit architectures
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	magnus.karlsson@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 12:58=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Thu, Apr 23, 2026 at 12:37:07AM +0800, Jason Xing wrote:
> > On Thu, Apr 23, 2026 at 12:10=E2=80=AFAM Alexander Lobakin
> > <aleksander.lobakin@intel.com> wrote:
> > >
> > > From: Jason Xing <kerneljasonxing@gmail.com>
> > > Date: Wed, 22 Apr 2026 11:36:50 +0800
> > >
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bit
> > > > descriptor address into skb_shinfo(skb)->destructor_arg (void *) vi=
a a
> > > > uintptr_t cast:
> > > >
> > > >     skb_shinfo(skb)->destructor_arg =3D (void *)((uintptr_t)addr | =
0x1UL);
> > > >
> > > > On 32-bit architectures uintptr_t is 32 bits, so the upper 32 bits =
of
> > > > the descriptor address are silently dropped. In XDP_ZEROCOPY unalig=
ned
> > > > mode the chunk offset is encoded in bits 48-63 of the descriptor
> > > > address (XSK_UNALIGNED_BUF_OFFSET_SHIFT =3D 48), meaning the offset=
 is
> > > > lost entirely. The completion queue then returns a truncated addres=
s to
> > > > userspace, making buffer recycling impossible.
> > >
> > > What if we relax the restriction a bit? For example, refuse to config=
ure
> >
> > As to the bug itself, yes, It only affects the unaligned mode.
> >
> > I wonder if we can support this after someone requires us to support
> > 32-bit arch and use it in the real world, then we can use the previous
> > patch to complete the full support (which doesn't harm the path on
> > 64-bit arch).
> >
> > The code looks like this based on your suggestion. Just for the record.
> > diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
> > index 58da2f4f4397..03417b04592f 100644
> > --- a/net/xdp/xdp_umem.c
> > +++ b/net/xdp/xdp_umem.c
> > @@ -177,6 +177,9 @@ static int xdp_umem_reg(struct xdp_umem *umem,
> > struct xdp_umem_reg *mr)
> > if (mr->flags & ~XDP_UMEM_FLAGS_VALID)
> > return -EINVAL;
> > + if (!IS_ENABLED(CONFIG_64BIT) && unaligned_chunks)
> > + return -EOPNOTSUPP;
> > +
> > if (!unaligned_chunks && !is_power_of_2(chunk_size))
> > return -EINVAL;
> >
> > Actually I'm fine with either of them. Right now I'm not so sure which
> > direction this patch should take :)
>
> Abstracting from discussion, that is not a patch we would want against
> -net. We should not forbid 32bit on stable kernels, maybe there is someon=
e
> in the 'basement' using 32bit xsk on stable kernel. Plus the fixes tag vs
> patch's content looks weird ;)

Sorry, I don't follow this. Any specific suggestions on how to move forward=
?

Now we have three approaches w/o the fixes tag:
1. completely forbid 32-bit arch
2. only forbid unaligned mode on 32-bit arch
3. completely fix/modify the allocation logic of the first frag on
32-bit (see the v2-0008 patch)

I'm wondering how to proceed with that?

Thanks,
Jason

>
> >
> > Thanks,
> > Jason
> >
> > > an XSk socket in unaligned mode if on a 32-bit arch? Or add a check
> > > under CONFIG_32_BIT like it was done in Page Pool:
> > >
> > > skb_shinfo(skb)->destructor_arg =3D (void *)((uintptr_t)addr | 0x1UL)=
;
> > >
> > > #ifdef CONFIG_32BIT
> > > if (((uintptr_t)skb_shinfo(skb)->destructor_arg) & ~0x1UL) !=3D addr)
> > >         // WARN_ONCE or whatever + error path
> > > #endif
> > >
> > > I never used XSk on a 32-bit arch, but back when I was working on 32-=
bit
> > > MIPS 1G routers, I wanted to add native XSk support to the Eth driver=
.
> > > Sure, just for fun, now that we have cheap AArch64 and other 64-bit
> > > embedded chips, 32-bit embedded networking SoCs are almost dead, but
> > > OTOH, as you can see, other subsystems like PP still try to support 3=
2 bit.
> > > Especially given that this issue applies to only to the skb XSk path,
> > > not native in-driver implementations.
> > >
> > > >
> > > > Since we hear no one is using AF_XDP on 32-bit arch, we decided to
> > > > strictly stop supporting it at compile time.
> > > >
> > > > Closes: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp=
.kernel.org/
> > > > Fixes: 0ebc27a4c67d ("xsk: avoid data corruption on cq descriptor n=
umber")
> > > > Suggested-by: Stanislav Fomichev <sdf@fomichev.me>
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > >  net/xdp/Kconfig | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/net/xdp/Kconfig b/net/xdp/Kconfig
> > > > index 71af2febe72a..819aa5795f50 100644
> > > > --- a/net/xdp/Kconfig
> > > > +++ b/net/xdp/Kconfig
> > > > @@ -1,7 +1,7 @@
> > > >  # SPDX-License-Identifier: GPL-2.0-only
> > > >  config XDP_SOCKETS
> > > >       bool "XDP sockets"
> > > > -     depends on BPF_SYSCALL
> > > > +     depends on BPF_SYSCALL && 64BIT
> > > >       default n
> > > >       help
> > > >         XDP sockets allows a channel between XDP programs and
> > >
> > > Thanks,
> > > Olek

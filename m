Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E8E2E9757
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 19:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776109488; cv=pass; b=orml/PPBHXS68xD1pJJjbyQpnxm7IVW2RovIisbmwDUz6bhU0C1aeDM0M/dHzVAbg1/I5FOSN6ge2vz9zJs/JCKk/W4/pXSdVPHfYmd8PhsApybhssYS8UD32L4vaspY8Zy9w+ojkv3NPx+imzLxsKDRVwokDn5WOIlO3xAgG7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776109488; c=relaxed/simple;
	bh=Lxn0rT4NL871Dmj7cVMTP69H2H1S5/tq78BQp0KXVsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XOE3qn95ZCIDGn3NnmwaQsCbf/0AsHoGdXXhnVZs+7bNtNFiqO/cEsL8Itle0Mcge74nX9U9szB7DAx17k2TW9jawoOqlSufuY4dxEmByuHXAZQDNs9tSM1PlrUfK5eQJQs2TQHbCGHoA/T+Vp9OZElEcv4X3T8R+gaBRoyXcqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKSIcknz; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKSIcknz"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso39756245e9.0
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 12:44:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776109486; cv=none;
        d=google.com; s=arc-20240605;
        b=Mgwvk/3sJ5noF2ceYRHFb8BRB0uyIueyRnpqDbH9x5qRPjro/rWQu5tXMtfSD+DWi/
         iwyvAIJa0gfJSkQByeeVf97as1peGBoxll0+42z88FAFC7yoBZuLrWckijlwf/GP/KFY
         DS41gUxKa3FWh5Iq7BrqCOV0pc4J6/Z0zSmTgPTCmVH90KImmcvQlGc+20g8ERKe6uBO
         GWyJNeeLYKS/g4tE1X+w1yDJ/YJw6fcfx5x/Rx227Ky1nVxRL4a7i9JOj9RGxqKUouf0
         QMLgeJ8tu//JX4X7u9Yw3vAvul+4au/YqIfspqmV5SVaWPucgkoROBRCcXS2ZvdQdhwX
         7ssQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QAfaCfxMWVbvr9ZyuYf8x1ao8k7jF3ydi1hTK+fOsDk=;
        fh=uWu2WEoDM7dlqFUuYB/8SEdcOJCydmUKIovqDY2M+Ag=;
        b=OZhu0dJDVd+EKY7p0Wy0JJnk0lv6JaR3SW353J01rCYJvFsECupUh2X2fz6KfY+zw1
         sgb1eKYHTtFWrQqZsBnaK++dfhiWzjRaPIu0147eL32XkF2QivRKgfgehuo+a1mOHXOt
         ZCPzM1ly5V3Du55GueZEs2SMrIwqM8eMkz1VzCLD3Zl1eaS+IwhdyeW/rLi5avwAeWAV
         XFzFOJg3tiYWzF2xVe/Esaj7TaRmpvKx4Or0sQIz6MiuP+JYfAohO6D7DDDdnkgK6D4L
         3jj0qXANCG7q/z7UUatoCu/4dT810YT8unRuzlCkqAgoPs3BABD536TTksv+wGHqQWcB
         uUVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776109486; x=1776714286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAfaCfxMWVbvr9ZyuYf8x1ao8k7jF3ydi1hTK+fOsDk=;
        b=GKSIcknzzBd9ISRgBhznSHrD9jZV/O/gqtzPdUThe5kfhl9XQTIEjbW1Ud4CGN1LM9
         hukW8sIpO8VGsZodZ2VEW4A9hU+PemDYksxhxdVGZ1jdbnhNTpbbQ553KP4Bn+PqPNaW
         mvNSYY/OeZDya0E/UBssjmMrqQrOb/RVwfJVCLiYNEsrqRuJ61etSvIfQiSE0K2nGiV1
         NT4MKwkGpYzvHgmSLqORH9qwzBe07mlBuWDuKaToodEMOIYlUqg++Q8XoiJGaUgLnJi7
         ClY8hDWoqXwfL7kXdYJ1bjaal3yJRTBUvHA67ILaxoYx5hiSYNPmtQtscVR+O1ELKl85
         p1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776109486; x=1776714286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QAfaCfxMWVbvr9ZyuYf8x1ao8k7jF3ydi1hTK+fOsDk=;
        b=K+w6YeJjteZzpCY8k9Yqae5LYpnP+XLfF/yCCtjJnds+6jz6UAJY4V8TOt2Mn2HJXw
         lFS7XcEFV+oKsZKDk0c49JKkwydmcrkq0MGkbJoTqU2e94Wag3vRmR1VkCgAALB2kXdO
         7rXKbJj2TFIf+NT0kjDRX3PHtGkUKyoU/Q2P4/SWye60kYvzDF4FSa3ZCTarf2Es2l4C
         LBwf5GQIWlu8w7AnRuBu/6iYT/fpU3AQTOInLq1hOA6Dk6MGyN1JXSITvyWZhA7vAy7x
         QnonUpIlj920oz0pyEnyAiqqAC2/BZKHg2qSKVokue4bMVklXERaeE8XbQ3LvpxqPhB+
         olrg==
X-Forwarded-Encrypted: i=1; AFNElJ8E10ROg5Q+1yW2gF5Ms8XUGQ3Oe2ky/MTLpwiuYipiViLBt1Gfxy5+bF/XFTBz2IgIsN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2IgkYJ4W8pD3nVsdRS0hXz2Gxi8aZw43pSGCzGIL5j/RjdNt4
	2eQCnIb0YgT1Oe6ELFBs/qacTbSjoR8nvAzzpiv3ogC8Y2mVcChU7h7wtfDFMcFckL1M/lalCWk
	fG/WTEYO4R7ZlOoUw2mtoIpau3umuCXQ=
X-Gm-Gg: AeBDieviIbBF9N9swqq009mwCxqtH+j4e6GyWYTweCw2PBWI7nj03WunPfQ4iuOzqNl
	kGfxyPcJCnRR1qLwULzTESmkfvA2/SON1tSEix0SvY/WwpTcRHLk3exy1gDBsj7OunIpjSAe3RC
	AWqyTi7PigOqkpCpx/xvysaaSIi2vqRIaMLI3izD3behnNHsiVgYz0/LyU+qhsXA74nInDLU1en
	UqRgLTDGZWKeUIP+SMnj8UIW/yBhbPQ012ywrltUFbkSo7M4+Y0dSaTkNgg5IN9Ol6BYqUschcz
	rJGA1nnPmsmXPoHQ8JsVNTpOu4XdWrXAhYddoVNV1/uyW+e7g6uYmRLlmp0Vpjd0Iuc+3LAEJMM
	9pKGBHLtVeXB21ANNUZmhqGv5+w==
X-Received: by 2002:a05:6000:605:b0:43d:7c4e:1ff6 with SMTP id
 ffacd0b85a97d-43d7c4e20b8mr4665859f8f.1.1776109485560; Mon, 13 Apr 2026
 12:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412022714.1955495-2-bestswngs@gmail.com> <20260412022714.1955495-3-bestswngs@gmail.com>
 <DHRD7K4Q4R0E.2HT85NT44DKZI@etsalapatis.com> <CAADnVQLhnnt8uGoZk=38zH1jh_9Uy8ah=NdcoBE71qGkuH2O5g@mail.gmail.com>
 <adzBmOuXCZ0vHnbg@SLSGDTSWING002> <CAADnVQLxJ4+uAEOLw4+w-aAsObaJFBLE4uppqAd5b06uAD=3Fw@mail.gmail.com>
In-Reply-To: <CAADnVQLxJ4+uAEOLw4+w-aAsObaJFBLE4uppqAd5b06uAD=3Fw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 13 Apr 2026 12:44:34 -0700
X-Gm-Features: AQROBzA9NVJKtHQ10n0CxdlQ4qlXDsNWTsn29cNh4xu69AWCQTz9sK-0NEGSoE8
Message-ID: <CAADnVQ+jxEW=8kXWdu1q5bW=LYPbpEZ8bDDe1CuLDH7T+BMQ6Q@mail.gmail.com>
Subject: Re: [PATCH bpf v4 1/2] bpf: Fix use-after-free of arena VMA on fork
To: Weiming Shi <bestswngs@gmail.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Barret Rhoden <brho@google.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Xiang Mei <xmei5@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 11:53=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> >
> > Thanks for the detailed review, really appreciate it.
> >
> > I traced through it with GDB + KASAN in QEMU. Here's what happens:
> >
> >   1. mmap =E2=86=92 remember_vma()
> >      vml->vma =3D 0xffff88800abfe700, mmap_count  =3D 1
> >      now Parent VMA =3D 0xffff88800abfe700
> >   2. fork =E2=86=92 arena_vm_open(child_vma)
> >      vml->vma =3D 0xffff88800abfe700 (unchanged), mmap_count  =3D 2
> >
> >   3. parent munmap =E2=86=92 arena_vm_close(parent_vma)
> >      mmap_count  =3D 1
> >      vml->vma is now dangling
> >
> >   4. child bpf_arena_free_pages =E2=86=92 zap_pages()
> >      reads vml->vma =3D 0xffff88800abfe700 =E2=86=92 UAF
> >
> > The core issue is that arena_vm_open() never registers the child
> > VMA -- it only bumps the mmap_count . So vml->vma always points at
> > the parent, and dangles once the parent unmaps.
> >
> > What approach would you suggest for fixing this?
>
> I'm thinking to just do this:
>
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index f355cf1c1a16..a4f1df1bf0f4 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -489,7 +489,7 @@ static int arena_map_mmap(struct bpf_map *map,
> struct vm_area_struct *vma)
>          * clears VM_MAYEXEC. Set VM_DONTEXPAND as well to avoid
>          * potential change of user_vm_start.
>          */
> -       vm_flags_set(vma, VM_DONTEXPAND);
> +       vm_flags_set(vma, VM_DONTEXPAND | VM_DONTCOPY);
>         vma->vm_ops =3D &arena_vm_ops;
>         return 0;
>  }

sent the fix:
https://lore.kernel.org/bpf/20260413194245.21449-1-alexei.starovoitov@gmail=
.com/

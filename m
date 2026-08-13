Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297762836F
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 22:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786659412; cv=pass; b=EhNgMqCSqnB66nmFCDAualnWuhNe8FqOu0I5o0Vnszsre1qVB359wKm/iwV09BrL4gy+EpM1qVxssOLtP3y81WJlnnpXsNbQMfss1lsENoZZPXNAgF0uWORS0TwhIA0YmShEUd1uIv0xTNdkOOp0LkfsUtfLD9Wi4aBMY3VDyRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786659412; c=relaxed/simple;
	bh=o35dZJ0BQCy/ELGJu4PSDG1IxdlRQ1OEdXPxJded7HY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=urvGPoJBP+QwqbQB+maPtt+rtD+fqllbAITh1bhQfs9oJme2Intjho2QUUF9BSJMaCPE7RPWxeIBeiKyJKIes3mPGtUw0H3U6QMXrTjdHaG0tbDhZJqdvP7/axEf3pyc8OCjZA2P7wb62+2B87j6BAi8E8KNWzYqGqYHf/sFaj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcYFWFU1; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcYFWFU1"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ca97d139d8dso187740a12.2
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 15:16:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786659410; cv=none;
        d=google.com; s=arc-20260327;
        b=WvfEp2T9tI4Xaz2a4muKqj3vOIgLbSjO6CsW/YQf5wBpuMlC/vzrfirQ04ihlnaYJJ
         7oTfOpNSll6RlgcAj+huQM9WtNfmrAJn0ARMpe0Gb+XtOVMd20PNXl16dEm2GiNu63Vk
         TpSUHZVbJsWq7XGaG1dj+WtdnesBSOWXQnt6QrvO9sBWscZhb6axtP200MYhDMmkWhD0
         ciIca0P52rZM/yYr0G9QUdWwddkQVC26HwNkpbxVYiYPc1lemxgE1PS82FusKNOQCsKW
         ilcyXRiAsHlaFOhuUakFR4cwYQVmOMsvAhkrOvpt9Qapr1Jj6Y1MP+S75ud8GGlqMKt3
         sJhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CcTFzX3Boiu897tHrY0Wnq/RbK+9GkP26RjSRHCQRZg=;
        fh=tD1M1+LIKDqOHgXF5hcN6UBYNyeC8XpWtz7upTYqC+w=;
        b=qSM3o/6ivpjV1YYyGkCN/SjpJ6QLFy9PhE7o1xxIazpFF10rT6IQRBg0/YJ/JQbpoW
         SXZgg3gjkcL5L3gLnP6q/4mkQg4MRLibr/8FaQQXNyPkgQXcbNcMDiqMi0QTREbo54hC
         W7eKsq5CbxKgfp40aOp2edaNC9wb2s9TBmZ8v0JBzfRQa6+59zyQkV+eCAaT8TOo61dp
         cfygG/mQhSfoPtIAUOa8AIoyN2KMEOrIwYez5zLyqijeb6nhsbl0TF5JX5UQt3zHlZ/z
         ACgfM5HvNjP5EsoMn0ly3xWFmYyhjIL4msjylA+9qkADVJSl86XeDsrtuYmWK/Kc8+1q
         Yezg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786659410; x=1787264210; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CcTFzX3Boiu897tHrY0Wnq/RbK+9GkP26RjSRHCQRZg=;
        b=FcYFWFU1VSoaYNVSOP12AhuMqESAK3OhHPMJ87SAJGxvojDXoqsp0M4k6c3H0LOUOa
         EqStWr5jMoKajarsSSbSN9QwDfVxpDjpZnh+hA5h5rv9bShQsJPCRfl0eJKX0cPlV65o
         7L+XZ2j+yU8P53yvNisTaKp1phwgWcytu+cjCPO2k5IoiRJ5P2UFrv/sfF+hvYt7uIf9
         7ShDNrI8EXIR2mHTgvqDJGK/E0riIhBLcAcHfN9DkCOlcuMh4udmYeyaSo/RJ2sIPvRv
         qBmnuMlDZVnv9kFS+pOqQa0Wgo98Kog1vI0Pk8mJsbdJZg91+qcNNCYV9J0XI9zthNX7
         GK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786659410; x=1787264210;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CcTFzX3Boiu897tHrY0Wnq/RbK+9GkP26RjSRHCQRZg=;
        b=hNhw8/FpqgG0svTtLivSxjtk33rT4IE8bXTjM/cX+gHeb4/WMj31ssjXDQzgyo0dHk
         rYWwoe00OQpx6rJCODcJcBabgxaY40fxnLPPuaymv3Z1B33MikTEN7v7wzyenN5JhH5U
         wnAKBwPusvpLNvXAgIgT+sBeu+UNfFjhJjVCx5zjR2LZy9e2kltICgPqDFyjSLo/WBAR
         C8Avh+5fuWwJ4TQU+CeYrVVxsgnwJn41eI/aqH0CzPff3xVak3UeBsfcBMRAv/9LZZjt
         CgL1bwhrY0HKK5/QFvbx267j+hcPUbXnm8KOTyHJ7qD7P0Ztz4ZoudsoIrFKuaM20+da
         p5UQ==
X-Gm-Message-State: AOJu0YxFlJSw+pLjx3OXvvlYfEefmhxBDEjk4w1Vn9huYspgWrquslIB
	VZIxAo8dZRJWC4IiGOPD4MXhFDk5LX2DbyNGqcIcQ03mqaGDB+5Le9juXSpvIhMHWeEt4z5Nmvh
	XZl5LeO1ajzywBRz/cfZDnaOmnHLaLowNa/bV
X-Gm-Gg: AR+sD10czA7LROMuhnJQn9ko4aCk/RTN+XA6jgN/EQl9woJkb9QLYuFuMF182bZ2Ivu
	GfL6fSN4hRwypJhIHNQvpA0Jt/abA1wKFSMbm5FqdflgjpTdTP5k8nLglULvoCyRxN/F7+qjRgq
	lj+qG5w6Z3ng0ar7ZK6yWJezv5oiXZirPlp8WV8xek46rni5SYr0XfMlWSTbWgE3VQWYNP6UZoH
	nTFJM+JLubeAennzxKwa9LpsTyg7SnM60wXqYMLwYZ7f/UAW+N+S3vaRhrtebNO8fsFPcruqFrh
	BlFrsRxTaO6prP/J+ihjMwikjHrpfzRJjal2E60nMhxu9yiJfW9RXwVHAd4/+rktinW8BlGF2Qw
	hSufVFWZdG7wjviKsbo/kBNbvg3CzvIXnn5Cj48vVstA=
X-Received: by 2002:a05:6a20:431b:b0:3c3:8d4c:6673 with SMTP id
 adf61e73a8af0-3cc71ddd759mr799619637.37.1786659410309; Thu, 13 Aug 2026
 15:16:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810092814.2698521-1-chenyuan_fl@163.com> <20260810092814.2698521-2-chenyuan_fl@163.com>
In-Reply-To: <20260810092814.2698521-2-chenyuan_fl@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 13 Aug 2026 15:16:35 -0700
X-Gm-Features: AUfX_myP9XI0LKeiUAbwgg1TMB5Qd8ADu3TpCqNxKgwIuBHS7slLV-xzNRHjc9w
Message-ID: <CAEf4BzZj3-qWtBaSQ5PKKji531Qe_EWEsFU4=VsHzHaa775E7g@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix queue/stack map u32 index overflow
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Yuan Chen <chenyuan@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 2:28=E2=80=AFAM <chenyuan_fl@163.com> wrote:
>
> From: Yuan Chen <chenyuan@kylinos.cn>
>
> The queue/stack map addresses elements[] with the product of a u32
> head/tail index and value_size, but the storage itself is allocated in
> 64-bit arithmetic. When max_entries * value_size exceeds U32_MAX, the
> product wraps and push/peek/pop operate on the wrong element, corrupting
> map data and leaking stale values to user space.
>
> The original bound check was removed by commit c85d69135a91 ("bpf: move
> memory size checks to bpf_map_charge_init()"), which migrated only the
> bytes-to-pages conversion and dropped the overflow guard, so oversized
> queue/stack maps can be created again.
>
> Restore the bound in queue_stack_map_alloc_check(): reject maps whose
> element storage would exceed U32_MAX bytes, keeping the u32 index
> multiplication overflow-free. Also reject max_entries =3D=3D U32_MAX, whi=
ch
> would make the u32 capacity counter qs->size (max_entries + 1) wrap to
> 0 and permanently break the map.
>
> Fixes: c85d69135a91 ("bpf: move memory size checks to bpf_map_charge_init=
()")
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---
>  kernel/bpf/queue_stack_maps.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.=
c
> index c1c9dee4dcdd..bb2453693b80 100644
> --- a/kernel/bpf/queue_stack_maps.c
> +++ b/kernel/bpf/queue_stack_maps.c
> @@ -59,6 +59,16 @@ static int queue_stack_map_alloc_check(union bpf_attr =
*attr)
>                  */
>                 return -E2BIG;
>
> +       /*
> +        * The u32 head/tail index is multiplied by value_size to address
> +        * elements[], and qs->size (max_entries + 1) is stored in a u32.
> +        * Bound the map size so neither the product nor the capacity
> +        * counter can overflow.
> +        */
> +       if ((u64)attr->max_entries * attr->value_size > U32_MAX ||
> +           attr->max_entries =3D=3D U32_MAX)
> +               return -E2BIG;

maybe just

if (attr->max_entries >=3D U32_MAX / attr->value_size)
    return -E2BIG;

This will reject any combination of max_entries and value_size (which
we already checked for zero, so we are fine with division here) that
would get us at U32_MAX size or larger. That automatically eliminates
max_entries =3D=3D U32_MAX as well.

pw-bot: cr

> +
>         return 0;
>  }
>
> --
> 2.54.0
>

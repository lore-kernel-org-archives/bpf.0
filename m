Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4CF2DA74C
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 04:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775102492; cv=pass; b=OLgHxipEpbahj2kG4bYlQHFuYYYkyKw3DjOayh4CLBAx1/GE4t0PWzdeWpqScMk9VU8xbvVtNxIGYKEVIv/cnNcSy3k3aGngSE9mhRn+TuSXfEmu96bLpENMNuw+D93FGpGPTFUCyK9uhCeG4YQErPw8iqRqGE2ddcO3slqpZec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775102492; c=relaxed/simple;
	bh=1LdlDt6jmLrY8FNpB2IuDTi4XlODfOTCL66SsUvxy7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=swTyZnt5c5RYlzCshyMYWuL0zuSPr/q3VyzFlY34l7LkM1DGbLsV6aHxVrYpF0p4T6W9mwRduxqx3dsWlyFY2ibHC3ictFbZ1CWX4ptMpof+czEZaX5cjAR6QVfL2yShMzzxxFlq7noiUwgOXNhRwBS7FZbjsEB6VCCF6mm1SWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EjTRUG2g; arc=pass smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EjTRUG2g"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cd71fb9f06so29863285a.2
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 21:01:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775102489; cv=none;
        d=google.com; s=arc-20240605;
        b=l2641poGdFt05YclAuZ2iJMBnSfmvkGXLNJhyv1LOlU96bdHrQ4s7zqAyGjX30xL3V
         d8JrsZs5YaivHZ4LIxAJfflnDD6dZ2Pk3knmcCXIrNJZ86jvrIEKKbx3PbpIAWpau5LR
         n/PgvjwOoSCzHLDMhI+UYO8dM7cQbdIpqPKHTUdZC0zUPKa+yWk/xwpN1YUZnkLEpXdJ
         Wxeb1zv9OJVGuHzvpbilB8bgq3BSpuilM/X1fPx2X56NoazYpurLnPMDqJhmjIf5aRE6
         mwpG/9eNeYQh08MYT5duahuP/+OOZ6f4uYI5MiAjhglNcMGhZHak+zzloUmNHw1r6Jir
         3Qhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ei3SX3G2s38D0KrFFaR3yQIVdKo46K0pf7MsWAZMuPY=;
        fh=2pSTROc/DR0A8i4at7uQ7qgM93pPbhd9k21nat16D0A=;
        b=antCCp3UoPtRCLE9R77td+MVoZ/xO/mUGfpogn6JPGaZHQt0veN7FkBFtN9/+sy4YK
         mNBtoifufSHksoK/xk0p7ZaDQBBsvpCdlDEGaccow0H5r6PHBDICnRwBNcudmEQpRVJo
         C1H4CeSE90VPrC/IeB3N+moeiu1mSVMAtpc9Q+4OTPhSFi2W3Q782o3h1Rk46I9TvCDt
         mlu8+J5a9VrRM9UsDfoRhg/Z6iuJ6yJu6WCr8teNkw6Zb0aJQSl0/O54KwzDBdTPN+g3
         nE8WluYJLahEBJlETemtzmxoYV4IAsNP05gckgphi0KLCIMaHLJhwZtR6ejhXCQbB0Oz
         8eSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775102489; x=1775707289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ei3SX3G2s38D0KrFFaR3yQIVdKo46K0pf7MsWAZMuPY=;
        b=EjTRUG2glylztXrEip2pEFDwmztsZ4gUic4aluaeDwlJH+fmgJih6KwFRpracCQeH5
         ScCRDIf02X5bCm/AaJzw/cpzZKXqzsSPcOT01YqDZJBTr0y13d+jT0WaZ6zME+YN/3IE
         uOV/HePk/QaWgk7XD9FLnyqzJqOJN7e3D6EgT3pi3+nlxiMCNrf2iesC1RfM2KnlgPFj
         VW+ejGg6EzgT0SMXpOJZbv5ImTaaVIeSMbjPS3gvtbAl8rI9hQKc3+TrqCg26vpig8ZG
         233LkxZHQtrRp56sW3sTIPOu4DmienaF02XxjzyeH5UF3P+MKwwkMwET6hGLw7PF4uLU
         e1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775102489; x=1775707289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ei3SX3G2s38D0KrFFaR3yQIVdKo46K0pf7MsWAZMuPY=;
        b=ZkeN7RuFrgkWwH5APp/4FMRUjIDUSKmuZzx6eVMGhSMy1ffJ0sCvEX2XDmLQ55HFkl
         VjpCb7esOlwr1HVhMC3xyGeBOd4m3hzSFnAkuZ/b088beTGJSkNPVTFLKm1E4zbk9zrp
         GBU/reI8NqS0Q4tYjr90B6W0mcN7DP7to/4CqcFa/u+/Nfh4L3aICKWV/1T1EUcXfrkG
         qmKxaTcV4ido1W5/AD4hG+3Mndmlg4ULg6S7f8USDo5BhywHOmGBU9C0a2cOlCazvpVn
         JsToLx2vq0qQxsR1nAFaIOXTx9EtrLGG8NOV25wQrdySag7FKz8Gk2ESo1J2b1nNssuI
         Nt2A==
X-Forwarded-Encrypted: i=1; AJvYcCWNz0EktFz/ukfazDE39o095lIMjhHEyufiAKUygXTMgzGC2/sjH5steEBMdj491XNB2B4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqKBiJcKWN4ebUokg8T2h77rETPOf5GPy/WaEY19CA/O+Hvf8L
	80/MoqblGI7zrK5oDpbJz8z2hf1msHjV8H7nYQ99Ez9ej4sSR4UwgFp0P1LP9MVdZ3IAi70VDKS
	RGOiY1NISe5Gmg17at3u3IbWyX/3yvO3vyq0lB9Th
X-Gm-Gg: ATEYQzzd0OS8HepynI8z9QvHMd1IJsPRbcntFhpRMZLoIzw+EqGyW376FLoGjjKFExf
	rgYrY73EcYqBpjIUjlBt+QQKyVDS4qEcj70TWuFDABZ4pDrjmFjhszK/NcS1YPYYZ6sGdXUb5a0
	y20g1q38n1HgNH0ql3NzUbpqsbitfOax2p/P/1CIA6F1GoYeNFWX1KHSEsxY6ufEMh5L3x7tQkC
	OhrLn4829yT+Brk3Q0EG20UYiPOo3Kt9fvZ4XVbtlxkQoKq/CpOBB7SK0Ctc80JXvfHcNaoF3/9
	taAjAZov
X-Received: by 2002:a05:622a:2b08:b0:50b:48a6:6ba4 with SMTP id
 d75a77b69052e-50d3bd3ac41mr85630311cf.48.1775102489074; Wed, 01 Apr 2026
 21:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402033138.388574-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260402033138.388574-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 Apr 2026 21:01:17 -0700
X-Gm-Features: AQROBzDO2EXTCqKgPEsclvEUttkZBXr41LCEacZtE-Rldds-MyHmszsQr-VIAjA
Message-ID: <CANn89iLdRZd-qO4tRpSGamHpggh=r5vM4xes5npYCnkwcNG89A@mail.gmail.com>
Subject: Re: [PATCH net v1] net: skb: fix cross-cache free of KFENCE-allocated
 skb head
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Antonius <antonius@bluedragonsec.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Michal Luczaj <mhal@rbox.co>, Mina Almasry <almasrymina@google.com>, 
	Eric Biggers <ebiggers@google.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Alexander Duyck <alexanderduyck@fb.com>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 8:32=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.dev=
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
> slab_build_skb() =E2=86=92 ksize() returns that exact value. After subtra=
cting
> skb_shared_info overhead, skb_end_offset ends up matching
> SKB_SMALL_HEAD_HEADROOM, causing skb_kfree_head() to incorrectly free
> the object to skb_small_head_cache instead of back to the original
> kmalloc cache, resulting in a slab cross-cache free:
>
>   kmem_cache_free(skbuff_small_head): Wrong slab cache. Expected
>   skbuff_small_head but got kmalloc-1k
>
> Fix this by adding an is_kfence_address() check in skb_kfree_head().
> When the head is a KFENCE object, we skip the kmem_cache_free() path
> and fall through to kfree(), which correctly handles KFENCE objects
> via kfence_free(). The check compiles away when CONFIG_KFENCE is
> disabled.
>
> Fixes: bf9f1baa279f ("net: add dedicated kmem_cache for typical/small skb=
->head")
> Reported-by: Antonius <antonius@bluedragonsec.com>
> Closes: https://lore.kernel.org/netdev/CAK8a0jxC5L5N7hq-DT2_NhUyjBxrPocoi=
DazzsBk4TGgT1r4-A@mail.gmail.com/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  net/core/skbuff.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 0e217041958a..87cecd40381b 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -91,6 +91,7 @@
>  #include <linux/user_namespace.h>
>  #include <linux/indirect_call_wrapper.h>
>  #include <linux/textsearch.h>
> +#include <linux/kfence.h>
>
>  #include "dev.h"
>  #include "devmem.h"
> @@ -1083,7 +1084,8 @@ static int skb_pp_frag_ref(struct sk_buff *skb)
>
>  static void skb_kfree_head(void *head, unsigned int end_offset)
>  {
> -       if (end_offset =3D=3D SKB_SMALL_HEAD_HEADROOM)
> +       if (end_offset =3D=3D SKB_SMALL_HEAD_HEADROOM &&
> +           !is_kfence_address(head))
>                 kmem_cache_free(net_hotdata.skb_small_head_cache, head);
>         else
>                 kfree(head);

Oh well, time to simply call kfree(head) ?

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 3d6978dd0aa83f63984b994359d0c914c6427a00..6b35aed23b8936409f6b0d4ee8d=
378f726c569c6
100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1072,10 +1072,7 @@ static int skb_pp_frag_ref(struct sk_buff *skb)

 static void skb_kfree_head(void *head, unsigned int end_offset)
 {
-       if (end_offset =3D=3D SKB_SMALL_HEAD_HEADROOM)
-               kmem_cache_free(net_hotdata.skb_small_head_cache, head);
-       else
-               kfree(head);
+       kfree(head);
 }

 static void skb_free_head(struct sk_buff *skb)

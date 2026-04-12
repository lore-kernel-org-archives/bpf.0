Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8B9186284
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 23:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776035638; cv=pass; b=otdASnnv/cmMhJq1RH8+huPjxqrJjIQdPza99wijhSBo/ISSe2motdqjIUrCfEJRs002oM6dXMFms3gK92WDuxlHqy9AzN1sZFs7W4e2NpDlfTPYl6oq885pSUNmQHda9qp4LraBUqEb3j+ME5xzl3IBIcrWbcbe+M05sw2szK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776035638; c=relaxed/simple;
	bh=OvyiZMLoxX3BPJUUEyg9JbjgHozYzZqa9sE6BCOrHVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWsNU0v15PjP41cpi00xTkcwmzSBj2x56MUfp1ZPFQZg+w5PPF/Tj0C0+FGK9Jep9UVynXfWbAZ+cylEU82MWQUD+UTW7GAfMNs6HHFmPCq034yBlyiZ6qYqqmFhoElKz+zrHCJVzAvE6sk+DgKOchZ+6YMDx56feihGk/+GB+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKnD43o0; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKnD43o0"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43cf906b007so2321662f8f.0
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 16:13:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776035635; cv=none;
        d=google.com; s=arc-20240605;
        b=VsJcslHzo1YvKGYhn1v1WCqwNY7OJudxHJC4CdQxDhG5sKUAQ1xhvvGCp0KZXJE6lI
         8TbXGq9KsO6idRR2EhssluEJ1gA7B9aB9F7JjY07BwZWKHvT/+HthT3kmud718V462ZI
         KwtNvsmY9/EYf7LPOG2DqTwBZ795fI0tcoFlRfM9io1iEwzLrgP56+HgNV0iNAJt73dA
         CBvHSndDXcCm2MO30BMZjeQ7gFqJxLg1yjCPrLJrTNGr623zRLN3V2NccGvu+Jbx4cLO
         nI89cf8ozaOpqipwsmBMPIi9fdHGdQb7cLLwFEqbqrksK8KqWspZ1sVJfQrd9AWYfITE
         CVlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DSjHYoAQF0MsRrTTTuwzpwQvdpllUnjwd/m6mYv3TIk=;
        fh=AoyNRaktsZ7bW/hTwiP8Dm5frmwh/+vEg7lx+EPGuMM=;
        b=Wb9GT/DaBOV9PWmRg6c5eshvja+ZT65hc7BG59Hy2B6YJr0/2O3OKloSWVPtUUj+Hl
         oOWzCstO5Ixd4NWRKpS1fP2RD8uVOrCS1tcliR3/HUlh7kw+L8BMU0WlAMcyaJ9OZXzA
         dcpHaUvHp9gsUAeEYXdkedvtI5m7MPzoQp+X8U6vFxdVFl5hApuu/g/gYoUPS2J7X84P
         hQdxvQNLI4x37P2xsRDHx5ybss61/e3X0kG5zw1yqoArg3Tun/GkIxZw1IuXAi6MLoch
         3j0q4Bblo7VoQQsw4GRvuUwoU3spaRDC6dKZsRJhGQmyUoYAFg7zKQdMsjfQ2hHeqzta
         NOCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776035635; x=1776640435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSjHYoAQF0MsRrTTTuwzpwQvdpllUnjwd/m6mYv3TIk=;
        b=EKnD43o0YLfh7bJwX0erDQDIQqIkH2nqfQwug2uf3wj5BUe+rH+F3HuqqF9SU6cPh4
         5JTkWszm/ZLNP/y0f2bl2TJuvIKZiRzAHf/eVw9xBkcjiiwCeKHYLBuOv10szvMN9BDo
         mFyB+kiip8JwP+ka1AbebuzqlonRgWKP9M55VIjNUXxklgyzEiQEBM7Aj2gtqeJvXWT5
         FD/du1POvsyXUgtC3//wsdh4QXDKObNq3cV4qbiJlhrPyxKzfSB+UG2cc5QK/Ywwj2HN
         U/B7XYd0mpBebpRroO5cafkgg2r6k8LfbmeMhMvK80vNH/9zbhQ6BMgYyLJS37bL9vuU
         WEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776035635; x=1776640435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DSjHYoAQF0MsRrTTTuwzpwQvdpllUnjwd/m6mYv3TIk=;
        b=KFB/8in+pk717VDzhb9pft47yFk75nLhVRUiMTw2p9S0L9Wt6vpDqqiyJijCP977hM
         1gdhLedmmR+ZPUY8QKqgztIYcNXtnhctrp/K+RHqHADcUBvRgCTu88NfAg0/EUVvkfOe
         X0vr+s0VL0dVq0IA/ja4Z0P2tQfBa+wqlzu4cKiiyyCq3ro4QPkNcp43zxihuMw9JStM
         UnQonc8s+sIAcUoQ5EU66GYCC4Hl+HDmPaP22Z2apcM4tAta7sN2FmFurfJicyYpGFkE
         Fq/n3O0qktDkMQfBVkNeC2yo++jkX+wuMx8vF8egGgIwhwFm3OyCaWpyzIv5afDqr4Nn
         LA9A==
X-Gm-Message-State: AOJu0YzG/s9srr1nCxF0R2ii9aQWkJ3381PdzvqNN+iZZ318D8BeEIwV
	Zq32DnyNKqREdxlEDyUhDgdZN6TQpcJjH0LWl1qQeBuuB4QoIzzMcsiCNwYasDefECERqCvmRxt
	ax1LFRGxCsWVgaM8wpdNMZFqMqoaz85o=
X-Gm-Gg: AeBDieuo3u+lwtp6gAFf0rHLENE3wvxd0V/KAC5NzcjTo1IRTHZon1BpVoKDW+qsvPi
	dz36aB8VJIhiwp0GRYG2mUFr+H7KgrRFlPnPCjcKT3l8YfrphP7cJXl4o6Z2r8caMANnJupRkLD
	LXb1CgmNwwuAEv/7Ipc8Qh69I+4iL8mFs4CLgElkHJEY8KMwEvDpSS5sIJzDRm6GGxCovMX4ZSj
	Wt8NkX/HEBQyRtTjD/xhhz4fuILbNWlnRvb+tAi1gk9qK3wVXI/ZKPuEoBXegXsGDJ4v2ekm3vQ
	U+EnovsQixKKPhOfe/DLE6zwDt6xTDgFZRGqEh/ksiv68l/SodmxufOYNk5cE5n0nB87yRC+i7Z
	GApt6off1a6V4dZuC7shoAIhUJw==
X-Received: by 2002:a05:6000:24c2:b0:43d:73de:abd1 with SMTP id
 ffacd0b85a97d-43d73dead06mr4443308f8f.51.1776035635514; Sun, 12 Apr 2026
 16:13:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com> <20260408-rhash-v2-4-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-4-3b3675da1f6e@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 12 Apr 2026 16:13:44 -0700
X-Gm-Features: AQROBzC1ik6rp9TViTaBBFbQXSnVaO4bar6kg13iU6amrtwquEn0qIWz5v96usY
Message-ID: <CAADnVQJuqv+ZkgaajB42r-PNj_zFWzvCakOs-jQvzODz5M=6gg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 04/18] rhashtable: Add rhashtable_walk_enter_from()
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 8:10=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> +
> +       /* Test 2: walk_enter_from with non-existent key starts from buck=
et */
> +       {
> +               struct test_obj_val key =3D { .id =3D 99 };
> +
> +               scoped_guard(rcu) {
> +                       rhashtable_walk_enter_from(&ht, &iter, &key,
> +                                                  test_rht_params);
> +                       rhashtable_walk_start(&iter);
> +               }
> +
> +               obj =3D rhashtable_walk_next(&iter);
> +               while (IS_ERR(obj) && PTR_ERR(obj) =3D=3D -EAGAIN)
> +                       obj =3D rhashtable_walk_next(&iter);
> +
> +               /* Should still return some element (iteration from bucke=
t start) */
> +               rhashtable_walk_stop(&iter);
> +               rhashtable_walk_exit(&iter);
> +       }
> +
> +       /* Test 3: verify walk_enter_from + walk_next can iterate remaini=
ng elements */
> +       {
> +               struct test_obj_val key =3D { .id =3D 0 };
> +               int count =3D 0;

Please de-claude this.
I couldn't force claude to avoid using these pointless indents.
Either figure out how to do it or remove it manually.

Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4928846DFE3
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 10:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785838461; cv=none; b=a95zFAbYrkXu64r2PFSf2MU0jMYQd6H61NY8lrFFid8DFAbGwLnLgRRYJSeEY1fh5Iz9AxXWyJwURNTi90C7s6ZcNAAKt8yvTUIgHBZA06mAdqGWIJeN9TfM3+939fu7Y/CgFhpqbnsMGG6XgKsy24fPgTwG3Ctiv9DLHPua2PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785838461; c=relaxed/simple;
	bh=KpZBFyVOZN6T3WZQDyMUDJB9FDOnzr878tykr+VvuoI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JnxZ64Jtjx23govbo9jvAOEWZiqK5R8U1guYUsj5wqq7kufiWdtKZ7/w2sqPn4QAvvEn9H97MuZCUjDnPSeQ57t6Wm3qbYG4NV9xzlxBmOSqPp8v1V2cze1C1qZogJ7TWvLgv5RcyRgkpLcNgigOuYV4CID6rfE2IVPsb9e5kgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=OGKfKHHE; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="OGKfKHHE"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a10a1a4b11so2913555a12.2
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 03:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1785838457; x=1786443257; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KpZBFyVOZN6T3WZQDyMUDJB9FDOnzr878tykr+VvuoI=;
        b=OGKfKHHEdDEA5FO3z+wPhfjCAedsWiy5Wxs2Mx1qJwJJX2Pkd4G2zkyuBk3/wyRjT0
         D9qkdWUjgiD3t9y8f+V8+g1XLbFMZMEQ1VjpEZ4u9y+aGOtndcVzF5ggMPkb8QsoLb3x
         DRZKvntEFoSeNowKsDzphPp7fDnRhV6KdFqJFbysaRamlylqxc+QJqrmfriio0zqD/Jd
         mGl8y5AFMyXNSzqD6e9Kw1wmgvv24ynoc1YrLuWTiglcxDXxhE0SDcuPOQuwC1FdtWMl
         yjLHOWUyhHA/UGTTSoecQutyMEfIrS+birxZexLPxNnJrxdBF5y3mLd62yPaVv3nuf1h
         e8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785838457; x=1786443257;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KpZBFyVOZN6T3WZQDyMUDJB9FDOnzr878tykr+VvuoI=;
        b=f4xZpeCzsQvxJYPVFImD8M6bWQtjljXNPWj4uOxW8pYGpCjls6KdX/weTRKW+FuoDD
         Smqd1PksqxfwG6gVvqPKcTFooz23PsFgauDz7giZa5samNWPOuImbb9i6quUUUrYAzo0
         FBFjMy7RVjeojm2f0pU1lyROtglmdjvwSbJH4ERrgwPHDsll76YxUCnpZBSfhe3ddpeb
         lpVm5rsucKJyvas42VKEgWFVgG78IHlESntC/C3hDWmK+FDKOxf5ueDCNV5/W/IZj/A+
         VtnBlRM1e4lAxPvtJ/HIJuSHeK6FEjQMVP0VoQSRdbK1vrsc7viZwsZCVjfSSR7+yb6l
         PN/g==
X-Forwarded-Encrypted: i=1; AHgh+Rq6pYoiFF0RjNofp99pqvbNHFN8t2rHC4+T49MlEMY8CPTF3JkGjfmieSU2EIN2bb5qKlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVMX1zp0vxonvT62fBAvrrOcsUUglK2V9W5bOW7Mks4vlpSFTZ
	+5Pc6FQngDuaodYXRCI3BqLmftsVBrffgSanU93f9XWHWNAhwRptVHSPPWIxezO8km4=
X-Gm-Gg: AR+sD13qmLDiBk6BThMznWQoRE4ceY9FjzlzbKR7LkE3X19PiUHvMBjjCcjus6pde0t
	L6Gz4E45varr384S5rzfZksBCSc+B1dQThb10kl9Vs7BRI/D3LHTFBrT10Sxe85okvA0+JJ9aAB
	g3trVuYaCT1/ZIxA9xZCJG4cJZfkxIYvySGt++eWUqt4CxSQyWQzjd98VF9bl7I3UHFz1RkiplQ
	Wp354tlVbc39/KpY/kXcyj1VzkSehkqISUBUfsG+gB6dbffcSoiujrg1z2qRoNVo/nzD4xvrXda
	yizPKazwcz3XCmKcNVxrY/gbZnjEduZm6wzRFAR9pIJ//s+IVmL+ekIZ6ZYCrwO7CHmR5xBoVrp
	vPm32y4e9ubx21Wel+G9B7t8awRAKL4QTHEF1tlb5x0ylBrlVM6rKqkV3KHy1lfTVCOzqIk3ER2
	OOn6i/7FsMxIRk2LtFwpVFYDysNlJhEVLeSiSkUEwr/dB3xaIjts+MHyMsB1USTSk=
X-Received: by 2002:a17:906:6a18:b0:c20:1c9d:8d4b with SMTP id a640c23a62f3a-c201c9d94e0mr545949266b.2.1785838456557;
        Tue, 04 Aug 2026 03:14:16 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd4534fc4sm644439366b.51.2026.08.04.03.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 03:14:16 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Eduard
 Zingerman <eddyz87@gmail.com>,  Kumar Kartikeya Dwivedi
 <memxor@gmail.com>,  Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  Jiri Olsa
 <jolsa@kernel.org>,  Emil Tsalapatis <emil@etsalapatis.com>,  John
 Fastabend <john.fastabend@gmail.com>,  Stanislav Fomichev
 <sdf@fomichev.me>,  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Kuniyuki Iwashima
 <kuniyu@google.com>,  Willem de Bruijn <willemb@google.com>,  Jiayuan Chen
 <jiayuan.chen@linux.dev>,  Joe Stringer <joe@wand.net.nz>,
  bpf@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH bpf v2 2/2] bpf: Unconditionally take socket references
 in lookup helpers
In-Reply-To: <20260803-sockmap-lookup-tcp-leak-v2-2-306e025bfe66@rbox.co>
	(Michal Luczaj's message of "Mon, 03 Aug 2026 11:00:43 +0200")
References: <20260803-sockmap-lookup-tcp-leak-v2-0-306e025bfe66@rbox.co>
	<20260803-sockmap-lookup-tcp-leak-v2-2-306e025bfe66@rbox.co>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Tue, 04 Aug 2026 12:14:14 +0200
Message-ID: <875x1qyyyx.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 03, 2026 at 11:00 AM +02, Michal Luczaj wrote:
> Lookup helpers gate whether to acquire a socket reference on
> sk_is_refcounted(), a check re-evaluated at release. An established socket
> refcounted at acquire time can gain SOCK_RCU_FREE via
> connect(AF_UNSPEC)+listen() before release runs; the release-side re-check
> then reads sk_is_refcounted() == false and skips the put. The reference
> leaks.
>
> Make acquire and release unconditional and symmetric: always take a
> reference, always put it. Adapt sk_select_reuseport().
>
> Fixes: 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
> Fixes: 64d85290d79c ("bpf: Allow bpf_map_lookup_elem for SOCKMAP and SOCKHASH")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/bpf/20260701235552.2B0AA1F00A3F@smtp.kernel.org/
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
> TC bpf_sk_assign() has the same issue; it takes a reference only when
> sk_is_refcounted() is true at assign time, but sock_pfree() (the skb
> destructor it installs) re-checks sk_is_refcounted() independently at
> release time. The same connect(AF_UNSPEC)+listen() transition leaks the
> socket here too. I'd welcome suggestions on the right way to handle this.

Can we make this scenario unsupported?

listen() could return EBUSY if called on a socket that is refcounted.

WDYT?

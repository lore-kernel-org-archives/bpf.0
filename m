Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795475972;
	b=RIJfhZMKxqQdSCkQio9eQUpJJk+DOcMA2R8jzV/VVr1Qt+2ZSEXATGD7/8HOr72DALUf
	 rPuFC2a+MJRPmrt2NGCEcYSkA2ONoSThAmKzanZdCovTsVNlHYhEfeVZeAdKbSj1cNR8r
	 tQaIzkFt86Wa1MmgSpPkxriDz5vcitJPw0e4dtjtZXgbtySsmZOuULhGK129Hnpvh+k3F
	 H7LRHDdabG57g+SdS1kIAmP3oXdyf9ovCxq8umYfe31yVOjy/XNoVlwP8riJz3WWBpxuu
	 Y64Mwf7ZOgSSTyC+kHJ/kRcRH030rDOooDGT7lX3Ra5m4TaZq7WLLVXtnSfOXb55qAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795475972;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cLhWqv/VagBjB5zuhR0ieKg5bnQX3hK7LoyWZzsgt5I=;
	b=B0JsOQmulilLgkIenawUwd4iUjz8KUC70lF4lRPxGkSWGLrdsjRArBj0sQ0EXjaewL84
	 OwQ+mwPshyU8RP78t15nnudyvoflchWSd5NejA7/RQiodmw7BO/k0coxi1V72I/zLn+3A
	 tENOuzT48b70Iq7orp8N6ceh1VuXUWtbBRwY74Q6/7FPQxaEca/vN9hrS8/pwEb14lk97
	 m+k5NtLv0G5DzQ3L3jhsvRvQksF36hCIdOnWlfjyG89xIKOm+271h+EP9BLSB296xiP9r
	 GFEbU42mAkSAaXqBc8TCqHzhyaZC/cU1Q12OzkSwj5e8aIi1JUlTz+8cibyWLXyib4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=YhXtktK3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC0E606A321
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 23:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DC0E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=YhXtktK3
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8b612fd74e1so1261368b3a.0
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 15:19:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795475971; cv=none;
        d=google.com; s=arc-20260327;
        b=CYXRvCoceZldHLghYh+wydWTlfDX5Uac4vZOgqy7snjm04kwTDWScAMoP77BkP1UG3
         UAGTGSyQ81ugniQSqQQ3uO6vdT2QYKz6hQMi05TAlPC+VaVrfQMXi9dN4rhzpjPrw0kH
         lHI2b1ankqyUGUkDpuppQNxvqNCjt9D6IQIKGQX4Y/kCycPdkC5qK7dFxoMBfpRj51YM
         PXLtPHolbm0p2/rN3uDdncnemSM7E5yTCupn5CQN9qClYUbcbHAWR/YgbY6ZBrMXals5
         gvlyQL1gayMhb3QmhdD/4OtGT1ESHgTWA6l0NxDhfJ94HTZGo9y0kiGDjQVZpJIqlJIG
         bSBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cLhWqv/VagBjB5zuhR0ieKg5bnQX3hK7LoyWZzsgt5I=;
        fh=rxk01fBbsWn9yoBq5alYdejHhgWNmXU9g1c27JSt1fo=;
        b=l3NgrlXoz8dXANl45dcJqUiObngw6s2zOl+nAZl90u596K7AtvA9TenxORJDDKX2hE
         kJVMoenp1QV/ytkjJgHXo7d6mvuIOO8XHhAyLtOQSECEdlHLvXGg5ji8Ifc+wP5bu0aZ
         /tVLmmT04Eib+2dhEPej/X8VdbK/vH9FaIFkn1GSwygSujOumpD/uwI6uzRBq+hvgDC5
         mrxkg1L4Q4KcpqIMZh7fre7jph+fXi5WO/9xdSKN+pJD5La/Ooy1boRTPRXSIFEFV11U
         +P1mPOPoUK7+GeIvaq3L0wB7qkukyMt9VOBGexkvoaucEQbPpqZt++0F4D5o3nWdH7V3
         ESeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1795475971; x=1796080771; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cLhWqv/VagBjB5zuhR0ieKg5bnQX3hK7LoyWZzsgt5I=;
        b=YhXtktK3TaxHoEAlQRblBl5NwaiIJzMRG08xeTEasVOlhXF9VzuYseXJhgLWW2EHGt
         JukoaxQupFfWcUqLaF5oxSvwZynvmpg5wICI4n+s01aIPBDvOkU0KbknfNARAEWMBVN7
         OKYXJaegBPz6ilzvzpEe6ACY1YEwIQVhkcYg5inow+PiZfU/wA6/6QKhD3ePBVWJhPrL
         ERwCuv/jfq+xLZhDIsBTa0sAaLtawlsX3BJ5AfDooQoz4b2oyft7coosdea7B7X0T8EA
         b4VjDkmEl/GIJJrySearV1rDJhdFqmMygt7PmizPlzGdZTWHEWeZjplLfY0n2sMGlpjv
         8/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795475971; x=1796080771;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cLhWqv/VagBjB5zuhR0ieKg5bnQX3hK7LoyWZzsgt5I=;
        b=CJE4Uu3/yJAHza5va9SIoTCet0XAtWjYujo/Q9CeP4ZT1K/icQ1WBVX+2wxVgwI8O/
         07kcfCF24n4plSIjbBchdaaBa1rU4w54OBAj2A3njiNLHxP4yt3HvqY/5h0EZs54jrDJ
         V1PVTWxNmctx7a+mCPK5vb1eE17X84CuSALJKanXUOOSL/oN4HlSyrYtuuTslhq7C1KW
         Q1TTFmySOozORu9eCawRLy5/4sUjdM4ByTSCVnrt1RCvvx8wp3uQyR3xGRQl18vhkSlG
         IEEPRnY5SC1JqYBvWme46CGFbDEKVpmMF2w80mlKOtgPz4DPpY4Ha9Y6HvI8w9QahC1Z
         zcYw==
X-Forwarded-Encrypted: i=1; AL+hErFNOTkwGu+tRtx2GYX/VACjVReq6NpgxXSARSRt2k9Y7sy7Y5yxnWI4Uua2dDnhD7tHjkM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8RzIuICAdjJL4E9CCYzqgOR+yhkM27ikoq6wWChzK2x6sZ1GEz
	UHE0d6sItNyU+i9SniKAFz2D/3Q2aWTs9mbyzk+FQQN6lCYITwBFRYrVHJHpsExsjA5crkLP/df
	9wC0NokJqnIufBeRDRRzopboWEiQQJRFQulI707x/
X-Gm-Gg: AZFdTZe700R8H7cQGGuOeQa/BTHVpCjG7ihK5oRYv2azDRt27REFItJULnSN4LQfYI6
	v/7dpa9w3hyqo8o378dYj3BYaKz9CNtXxmUm3tYfnu2tYhXxWQAZufFrva/OafPGQPpZrqLLWBr
	RMecN9mmuAWT3yYT0mOYSkKnO7YyPOd0PWMiX5Bdt9bUtuLfqky24w9/WfLAar62Crf6tdCUvBc
	bQ2+rjQcQH1FPsiOeMD3Xr9Kw7q5+Y6CA4TLw1Lb8MKYJVCx6shSSV5ABXTUnjebtLvchCzQb2y
	hvaboIaOueccceefXaOIFeD+kButHHoWQggGKhdop/L1i+XRi9L/oJymil6DxtGrccdIyGvDAS4
	jqIYIFcC2zsE9bXk7VFNsRDERqW/E2oFO4i1ifRrLqxSHmusIL4fkZibbL/ic0KyCr67Pzg==
X-Received: by 2002:a05:6a21:7111:b0:3fa:f23f:a1ef with SMTP id
 adf61e73a8af0-4014da5d430mr11922129637.61.1795475971432; Mon, 23 Nov 2026
 15:19:31 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-work-security-namespace_free-v2-0-65591dbba7b3@kernel.org>
 <20261029-work-security-namespace_free-v2-4-65591dbba7b3@kernel.org>
In-Reply-To: <20261029-work-security-namespace_free-v2-4-65591dbba7b3@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Nov 2026 18:19:16 -0500
X-Gm-Features: Aa3M54pQLfC4vU3-6-r9j0PdP3_OAJ4uOdt5cmk3KHNndD-uhH08FyqH6wqPWRk
Message-ID: <CAHC9VhSq+VXrs-M0ezGGW66d=-w8rjqCggpnS=ORiRZwMRPdmw@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] ns: allocate the namespace id before the
 namespace_init hook
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, netdev@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 12:41=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> Currently the namespace id is allocated only after __ns_common_init()
> has called the namespace_init LSM hook. Most namespace types allocate it
> in ns_tree_add() right before the namespace is added to the namespace
> trees. So the namespace_init hook always sees an id of zero.
>
> The namespace id is the only identifier of a namespace that is never
> recycled. A bpf LSM wants to use it to track a namespace from
> namespace_init until namespace_free, e.g., by using it as the key into a
> map that associates data with the namespace. The inode number doesn't
> work for that as it is quickly recycled.
>
> So allocate the id in __ns_common_init() before calling the
> namespace_init hook. Every namespace then has its id by the time it is
> added to the namespace trees. The initial namespaces still get their
> fixed ids, either statically from NS_COMMON_INIT() or for init_net from
> ns_common_init(). So ns_tree_add() doesn't need to allocate an id
> anymore. Ids are still handed out in creation order so mnt_ns_loop()
> keeps working. Mount and ipc namespaces already allocated their id right
> after ns_common_init() anyway.
>
> If creating the namespace fails after the id has been allocated the id
> is simply never used.
>
> Landlock logs the namespace id when it denies the use of a namespace.
> For a denied namespace creation that used to be zero. Now it's the id
> that was allocated for the new namespace. That namespace never becomes
> visible to userspace but it's the same id that other LSMs see in
> namespace_init. Update the Landlock documentation and selftests
> accordingly. The selftests can't know the id of a namespace whose
> creation was denied so they only check that it isn't zero.
>
> While at it, drop ns_tree_gen_id() as it has no users left.
>
> Reproducer, 100 user and uts namespaces:
>
>   bpftrace -e 'fentry:bpf_lsm_namespace_init {
>       @[args.ns->ns_id ? "set" : "zero"] =3D count(); }' &
>   for i in $(seq 100); do unshare -Uu true; done
>
>   before: @[zero]: 200
>   after:  @[set]: 200
>
> Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> Cc: <stable@kernel.org> # mainline only
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  Documentation/admin-guide/LSM/landlock.rst |  5 +++--
>  Documentation/trace/events-landlock.rst    |  5 +++--
>  fs/namespace.c                             |  2 --
>  include/linux/ns_common.h                  | 16 +++++++++-------
>  include/linux/nstree.h                     | 18 +++---------------
>  include/trace/events/landlock.h            |  3 ++-
>  ipc/namespace.c                            |  1 -
>  kernel/nscommon.c                          |  7 +++++--
>  net/core/net_namespace.c                   |  2 +-
>  security/landlock/ns.c                     |  3 ++-
>  tools/testing/selftests/landlock/ns_test.c |  7 +++++--
>  11 files changed, 33 insertions(+), 36 deletions(-)

See my comment in patch 6/7 as it impacts this patch.

Reviewed-by: Paul Moore <paul@paul-moore.com>


--
paul-moore.com

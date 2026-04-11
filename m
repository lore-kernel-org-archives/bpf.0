Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CBE284B37
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 04:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775882354; cv=pass; b=RZBFavi7/0dR9MA9fXp0CFVpdjylQaYkYV/mEjyBHOz/y1GTH1WGEgbDQUddhksJNSuGxMqsD0jq8GHUu2WopvgrWEG3lkchedWDcNLWBOVqwL1+BIK3N5jYT2HYX4r8lyDZEuRWZhTnhTx++1BAKsEMUi+7qpIyJqQwYX6KsKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775882354; c=relaxed/simple;
	bh=DqAVYzg35YxGWL9WCukXnG5qvJlP1oQzSfziIeAJ21g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EyU566xPHbK/NJYIsog8jY9V8BdGmCuij74gWAT/cGDUhhSphBT90gtn0Nxq43H2B2CB26DySrRr/xQ5Ch1JX2DV3gaJ4SEScHpl6qsw5VxQroL4VQh/MxlWpIr9BetWqmLpx0q4wqZ2vyyFQ0fTHEnf+HLVVGRRb6kz42ZcMPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eei+qXqV; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eei+qXqV"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488971db0fdso26567755e9.0
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 21:39:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775882352; cv=none;
        d=google.com; s=arc-20240605;
        b=Ok6LF/j0+UjSlpPOw6ttaD55oRhNdXvgKEHp/M2fTTG7ZScUic72/WNgtGL3mVWTjX
         /kZosxj+peG2Cr1OvbKQHazbeGBGpI2T9Enkxm5YfJE5DFp3PY1iQUblJNM2lY6TxlPI
         OYmp+Eo4/DBVXzX2cDN+sEp7t1w7XnK2ErtS2MyQz8D8o+8SyNviGJBwsidgcNtLZiml
         9rQz3ov6aNXXtQDltxTjL2K/tkN95mFNkSfxq7on0X5gAAzedF1qLGjd7KYhFPVKuN2c
         yvvgo6OgCVmbvQCskNvEFid6uDUn7S3wNE0wMAmymjq7bojYO3yEU3Aodtf7gI/bCtxI
         Eo0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DqAVYzg35YxGWL9WCukXnG5qvJlP1oQzSfziIeAJ21g=;
        fh=MjD+458AmqIvSCM5Mo5LqINqNHKOkN1RnhQxQhU/ZaA=;
        b=amtgkIXdaJOvTxInXqGSptjlwdHY9t0OrYMP7iUM1RLFkNErxHYP+p6pLwf/P4gH7h
         ehfb1qx7L2qBISbgBajWz8RzHgLcK5++cTJWwg/ZSIGW2n/NbZI7MQbH0HF3tNKe0VxT
         /JhuXIsSfEjRykI5R0IEZSHfZHsdxbHmuwF6YU985/wZvBAfm3uyxUZcGif+TJ+b6B6Z
         1DZxe8E5qt2IcGH/f+fyuDHCpWqIPB3hRXaN6ZPqDAXXGBF4S2fjrxj16gAF71EtxdAq
         rNONo36q9Xdw0k1v79pVLFY5CwHt9Rsuq9HVa3t6DGvRXI63BEZXe9fqg3vRb3kk8KgI
         1awQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775882352; x=1776487152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqAVYzg35YxGWL9WCukXnG5qvJlP1oQzSfziIeAJ21g=;
        b=Eei+qXqVbAfanSPq7bteu0R81lv1SPM9rJPFXo90/+dJizkT8xlmZpC0EpLT6Fslmm
         1n3eg08AlLIy4dtDQ3atH6scqPN3S0VnGO5GITf5hOwkZARDmNtbeKFctnJT0R4XzFIm
         t8zwhA1EQwZ+y5uFyH84mxPbM8+ZU6dtfh/bs0eX7YB3BYkIcRfeouQWNGJukX8Ngyuu
         OFwhOCoZiFfEWUgZPL9nn9i9vkR7aZt6a0ShinyxELZmyWDn40Pe/RdgaOknpyAUaqod
         hdycfT4oxZs1alq8BPI63k6wupWy2j2BVlEBKJ4zch0k8v6Eti/Vozqik3EDPU3ZpEMr
         +Yng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775882352; x=1776487152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DqAVYzg35YxGWL9WCukXnG5qvJlP1oQzSfziIeAJ21g=;
        b=izxkrpSBzPHhHVzR/UODF658UtN4zlM8socTGHYDQnenH2H5wVgXfIABJNu4RItYMH
         ROc39kSbzhMZJd0oTzVLTu2htF1+W7Zk7cK1uUAuIn5ARF/XSwdpYEr4c1dJB/zr9QNm
         h/lStB4QFfx3k7zdJWa0t0m+/QtD1DmSUhpifilYUT6lnugjR8ELE7Dc7IKNnMS8tX+t
         DQcZ+JZ0wJFe/ln9zaOPy+J7ABvb8ya8kYokbj1C16DDl2d2T5F/OrfRkSZqCXxDZ8KE
         tPzfwoFWDhTBpmfidN951JXMiCVU2POeIVvorEjtiAz7o8AcZ4CY8Hn6Q/OaF2DRpCZq
         Zdag==
X-Forwarded-Encrypted: i=1; AJvYcCWlughx+x5llfjYoc+hMSlL5pm60VcbS+5BWGAlmHI8aTlAECmLLfGQ7ExAbx9qa/M2+ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqziBrMEFojvhyIUW9vF0iqS6u1KDEMdlYnPWRarBj63KIliFu
	X4Y65v6fo05TFgzCqvXnCLGnK63heIAKxE3yiM0cm3u4IG2vjppkJTH10iZI+AnhyvGuHLFXSv6
	qcMbVwXTsqdX+KFLghXzDfCet4Q4jML8=
X-Gm-Gg: AeBDiesKBN7ICEYCjOUsOX/S2OMd8ViPZbKdrUvGzq7ZhRy5/eam4BkO37duu5649ad
	+71zZ+gp7Ph3zA5W4homKq5AMdx9HukQgOjCUnXeqaS2ZAhBnsFTYdIN0Wt58OpIyVwR50XeUiB
	HW8Yuim1qP72xB3LzdFOPqa8yRA6FsfDCuPRNUS9Qn3nnMVXrvX0/DjmGPUlUlvwzTv81oqpiXh
	HJTgEgQh2TdLpMZwwmgTSOskftIEpLh6Bs82WLL/oIEM7maIMeOh9FkgSuku1NtcxiyLTSbdQEK
	DChsyJHS5Q9eF6h4dFcRpWxe1DD1w3v5b0lEAGxadlMniuJ3vBI6r04sm2wO02FQZF7XwpURJEu
	e67pnfgUu/TzB/+l2c60bxHPcGw==
X-Received: by 2002:a05:600c:5299:b0:487:1fb4:7e1 with SMTP id
 5b1f17b1804b1-488d6875f3emr70333425e9.22.1775882351810; Fri, 10 Apr 2026
 21:39:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411015419.114016-3-ameryhung@gmail.com> <efdb35c2d8151489fb031ad63ce8bd6000b8bbaa2bf5a523c927907399c93ab0@mail.kernel.org>
In-Reply-To: <efdb35c2d8151489fb031ad63ce8bd6000b8bbaa2bf5a523c927907399c93ab0@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 10 Apr 2026 21:39:00 -0700
X-Gm-Features: AQROBzCikxtCHtI5qqdK0C85R-3ghBvHgVMXauRVCn-weANy68D8fquPbHVRm5U
Message-ID: <CAADnVQKeFF--bgnZZSU12UY0muuwYA=7EdzLyOi837oZs+bXTA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Use kmalloc_nolock() universally in
 local storage
To: bot+bpf-ci@kernel.org
Cc: Amery Hung <ameryhung@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>, 
	Alexei Starovoitov <ast@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 7:36=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
>
> This allows value sizes up to ~65KB. Before this patch, socket and
> inode storage used bpf_map_kzalloc() (backed by regular kmalloc)
> which could handle those large sizes. After this patch, any
> elem_size above KMALLOC_MAX_CACHE_SIZE will silently fail: the map
> creation succeeds via bpf_local_storage_map_alloc_check() but every
> element allocation returns NULL.
>
> Should BPF_LOCAL_STORAGE_MAX_VALUE_SIZE be updated to use
> KMALLOC_MAX_CACHE_SIZE instead of KMALLOC_MAX_SIZE now that all
> storage types go through kmalloc_nolock()?
>
> Slava Imameev raised the same concern for task storage in
> https://lore.kernel.org/bpf/20260410014341.47043-1-slava.imameev@crowdstr=
ike.com/

Right. Let's update it, but I don't think it's a regression.
On a loaded system kmalloc_large() rarely succeeds for order 2+.
That's why kmalloc_nolock() doesn't attempt to bridge that gap.
One or two contiguous physical pages is the best one can expect.
In early bpf days we picked KMALLOC_MAX_SIZE assuming that
it's a realistic max for kmalloc().
It turned out to be wishful thinking.
kmalloc_large concept should really be removed.
It deceives users into thinking that it's usable.

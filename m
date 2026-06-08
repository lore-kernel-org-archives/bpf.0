Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9521A3B7B7B
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913506; cv=none; b=kMxiIjf4Hyf8gsn4/zDTZwSBTQ3Jj4Ibs5OhS7EMW7nxlWZlxvl7qd7t7gw3As4aDKI1LFue8HFJI/aSpX2ZwuiNsQR2ydHsO2oWXxAVEHT6KxCQz6e1oHqGLKfql1z5rFxRWulcK/qJ8Mr+YFd/5UzPXqhcZqqdQhimfM0tA6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913506; c=relaxed/simple;
	bh=ZaYXd74wO4W947HBTLlc43sIaBj9s8ZXEj28ePkAUzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADAkM21FOvp8Oko+FqHUQJ/Wag0rN2dsH9cOPiGKzVdOUJz4ADQjdV41OkgBThIBnwwAXPH5atoYJn1tu98dxiQP1Shci60RgP0edyCMVubGBUS3Vpx24mwP7vnqovShuKnN6vJb5mnB7fvAugpUQIvaFly1sSZhfe2kHm/IVII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PbaywxLR; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PbaywxLR"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bed2195323cso587163866b.1
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 03:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780913503; x=1781518303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ULW3bj4Y9orybcM84cc6zZ+siCehkEue96H8pU01HE4=;
        b=PbaywxLRRJcFc6D4PN+jAuMtrXmWYW0gKWzzt6w7/31C6rL26o8/gpyKZXN5je1LFD
         GGYxgyam+F+73wZAttyjBk/vk5PxHZ3jjXJkRWD1ZpVb1gD1mvs8baf6aGvPiBKW5phu
         nX8/K5rdj4CqWUUSpdkKjg3av7NP41KVAvYXC42KqWGyzOGRY4MMoKrXHJ+VQVex0pL1
         d5+Sj7XOTZjklWAlx/iP0JQQgkHa5Ews2KT5j2UqUd9z8bp7N2sjLgV40OyFCVsPhWTf
         JmGlerg1zcya3T5imp0V+57UTPQEvwekB/Xtn1MrNC458Zc1d8ApVfSX2KMCzDDxSvtl
         IYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780913503; x=1781518303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ULW3bj4Y9orybcM84cc6zZ+siCehkEue96H8pU01HE4=;
        b=CoTQjyVZqsbz9R84VtD4AullbbEre4lgSguVRXl5bf1x1UCS1wFPHF1wM7t3ZA5PUl
         erh1uVsjmJ+vFM/a8TwgPsSzhM+YUP1d5vpuMkgMPzx8dGUC0KApOHfllSyZVD+P41m2
         gkJudN+yn/auX9rDILcgrV+xecsOiBvGoLeRQb56ifgWIVbYFLj88nK5t7dFnkHpSSmI
         +pH2Qt66/1JOayV4zh2z0QqmoUtZ0e8CFTF76EwjD0pZyvqNLTQ8yZ1yscbXl/29sr9F
         aP4gG8HnQoksvAl2CiWx6zkLXWR9JWfOdYwhq8P2xL0rshhMwYpIeilfUBVgkS5py5FX
         ZgSw==
X-Gm-Message-State: AOJu0YwDhgT9rWuO1WTxmpcWXusOj7BOX5iuhp1UkBKww+meYTL77WnY
	PvTigUJ4dno/xGcZMWivki2bW41sNS5ABMvKm2eQh55HFaJdaoxE6/wKV4kS9PqWYOs=
X-Gm-Gg: Acq92OHGQhGuO2uPGD7N1h/dF3D1gBiMJnRbYqxUA0RupIUjFrTa2O/AlnOss86IEnZ
	YcNKSZ3F2TTdrinSoNOxxvnXOjyqCNwdrjXe3Bf4HJnW0eBCI1S13hl4DiCLKmdsImJOh10RNVW
	H23Jij814dP1ruaVDbcEOgPQmsPZbb3yEMPCkb2W2/lGrOVWFTVNB7bCScWKEe2p5ea7MsZWVKD
	s2ChBZfxMKaE/NIH3XaNIPKLR4mO5F/cuX82aErT1ntbLPjWcCxD5bqUpBpeTlcLx2vwpCk4HAq
	8qQ6GxFjhKHik/FPNFen6EzrKqWtFdEhgkDE+lCgda8W8SbuVN7xrxZ3dAH/jhxGRmKNFQF1E0i
	WLkPTYTyDIJqyRU5OKg08LUpC0weNlYrBA40xoNhU0M6TuoXX3B0sjr5Nbb/4Yi9QJ+jnhx4ai4
	qbfjXVxnU3KCLQyh26aw0SD5JHXu//BNDrHobIdfcVinb5IIs6cYPCRtvzLKhFhgE=
X-Received: by 2002:a17:906:7950:b0:bed:2a8b:3e72 with SMTP id a640c23a62f3a-bf370c66fbemr645648766b.21.1780913502989;
        Mon, 08 Jun 2026 03:11:42 -0700 (PDT)
Received: from u94a (218-164-53-75.dynamic-ip.hinet.net. [218.164.53.75])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0a4b60sm16012687a12.15.2026.06.08.03.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 03:11:41 -0700 (PDT)
Date: Mon, 8 Jun 2026 18:11:32 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Zhenzhong Wu <jt26wzz@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	menglong8.dong@gmail.com, eddyz87@gmail.com, stable@vger.kernel.org, mykolal@fb.com, 
	tamird@kernel.org
Subject: Re: [PATCH stable 6.6.y v2 0/3] bpf: backport scalar not-equal
 tracking fixes
Message-ID: <aiaTZCQLWy-96M9O@u94a>
References: <20260607170959.823755-1-jt26wzz@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607170959.823755-1-jt26wzz@gmail.com>

Hi Zhenzhong,

On Mon, Jun 08, 2026 at 01:09:55AM +0800, Zhenzhong Wu wrote:
> Hi,
> 
> This series backports two BPF verifier scalar range-tracking fixes to
> 6.6.y and adds a selftest. It fixes a verifier state-pruning issue where
> an impossible linked-scalar path can be kept while the real success path is
> pruned.
...
>   15: (85) call bpf_get_func_ret#184    ; R0_w=scalar() fp-8_w=mmmmmmmm
>   16: (79) r7 = *(u64 *)(r10 -8)        ; R7_w=scalar() R10=fp0
>   17: (15) if r0 == 0x0 goto pc+1       ; R0_w=scalar()
>   18: (bf) r7 = r0                      ; R0=scalar(id=1) R7=scalar(id=1)
>   19: (55) if r0 != 0x0 goto pc+6       ; R0=0
>   20: (67) r7 <<= 32                    ; R7_w=0
>   21: (77) r7 >>= 32                    ; R7_w=0
>   22: (b7) r1 = 1                       ; R1_w=1
>   23: (55) if r7 != 0xf goto pc+1
...
> I also checked bpf-next: bpf-next passes even when the d028f87517d6 JNE
> refinement is reverted, because newer kernels also have the later
> 4bf79f9be434e ("bpf: Track equal scalars history on per-instruction level")
> precision-tracking change. I did not use 4bf79f9be434e as the stable
> backport base because it is a broader jmp_history/precision-tracking change
> for linked scalars. For 6.6.y this series keeps the smaller stable backport
> path that directly follows the bisected fix: preserve scalar bounds after
> conditional refinement, then add the not-equal range refinement in the older
> reg_set_min_max() layout.
...

To be honest I have not figure everything out yet, but I really much
prefer we backport commit 4bf79f9be434e ("bpf: Track equal scalars
history on per-instruction level") to address the issue instead. While
'bpf: make the verifier tracks the "not equal" for regs' itself is
self-contained and reasonable, "bpf: drop knowledge-losing
__reg_combine_{32,64}_into_{64,32} logic" comes from a much larger
series[1], and taking that out of context seems rather risky[2].

More importantly, 'bpf: make the verifier tracks the "not equal" for
regs' does not address root cause of the issue, it merely mask the issue
by making the two states different enough that the two is no longer
equal, which works for the Rust specific case you have, but won't work
if the value was slightly different (e.g. "r0 == 1" followed by "r0 !=
1").

The root cause to the problem have been stated by you already, it is:

> The relevant pruning point is that regsafe()/states_equal() accepted the
> real success-path state against an earlier cached state where r0 was an
> imprecise scalar and r7 constraints were loose enough to cover the current
> r7.

Looking at the verifier log you have, in the impossible path we have
r0.id == r7.id from instruction 18, where as the real success path (that
skips instruction 18) does not have that relationship, thus the two
should be considered different, and that seems just what "bpf: track
find_equal_scalars history on per-instruction level" solves by having
the correct precise mark.

Could you give backporting the full "bpf: track find_equal_scalars history on
per-instruction level" series[3] a try? For 6.6 it should be doable, and
hopefully for 6.1, too, but not too sure about earlier ones. If you prefer I
work on it I can also give it a try later this week.

As for the selftest, it would need to be send separately and by itself
to bpf-next, and picked up there, before it can be backported to stable.
I suggest you look at [4] and have your test placed similarly, and
mention that your test specifically test a Rust/Aya pattern.


Thanks,
Shung-Hsi

1: https://lore.kernel.org/r/20231102033759.2541186-1-andrii@kernel.org
2: https://lore.kernel.org/bpf/20260601182508.29C811F00893@smtp.kernel.org/
3: https://lore.kernel.org/bpf/20240718202357.1746514-1-eddyz87@gmail.com/
4: https://lore.kernel.org/bpf/20240718202357.1746514-4-eddyz87@gmail.com/

[...]

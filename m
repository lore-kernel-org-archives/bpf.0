Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F5C27A916
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 20:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790193894; cv=none; b=SzKOaN3zwOhadhmNm1Qpv2km/9oVI7qX4jFclg0G7HuVZYKinaQ22istqDzaSRIyTUmZ4h0SVc/W+qc9cE4tUNETZRmdhM9v1iVLdOIwX+8JxdCgAybCIrsHt9cZdOHoixfNvfGWdz1TOFMmkUH2yrwaWLkh8R6qYK2uIYHveSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790193894; c=relaxed/simple;
	bh=L/TZ9QXjVz7bvaaaXlYKNSzbROHnZg2bAIgMuRXaWsI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=PN1ESWZQ4LPcNXQM7v5rgY0yjPb8b9ZhZ2LhOJdQ8Pz9qrwArBW9azde32d6WqnDc0bHbbesC3Wddp8DLNO5AqZWhwG5mJd6koBb2Y7FsZhnjvTBeL53t8IFJ4vgzeX37crL2uv5Nad9SoJ5ypNTULuPQZ1vZu2LT2uo6+nNGtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G24fEeQR; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G24fEeQR"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49cfcf2548aso4298895e9.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 13:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790193887; x=1790798687; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eg7dIaD/wChCpqMaOq7zvuolG3ohtFh1DJNiz7Unb+A=;
        b=G24fEeQRzdb8p5XQVCViFE7AKJ7+q1KjsuYTT/Ns+TA04TG4iPyzVtNhGiyAQi3Klt
         T363ZOrcsSKx1g02OBg4J1ggfioA+4OoFAjNWEFOGvX9CDusKNxUWk0K2rK8jzi66hA1
         g0Kly+/a+1yrld9B5+Zog63DBbeV/SCk0wDLG3wNwcmIz8Nm4IGf6un3ZpfwDhCIQFSx
         k1Zd95UMwHCjiTCL7ZU5RYFXsqoG+Q7Bgxv5Rzs2jEHE4JRiCprQYMAMNW0i7fO9x0ZO
         5TJRMwT6lycO92pw428+TtH6lXUPVvlP1qWgF+Blpa7t34EbrQGjAL2CLFjNFEdG9ouZ
         Arrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790193887; x=1790798687;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eg7dIaD/wChCpqMaOq7zvuolG3ohtFh1DJNiz7Unb+A=;
        b=eMGiG6DT79+ECxORYYJn10PgBSZm0bCnl485iw+rWCmV/040d709Nau1+mJz+a9KOd
         F8BhJAn0UzDY/U7PU3271Rt+8uJuClTRO2oCLqo2obo9PvlVh4E/LJ9NeMLILgDhxr1W
         w9WIVnOjnvNP3cwzi+dGuFeIF/1tn+xAmwNnftOWpLdWtWTBUueSstYpnhCJgYI19Psk
         c6ASBVGsMnSz4w0tRyDl4WqNE86N2VyHZfN3+DCs6WykhYXHuNSfDqjcO3oTCg36pclN
         hsTb4MfamBMhbL2xTjyLMpt1E/m4Dz9N38MEBm/JCuRDZje+hM1T3bHPJqUZqt6tIx6K
         bKmw==
X-Forwarded-Encrypted: i=1; AKwUvBxrt0Zc8KikpvHSym3+Mz2B5yR/frWRyt/THpkoMSNNNoewRV/+kxP4aDuRXw+N2ynWWIE=@vger.kernel.org
X-Gm-Message-State: AFuF++mSHYVx3w0tlQgxuzxdACjsGVZGyV5+5Ko8/Vft1OYIB5SijoGq
	M1j4kHVLsxMWRiyT2zGVzcHQHG33RL7DEvYr2c0KhDcYCwFMfV40rL2D
X-Gm-Gg: AYBFou3wevew9bBEMpDuLaYjoPWHUQ4YWHIX4SPSZViQXc0dvLwCoawE+5VETeW25aa
	VBTRlcsMwD1RvscSVgNC4CpieOV3g+NPOMUhtG2mMxAf/JJEdDJz/SEVFP9r5iEANoH5tgLCyzj
	PeB5WwPcM2KIA+cHtLNBI0GavtH7oHMxLv/LLlWheUspNvOdUTu9EGsE613aThzsp3RRfh2cFu5
	ji2EUam5queXEWwlPpepWMJkdun0rYcTIHO6BlUstHpjbpX+FCATzL99cKM5LQ2///OOO8Bszpp
	DkY/DTDiTstyed5edsLlOAAAKVWH04IpaNQTELyBdQkUNYG5yr0aQxxUtB62x3voTJYUd6hBZOM
	XHOicVXyHJmWfQRImTuLQUzPyHzcUGPp4ZBx6OpSd/Vj09U/cgj4iM6XvXN5EfxjllP7U8Sdo7d
	aGBglcf401r6aW6oz+hae5z6uihb3SiCZ7v4i+MTScVFcsC4dsRlynPwQ3a3DM8zOTJ+SwJv5ro
	ZuHObSjL68s0IdFfegNm/mNw5GxlBa2Y9HxdLPwSSLRvrcar8TOtgI6O5CbQmouCONfVXR2jMSg
	SwNFBo16cF5taYPj/DIwaB7+/OqYJoSMnjnng+Ab/Gsb4Vq8VtqWdMSyojg=
X-Received: by 2002:a05:600c:350e:b0:49d:1fa8:b266 with SMTP id 5b1f17b1804b1-49fe670031cmr4017445e9.26.1790193886958;
        Wed, 23 Sep 2026 13:04:46 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdf158147sm73525065e9.0.2026.09.23.13.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 13:04:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 22:04:45 +0200
Message-Id: <DLMYRPN1E0EQ.1XSYMJIAKSM85@gmail.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <emil@etsalapatis.com>, <tj@kernel.org>,
 <kkd@meta.com>, <kernel-team@meta.com>, <martin.lau@kernel.org>,
 <yonghong.song@linux.dev>, <mason@kernel.org>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v1 01/18] bpf: Add accessors for verifier stack
 slots
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260923191139.2816206-2-memxor@gmail.com>
 <731653ff84bafb19361b62836f366d369799041bf18166b016dc7ff13eff5b73@mail.kernel.org>
In-Reply-To: <731653ff84bafb19361b62836f366d369799041bf18166b016dc7ff13eff5b73@mail.kernel.org>

On Wed Sep 23, 2026 at 9:57 PM CEST, bot+bpf-ci wrote:
>> bpf: Add accessors for verifier stack slots
>>
>> The verifier indexes a frame's stack state directly through
>> state->stack[spi] and computes the number of tracked slots as
>> allocated_stack / BPF_REG_SIZE in every file that touches stack slots.
>> Route all of these through two helpers, bpf_stack_slot() and
>> bpf_stack_nr_slots(), so the layout of the per-frame stack state is
>> visible in one place and can change without touching every user.
>> Both take a const frame: the slot accessor returns the slot through the
>> frame's stack pointer, so read-only code such as the state printer can
>> use it without giving up its qualifiers. Functions that look up the
>> same slot repeatedly now fetch it once.
>>
>> No functional change.
>>
>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> The commit message makes two universal claims that the tree does not back
> up after this patch.
>
> 1) "Route all of these through two helpers ... so the layout of the
> per-frame stack state is visible in one place and can change without
> touching every user."
>
> At least two users of struct bpf_func_state::stack still depend on the ra=
w
> layout:
>
> drivers/net/ethernet/netronome/nfp/bpf/verifier.c:nfp_bpf_map_update_valu=
e_ok():
>
>     state =3D env->cur_state->frame[reg3->frameno];
>     ...
>     soff =3D -(off + i) - 1;
>     stack_entry =3D &state->stack[soff / BPF_REG_SIZE];
>

This is correct, will fix.

> This is the exact state->stack[spi] indexing the message says was removed=
.
> It was not converted.
>
> kernel/bpf/diagnostics.c:reg_to_target(), which this patch edits (the nsl=
ots
> line), still does raw pointer arithmetic that assumes stack is a flat arr=
ay:
>
>     start =3D (unsigned long)state->stack;
>     end =3D (unsigned long)(state->stack + nslots);
>     ...
>     spi =3D ((const char *)reg - (const char *)state->stack) /
>           sizeof(*state->stack);
>
> If bpf_stack_slot() ever stops being &frame->stack[spi], both sites will
> silently compute wrong slots. So the stated goal (the layout can change
> without touching every user) does not hold yet.
>
> Nothing later in 277f2757dee8..7757cddf610a changes the helpers, the layo=
ut,
> or the nfp code, so this is not a runtime bug in the series. It is an
> incomplete conversion, or a message that needs narrowing.
>

Yep, also needs fixing.

> 2) "Functions that look up the same slot repeatedly now fetch it once."
>
> Several converted functions still call the accessor twice for the same
> index:
>
> bpf_get_spilled_reg():
>
>     (1 << bpf_stack_slot(frame, slot)->slot_type[BPF_REG_SIZE - 1]) & mas=
k)
>     return &bpf_stack_slot(frame, slot)->spilled_ptr;
>
> bpf_mark_all_scalars_precise():
>
>     if (!bpf_is_spilled_reg(bpf_stack_slot(func, j)))
>     reg =3D &bpf_stack_slot(func, j)->spilled_ptr;
>
> bpf_mark_chain_precision():
>
>     if (!bpf_is_spilled_scalar_reg(bpf_stack_slot(func, i))) {
>     reg =3D &bpf_stack_slot(func, i)->spilled_ptr;
>
> The same pattern appears in states.c (propagate_precision,
> iter_active_depths_differ, mark_all_scalars_imprecise) and verifier.c
> (check_stack_write_var_off, get_constant_map_key, collect_linked_regs,
> widen_imprecise_scalars). Only some functions, such as
> print_verifier_state(), were changed to fetch once.
>

This is less serious, but will fix.

> Should nfp_bpf_map_update_value_ok() be converted to bpf_stack_slot(), an=
d
> reg_to_target() given a note or helper for its address-range check?
> Otherwise the changelog could be narrowed to match what the patch actuall=
y
> does.
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/359098=
53278


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793318351;
	b=t6ScTyCxT1eAIh9SHeHSW1G40kIuYW//74AIGF9GOBMOgEK00yuuvLMDBuvdoMmLe4EE
	 m4sLvEYSmw9FYKRX0RyPOlwlGblouJWCI+0S+WFoiBY8P/3GYjSyFh0UO6iNPrQu4vliy
	 +CMGIJRlZkNYUJ316/U43oMNw3zUKM61VehfNB2y/U9D774GxOzAXRoIuFlH/PLncnzRG
	 6TsHnJt5PNmOXTdJ5hLMAcMdOVvhbbrXJFrTqfyJoLzlh+37YNZXs8u3c8/NmB+wkRwbM
	 +LqJlXdD8pWHtgJBjOhJEw+hwVTkirTlaPoAwxzsBcsWdlRorNyLC4cjJMxsy67XueA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793318351;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=VGMJLST0LGZUFVPZmCbPA5PwvaGlJCqBZDRorhKs8Vs=;
	b=JkAnRT/Giy/DT4oXcAd21N6K8J6eKfDZDjnmpv8rQb+/Q3jywa+HvZnek1o0itFEvu50
	 dt9prv7aVP5A5gIADavH9gaKwRTVGZWpEKJltSj+wD+msE0x1/Nzq4SyR+2L7vyPyOztP
	 QHXOc0uUsiTZc92j3NxaGqh0ZxQZS8SVX/pxyIFOIvuAreNUnnHoC2HLpIfZ/0to6WF9X
	 OkSANctyJFuxSYiB412s/dOSj/gFC2M+uaDYdhnYjhmtSyPa3Klyq4y0rI3aPMKSsTgMq
	 2M5Uc7KXbYko+6tFuzI17i2U/VH+ednvGPn87hd0iKAoiGipsQJfF797psvH280AOww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WoX69Q4N;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6389C606A31D
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 23:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6389C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WoX69Q4N
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3282db206d3so424221eec.0
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 16:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793318350; x=1793923150; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=VGMJLST0LGZUFVPZmCbPA5PwvaGlJCqBZDRorhKs8Vs=;
        b=WoX69Q4NNcPPhzbrlswGDlRi84VBL+LUZxxmp6vje32C9kac72+/Fup88MGeOvah2B
         uTgFaECD/M9bPN1r18IQsGSn4eQj7IehJOsJ3vpYnH9CpRD+7sJG40dVA/yeHKYJKPLs
         /tmug1prlcb0boHZFSu8Wf3xCuIh2/QPn+QvglnwwlqjMXtOijYKwsN5BRR0iob6abpr
         DAFHKbHuC9/Ir8MkhiYpGF8gHZSHkcx4sq0H1jktw8J08TIh0PkIPo3vpyn0N72cDi5/
         bpr/jl+gv/rY5P7w6JEF5EEG7h/2freoUlOXuBoFoCm6x0h77IMRCAlVnCPhHfqDl+r+
         MJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793318350; x=1793923150;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VGMJLST0LGZUFVPZmCbPA5PwvaGlJCqBZDRorhKs8Vs=;
        b=j8Xzsd1ie0Ed7+EezIvWfdX7yx+ImGVLs89+HNpRDlJfXQzScb45QfyZ/aAfGQN3vf
         +QgRqczidiItMzv4uCLtD4rbZISk18VJ2hApnEJ+CZmapecjPlMzG3uwdGJl9yeGtpiQ
         bisBvfnKMM3TupOJ7K4SCRVk9fT2ndy/OP1Nnon1s3EX1iPOaI0CAleb7UbuRfhaGL/f
         ZgookiNhSoUnOKuSh97AQxohMSNxlqFiVOLWVV22n3EafWmSJnjVB7dA0FD6JQ2MmqLE
         bidNMfLdfEmIp0o6iMALNuluAdWctxTQNbjiGEeuMLAYtZd9F/c8FGoYDotVEnGEO4v6
         sjAA==
X-Forwarded-Encrypted: i=1; AKwUvBymcsE5ejavLCAsgCP9MLxhX/zfUhiPjKYjI18QfxDiJf5SnAD8TKEDeibBjHnOZcV/MEU=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7IRrHNbIcwghb5wBlgaJ6uJBVE6gfzMNeVLuQhcBQMDW2RzFE
	ZssIfIG5GyS4Jjx9Fe7gCncl1It3f+jaLYWj2Dkx5Yi0rpsx3s/j08pY
X-Gm-Gg: AYBFou1DrkMsUsw7rpglfqfvrW6KkbzmF6PblGwKZsiRpgn/spUvakI8aUM3JeMiaCb
	OC0I+kIh9s3aKk9dVJPl7I6jj23hCli2WwBiZs8XlVYAxqu/it/f7vB4APRBWV1P/aYzciyXWY1
	sDxJGOnSDjrV8jBsmMnemeiLVSa+AT92GoyIefrqoERuJfwsM3vil0iz2IQe1tA0ELrS/iv9x3r
	5Ttn6CEYhBDwt18AZsH1o7XCY3QyHMnIgAKqEu1TJnEgxAqEg2nisVxYlGkWW/+4tUhgwO8baHa
	qAUQRv5u0kMNhjJNSCwxsL8d/5FVfrTDbB9q6iAHnTaMiMtRykGXtFHOi+mLt/zLL3X2p4CYRHO
	viTqFD28PbcOtF69Ghr1aF/pZMhLEi6uAxxUhrnzDRzYoNLC84E5vszH1BMyln3Bzak+nVT6t+V
	evjLTi5BQPg/cgcbSWgLk3nUf25o5YW/PFDz1c2TnH8jodUL13/vK72kB6rP/V/eWXTHOLTDh40
	fJTBzZuL5FnyBzRC0T8A/f/r84/DIVnmbj3ZC8HQ1CWfgOUljhYakIzlzQCWFP6625/s8OzV/7j
	5QKXbqy5gzltNlEGdfloFR9c/jFbzQVDCAK9h34DA4PJzQBGZ06ag972zTEwlWCFxFhqQvswBe2
	0HKZqmRk88ajU
X-Received: by 2002:a05:7301:619b:10b0:36a:1d6f:917c with SMTP id 5a478bee46e88-36a423c3380mr1319780eec.22.1793318350137;
        Thu, 29 Oct 2026 16:59:10 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:cb2e:96f2:5ce4:2074? ([2620:10d:c090:500::4:5b14])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4293b651sm1680245eec.17.2026.10.29.16.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 16:59:09 -0700 (PDT)
Message-ID: <bbe940d654ddbc9b099f578fd54137eecb79dd4c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 04/12] bpf: Track low-32 scalar equality
 across zero-extending movs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Vineet Gupta <vineet.gupta@linux.dev>, ast@kernel.org,
 daniel@iogearbox.net, 	andrii@kernel.org, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	john.fastabend@gmail.com, shuah@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Thu, 29 Oct 2026 16:59:07 -0700
In-Reply-To: <20261020161907.2115379-5-vineet.gupta@linux.dev>
References: <20261020161907.2115379-1-vineet.gupta@linux.dev>
	 <20261020161907.2115379-5-vineet.gupta@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-10-20 at 09:18 -0700, Vineet Gupta wrote:
> Linked-scalar equality is full-64-bit only, so a 32-bit mov from a source
> with unknown high bits drops the relationship:
>=20
>   r6 =3D ...              /* full 64-bit unknown */
>   w7 =3D w6               /* 32-bit zero-extending mov */
>   if w6 !=3D 0 goto ...   /* not taken: r6's low 32 bits are 0 */
>   if w7 =3D=3D 0 goto ...   /* not deduced today */
>=20
> Record it with the kind the previous patch already provides.
> BPF_REG_LINK_ZEXT, which is what BPF_ADD_CONST32 became, says exactly
> what the mov did:
>=20
> 	dst =3D=3D (u32)(src + 0)
>=20
> However this changes the pre-existing semantics slightly:
>=20
> 	today    reg =3D=3D base + delta, base known to fit u32
> 	here     reg =3D=3D (u32)(base + delta), for any base width
>=20
> Every link that forms today is over a narrow base, where the two
> readings coincide, so nothing reachable now behaves differently; what is
> new is that a wide base forms a link where it was previously refused
> outright.
>=20
> This is done by dropping the guard:
>=20
> 	if (alu32 && (dst_umax > U32_MAX))
> 		goto clear_id;
>=20
> What the wide base costs is invertibility of the high half: dst pins
> src's low 32 bits and says nothing about the rest. So sync_linked_regs()
> drives such a link forwards only.
>=20
> That also changes how a member is updated. Where the old code replaced
> it with the base plus the delta difference, it now intersects the two: a
> one-directional link leaves the member free to know more about itself
> than the base does, and overwriting would discard that.
>=20
> Intersecting can come out empty, when the two sides contradict -- the
> link pins only the low 32 bits, so the verifier can walk a branch where
> they disagree about the rest. Empty is the correct answer, and a bad
> shape to leave behind: reg_bounds_sync() declines to touch an empty
> range and the next reg_bounds_sanity_check() reports a verifier bug that
> is not one. Keep the pre-intersect state instead. Without that,
>=20
> 	w7 =3D w6;		/* r7 =3D=3D (u32)r6 */
> 	if w7 !=3D 5 goto out;	/* r7 =3D=3D 5 */
> 	if r6 !=3D 7 goto out;	/* explored: r6 is wide and unknown */
> 	r9 =3D 0;
> 	r7 %=3D r9;		/* validates r7 without recomputing it */
>=20
> prints a REG INVARIANTS VIOLATION and a WARNING from an ordinary socket
> filter. zext_contradiction_keeps_range_sane covers it, and discriminates
> only here: the later reverse-direction patch makes "if r6 !=3D 7"
> statically false, so the branch is never walked at the tip.
>=20
> The patch also allows delta composition, once. "w3 =3D w0; w3 -=3D 1" is
> ordinary codegen, and until now the subtract threw the link away: the
> mov gives every zero-extending link a kind, and the test that refuses a
> second delta could not tell a link that has one from a link that merely
> has a kind. Let the zero-extending link, and only it, compose a single
> 32-bit delta onto a delta of zero. The updated sub32_partial_overflow
> dump is this case, its register now rendering as id=3DN-1.
>=20
> Composing any further is refused deliberately. Deltas are compared for
> equality, so a link that keeps accumulating them turns every value a
> loop reaches into a state of its own: on arena_strsearch allowing a
> second delta costs 1176 -> 1751 insns and 102 -> 133 states, and
> allowing it onto a zero delta that an add produced rather than the mov
> still costs 1176 -> 1196. Neither buys a verdict.
>=20
> Forming a link re-bases a wide source, since
> assign_scalar_id_before_mov() drops whatever link it carried; that costs
> precision only.
>=20
> verifier_reg_equal's subreg_equality_2 becomes __success. It is the same
> link with a 64-bit compare on the member: "w2 < 9" bounds r3 over all 64
> bits, not just its low half, because the zero-extending mov leaves
> nothing above them.
>=20
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
> ---

Please revisit comments in this patch, maybe as a follow-up.
They are too wordy and, at times, hard to comprehend.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...

> @@ -18485,6 +18534,27 @@ static void sync_linked_regs(struct bpf_verifier=
_env *env, struct bpf_verifier_s
>  			if (reg->link_kind =3D=3D BPF_REG_LINK_ZEXT ||
>  			    known_reg->link_kind =3D=3D BPF_REG_LINK_ZEXT)
>  				zext_32_to_64(reg);
> +			/*
> +			 * Intersect rather than overwrite. A BPF_REG_LINK_ZEXT
> +			 * link over a wide base does not propagate back, so the
> +			 * base can be wider than what @reg has already proved
> +			 * about itself; replacing it would lose that.
> +			 */
> +			cnum64_intersect_with(&reg->r64, prev.r64);
> +			cnum32_intersect_with(&reg->r32, prev.r32);
> +			reg->var_off =3D tnum_intersect(reg->var_off, prev.var_off);
> +			/*
> +			 * An empty intersection means the two sides contradict,
> +			 * so this path is unreachable. Say nothing rather than
> +			 * say it with an empty range: reg_bounds_sync() below
> +			 * refuses to touch one, and the first later
> +			 * reg_bounds_sanity_check() would report it as a
> +			 * verifier bug, which it is not. Keeping the wider
> +			 * pre-intersect state only costs precision on a path
> +			 * that cannot be taken.
> +			 */
> +			if (range_bounds_violation(reg))
> +				*reg =3D prev;

I'm not a fan, tbh.
As a followup, I'd suggest a wider refactoring:
- get rid of is_scalar_branch_taken() (or most of it?)
- branch unconditionally;
- apply regs_refine_cond_op() for every branch;
- apply sync_linked_regs() for every branch;
- check if one of the branches is has registers with empty ranges and
  avoid exploring it.

>  			reg_bounds_sync(reg);
>  		}
>  		if (e->is_reg)

...

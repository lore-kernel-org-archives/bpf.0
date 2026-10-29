Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793314314;
	b=yE+hORMhCTbpeKK5O9ApHCRcsvgT0BC1SlFaD7cJHHITN5v/XJCxDAraua+vMiM2Z4gq
	 tupIXrDcuMzfFVzu65sAlWiksGzbl/y/GiD+8kASZAOKcxSv+lYcwQm77GBJmejZ8E0ZN
	 w2cLNQYZhYVtHkf4MjHuBveNs5nsAN0ymvxBRNVGNe225EFR0mpY97Rf9hQsr5eqJT581
	 zYgbGoxk0WWMdzdLSOG5oYQegLJP+Kq+ISw3uAHRAAn/LYkTX9eat+8Ui72qEElNuRKH9
	 be4AaIJAEkRRCg5pf9l7JBkvQLZiylaUGH1fCprGGwLDIOAltxc2TvmHLEA+qbn8LxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793314314;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=Hss75QZMHY8uPDXRh4LQ1BVxzqq6aGc85aMpqhknHO0=;
	b=08ai2NgVZ3i8KOAYJBU22NhgqE5uGJR3XFhrvZjyI9Z106oYvAB8KyGolc8lFyE463jK
	 3/C6X0iAhjt5Dr6Kz5+bPXjTr1DncZwmGL7zhXxQhCE+RyG2feGis0AHkYKbVnl49VRFE
	 E6T0VDQAN0EMuP34ff2FUpmC9dDuYT8NqL1ocBq+lc0OlvuEf0Nlu6wi6qmvO7601Lp15
	 xpZNLMmTDwL6dLRL14eKXAnpwvs2KVw1tH9PSyiSBYd3SL4OXK9+QuShBMMSRbmqqmohj
	 yhuxzgJYD+zyx0DwF8lHTEsXb7ymf7yfR0+0Du4cdbwcsyzJBMY8DDmL5L3RmS9O1rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iU6pl01B;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED32E606A31C
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 22:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED32E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iU6pl01B
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-188406bb948so69025c88.1
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 15:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793314313; x=1793919113; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Hss75QZMHY8uPDXRh4LQ1BVxzqq6aGc85aMpqhknHO0=;
        b=iU6pl01BqZ2NwS1tYp1PUcjVqVNDN4aWkaYxrRXyxRXtaMCTX6DblvZ1sgcj9kENTk
         5lFO/4731Mj5U58dSZt3CJsG7lwk4N4isUB8worOznMe7fYGaQ5ZxbxEzqSiWXYmA9TA
         M1royqRzI4AdrmdjtiBwCcoJoVoB1HJ2MI+OZ5qtxi4nl2FjP+pAQP5RoqdKSb5+Iu5a
         75J6wOmH7arBr0LYQoqzqx93vfB4cwYqPMYt4h9PFuh3IDzwh9wNyC/ERbzEHrjIhGYP
         q2cAhSo9GxSDE4eavD2tpDbooYBETy0sy2qkQxBBqWxYcM9y6CT7aeH5eP8zpqUGyuar
         /SFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793314313; x=1793919113;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hss75QZMHY8uPDXRh4LQ1BVxzqq6aGc85aMpqhknHO0=;
        b=TxLZs3ewk/AfzipAkdKr7JvJwA2wWnf3WPwu4bNBSgEeXwxKe+6aCZf9f+OK5tuPBb
         0afHFvv1tfRxOYNkyKUyLkNVpqZs/vKUqddJg05pjVXBbaPh0rxH00gnvOrkCpuBlX6I
         y8RSKG4Zeu+frpGqVLgz3NFNY1wwcDuuoFw05sjcoSkTlYzS4tlX2p58EvHH/AyQQ1n9
         egk/uwny7VJYyVd2QrVViHtXK/rfmNL5tj/7RCAXA5ce1b48WQTK4AOVO1Kvq6uiX6qg
         gSfOOvVIUqxAiHg11B+/IhUkilkc5VuD3k5mjddM97UUGgXSQlGRJyNtaTYTAABJ19gZ
         mWBw==
X-Forwarded-Encrypted: i=1; AKwUvBxjhlmhyhKvMk9pe+gruX1acemgX0afKLba9SB+popqSo0VxWzLl43RHTdYIKhMHZ/s8+Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYKMkdJnk6DPksgKbHl89GTWQHvE9eLxJTsLZ2/pYO6L2iZJobwm
	6nxE2ubF73avVMAvlWGssMPuETpt0LJtCHEYHPIyEPW7nNia3+Glookk
X-Gm-Gg: AYBFou3FrLgsmKUq40oMBVKOkCT34X0w/7cCXbjYNQcR8T2a/Yq/5e2Ph0PZA5J8CRj
	znRPp/eeGVx36hYNEJZq868jTISqOhNjfPX0f6UUcJC+Z56pEE2Tq6bqKbFRxxNWuLsBFEIfdPZ
	4hL+GgXtgNiIR4TkBOvEN9oTiuJ2I9hFKRx4OWr+Fg1Yo6AEApUXSvH2xBs7jPPxIifCN4hZu7B
	JG5KIfJLbZ2BqgV0V8YJKFW9lcVVm6HF7M1Xbw6n4x855M5gtzqJGT4W1Hm6vYehiZsMowmo8Qd
	/oQNkodxsCZHB7rM1O/TBhTcD8UxXsCe14rVKMGU/EYjfYaNrUVCbvKeC/beqBna7L1gWjMjTZc
	iQA3GPVarVkB7ukdSVL9fG+4W62A813YcFuA0yqal9et3pkO36+gTCO9Kngz8AXFu5EAxsMAJ3w
	ipJsmEAg62BldvMMFi2CmrcTaxA/PVzSKPNP23wNSDTkWYJQmNwgo7jh22lgHmwykLg7pXmrxLT
	gCc1l5sNqGdhPue9qw2UjoCJCjgW7tYAkvYVP7VyR1GVNCUMvKW7xS5Li8BKWYBQAar4r5zPEFt
	ajoVnhrKR7C0C1Tr09CUqG3se1hxbUU2A+fig+kGutWJGEphKbsxOpFUaHcHv7dlPoFyHeTtmuv
	dEcF1i0Nece8=
X-Received: by 2002:a05:7022:285:20b0:1ab:f77:2977 with SMTP id a92af1059eb24-1ac5b027fa5mr581517c88.14.1793314312717;
        Thu, 29 Oct 2026 15:51:52 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:cb2e:96f2:5ce4:2074? ([2620:10d:c090:500::4:5b14])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac19f4a04esm1522321c88.15.2026.10.29.15.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:51:52 -0700 (PDT)
Message-ID: <49019042b63d5718a9419e8fac035cf9104ae8bf.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 03/12] bpf: Prepare linked scalars for
 relations narrower than 64 bits
From: Eduard Zingerman <eddyz87@gmail.com>
To: Vineet Gupta <vineet.gupta@linux.dev>, ast@kernel.org,
 daniel@iogearbox.net, 	andrii@kernel.org, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	john.fastabend@gmail.com, shuah@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Thu, 29 Oct 2026 15:51:50 -0700
In-Reply-To: <20261020161907.2115379-4-vineet.gupta@linux.dev>
References: <20261020161907.2115379-1-vineet.gupta@linux.dev>
	 <20261020161907.2115379-4-vineet.gupta@linux.dev>
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
> Two scalars sharing an ->id are always related by full 64-bit equality
> today: reg =3D=3D base + delta over all 64 bits (this is true for
> BPF_ADD_CONST32 as well, which implies upper bits to be all zero).
> Sign-extension needs a genuinely low32 equal only relationship kind
> with bit 31 supplying upper 32-bits.
>=20
> Today the following 2 relationships exist
>=20
>   #define BPF_ADD_CONST64 (1U << 31)
>   #define BPF_ADD_CONST32 (1U << 30)
>=20
> Model them differently as
>=20
>   enum bpf_reg_link_kind { BPF_REG_LINK_NONE, BPF_REG_LINK_FULL,
>                            BPF_REG_LINK_ZEXT, BPF_REG_LINK_SEXT };
>=20
> So BPF_ADD_CONST64 becomes BPF_REG_LINK_FULL and BPF_ADD_CONST32 becomes
> BPF_REG_LINK_ZEXT with the exact same semantics as today. But this paves
> the way for a future BPF_REG_LINK_SEXT in the same framework.
>=20
> The implementation needs to change as well. Today the above 2 bits are
> shoe-horned into ->id, needing masking and OR'ing to get ->id and kind
> bits: with more types and bits needed, move them out into an enum
> bitfield of its own. To avoid growing the storage (and stay within the
> 1K allocator bucket), borrow 2 bits out of ->map_uid, 31 -> 29, which is
> still far more ids than a program can generate.
>=20
> ->id becomes a plain identifier, so check_scalar_ids() loses its "compare
> the compound id, then the base id" dance in favour of one check_ids().
>=20
> With the kind out of ->id it also leaves the idmap key, so regs_exact()
> and regsafe()'s explore_alu_limits arm have to compare it explicitly.
>=20
> One case changes behaviour -- old {r2.id=3DA+delta32} against
> cur {r2.id=3DB+delta64} was accepted and is now rejected, correctly, sinc=
e
> alu32 and alu64 deltas diverge in sync_linked_regs().
>=20
> Clearing a link is no longer just ->id =3D 0: any stale ->link_kind needs
> to be cleared out as well. And given this needs to be done in the newly
> added kernel/bpf/scev.c, it is moved into bpf_verifier.h as
> bpf_clear_scalar_id().
>=20
> The helper also zeroes ->delta, which the open-coded clear left behind.
> Unlike ->id that field is inside the memcmp() prefix state comparison
> uses, so a leftover value could keep two otherwise-identical states
> apart; clearing it can only help pruning.
>=20
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
> ---

Nice refactoring.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...

> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index 5432c0fc442b..a6f205653a9e 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -651,8 +651,8 @@ static void print_reg_state(struct bpf_verifier_env *=
env,
>  		verbose(env, "%s", btf_type_name(reg->btf, reg->btf_id));
>  	verbose(env, "(");
>  	if (reg->id)
> -		verbose_a("id=3D%d", reg->id & ~BPF_ADD_CONST);
> -	if (reg->id & BPF_ADD_CONST)
> +		verbose_a("id=3D%d", reg->id);
> +	if (reg->link_kind)
>  		verbose(env, "%+d", reg->delta);

Nit: it would be nice to see if the link is full or zext.

>  	if (reg->parent_id)
>  		verbose_a("parent_id=3D%d", reg->parent_id);
> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> index 48500d73105a..f0aa314233c8 100644
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c
> @@ -2285,7 +2285,7 @@ static void scratch_widened_reg_id(struct bpf_verif=
ier_env *env, struct bpf_reg_
>  {
>  	switch (base_type(reg->type)) {
>  	case SCALAR_VALUE:
> -		reg->id =3D 0;
> +		bpf_clear_scalar_id(reg);
>  		break;
>  	case PTR_TO_PACKET:
>  	case PTR_TO_PACKET_META:
> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index 953700822fa7..a1b90a31747a 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c

...

> @@ -574,13 +561,14 @@ static bool regsafe(struct bpf_verifier_env *env, s=
truct bpf_reg_state *rold,
>  		 * Linked register tracking uses rold->id to detect relationships.
>  		 * When rold->id =3D=3D 0, the register is independent and any linking
>  		 * in rcur only adds constraints. When rold->id !=3D 0, we must verify
> -		 * id mapping and (for BPF_ADD_CONST) offset consistency.
> +		 * id mapping and that the link kinds agree, along with any delta
> +		 * they carry.
>  		 *
>  		 * +------------------+-----------+------------------+---------------+
> -		 * |                  | rold->id  | rold + ADD_CONST | rold->id =3D=3D=
 0 |
> +		 * |                  | rold->id  | rold linked kind | rold->id =3D=3D=
 0 |
>  		 * |------------------+-----------+------------------+---------------|
>  		 * | rcur->id         | range,ids | false            | range         |
> -		 * | rcur + ADD_CONST | false     | range,ids,off    | range         |
> +		 * | rcur linked kind | false     | range,ids,delta  | range         |
>  		 * | rcur->id =3D=3D 0    | range,ids | false            | range      =
   |
>  		 * +------------------+-----------+------------------+---------------+

Nit: "linked kind" -> "link_kind".
     also, the table should show when link_kind equality is required.

...

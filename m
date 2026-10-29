Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313037;
	b=gueOv34QDFRiqRaPl8cflJUb8P5PwJBzq3yhPOifYYLDWh9syMaFDnnNfUoi8IB3GjO8
	 ekih8k6N0xq2IKvP7eAsah/Nu5IXukElIuOyC6TsujOh441NecCMtdjFi2ytdPty/ReB2
	 5u3v0H8BsluNyoaCBOSNDZEXJwaLJuJqrDh9ZcXYKO8EUBcU4g1SqhHkfeZ0Eo0VazO+E
	 93S3CIk71zrOLNtTypSvQPmrm3aoOQ426OZqZCXEmTPQYTNyAonGVOguWl5czmpj+0Mcn
	 95U62GAUJaSsyPAomdB4MqgxLuEgrcxUNeGNr5nyvyKALOPfKrsUAO8j5ap0Hyy6F9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313037;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=raAFDgbKNrzXejiq1hnLYOYiZSgol4DkfmEbVso6mO4=;
	b=KiX8pxTKtTI9eZeTyXFok++ZK8Wc9/Xjd+fgs/GBbOye7Fr1Wly6cWl+ZhvUXuEmjLNJ
	 Z3lfIAbCYgmIL2bMGv5aA4bDLYSYxdlDs9HpiiIMQcoG0xFfZss9Iwm3RWI7UX5WrqXxL
	 DlwmO4CmlZ9VflmAr1qkie9RO0vRyrzmqKJVEO/Q5rgB09qb7tkr7xxCC89oU95YLVGn5
	 3AAfv0rG/v9FHYq3/I4a5V4gB0KY2diEN/9KVXLT3hXPQMB/71F/CxN0tSgytBKPop/zc
	 snoBrhmMrduKSDKGLWLZl1UPmwzzLfZfi2YhjbwMLiMCzNnGN+0/j2Nbfyh7HikMjHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L7pPrL8E;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10219606A31C
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 22:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10219606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L7pPrL8E
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1931ff67a29so194830c88.1
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 15:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793313036; x=1793917836; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=raAFDgbKNrzXejiq1hnLYOYiZSgol4DkfmEbVso6mO4=;
        b=L7pPrL8EEFgeiEVXzTHbv9xSTZF45Y8UW+YkiZZZb5AzKUBfVQ9wXFtpSo14fUsVGY
         ZRJJXpYxJa2SrVd4LH5AlZaA7iSE6+C0UmUABUX4BfMgZtbLHSlud9ElnKwkKt3mC6ez
         q04hvGP46yVhEcQfXFbc8jepoQQNenhjPhvFXmTXHxVQ6ZRsNsNFjL31a9752fnsx5Xs
         x6RE61zO++ScNkkyZZBelSEeHLGHiBMnYlRN4aOd2MQcoLZ9ans3r2NieV/MYbB/S2vt
         XeTprG7GWae92hFwSuyx1LiAbOj7Old7zMVXOiRvqt25+ZgI3GoWracTpd78j5PkNTmS
         Vm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793313036; x=1793917836;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=raAFDgbKNrzXejiq1hnLYOYiZSgol4DkfmEbVso6mO4=;
        b=oY/ZRKBQKSkcLGzALUUlLmEEwKj24A5DWtk/ZcIOdYEC+zm46OlkJsPlovRUzXI/Hq
         TXHloYYl12RoKXSrD5OuDXE6+mOHqCVav7P6gvpbdPAB+hfekYg3AIcOANGZf0dXz6h/
         Qq6YhR3ejDkOX/hf2/THP08EZ9yGRTk9bCImLbkVMLe99Bzyoh+QJKtxN5Op/T0wMVO3
         PjG1+h8tY3BB6HPDBDbiaCE3tCULp3mEelsMh+pPJuv3m7/++daaVPgO1rfFrYp52O5a
         c4dT0aA6HO3cWC8bivjJit62n7F4favV10aJAq0BpOjjWZ05L4B6+VUQVtmMMLNMzTtO
         DXEw==
X-Forwarded-Encrypted: i=1; AKwUvBzNYMzouKrA9Xgp1gzFtnxfYV9n7OnHGHMmZptTze2H1v4YcNT1UaeZQ/Sb+N27nlfaIx8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIVvnn4XyvlJKMCahDIhEKkVpRY3WBOLGUUM8TQ0ppziG+cu4+r
	42A4voVVWmGASuzqbRtmCooIFx3jXUnrRKO6f2q+6yq0Hy9onpa8WICg
X-Gm-Gg: AYBFou1KeZL06S+LWP3gm4zbZ5pqTqEg+fYqc2/3ie4YlXRkMxtnagmCIT2Z/zP5mUz
	cchUCXmzAPLtf+Dw6eGpiWigLOGKs9qYKzDeKo1SY3tJpxCaAvstDV5YBUPDEWQYZJ+iIvIfzzr
	0qOP20FQJX9jZ9v5PQSOkXARwAcAkdrCL1LNdhHexGWhEMeDV12sf/6sb6KyDdAgNhlgkPcFZ/j
	rWSd2SD9ekRCBcS+sZHIyrJJ9S+xz/oP3RwgjQRkGGLGReTj84+zISZB7uxKQrWWxUfeQJ+9K3M
	U2dnIFSiHkPpsJBR9itIfoaQy6GVdW9L8jnxfyYFwOj6qHNclkLkjilc8CqQ6nCM7cnOrKtsIMe
	LOkPpDsBwsPktxKPfF3Ug67U3HiXOGsmI5oBuwhNsCHpcRjMJp/rXypLwUVd1rIF/SYSTW6CxMK
	r6mLtdqcU+ODXvhn4Dm8LhFIKu9ZL+If9Ly4vedpeweSaxdhfMcEu1lIohVoPVCKOaG4LSTTS4h
	nq97MwrLSC5NcIefkfhiCRMcw4GQ/Nve6bKRF+SSTwoiMjorldr0ODKEwxcm9MFDEq+aPdSvHkA
	LuLYX3bVSg4I7y7WC2vgkEzCTtHoqaquUq7FoRkZtl+oCMfnYx1xb5fj90lNyYH64d6C7vcbWGM
	/0tLFpq9NAL8=
X-Received: by 2002:a05:7022:5f02:b0:166:862b:9bcc with SMTP id a92af1059eb24-1ac5ac4caecmr596289c88.18.1793313036057;
        Thu, 29 Oct 2026 15:30:36 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:cb2e:96f2:5ce4:2074? ([2620:10d:c090:500::4:5b14])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac19c6b969sm1459038c88.14.2026.10.29.15.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:30:35 -0700 (PDT)
Message-ID: <9720ed1ff19dea17a1b379c02d7dd52ae886d807.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 01/12] bpf: Keep the 32-bit range across a
 sign extension that cannot change it
From: Eduard Zingerman <eddyz87@gmail.com>
To: Vineet Gupta <vineet.gupta@linux.dev>, ast@kernel.org,
 daniel@iogearbox.net, 	andrii@kernel.org, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	john.fastabend@gmail.com, shuah@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Thu, 29 Oct 2026 15:30:30 -0700
In-Reply-To: <20261020161907.2115379-2-vineet.gupta@linux.dev>
References: <20261020161907.2115379-1-vineet.gupta@linux.dev>
	 <20261020161907.2115379-2-vineet.gupta@linux.dev>
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

...

> @@ -6192,6 +6193,27 @@ static void coerce_subreg_to_size_sx(struct bpf_re=
g_state *reg, int size)
>  	if (reg_umax(reg) < (1ULL << (num_bits - 1)))
>  		return;
> =20
> +	if (size =3D=3D 1) {
> +		field_smin =3D S8_MIN;
> +		field_smax =3D S8_MAX;
> +	} else {
> +		/* size =3D=3D 2 */
> +		field_smin =3D S16_MIN;
> +		field_smax =3D S16_MAX;
> +	}
> +
> +	/*
> +	 * The range already fits the field, so (sN)v =3D=3D v for every value =
the
> +	 * register can hold and the sign extension changes nothing. The test
> +	 * above misses this once the range straddles zero: it only looks at
> +	 * reg_umax(), which a negative smin makes huge.

The `if (reg_umax(reg) < (1ULL << (num_bits - 1))) return` check is no
longer necessary, the new check below subsumes it.
Please drop it, otherwise commit lgtm.

> +	 * This has to precede reg_step_reset() below: the extension is a noop,
> +	 * so the base/step line still holds and there is nothing to discard.
> +	 */
> +	if (reg_s32_min(reg) >=3D field_smin && reg_s32_max(reg) <=3D field_sma=
x)
> +		return;
> +
>  	/* See comment at reg_step_check_unsigned(). */
>  	reg_step_reset(reg);
> =20

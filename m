Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6188F625
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 00:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786666250; cv=none; b=eHNn7VTUR8i2xt+9kJoXvlNzV9OFZQL2qsazEceN1HIw4eNYB+9Dt1XmQodSPZtMf7NPZ5Os7ghecPP6WBetLuFpdsALI8RlDBQGaAiaPYXfFMj0jWCMLCs2eX6sRY07edNZHWlj5g5vUoA/9kXKDw2X7sArHAbntjNgZuM/jN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786666250; c=relaxed/simple;
	bh=ZbAZOdWKt8XZK/mDsG8fx0AbUYC2YRiTBnBkT1i+14I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P05S4Bx8gtZX3M0ZxC0Ff4ukuzqlb9KcvXTUpJMwjdplP11WVBPvUeqvc78M0fG6FOSmyWVQ4aStqD0TTZOAo6UW1659M6cDmXAuOIv7T/7Uo5Te5DOOBpIrDBREK55/eI02UplMtBSDto40DlyCU43+rIYs8hz13CTZrhp5UpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqwVtewl; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqwVtewl"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca88130e09aso218123a12.3
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 17:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786666249; x=1787271049; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vxUJXHlvFRXY9nFTDrNukp2ua4VB6S3FKHVIjOzcgFM=;
        b=OqwVtewl8fNKYO3kSXdj+qGLsLt8MlM2UHgGUHRMNCdrwN1L6Yo8wuMcMFHlxvV7sP
         ojd9DpQAfERoQ3T6xQLXQGg/NRsyl5Bobm+HoRcEPKI/LJbMbLwugvf1ZBS18HORJPb7
         Dpt0iqBs/tdhQPhqUZyjfdCiQMiM6SvYiyPHBxJUj3yA+SE7YA/Ud1hrLB9ZkpznmXDG
         zHzq9z3vGRL48OP1T43e+8zvNWxUPMtQREQCnkgxV13wiW/lMi73YMMQBHzpZJtoOn6M
         +FO7HzoCYay95QO2QeaevFYt8I4qUj+2/DpPLKFfXmjjdwJFM32TB9FIb3OY6QnwJ/JL
         vCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786666249; x=1787271049;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vxUJXHlvFRXY9nFTDrNukp2ua4VB6S3FKHVIjOzcgFM=;
        b=e2wHgJYj4rKZFZHWoiZS4SXRjU4PVbfXJclg+qENi38/hFlspsMDpuVg6aEz3sLVE9
         URQluvUGnb+T0VWoj+X8bwLJFyveSFvFPW63+uVfVLP0BDw2b/sxgveh16ZRazcD1XZt
         Eqq1W6D2wNagIyJiCRG/LCgkqaX4sVuNI5Vztofakey+7dbpCn5mG5FKZujPtEWShlh3
         hYrAImymTE1gwPkZBdAhwQGB5vJCf/YKWYGrPDtJFUrhkvXD2QtMDS0ip4nKatW7mM2n
         6Ky4aDMkPcDXGtqQMocwfjlmukYVWas5xAcw0ferdUGbiQ/eCR3lSUUCC9S1iCiXCkzT
         x4Ow==
X-Forwarded-Encrypted: i=1; AHgh+RqX3ETWsznkso8KjUpvtgPmPKJwcoHRkyPMvFo82U9OE+3sk+ASPooUj+riHQKUFlKdEOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvhZ9kMAGsU2E5WA6wtbCrBIMHkEft/NoujbfYFLdukzEKjOGD
	wMNjYBUdMgSRHxpvp1h2TPJ5zKQSY6IpG3t+Cw6vfAlS7oo1waGKcwO54QXrVkZ/
X-Gm-Gg: AR+sD12nVcq0Kp30zzCSMaln0XDe3I/Cn06jQeaQGPipcdMZwcLChunx2ymIyAjzhJd
	rFLIs2MTQroXN55qKppFSFsvJmy4CAAcnRtZy4ywYZwMk98bK0ytYZkc5UFR1gDpuTQcBfxoPMO
	kXwcaui/uSVafjfE6jpq9gOjuHTQkAxOkfH6JO9yC8uziyDxMsNhzRLgwc31tGGuSRAqwWjun44
	/1+ooFz5kdHfFftLnd1Q8g2a5MqKuRbXxLd2U6mFNUg26M3O4/bwJaZaWqJKN2T7bkBrtvieIaL
	iFUKE7eU4jghOvfgSQ1PYv28jl7bwYg9GPQUxYGFusKQxo96T886aKCBV8WH6RJy4tikBH6P59c
	k2IrORXXEdzdbe1UH2tjmxi1FxMjRJgLYdXBKvPkNZQS1yX8t6uXKB57EyucqtAh4WDEHiq++Qy
	Dn8MJDpmYbEwCUL3qVLb3y+WwYJ7JPesbmUWK5srMFmWTO6GLkZa+Z51RLlvsC6Gu6eGxh+dZCE
	Iy235VyST+kZcxdloNbaWMcK85GovzK0Vq2g+Jqt3OtgA==
X-Received: by 2002:a05:6a20:1609:b0:3cc:3d08:da2b with SMTP id adf61e73a8af0-3cc71ad1691mr1706719637.15.1786666248552;
        Thu, 13 Aug 2026 17:10:48 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2cae:4c28:2903:b6f9? ([2620:10d:c090:500::7:1c5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3203ce11a8csm378908eec.29.2026.08.13.17.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 17:10:48 -0700 (PDT)
Message-ID: <5100ddfaca7e8c841a603d0688b21aa0361b117a.camel@gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: Keep untrusted PTR_TO_MEM read-only
 on RCU invalidation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: memxor@gmail.com, bpf@vger.kernel.org
Date: Thu, 13 Aug 2026 17:10:47 -0700
In-Reply-To: <20260813204032.644949-3-daniel@iogearbox.net>
References: <20260813204032.644949-1-daniel@iogearbox.net>
	 <20260813204032.644949-3-daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-13 at 22:40 +0200, Daniel Borkmann wrote:
> invalidate_rcu_protected_refs() turns MEM_RCU pointers into PTR_UNTRUSTED
> ones once the RCU read-side critical section ends.
>=20
> For a PTR_TO_BTF_ID base that is fine, but for a PTR_TO_MEM base the
> result has to carry MEM_RDONLY as well, since the rest of the verifier
> relies on the two coming as a pair (e.g. bpf_convert_ctx_accesses()).
>=20
> A writable untrusted PTR_TO_MEM would otherwise end up as a plain load
> or store to memory without fault protection. No in-tree kfunc produces
> the combination today, thus this is mainly hardening.
>=20
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  kernel/bpf/verifier.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8ef9418733ca..0c0dd53118d5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9054,6 +9054,9 @@ static void invalidate_rcu_protected_refs(struct bp=
f_verifier_env *env)
>  		if (reg->type & MEM_RCU) {
>  			reg->type &=3D ~(MEM_RCU | PTR_MAYBE_NULL);
>  			reg->type |=3D PTR_UNTRUSTED;
> +			/* An untrusted PTR_TO_MEM has to be MEM_RDONLY. */
> +			if (base_type(reg->type) =3D=3D PTR_TO_MEM)
> +				reg->type |=3D MEM_RDONLY;
>  		}
>  	}));
>  }

And said extension to bpf_convert_ctx_accesses() would cover this case auto=
matically.

Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026AD3A4F58
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790713586; cv=none; b=UCvFnTg97ZzaE8yBJSZ6SSGI1zwQ20g1KO9iaQ9TD1Ifb+fVLP9tT7Du8HjQBTwZaz2PCR1R3t4J0lPFRO2whtPQe+oWbayASR5f9/egHD9bZiaAocXhAjv/KNVZezH0KY6tSBC3LPe5iOLDiEaNxcYLdzsnPUn1R0sWUhw3I0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790713586; c=relaxed/simple;
	bh=d0f08Lw9d82bEWsPQgzcIX814zK0mNlCefYpfzSFf8I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lknjp9r74eqZRz/dmu7w04WV9TsQh/BLL9t+wQ2B3HBOwQYRml2L/0b7UGZZp1b3h6i6bxOerjydtl9dMBLjCuH2IRJZcC+ocI3CW8u5++n4uGd9433HU3mt1dtyo1O9lafTTBUCeBDIF6aj5eunYn47gNVkA9ZRR6OXTOtmFCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArwE5NNZ; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArwE5NNZ"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34c0b552ccfso394971eec.3
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 13:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790713584; x=1791318384; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=d0f08Lw9d82bEWsPQgzcIX814zK0mNlCefYpfzSFf8I=;
        b=ArwE5NNZjQkbrJlIfwpS+a2Coe7UoPEGJFTW928Jw8sru+bISFcRq6iBg64o5Ov/4X
         9+m5lwU0bwIiOASkL/fhUgNMA2pVHLBrMIDGnVWQUcI++oRfkHn+ksR2dBCrQVgVdGum
         HvX8aRoICPA/IJqh7vy45L6xV7Y86pym9Y0nlnCmdo2XH7CtxK9WgGVka91aDIzXV5aO
         WDUu6ns30nAef5OoZHZ6qSygLJevf+x1FPskzh/VngJCqK362Z4UkKQ35Y0V0xXwLZa3
         VEyXDkUyCMVimf3mKpgUI4C69bzwKtDgLkr9XiluZnNRiBDOTmRqZT/MePt6WeXAFOno
         8j0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790713584; x=1791318384;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d0f08Lw9d82bEWsPQgzcIX814zK0mNlCefYpfzSFf8I=;
        b=PRueveWS5PAxXpArM64gUv1ujiz9yD+0sVsu9HrNyU2VFDK/nwZTomO3g309vu/Co0
         IiOK1Pnlv21liXiEE9tQucw5BjLw2BNTpypKZzA6NN4OCoQsUM73kiY9Dp6Lwme6ItYN
         z+nkxh1fU/ho157TxjU0iAXPpLG0d/T7PzXs89tdCU6CCo7F6/XWTlksiMB0MAUe8qfR
         y+am9T2Y3EpGNEbAkYF177AtsIx+RhftffqoLKzxL1oK7bV0j8c2tXHyw7WGdJZ961Dx
         EufOn4aTHatNQvl9D6Yn3ozRrb1cz8QRsTFSqWlmdocfOFWFWszxCl8UfNAUKn69+49L
         3lNA==
X-Forwarded-Encrypted: i=1; AKwUvByJSwXurF8Lp4IafD54NQZZihKWNKcTnAvBq4TanT5c8agV/glDYLumdMgRx22tNjVSixo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIcCjetMuHnLQnhgjg8l6iftX1sDk/GtgSu59Wibh4ltIDQNuGI
	c3uwzT41QHYkAABr2X+k2leKgtXf5BCprEqHZF2GGw4gthpP55isefjk
X-Gm-Gg: AYBFou2Ay+TTrBmO5gTyNGI4yXtn5JbNbvEZEO04dnL/37GCh4ZY7XfRfJqdKigMzmD
	Gs1c4NA84UNho84YtQ0912V3XiDjWRmtGbcIeWrw5FAj+0TBEyI4GtJ/hDLK47/WUm/CsMNYXlQ
	HFLRKPyYHE01xhrPp+y0eRwvrV4AVvhWSZaehDenoH8hNUELp6/AZJFIrMClOItVenSPmXWTuIs
	GuRYF4CcMP6wsnodYuIDNE87LZZi12bNhfiDmZpygxsOW1Yq4rBfZbpZ8Ks+MZ45xQNOMpI12h0
	wbXybm/rWjSHbxLRPIBhoe/jIVmPi2t8YZzhqjyRB62baz8jbElnMDKZsf54VwTEMD7re1mpkss
	rgMrYSnNRSMuO6Rs8ZhWztOV01vJMyrQa2ksvlAgPDUT//SbwMI3AbwcMrpzvLuJxCPm3dOnD4B
	ocue0AiKA+JB1Kcld0ONw4IYUnxZbHrlIe4angMshGPmowHz14ZV4h4MSdU4mmVPKnaxrpyu7PG
	bTR1K0sAtKKB7OLa+yJzSbYMksBnCPrcbSa5AZd77UoJeUGTsf1kOLy
X-Received: by 2002:a05:7300:d20d:b0:315:afc1:72db with SMTP id 5a478bee46e88-34c65c61c60mr490065eec.9.1790713583999;
        Tue, 29 Sep 2026 13:26:23 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:abbd:bfa5:f574:cca3? ([2620:10d:c090:500::7:dfd3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34c386c2723sm1229398eec.18.2026.09.29.13.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 13:26:23 -0700 (PDT)
Message-ID: <37811b8cd92da6a037f33ea98549e6c0f37a8759.camel@gmail.com>
Subject: Re: [PATCH bpf-next 05/36] bpf: record write effects for atomic
 operations in liveness.c
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com, martin.lau@kernel.org,
 mason@kernel.org, 	ihor.solodrai@linux.dev
Date: Tue, 29 Sep 2026 13:26:21 -0700
In-Reply-To: <2dd22c28c9377610b3471eba2f88253146a2af847c30aeee6f5f86f5f2183f64@mail.kernel.org>
References: <20260926-scev-minimal-rebase-v1-5-c8e5ab5ba79f@gmail.com>
	 <2dd22c28c9377610b3471eba2f88253146a2af847c30aeee6f5f86f5f2183f64@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-09-27 at 20:27 +0000, bot+bpf-ci@kernel.org wrote:
> > bpf: record write effects for atomic operations in liveness.c
> >=20
> > Atomic read-modify-write instructions are recorded as reads only,
> > omitting their stack write effects from the may_write masks needed
> > by SCEV.
> >=20
> > Record both read and write accesses for atomic RMW operations. Keep
> > LOAD_ACQ read-only and STORE_REL write-only. Share the precise/imprecis=
e
> > stack-access dispatch so both accesses use the same address handling.
> >=20
> > Fixes: fed53dbcdb61 ("bpf: record arg tracking results in bpf_liveness =
masks")
>=20
> Does the Fixes: tag point at the right commit?

Hm, fixes tag is not needed.
The original code returns negative size only for STORE_REL,
which is fine.

...

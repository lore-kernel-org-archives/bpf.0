Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795140856;
	b=CmjZwaUnYYbcfV9OREPW3t6ITKWUCrjGaIZO76dB8O5lFCCO1naa0kEAOqxyc/WiPWYm
	 1gFl5IM+R0MZI7pi62XM73H2yJgqfd+nobOSsioJ2xdQdtULcKAmbEeFn+OuNGZHu8AKk
	 RJEhwOc+HAzPv+Tv+/ch0a9hIqElde3YjmERvI7ODTSZR2EE/Bg+OfGU1kGpO52k4pO1C
	 ZFsUZaln4y+zIvgKygsW5dag/bjN6lHu7b1rva1vR/+k918phrVLAecQwriOOstRwHf55
	 RSBuH1shBj5dRhjv9lO/i2qXyb9QTtfAaEvG+UwcPH/iJry8SuifuWjXwFJ175CD/4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795140856;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qwnuquGI33r38NkoJ7hs4vNmYK6M6vYCCd5IUaSABRI=;
	b=htpsrlvE5kmpBI0zhFSv0xJWwOuQPgD43utdsW8Xnr0swDYG5GG51QAnvp7ou1MGgnV5
	 eTixmJUjVt6csZV2FMIVwxfnHcNhMDIIVu87SW2yf7dsqKX1fTb2pybfbuu3+4TW7fIHK
	 CLQM3MXUjToc+j9EOPMzHQPhmiLrwQuJzfQjAHxL/03/5ZfREsR+fNUdn5Eo0vUrLAAtb
	 NArZxUelvFvlqvnmlyswNFi1tp6KnztNMnC2OvnlaboMP4V6Tmz5Cza0SxcoREHayF2WI
	 xTvRcu4ImD/usqGQar8YWfX2JgK0ZYaEOfB+mi9E4F3Ri5TCs6ScDij9xKv9tQjAIow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0kW6cvAn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.169
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674E8606A325
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 02:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 674E8606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0kW6cvAn
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3ab4354db11so3346941fa.1
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 18:14:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795140854; cv=none;
        d=google.com; s=arc-20260327;
        b=fqVIObbVbj9uad0exVgpHp4JN9nL/6F5YLbSvGL6AVufXA+Sya8ZTyjkxr5/Q/YY1w
         54Kk3ptSoC6SadSisu3qI15xTYJVE0HnNcSP2vX4jEWDUufjkS2x0RWZC00eHd57KBOL
         6rVRbJOL6C1MJl9CC+lkozm8khL6wuOnUOGsmX5GY9nuzDKt2D3CfOTRym13IzTLkEzU
         Orrr4dysSenz46i/C/h6xdWlvRETeecqY9eNURv9854UtNtwaJiONNA37kE8ADvva5/4
         WhZgLpxLkaFDpboiTdqmpzSnDB7ASNE9nXNsh2cvpbaPDD2YcaE3tJ7aSZETR69O7ZJ9
         nzpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qwnuquGI33r38NkoJ7hs4vNmYK6M6vYCCd5IUaSABRI=;
        fh=0kUheQRPy6nVLXxTpJO0dga2UeEcZmZRkZ5AL2p0PN0=;
        b=JqGukxtuJcxdffg/pVT6n47VIB9o/V3T4tW0Gkcvv6Yq44JjRZ2ib6dcPX2XOSnXeS
         lfeyqoeZByInr/0DkJ7ujOrwqURdfZyrvy69WteXw80s+sVa34KQhHDqag6e8ZWrxUG3
         MWwGSQA/Lbm26153GrJahnQIu4eqj7zqTtSBsIIrtJLDlwpniTp44fkCfdFAtFvZw9lq
         oY1Ru6avWGKGpVhD32g96fb70wN+YnGmloPq7mF5jhNlLiFKqiCLEIRKm77cbaxGOBqf
         0/QeIysA1i3/hhideGSyRVYSUvYzTSVWiAx4a5AWR9+mtpB56tbmi7oRwJyKqGv+JgOw
         hdfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795140854; x=1795745654; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qwnuquGI33r38NkoJ7hs4vNmYK6M6vYCCd5IUaSABRI=;
        b=0kW6cvAn/u+46Lzn5PS5Ap1ds5CSsxACBzwVNGwMkfr9zxFjcoHXKiffC4lGn8qlQY
         gs7g1FBDGe6wQWann4Oy7uOgIecc8hJkQTZ3qWIkID4t5qKNm/h6wSUI2atR5eOlCecm
         8i1FnV+oBCkpLJjK3JYYTIkD8/nTc5an8UxL63Ga4WvDa2ffgApPIpkMgiuSyymvvW88
         /wD8rfyomJiqtAKs3/N5UlIM1NSfpiLZwWppBVb81NfG6FBXAW88pLA2NsweTADdsNet
         sfXVR128Lbw3O1/hsvm2sQwRPC7J26DbYtfuM0wz+Dr0pMwLL8puyKMlmouaL24huHYV
         2Anw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795140854; x=1795745654;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qwnuquGI33r38NkoJ7hs4vNmYK6M6vYCCd5IUaSABRI=;
        b=IZ2GZq1hYNq8EOgTjtHvSsiLJRsPGPuTrTXeiJOeBV2uZG4NFXHf7ZFd5vp5EPb1R8
         do6GbW3dkmE7ZTmLFmXa5EOmUYXIEDABXPBvHnFvtTqPMf6OZbVZwXOInQp94pR3xLry
         ftDEzzaK9pdaGrakmuORjKP8jBT7dvWIvt1avY61fAuon9do/Kt2a4BaWxy7ZUoZNpAE
         9p8EWkhqBeer2+31+wh8pPPEl8Jh5pamG3Z+/SurfgjdT+w55OukUlY14wOZALwX6v+I
         2ZHRIHWpT1PQ3hSfMVyN1eLN7QfDesqe15vt8dbnFMqsqAFtVV9D/pefHQSwO3Tq/RSq
         uJ6Q==
X-Forwarded-Encrypted: i=1; AL+hErEyf8RXI45dvZwWRjveehhvlIhIGx/Pv1SmLfTkDq/vpb5ZsfwaQo2MGIfg1mhTkAMmBJA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9K+Funst/V4tlb3lPygU7nmbWzlvzT/bJOR4vpnp3hkGB2piRs
	9kR7+EDVRfQvDEho/hv5rgs3Eo0yN9qr1BHzz4tjjPdW9QoGalVRXy4QNk/lc535Kct0tX7zWE5
	RDBYc+c8pB99APaKaOxpV+HWniSptt4U=
X-Gm-Gg: AZFdTZcSgnA/VVvvEmAK4HGaZdlLScuQLMP9hP8CGyuNVFGtweGXm46gltiS1whWgup
	qW/0hUT+QaEx+WD+flKKVgSQkuOE4QKU2eGvOUnPttIqVhZZHyxQlEPWCbipdRn0J0HuPNfP8Vo
	F28BoAaFNV334OYZs0TMPt1hIV9t7HOcTq6J+NjjaQnNsaSnzgvu3QcNEQG1EEEwGvFQVb/KD1H
	uXp6NGgjoIi6MzhrIO1VWOfPMrq6IfBBA0DjUU4E955VJQVNKSHrQQa7hYix7IRlLCcgqp+EhnK
	Ze4bNUdUGlxIMKDgBsQInGlThr1JxNeDEc4k9hXUtKgUTL6l6nXYzPPAcDL7Vw7IBnHk0V76XMB
	R8DsGIDbci0anjxsBdNw9m0bNqb8ZXPh279h/z9lr03rlUilqCBN3fOTiqnUPmLq8ybQUga+5bi
	iMsxggWo3gO8aMFYYcyi06XR9MX/GFKRqZI38+7NlqTOnAUgAs8d6OrVvbUcT1U+Unua1Yme4=
X-Received: by 2002:a05:6512:3d27:b0:5bf:c2fa:3261 with SMTP id
 2adb3069b0e04-5c1bc8507bbmr399936e87.62.1795140854265; Thu, 19 Nov 2026
 18:14:14 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260901083325.3445-1-kerneljasonxing@gmail.com>
 <178847847848.4131868.16090144540850507396@kernel.org> <CAL+tcoDpyG-Hy9mtDnLSGu0nvU_VDqTjs-k51r2+OPwVyHtABA@mail.gmail.com>
 <CAL+tcoC=w6j+1p8ovjbLxgb1QdL3ipic0nMOvX_9OJrspSQS2Q@mail.gmail.com>
 <arKm5gCaERk6MaGA@boxer> <CAL+tcoB8f7H1ptcEk1iVH065AcUNPEL2V1gKoJacwr3zndfPWA@mail.gmail.com>
 <DU4P194MB29716D57A08053EAF2AF4F8FA7792@DU4P194MB2971.EURP194.PROD.OUTLOOK.COM>
In-Reply-To: <DU4P194MB29716D57A08053EAF2AF4F8FA7792@DU4P194MB2971.EURP194.PROD.OUTLOOK.COM>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 20 Nov 2026 10:13:35 +0800
X-Gm-Features: Aa3M54pa6BuImF-JDf3h3rfZH2I-9jKwu2Mik1fylUySCS_D0U-LbD7MWemGb7k
Message-ID: <CAL+tcoCKk1kLqYp8DJuVmj3wf--zPDfSkAGPGoJGr5ELR_nmBA@mail.gmail.com>
Subject: Re: [PATCH net v2] xsk: set network header on skb at generic transmit
To: James Sawyer <jamessawyer@outlook.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Bjorn Topel <bjorn@kernel.org>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 10:10=E2=80=AFPM James Sawyer <jamessawyer@outlook.=
com> wrote:
>
> On Thu, Nov 19, 2026, Jason Xing wrote:
> > James, I would add your tested-by/reported-by tag if you don't mind.
>
> Hi Jason,
>
> Thank you, I'd be glad to. Please use:
>
> Reported-by: James Sawyer <jamessawyer@outlook.com>
>
> I tested the v3 hunk (skb_reset_network_header() at the top of
> xsk_skb_init_misc()) and it closed the issue. I will run v4 through the
> same test when you post it and reply with Tested-by, so the tag matches
> the patch that was actually tested.
>
> Thanks for taking this forward.

Thanks for your report and the careful testing! Will send it by Sunday
this week.

Thanks,
Jason

Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=67.231.153.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793518025;
	b=vPYEz1nBM0jBeIbpGlFUAVoI7e9xKO5Z0auYekfEJQp2Hbk8h5nTkIvdx/O7qE6WJCWR
	 83v8A6X9sZYHw6YJqN8EtLrXU8veSSxbeYtEK6Hg9HTtTr7mkjyr4IrGE0ebOwGf/CRej
	 hkbQVEVLxGgbOeAtdBTeOibGPCcp5ciYmisQKYV1vb8X4Z5CneZXG0JpZyff2Are4mOYT
	 KlDjtcOZIv40fGkEVNYRyB7r0pScQ1SxhwJ5ypgsZpGrMivK2aDx1/N620KvmhO1S7WgG
	 70rp/AaUWnakrlb7oakFSIhcpSq9DcIAgimdkDK7vqjZ4URX7ZQxEEUkRYblUXT+zYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793518025;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version;
	bh=MGNmRZJ5EXIuTeQwUeV6hfVHLx1Zwi2jbLG26tP/iGU=;
	b=UeUgNtBV6g8AsiPajfbpaRSJY6kgoRn8cUWMnICP1pTkCSZTYb+1ycn4Jz9cy8J8DguG
	 rFlHbXS60PeBR0jXG4XRF7zNRWjsM242rNqiZyFc++2kmoRcDGGSRX+swuH4d8aZy6KA/
	 /KFv/g+8K7Fq2PLcSMqjaTpJejJuMTBawG59329G0cY6kEjtaqYI8whW0wLSoUMKgqAAd
	 48wzD+bVnSJO+SFo/nDZPJz85Wwqu2F9kQUGTSM3qQWemJA1UGtZ6drWYmswN4nQQK+T+
	 YU4XfAQB9EWesSlOjMvKwUFd5rBHNJ3bErYA+TNdhOfIH7R2Rq9Rx7w0RNFcMzXoPxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=QxdmKgD+;
	arc=fail smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBF0606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 07:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CBF0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=QxdmKgD+
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A16gBSX3709609
	for <bpf@vger.kernel.org>; Sun, 1 Nov 2026 00:27:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=MGNmRZJ5EXIuTeQwUeV6hfVHLx1Zwi2jbLG26
	tP/iGU=; b=QxdmKgD+2Gh+nDrlGV+0UKG89Bg9bCduAh27t2zIZi1zVhDZLThE4
	Zy3DFGZRIuiSqcknWA+ZYkoWHKv09DE3ULf5zxUVDAUPUGkckLJArB+FXsfhS4Oz
	7KBqQJPMcoibmmgz5KVT3QySDylc1AWFLix4hUPgJvVgWq7akLcnE6lfZnRI7r1n
	UvNUM85QQoaASi6UkcxxV82SJyApOrNXO+dgzbnQ7HV97NmwcAngRxIEqcs0ZB1c
	82XjLraluPmLlmBSf/W+Pwqnl4cU/KZPyouP3/rA735W9nlzaPOjQdJsFOe0tzv7
	GFE1UiO4v2DkvwHGcCDAEH2itHD4HgQJA==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hndubumj9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 00:27:03 -0700 (PDT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8b18c67095dso32606147b3.2
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 00:27:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793518023; cv=none;
        d=google.com; s=arc-20260327;
        b=oW41tGhKi69icX4H/mRoI0U+l/iMzuUhGwb/w7YnmEg84T17TOX67vkxCrBCZLYl8L
         d8EsqeqiTM5ca8DHFFvBuPUDNFHlq0ShLFbGucx8eViphY19DZ4Rq4w7mWrdqRIwmXNR
         jKNLuEr0qjT8iQlHNwfDkCTFh4QX6+tRIqF8D9I2ztP4ge6PV07sRhndHGoXPSoczIc2
         FgPwzX8rzKxu4VxAgu3v6BgK/VzAsfI3kqTCbEYlcZUh2MSdXtR2w9S4tPIBDiF8hTqE
         vWfps34SRvHx5KyKyY5USxaVHI3I6g3XhrS3IQa32l5uIKycwko5xwI2IKjWbiOKhgq1
         DUNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=BiF5XqM8lkk0AvCPxwWh1yK7P1B7bRDHAlKk74+QNa4=;
        fh=TEBidfRvke67vCAy/LUGjR87Odm8+nr8rWlqNk9Kcl4=;
        b=abpDwPz8wQm/jjm6atJz3sBjmvn/ji/6gRHVcis+HF8UKhhmeheobHaQikunHWlnEF
         QCa0tINe2Sk/1HPJj/X/lWj7mI4yLIRF3lc9Go1o8x1KWAYq09nxPK9lCMvn2XlF6aQf
         Iq18KYJ21mrhpe4pNUbSF98gyrxF6cJbpqPL5XMogE1tCj4aG7S7eb6Us9ZADyVGqueT
         9Exkwn07HUOVzfv2zkdFs3cGPUccqwEjKS3VBPMQI61ekx+64f0BDpoeq66SPngb1ldG
         Qb5MDYnf/fxX0rkGCJyrsgWbIlSh7Db5a+vKpnYkAb1iZFp9/hH0BbgwrvNBb9rFXj+c
         89DA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793518023; x=1794122823;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BiF5XqM8lkk0AvCPxwWh1yK7P1B7bRDHAlKk74+QNa4=;
        b=nSOCJ9VCk9UosXm70m3ApzMvQENfaCg2lkUNtzMOOIXtIFcGR6kNYMn6TmcueDYjwg
         bgUkQ0J2AcdR20BwVePknZGfKyrW+njQoyMGOkrryeW9uvlw6/wzh1XwMM/lYP5XYYp5
         +zz0ZS8b/u2FwWooyy71Drjm/HMA6YSkz9NezEU7F5KwW8uyEwgaeb7s47qL9AgdyOrj
         tBduKlpu3Q8vtfwAx5646ADE8NaompYKmNVHwy8j73or1FPxE+2qb2Y7IZhVF95+aaNJ
         CIXjCJAd6DTVkAQCYBRuqEu9jyn4jPVsSGDcYTYKMVlzkZtETt5dljRnoxOuiqrGVAAC
         M6nQ==
X-Gm-Message-State: APuU4Z9Zvg5qCgdrLeATaOixqxpDkm46rj/DdiZhy7lyrUrFf+7JSEVi
	1ltvjnTQIA0VqMgUU3hQGAvLBs3dXhwOiWvykC8QK3C6CEF+5uozADIryDn9/D/B/KfPzOIOw38
	P5IX/fhKXx0ESr/VWDTHWQ5B2g7HukavjX4G8AqfLh36DPeKs8+nuZBpREYDvlWVzlGXLGsfZ+q
	/HWfpRxp7kor7WF9rW6pkAXiWRWy8=
X-Gm-Gg: AYBFou3hv+u8wHWRf4o1iPRlfGa+8Af1bArpBkGO8T8FgcuxBwDbqXHGcVyWxuvxRNp
	FMRzNdcekukZIaCytgQsKOcq69BxBLNqUSbh/bpJl+wkDrt5ySvyezAGTfMSyxAoBahoDKyYN28
	VF0TokhfIn4DMAODb823bwjwwi5tzh49iU0rFIOflgtVIWxZ7IdXWw/iOWopmK+VHHkksTlob7t
	zJMov0dJQtyDDk=
X-Received: by 2002:a05:690c:f14:b0:847:d0cd:11eb with SMTP id 00721157ae682-8b2b6597d61mr50499027b3.9.1793518022700;
        Sun, 01 Nov 2026 00:27:02 -0700 (PDT)
X-Received: by 2002:a05:690c:f14:b0:847:d0cd:11eb with SMTP id
 00721157ae682-8b2b6597d61mr50498917b3.9.1793518022073; Sun, 01 Nov 2026
 00:27:02 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAJgm7qNx6NBzfxQbwF0ZoMLoULquNpsnrYSL1F3EFf2tztES7Q@mail.gmail.com>
 <2026103022-epilogue-coeditor-0029@gregkh> <CAJgm7qMWGF3zWOR=5qO8RWmufGud6fcNBQQxTsVgx=CgvRz3Qg@mail.gmail.com>
 <CAADnVQ+spWODbcC25SwVFXUv+ksPNuVkQgxtq4PwLHdDDsSZCA@mail.gmail.com>
 <CAJgm7qMEz-O1+L2MJz+qqH6-pz_ELaQNG0QQkgMbHOoDi69R4Q@mail.gmail.com> <DMJHKAHV1KRA.OV1LITSNYP3D@gmail.com>
In-Reply-To: <DMJHKAHV1KRA.OV1LITSNYP3D@gmail.com>
From: James Burton <jamesburton@meta.com>
Date: Sun, 1 Nov 2026 00:26:50 -0700
X-Gm-Features: AclHuK_XI3D84HCJeEC_NGSG4EAMqGoKdfh2EYjpzzp4ECJ-4LU9NohxMFFdFAQ
Message-ID: <CAJgm7qMsY_SVEeX8AOuOkyMdyPjU34G-WNXCufLvYeNa7_yiaw@mail.gmail.com>
Subject: Re: gotox/INSN_ARRAY cross-subprog fixes: request vuln-fix
 designation and stable tags
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Eduard <eddyz87@gmail.com>,
        Anton Protopopov <a.s.protopopov@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: SlvNT3O1A9nLGfEqzJqRFdpaRDI_KBE0
X-Authority-Analysis: v=2.4 cv=JK2uIMKb c=1 sm=1 tr=0 ts=6ae6e9c7 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22
 a=pGLkceISAAAA:8 a=dWYsJmFqNPkyoDUjv0wA:9 a=QEXdDO2ut3YA:10
 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-GUID: SlvNT3O1A9nLGfEqzJqRFdpaRDI_KBE0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDAyOSBTYWx0ZWRfX4oS5zhRgHMPr
 6+i5fTitftc+JSHlmxQ1euDRyh0+07ozZHlVU9lkQsDCVRxG8j0hU4TX70ymwSfTLgn5AqmNvt4
 BHxgsbBZz4jluICbw7CmL5odePbP4YsnVq6+PMtVfHvF0PfOa9M/3oY58I+ggFtyTnhczEmQ1KR
 hF8ZCBLqKuZsHL0G26m8F9Dx41ltxC5X+yk1bgxV7W7I1W2JI8oWVVv1nK7T7aUrwsUb5pmsTJQ
 xossZ6B9vPx14hRUkyvTn/lVTWPV/r3RjWrCMk6mp1oK3/PoShjyNLv2TD60pdfK6VHe+E1KHl0
 l2cP6pIbfNbeultR08PVDiS/9+5kqUVB7crVxli4AvLTD5m4LycrBTCMNRiHSGDIzS+zQUyriyu
 EZqB+6/BR+l62ash39jc9XjTdSFoc2PTi0otN1lSvUffSfAn3Hvv1aRH3ZTPLXgnXlSbntisCGs
 GQWpRsHKoED5Oyl1+5A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDAyOSBTYWx0ZWRfX+Oggf64i1lSi
 X/vHNCF+g0cCio2MDpivz+7iT2xxN9M5C3Dv4yb58IumhqJCeopV3pN96JBoCCGcaK2A6a4bTI5
 AKa5FLzdtuOdf5tx6Z1Gi+LIcZagHXk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_02,2026-10-21_02,2025-10-01_01

The latter, understood, I'll focus future reports at paths reachable
without cap_*.

Thanks again for the quick fixes.

James

On Sat, Oct 31, 2026 at 6:33=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> >
> On Sat Oct 31, 2026 at 11:07 PM UTC, James Burton wrote:
> > Daniel, Alexei,
> >
> > Fair enough on searching lore first. I did, and that's actually what
> > prompted the question.
> >
> > The same gotox/insn_array feature already has three fixes that only
> > needed CAP_BPF and still got CVEs and stable backports:
> >
> > - CVE-2026-43321, mark live registers for indirect jumps, in 6.19.6 and=
 7.0
> > - CVE-2026-93043, interpreter fallback BUG_ON for gotox, in 7.2.6 and 7=
.3
> > - CVE-2026-45967, wrong address for insn array offsets, in 6.19.4 and 7=
.0
> >
> > The two I reported, 19581372dd81 and c48a91c049fd, look like the same
> > kind of bug on that feature and sit behind the same CAP_BPF gate, but
> > they're mainline only, so 6.19 through 7.3 still carry them. The first
> > one has a deterministic reproducer that goes from CAP_BPF to root.
>
> Are you after cve scorecard or you want to truly improve kernel security?
> If later then please skip all bugs that need cap_*.

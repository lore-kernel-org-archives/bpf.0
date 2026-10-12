Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACA33EAC8D
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 15:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820376; cv=none; b=io01O5i3RejWra+QZQarDhCLIZADgDkUr3lVMRh3xWk7oVZ9p52IlCfSjlnadVkiXH5e3Ggc/5WzkGpY4pvOE3KtjrNs4fS8JgJLYBiB0Z0CZE2FVHt6aZxbTJLO6j2gr7OsZV2ziIPsEnXmkzB4CFl9pAfCfEG2ZQaZvXqO37k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820376; c=relaxed/simple;
	bh=LHMwAWagy6GhPKXqHPYzseRLeMTAefpgZrXkoLY3gD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oH+b8XIt2sy6qS6+BycQw4JICPRaYCf7uB8xosHeacqDTn+VxhzQxzWxuahzwoRiW4ErhXs+Tkf3sF3XFP/STZ/PLEbXXIl2u8aJ2UfDS1sbK0RIVqNOGylhfJ0dZsWwOBkMBVkREDQUTGc0jvD4XxIb7F4lZ40w/r6DCXn3ySk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jxBot3MI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lm/UyzQp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jxBot3MI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lm/UyzQp"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFevaX1895533
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 15:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/oJKRRR72jg/nPW1o56vlRji
	pAWluWMfTze5tftOJ0s=; b=jxBot3MIDZXo+S4b8hKG6K9YVcffzgO8qTGXTEUZ
	6r0GS8QRiOcJ2yVqRwUc9uJqBSRH58zMt1ba3UW5e2A8IX7POOtYiuyZmUKUtYsr
	BB1aCcGF1/7LyEfcPpWqFUe51Ai3SvnneFTemqoJqyydGFVPpaqBiLkMV0fIXL6Z
	Fja2TuT3xoC45r5iWBdn06h/ADKGk6kBvUS+L8tLt0PLdyQq38ISyfx8MvOOyUXu
	1fWd6bpmpiU+yefqSY+cWSbLfWe4igTiOPm7fxNynK28cQ0SewoaNj0uB6CLoHzB
	pu1uFc9lxJ2vDATlJlxfesX9sKvwNF+80olV2vCk013RDg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8v7kswqv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 15:52:55 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91961374299so75825406d6.0
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 08:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791820374; x=1792425174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/oJKRRR72jg/nPW1o56vlRjipAWluWMfTze5tftOJ0s=;
        b=Lm/UyzQpwk8njeemVkodiv5aV9oGcKTIK4jVsQzAej9CbumLKQdFpV+zePopifqQm7
         YCZVTAjG9hamTzPc/C67e/4+XnLYGm+VDBfTmTodZcKwQYNJUzRLgxgnROdEOM9H3fix
         ogM9d+Vwaod2woxo/CZzD3a64LUxqlX6QCKdn1DmEXwtB4Aew9WluUe6mKAkMz8Yg2O1
         82GLhn7N6dAXcskL4604WskLEU5ObH2hkU8q31QlL8mbMSWG1IPJEthZhRfWHtvxJDvK
         KmGS1gzckICaJj8CbSAYxri2lXI+VTrrjHX7kXmdwPC9v1bDag0pUmKfZIvLle2F+t9H
         gV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791820374; x=1792425174;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/oJKRRR72jg/nPW1o56vlRjipAWluWMfTze5tftOJ0s=;
        b=gnEEPZwapJTOz++UmErKA/UZ2zX6Bo8G3T8KQX38bXy1Nh1ZC1ktXtWSiQ4praPAqL
         KKNPxJU4BZjjP4F9YZqHbosAjf5U2GVTIck6bgCKb2A0+AusVEnytMwSV3xZ9y0SlUF4
         zI7Vd+phLYONUAOba7jBzLaYk/qoijReVwCsTdHGHHoh94y2zJtQJaEtGiMYYPGhl/GY
         cvRfoPcDFWr452qWNaMntZjIz1sFBvgSUCkLrMj+oOUmMcEHGZfLe0+sqB9nfPWpVLLI
         BYEw/+f3AesI9sMwHa6XDbuLmWm4pDjEmJrGbXjCY8krgC6MHGRLLO2LRlUOOockjNmq
         ohIw==
X-Forwarded-Encrypted: i=1; AKwUvBy3PLW6Rbx1iC+nS2greWrAx37uu+L6PMNZlLET6Ng+ioEKYsbTk+eG9Qc23k1MKkjB3PY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIMJ9E+UiB2CT6RC+xK1WOysv8/DvK85om/WwCkwySsy9htUwpt
	hNX9DiWWRpnCrnsAR7J8TNTXKmYfApBihB7pOHAqTmqCYCbhQ/7O75pAaDKa505QlomKJiQkaXp
	xxs2XkEEa40JvFoFfkOi+XGsNHsqCsr771uXEaskjHsPk+OrhwFUSb98=
X-Gm-Gg: AYBFou1Q7n8sbvp2rx9+zh+C7KW6EnZU+gnfuRaz23pPiR8EaVcKPfWqBUDZsIAyMhG
	j0yiqzXSNtPidVjkN3Q3uJqPA5kZbD7luLRJckOPt3rAiY3KSHStmDyOQB8DZf1QATyHvk+GhHJ
	XmpBolzwRNw9hZTnaHs31Gdr1tFVNcvOTRVSTd/Qp321TqYP0d31uQhZr2Aun7rVDEzw+oapShG
	q2t0D18dxduXilcL/5ThQ1KwwbpPL0uqt//qT1KT3QXLEg6C1KwwPqw6Z+WmRT/iaTumIVYnbN4
	5lD2Wik3QI7jAKQeVSx5rOY8wSY17sC8Dny5K0jL9/ZbTVoVWNmz8ibFNYPt3+UDw0mLmWNiNM7
	jk6/WSq/sdHuYoQ==
X-Received: by 2002:a05:620a:4383:b0:93e:74b4:3115 with SMTP id af79cd13be357-93ebd248c51mr1554725985a.38.1791820373964;
        Mon, 12 Oct 2026 08:52:53 -0700 (PDT)
X-Received: by 2002:a05:620a:4383:b0:93e:74b4:3115 with SMTP id af79cd13be357-93ebd248c51mr1554723385a.38.1791820373370;
        Mon, 12 Oct 2026 08:52:53 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaaa34sm165063f8f.20.2026.10.12.08.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 08:52:52 -0700 (PDT)
Date: Mon, 12 Oct 2026 17:52:51 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sinfo@kernel.org
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Ong Boon Leong <boon.leong.ong@intel.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] stmmac: some XDP fixes in XDP_TX path
Message-ID: <as0CUyuWNOrV4WPP@lore-desk>
References: <20261012-stmmac-xdp-tx-pre-fixes-v1-0-05fd0c90f7e1@oss.qualcomm.com>
 <179181904740.2527009.16307700795539761723@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="or10+gSup2yG4+kv"
Content-Disposition: inline
In-Reply-To: <179181904740.2527009.16307700795539761723@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2MyBTYWx0ZWRfX8OK0kNHExBAw
 GP7OyPW80g4X+NWPPk3yO+UBgQc3xOf8gWWEBZV4bPG9sOevwHSEIehiGDATTmLd8Mvh/AHwKkj
 qAxmj1/ToyBS9eQJSc0pK3PIK5KmOn1Gs43eNTnJ9Eb2XqxR5vNMtxnyLSMrorP82iYGOQRKt87
 xIst8NR1wCBnUGJWmH5/k5M7LT3zGaqNT9SPLAQ/kV8lGxWo1AgE9BUEaDNPxBKjMMMjx58EtJV
 vZMHW3IO/f6HFt5ENW9bnutbIPjAitYQNJB7e7qFOKaO06Z0LHc15Ht3d4iNyXmYBVluNkgj8+F
 UeGFKn/7b6N+ZDu2VVXZOkhYLaVHtOprp8KMp40/Ww+byAq81b3oqZDxgxFo8UAkrN/JtOLtrCn
 S9iRbZgOOf8feSes/isx84JODYS9VPvk/Nq5U3PzHiCLX/gQjfUxj6Ilu+Pk6gE9dv65gge+1pq
 ajrov/MNaCBOLP58r6A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2MyBTYWx0ZWRfXwEZAdnkmfZA2
 dblTgFfN/ikASInCTJTfFWImfCxmOSKZEcnLUrzJSsowjeedreNcaX6148zjxEHBJWvlKNyTtwD
 vJh48LgYecn1TIJipWMxn0kCB091Zck=
X-Authority-Analysis: v=2.4 cv=VOtIDNPX c=1 sm=1 tr=0 ts=6acd0257 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=jeKYxtEjmYGD5WCmXysA:9
 a=CjuIK1q_8ugA:10 a=aJ77pqhsylUep-8PoN0A:9 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: wIK0NyVXNMZkHCEQ_AM1fUna32gclP6d
X-Proofpoint-ORIG-GUID: wIK0NyVXNMZkHCEQ_AM1fUna32gclP6d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120063

--or10+gSup2yG4+kv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi!
>=20
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>=20
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

these issues have been reported by sashiko.

>=20
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

they are real problems spotted by sashiko.

>=20
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

I tested them on a Qualcomm Rb3-gen2 board.

Regards,
Lorenzo

>=20
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>=20
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

--or10+gSup2yG4+kv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCas0CUwAKCRA6cBh0uS2t
rNW3AQC2/QeMrn5IqfOYKh+NSNDgIXxUvz26WKNJJ4xN0lVxgAEA/W1AUeFJcriu
MA8eHjFtt2TSRtfyi2A3pmw9qVuFYAE=
=Ixfu
-----END PGP SIGNATURE-----

--or10+gSup2yG4+kv--

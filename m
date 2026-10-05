Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855AF311C2C
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 07:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791186206; cv=none; b=uC6mOebBzzndWnQVv+qa51MpeAHKNihOkjyqTMjLHuEpFoDyqgNeztUJaOLJ/BnNXm975UA3p1yvi1thIS+j2v0V8IzIth5/hrJFc95b3kBB47Ayqq2lYPcs+mojuaxFQl/BajirizgNPtrus6jaOz5jEOIazyN6PvUDh0rLxfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791186206; c=relaxed/simple;
	bh=Ip4Tu/mP3lKM3A/zvaVsHeRMw7G+0SLFeG2pKm0nf8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1esL58Mq6r2st0qoKO3G8k96xq2nMr7OB4fuZTyM9IOMO41+i2lwjmvFgsBsQTMRIgSyo5GoDXdR4ecrL8XGKJnStqUTglwRx+PWG3q9UTT4f7hsn9HzEWqqzB9NYOZooaenxIq8/JzUTuMivH0n/L5FYSNVDwvAEK7kixBwfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n8DPUBO+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c8cB73bm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n8DPUBO+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c8cB73bm"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69510bpI788386
	for <bpf@vger.kernel.org>; Mon, 5 Oct 2026 07:43:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=h2zW2XYrhteEZp+tMcr1cImJ
	9lxTvzZKtBhMT4o9kFY=; b=n8DPUBO+IKzrhykk60ivyIvwjSn0HlGsZfsZen0H
	7PsAQrmLqbN3KlFLzkaLGnYUUdY/f1X91Sti5663Wm6tLKzfQXq4bhUUdeR9mGm3
	YW3Mky1BH8HicxUZvuKRkqT4QMqeBlfRig1EnfvZVgmxZIDnMvZtndpuOz5rK43p
	5h4snJSZkK2d568mbskD7xKvBsp0fPgY8QTNm+HcgP5B2Ha1GXpQDqN+liZJXDP5
	q23uXHcvoqMv/uKaSpxf620j2N/WvZtqYgkdYpaJrcVK1zztHwRuH3ZmYf+ybW7r
	fHZdH/3C164EmjKyt0P+c53KHrjY2GC/s6d40dtAjalHNA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2spa4ydb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 07:43:24 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-914321eb48eso23904366d6.3
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 00:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791186204; x=1791791004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h2zW2XYrhteEZp+tMcr1cImJ9lxTvzZKtBhMT4o9kFY=;
        b=c8cB73bmPFnj7ZlfwTE9qkSjm3CttguseuJE16vmepwaVG0lFyggpAvtgTlEDIWlj+
         SvePWDKLUphxeyKe71UmFrMoED7v+AzJCA2UEqb8Zkfk21AQ0mqF+Z1wMzWzs+Oo+7x5
         zrsjh5nO/YLGlgU0ir21WGDA3YJIlUg/267MIsO67Eu4sNJY5aWSi3oECxKI5KtiGjwg
         dsbVY+0TL64JRV09BaCTobNk89zjtfjFpbtUlzVXqhJqdEIGUK4dtnSJEoIxtwiwxZkJ
         4ufRXYRDX+DRvdpxWl1/l1I5NnvCvpHnXXhVAOFimeeUR6gpKt0SXEPdy7FA23KfrHke
         wV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791186204; x=1791791004;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h2zW2XYrhteEZp+tMcr1cImJ9lxTvzZKtBhMT4o9kFY=;
        b=iEyRUTiecqF6ysJXL1LwbVK2IiEb7fij958cCqan6MJy8aQoCAiW/q5S0MNvoCrqpp
         /y54LnXdTdCWtEKlfemR4rudH0WcHHRjyZReJB1Jf5XXCbUP6xd9gmRdlVGlHPb5e0fX
         g1aRBsxZUyq/CjhY/Vka1vE3BL3wWTwPsXhJiN+vFqumeGHUo4oIxFKp+wQBCkTHYrkw
         OY89VaumR9QshLn3kXkvF+vTj1xb3o51rUApv45Q6Azz8mRVv/3MLSIsaqxL+tzZhnRL
         kLpb+IPeVhEWt/Ah/aBmWZnlPQF2osKZYNaIiu4AUr6LZfmV+K5vBB7HvRCjUhF3iA3l
         unOA==
X-Forwarded-Encrypted: i=1; AKwUvBwTAl2ffwMQbu02dMbG2q4lUBCl8Qj0N4+rSNgscfKEl0TRnWCu/yfAfX7xERY8MgCjp2I=@vger.kernel.org
X-Gm-Message-State: AFuF++lls4Fe0Z1NuWKZZhwMZE7WPz6lxsRXA3ygTujeDn98+UU0FyMG
	B9L8YeuhUc2ZS3S9K1PiNp1JrwJe1g10VKlehCoT/eohzd2F1Y3/JzQGQbBFmir8YU9u689EZ8Z
	TWG8B52PAqY0w3wzjjNsLC5Qzh9NY+sdUOrj89bAnJe+kMtbKxB5J7qI=
X-Gm-Gg: AYBFou0HkM2tsY6B8hPL4bHkHzFpmzMiC1gu6VYuH1cARCiah86gZpTOErMwsYEqM1h
	dVCSB+n+LuS1u0Gqq0fnMkk2K8rA1Aq5Imdv72iEb+5xV7PESnEgMIVilBwQmbE/eH3lT6+ZVDr
	EoghALTm0y1TxoqjCbSCT8acnPLuBLrwvhCgx188/GPqULafDC9gEMUfaFiRBAP0YifDZWYxqKw
	PZKOHYebWXTYUogM/IyNRYX6ktdC3CJbZPjHKW2Gss0ZOtoClEHEugU9x2KoPbSi7GLRr63BABx
	VNd8VGZkwJ3TRzq8UcrO0WE9H99TwhnIdhUc3Xt2SXYuASM8hNVXJX/lBY7qD2YNhO4xyozXVTV
	H4sVmV1TX3bXnDA==
X-Received: by 2002:a05:620a:1727:b0:93e:5fff:db01 with SMTP id af79cd13be357-93e5fffdf99mr824218485a.6.1791186203476;
        Mon, 05 Oct 2026 00:43:23 -0700 (PDT)
X-Received: by 2002:a05:620a:1727:b0:93e:5fff:db01 with SMTP id af79cd13be357-93e5fffdf99mr824214385a.6.1791186202794;
        Mon, 05 Oct 2026 00:43:22 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c622bb172sm3783113f8f.42.2026.10.05.00.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 00:43:21 -0700 (PDT)
Date: Mon, 5 Oct 2026 09:43:20 +0200
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
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        James Hilliard <james.hilliard1@gmail.com>
Subject: Re: [PATCH net-next v3 0/2] net: stmmac: introduce XDP rx multi-buff
 support
Message-ID: <asNVGOmmQMitsvGe@lore-desk>
References: <20261004-stmmac-rx-mb-v3-0-50fa171af9ec@oss.qualcomm.com>
 <179114695065.1402591.17659606391395950626@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9uROaV1TaSjXnGB1"
Content-Disposition: inline
In-Reply-To: <179114695065.1402591.17659606391395950626@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAzMCBTYWx0ZWRfX7hFjaGBY8Ba+
 T6w3Y673wGJirID1rDQDjQWBsXOxQ3VC4VAj65yvZQ3FcEWgi+Nj/jYeDgMK+I/A+HWIs3Fdtcv
 s0DzDuboiI1spqHRVhic6UTDyUGeInIs+M9khs0IL3aNg8gGoBGll54kXN4f08p7V0RiR/Iy0cx
 NF8KsJ6lLlpLTZX5Y0jxuoLGwSauZ1CY6/9jqbQfKHQUeq0Y8MxWNlMOQT9dxa4LgB/E9/ZArQa
 RcZN8DsNusF1RqCqwjszuMvRtMdWiXwmxMcAlo8FM4XjRvhZDe7NQbhRADBM5ccW0/GIY/ij/3J
 LIKrw61x8921Meduak2K+4DzVpYiXie1MRulEGNntNFI80ky8QSphCxBIi8vAT9HQXa4IKbNps7
 SfvJ0JcXdce/fe7SJrxeecj6MF4XRRb7K7CLj+zRmzVpSCS4YKpNSbF+wkEER2VycerCNBqdSkW
 tTiQ4aV06JSU4pF5ZDA==
X-Authority-Analysis: v=2.4 cv=b7MncdGx c=1 sm=1 tr=0 ts=6ac3551c cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=jeKYxtEjmYGD5WCmXysA:9
 a=CjuIK1q_8ugA:10 a=Zqq8r-utnCB5I3cg7E0A:9 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: L-NpORAGZ7ml8Wp_SqnlR7yQxvjz2Mz1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAzMCBTYWx0ZWRfX7qHwaBKcxTmD
 6pL7HP9dtQ30qXh1faKjmezux8FDPCTB4KC2r6wNu4uqmfU2VptY5CJ+aQwJfABkocDYqhLZ+Xx
 lSXqCtjBfLSzTha4WEAHDpUv+gnIjCo=
X-Proofpoint-GUID: L-NpORAGZ7ml8Wp_SqnlR7yQxvjz2Mz1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050030

--9uROaV1TaSjXnGB1
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

The issue was spotted during code development.

>=20
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

This is a theoretical issue found during code inspection.

>=20
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

I tested this patch on a Qualcomm Rb3-gen2 board.

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

--9uROaV1TaSjXnGB1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCasNVGAAKCRA6cBh0uS2t
rJ5sAQDtfUGPnyWCkz+pj7JZxhjd1ga4M4qD7JZHsy7lZp0O1AEAtt0ccBSxDqoo
94s3FWJnuvbD7dd+a1MlgpW/uuYGGww=
=Sts9
-----END PGP SIGNATURE-----

--9uROaV1TaSjXnGB1--

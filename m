Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B88F3D8104
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 09:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791279746; cv=none; b=bFcygJ1clHNsbq4/avU4EX3huAIvzpD+nkhmUXVZk/6WNlefZeJxJJxMoIxG87WtyfQeMahyfjUnsNBsAjrMTb+1itntCs1AscgWiK/uKsPxMYswBYHD0T5c7FoFukvSKMn4Xj2kJR5zBNPEZbm98WzKU61lBXo8x8F0OAxODZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791279746; c=relaxed/simple;
	bh=N0cBn/U5phHjk33caX0C+8gh9x9iMzSnCbasLzRRcEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LT5ugbcpTV5a0XNXocH27HBvCjolazaQIaMFmwO8EOeRJ8bE5Ido4J9knpF1/5VflqyIBMzAVFFSnXyfxKQwsF9GmM06mkNsgmlPYTfGsO7Vv+7nkHhrKsU92cLTHbvTTEVX4lnBiF2Ht+lGbhAbwgsYl383LrJowt2+ZR5jx+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JAMvpwAD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PnUE8zGw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JAMvpwAD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PnUE8zGw"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6966eDrQ3269514
	for <bpf@vger.kernel.org>; Tue, 6 Oct 2026 09:42:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kcOil/NwtMA68u6bwhNQDlDq
	9DYU9sJ5Fd/m/3qw0dE=; b=JAMvpwADuXrLTUegRGlnTjHlueQHFC0euuqJquGL
	D05bY9Eh3b2UpEWUvXHXhd1E9Vj4MEgiAGctfWGpk2XrscciFmQE/g19uhIEaz+U
	GzjdntXXpE61qJAJVHglA/OMGfvdZMWObm1xleHT2W53A5ikl0C9q4r76dbNMnJt
	O99AKPrtup0WIdbS8NeuVTZ5kFz8I7Tk/T4/s+YOcszJ/I/uq63H1QhtgFB0hEDC
	ZWfxnt7TUeS6R0OtYlaXu0z+JvRnW5eZynBwQuyUhkYCz3ndwVamAXEDP1pnFHCr
	CWgvuspiOk9fQ6DWhWal49RlYivZU2VmuN2uuNtaBERCyA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4fkukac0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 09:42:23 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cb7f9bb86so510289385a.2
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 02:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791279743; x=1791884543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kcOil/NwtMA68u6bwhNQDlDq9DYU9sJ5Fd/m/3qw0dE=;
        b=PnUE8zGwKP75GAljOCehvFYzt5xSwouaCY/ZAIxhT29c6Cb0RThMbqGmhcsZsJbxxY
         bPAw1kB2pTgD1CI6qBfAdmDh/dN/l4nAzgILJFfp+xehn/x6iJ3qjHdvZbSGUlCBQz8+
         F9aG6+j0FcrZ2azvO5GFKSjRwF71qHmkicUkUmqUUGxmL6jXtGFxt8HaIarJWAsSIqnk
         NeQ3jmRIj6ei8xEn0PJ6HjjQ0FF4XQAzX4PjYrslfoq0f891KXDNvxaJU4xWzpRlW02N
         d2JoQhj46E59sDyQ4r1+aiTFFIoKV1VAL6AVzfRnvK6OSzZDmH6foChcggQa03gJXUrP
         t1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791279743; x=1791884543;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kcOil/NwtMA68u6bwhNQDlDq9DYU9sJ5Fd/m/3qw0dE=;
        b=24GCiDQRtpRQGJM9pLXrRmf0botvAvy2Ma5gLn/vonjgYeZ5Xp1tvBZW4pRQIHOmNn
         gsMPL0gA8F9gUH5dPzNgh0E2JifuCfKmqejJPcquv/Y2ASbs3THI9MXcp6091vE8fWNK
         7Wo5nIevQNhU/yGVS3Iasxm0bOtEz/clDvgZk0TnvV5/kf78grH0Ozp7hzkROh5Uj9NB
         BXB+H8owzF0IhUtJfjD8V9tN8ixC1utImwiu7ZKsi6K1d6LOmZHJ2WUErHE5WEHW0RLP
         LfA65H2mxWd9agP/LwswimChuiRU/oSHIT5So+I4sNplTt3xWKuZz/BDBKxIdHl0kqSg
         b2Jg==
X-Forwarded-Encrypted: i=1; AKwUvBy/Ly6VpZZdwOCRY1H3zstRu7gP+goH13l/tsQrLbTEjU1Nl4K2M2EfykodRt1mhTSt/8g=@vger.kernel.org
X-Gm-Message-State: AFuF++nOu46rh0cwFzmr1w8rZqtq/su+Pr02IHvoHd4CEBeTI5q5ZMGh
	5RxOSvAqbiFn31fnEeAXPlBjUuZckXYXP1FnC33sbejQL+u7A5VxMGASW+CPZLPggH1wj9Fos45
	dJFoMJGGKHyx+w57xTRn76D8zTPps+H0iYWGTlsKRXzMPvM8Z9bKmAoo=
X-Gm-Gg: AYBFou2lrIbjnljD1+gIzmimZzvI8lGbw+rYbW2DI50QpXmJHrAP0GgsxC9EF9oRa5K
	ngB4b7SyNgQrWWzOI765gmB3lPwN/gaxJBAh63wp5T0YTqDJs/UV5YCyF2zFGQqSwgfaxCKL66z
	tgdKZiEEpnrq5X+BcxZMkhRvA1EBZ28fmOsg/Otu389bgvErtzfTqdhngprOwTh/LLp9Dg1+ih6
	kySkS8boIXFcp6m++h9AP3FXQx9Ct5dS0OYTAw/aA/JOxyqpRSmNV/dbDUTgN/31xBwrSVdOghu
	Cy6PnPdcL+//ftLcX9BZ3cQJEbG+1OhObL7jIU1+iX0vzw0madbEnWa9kKhAw63fGfRInMocOmo
	D/P0rNosignf5Ew==
X-Received: by 2002:a05:620a:711c:b0:939:4b31:4669 with SMTP id af79cd13be357-93e8f35d7a9mr140704485a.29.1791279742556;
        Tue, 06 Oct 2026 02:42:22 -0700 (PDT)
X-Received: by 2002:a05:620a:711c:b0:939:4b31:4669 with SMTP id af79cd13be357-93e8f35d7a9mr140700585a.29.1791279741909;
        Tue, 06 Oct 2026 02:42:21 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c6f3a36dfsm639859f8f.19.2026.10.06.02.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 02:42:20 -0700 (PDT)
Date: Tue, 6 Oct 2026 11:42:20 +0200
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
Message-ID: <asTCfOqNsv7fhX13@lore-desk>
References: <20261004-stmmac-rx-mb-v3-0-50fa171af9ec@oss.qualcomm.com>
 <179114695065.1402591.17659606391395950626@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2Bgar8i1ZwHvrwxx"
Content-Disposition: inline
In-Reply-To: <179114695065.1402591.17659606391395950626@kernel.org>
X-Authority-Analysis: v=2.4 cv=HtPjiETS c=1 sm=1 tr=0 ts=6ac4c27f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=wfrYX8O7EWgUh0Dss7UA:9
 a=CjuIK1q_8ugA:10 a=edXyOhOlrqVGcbvKT0AA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 41z5ws-K2vbjyVjqtvIrHCOh6YT_fiQC
X-Proofpoint-ORIG-GUID: 41z5ws-K2vbjyVjqtvIrHCOh6YT_fiQC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzOCBTYWx0ZWRfX03mTNUI0hTVP
 OFuXV2zL2VVO9oXSrXSppLsaW/4GjvWkgijb7UcNKylRPdRcg8CtdydYEANbZ64Qx7sgbAM1SPo
 0zK1Maspq9T1DSFNT2HcKaF39isqZVA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzOCBTYWx0ZWRfX++Shbkm1IvXx
 thkxDoHCGPIJmriV6Mr7px1opjB7gXrqL1unElKCIhrywoa/tEmdgb3LpBbou5+yjWfQLjkHRGP
 Hk9dQGsqPum+9aCi44j32sGQAPk9dkI4Tw1rvXCVEJ/aAswq46s7YnV9A31MVbe84o3oYIN+mQK
 TnVmNP6crjbs11S5WU/2egKXy9OzrR3yIw1OBDLFuo39Qu0Oke6zJPQY/d/JZZno0rKa/lqaLQH
 0V/EjlJa/wlGwO3i3r/cWWyfgmQgpSV4j9lI0LhP7fDcDyP4u8VGXHb+I0QiQnOecUoURjmjGhN
 j9NiANljTl4g+CgZng3ncQNUMJWqqiEsMYFhYv2jLwBc79CGzyI67udbjK3iDaw6wXCAdBIIK1V
 9aVheMxUpPfUWEvwndFpdBmEtSuzCW9x/Bg2ZTMHS/7K5ph3SbNLCqKLHnhs7ejimBmaBhAbTTW
 8JdVtJboIVH6s7rThVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060038

--2Bgar8i1ZwHvrwxx
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
>=20
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>=20
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
>=20
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>=20
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

I will fix the sashiko's reported problem in v4.

Regards,
Lorenzo

--2Bgar8i1ZwHvrwxx
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCasTCfAAKCRA6cBh0uS2t
rLkbAP4wA6iHjzlqIoQ2A2AtB/Sq+wGDHsP23jOQzttMk/mS/QD+LC7sLvYYF00Y
1excpxc14pI3OvMuh5vX1oy3OHdsCgk=
=2/xG
-----END PGP SIGNATURE-----

--2Bgar8i1ZwHvrwxx--

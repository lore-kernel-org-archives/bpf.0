Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793625648;
	b=CxXsafqML2nrZC39qsI9iVngNqWalBeRXPGVE2tZEUprjVbplxCxTyQ56ceu8RvLgNHV
	 Dj4SOF5gHpWIdTOQI3NpFs7HD6hiRoDmDnQ6zqnVPXNB6gRu4Xfc1rlpBCFJJxbzcj2vK
	 WZhoydmF4lY9pBeG0XkkxBw8J2fuy/TZ5b4WgDmrD2ECea71Yu1kMu/uZ73eOhXecOfjI
	 n5Zavrg8+w+xRaK5tUKtkq7RWBvkKKeLwZM9PJDagZYOaOtMEZYP0AOp+Cdp7xX0TfWus
	 mHdTN5RhBOm1BjnUF/35aqBMBP9Ory/CVj21zH+syCs0NCYQ6dWqd9cL7E2pFbMMGvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793625648;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=KlXD+aOR63c/FOljEMI3DnU5RwdrA1mGi00aGRNoEI0=;
	b=otQ8hWVu4CJLY5SPlx1qoz4h8DkFQj21PuYJJe27PdP1lckoxI3t7mNb6TZw68t0/sgi
	 INGCMbKM96CXfjp64eS+irTyrM37zK7REQg0k8g53sUrnD2sAzUk11fHw0BA5rggCn4yy
	 osANOebiGGh0P5o/fN5Z30aEsiHdLh1cf275ZBCZfioxNsE25Ys0gA4ykjC+NLYceKJCA
	 zataTUVBQq1V6ueOHKFHIKv7YnLqqViQfC7saQWveC4QEod3LjI4Tsm1PcsedOXsuW44c
	 u+tDyv4pO3fAzj+/j4cpY8lwZ8thd0s2plhVu5FupOqd3cMCvtsP19pQjdWRGh0USvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Hp39N+GV;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z4jJayBe;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F60606A326
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 13:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94F60606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Hp39N+GV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z4jJayBe
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DALfn388214
	for <bpf@vger.kernel.org>; Mon, 2 Nov 2026 13:20:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KlXD+aOR63c/FOljEMI3DnU5
	RwdrA1mGi00aGRNoEI0=; b=Hp39N+GV8u/o8iM+5Myo10stt656PODJcvKDZxE7
	JWSrdiOFqnM0taNmJ2WLDI1yBnsflmLiOqu5nWXXPBDNljgh4vDtt99cTfWdclj2
	iRjf2t3wUk6r0FCP+gHLTJy3CtwADEjbnsFO8SCW7Mnw3p2odyJiHX21Kdv/dl0V
	Q9ri2/YP9yBaUSsFeRifCzBsYyu1IP4GVpq1U0WXmdKRdKWesfrPKami20fCdIcB
	br5iLA/1ICURZPPV8hnL/8P3yadRhZlhktl3bRn/SgDx/5fqBJ27PUwJuZjOdDFo
	Ld47SFfCV8Jh2kQeuc7CPRxuc1n+DwpZikCIhzMMZb8DtQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpph1993w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 13:20:46 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f322ef7d3so564694685a.0
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 05:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793625646; x=1794230446; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KlXD+aOR63c/FOljEMI3DnU5RwdrA1mGi00aGRNoEI0=;
        b=Z4jJayBeCpCOB+DmqGIDXTa4403oNvghHKRFf76XUf8NcpmUFf6ZAbYsFZKp2znIuN
         o96Fn/3w7hgNu9mFt5qgmmo8T0loybUO20sGVRlL0b+oi+A3yhMLAKmqQVzHXlcLcw/w
         X3SlBuOckpLC8LRqkeqcxoWxE/8zG6PSaAk68Bt8MlpsnBqxLrKT31tc+uExT8grpRzB
         UignzlsJi6Jc2Vi6sK7cLJtFPEdM9mkDu/dzC9zytHpbzjKRMcKONQtVMCEsL8nPO7Hy
         XhakxN5p/12h9xroDwnk+IdUlT9ufEgn89saA0HDy+Mxwmi4qhJr9M+TEPEYHXxEmvDw
         BLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793625646; x=1794230446;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KlXD+aOR63c/FOljEMI3DnU5RwdrA1mGi00aGRNoEI0=;
        b=PjViQw+1CbRlf7JxMXSvHWXgv1PZdZaz1ZcwzL8ZO40JYaYtzMMjC0tU0ryJBptEJs
         aZawn9NtzDryxTHutCex0T3VuptmCZ/QM27xltFIUgR8LVUphpy41aZFTmTvB6j/tRxH
         jWAju5dVDYfh88h4ZVlZQx7l7hWnwWTlIgDQJHd/mExtT0tb8VnV9QlMefx6ARkA7e5Q
         dNIBdlA2Kp4jU+3m8Acf/mVC4r0ftQa1rUkSOYHUO0lmFUAr1Xe2dQhkwR9hhK0AwkDy
         cHqpBbG0mdmsrIyQ+JoTHLKiGuuw3tlAUwTGY+d4YwcRNrN6BDJsLCwikO6F/GACRibC
         M0sg==
X-Forwarded-Encrypted: i=1; AKwUvBwjl4tN0v3S1buaqWSzaa2P+DqwOXy4NMhvLiAAel5+AM7Lr8niDR8/E9eGATVP6E+SiW8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJyR1lh2/NuGxkWoSm/lm8JZmOTFV3Quymw9B7wgk0mA5JZiHNH
	TE6w54SwyC/h5Vd3TA4ywKL2fbLv69rUoLjRnfXLY7jfT+RB/O/T8OHT0ROY3CuK8eSv1JK/bVk
	3W0tTtv9EVhg+fEdVpCDVPpCXtpoN/kVOa7qu+bOYsTlbqzKMne2psPY=
X-Gm-Gg: AYBFou2FnyzeqCa9yYNrwSMKON4UhOShoLjaDmGQvhyDuUI3NiqINZQ5cuKOzsDhPhI
	HCe+0ex5LzC5TOUu+GEllKVTkt9hgEfH+M1MpkZ3rZbY4U5NYXgp2mHfI8ahQtvjwR0uA1l5IIF
	Y0FU7Xei3sDchSUZCwqh8JzMXFvxrXuf/vtVZLzwsxfi35yzKo8zi0d55+YHY1KNTlkkDkL87kT
	4D8PvD69pBbVXeTba8zxCqiwt4tW8PbdfnV1964fEMKk4IAlWdRK49g8LX36OCFPtU/IS4ESWUV
	1OIzMNQMh0wpkMlSleK5sa5f4BosAHSMOM56xZfO6PaLPOZGYHOHfR9vxI0ZnQ/7DUX2o6DLQ3p
	mKLUrZAfsdvyVk0Tu1wQeun2VD6UMBN9rU4Vbn3e05OjyMIh3zd10I1/EZnRkyg==
X-Received: by 2002:a05:620a:618e:b0:93c:6e1d:96b4 with SMTP id af79cd13be357-944217b4de9mr1533408885a.62.1793625645507;
        Mon, 02 Nov 2026 05:20:45 -0800 (PST)
X-Received: by 2002:a05:620a:618e:b0:93c:6e1d:96b4 with SMTP id af79cd13be357-944217b4de9mr1533404985a.62.1793625644858;
        Mon, 02 Nov 2026 05:20:44 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ad414e298bsm125215315e9.2.2026.11.02.05.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 05:20:43 -0800 (PST)
Date: Mon, 2 Nov 2026 14:20:43 +0100
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
        Song Yoong Siang <yoong.siang.song@intel.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: set XDP metadata length on the
 page_pool RX path
Message-ID: <auiOKxu4PY2lGgkP@lore-desk>
References: <20261102-stmmac_meatada_pp_path-v1-1-d93cc4f9a864@oss.qualcomm.com>
 <179362019361.3286.8732260602904932373@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hEQCQpva2igBtHcT"
Content-Disposition: inline
In-Reply-To: <179362019361.3286.8732260602904932373@kernel.org>
X-Proofpoint-GUID: KZbsalTkr1ueXha6qpodORQX-L_VBvBv
X-Authority-Analysis: v=2.4 cv=IruL47/g c=1 sm=1 tr=0 ts=6ae88e2e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=jeKYxtEjmYGD5WCmXysA:9
 a=CjuIK1q_8ugA:10 a=Go-FRpC6VwjTotnDkukA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: KZbsalTkr1ueXha6qpodORQX-L_VBvBv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1MyBTYWx0ZWRfXzDOaai6aeFew
 rCNy2XHSUo5Rswgvp5V+X0aAmvsQdS/n2gI6pYtqENid6iXaHFz7OAjl0eJo7WSxCyKOqunM+6i
 uPVZpz807B1Tkr8npLmbytxMIR58NV+ND9JLeN5Db4R0R9WLpeFh3wBjwuXh82F5phcsgXwiDI4
 faQ1K9EOb6j/mcgwub7ib2sRd2MS3uXXZgVyvKb8VMcYy6+1nI4rA1J7sEsgF1Fdc6PThhoHY1R
 cRBNk4J22ETY8wh41gpwJDnICT4cOlrYfVg/WZNEKDaN5u18skZgLSg//WyLzZHxbiQe0CPuMUP
 SWrRcI55BBQcXfGViy0TsYZN4XzgObH686iJgNw8DuEjbsNC20cEVKNA4lqJBMqX8/0XDHJ/ymL
 zzZDoMtb/SQgpbN7O0l/3XNU4cVDYl8Qlhfyja8lTS4THmfl1duEYBzZnYopOu+bhLE2DJpXTVR
 HTI1RoU1dVqH4ascGEQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1MyBTYWx0ZWRfX8c6uKJtGCfG9
 t63RekseXKUmuhzGEUPW9fZjN9PJQtoiKu9iofpnwLTSLbv/d0aHNMqoaCINKPZMK5TnXBCMWTk
 dngPLz2L2iafgVdnXIoG6187g8zGL00=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020053

--hEQCQpva2igBtHcT
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

The issue has been reported by sashiko

>=20
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

This is a real issue found by sashiko

>=20
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

I tested the patch on Qualcomm rb3-gen2 board

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

--hEQCQpva2igBtHcT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCauiOKwAKCRA6cBh0uS2t
rHRdAQD/v8Dhm8FIwTs3wowVw2wCikCGentLt6uK5GTW5atbhQEAz8EIXwAcWJPJ
sqI3crlBL10HzgL1B2U0IkCcfwTQngA=
=Z4aK
-----END PGP SIGNATURE-----

--hEQCQpva2igBtHcT--

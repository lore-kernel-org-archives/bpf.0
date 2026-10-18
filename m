Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0703876CC
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344004; cv=none; b=PWnHZw3O1AE2FSNwLemOvyjfQjwEGWFjB4SVy+T3E7nnLq+6m4RG9NknC1e5e/oecpDzhw9PZqJPl5X6QQ4DxgyShDFF4IvJC7MoaGhfI3K88hVtZbYYsSXASNXnL/9gfClzQTOdC3kZgkv3Ncf8DQ7AVLXWLM4ct5dK6cnxYsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344004; c=relaxed/simple;
	bh=5CHyBq6+hpt82CrYxDzI8fviha4Yg/+dp2ZyyFPEx5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIF7hRzldH7kHlW7gAbFScU4vPitd5VvvmVSLpkH+b/6aBS6kuA3w5decWeJgbwFrXTqVXCQE/RMwP+LX42zKb7G3VLXG5V6bR+StfgmqC9MG3+uzUrUHK9Sp8n38xZveRTZp9KlDrxiP0SGggqAT1Xkqu8bSFZgepxFXFd3kOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i2FtwSGW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CSRb+YGr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i2FtwSGW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CSRb+YGr"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69IF7dRh1158222
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 17:20:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=T0p+EIzAf6jC8zjKtsjkjlrP
	wlROr4CztFJTT33WVqk=; b=i2FtwSGW8MYD3I8B6nVJFFiB5dVUYIUDadrih8zK
	VHgl0NMp2nHbu2ek0fGkxNqFJOS91wSOpwPQ+RGnjnJb4yeaw6wURDsWITqUy9kq
	tkRcVIX0su71SVgXE6R1U5Ug+hprBHzXyIawRzJBohzV6mmwngb7RBO2nnOSSJsK
	AwewnhP4MqqMF7ZdztbTQycGeB3fjzqHuOW5IMiytBeNZZSvmb0pZpo6QestzOeY
	RRra2dLBoSyzERCfFmb8ifsuQI1MucmYqaSa1IqUV36NSKpIgwFgvfwnDwdEffDF
	bAUsDVzsEzaJBP7oRf6ekU1vNRLeMoTuA4HpJ2SHcl85Mw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbxqfuu7d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 17:20:01 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f2c0e6653so250158685a.1
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 10:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792343999; x=1792948799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T0p+EIzAf6jC8zjKtsjkjlrPwlROr4CztFJTT33WVqk=;
        b=CSRb+YGrc9saAoF/H34cVnrLZ6UWU/NBshxE8NjHb6bd/mKbwqUd/wd1jjCGUEdCaF
         al1szCYRjBaXz1JkIAWZh4Rg6XxTwSh3ZiUhbzsH+/QYFtdr6X0aTMR+Xm4ZJCnhlTVn
         PyBh42U0LujolCAwedAVNR5AIYU3WIEEdPMmH8UZOyHG9grnv/XK4oP0CxewUEWni5nV
         lEnHmJyWF7N8Rbsz1gnrranSuxT21WGFzxZuMNSj5zvt7VOmNYlV8CYY+5RN5dyzWsXm
         t9LYSOP2M949stOGhN6IMb/CoDaaLIY0jCqzN2uHqP+uuJTuYlyFcUlo9O5V8qKZpvy+
         8Pmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792343999; x=1792948799;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T0p+EIzAf6jC8zjKtsjkjlrPwlROr4CztFJTT33WVqk=;
        b=jjE+g7RZjdltbZ/CbermtVTlOlqG4Mbmotx63igLa5t5fHVStCF4D8aeV3QF6R6qCO
         MjD9ZAclS2+6ETc0fC2gwzlQBVfo5Pk0xVGM32x83R1+ri7g8JGrI2tivMRVYkcrgZeE
         wdB7ztyKaKAfQLJT2O86QE/yqnf8/xllbNi2Fctqp0emEFVc+guQuf6i8b56hKrlgV86
         c/xqAP5Jbyg0y47VUvMqUSHoOzLlD8ORDBBpTu9xQ1BEIwXxyFT8NlfkVJGGTFUMT5Ab
         TQu2Mw4PZr2BZ2zYAsnbD8nriaOB2Hg1IYwUbXXOVM1C2lMDAy5/mSyaHx/OS2t+ZTMC
         pEaw==
X-Forwarded-Encrypted: i=1; AKwUvBxMH/g2SgrypCPqvqpSgYeICUZd2OcesttErTPPPZgpsW+cjyXcGwsyDHBj4pPP487FjC0=@vger.kernel.org
X-Gm-Message-State: AFq9FYL52ThCLaz5XS2LnilJL7B4suPzqvbVlrH+vrn3ZhwfsCbOKdsg
	KtW7NrPToRdCtAsOpcthbWJi6m8Adb68beOSyoj86Wfo20eeGtI65I1VWBWxjxGDzuEiwHVhU6X
	r4NVd7Agj/PJ6KVygbCl0DQPeoUyMTuDZuX9b7sO12pd6Apq/QqAv3s8=
X-Gm-Gg: AYBFou0MNlwSc69z74Fl2zusilKvlwALXFOlbeD8b41MG0ULGZbHC8lA4/jm8c8TLCE
	28on5q45jiIflcWa+a7/UvjGT1nqmS9kKbj5rin+r9sMSrrXp1RUWWXOooumrvS26ju88fVIgmf
	EsYZxzjb2oYx5DmoTKut7GVUdVEfGrY+9grR5lGGcaUb/5JKR4h/ARVmnmkbez/jsbaLtHGjDqk
	PaEcX/GB+cW39HCC+wKveed9yUIBP0nTMTIB7vd3nrCLd7FJ1EPhmQ9qAX0igmoeov1m2SnRC5W
	YTXNbgBZ9GxSkXokw3i+b9sHnpJ7kRyItdPBhMswnj3Kp7glzt42sPIP9kVv9ZEeqRWgqwPWAVg
	WogITw+sMb3qoVQ==
X-Received: by 2002:a05:620a:198d:b0:93f:2463:f784 with SMTP id af79cd13be357-93f29dce82dmr927324885a.66.1792343999467;
        Sun, 18 Oct 2026 10:19:59 -0700 (PDT)
X-Received: by 2002:a05:620a:198d:b0:93f:2463:f784 with SMTP id af79cd13be357-93f29dce82dmr927320985a.66.1792343998916;
        Sun, 18 Oct 2026 10:19:58 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd503a24sm18085517f8f.49.2026.10.18.10.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 10:19:57 -0700 (PDT)
Date: Sun, 18 Oct 2026 19:19:57 +0200
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
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        James Hilliard <james.hilliard1@gmail.com>,
        Nicolai Buchwitz <nb@tipi-net.de>
Subject: Re: [PATCH net-next v8 0/5] net: stmmac: introduce XDP rx multi-buff
 support
Message-ID: <atT_ve7qmxaE9ZBl@lore-desk>
References: <20261018-stmmac-rx-mb-v8-0-5f58c0b25849@oss.qualcomm.com>
 <179234329183.3290.15960565045054355734@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AgvfZen+EKhfDhbF"
Content-Disposition: inline
In-Reply-To: <179234329183.3290.15960565045054355734@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE4MDA2OSBTYWx0ZWRfXzP7tmExVUtHb
 KB8VjrJ7OzfhrOnkAS0s+ucRJ9IJEJhvYMqo0x0CQZGaTfjmzfq3YE6JELbKmhSWvxPH7SJytjq
 RKpJKRfUKqlPrM5UB34JBOJE1Nz8aqY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE4MDA2OSBTYWx0ZWRfX8tvDJqzPI0vd
 vtQ/nS6fxSg/eE7W7kmMkMsFke0Ar1MK0F0zyfHGKOJc3E/46cxnSzh9tt3x0I+KyQJbX8YrRe/
 Ea+bRyr44FyBhTSJ7pSdmFpvWgcTw6ozM3VflgMcczQjzz3vHVoeK0rUkLFxD0Qkqo1J5hEbVNu
 QB3nt7Zu6exvK5o7M+GNAGy3kH8brF3TMD9vQQ8HrWj4a11qfMbAaJmgRVp+X9HHsu6VT7XEJ2j
 U+d60VcJ8lfHwYUF7QRlKmOKtgWuBn769AnrxwxkKjheYTGE+kOnzvmUxg8tAXYlL6hFiLJsz6e
 4+cLw08PIHaiAYcv3DNM6Sp2SiStEjmv3bj39O5xGVLh5TkinvTb+34IATRtasOc4BL2L8KdM+o
 NG4+1fqTfmCZSn3VOUxgJb3aBX7zW2iaT2Wd2w1u1IsIha2gx1UQ+I3CvnwhGh+jQUcTmCo30YN
 qhEh1HtZg9vnhw9gaNw==
X-Proofpoint-ORIG-GUID: wnPC4gHECiLmg-Q3-_4xLy8-MahlXUBZ
X-Proofpoint-GUID: wnPC4gHECiLmg-Q3-_4xLy8-MahlXUBZ
X-Authority-Analysis: v=2.4 cv=RYMFmFtv c=1 sm=1 tr=0 ts=6ad4ffc1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=jeKYxtEjmYGD5WCmXysA:9
 a=CjuIK1q_8ugA:10 a=lBbZA46aXh9jGIf2LhwA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610180069

--AgvfZen+EKhfDhbF
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

The issues have been reported by sashiko.

>=20
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

The issues are real bugs spotted by sashiko.

>=20
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

I tested them on a Qualcomm RB3-gen2 board.

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

--AgvfZen+EKhfDhbF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCatT/vQAKCRA6cBh0uS2t
rMCUAP9wts/I/Spdip/Po0TyZ6S93pscCx7yjQHQeCpXz5zWsgD/XObM8IQhNJgO
JwuM9ruODNNYhXQtjGzh7mzKxktZmgg=
=u01+
-----END PGP SIGNATURE-----

--AgvfZen+EKhfDhbF--

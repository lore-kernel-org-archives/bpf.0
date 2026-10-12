Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804E530D404
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 20:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791837007; cv=none; b=sgLMEO5Wu+cUE4oQXBIRksH6zIzJ5kmiU6v0JR98gGX3CHtUqVESKBnOJRSVbtzwXWPWOQ4XI+DUs+VDwEC2sFJPIJYgJUvWphS6jcDMiIy2OF5VZSZbjtQytioREAX858ce4YLkHLmt+4hYt+93Rrh+7h824CuLnRLFdCXagz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791837007; c=relaxed/simple;
	bh=OgXXUa/f+2IQENw7VxVcuxkaXYRlSYTVwmw1zOa+r7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxd4oXemAqoeTqb8Jy6HMbC6v9Ca35MH/VT26aa5CF5L2kewiZJ4RCZ9R5LxfYyfzgrgUlOyTmQmF9GIgkl+NT1n4THJaWwNULAXpt6OYs6BfmtF3RyfEd70X6jGpRmwlVaWBHzyXDP84DRow6mKT8s4BKJT3yD9Y2IIqMvG2WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GA9ZyJox; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DOPqX7md; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GA9ZyJox";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DOPqX7md"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CJMvqw080236
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 20:30:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mwAVVDCRlRix98sQkEjepCst
	OH1RiFvVFbweyqzpRZc=; b=GA9ZyJox15J5NJie40dVRCpwKUtWlh6tcoNuBh63
	cmpinXdeADUTGHRel5O3OeZWlN+FgjDysfflNdUJlxOUcy1GKfbysr6KeyKhD99p
	AgrEfNVocbw4NSJaCLhB8BQdWLghFIq6CYLS+lZezFWIE5QlNF61nsF2FJgFT1QQ
	TXOTw84r19D94h3/ciK6Kmo9FcyHjE2Lm57GcMRuBrxcbArCmV8Em7ARcHmLrPps
	sQmapk6mQScWAZl3i2rc2gvgYAhMFGr/MK1Mhymn913cBhlNGAueq6Sz+hF6Kf/Z
	zDegDnt7URXd+PqNWeBjK/J73orDqtHhAGo7o1jyM0haNA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8uh3kb5c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 20:30:04 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cc7a6e4e1so744010285a.1
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 13:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791837003; x=1792441803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mwAVVDCRlRix98sQkEjepCstOH1RiFvVFbweyqzpRZc=;
        b=DOPqX7md/Mk2tzHHPfekc61GfF0+F/tgdgCsBfEvTTV6KJDXDbERgRf9wviEgnGlLN
         dkKDmDAKehOZbrX2pyYL0sYWDvhVqY+NpSJDsz0gA3dnKvLObOwO+D8Gb/wF09Xxaz0U
         60IuH7sQGr+eBNXeAOzJ/TKP3QKK34izAnkhZUXJG9qF1AdUjCghug1woFXZabbzGaPQ
         h9tbBCVdnznGK9V1Mj5w7XEuCXMf9gEfEjifNqLHs6vb0ZP+X1MXLefXyOmt+cqdlq1L
         n+A17ueEEwuMnqSLi6PvZdZepOyR9ljd+ARfLInyXSWVE4qJ0C+R1ffj7O+pcxxh7iut
         ugbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791837003; x=1792441803;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mwAVVDCRlRix98sQkEjepCstOH1RiFvVFbweyqzpRZc=;
        b=ts28tUrcAh+OnwwqyFupYFFaddEjOV0C4U9HGHj133euUeHjPY9KFwXjMbrDu69w9J
         B7ym7q4e4YhLmSDbwH6gDZ7xwYQk0TQLbVmphQa6/vxBefRlVyaGWq/6wcEA6Ql4SCHv
         huPhVhPfEsG0Y4tattgoDEpE1rcU8Q3TA5J9Rd7a88JJK7jhqf4xg1hrr7OcRTJCtH38
         vK0SdqmbdSHbEFyOg6Kog5ISAjZkwtmOfBEuTAmhznNHbqX2gL0o7jZTXr8J0sndk62N
         nrl+/5uAEJJVJF27XOwkRmQFq/pAGgLYJ22cKabrjXhM9/S7e7z3Npk/odSdVhaNaHJR
         wZKw==
X-Forwarded-Encrypted: i=1; AKwUvBzvBPh3EZZ1am9bcTxzAWFqCp9P804Fy+JOkA5ojE3Khlu4gV3HWnutbwGmT03eAmuzEhg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJN1g5dvKw4g+XsT82w596zfXPt6Jl6Ir6x1xlmOataSqFPzdhQ
	6HIvKjhN9fvSzdztSjHHlLpoLUePBxTxPRw28zHb3PPAFHx127a3HkW/8P4DrjqNzdXRQJJdTIs
	dA6/IfmTV0mRV0IbICCoRih+xsX2M0r751pxu4fik7s0exVQdFzc6dbY=
X-Gm-Gg: AYBFou3BRVDj8FEWjNN9ZzLYDjjSBfYAbXdoJUiW9FaQ70QbD6DzXCb/OKLbVRlYzdH
	QScVL+tOEbYHPmVV1jGP/nIM43J6zGweZRS/iZNSH3KUG5LsAKLEA0ADOrolCHmJmw6qvJQdiSn
	+K4MInWV5AG0a9b+jUc5c8BFhgMMrpR13Z4AJ1kRKqs/3LTxaN1oa5et1Xh3Ia0FaMOyjFC4j9k
	yv3Lq68xLVN5wcVQuUs1SCVsUeNKjUVcfA+n7Q0YFlyAi+1AJ50kpz87K6dIlTXaTAPiUbdhOn3
	COxo84IrZHv/8ovJ8guShfLVETtGGavtXXZdj5+JtDqKhcx7B/StJPebs+h3YxlexaNjy4WnaPc
	pwGFGscu77jsRzg==
X-Received: by 2002:a05:620a:19a1:b0:93e:653e:698b with SMTP id af79cd13be357-93ebd27d873mr1663644285a.55.1791837003317;
        Mon, 12 Oct 2026 13:30:03 -0700 (PDT)
X-Received: by 2002:a05:620a:19a1:b0:93e:653e:698b with SMTP id af79cd13be357-93ebd27d873mr1663640685a.55.1791837002753;
        Mon, 12 Oct 2026 13:30:02 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de096922dsm1001134f8f.8.2026.10.12.13.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 13:30:00 -0700 (PDT)
Date: Mon, 12 Oct 2026 22:30:00 +0200
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
Subject: Re: [PATCH net-next v5 0/3] net: stmmac: introduce XDP rx multi-buff
 support
Message-ID: <as1DSAxuXDJ9hIIM@lore-desk>
References: <20261009-stmmac-rx-mb-v5-0-c38fa4eaa138@oss.qualcomm.com>
 <179154182368.2527009.383686573505818394@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kKjh0wB5J+VbIG+m"
Content-Disposition: inline
In-Reply-To: <179154182368.2527009.383686573505818394@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA4MSBTYWx0ZWRfX14j5q71MwJqC
 p0J8V7Q15R+igN1PCgiTlGi4LA7SXKv4tTCmt5EPJ3gPlVz7UWEDUXVNZmfCVj6c2sMz+KBmS6k
 EFF8DRLbFVb03SoaRNUqUsAFlATNcAlydADD5p5EXj3B3WwwcDSsUr8G2i+/A7mTkgLwap0UpRS
 ItFUuTYuJ8jJibbYZR0+ELMvhIHMzsftdwtH14rrlkwjxw2VexFW9wyCd2wRLYfvYTkfmCMGO+V
 DnPwmJckBf79lUjWw3HnX6N7wKXP/K5nMdQHfDwH7+Mq/wkTGB+CfecvtxLtUKjRh/kUTtox2Ob
 t4ZF5nRyHErTSe7i0HzDRajAZxgtOiuERMRkAtBM41ureiFpnr4iWxjrrBQgjzBW5H/pDcxcLlZ
 4oxWdbGsTDT+rum7oY56dmHWI33/JrtrvTTycXP68vcJK7sap3IY9f7/4R4kRCFbjQCAHi4D+sE
 681KbagwbbxK1cbp5eA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA4MSBTYWx0ZWRfXzH+wvpyGRth9
 eWQabiQaEB9Vj2cOsixZ3SYYyxoCLBwC8I3h4RCiAMq+3rGmU/zgdrik/4FG2sUz31O1uJyoZ5j
 xru53fRQchTDWRVjxTO7HnalJIfIQN0=
X-Authority-Analysis: v=2.4 cv=QO391QLL c=1 sm=1 tr=0 ts=6acd434c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=wfrYX8O7EWgUh0Dss7UA:9
 a=CjuIK1q_8ugA:10 a=2sSK_cnNksaZuBzH8zMA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: QVgMm4H7RItKJ8KU9SDU8pLnNniwcsrn
X-Proofpoint-GUID: QVgMm4H7RItKJ8KU9SDU8pLnNniwcsrn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120081

--kKjh0wB5J+VbIG+m
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

I will fix sashiko's reported issues in v6.

Regards,
Lorenzo

--kKjh0wB5J+VbIG+m
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCas1DSAAKCRA6cBh0uS2t
rKejAP4gV7duzIkrdPWPXvIjqkWPfXtxyWImDmCZVcRrr7dkIgD/USVZbJLTAVU+
+L4mMOrD5VRwd1aTXUsiPcjZwQbL7gE=
=spw1
-----END PGP SIGNATURE-----

--kKjh0wB5J+VbIG+m--

Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EC25372C2
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 13:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984779; cv=none; b=fuPErFLQqsJtIoPcPs0vkOZGxCtFbeLXU2xem2qS5FnulsCcJoM5jIEPLF+UDirRhDDBcZU7ZEsqt5Mh3xktTS97i+bntRVnq1jgIxTVmYv7brI8iRN3BrzMG1zE208AreB/NwJfSfETAQhmIwairNkNbxYfYxdKH38xxBXUu5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984779; c=relaxed/simple;
	bh=0L4Nbu8du58reQkSm3StrgE48it0YJU1Ueyadr49Vfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9jAgzX1GTH5VDR/GPWVUYcCMQvuHtqcFEdSfPsjzfnr5iKT/KzPB3ptFwBa9dz7/a7MRpPMGqihWQkPA/AdZDa6m3qrwYqt5tvlNjOQu07vrcUzB7kIpliDHmGzCAsVwYxt5YJEgOWkUyC9p+xMfeparTa5Xl7MRR3v9qZTkrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UnfABSKF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H7HuHbIp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UnfABSKF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H7HuHbIp"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EBOsn72515923
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 13:32:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Sqq3d4Um/1FzAW/kUe6wQksJ
	qVemNCXMK7vcu4NUvaE=; b=UnfABSKF4JG68NRDS67n6FE6AnekBQykOL4dXwyE
	Lyv7SfAq92MSxg/NrlbJV+N22FkwrRfz1rvxBk56npO9QdUUq/VpujtVZEIRl2Ta
	nYctr+D9MFQKQ7eN9JOqCUogOh+OQC8JeUOiI9pCW9roWtHj5GlmcnsCP05PTpii
	5GRxY4+zhnTqgZdlksK+Qjb29bFX8A8MYjCvwAgbXr78RAb52zHSYJMCiJHPrfL3
	oNlOsNFMMq9MXzjw67mbd4gMyk7ImLGh/5DZwJAhXP/P5rImYvy1xtETZIjoZD0X
	4ut88kZXLGxS4yDQ95V+egmivq9706ssobJbZhFmUxoncA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha4709s5f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 13:32:50 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5d9f5706703so90438e0c.2
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 06:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791984770; x=1792589570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Sqq3d4Um/1FzAW/kUe6wQksJqVemNCXMK7vcu4NUvaE=;
        b=H7HuHbIpDSoqQRtXoS17ySlkA6yJT+LLziqgm2+A4RkVd3S3g6uiw0BWSQLfhYDLTG
         C4mFIQydKZxm5YZhIFxB6d7uRBbOEcLGC4wrk0oR57+qao22pggT5nfg8vTgX2EW9SRy
         j5x3EldNd42zQxDyl109gKXE6bX1Uu2H2+ZU6RLHv1mSKJCzZHlGqmk91h3iOgZT6qm7
         Xh+uH+Q8V6pcfJuDHGlRWSKDuiksnf2y5ZcwQ9YE3lQ3w0lu+bzbpkuZBrh9/s2XP3t0
         svmSj0JPllzZ3Ui1NknuBT2GXNbf4Ox0HhUOv5bunySoHlrRvyLLsjgWAdFDi2FfpjSK
         2C3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791984770; x=1792589570;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sqq3d4Um/1FzAW/kUe6wQksJqVemNCXMK7vcu4NUvaE=;
        b=vOHFvrbCShQN+qw2o/LFgdVJcXvetx8qimbvtm9fFfENy8JMfBdwK1bJQM/C5Entsx
         c7Z1q0f1Mbqzx7Z7NywkzVmu6QFUtWVyG0uwmLQUTurV2gLebmMaXrcteFLqS0IzQKV9
         rA7hUcvs1OpGggUelaQSKZH3et0aiCGfJyMmY6q5MAvNPF5l8tlcRiIGsaW+VufxAzms
         jmtqc6UNW2SeFE8d6XsIxMhZJKqmEHpyOcaD+4Hqtva3laHc4EQBsn3uFDMMpMK6JawV
         oBtvPf5LT2eZA6iMMUAgFQdJT1w3JOdxZHK2a7u2RZlJxqM2oICCp9aUXemUmACP0alx
         tbtg==
X-Forwarded-Encrypted: i=1; AKwUvBw2JD0KWb6harsxvYstPGOlC5ANGpYPZNW5rabtiA9druWr4RKCQztv9nPCCubIW1Skvg8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKVJ+0Zmja9ltHoeBsNlaj1AjW9VShLVP1QwSYYls/nikFWCBkv
	gb0f29LIGqM/ZCkXf3ElVoiA7gG3PPgC3c0Na8JaRGAiR5MwCtMN5cWhRgQRXE1fq0mMjmsJ8a+
	ZcUlzytGw6uiFcs1xw5379lZoOdS/D3hr7o5fQO5NVptSw82+cs1MeAM=
X-Gm-Gg: AYBFou1EitrER+z/WD+C8bceDYvUgT8CjN6eHUF8R04Q56cyQkF/tKYI0HwoNnyVY9U
	BNUjUa7rbN7zOUkEiwXBCrl54Dy0V9Jnm5BrEgnZymriQ5AiAE/LTbWF2xdXybuIl1N2vuPFvyT
	WdX8RoPL6S8f8T0/i2QR0/oVx2L+PiMKI8S441xnXnd2tJSEhzhfO16f6z71rL0FKNOrVhT5dnr
	FcqLeHgkbG+zvv+R4vzexgxQTisS+g+E5VnvhdPxkysa8fLOm9yMiNHnSFVJ8XDr/0BFiVQ5ar4
	9Bgv9C24EWN2iUG1ycmBosG7HYerhojNTkA1JkpBR9e0K+7+ILf/vup+/JlRKRC57e7rMPaZ5fn
	8Q/c9MofXE6/pyA==
X-Received: by 2002:a05:6122:20a8:b0:5c9:a60b:e5bd with SMTP id 71dfb90a1353d-5e91f48b6b8mr4332955e0c.13.1791984769691;
        Wed, 14 Oct 2026 06:32:49 -0700 (PDT)
X-Received: by 2002:a05:6122:20a8:b0:5c9:a60b:e5bd with SMTP id 71dfb90a1353d-5e91f48b6b8mr4332918e0c.13.1791984769035;
        Wed, 14 Oct 2026 06:32:49 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd07c276sm416225e9.13.2026.10.14.06.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 06:32:48 -0700 (PDT)
Date: Wed, 14 Oct 2026 15:32:47 +0200
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
Subject: Re: [PATCH net-next v7 0/4] net: stmmac: introduce XDP rx multi-buff
 support
Message-ID: <as-Ef22VEKQcZ9QQ@lore-desk>
References: <20261014-stmmac-rx-mb-v7-0-5d2d70f052cd@oss.qualcomm.com>
 <179198374828.320699.17103999780938670424@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q3kgqRgL7mAsQ/qT"
Content-Disposition: inline
In-Reply-To: <179198374828.320699.17103999780938670424@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1MyBTYWx0ZWRfX6YoEE+EyW//K
 fcPYzu4Zyi5PmBgg7/WgIzrclrHmhOrcpNcUTkFXoeATMVZ2TnLjfJXvpUVjhotOUGyKo6yYndP
 oa7KbUGil/FnDBMSm8KJlM74Sh3Sfdt0cJ6pMa9fgRQUqy6+uz1HGC/F/7EzIhl41kyIDQMLWk9
 xmWCL5wAfC15ybW4xBJVnw1OZ8oxeSv74kfq29DP/GjUY8AlA5QW3y0iazNJnDNVUejIYEU17PJ
 G88uCMy0jnol9+ZEVAv+AvdUd7FAjUHTUW3rGN28JhOvgtRi24lYjg9RfzAfWac6EIvRR+VcLjA
 Y+UKN8P6LV9dgzu2vMdkXrNvHtZXl6hYV0roqT/3XH6x7uDQRf/FJ2odFFkpqss037Sqnk7QzCs
 AzkCt3AF8EKhLqV8hd6JqT78ddLyGP4X0l91kWuMkTDjIK8lJs/KKOojAU0JAEKQKFXI7pS4Q0a
 2ebfXSTJ7+WI7ep77mg==
X-Proofpoint-GUID: CHtk4F1hPBu5ilWyVFS0a9akiTg4J6jx
X-Authority-Analysis: v=2.4 cv=P6avFSAu c=1 sm=1 tr=0 ts=6acf8482 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=jeKYxtEjmYGD5WCmXysA:9
 a=CjuIK1q_8ugA:10 a=cApNwXssEwYNTDXMzu4A:9 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-ORIG-GUID: CHtk4F1hPBu5ilWyVFS0a9akiTg4J6jx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1MyBTYWx0ZWRfX4nqvuY2K45TV
 Nl0fZEzrKSYv7kLe7QWJl4pZm8C5JSoAsTaLsjd/udNSkLGAicK0oBB8AFCy9URM8S3VI81r6wI
 mGGNbMbL/xmM66TzTY2SGYL5yYpsj7o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140053

--q3kgqRgL7mAsQ/qT
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

--q3kgqRgL7mAsQ/qT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCas+EfwAKCRA6cBh0uS2t
rHLiAPoDfKUfclyNbJe2zYWQCf+joNgROzCH1Sw+dJSGo0Hy/wD+JduogxPwQFL2
qb5cuv1UhjwryPGYdH+CM1gOy0VEIAw=
=E36V
-----END PGP SIGNATURE-----

--q3kgqRgL7mAsQ/qT--

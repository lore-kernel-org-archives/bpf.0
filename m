Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1858149BD75
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791377144; cv=none; b=DmrpIkO++6pX4j3G8HT6Lmz6i2fxX5YhRH3RLdWCtDKwQ0CE5vwOs2aSVhNnq2b2P7RL3LtbWljJbToME8s4PTW/TcG5OnruQAL8AjMNp4BHRANmVOXFcUjsAa7Fm3eqs5Mf+zPubrH2t4BbNw0o134EAsBCPQd9jxUJJniuuXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791377144; c=relaxed/simple;
	bh=8qplGZOWb19L6x3ArL0rwzyHQs9CghQkkFlHEuRzQRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IekG0qHUBjms45njg6kRtEVgyJML/2qBuQDhO4JACe36aIZPoXahyR8zwbeUEKXzZboy39ssCjqZlktCly+YQdSqb+aF8mY4fwtqt4k1KF85sjCU5hM8NCQr1yUA4DR7O6B/RrZ5R26DVtg5ilFXc8d4t8NvXt2Wk3QgYKFF9qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ww0GtaIL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g/pmLK7+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ww0GtaIL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g/pmLK7+"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BVE5Z609967
	for <bpf@vger.kernel.org>; Wed, 7 Oct 2026 12:45:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=wDKHbexpFw/5dh0l0ZtSxW1a
	xHuzuCQ9/xmJsjlfp4o=; b=Ww0GtaIL4KayrDqac+L9OrMKXZrBTwJdgFwWYeuG
	5hDgHXs3L/3v8OzJNfbOg7jfhMvok5hT2QiDt05Gr2QJ2MAd4wM34+YYWFRSJFN5
	SbMpzW2EFuFVaFd5+ZnqAyLBwDPV0Zbcds/Ccm3svBLy/JqWtOd10O9kFAsPyCM8
	TB2Z1IeiPtGQT61m2anf5kWz7bbfWfwFlcsi0rerrVpBpksZV/vLZ4xZDYO9PC8F
	uOat22mhA83FPaeF5Ym7ZqHCTwVb2muzsx91z0tyV9mnHGqkau/ADJiRC1EpOovh
	KV1o7bM7kFqsmykYwB7kfNXe0GIsIAGCYrkCkpjnDHmetQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5fc59fqb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 12:45:34 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a1de6d5c3so855685785a.3
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 05:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791377134; x=1791981934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wDKHbexpFw/5dh0l0ZtSxW1axHuzuCQ9/xmJsjlfp4o=;
        b=g/pmLK7+7nplCIRnNhSoE+8cqtZy2MFi/586CoKSaDt2zvapcZVnmfKhWwoXBWG9+0
         oGRI6nB2FyBOuHv0P9qyUHLgi/i8wvq6bgpBYF4xUtMj/YJT4mSMQvDkJkD9JlAD0Scj
         JAszaa2iPUAvJNJacZOOUV9n9WW2g+/bCa0GJ0USe4L8iaakEWQeRIZCb46dchDKuhf0
         YoYjZGkKbe54umZmzub98RjPLqaWQFFdFemt8dxugE49v0LUmYb815HxZ1k9UkRwBpZT
         +E9uNJ2sw05ppbz7nmxL9n3mfg9bWfIkN01R/0BGOLFmaXXsO+ke1eShqnA0ODkXIv76
         ny9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791377134; x=1791981934;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wDKHbexpFw/5dh0l0ZtSxW1axHuzuCQ9/xmJsjlfp4o=;
        b=A/vLpbyF9VQ4tq3/UE3Bf0orTAptFqE1S37lPonVm4VqWbs3r07ef9Ro10NhLlBqA7
         XIRMqyUlKS7qNMu2cbFvZF/rxW4y4T+D4b0oRDyhk8Zbba8a97o+wv7JnzwHyfKHEyqQ
         RNCF2nidL3FLcled31W/6YtJW/Z0RmiL1phYlPv//EKhEKJEPGVSMN4j7hsoomhzfoAq
         8VW8VUgR9seZgtg63UOIO5c1F5bcPBrZQMVec6Mzy4dXDFGkgJD9YubosZjKn2ZmhtYn
         fHWMpyR0SA2wkvlXzY4EaNTB7yHrYLWpm8dPrxFtmsGrz2C/usjxFgM7yzJy7rdBAVZQ
         deqw==
X-Forwarded-Encrypted: i=1; AKwUvBzy22rbBfPUdB81xxvkH/cXUgQcodQdNo9rRqa5H4I3Z8ZmUVzfbD9J7BdUPd7i8iiInk0=@vger.kernel.org
X-Gm-Message-State: AFuF++lIDtCaPHpfpdnH3MR4E0ThhI20q/u+KQvyentnZt1WfKrQSaoW
	bkawbWRrspDjRz+VqbGI4FcpzaE/URDjWfyYhKPnsXj8Qy+WR/wW1YYZQ3x837yRg//SdDdrHcL
	nYXbw2UIFoIEDeD4tEofkQNYNoazmWVM/2ThTC6TgQpz2G8g9jDBC5QI=
X-Gm-Gg: AYBFou25/uyaEX7sNuyqLtxCxeo2YEJDzzm5dNaBziEW3CbBpLPl+LAB7oBa1/CnkJ9
	9+J9d4M1u2yfqU1O05XcRb9c9PTTHdzBZd2GbN1TfEm2XpQz5quTp/q82Knm9BRp7rBrxFX+HDk
	dmt4RW+1BpMcos8IJzXzmdeTx9U9HVqBuTKU2RIsB6cS4qEwrx6zKuRLbPuZ4MfC79/tU+23rs9
	zOp53On6M1c98PtQdyAJwg/up6Y5IiZufGLI64vXwfiKX7XR7prxLrF2KnckRcdFzwa10wsTwCP
	AlYXi/T4L2yAioZ6E+NXpVqFz2bul59I5aa3C9cv/T5IKhv4wJ9ZkPxm/E26HXgrQ2XhSYSWNeE
	rFW+LacOFe2gp+A==
X-Received: by 2002:a05:620a:2841:b0:93e:9292:1b96 with SMTP id af79cd13be357-93e9b0f2bc1mr403461085a.3.1791377132830;
        Wed, 07 Oct 2026 05:45:32 -0700 (PDT)
X-Received: by 2002:a05:620a:2841:b0:93e:9292:1b96 with SMTP id af79cd13be357-93e9b0f2bc1mr403455085a.3.1791377132184;
        Wed, 07 Oct 2026 05:45:32 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f4480a4sm51221405e9.0.2026.10.07.05.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 05:45:30 -0700 (PDT)
Date: Wed, 7 Oct 2026 14:45:30 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Tianyi Gao <tianyi@cloudflare.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        toke@redhat.com, lorenzo@kernel.org, horms@kernel.org,
        bpf@vger.kernel.org, shuah@kernel.org, hawk@kernel.org,
        kernel-team@cloudflare.com, ast@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, sdf@fomichev.me,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 1/2] veth: fix peer NETDEV_XDP_ACT_NDO_XMIT after GRO
 is toggled while down
Message-ID: <asY-6venW_HXIXv3@lore-desk>
References: <20261006173241.65945-1-tianyi@cloudflare.com>
 <20261006173241.65945-2-tianyi@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4xEDG4xH1wxBdFf8"
Content-Disposition: inline
In-Reply-To: <20261006173241.65945-2-tianyi@cloudflare.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA1MCBTYWx0ZWRfXw4et873Pa50A
 tOYTC3TFae1GNS0CFKUbSCHg5+X28h9VrBnZLc0gEy7ZvOz3iQVSZAiIBxy/oXaAhSpANovUF6J
 FNTaM0bX/0IpdWYYUBQcvDMXJbRjMSU=
X-Proofpoint-GUID: aD0-gaxienRuucQ7abUcWsClkdoKdT3b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA1MCBTYWx0ZWRfX2rrAya2Ngslv
 5X977f1e6KHBGRJwouK8TH0C3idlbJqT3C2Tm520hqFY/OjWoCKWcTvjh9Z1rFAClXcwCQn+d30
 Zu/NOR9ueYTsyI5B5fua7E/g6pzLMKe5+I7cx3GcufrIKTXCPaH0pKsymGWxBJ8HxYb1PVW/mRd
 g18rGTK8VxkC+UAeYSv2MRBhXfaVuCoaEBxfCn++tHlA/cNrqLyq1/dbSFl7W6fZt+fNLhxYk0U
 JXQszQ2g07GruerCI3m6d7rsRyZlgdqiXJCMYhzOsbA363H41DOPVNyoswBAhj7c+9SZd42Vxv9
 2OYz02zuUbNYO8nKkogL3PmFWCmTkBLz+EwRXkcazMdGWZl/T7ee2vK9MT8niyy0aQePqq+D2o3
 vMbcGXne928j7N1ZLP0TCDl0fb8d+Ep1q1fj2kfzFjJ3eWUoTi9cUeKp7qyMQGOkmgVWmHTyeuI
 5HjqsgPtuFO6LHEK3dA==
X-Proofpoint-ORIG-GUID: aD0-gaxienRuucQ7abUcWsClkdoKdT3b
X-Authority-Analysis: v=2.4 cv=a6+lZkSF c=1 sm=1 tr=0 ts=6ac63eee cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EG7W4yiQAAAA:8
 a=EUspDBNiAAAA:8 a=i-1Ti26mAgIR2IkWSe4A:9 a=CjuIK1q_8ugA:10
 a=8rg98RGK6hDbJEFrGYMA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070050

--4xEDG4xH1wxBdFf8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> A veth device advertises NETDEV_XDP_ACT_NDO_XMIT only if its peer has an
> XDP program attached or GRO enabled, that is, only if the peer will have
> NAPI to receive the frames.
>=20
> veth_set_features() updates the peer's flag when GRO is toggled, but
> returns early if the device is down, and veth_open() only refreshes the
> flags of the device being opened. Toggling GRO while the device is down
> therefore leaves the peer's flag stale after the device comes up.
>=20
> If GRO was enabled while down, the device comes up with NAPI but the
> peer does not advertise NDO_XMIT, and devmap rejects redirects to the
> peer with -EOPNOTSUPP. If GRO was disabled while down, the device comes
> up without NAPI but the peer still advertises NDO_XMIT, so redirects are
> accepted and then dropped in veth_xdp_xmit() with -ENXIO.
>=20
> Commit 7a6102aa6df0 ("veth: Update XDP feature set when bringing up
> device") made veth_open() refresh the device's own flags. Refresh the
> peer's flags there too. The peer's flag depends on this device's XDP
> program and GRO setting, not on whether the peer is up, so it is
> correct to set it even if the peer is down.
>=20
> Fixes: 8267fc71abb2 ("veth: take into account peer device for NETDEV_XDP_=
ACT_NDO_XMIT xdp_features flag")
> Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>

Acked-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

> ---
>  drivers/net/veth.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 71227d0389aa..643b97dc5245 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -1415,6 +1415,7 @@ static int veth_open(struct net_device *dev)
>  	}
> =20
>  	veth_set_xdp_features(dev);
> +	veth_set_xdp_features(peer);
> =20
>  	return 0;
>  }
> --=20
> 2.55.0
>=20

--4xEDG4xH1wxBdFf8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCasY+6gAKCRA6cBh0uS2t
rBUQAP92l+vMlvnh0tOci6HtUud+Pwzz8ZGMxlLmTUfmad5FhAEAzMyc2EiQGSGP
qwTW1ydbnj8xCFo1XTjODTC/8FY3FAE=
=MCcS
-----END PGP SIGNATURE-----

--4xEDG4xH1wxBdFf8--

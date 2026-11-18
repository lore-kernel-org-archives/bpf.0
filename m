Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=67.231.145.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795024002;
	b=1u2SQb4pVrtVihsUVm++2wwCwDWangklXq/zRnSU26oNrs7nvDTgwB+YWYpC8WxVADWl
	 amJwQUJewyUHMTo3NEETlqTvsrpdb3gWc7keQGpC9cncdYoQqZglq8WlOV3AD+Y+31IKq
	 WGs4tpuIUZIfKKihdbZ68vDlbELD3qlHvq0lMZzqfg2lTc+gn2WMW/LOovjtaNVXtMoeI
	 T89pVJjwkPg4qLjkRN6vmcPqztywPqm3pLWspTVjLEO1kUvuSqpFXFV08wi2jzXcrm6P+
	 hDWygaeyPUBMQeOaM1QGJB26lxk71bgkqbf4ny43aee943f7LczVNHoNLENU3Fc17EA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795024002;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version;
	bh=3ykO91BHuXIQ6tsZKZrYbUoukzNZTCZ58wQfRBP+nBg=;
	b=m6ZrHwBAtf5UlvZoeCNcZN6DddM846zC5JBni0l2WDfvBI+V/xvHd7nv4qIrhvlyHw64
	 QEZwb3NqnlKK/JusJJe56nssaLITirlQ8cRmksTaJ/5g6KLs+oWuLIdPzkHJ3wkTylOVL
	 /u4XagGCEt0ZHpbnzJAb4lVrXUgvWiZ6bLMjM3pSyl63w4f6Pq1qYik04/hsqLG3Jsyjg
	 ufN83EtfqFgLks02RP7CoHmqPvF5Wfcz3FrRem4If+NWPFJEsWDJflD/vM0BldaeVo1P7
	 AIIT42V6QChih20ry23bbFVL+2IZrt3tM5ju/tZuTfhp3BdjFCuYFILVvLWIiTg6gPQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=mR5cWZhH;
	arc=fail smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFFE606A333
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 17:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDFFE606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=mR5cWZhH
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIHGvY53874688
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 09:46:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=3ykO91BHuXI
	Q6tsZKZrYbUoukzNZTCZ58wQfRBP+nBg=; b=mR5cWZhHSGlgX9Kp6sEX3IH0+vZ
	7DhjCpS6kNifZvDX+8X4OeETq3AcTzE9isy0aS2loX670ry+7TN75kVbI8yRo1Q6
	gq+x5l6yhhuU6Wk3IRlOTXzEW1O8Kj3CPXaW7nmZ2iZTsfulilCriD9DhvSNbOFV
	+LEfsYSD8WgJDdr759A/H/ZR2SrSVA+o6i8qGD/4Jzx/vvk0c2DA1O8WtVgovNWz
	mS4mSF17IRuXojKZUPJgIbCJz3yts0xln4eo1+Af/NfhEOcjMVu4kVfu/pGgrgga
	CqMpmoyU6vuiNbRC90iCXLfbCcUEM1uT0uRPofW0D9uZzMwYVDSoS0KcRNQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j0yu5ye7q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 09:46:41 -0800 (PST)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8b647bbf87aso1005437b3a.2
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 09:46:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795024000; cv=none;
        d=google.com; s=arc-20260327;
        b=SlR7uaq5S5CzetboGheZj8zX7vwZumA/sTbexrbNQGmDa+UOdBVW7VE9tMCv0VY5ll
         u561hff8qCO3igQkYPo8J6/aJPzz4HZP9VjSRwUoEKzfcPKvrIubSk5PQ7Xj2mSqAIyx
         4NqeMKyLUnV5ssmjW55y9nCiANzxJOxJxyz/yKRbn9bl8JAEq3KPGaU1TCZ0/vq9M7Vh
         O00ZwM4vxxxsVw2bYOzaOYlj5qQjBOV+kjNvsfT/KYRneo/TqlS4PLlhrNKspgz3N7RD
         tEFBjWvLisXw00O+LF+Ci3qhv9BLhRxIURrL7HIPe+Pz0pz/BYqBHNCcGQGIPymGYsfM
         jFYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=3ykO91BHuXIQ6tsZKZrYbUoukzNZTCZ58wQfRBP+nBg=;
        fh=WiDNmr6zFNsogL97G26qRu5v6wT4RNUbxPBifgzAnKY=;
        b=QyR1chmGwNiWY1vXSLx9JBxf+qdh82uh2tpTkcDOiGhxjALBUUkPjDEh9T5MqX/r0f
         WiCiD6o6J5r/GSydTZjHNGtzHrBR//NZJTKFZOpygPDyBet3tD3HAqV3Kj+X+TUIHPcx
         THMwkVsXBTtqbUmMgSD4JDyw6gBNhQotHbA0bn1dnUxz8OHBTPUvAi2uEruFp718vLBT
         /xFULRsXCbK+M0tpmqpmlD+JJUCahGjqZW84t91ouRnrZtJikGbb1o3x6tUEwNtUS05Y
         SAkI0ZVgih3tsbdAEyFCQmt2ZoDpcHsLBm28KLJWSBLBvW4ig7IXvKkgNJ+A2V/eUGMp
         aa/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795024000; x=1795628800;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3ykO91BHuXIQ6tsZKZrYbUoukzNZTCZ58wQfRBP+nBg=;
        b=ltD8vsZ6xj5TLPcbSD9IM7QR2LQzUekMWzOfDbwUGl9SZlZKLTL2rbbXH0/nz1vFHU
         4vR1cm65lGkj+zskLEL/QknSXECeKIgCWbfaSMdL8WnnBFgTahGB6mliHBmfjXvrNp8Q
         +ixRiW0JaYAUrMxzaCcRk6gpE3XXIv9KdGeckPf0NDto5OQ1AjDBOXhqx+S0JaJOfSfL
         Dz//dqVBg3oVCHJPqmmKgMUrN6+MzPC+lrMIexLMD3h8mu8chxQRcQCrUZ1aiCvoFgyJ
         9BCk1mhZmKlkUovqZ1nZUwkk0Tt9wVB0F1TqewZaaGVj7ddTjhMNws5mMt5L14hOx8aQ
         AAtg==
X-Forwarded-Encrypted: i=1; AL+hErEB6ntitByK2daI0Am3aH4DZZG7rOwk6ZZ1iqI+U2HDAuwS8WobtLL6gr8g+8FpzCErvQ0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8fPH4ejshSuHAkwHeLJ6NwhXDXFdX2Js9NYDmX318wogga9tB
	qh9w0zO0W3mEMj3C0iePn46eJ98DjkCpKvnGjzfsDJtYG/sKJlnY7hqXhVHH2ErQdQNGtJYYEQJ
	RC82yj6uz78xSOXcrr7V7YryXAN9owy1qwpmBTbs0S5h8Cesz8G4s57Mlu9NSMjlIftu3CVZMxV
	EKZoPx57waPfzptf/wzjgLxj9Lh1w=
X-Gm-Gg: AYBFou1S0ODxf9VzpOprGGJ4cpPPBC+YWieuG3XeXE4HL2vQ+mJt75EQeRJkjFKuSMf
	oo8Vo/rrbsGhoKbTYo7wkxHqOYVFfOB0/g1Hmqt2SO7xfb4P9aQ2bQUTorNN9VIqDXD17RSSiwx
	7xfrWSYwMUm44SvKeHOudyzgdDrz+s688sWNdKK5keZXoGpk1pW9Am1D9YU75byPkn4Q0WV1ud9
	yE3MCWW5VxQLba6EdC1SJRbx4oq0xPV
X-Received: by 2002:a05:6a21:7e83:b0:3e2:a849:64c5 with SMTP id adf61e73a8af0-3fe970fb016mr3351013637.19.1795024000277;
        Wed, 18 Nov 2026 09:46:40 -0800 (PST)
X-Received: by 2002:a05:6a21:7e83:b0:3e2:a849:64c5 with SMTP id
 adf61e73a8af0-3fe970fb016mr3350979637.19.1795023999775; Wed, 18 Nov 2026
 09:46:39 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111005533.6436-1-toddfreed@meta.com> <20261111005533.6436-8-toddfreed@meta.com>
 <ea8a18e0-12cc-48e0-903e-325a8ece5a0f@iogearbox.net>
In-Reply-To: <ea8a18e0-12cc-48e0-903e-325a8ece5a0f@iogearbox.net>
From: Todd Bert Freed <toddfreed@meta.com>
Date: Wed, 18 Nov 2026 09:46:29 -0800
X-Gm-Features: AclHuK933nJ--reKuON_iU7qOJYXtOh-j2OhgmEp3HOYoG1ZpPxZFsfMEYfL2v0
Message-ID: <CADh2yMxffQ3cywT3aNg3SkVfog5CFnUSp34F1esyun-xUBVa9g@mail.gmail.com>
Subject: Re: [PATCH net-next v1 07/15] bpf: don't redirect decrypted skbs from
 egress to ingress
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        bpf@vger.kernel.org, Daniel Zahka <daniel.zahka@gmail.com>,
        Donald Hunter <donald.hunter@gmail.com>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
        John Fastabend <john.fastabend@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-rdma@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
        Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
        Wei Wang <weiwan@google.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA3MCBTYWx0ZWRfX/7EGi+TxvMsV
 ydYuZ7TL1S0aXZXZwVmkJEWtrNI6kAAsknYbqJKxXu626mZnxloZPNd6Qm/weAWElGYMaohOXdd
 piu09OPjEgm7UxDlDUcuoeQN9++Eas8=
X-Proofpoint-ORIG-GUID: nYqzzFSL0xKA_h0xv2eCPxPP8eIEjjIB
X-Authority-Analysis: v=2.4 cv=JeApPkKV c=1 sm=1 tr=0 ts=6afde481 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_1IyUuN4QrATX339ibzo:22
 a=XWTshytv-yXGdKsk3gQA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA3MCBTYWx0ZWRfX1p/XcI7y4DCs
 QOYiK5+na0iTnqDz0yDK3s+7Y0CM823+zH44vYZCie9Ez3Y8s+feS4pad3f3kZfksV9BrUNRdoL
 CRAvhfVJxf2bRsOEGesHulNsj+T80VZzb0KW2GbekBoI+So3fGRrifi6o0ZQcWqg1yQwIythgax
 04DV6QWGZG8R8sOZr1+V3/8ascGwHluDHDdFwSJ21zBua0RQA9Y12t1+yAYI+umPWQMqwGZ2BCl
 ZAd7zbqHz2sDx7X+4tuogfkfylaRXx4ZK5xHV/lh7hIt/q/EWbGm3kaIWBOPvc3Eh9ywz0FTLGU
 +3JWk9aOg8uF3aiF9pttHDvKaL+qG/zaEsYUU6mfhY0eTbIoW10kaHzKD9H1CocKUcTViMl9PeC
 TzXN3GEuTxKyhMbs7BI0u3NNJT9ucqOSAAlIyI9b80HMLsI313wWHcyMDj4FAse5RanXGKQdh0G
 YBfZ7eSaV0dPI1bDuGw==
X-Proofpoint-GUID: nYqzzFSL0xKA_h0xv2eCPxPP8eIEjjIB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_05,2026-11-16_01,2025-10-01_01

> > +     /* On transmit, decrypted asks the device to encrypt the packet. Sent
> > +      * to ingress, the packet would read as decrypted by the device.
> > +      */
> > +     if (unlikely((flags & BPF_F_INGRESS) && !skb_at_tc_ingress(skb) &&
> > +                  skb_is_decrypted(skb))) {
> > +             kfree_skb(skb);
> > +             return -EINVAL;
>
> This check should rather live in the bpf_redirect (and friends) helper e.g. after
> we check for invalid params, etc, rather than here which feels off. Also, it would
> probably make sense to refactor this condition into a small inline helper so you
> don't have to open code it multiple times.

Sounds good I will move this check into the two callers
(bpf_clone_redirect() and
skb_do_redirect()) under a helper.

FYI this patch was moved to the net series "net: don't redirect
decrypted skbs to
ingress, psp time-wait validator", so you will see this applied to v3 there.

-Todd

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.145.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794512170;
	b=u/xXfZxK42TxwgrOzgp6qPPrB+l4XfT5IQCPCn4skQdFh63BqRuEvsTj6ArPhVs5DhkX
	 IjGH0xXos5PFV/kf6kLE2V+ow7ad9zGIMdxJpmbBz1X1xWSH++Jp5I6cZdo79W8bBHzz5
	 yuH3/EGNAZoIb0Yb2gv6JZXOfL+aLekLE/5zR5kAYbLpULvwyA/qpOeMr3I2P/f/O4E13
	 u+zTUi2DEu3kjC5P1r3jeYyXWbayFTUatS/PXeI855gKyF9kArwRZurHLvmB2isTBrbuY
	 7LQ8qyMifMTauy5BUf5Aw3q2sXAGjO/2zzk4qpEy81oVO1X93tl805deqcOfSgQLWiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794512170;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=Q3u7I1yY3nJmuq+49fNnSVZ6NxAiKftF5EDGZUfjWaE=;
	b=fB9HXAsznisGXPRRd0cv98QnqVsxOuPig1FIJOsWd1ELr2NUy6GG0SBpqOCkP5xPkLKP
	 x+XhFwoFVVHXigBVSZUtbX9I9bA9+a+nys5P+NxkFyIoy+z/n236oW7C9XhquZ36HgXn6
	 LrXN/asU7qYl9j4i8IjJqETWfPWEBQEhZB69v6z1ox89dIjP44MV8l18FastahqvOdjgz
	 fBZeVWDoT2HPRD1Qzi50v82dBwzxfKhUEfMNBcqMhmU+3aNe20+aVGYKJlZdy3ftA84WO
	 enxvvrwecK2rn5UJm64iwue1lpZzZDNSo6d/PgfrEp+HN/KvxOzyf+nQmNSc4KukjLQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=LU8nJzdq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC22606A327
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 19:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DC22606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=LU8nJzdq
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACI9Uet3345057
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 11:36:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=Q3u7I1yY3nJ
	muq+49fNnSVZ6NxAiKftF5EDGZUfjWaE=; b=LU8nJzdqTuFeXxiCts/Icr9sphO
	9JwQ6qneW0n34BTZV0JOHdPmVmq6v/o8AAukNp0VfJtyC1BxJESUVBZnUPO6bTJz
	heXDvu278xn0fp985Ow2X7KOpGQZ22QPNDE8ZkenXzSOzsL3mE+pV15Ld4NYN0ke
	Z4xYE3FlOFj/3hNCfLYkNWEOgkL+E1fKr1d8mgMFhG4bM25au11LSDbP1ZpUQNkL
	P4j6oE2OX8TxKs7kHuTuK5VSeUo2ZEx/0qtZHGl8RSf7BrtesxK08+eNxS3Ts9nr
	J4HURg6r5rm/vNvQFI8Dm0i35N/VUkWCnNGSvZbKTT+YhzyAn8Y9jOOTXJQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hwjg5grgv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 11:36:09 -0800 (PST)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd5ca3840c5so202847a12.2
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 11:36:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794512169; cv=none;
        d=google.com; s=arc-20260327;
        b=PKIGkyTybvpr5A0eONNgf7YOaDuzffvLkSNXbJQAupp/HteACXy+wdMDFgzMW/Mac7
         uYnByW/uMxv5emyV/vhuHPNeuaixAd1QenaOAdey2mBQRjpYyDS6xi5PwrsXPW1SHsYK
         L0llAfo0BZQIsCXAuyEDmEfbv5QCO4AG7VLAVF6BdPQKBig7v+fj6FwwBIvoW30Nlkbr
         8EEKTH9ifeIGQ6nXnxfuA1cLRzi+zhKEW+qOoPOmdN0cC2HQP+VQ13E/sCgEniKUqgWr
         9CgRwjtwRhUXkU4PuBXznSOyVU+LvBgzQwnAKPXbuF91a7ZoZXBdDrPM5pTDCDTb1s9b
         1QyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=Q3u7I1yY3nJmuq+49fNnSVZ6NxAiKftF5EDGZUfjWaE=;
        fh=1dPokvRyPwKq+KuxoBIjP7CHX8LwqlIX6Rhmh8xRx3M=;
        b=TXY3iKvStemiR32OHemcoRTQnuca++c7NOXJAMYx8Tdsould3FND6yEGhQrRYFLg4N
         4uZ2AGX9JOoqega83xT0iRru6Pa0DA+1G3y7Nkwv3nV4JLd1vvXuOwlphEO19qd9eJU+
         C6SQbYAcAWYmBwD5aTqgdyeEuw4/uzAd75miSZjxAnNOyKJ/8f/VE26oJF6/ZcWSPWX+
         hb8e0kMsxGaNBajLkDf8QoYqqBugjkAJXXQmBifM/ARbzxbiDLFCge5olkcW8b6cYGAz
         nLem2QWXmEBKGUWMOlF5zY3sARurdvMTFPJQiE71WKzYbV0NG2k4IujpWtBATHQE9sk9
         cB/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794512169; x=1795116969;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Q3u7I1yY3nJmuq+49fNnSVZ6NxAiKftF5EDGZUfjWaE=;
        b=uFOQyeAUylaNxekA7T9pui0DTdRQHTG/Aa/4v75Ne4YgNiG0h3SSTmAfig5ddpzbaZ
         IRh4BY7WK5OhxRrVK6Ju670+KeTUyRwYJ9G3A7qY8lEPuPsMDAJf1gWHiO8X4StDTbXM
         UpRKEnE8L2mN2w5dY5y89wCP8nYtZHWNFY5lRiCW0dD91sefdoy4ngKEQj4oNxONB4Z9
         ZUyzJrfAIJ41z26PFo8baxp1Pn2KWX+k+wTaHwHTqkF+MB4Jmo+5X5anVMtA2AzwBduu
         DvnsVWaJy6AdNBlrfpEhUorH7Vgc8CFKhwYi5GTIpHPh8dIn55Qbe9UjuLISdn4MU+Th
         6BCg==
X-Forwarded-Encrypted: i=1; AL+hErHscvH1TRjV2xgsolaXCsLwAzw+xtAtvzQ7MUoZ7y5t2dX0+bju9qXvMBNXnXtXGQaI7Yg=@vger.kernel.org
X-Gm-Message-State: APuU4Z92Xz7rdfvU4G4QbmM63JyVcEnSitU/rpPcinGkF4YPWni2MTqz
	S7q+4h1+yCERDbrpD+GZAewqW8QZXPAnZH29mRhe7AFMBoK1yW5VFcPsN5HzpChb3IW8favbdZO
	7l4BiIaVPqOZwoVQJHC6kvrECWcLnaFyGSA3tdRADhbPM7DlRIFaG5F0LqoWs57dv9xnpkXHay4
	gErXreQlWhloJdrJfl7Frjf64+0Ko=
X-Gm-Gg: AYBFou3OR2V4IgG920Ee5elAo9MdINp+umvNQW37dwcLTkA2SAs2UKy4zKRoff0zVgE
	5xyUgTuRcn1zs9w9oXX53bDMdHntCoNVCmfBtyZ26z3nbDJXvngKdsPvaDMhKzHzJZdbsULYHo+
	5q+fzdfdmEp+LeX78J1Q9tOlcWNBPdM7cRjZlnfnSCPhjG6Gb/CYLbcEc+76lMzC8xTDf0rUki5
	Ygtx0f5YLMzCfOgxhZ+OvPetbyQ3Mw+
X-Received: by 2002:a05:6a21:798f:b0:3e2:2b76:bf40 with SMTP id adf61e73a8af0-3f7a6e9f331mr164005637.26.1794512169114;
        Thu, 12 Nov 2026 11:36:09 -0800 (PST)
X-Received: by 2002:a05:6a21:798f:b0:3e2:2b76:bf40 with SMTP id
 adf61e73a8af0-3f7a6e9f331mr163970637.26.1794512168673; Thu, 12 Nov 2026
 11:36:08 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111005533.6436-1-toddfreed@meta.com> <DMSJJY9PLHSR.39PSNUXEC82J4@gmail.com>
In-Reply-To: <DMSJJY9PLHSR.39PSNUXEC82J4@gmail.com>
From: Todd Bert Freed <toddfreed@meta.com>
Date: Thu, 12 Nov 2026 11:35:57 -0800
X-Gm-Features: AclHuK-L78K4XX2ZOiQNpBmdIZKiLWCeJjgy0X9ZblQI3qzdXkkSafaXrEWKuy4
Message-ID: <CADh2yMzE1ipKD7N4YBjb0oP1Ko-Z5J6uN4k4_kK=gosHyfsKWQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 00/15] psp: introduce socket-less associations
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
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
X-Proofpoint-ORIG-GUID: qWbbQ2x-ZQVHNjHErOETAP4VPVHwAWPY
X-Proofpoint-GUID: qWbbQ2x-ZQVHNjHErOETAP4VPVHwAWPY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA3OCBTYWx0ZWRfXz9L6jcSwP0tS
 zoJgNwrpZuF4S8b+1Q3LeD/LZsOXPyM57qa82MHyWb9W49in22JjU851at5QvtGdJ/RR9G7UyuN
 01MOv90UzewGjrdeQrpRWV6ysa0wDb4=
X-Authority-Analysis: v=2.4 cv=Mcb5KJ/f c=1 sm=1 tr=0 ts=6af61529 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_1IyUuN4QrATX339ibzo:22
 a=FSGtspZVazLKPRRdjFEA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA3OCBTYWx0ZWRfX5iJCq8V91PBU
 OJs6rwTxsLrNWFfOUe0NZIZ+1nnzLpM+chT/tiyAykJR2X1/fA1+76lg13wkJyzoRmyfYO1sV6k
 3v2ubo/7DjSEDUA3ENS+izKwdyLFFGwvvRdG1GFXY4+S9E2pWI/HXIhIis9tKegzrlhL45pvYbb
 oKFpJVN3UJjqO6oY9Z0j6VgR3hoNf/x6yl+1usRw1Pxpo9w/Xr9nyW22IzcigXVdRVqEW3bfqJ6
 VWkhwn9WWXuOcH+uFXfuth7JYDN8CydcPEG+oYjl4EHSlxuNKPz+Bg3dK23T8pjL+tyLM8jK8de
 E4bAnRtb3En+In7DYdHE/AdXvWTgc1qROzsSN0Uwx3mt0dsDFzVuqBwPTKNBbnR+6j/TBAtMaDj
 kV6fhtYVdBVGI2KOfaOJtSME6NQV27VBZHlwoXtss/ltH7V1wK1aNhVH4b9SXigEua71lEodx9M
 aGbrClI+jT1epIjkkew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01

> Some of these can probably stand alone like the bpf decrypted, psp encap
> helper, and timewait validation, and be submitted first to shorten the
> series. That's just a suggestion though. If there are dependencies on
> the main series you can ignore.

Ok, I will re-post 6, 7, and 8 as Fixes to net.

-Todd

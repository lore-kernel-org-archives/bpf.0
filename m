Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=67.231.153.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794444717;
	b=mB7IuNE5DsEJ6xr5ThIJUL69HtZvd96mWcBxOB722iCoEMtho4toxoy43r3jPbrMBswx
	 vU4VfIisltDVFm35vFnfB69+HZnka5k1cxSlYpzsGnh9nFIXgp+63N0NdeZU/HLcxvYb0
	 FEIbvyZMT00uRG1BPXIu4az9XTix4AJFTF/CgL2LuIxrs2k+8hWUO2KsHosHKwgzzY68o
	 XIErFM+wSgPMc/t/VSw+uO8cNrYCKJVIPe71BA2/ySB0vuqOluQ/Z/Gxl7N8qFkMRoYSq
	 waaVMgVNCsxk6KyqIdwgJ5U/ffHruDDr6WnCEtnAeg2c0sFigf9CDyyg/poSOd4wKHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794444717;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version;
	bh=COvz1LYfsfnPEz5Rqox0HEgHvMOUnAt/U2EOg+WNlZU=;
	b=hi+3XKOZi3G5eBnsVBpg+oKLEIlRvnfVI8FJ7UFIWnqKyfW+/1gFKgpBtqVkpAk+vjlo
	 bqHhhWjlNsi6kU7d3NTI4umMKFC9NygTKCwDv9KLyZLqozKxwKND9dwTK2R01bI0GVnAy
	 1ugu1utjcGLXW1SVdg18g0OcDpOYFdS5f/I15Ck7WHdTEKwXimVOvJoti8fjV0XtQl4mE
	 WVj18Gl8ch57zYUUrGH1bzj65jCu1Anu/xnsJK9iD4IJxUfNpzS9jmEvMXTNVWEsZZQ0D
	 n4VKzP8kdnfpT+qOoZ0mlN6sfh/ZQGdX83P103fFQi+4raJfj2lPD/ORmwchbffuhBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b="M9reJI/S";
	arc=fail smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C195606A323
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 00:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C195606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=M9reJI/S
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC02bwQ761448
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:51:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=COvz1LYfsfn
	PEz5Rqox0HEgHvMOUnAt/U2EOg+WNlZU=; b=M9reJI/SbRv3KTUBSw1H39UYEB+
	5lytBhF7hV4YQaPVXjAXypBnalL48KDk1A1rPKkW4JS7QlVjoHRcEgxDsnA3DkFA
	V060Ck2jnCyXydM8YqDn8C+78ia42U3pbptfzsZlVy9Q4snVD20ijYvY83yoTAm8
	ocCd0aFLyIXSlQmjSjI4EMdJy/wmj2AUKlRJZxWjN0PrKyVpD34ID8GoMpx8amwx
	sUFDPaIZYs7/+VMoJ2ms1f1pJNJM2ePMvINLR5wuKhj4NwbcNnaqKiw3F04xD0Hl
	fQXX3j31JGidEqXUi2+1MYP8OtMbJoF6w9Rm0iCvm3rpqRXC98O03u3+rog==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hvbxch32t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:51:56 -0800 (PST)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b10afdf947so318978a91.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:51:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794444715; cv=none;
        d=google.com; s=arc-20260327;
        b=LvA02I32rgjcFPYJlBJgkYAceukCQJiPxIVzJorjpbqAhj7Sr9JcfoQ11R+L3t9yzF
         zBwI/PH7dvet+xOdz5kC2V/Ng3Tv6Omf6eNoVCv4YUtejCCmFN11K7AEGK5v9rqbR/7H
         xv209vIg0Uq1oQz5uq8e/9wFZw/bcegq362ElmCEGhEyeRobiHTRbUu0ST5rBc/1rM4W
         m8pFTIqhC/JQxRh6UV8CjVC0zBFSX8+Ab1PdMJoErftpHDpRejEJUsxbWnQ06OfpaEYN
         GgS51uzrNwwFTiAPQEMbGl7l/0NG+S5ngd0kcaCmQCqoBUe8MafJguZduVr5rmnO6G9G
         bjjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=COvz1LYfsfnPEz5Rqox0HEgHvMOUnAt/U2EOg+WNlZU=;
        fh=MAK95IuLCuadfBlw+h6LMb6xB9Uon1Dssny6fs9ukPY=;
        b=UulIE5R8TpnZsM1Dyce9RiJhEdrZxdqNvjaQ9/6FUUnCmG6YELQk2gRxWTmyFtlqxf
         RuzV2j48lIXtooE7XjENdn72QwZbH4nwRgvm/gYRl2d8b6PPXxt1J5ywPhnUZK8zU6P8
         yRjqzUWP3uO71D0/RQ3vt1Y6XetzAPMfFLMSVfe0bV1cmbQkPrws+jat+t69I0WrwNZX
         AdvydlG8ZLAzKHfRjs76Y6a1abBRjg4wjfQvnrCK52tPQcY9oxPbjQDSdgvuBhAsK8SL
         aPlJGENKUnl/nwQPIhtZeymJDvIcGKyuanWqZ+IqO5DWO0+nOPRjYXoacujFWerRSWPm
         bnyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794444715; x=1795049515;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=COvz1LYfsfnPEz5Rqox0HEgHvMOUnAt/U2EOg+WNlZU=;
        b=blp0COdnqKfXIvL2neXitkcv+NnLmpwhIaS2FjkpT6dUbbMPP1UGrttFqMuVH+KJ7p
         l8hcfAsGj/+zTA+RqKgKKsmuedcHorgQpqgWcm3e2iWwKzBGAVVX5H8afDjKuSsrD1mj
         KRlafWvZ4ND1SUASrpFINzkx0oJVgMIolgb+L3fhXig8jN0Zt/Gpp9Mq/wJ7Y2fEfnsC
         vtrgmTuAHbrPK+p4C3hEnT3IuJJ4ZCKShJSD76EAwFqveHWFeaeNX6jjXqj/Lo3/niX8
         jaj/dyLXm7z1IPIyBSrxXFhgbBC+paQEia7R1MJ9n17RqDZwpvl/R7darW4M45nkGe+A
         p1Pg==
X-Forwarded-Encrypted: i=1; AL+hErEilwwsHpC6Ub8g9WUqgZM2JfmnHlFgjEzmfH0g9Ttmr+NhIvrOPW1DDsfh21KbcxPrf2k=@vger.kernel.org
X-Gm-Message-State: APuU4Z9+cnyU+mcxAXfE7YGG1Ym0BpcpanOb6jEFJPPW2KJjzl6bTm97
	hUioqwbBb2FNxpFoY4ZOzzfb9isCPSrbJAkeC9rtj9z91h0HEH7q00ge0FzmGoixCtKtiItjCP5
	DSEQijZ8CTS2Dd3zBVxvxjWIc8GPe4Z6ZD0NrY2EJLKbYU0m7s5cjk6JuvHG1uY7qx3JL4LyN9x
	kQXgpmqICuHZvEoU+534B3llspwh8=
X-Gm-Gg: AYBFou3ImP57qVnULZvv9qOHtCxwF7bOR/GUCBsWjYSdu9vQIaSNvxoEmoLEdLdpbja
	4V2qGg7MRWO6+WKXPY0RuT4pmg+PjrPtWpLmVf7gGPtvrkTMMupEwrc7aDHxPdQioyAc4y0YztQ
	5FvvM0rEMX+gNNQxxy2g4mHj0mL1oN7FhLp4XrAz5ebDnhq76ADITOvSzAklk22KAbERuSCSh4O
	SbgOCdPUVi0pyZPbkrkglZi050LJUXo
X-Received: by 2002:a17:90a:8c8e:b0:3ab:d26b:c2df with SMTP id 98e67ed59e1d1-3b197cadcdamr475951a91.27.1794444715019;
        Wed, 11 Nov 2026 16:51:55 -0800 (PST)
X-Received: by 2002:a17:90a:8c8e:b0:3ab:d26b:c2df with SMTP id
 98e67ed59e1d1-3b197cadcdamr475937a91.27.1794444714456; Wed, 11 Nov 2026
 16:51:54 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111005533.6436-1-toddfreed@meta.com> <20261111005533.6436-5-toddfreed@meta.com>
 <DMSJB8MZZCXK.MCEBRZQDAM5Q@gmail.com>
In-Reply-To: <DMSJB8MZZCXK.MCEBRZQDAM5Q@gmail.com>
From: Todd Bert Freed <toddfreed@meta.com>
Date: Wed, 11 Nov 2026 16:51:43 -0800
X-Gm-Features: AclHuK_TCwMOAV1WvAw9HnkDUPDvVUUNIB0-FrcHVRqyh165RWlzsz9oCiRdiUI
Message-ID: <CADh2yMzdD3FSJSAY2+vJYADwRg704Ndqwz2DhAC3nhmyZe85jQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 04/15] psp: add support for socket-less psp associations
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAwMyBTYWx0ZWRfX2z49aHG1tUfr
 QEeJe5ekJMXaRRwjqqsZ4EtJSPZKJT1sjrm2gZXcMvyIyKLJ42R7ldZt+OMg1AWhfmZ3cEWO8Sl
 rSWC2zFZTcEHI9yBYiSOGlmRS/Is5iRyf/L8Chzd53Dvw+GSImIlTUoBsOHmfxa/q2IfvIh3v6z
 pIdSG28uNDQ1KBvMxprCdyNQJkQfzbU3SnAPoCiurqNIabkv1uE6P3vkyXNRUUXOjiNt/+ZrRyL
 eAwP1aK/DZz5OneAJMLA64gFCSu/OddGtfJbhFv9jnN0RN/arsYY0c3WeY98oXYk/9hSaduX81Q
 DqvLfy4vcpFwovu0iJOzFgEXDvWYAQ3b+aiC8JRJZE5qLTdUsJQcb5HyFJ66sMt0OzSXbowGq5O
 LayngwjooCTWB73CGTTMxDYB2+SvSX06lgQXdtV0F1qR5yOa7DyLaHch9ETah+VyqBG2nseUxhT
 knlIQF4iRGTrYbmIdFQ==
X-Proofpoint-ORIG-GUID: aXtXd20HPjD5mrGL1wsid6pvBfpeqpQ6
X-Proofpoint-GUID: aXtXd20HPjD5mrGL1wsid6pvBfpeqpQ6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAwMyBTYWx0ZWRfX0wqZmEtWcsG8
 BaGNkb1WqNsHVf6gRhwsRSyz9yOdJaphqypxVKCHNtvISnETiYupgAa4FoOfixiP/+MMix9QGAp
 re0MquFpsux5LsY4aTeM1PpT9wWjRXM=
X-Authority-Analysis: v=2.4 cv=ZdKIpcVA c=1 sm=1 tr=0 ts=6af50dac cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=jCddH8ec0KUNCymVuxII:22
 a=EaETVqjJsHDKXBk3jaYA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_06,2026-11-11_03,2025-10-01_01

> I think the design could be improved by not reusing struct psp_assoc for
> the socketless rx spi accounting, and by not placing the socketless tx
> assoc on the active, prev, and stale lists next to the socket
> associations. I'll try to comment inline to give you a better idea of
> what I'm talking about.

Sounds good, I will do this.

> I would create a separate list for the socketless tx assocs, so that
> SADB handles can be flushed on psp_dev_unregister(). Then you can just
> leave this function untouched, because invalidating the generation is
> only for __psp_sk_rx_policy_check(), which isn't used by the socketless
> rx assocs.

This sounds good as well.

-Todd

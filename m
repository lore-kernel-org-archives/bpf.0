Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784B83C13F2
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 21:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718800; cv=fail; b=OVKQ6zmGeklTIeWqJltXG8BlQjlA9jLgWFgwd5BRLJOF0hgeqNAu7gihnh9Qxv1YI5Y+HM4sz1k7eF+OnpEd6+Ffa0UhIVWLXcfb5rtWunzcAZUCh8UmCXMT0GNamaB1swOiss+7PWCSQJ9vDRZZ8JI95039QKRQHwetkpZMi2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718800; c=relaxed/simple;
	bh=VkC6ASY6hMpcb2N3FQ3m7UCF3tlkExQIcMsQcc5KFgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TvPL6mOiEuncIn4Arcna1rORbxDxyBAIdU5jr5iDMB1yw8980sXUVtGhZSrfmBQ1scHXI269xf2NffmclnlYa9DUFv0nCCyU5g51wCig2jCBwJ/ZTZf//oJIcW7TlMguU3Wm02eKMpxM4sn+N31odOc+To76wZ3v18Fa+/Y0UjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=MHyYFJ8T; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="MHyYFJ8T"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AK36rd2450570
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 14:26:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=4rVTCVe8LWbzPm0wjrSAG/mKG3KG/lwpsyIV2TiZsYM=; b=MHyYFJ8T0cAB
	L2thTi2mW0tU4fKtEkEPlTuNlGSYNbAUHm2cGN71mq4XJ4e9JRvXbECAO+LUE4wt
	K1IoCs6xDb82FhZ25qMZbkgIExbpGLxJb+j7vZQklv61ikYvgVa3EdM8bUKoN2kn
	qVAEIzWte1NFNwu9+oa2TdM0NR/dky97cKPGNGaJFWix6NXSrHe/BFvk2SDDVAKM
	E9UpXcQv9/N0fhLIFCRg7OHIzQeeZ6I1uG2uWvQ0XeZG1mAzAhXXnkNT0bLeIzcc
	ALSpjILyQaLkuXvHF8KPQQBD1/CJXMd9rnIQNZB/myvXMIMoLEeh/K7YDpFPbdMZ
	F1lIpqYrqg==
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4faku8xvpg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 14:26:33 -0700 (PDT)
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c15ddb61f13so128695966b.0
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 14:26:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783718792; cv=none;
        d=google.com; s=arc-20260327;
        b=dbOmpnXxmcbWAI+Ys5jRu18Ki61bOhTHRIZQTfLORx7CIYUozuUl+Xaw4Ri31Z45b4
         ljaDO0jj/nODU8Ib4DChGwfceWsiGeDf6FPO8F4L/AvL74MWj/FmzR2hkA85gy4lu4Uw
         zfi3+v4AuoIEjlNDhzA2fC98EC2PXrxdwW6XK/HyJHdAbwtE3Clm3HBvJFLJpXb5eWQv
         GDjNn4SKRFtBXym1asb6/QGu0yHUrKYaNH6sTHnnsAT2YN8o2JFqDQKJ3JMd1j6PY/Ks
         WO2dCf/rvKSa83FwyIaGyNVFcWv0LNCYpfaX8/2w7WLTSmfeTTg9cDxE5a8XiudDlrTe
         oCQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=FNJYGUchRZc+yyibQEoFJBWXm2WlrbE2kAvLAMOngVI=;
        fh=rmtCzUeBM84u+hkgXIOdvh1v0fLzOnUHkUTjq18Dd4M=;
        b=dqgvtxQOlogMqDiZsW6TiYJocx8P0WfKJBn3tv+2+yHHlCatJK0ymj/9wTAK+NCRmL
         fa2wkH9+VrVwB9McjkSS/WP2giDpFqMp6v4u6U0JCiefRu6yaj7m2yM4QMyNPkN1kMtc
         IPlG0db7PT7JV0iudNWly/Xkf8eP6K9QvLXRZh3OrVlrcTmuhE/1pm8hsmya3eZ8WAIQ
         ngoFquh51YfnRZoaILhrFDat0hFYISO31pZT2JCLISvAuRJDAfUY9wMZL7wByaHT3NV7
         TThJVQcrBr+OOcMaXq4/foCl+NOfK4KQGW43rhMPltKnhFQ5pyIrALXLj/29Y0Ky3Q5M
         Lfjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718792; x=1784323592;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FNJYGUchRZc+yyibQEoFJBWXm2WlrbE2kAvLAMOngVI=;
        b=lSy4lpdVESlYYTMrTT3K2qYxd0FTXxZA8rj8xWYcGuSO+b606ixf69F9dhANH2THhC
         yX3UAHW9OcblCrtWM0W8FKfvIFdRfQhjAjazFS16VVwa3x0t9Ab/JnEBjam/ZbkrdwtZ
         eY7B4BnhKuMtGt5AcmCLvAnpC97U388QFoamOSGr4meFVQz3h69L2b84ql6xOGcBScmf
         3mhU5sSu4qDM6R9W9YK5egenSBBQzezFm2QN08c23Yx2NPQ8o2WA188cGEVo9g7+HWSm
         uFcIAcYw2twGN9TDJBEKycAWM/TbyeWa4I4rBwmynsHMItq35Wgbog8R66HEeOMxKgL0
         nPaA==
X-Forwarded-Encrypted: i=1; AHgh+RpgZB8iMBCTFEOuQVbeaFRnBX5saQcp/hcSfjCpLqRor/FswFk0c4LqhyHBt9cpjYMNb7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzJpsQjQwsAJa3ATXvlGdTmVNdsmm38HhZdM00VYU9XWxobV6z
	urfPhAQcl3R3FYxL20DMaO5dtm5KoZoamPPOG+bWMviBOwvRHvI8hqaY6WaEP0UoxnbnSp95WpH
	s6hAUYbEiX8Oihc+c5u1NsRBhySjToimHlqgxFK7pS/X3Ynp97YjzajJpeoA71t1ie3uFHBMtzf
	XkRCIVKTTMA5aipOhnwqXOBZdYhP6L5JZ1mQ==
X-Gm-Gg: AfdE7cmeveKFwWBMjJ++/gWWmZ00g3wso0vPQKQGDfSKge7FsKiC+/KhoIrbnhOoOVU
	1+/Y4roJ97Dg6dGATCpSexa/+ZNu/jo/zG9HhPpG+ZGtzfRDQ5/Td/2x4+UX46kg5WGv6HStqIO
	1T064hITLaNNhP7IYgVZN6qDIxvhTD4noCrVUD3Eq09RivBwQs9Xa0VLDj/e742GwUp0ProzNN
X-Received: by 2002:a17:907:c084:b0:c0e:883e:93fd with SMTP id a640c23a62f3a-c161ea934b9mr22612366b.48.1783718792372;
        Fri, 10 Jul 2026 14:26:32 -0700 (PDT)
X-Received: by 2002:a17:907:c084:b0:c0e:883e:93fd with SMTP id
 a640c23a62f3a-c161ea934b9mr22610966b.48.1783718791996; Fri, 10 Jul 2026
 14:26:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710-net-sft-fix-containers-v1-0-a2915c294ef5@kernel.org> <20260710-net-sft-fix-containers-v1-6-a2915c294ef5@kernel.org>
In-Reply-To: <20260710-net-sft-fix-containers-v1-6-a2915c294ef5@kernel.org>
From: Wei Wang <weibunny@meta.com>
Date: Fri, 10 Jul 2026 14:26:20 -0700
X-Gm-Features: AVVi8CfAds6-1QvMPvHqFEOGQj6cDhKRwM4ua7wpqufDJTfdW3NOUKcxL1Pga9E
Message-ID: <CADe0Y=tMSQerM4or_QNO6tjc6GaEiysaGpmcHnWhaDKQocN86w@mail.gmail.com>
Subject: Re: [PATCH net 6/7] selftests: drv-net: add missing kconfig for psp.py
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Mohsin Bashir <mohsin.bashr@gmail.com>, David Wei <dw@davidwei.uk>,
        Wei Wang <weibunny@fb.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=eo3vCIpX c=1 sm=1 tr=0 ts=6a516389 cx=c_pps
 a=jJvPsHQLKLf2UdvVr97r4g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=wpfVPzegXHpEFt3DAXn9:22
 a=VwQbUJbxAAAA:8 a=hWMQpYRtAAAA:8 a=pGLkceISAAAA:8 a=FOH2dFAWAAAA:8
 a=ctOhbmcJb_RA1L7furcA:9 a=QEXdDO2ut3YA:10 a=q7aydO1c4wibL4nb3gNS:22
 a=KCsI-UfzjElwHeZNREa_:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxNSBTYWx0ZWRfXy4MMy2Zgwvbi
 PuNSoBeAVw8WdYJq9m5LNvHlCrGwSVjdOMrhRiJU/UxmllIvmfLiDmJDFMONri1dSXQrE0lKBlo
 Bx9+ZIMp88MO3gZYH88/KBgn8I5/Ncc=
X-Proofpoint-GUID: PAgu7zi9yq047vkZXlF_0YN6EgWrwcm5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxNSBTYWx0ZWRfX/KC1lCwbrNkN
 UpRETE7kMKr95i+PMxC6FsEpLQBtiEoiE1chRZPv5RTtDqqzPV24qXvg8wGMWZzIekc6IJM/ix2
 hb+PfYquE11ubHYFPYr/kTP8QeObdGhdvJLMVlPZUBjYUbwtD7a1/X4Q3E+0pGYrAK3C8sbhn8J
 0QVOKzIxXqkyMbhVPiO9ZMhgPfrk/2BqdwMra613OQwPPnvlxr/QQFRDXqx8gvEzuenhEpipIgb
 fRnEdjJs7qtcU3bAlpqb/LhZWiDaPinOdWQQ9ACgm7klDr2ss6aXOrQ2FVS8q1H2yt8opI60NvI
 TmmrgbSxKX6TpjohexiDHVxs4oeienZvP64rjUgOBf2Jnmo/t5dIkFQXjCFpauIKBXDkb9a2FPW
 O060qp+IrKAsJP5XX/29Zt+cixSYlaQxmGe26+Lh7npHE7D7NZbQe/d9AqPXoZgX0RERpeOGHhM
 SHDU//Seyn8gGKWNlVw==
X-Proofpoint-ORIG-GUID: PAgu7zi9yq047vkZXlF_0YN6EgWrwcm5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01

On Fri, Jul 10, 2026 at 11:05=E2=80=AFAM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> >
> This psp.py selftest was failing on my side when only using the
> drivers/net config file on top of the default one -- the recommended way
> to execute selftest targets.
>
> It looks like some kernel config are needed to execute the new tc
> commands.
>
> Note that this was not visible on NIPA, because these tests are executed
> with the drivers/net/hw ones, combining the two config files, and the hw
> one contains the missing ones.
>
> Fixes: 3f74d5bb807e ("selftests/net: Add env for container based tests")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> To: Andrew Lunn <andrew+netdev@lunn.ch>
> To: Alexei Starovoitov <ast@kernel.org>
> To: Daniel Borkmann <daniel@iogearbox.net>
> To: Jesper Dangaard Brouer <hawk@kernel.org>
> To: John Fastabend <john.fastabend@gmail.com>
> To: Stanislav Fomichev <sdf@fomichev.me>
> To: Mohsin Bashir <mohsin.bashr@gmail.com>
> To: David Wei <dw@davidwei.uk>
> Cc: Wei Wang <weibunny@fb.com>
> Cc: bpf@vger.kernel.org
> ---

The fix makes sense to me.

Reviewed-by: Wei Wang <weibunny@fb.com>

>  tools/testing/selftests/drivers/net/config | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/testing/selftests/drivers/net/config b/tools/testing/s=
elftests/drivers/net/config
> index 91d4fd410914..2070e890e064 100644
> --- a/tools/testing/selftests/drivers/net/config
> +++ b/tools/testing/selftests/drivers/net/config
> @@ -4,6 +4,8 @@ CONFIG_DEBUG_INFO_BTF_MODULES=3Dn
>  CONFIG_INET_PSP=3Dy
>  CONFIG_IPV6=3Dy
>  CONFIG_MACSEC=3Dm
> +CONFIG_NET_CLS_ACT=3Dy
> +CONFIG_NET_CLS_BPF=3Dy
>  CONFIG_NETCONSOLE=3Dm
>  CONFIG_NETCONSOLE_DYNAMIC=3Dy
>  CONFIG_NETCONSOLE_EXTENDED_LOG=3Dy
> @@ -11,6 +13,7 @@ CONFIG_NETDEVSIM=3Dm
>  CONFIG_NETKIT=3Dy
>  CONFIG_NET_SCH_ETF=3Dm
>  CONFIG_NET_SCH_FQ=3Dm
> +CONFIG_NET_SCH_INGRESS=3Dy
>  CONFIG_PPP=3Dy
>  CONFIG_PPPOE=3Dy
>  CONFIG_VLAN_8021Q=3Dm
>
> --
> 2.53.0
>

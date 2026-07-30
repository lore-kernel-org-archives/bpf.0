Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB783AE6FC
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 08:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785399117; cv=none; b=ZMyGKegfdvGVKRSyEH+LFOF+B0FTNyEYB1ttk9uwdJtghUpr26K4lnuNw8gO799jyjKvLdEMtJsUc/sTxO2cKCVKumfNtcBciwQQ3juyIcHQKIWVwl2dbDZGtBUqUeznVKOkIYCbvawFR9CFISzpX125FwSS43KO2EnGZcBfq3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785399117; c=relaxed/simple;
	bh=4QPs/GUSJjXu3SMPCjbKcTjBPS5rwxyVwdUg4pQ30iY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2bD2HqlRcBL1ghbk7gN8THTuFdnDvPPAWFTVl3QqFrLhaRzGtQ27X5h/So2m+VQG+UwDL7px57ceUnp/+ZUvWJX7Jhpg46BdDkj/odHUr+mU6ADyQwdawu5/Klip+icIcMHj3JmrSqEuC717+VWOJviEh494P/xJZKTP2dLeF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZPL/Ov1P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VEp8xNIa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZPL/Ov1P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VEp8xNIa"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U6aaN64139685
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 08:11:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u9UFoU4lYuyMXLSPiV/x+DNCpef+k8Qmi5vfYkwQM9o=; b=ZPL/Ov1PXckxn8rI
	NpElNpwLo67PAs0zeonbcKC0BDgiL/ZZiXMHP0TXWGlqOVfV7QMGGO95iSKcrdQ5
	ZKL1nVoevIKFgkVJD7WNWSlbvivpu+fSx4OUy15+8YIbD6Zee14vPbn5J7k7dGe8
	mj5Pw8aeJyZqjGxKItzQ1YFc81Nbamijpz8VFs9j0X0oCV5EO14Y3rthrkc6dzL3
	n9eqJlUbIoVtGTg4m9f4qZGqt0t6/SKtHSSdfLDvj4CZvXhWzhSufSr4d0jVIuFj
	5JGtNFoZKlY2MP9VLP8ui9OACbBP4kTW1VxDHCOumgdq0vILe4yO+RJpamY889Sn
	hlpzrA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr19grfp2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 08:11:52 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93106d8af18so165858085a.0
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 01:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785399111; x=1786003911; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u9UFoU4lYuyMXLSPiV/x+DNCpef+k8Qmi5vfYkwQM9o=;
        b=VEp8xNIaCx/w3d9q2snx9W2BtZla3Rp/vWRbtPfg4OrSvNfuFXa3hvby/5dNIRSGGU
         9BVuaTHrdhSpBW1eQ1XBhIYMMTImY8mUWbirPr4FY49en/OTK64YRHSLaYpUui2MBA+P
         6K2WEMeJTo1ML23t20wRyzKCsMYs9knJhiKuv80hOXOmqDwftu5jVfLhQl3I5ciTuVtF
         MBodzr1tfMKzAC43aOsyl0sZx+OvRoaAHOswRzcUIeVsJdjWrVaxC7RPg3QS5O3OxTFH
         A4aRcAZZb1ia3SWa5Y7vt0vf0ySc2jfdpEnjwoSfEDHLKdwNtiQ+LBQMtKbLGCyFBUN7
         TBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785399111; x=1786003911;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u9UFoU4lYuyMXLSPiV/x+DNCpef+k8Qmi5vfYkwQM9o=;
        b=Eu6xlAc2ojjQrAoz6LEMXHXceCXaKCWPZRyYcD+Eng82JEFDWUSQOwPXrs81hL7bRq
         j9B6sJ03LU10vb6IqEn+KuqfrhIlGFqzbNG1gDc1Yuav1WrXLP0gHW7wWNQLeGh1hICe
         lYykS4axd/aeRICEzCPxcFgYqJHnrYbufMmtMA7ws6hDbQkKpJKqPuQZcvUqpIHubdhu
         ilYCg3s6JOD2KjJl9cCkSHxOyFZxP5OvqEKMMyXuTsITGWS5hBnNfxjeASDaPllI74EQ
         Lq6/aNwsE9wwYmrQNGsL6n6Avh11Bkw0DGqnz4fv3QIlJTgNTZNciHreMmVEdoZt473L
         myRA==
X-Forwarded-Encrypted: i=1; AHgh+Roe71L6OCJqFno3yeIel8gYkEZ709skeuNz+9BRtGlk3eA3iI62xFfX3tNgGiikh3NyP/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrVRVkv1hvZdekdbx/Sjj/S9gMUUHvDkACP5gungLQKf+/Sy9S
	9A59loXg+jw0MquDiUYKPTMgyZ5GlsJowxzdfhdjjhF5+AB1xQDFl+Ph7nx6s5usNc7bXD/ghw1
	xfyJslm0Ow4yPy9xMxE+asJ1GBQU9Ka+ESwe7qurK28x0WloiDRZ2s3E=
X-Gm-Gg: AR+sD10fRZbIzi9hhgtxwGpXjGOV3KBPbjN8zKGeP6FqU6VIG1WRCtV4SpCHGSby5/d
	W2eXI0zaT2oAglnFLhniNKUPZKBBNeCJ2VVPq2bdEagX+ewZZMR47wp/96qN8TKf5WAPETrvREf
	WsZY30FD9ZnRDW/Li7YbOhkoepWsGLxTJw3a7cuGUVgSoeGbWJaPaAI5GTzuIhTdHlVcdM0Hq7Q
	osWYgnu6AFNsn7eTKuPqnmj6lVB0eJTddbXQBKnxtpVOzhkdQD03EvMLEjOz5xeA5wJWlFv3HXM
	pPCqUl2cX8M1rMa245CaRel2xEFvs3kV1849LLiAYPGY7G6roHRfzjKCxN46WjpcOQrbjr/AMzX
	H13mCYfPuFb364JJiFI89MiIz6rjkrAxA/0O54J4DUBx8QRpnxPg=
X-Received: by 2002:a05:622a:5910:b0:51c:1967:5091 with SMTP id d75a77b69052e-52b3866dd5emr18473271cf.41.1785399111460;
        Thu, 30 Jul 2026 01:11:51 -0700 (PDT)
X-Received: by 2002:a05:622a:5910:b0:51c:1967:5091 with SMTP id d75a77b69052e-52b3866dd5emr18473131cf.41.1785399110956;
        Thu, 30 Jul 2026 01:11:50 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4980120b42csm39840115e9.10.2026.07.30.01.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 01:11:50 -0700 (PDT)
Message-ID: <8ad47516-2747-45d1-ae25-e9ce068b7f3c@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 10:11:47 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] bpf, mips: Factor out div/mod emission
 helpers
Content-Language: en-US
To: Nicholas Dudar <main.kalliope@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
        memxor@gmail.com, tsbogend@alpha.franken.de,
        johan.almbladh@anyfinetworks.com, paulburton@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
        visitorckw@gmail.com, bpf@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.lau@kernel.org, clm@meta.com
References: <20260729162931.2369353-2-main.kalliope@gmail.com>
 <c517c61555d5ac0e7dda77c6f9a4e3624ef8ed742d6372ab3d5af4879291ec4f@mail.kernel.org>
 <CAJZwKkjS6aREL7zSXp-4XDL7aHjCmLpUFOyO8nPAiJMUtBgSTA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAJZwKkjS6aREL7zSXp-4XDL7aHjCmLpUFOyO8nPAiJMUtBgSTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA1OCBTYWx0ZWRfXw5ShlJJQWppE
 yY+YfSaAJx03+jcFD246K1CgpghgC9TYIIoZU4w+hazLw0hLeODdpX7LvsbCgwS4WeQL46HDLvO
 ez3cFhfpNMxUry2vOA+Ph0blfLzN6iGXqOThdmuvFrDCbejg49Jt4cgCReFBdwUPC8VyBRorW3n
 CNucgD2i25CY60LjwC3nQWFChvVZ+VI509BpEK5cCg8znOancm6CwmS6MJRSo47ck+BUCMwOkSV
 7pJhv6brzgxnG4haV/pJfnoGpcj6TUyg1VosNRuc+EOfWwTY7qXe9gEFYrkuhhdgmRLTm/791mG
 gSQf1vtOd4QVe20KMarFPgfME22fNvY+deu8YOBeeQJESGI+AzT2vxJNH9H4avplc4QQxs9W8o2
 V51oVtswtwrLrimEP6ivWBUSdVTWmBzTdJk9ueBKo4zn10d5lgu/tqi0ze7H3ZbIRQUAvlFCake
 GGRnN75hXpZmY+IMNaw==
X-Proofpoint-ORIG-GUID: 1OxrX74C0udIocmdaH6z3KP-9icMIdMK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA1OCBTYWx0ZWRfX8wiA+bLLDaYE
 m6y69VBma2XDAmoUiRZHgzulzkKmHhkX1maLOaLjPP1Oj0nf1HUcwlpasvyclMkJwJ4+JX9Fe0i
 /seX/YwVy1ZEBH6nQidhg8VYjURRFW0=
X-Proofpoint-GUID: 1OxrX74C0udIocmdaH6z3KP-9icMIdMK
X-Authority-Analysis: v=2.4 cv=d7bFDxjE c=1 sm=1 tr=0 ts=6a6b0748 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_02,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300058

On 29/7/26 20:54, Nicholas Dudar wrote:
>> This isn't a bug, but would a short header comment on emit_div() and
>> emit_mod(), in the style of the neighbouring '/* ALU register operation
>> (32-bit) */', keep these consistent with the rest of the file? Every
>> other emitter here carries one.
>>
>> Same for emit_div64() and emit_mod64() here.
> 
> Agreed that short comments would match the surrounding emitter style.
> I'll add them if the series needs another revision.

Thanks for the v2.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


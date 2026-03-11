Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79632F261C;
	Wed, 11 Mar 2026 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773241861; cv=none; b=gKP6GmbABJbanV68XJFpJxaQWrxHJdY4Y/58KB/2KSUcTuqVHrPankz2HXX9HdkMx8zHdJwSGn2ahtAKarGe+P1MshKDj8aYsbpTSQN0G6cLzoJkieqHnFkwhyEYQfxwRY/wPeBSSsFRRs47XBHN09n3t3YTjnMlVWhbf2cfuT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773241861; c=relaxed/simple;
	bh=NRC7ZXu5btyLwVSpA8VvZ0YBUdwBXShqd3tqgalLD4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J7ONqoNTPaGDMyvmzn8bKK10TihEVla77TPXDfvyWv1tlJSOR5WdjPaoY+/TsFS6Q0Du0ELyiRwsTvQln3wTLMjWQgS4ZxPci6dkTIbsMFx6aoNIXTwTg35JMCCE+q0zsADhuoEYhWaiZwPoS76p2QXRmDklP+FIqexmHK5PMp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B0HzN6He; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B0HzN6He"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BE2XoT1271651;
	Wed, 11 Mar 2026 15:10:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=amCQ1M
	PT1KYih44KaTGWV1mjOCXm8jh25zvzG3ZOi7c=; b=B0HzN6HeeqVzJX2wa6pLjL
	bScQMzw490VbGa7jBEcaEYpEXtcfJ7O5HzCopdjkBa4B94CA9SVQoM9wUjsqiilj
	DdozDE+kbYAaxeWQ4DWikdoGaai1ESgUHMHm9KcCoPjOUbWYwt5XW6xZf1dgiqGM
	7/G7FbH8vE3IT2mOe/Jk0xz4bV1GVFVWE+HFhduSD5eADpU6BeFLovkkSd8quDHF
	4gXIqtWKaf6rdBYZgHXTEuCz4EPe64sZ8Dvv4aIxF4RSXlQ//ah7EXKzM8dQ1cMT
	JSFqqIlDHYXmw/DXEU60cP9MtZ/QN/mF5QwBO6uX74FHGo1oSh8hvLLrKnb+dz9A
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcung0er-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 15:10:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62BC4TxL015629;
	Wed, 11 Mar 2026 15:10:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4crybndxua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 15:10:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62BFAWfG50200860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 15:10:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BF972004B;
	Wed, 11 Mar 2026 15:10:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E502520040;
	Wed, 11 Mar 2026 15:10:29 +0000 (GMT)
Received: from [9.43.104.94] (unknown [9.43.104.94])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Mar 2026 15:10:29 +0000 (GMT)
Message-ID: <bbf6a46c-37e9-4d8d-968e-a99bb12dcc14@linux.ibm.com>
Date: Wed, 11 Mar 2026 20:40:28 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/bpf: improve test coverage for kfunc call
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Eduard <eddyz87@gmail.com>, Vineet Gupta <vineet.gupta@linux.dev>,
        "Jose E. Marchesi" <jemarch@gnu.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20260303131453.328674-1-hbathini@linux.ibm.com>
 <CAADnVQKuARvSirPjnTcSifLPunCiKC4Nenq0Mr61GpzbW5WxWg@mail.gmail.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <CAADnVQKuARvSirPjnTcSifLPunCiKC4Nenq0Mr61GpzbW5WxWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: t_4kJIpTzNz-lzettM23PJ-KXu-uhYzd
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69b185eb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=STsw3Vc2TD3qxPjF4oIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEyNyBTYWx0ZWRfXwT8P/YKmFHIw
 mllH/UYbV4BKUFgCtAlpPKRdeymea9abOD2iapMNLR8d58DbP9KAWyqqBXyZs5Z2qP7GMEgNAaI
 HZ2R19W4ZWjhT5EjMX0d77ToBc5n1sw9keSFt9Spl+OzC7EySpAH24CWvCekK2NiB5mvETjpcu0
 nWb7RNzDO+qXITGUSVfTukCM41AhJUx/79lfAOajrcdt7a8l87J/SUskIFJ/HG06mjv47XaCD+E
 I8bwNoue2J7/l1FmP4anpZIAiuj9FLuobjmVCkPxcQq3UqUuDOsmFjBYndEeAmren5v+yCUtGBG
 WR7Fy0TDFWD/CT8iHNJLThhtyEHbFysDhPZx5utb6xJz3U2U+ACfGd41CoDnVTIMtuaQifGR1wt
 52VE6k6pmFQza1vXBylW/Uida2Epu1PrlLV6HHVtpMIi3US2nJCYjpPuqaz4jySBJ98JF26a1oW
 8I3qUy2s/mX+OOb4K4A==
X-Proofpoint-ORIG-GUID: 5QnvErwvkBK5pN4Dm8u-Ff4ZW6G7zuFh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110127

Hi Alexei,

Thanks for the review.

On 09/03/26 10:37 pm, Alexei Starovoitov wrote:
> On Tue, Mar 3, 2026 at 5:15 AM Hari Bathini <hbathini@linux.ibm.com> wrote:
>>
>>
>> +SEC("tc")
>> +int kfunc_call_test5(struct __sk_buff *skb)
>> +{
>> +       struct bpf_sock *sk = skb->sk;
>> +       int ret;
>> +       u32 val32;
>> +       u16 val16;
>> +       u8 val8;
>> +
>> +       if (!sk)
>> +               return -1;
>> +
>> +       sk = bpf_sk_fullsock(sk);
>> +       if (!sk)
>> +               return -1;
>> +
>> +       ret = bpf_kfunc_call_test5(0xFF, 0xFFFF, 0xFFFFFFFF);
> 
> maybe add a comment with bpf asm to highlight what this is ?
> 
> Also 0xFFFFffffULL ?
> 8 "F"s in a row is harder on the eyes.
> and ULL to make it explicit ?

True. Will do that.

>> +       if (ret)
>> +               return ret;
>> +
>> +       val32 = bpf_get_prandom_u32();
>> +       val16 = val32 & 0xFFFF;
>> +       val8 = val32 & 0xFF;
>> +       ret = bpf_kfunc_call_test5(val8, val16, val32);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = bpf_kfunc_call_test5(val8 * 0xFF, val16 * 0xFFFF, val32 * 0xFFFFFFFF);
> 
> I'm struggling to decipher it. Pls add a comment with asm to explain.
> I think the last multiplication is still done in 32-bit domain ?
> or not? 0xFFFFFFFF is a 64-bit constant in C. I think...

Sure. Let me add comments to convey the intention of the bpf programs
to avoid ambiguity..

> 
> Also we have 4 ISA versions. test_progs-no_alu32 and test_progs
> compile it differently.
> Maybe let's add another version of this test but fully in asm ?
> Keep the C version too.
> 
>> +       if (ret)
>> +               return ret;
>> +
>> +       return 0;
>> +}
>> +
>>   SEC("tc")
>>   int kfunc_call_test4(struct __sk_buff *skb)
>>   {
>> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>> index e62c6b78657f..de4897ddcff1 100644
>> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>> @@ -766,6 +766,33 @@ __bpf_kfunc long noinline bpf_kfunc_call_test4(signed char a, short b, int c, lo
>>          return (long)a + (long)b + (long)c + d;
>>   }
>>
>> +__bpf_kfunc int bpf_kfunc_call_test5(u8 a, u16 b, u32 c)
>> +{
>> +       /* Make val as volatile to avoid compiler optimizations on the below checks */
>> +       volatile long val = a;
> 
> Pls add a comment that this is zero extended in C.
> 
>> +
>> +       /* Check zero-extension */
>> +       if (val != (unsigned long)a)
>> +               return 1;
>> +       /* Check no sign-extension */
>> +       if (val < 0)
>> +               return 2;
>> +
>> +       val = b;
>> +       if (val != (unsigned long)b)
>> +               return 3;
>> +       if (val < 0)
>> +               return 4;
>> +
>> +       val = c;
>> +       if (val != (unsigned long)c)
>> +               return 5;
>> +       if (val < 0)
>> +               return 6;
>> +
>> +       return 0;
>> +}
> 
> Overall this looks very useful.
> I would expand with another test where a,b,c are s8,s16,s32.

Slightly different approach but kfunc_call_test4/bpf_kfunc_call_test4
cover signed arguments already?

> Please resend with [PATCH bpf-next] in the subject, so that CIs
> can pick it up correctly.
My bad. Will add the suffix while sending v2..

- Hari

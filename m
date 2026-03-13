Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446733C5DDE;
	Fri, 13 Mar 2026 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773420749; cv=none; b=s71+jWIfI1G9xaF3AeUmsXoFBzndzpH49e2b34HXOJwymb2LbpIs48GPGuB+8RL2RJTm7YgFOqIlRyvyDCcZKopnxdoWh46GLX/xyPcNzJqQFfE88JLmKhK9Ox8ZcsC294rSrHgQjmGKuLZF3lFshrFhjIiuw+NTbRugl1xkXac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773420749; c=relaxed/simple;
	bh=q54FFooi9TYoUDLzssQJ4YkpkMjrzanbg74Jao2ivAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OKyiWKCj9pF3BbN92Bq5JLmBXH2pY0KFekqXsGDb1RlAA346ZdF+3Eumj1rg7IKxgg52wVLOSbaN4+nVz1lm1U+3LL5ZjL6Vby66kqxactUBmkKPfPxsTwM+lNLb3kDZKp2NJvipMjQHFj+MZocq3qVzDt2Bs/tXtNhIwWecR2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GfQsk9do; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GfQsk9do"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D4Vg102278217;
	Fri, 13 Mar 2026 16:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AC2zBX
	F891MtSTStOPogcDxbY2Tjw+/PtdEifJjKKtg=; b=GfQsk9doJqFTBxBozMRjb4
	k+6j94ZOgbp8Lz8KbzEFU1yoWgIEcPw+K790Wdxqf0W5DYoaQbFr2Bxynqy2/N0F
	lMSKXVnqi2nhndLmn8v+MN9J5Lny9wkX6BT7WBoOxyjZT6MMg5+VIp4wPhsmMbrK
	R3E4k6btjXflC8jv+oSjdphyh52abK+sTZE0J0rs4ygJJ05PUIXKGD91s1c6uXrJ
	OehwhcfFt8CG2I+UmiI0QSMcImOLsAVGzOpLAs5Fh3xPuym9awDsj3tCAq5jvaWF
	h1zDHCGr8XCEJXucp8ZQew9VNfvLMwL+rX2nDAkOaYI2Doew2U7A6poyZCV5N25A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh91rtt3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 16:51:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DF2aJh006036;
	Fri, 13 Mar 2026 16:51:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha9qfmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 16:51:49 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62DGplG450266616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 16:51:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C96820043;
	Fri, 13 Mar 2026 16:51:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10CA720040;
	Fri, 13 Mar 2026 16:51:47 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.88.140])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Mar 2026 16:51:46 +0000 (GMT)
Message-ID: <86ea999a-12a9-426a-ab8b-abfc5efa8de4@linux.ibm.com>
Date: Fri, 13 Mar 2026 17:51:46 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] selftests/bpf: improve test coverage for
 kfunc call
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Hari Bathini <hbathini@linux.ibm.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20260312080113.843408-1-hbathini@linux.ibm.com>
 <02e68ebf-5782-4632-aed8-0026a3aab96b@linux.dev>
 <ec4e7ff6-55e3-4889-b507-fee71fab99f8@linux.ibm.com>
 <CAADnVQK--hKVH=FBMLiF7io2kBLfqwkXM9porBS1T--og=R4Yw@mail.gmail.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <CAADnVQK--hKVH=FBMLiF7io2kBLfqwkXM9porBS1T--og=R4Yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: uwxZQaOgW6aGcaadJEHNHSPRYhja9D63
X-Authority-Analysis: v=2.4 cv=E6/AZKdl c=1 sm=1 tr=0 ts=69b440a6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=L2Ql71LPTLevAORkKs8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEzMiBTYWx0ZWRfX2Q+j1MHcK8Tc
 7+q0kG+kmaj/wAuViNfTTTz5qA8X+xmb0jGB29MSpvspugosTWqd0XNkpANegcxcnMFZJk19YtY
 BOC/8qCaYJWVdRFVKKzuzmi0mjQwUzI+ChYOjGX/TSg9X2AIUIExt9G9ZE1fweeBN6D1nVByM/w
 QhpazVxWri1bpILh/jBhY+UhAMuWFNl2lLlxFYgRlPWFfkBaJY3R4pDp92T+jM00IQbtEClTtnD
 hQb00J9+8X8vyBzYJnnNrhlIZcnmWIePYMotAYcn+fJrhLX9HXjaDty/4I4XCZ+ddRtZzOKPjBN
 +elszvvHf6mzbhOdELuRHdsY/z+zf/r1juF2Fy9C9gco87y7kXNSZdFdtje+UDl9ewESdnyRlcK
 X1MmSNeRkOP/EDdOWVJEJ5l4UAphm1CuNKESeiuitOhkVXf1KT+25PvfWXtQ8ZYXCVbQSE3kxRV
 XxhUr5YmvpgdJQto1DA==
X-Proofpoint-ORIG-GUID: wC0qMM4hgjbjukEJuRVJaTWautxGqhg8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130132

On 3/13/26 15:20, Alexei Starovoitov wrote:
[...]
> I was about to apply it, but it fails on s390. See CI:
>
> Error: #160 kfunc_call
> Error: #160/13 kfunc_call/kfunc_call_test5_asm
> Error: #160/13 kfunc_call/kfunc_call_test5_asm
> verify_success:PASS:skel 0 nsec
> verify_success:PASS:bpf_object__find_program_by_name 0 nsec
> verify_success:PASS:kfunc_call_test5_asm 0 nsec
> verify_success:FAIL:retval unexpected retval: actual 6 != expected 0
> Test Results:
> bpftool: PASS
> test_progs: FAIL (returned 1)
>
> It doesn't look to be endianness related (which is often
> the case for breaking s390).
> In this case it could be an s390 JIT issue?
>
> Ilya ?
>
> pw-bot: cr

I implemented sign-extension required by the s390x ABI, but forgot about 
zero-extension.

I will send the fix soon, after ./test_progs completes.


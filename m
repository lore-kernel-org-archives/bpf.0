Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECA52848BB;
	Tue, 17 Feb 2026 12:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771332972; cv=none; b=kUwZ5SQC10HreLIQDOkQexesgYtxF4DitWBh5t0nGIOiKzA+sbQi3q+SQz90gIge2a9RuPXu+8f6E27CVK2khSpMXWzA0+RPmsjJsbcsDrmxJedM3hMKs6kFOoFOaAxJzri7nF6aZ/kMAGmN2xh6RAlYnVcCn5M0SrPGstFMduI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771332972; c=relaxed/simple;
	bh=KKmXqRdnf9otsggV2CwzQEXQbyGFlIsjANsPVJNvC/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uTtwCO/TXngh0T4ASjPOJ5QcHmCnCqeTamDSwbx7NvY1VrO4UX8QkLxhrSqeBY37RjEBBrA5Ufiyb+wdFXrf6XbAfJUbGQu0+H4u0QJ33PryEWi4qZLePD31yCvmqewwnYl3H2yrh6yT3SOVu9qmoBRRjhaE2PBjie0alvp0G4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Bl/3p1aT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Bl/3p1aT"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GNZGpP2711260;
	Tue, 17 Feb 2026 12:53:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sQ+uVO
	jbsI8+hN/+N+grsJoubrT4r9Lkm3o+6FEB1BU=; b=Bl/3p1aTZg9GNboxn1XOix
	5PjAMYOr2HoGGeUhnOXmXP4NT0NxHOJ0mXlOFBRmIZKOnWSQlwEWJH2Kj8kb8SCn
	UOPLdyNXt5E4cD7NslyqMpNT/gUKYoFiPD8bBtT2Fb5ZHtCalT95UIMvGJx7bELK
	NkHHqRNiLdvkoVXk4sHTarOKeeA+tKuX6ERMM9w4/9RlushfTd2ROw3UlCgWvC7M
	iPA3ibLSPY2iHfDC1T6eQ5+2N16a0i2blz11d4bM39B5CKCOe+K3Ipi80D8na7hj
	xg+Ns1m88DyHppFxzqZvnMq24lRXPCYpGygNYIZryH8K63hf7NaamubECErSrWLQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcqux1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 12:53:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61H8nVm5011920;
	Tue, 17 Feb 2026 12:53:50 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb26tf01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 12:53:50 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61HCrm2s16712168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 12:53:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24F0C200A7;
	Tue, 17 Feb 2026 12:53:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6E89200A9;
	Tue, 17 Feb 2026 12:53:47 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.136.123])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Feb 2026 12:53:47 +0000 (GMT)
Message-ID: <4085b3b0-3f3f-4d4c-8b10-78d144ed0883@linux.ibm.com>
Date: Tue, 17 Feb 2026 13:53:47 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/bpf: test accounting of tail calls when prog is
 NULL
To: Hari Bathini <hbathini@linux.ibm.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, linux-kselftest@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <20260216090802.1805655-1-hbathini@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260216090802.1805655-1-hbathini@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tptXIinyHf7B6l2YqZ8WTbW5oCCab6O2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEwNSBTYWx0ZWRfX1EJin8Vt6GwS
 CnvGTXGuv00FuBP+h4iBxV+u1u09oEwQJlMi/+HnFLLGAnykZBAvNvgj50UXvEAkKa6V2i741Qv
 q/wBGxnzEaBEfAPH/BxjDJTAcBsnqht8ru4tZisU2DooSdKueOxTWfv2LO9oiGbTlsJMg2WxJfp
 GetCHMC3PbhKY1p7lDLyMuyvRHAOASrp1gjjoeLs31xzo+fyWNpnZsPIb9eM/mLX2XLYdxP6Fqt
 WjMGN2+XSa+RfiewtNyYWY1SjSTP/wdvhRzf12KnfGXO4wRjoDtwRpxhlKsRzOmoQrnQBeZC5zW
 XlC7guLIfuNQ9OzsBDg9Hz06A8IXpt8Lz5kqKvWTYev1ry+3CHevvqNYIkapYLVZzBDzMk1aQt+
 DJV8nRdmGPoA4vGUYtYDoTW5nzycMRysvbWID3ELfkCEu9nBuJkClWwuwcdn5Uo3roWj3Byn8lB
 y+MVZ6z3n9p5WtpHYoA==
X-Authority-Analysis: v=2.4 cv=UPXQ3Sfy c=1 sm=1 tr=0 ts=699464df cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pqbiIwGrAfcC34Az2vkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: tptXIinyHf7B6l2YqZ8WTbW5oCCab6O2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170105


On 2/16/26 10:08, Hari Bathini wrote:
> Test whether tail call count is incorrectly accounted for, when the
> tail call fails due to a missing BPF program.
>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
>
> - powerpc64 BPF JIT has been incorrectly accounting for tailcall count
>    even when BPF program to tailcall into is missing. A simple change
>    to one of the tailcall selftests could have flagged it earlier.
>
>      https://lore.kernel.org/all/20260216065639.1750181-2-hbathini@linux.ibm.com/
>
>   tools/testing/selftests/bpf/progs/tailcall3.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/tailcall3.c b/tools/testing/selftests/bpf/progs/tailcall3.c
> index f60bcd7b8d4b..204f19c30a3e 100644
> --- a/tools/testing/selftests/bpf/progs/tailcall3.c
> +++ b/tools/testing/selftests/bpf/progs/tailcall3.c
> @@ -5,7 +5,7 @@
>   
>   struct {
>   	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> -	__uint(max_entries, 1);
> +	__uint(max_entries, 2);
>   	__uint(key_size, sizeof(__u32));
>   	__uint(value_size, sizeof(__u32));
>   } jmp_table SEC(".maps");
> @@ -23,6 +23,9 @@ int classifier_0(struct __sk_buff *skb)
>   SEC("tc")
>   int entry(struct __sk_buff *skb)
>   {
> +	/* prog == NULL case */
> +	bpf_tail_call_static(skb, &jmp_table, 1);
> +
>   	bpf_tail_call_static(skb, &jmp_table, 0);
>   	return 0;
>   }

Seems like the x86_64 JIT passes this already, but the interpreter still 
has:

         if (unlikely(tail_call_cnt >= MAX_TAIL_CALL_CNT))
             goto out;

         tail_call_cnt++;

         prog = READ_ONCE(array->ptrs[index]);
         if (!prog)
             goto out;

Should it be changed too? Regardless:

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


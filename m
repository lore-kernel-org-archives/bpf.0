Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0620322A;
	Fri, 20 Feb 2026 06:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771569299; cv=none; b=I+vDBYvbK/KuUUM4ipG/uMJM8yIIF1TZyxiErSgP0IZZuIniO0jdtJxpuNiss/L+xNdOk8Q30IgVx5n6o/4OvFcDlNM3MSbUUocuq66wvV953UqIcdltDCOmQKDFzNjV04PQLAcnjsyEfUcjvp4IitvpNaRq+FS7M4c872m2M0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771569299; c=relaxed/simple;
	bh=jcRFhBKmpxrt8/eYhbeF09z16jzOHC4vUYCwKmlwxbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aMWrpTVIkE4fh7YyBfuWt5y22WUga/qLjI5UDxa8+oIfGzFq3i2N3jBKGWKd9BsDp3AvCNL2wOnUBOvxWklpY3yWNWVr3jpXB66fcKAsF9dWRpS0D1RyZjir/QLoRiJGZ7aZMTDnIo57IBmHZZCSv+fl/poOa+Br04MRQqcpi6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gn1ferNn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gn1ferNn"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JKdbi31271172;
	Fri, 20 Feb 2026 06:34:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NzL2GO
	FdTGigo5lRA4Nbr0a7EdpbCkmRbPJyX9DjPig=; b=gn1ferNnsRudTICjFwkpcG
	m/weMlxHqoc6UWMyPy7er4ufmjhV7sSKg0Ff46OVP0iZ+d+cmUmCo2CiPXsVSW8T
	qbEq6KZYOhXcxPVWBkXUIQgSReqZsMyxfTpCdAiDhZ5unUFkfsCZCAVGCqOc9H4E
	i2TERrAIp8mYgF2IichdbkFSbwHFeYm281I0Lm6uH6wgR3VZQXu0cG+nQB0eCihc
	3P2th9QJOBekeiEJdXLSOawSBFT3h1u8/HLJbk0tvPbg5Q/yJ0CJ1Pm4MCRQPZaW
	/Tyrs44ErIBf+2Wo0lO3CYBxnzR327UICUstlcP1bqh0euzgrgpFpMWe1yDHGlGA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj4kra16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 06:34:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61K4GbsM030711;
	Fri, 20 Feb 2026 06:34:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb45fbt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 06:34:43 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61K6YgZq51708314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 06:34:42 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B88720043;
	Fri, 20 Feb 2026 06:34:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CA6E20040;
	Fri, 20 Feb 2026 06:34:40 +0000 (GMT)
Received: from [9.43.64.63] (unknown [9.43.64.63])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Feb 2026 06:34:40 +0000 (GMT)
Message-ID: <83243860-4c05-4a16-aeb2-7cc07fa1252e@linux.ibm.com>
Date: Fri, 20 Feb 2026 12:04:39 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/bpf: test accounting of tail calls when prog is
 NULL
To: Ilya Leoshkevich <iii@linux.ibm.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, linux-kselftest@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <20260216090802.1805655-1-hbathini@linux.ibm.com>
 <4085b3b0-3f3f-4d4c-8b10-78d144ed0883@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <4085b3b0-3f3f-4d4c-8b10-78d144ed0883@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDA1MiBTYWx0ZWRfX1zxgThUJFmuQ
 y/+QtLX6XIAv1YXcUwljg2z0cdUsQJkEcOjLRdQGSrCu6/r9iynUa8HhShzHZfFZVJMnZW8MgQS
 4Uk8oaUa0MrVJ90LyQJnN7lFKnRs8/9tELF+R4k1Wh9vvhv4kucl+cmKvWbseU2oj/d5Ru6ysZL
 4lBMuCVaKI0wgsu4qAMtnyy7cSRb+mqjo5e8+gTaq4JbFzHkiKkhe350n1dadbXdLrw4vMci8ej
 kmGLPUn9EbUeU9ym1EVJ52eAzuWQJehU5JBxwtZZ4Sdw4uihi6pUviXfek1UVeLxZGaUvAGCYRQ
 c77AtRVkgL/p8jfjheokQfsZqi471lnDGG/pQ2kJAsuJV3NEvrYO4UVojXYiMzp+/z/6PzfYQPO
 MxGNxEDyOsHgP9ZKyFO+QCnkrSsRn5J4wn2AuSmtB5Z2GmDmhYGCHP10UIGT2E2wQ/NGQA8ZJPD
 z4XrdW4f2yVbGvtpG3Q==
X-Proofpoint-ORIG-GUID: 960GySMTQiB8PS3P6cKv-r31fTILX4Kx
X-Proofpoint-GUID: 960GySMTQiB8PS3P6cKv-r31fTILX4Kx
X-Authority-Analysis: v=2.4 cv=M7hA6iws c=1 sm=1 tr=0 ts=69980084 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=5pFfz3ocJ-uwvMfrsKAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_06,2026-02-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200052



On 17/02/26 6:23 pm, Ilya Leoshkevich wrote:
> 
> On 2/16/26 10:08, Hari Bathini wrote:
>> Test whether tail call count is incorrectly accounted for, when the
>> tail call fails due to a missing BPF program.
>>
>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
>> ---
>>
>> - powerpc64 BPF JIT has been incorrectly accounting for tailcall count
>>    even when BPF program to tailcall into is missing. A simple change
>>    to one of the tailcall selftests could have flagged it earlier.
>>
>>      https://lore.kernel.org/all/20260216065639.1750181-2- 
>> hbathini@linux.ibm.com/
>>
>>   tools/testing/selftests/bpf/progs/tailcall3.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/tailcall3.c b/tools/ 
>> testing/selftests/bpf/progs/tailcall3.c
>> index f60bcd7b8d4b..204f19c30a3e 100644
>> --- a/tools/testing/selftests/bpf/progs/tailcall3.c
>> +++ b/tools/testing/selftests/bpf/progs/tailcall3.c
>> @@ -5,7 +5,7 @@
>>   struct {
>>       __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
>> -    __uint(max_entries, 1);
>> +    __uint(max_entries, 2);
>>       __uint(key_size, sizeof(__u32));
>>       __uint(value_size, sizeof(__u32));
>>   } jmp_table SEC(".maps");
>> @@ -23,6 +23,9 @@ int classifier_0(struct __sk_buff *skb)
>>   SEC("tc")
>>   int entry(struct __sk_buff *skb)
>>   {
>> +    /* prog == NULL case */
>> +    bpf_tail_call_static(skb, &jmp_table, 1);
>> +
>>       bpf_tail_call_static(skb, &jmp_table, 0);
>>       return 0;
>>   }
> 
> Seems like the x86_64 JIT passes this already, but the interpreter still 
> has:
> 
>          if (unlikely(tail_call_cnt >= MAX_TAIL_CALL_CNT))
>              goto out;
> 
>          tail_call_cnt++;
> 
>          prog = READ_ONCE(array->ptrs[index]);
>          if (!prog)
>              goto out;
> 
> Should it be changed too? Regardless:

Yeah, I guess. Posted 
https://lore.kernel.org/bpf/20260220062959.195101-1-hbathini@linux.ibm.com/

> 
> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

Thanks, Ilya.

- Hari

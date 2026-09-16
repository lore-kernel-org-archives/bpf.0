Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8544DF4B4;
	Wed, 16 Sep 2026 10:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789554824; cv=none; b=GO+R5u6wNl6xoAOvlhQna6VTGXnguJ2zHoD3QIJDeUT+A7XLkkmgHKlDHdeLAxT2IlUOoG5+SGkq3+uUaUkkZAOynoHEaqCDXCEmNmIbWDG+zANFOoM9kSZ3q4IfggLoJthfk/BdHaylY0rm8ONEeEu8XMdRLjyJhyWFxvJpBhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789554824; c=relaxed/simple;
	bh=d2geyMsNBTOOHKZfEQ320515mKz45HpvCBW07mHLmuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SJheKLmWYR0qoKZQ0svZKmFjOvM/UsoGoH6pMCtz/M7RNLGI+/yJqYq2C4B9lEWLr6/S3CER0rOeUoauUgRJv5TpttK84+Rqpp+JScHMXi8e44hb8Hqo/Kon/kMGhL/H3BDhPabOdwqR0I0hs6k4wgUODXoqD+9UxTrXE4k29gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FV25dpsP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FV25dpsP"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLVspj791787;
	Wed, 16 Sep 2026 10:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mTjoG3
	WVrM/I9AJe8x8ELwtCSLklrMet0zke+dNepGc=; b=FV25dpsPqWsf6GDBfYiI19
	3/mcmkETQHxXZ0IF0xVZY7W0CZXshCL84wvlaCD4OuDJUD05XNPG6wbwUYUsXz/g
	j+yWm6uSj0TQOMZ2UD8pHEaYTa6e53S49QTdIyDGG7At/acgmWf9knaozKMY5OfQ
	AOCS8tGpB+wNKc4o/sjuj63182UhcBKBnwLBwysqahrGTVKMBbISDTK6FQsJbCcm
	awCB1NUA7ylnslZyJMrYRpTRMt2bOGEiFf2WJJ7SNo1n7VPbO/LEPFHD0LtEUJ/8
	6fbS6kceRTLPjETS4TZuxNa9O2jPubg9jlYk5e4BVta9F2tu4Ya50U2j6hZ+XtOA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5e3s80-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 10:33:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68G7ZGhT464083;
	Wed, 16 Sep 2026 10:33:11 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gq03vdtnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 10:33:11 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68GAXAqV33751758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 10:33:10 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4024D58055;
	Wed, 16 Sep 2026 10:33:10 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC8F158063;
	Wed, 16 Sep 2026 10:33:05 +0000 (GMT)
Received: from [9.61.253.212] (unknown [9.61.253.212])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Sep 2026 10:33:05 +0000 (GMT)
Message-ID: <fac3bade-3152-490b-b557-22d6abe56b50@linux.ibm.com>
Date: Wed, 16 Sep 2026 16:03:04 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] powerpc/bpf: Kernel stack corruption in avc_has_perm()
 during BPF kselftests (test_progs)
To: Shrikanth Hegde <sshegde@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf <bpf@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eduard Zingerman
 <eddyz87@gmail.com>, yonghong.song@linux.dev,
        Alexei Starovoitov <ast@kernel.org>, andrii@kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <56d51dc6-f597-4cfa-b61c-b6b95d61ab86@linux.ibm.com>
 <46508541-55ab-4340-8871-924514ee8d5b@linux.ibm.com>
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <46508541-55ab-4340-8871-924514ee8d5b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDEzOCBTYWx0ZWRfX/tfu/7f6+CUZ
 SqZ8XiLBqWI7Lus+jh8nmfUke0YdIFNRZIpUrGJXbgsR3/E+1PBjAWQrx05T+CuE6PwJan/E2V7
 KkRdIygF49aGHljqwttC4HpVcqHvit0Axmm70+aV8xUqmwlzEYSjDd+JCjKoVBJTo4r4Rv7x45t
 Pv95CikB2BmHL9ZieU3ehQu7g69Ros4FqIZCcOG5m3RY8jiiuUcMZJfa2ds/g27r0w2zfdUOsOP
 899Q+oHtb8WW6rHujUYPmu0hyLXqh6rQXZbPDKdCO58LETbpG6Vk8nFcEiUSMg/+AurzqzuMRw+
 +mqrWUQoos3kA5Acqe/YvK/HslUg+EY9POMTZoX24fafk7hbf15T5eHyTOhzStpWyaknelEYK15
 ikULV0LV6vuS/JgVHJ6iStXt0NS0hVrx4jRxnuJLVr3+WMIzCxoJ+Xv3zO1uKbTlCnow2yq4mBa
 pUjh0gYT5P90ymtHN0A==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aaa7068 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=6zCX1olo2Mcs3fojgbkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GhwMK2bzqtSiB7ygT_iyaZZdvnTwOMjY
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDEzOCBTYWx0ZWRfX59mRAOtMlHEf
 pV7rl2RAyTf0M4JTV5wbRgJb/6Ti+vZLy91pioiBOCKHltPxO3H6sDDMFP8KStiQ3gS/pV++LLr
 V37VImKE00AQxC+JSsOb/4rNY9JEkNY=
X-Proofpoint-GUID: Gkg2wqQ5PA4Wu5DZ_cJO1oyLFUWSd1H_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160138


On 16/09/26 2:22 pm, Shrikanth Hegde wrote:
> Hi Venkat.
>
> Thanks for reporting.
>
> On 9/16/26 2:11 PM, Venkat Rao Bagalkote wrote:
>> Hello All!!!
>>
>>
>> IBM CI has reported a kernel panic on PowerPC (ppc64le, POWER9 
>> pSeries guest) while running BPF kselftests (test_progs).
>>
>
> What has changed in CI that it is hitting now?


Nothings in specific. Its just that, some of the tests were not run for 
some time, due to build and other issues.

>
>> Environment:
>>
>
> It is very likely same as
> https://lore.kernel.org/all/ba9759d0-b1f2-4b33-aff5-769cf89bd584@linux.ibm.com/ 
>
>
>>
>> Kernel version: 7.3.0-rc3-gf6e7b42bf05b (PREEMPT)
>> Architecture: ppc64le (POWER9 - IBM,8375-42A pSeries / phyp)
>> Test Suite: Avocado FVT / kselftests 
>> (tools/testing/selftests/bpf/test_progs)
>>
>>
>> Traces:
>>
>> [ 1359.516833] Kernel panic - not syncing: stack-protector: Kernel 
>> stack is corrupted in: avc_has_perm+0x23c/0x240
>> [ 1359.516856] CPU: 0 UID: 0 PID: 49806 Comm: test_progs Tainted: G   
>>    OE K     7.3.0-rc3-gf6e7b42bf05b #1 PREEMPT
>> [ 1359.516866] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE, 
>> [K]=LIVEPATCH
>> [ 1359.516870] Hardware name: IBM,8375-42A POWER9 (architected) 
>> 0x4e0202 0xf000005 of:IBM,FW950.80 (VL950_131) hv:phyp pSeries
>> [ 1359.516876] Call Trace:
>> [ 1359.516880] [c00000011bc67b10] [c0000000014627c0] 
>> dump_stack_lvl+0x84/0xc0 (unreliable)
>> [ 1359.516890] [c00000011bc67b40] [c000000000234840] vpanic+0x1b4/0x47c
>> [ 1359.516897] [c00000011bc67be0] [c000000000234b44] 
>> do_panic_on_target_cpu+0x0/0x2c
>> [ 1359.516906] [c00000011bc67c00] [c0000000014f8ce8] 
>> __stack_chk_fail+0x48/0x60
>> [ 1359.516913] [c00000011bc67c70] [c00000000092f0bc] 
>> avc_has_perm+0x23c/0x240
>> [ 1359.516920] [c00000011bc67d40] [c000000000936fc0] 
>> selinux_task_getpgid+0x80/0xa0
>> [ 1359.516927] [c00000011bc67d80] [c000000000920190] 
>> security_task_getpgid+0x70/0x1c0
>> [ 1359.516934] [c00000011bc67db0] [c000000000259488] 
>> do_getpgid+0xa8/0xf0
>> [ 1359.516941] [c00000011bc67de0] [c0000000002594f0] 
>> sys_getpgid+0x20/0x30
>> [ 1359.516948] [c00000011bc67e00] [c000000000034670] 
>> system_call_exception+0x160/0x480
>> [ 1359.516957] [c00000011bc67e50] [c00000000000d05c] 
>> system_call_vectored_common+0x15c/0x2ec
>>
>>
>> Please let us know if any further debugging or testing with specific 
>> BPF JIT options is needed.
>>
>>
>> Regards,
>>
>> Venkat.
>>
>
>

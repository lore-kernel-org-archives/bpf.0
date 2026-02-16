Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B352E313E2F;
	Mon, 16 Feb 2026 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254094; cv=none; b=knRkyP1OGEn1lSXebP+ZpOpdWEtD3nWHoJYJ6GIQ+Rsk+5oH1+o5DY+NTle+TT60Z3W30X7a6IQ7E7X60a9bKyj+UqivtJrExHnR8enGbIjMp/cAlk2NMYdzUtlV/6ZQttTB+CQ75irnTfMhV3zoHx5bS4KJfo9b8JMqE+5BiZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254094; c=relaxed/simple;
	bh=CEUYfp05A9YHWXZl7lqp+AtzHPpofyCpEJvkUthqJl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VhD39KCc8eWLvgx5CSr+HfK0StjkYYMtrrW6rFUhqqkuEERJVLTn3kcq3YBIf/F+91EJcJ0KDMXDDQHPoIRNy58fJaeRCDjir6+jdtuhO5Y9wjWWjCktpNooQj8T2QAaKpW55XJT2h8FuVwnLJ7B40eKUQZOwgkdr6VL0UEON6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NE9risyv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NE9risyv"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61G6dE822350407;
	Mon, 16 Feb 2026 15:01:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=imSVlc
	Ca9/qZ91X++XIJsMq8z8CZvUNQJJkQfE4RwnM=; b=NE9risyvPMvI4nxeouop5h
	b6olCWTGQGPw1fJWt3vm0ubbDLbrRj10OFaKoq2LKcRYubcT6lFTqd6/n3sXiZeb
	meoOIk5lhR+sL7Kuo0WXZ5CaDfBkACwusNJdxH2HIAeoJIc4gkL6uU/G61BkWi2O
	pw1FW7vXe1pU5JCKbknf5jJLL5vgYTRj2AbD/0lnIDpixJhWcEelBgm942AXwck7
	BskLkI29scYo3IjwKOGJNuNieliSCogNvwWvHob0YJ/bWJRRvF+xjLfHNVSRDTwM
	eN5ETlzF43S/cqqaClq3jlw2XDUhvzm7lfIMeMGD89Mexvp1Gprs4l7/fNui5PfQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6rr386-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 15:01:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61GCG5IV003762;
	Mon, 16 Feb 2026 15:01:05 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cb4cmws9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 15:01:05 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61GF15xO17760950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 15:01:05 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A04D5805C;
	Mon, 16 Feb 2026 15:01:05 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 210F55805F;
	Mon, 16 Feb 2026 15:01:03 +0000 (GMT)
Received: from [9.61.255.86] (unknown [9.61.255.86])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Feb 2026 15:01:02 +0000 (GMT)
Message-ID: <0cbbc97a-ebb8-41d8-ac88-2a954279d10c@linux.ibm.com>
Date: Mon, 16 Feb 2026 20:31:00 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/bpf: test accounting of tail calls when prog is
 NULL
Content-Language: en-GB
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, linux-kselftest@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <20260216090802.1805655-1-hbathini@linux.ibm.com>
 <3A7B8B6A-C91D-4322-907E-22E6268F469E@linux.ibm.com>
 <1463952f-ccdc-4496-8041-12fb79ef3e9e@linux.ibm.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <1463952f-ccdc-4496-8041-12fb79ef3e9e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=dvvWylg4 c=1 sm=1 tr=0 ts=69933132 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Z4Rwk6OoAAAA:8 a=IPz-mW2kSXcG9fERNwEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-GUID: 6TiinXUD8AGdPsgD1IUtlEpDlyg7NCdl
X-Proofpoint-ORIG-GUID: 6TiinXUD8AGdPsgD1IUtlEpDlyg7NCdl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDEyNSBTYWx0ZWRfXzDt1s4Njw2R/
 Z0fk4cZvlJG0E4vKklbfH/j9vaYZsMbb4SXeGqmTWnq3DrTQua/5A00rot7/qpljiaK6DZXkkoo
 Ks9mdfSingN96CY5MszPCFkk76NaI713oExB+xer6ZPMXFzmfG6983oYZvmHJVXXRU2dBlDrjbE
 DdJ1ZlQbpzTqo94VgmcF0wDgnSGwtp9E9zYhOgcjkDpXZkilHKemZfab20XcYdreCGKvipbKfXh
 OA9+qGVtVyYB1+4U4FujBlUs3IBKN8Ho45jWyn5RZCDzNxcwp2Y7eH4nq7BdrKN3qR4I3Uuyakd
 9ausqpiN45HR0/64ymU8PrD/6byWsGTHISjho/H0lkIG1VwlvTyE9A75PlgJwTNXmay0p2r2BE4
 /zt189QPhA2YYMFQ/S50NOBZT5hMZ/i9/l+QmvFQQpHYtIp0O5wEC1VmlU6pTq0SegoEMI6BKq5
 r/KTIHVTjnnB931lksg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602160125


On 16/02/26 4:41 pm, Hari Bathini wrote:
>
>
> On 16/02/26 4:38 pm, Venkat wrote:
>> Hello Hari,
>>
>> With this patch, tailcalls selftest is failing.
>>
>> # ./test_progs -t tailcalls
>> tester_init:PASS:tester_log_buf 0 nsec
>> process_subtest:PASS:obj_open_mem 0 nsec
>> process_subtest:PASS:specs_alloc 0 nsec
>> #448/1   tailcalls/tailcall_1:OK
>> #448/2   tailcalls/tailcall_2:OK
>> test_tailcall_count:PASS:tailcall 0 nsec
>> test_tailcall_count:PASS:tailcall retval 0 nsec
>> test_tailcall_count:PASS:tailcall count 0 nsec
>> test_tailcall_count:FAIL:tailcall count unexpected tailcall count: 
>> actual 32 != expected 33
>> test_tailcall_count:PASS:tailcall 0 nsec
>> test_tailcall_count:PASS:tailcall retval 0 nsec
>> #448/3   tailcalls/tailcall_3:FAIL
>> #448/4   tailcalls/tailcall_4:OK
>> #448/5   tailcalls/tailcall_5:OK
>> #448/6   tailcalls/tailcall_6:OK
>> #448/7   tailcalls/tailcall_bpf2bpf_1:OK
>> #448/8   tailcalls/tailcall_bpf2bpf_2:OK
>> #448/9   tailcalls/tailcall_bpf2bpf_3:OK
>> #448/10  tailcalls/tailcall_bpf2bpf_4:OK
>> #448/11  tailcalls/tailcall_bpf2bpf_5:OK
>> #448/12  tailcalls/tailcall_bpf2bpf_6:OK
>> #448/13  tailcalls/tailcall_bpf2bpf_fentry:OK
>> #448/14  tailcalls/tailcall_bpf2bpf_fexit:OK
>> #448/15  tailcalls/tailcall_bpf2bpf_fentry_fexit:OK
>> #448/16  tailcalls/tailcall_bpf2bpf_fentry_entry:OK
>> #448/17  tailcalls/tailcall_poke:OK
>> #448/18  tailcalls/tailcall_bpf2bpf_hierarchy_1:OK
>> #448/19  tailcalls/tailcall_bpf2bpf_hierarchy_fentry:OK
>> #448/20  tailcalls/tailcall_bpf2bpf_hierarchy_fexit:OK
>> #448/21  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_fexit:OK
>> #448/22  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_entry:OK
>> #448/23  tailcalls/tailcall_bpf2bpf_hierarchy_2:OK
>> #448/24  tailcalls/tailcall_bpf2bpf_hierarchy_3:OK
>> #448/25  tailcalls/tailcall_freplace:OK
>> #448/26  tailcalls/tailcall_bpf2bpf_freplace:OK
>> #448/27  tailcalls/tailcall_failure:OK
>> #448/28  tailcalls/reject_tail_call_spin_lock:OK
>> #448/29  tailcalls/reject_tail_call_rcu_lock:OK
>> #448/30  tailcalls/reject_tail_call_preempt_lock:OK
>> #448/31  tailcalls/reject_tail_call_ref:OK
>> #448/32  tailcalls/tailcall_sleepable:OK
>> #448     tailcalls:FAIL
>>
>> All error logs:
>> tester_init:PASS:tester_log_buf 0 nsec
>> process_subtest:PASS:obj_open_mem 0 nsec
>> process_subtest:PASS:specs_alloc 0 nsec
>> test_tailcall_count:PASS:tailcall 0 nsec
>> test_tailcall_count:PASS:tailcall retval 0 nsec
>> test_tailcall_count:PASS:tailcall count 0 nsec
>> test_tailcall_count:FAIL:tailcall count unexpected tailcall count: 
>> actual 32 != expected 33
>> test_tailcall_count:PASS:tailcall 0 nsec
>> test_tailcall_count:PASS:tailcall retval 0 nsec
>> #448/3   tailcalls/tailcall_3:FAIL
>> #448     tailcalls:FAIL
>> Summary: 0/31 PASSED, 0 SKIPPED, 1 FAILED
>>
>> Regards,
>> Venkat.
>>
>>> On 16 Feb 2026, at 2:38 PM, Hari Bathini <hbathini@linux.ibm.com> 
>>> wrote:
>>>
>>> Test whether tail call count is incorrectly accounted for, when the
>>> tail call fails due to a missing BPF program.
>>>
>>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
>>> ---
>>>
>>> - powerpc64 BPF JIT has been incorrectly accounting for tailcall count
>>>   even when BPF program to tailcall into is missing. A simple change
>>>   to one of the tailcall selftests could have flagged it earlier.
>>>
>
>>> https://lore.kernel.org/all/20260216065639.1750181-2-hbathini@linux.ibm.com/ 
>>>


Above patch was not applied, during the test.

>
> Hi Venkat,
>
> Can you confirm if the above kernel patch was used or not?


Its with only below patch. Please refer git log.


git log
commit cb50b08d0c45e7f97e1364075a5ee399c63422d5 (HEAD -> master)
Author: Hari Bathini <hbathini@linux.ibm.com>
Date:   Mon Feb 16 14:38:02 2026 +0530

     selftests/bpf: test accounting of tail calls when prog is NULL

     Test whether tail call count is incorrectly accounted for, when the
     tail call fails due to a missing BPF program.

     Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>

commit 0f2acd3148e0ef42bdacbd477f90e8533f96b2ac (origin/master, origin/HEAD)
Merge: 26a4cfaff82a a16ac6ca46d6
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Feb 15 19:45:00 2026 -0800


Regards,

Venkat.

>
> - Hari
>

Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CFA11CBA;
	Sat, 21 Feb 2026 03:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771645743; cv=none; b=QRuz+viDaBtnOJKmyodBQGJzTZ/JrgRn6p9t9ofq1mIVcIF6m4IliZMoxCIAaERhasb9yKHNnVFVI/QEZ1E26fjbcow37pm5tL8Fcj++wBlqOjZCfAIBvIt/zY06+Ox/6hS/fgDWonYdF4oNJZaTAmYQcz2zROBH12k0fvhPxI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771645743; c=relaxed/simple;
	bh=yIPrWu3jWajTK8gVqrvMryAejOBZgmVig9RekpyaP+g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XKaklA0HEsBedWP5rVLuH3P5yRfNppLkVvumTRPXl5knaCHqrs82YnChcstQ1aFZ6rMNqXzySNlMmohycxPei09nLlBPXoKRSEa+DzwX7snwsjJhF/9F/ldO69DSOsBffkGn1ZmF5j6Z17qJZxPrQ+Y6FucnRv8Hqo3K5mmX9Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hU1W3eQs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hU1W3eQs"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61L1lZZo1922106;
	Sat, 21 Feb 2026 03:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BZ/jyR
	98Le2KGW1IHJQZQMhWFJV+ETB90Iq76CNjXZ4=; b=hU1W3eQsFAbMBQa/cIoF1K
	lo9f9DWDYXMh3+46WVSl2BYTfaA4JdsNU7AHkDC/n66DC/pU7pzUASvUqWtMusDF
	Mkh07Hy024Tsno1qy8HiNavyHq9WOjz6eetTXgdBEtdtLNFXBuIVC9mrL94XrRKh
	t9K3IZTFz4z4BEfqRglpBx/l4zhxZYvTc4SJBk3o3V0iBFqCrIsYCWIub4IHEqxX
	eIwqegKNoHp5+h+uEzR9alFf/ouoa1tDtuBghAGZE2ZcvRP9+CqlA5V4Vchuo1R9
	ghSYR7RWGoudOwrrOfB1hAEz+ARwHplqDrKOMPdQ1yqzplLaEAFvYrKfRx/9i3Wg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf34br7r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Feb 2026 03:48:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61L0QC8J011898;
	Sat, 21 Feb 2026 03:48:48 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb27ayvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Feb 2026 03:48:48 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61L3mlnI29164262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Feb 2026 03:48:47 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E2025804E;
	Sat, 21 Feb 2026 03:48:47 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF7215803F;
	Sat, 21 Feb 2026 03:48:44 +0000 (GMT)
Received: from [9.61.251.42] (unknown [9.61.251.42])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 21 Feb 2026 03:48:44 +0000 (GMT)
Message-ID: <112376c3-7cae-471b-b425-98ae17284c2b@linux.ibm.com>
Date: Sat, 21 Feb 2026 09:18:43 +0530
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
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, linux-kselftest@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <20260216090802.1805655-1-hbathini@linux.ibm.com>
 <3A7B8B6A-C91D-4322-907E-22E6268F469E@linux.ibm.com>
 <1463952f-ccdc-4496-8041-12fb79ef3e9e@linux.ibm.com>
 <0cbbc97a-ebb8-41d8-ac88-2a954279d10c@linux.ibm.com>
In-Reply-To: <0cbbc97a-ebb8-41d8-ac88-2a954279d10c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIxMDAzNiBTYWx0ZWRfX2dz2bn3kErYb
 ryUsyXjuySXJY0Ow8xE/F6DfgSTC4ur0egdM0CpXHa+jO8cfMJRWFmNNxrqnA27RvF2unwy2bjj
 Yu11Cf7QHSjT7hvayDHJD1TxO3UDT7MVfuI98LvLkxcUvJzGfIWW8nk3uqehhJ6fb5l04dTn9IL
 /fCO1HtN78X+u5FGbgrVNrNrajYtBtkT79BQ6Uf22P8M/OMakJIZFDGIr/r+jbnNXXfX0L5ZBBt
 c7S4WFfbFV0iOo9rd8wZlB9GVNgjMLMgZLXXPdEwtnXNGVBO1ECOeU0rFHODg6C0AXuPRPw7PNe
 ztsRGA5lfNm31b0j7EHXJdJyC/ZkU7MsKpcT4t58vnxtXOyn5VOoFeMkp5Q2Y/Nm2YM+2fGmdZc
 jZjSUQT5i21KPtqzOiXvOsX3tTh7X9HUdl3F33fNXs9SVrutUZuLagyAFK8qI502zeuI/ElhvLY
 fOLbPvwTJXNnUusQRBg==
X-Proofpoint-ORIG-GUID: VbPHxn3kn-yQQ940Lvscsr1y3fiEekN0
X-Authority-Analysis: v=2.4 cv=F9lat6hN c=1 sm=1 tr=0 ts=69992b20 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Z4Rwk6OoAAAA:8 a=TXWCOjKJl8BBEJDdKSEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-GUID: VbPHxn3kn-yQQ940Lvscsr1y3fiEekN0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-21_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602210036


On 16/02/26 8:31 pm, Venkat Rao Bagalkote wrote:
>
> On 16/02/26 4:41 pm, Hari Bathini wrote:
>>
>>
>> On 16/02/26 4:38 pm, Venkat wrote:
>>> Hello Hari,
>>>
>>> With this patch, tailcalls selftest is failing.
>>>
>>> # ./test_progs -t tailcalls
>>> tester_init:PASS:tester_log_buf 0 nsec
>>> process_subtest:PASS:obj_open_mem 0 nsec
>>> process_subtest:PASS:specs_alloc 0 nsec
>>> #448/1   tailcalls/tailcall_1:OK
>>> #448/2   tailcalls/tailcall_2:OK
>>> test_tailcall_count:PASS:tailcall 0 nsec
>>> test_tailcall_count:PASS:tailcall retval 0 nsec
>>> test_tailcall_count:PASS:tailcall count 0 nsec
>>> test_tailcall_count:FAIL:tailcall count unexpected tailcall count: 
>>> actual 32 != expected 33
>>> test_tailcall_count:PASS:tailcall 0 nsec
>>> test_tailcall_count:PASS:tailcall retval 0 nsec
>>> #448/3   tailcalls/tailcall_3:FAIL
>>> #448/4   tailcalls/tailcall_4:OK
>>> #448/5   tailcalls/tailcall_5:OK
>>> #448/6   tailcalls/tailcall_6:OK
>>> #448/7   tailcalls/tailcall_bpf2bpf_1:OK
>>> #448/8   tailcalls/tailcall_bpf2bpf_2:OK
>>> #448/9   tailcalls/tailcall_bpf2bpf_3:OK
>>> #448/10  tailcalls/tailcall_bpf2bpf_4:OK
>>> #448/11  tailcalls/tailcall_bpf2bpf_5:OK
>>> #448/12  tailcalls/tailcall_bpf2bpf_6:OK
>>> #448/13  tailcalls/tailcall_bpf2bpf_fentry:OK
>>> #448/14  tailcalls/tailcall_bpf2bpf_fexit:OK
>>> #448/15  tailcalls/tailcall_bpf2bpf_fentry_fexit:OK
>>> #448/16  tailcalls/tailcall_bpf2bpf_fentry_entry:OK
>>> #448/17  tailcalls/tailcall_poke:OK
>>> #448/18  tailcalls/tailcall_bpf2bpf_hierarchy_1:OK
>>> #448/19  tailcalls/tailcall_bpf2bpf_hierarchy_fentry:OK
>>> #448/20  tailcalls/tailcall_bpf2bpf_hierarchy_fexit:OK
>>> #448/21  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_fexit:OK
>>> #448/22  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_entry:OK
>>> #448/23  tailcalls/tailcall_bpf2bpf_hierarchy_2:OK
>>> #448/24  tailcalls/tailcall_bpf2bpf_hierarchy_3:OK
>>> #448/25  tailcalls/tailcall_freplace:OK
>>> #448/26  tailcalls/tailcall_bpf2bpf_freplace:OK
>>> #448/27  tailcalls/tailcall_failure:OK
>>> #448/28  tailcalls/reject_tail_call_spin_lock:OK
>>> #448/29  tailcalls/reject_tail_call_rcu_lock:OK
>>> #448/30  tailcalls/reject_tail_call_preempt_lock:OK
>>> #448/31  tailcalls/reject_tail_call_ref:OK
>>> #448/32  tailcalls/tailcall_sleepable:OK
>>> #448     tailcalls:FAIL
>>>
>>> All error logs:
>>> tester_init:PASS:tester_log_buf 0 nsec
>>> process_subtest:PASS:obj_open_mem 0 nsec
>>> process_subtest:PASS:specs_alloc 0 nsec
>>> test_tailcall_count:PASS:tailcall 0 nsec
>>> test_tailcall_count:PASS:tailcall retval 0 nsec
>>> test_tailcall_count:PASS:tailcall count 0 nsec
>>> test_tailcall_count:FAIL:tailcall count unexpected tailcall count: 
>>> actual 32 != expected 33
>>> test_tailcall_count:PASS:tailcall 0 nsec
>>> test_tailcall_count:PASS:tailcall retval 0 nsec
>>> #448/3   tailcalls/tailcall_3:FAIL
>>> #448     tailcalls:FAIL
>>> Summary: 0/31 PASSED, 0 SKIPPED, 1 FAILED
>>>
>>> Regards,
>>> Venkat.
>>>
>>>> On 16 Feb 2026, at 2:38 PM, Hari Bathini <hbathini@linux.ibm.com> 
>>>> wrote:
>>>>
>>>> Test whether tail call count is incorrectly accounted for, when the
>>>> tail call fails due to a missing BPF program.
>>>>
>>>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
>>>> ---
>>>>
>>>> - powerpc64 BPF JIT has been incorrectly accounting for tailcall count
>>>>   even when BPF program to tailcall into is missing. A simple change
>>>>   to one of the tailcall selftests could have flagged it earlier.
>>>>
>>
>>>> https://lore.kernel.org/all/20260216065639.1750181-2-hbathini@linux.ibm.com/ 
>>>>
>
Tested by applying V2 version of above patch series, and tested this 
patch, and the test passes.


Logs:

./test_progs -t tailcalls
#448/1   tailcalls/tailcall_1:OK
#448/2   tailcalls/tailcall_2:OK
#448/3   tailcalls/tailcall_3:OK
#448/4   tailcalls/tailcall_4:OK
#448/5   tailcalls/tailcall_5:OK
#448/6   tailcalls/tailcall_6:OK
#448/7   tailcalls/tailcall_bpf2bpf_1:OK
#448/8   tailcalls/tailcall_bpf2bpf_2:OK
#448/9   tailcalls/tailcall_bpf2bpf_3:OK
#448/10  tailcalls/tailcall_bpf2bpf_4:OK
#448/11  tailcalls/tailcall_bpf2bpf_5:OK
#448/12  tailcalls/tailcall_bpf2bpf_6:OK
#448/13  tailcalls/tailcall_bpf2bpf_fentry:OK
#448/14  tailcalls/tailcall_bpf2bpf_fexit:OK
#448/15  tailcalls/tailcall_bpf2bpf_fentry_fexit:OK
#448/16  tailcalls/tailcall_bpf2bpf_fentry_entry:OK
#448/17  tailcalls/tailcall_poke:OK
#448/18  tailcalls/tailcall_bpf2bpf_hierarchy_1:OK
#448/19  tailcalls/tailcall_bpf2bpf_hierarchy_fentry:OK
#448/20  tailcalls/tailcall_bpf2bpf_hierarchy_fexit:OK
#448/21  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_fexit:OK
#448/22  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_entry:OK
#448/23  tailcalls/tailcall_bpf2bpf_hierarchy_2:OK
#448/24  tailcalls/tailcall_bpf2bpf_hierarchy_3:OK
#448/25  tailcalls/tailcall_freplace:OK
#448/26  tailcalls/tailcall_bpf2bpf_freplace:OK
#448/27  tailcalls/tailcall_failure:OK
#448/28  tailcalls/reject_tail_call_spin_lock:OK
#448/29  tailcalls/reject_tail_call_rcu_lock:OK
#448/30  tailcalls/reject_tail_call_preempt_lock:OK
#448/31  tailcalls/reject_tail_call_ref:OK
#448/32  tailcalls/tailcall_sleepable:OK
#448     tailcalls:OK
Summary: 1/32 PASSED, 0 SKIPPED, 0 FAILED


Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>



My bad, I didnt apply the related patches, when I tested earlier.


Regards,

Venkat.

>
> Above patch was not applied, during the test.
>
>>
>> Hi Venkat,
>>
>> Can you confirm if the above kernel patch was used or not?
>
>
> Its with only below patch. Please refer git log.
>
>
> git log
> commit cb50b08d0c45e7f97e1364075a5ee399c63422d5 (HEAD -> master)
> Author: Hari Bathini <hbathini@linux.ibm.com>
> Date:   Mon Feb 16 14:38:02 2026 +0530
>
>     selftests/bpf: test accounting of tail calls when prog is NULL
>
>     Test whether tail call count is incorrectly accounted for, when the
>     tail call fails due to a missing BPF program.
>
>     Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
>
> commit 0f2acd3148e0ef42bdacbd477f90e8533f96b2ac (origin/master, 
> origin/HEAD)
> Merge: 26a4cfaff82a a16ac6ca46d6
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sun Feb 15 19:45:00 2026 -0800
>
>
> Regards,
>
> Venkat.
>
>>
>> - Hari
>>

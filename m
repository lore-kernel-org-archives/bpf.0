Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ABF22256F;
	Fri, 13 Mar 2026 09:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773394217; cv=none; b=JMqEAM6pv9b9SKwbE7ASIkC/36th3s6bNpZH+G56OgQsiBO99A73R9XtaGysbj6stEQtStw2fiRVKRTH8Z4UuATpD49eLnxYPIVFhBVplIgUjWtHcVSn7UAYdzqaG1pxyYHTmF5lKRnO2WHQd/AEq5PhEXbGwFmNbHZrYfnoaTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773394217; c=relaxed/simple;
	bh=qc05WWl7Lm9nFXBtakuH0KvtMf5pk/h1eBlPEav4eoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a4kGqKCNBBY+PmhQ2MS5Kk7dHzC7pQpXIJnxDzFfqXghrscETR82YOEwf34eEg3cnm7Xg3QhD+1DwS6FT8CLgyGOscW3DrQ9NtHnPlqs7dg+fz36GrYFNU73M95NZUoxgO3r5UQ0LF8/3cFKsqBFeTlscKK3tMv4w2qPWCYeX+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VETa/Vrh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VETa/Vrh"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D6ZZER2206305;
	Fri, 13 Mar 2026 09:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HE5Qi3
	EihYLD8YY4FpHuo1qkorI6ypCTOKTEtMLwtPE=; b=VETa/Vrh++h4coO1YfSlnp
	yhuaT0ftUwRy+uWGwlvIDYctkWDxAnH5I1GPqlOYS9mmlTrAsrEQHLgqJeevExVH
	Cqu/bKawYnJnnojM1AUdj4RW+tvsQztlQCquVKdIe8z0KuWXZL1najqspS6+YK6s
	6SKIbSKdTjjiSNhsi3Anl3WihxoXaPErToNZ6pYTRps8rl0OoxU2Bt1b1htCgGWt
	GEtQ6C0uFWzAp8SGaiOkN9gY4E6glhr1SYSZMixdKFmn745hzAGWMv/qw2n/gKoj
	XSlyS4PP1Wk9uZKbhsTtNoUI1TJA7cQdhP8oBR8a0KgG5VsFI1iM2/SzQ1ub8WsQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh98es5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 09:29:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62D5O8XI025686;
	Fri, 13 Mar 2026 09:29:56 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha8e1ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 09:29:56 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62D9TsZT46334426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 09:29:54 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFDDD2004F;
	Fri, 13 Mar 2026 09:29:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F2DC20043;
	Fri, 13 Mar 2026 09:29:53 +0000 (GMT)
Received: from [9.78.106.17] (unknown [9.78.106.17])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Mar 2026 09:29:53 +0000 (GMT)
Message-ID: <ec4e7ff6-55e3-4889-b507-fee71fab99f8@linux.ibm.com>
Date: Fri, 13 Mar 2026 14:59:52 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] selftests/bpf: improve test coverage for
 kfunc call
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
References: <20260312080113.843408-1-hbathini@linux.ibm.com>
 <02e68ebf-5782-4632-aed8-0026a3aab96b@linux.dev>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <02e68ebf-5782-4632-aed8-0026a3aab96b@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M+pA6iws c=1 sm=1 tr=0 ts=69b3d915 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=wFA0YCTz-keeHaNuyW8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: uNo_lfeklqp90At1W4DnGwbnh_K-iSrO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA2OSBTYWx0ZWRfX0vxJCrOZ0oPL
 arfsMnBfTWl4syhgNkBS3wvrnCN1Nw1KK7nKDxfMPLa0Mxrai+WOUq9LjP1f9nYoyC3U75ImK4w
 3uaoGp2YbsIKRgYw4kB/UazYPTKKj9jUyWTOCU95CKvOfrYZZzQt4F5/M7kUPsgiAB1/VK80eL6
 Y0tB6O+cC6p5nuwILb/lfwW/jmisz2z1YrG/hfsSG6/0UtQcv4+Sdsp2J/p2/4VPEo5D94H8VWi
 X6WWKikcH4F8720rOOR6fq4mv4zk8Sv3jgSCrRfr0JfO51XWkEcZUYXFcrmhTCfO6Xp6eNOq7bj
 zIQy8DYmYRKwzn95bzau48mEXzgBNAUPAeOD+F9DXUvWvJxPLehm/QmfHIEDidSVAWYPBsfIP2+
 8ut3vffFCG0JzLT5A06O3Ewk0N/83i06w/c9mCvE4qh4MJhBQpekxTqw2uTNJfRphy7CaSeWsDA
 3aY1jNIfrSCk4sXf+KQ==
X-Proofpoint-ORIG-GUID: uNo_lfeklqp90At1W4DnGwbnh_K-iSrO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130069



On 12/03/26 11:52 pm, Yonghong Song wrote:
> 
> 
> On 3/12/26 1:01 AM, Hari Bathini wrote:
>> On powerpc, immediate load instructions are sign extended. In case
>> of unsigned types, arguments should be explicitly zero-extended by
>> the caller. For kfunc call, this needs to be handled in the JIT code.
>> In bpf_kfunc_call_test4(), that tests for sign-extension of signed
>> argument types in kfunc calls, add some additional failure checks.
>> And add bpf_kfunc_call_test5() to test zero-extension of unsigned
>> argument types in kfunc calls.
>>
>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> 
> LGTM with a nit below.
> 
> Acked-by: Yonghong Song <yonghong.song@linux.dev>

Thanks for the review, Yonghong.

> 
>> ---
>>
>> Changes in v2:
>> - Added asm version of the selftest for consistent testing across
>>    different BPF ISA versions.
>> - Added comments clearly stating the intent of the test cases.
>> - Updated sign-extension selftest to have additional failure checks.
>>
>>
>>   .../selftests/bpf/prog_tests/kfunc_call.c     |  2 +
>>   .../selftests/bpf/progs/kfunc_call_test.c     | 98 +++++++++++++++++++
>>   .../selftests/bpf/test_kmods/bpf_testmod.c    | 54 +++++++++-
>>   .../bpf/test_kmods/bpf_testmod_kfunc.h        |  1 +
>>   4 files changed, 154 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c b/ 
>> tools/testing/selftests/bpf/prog_tests/kfunc_call.c
>> index f79c8e53cb3e..62f3fb79f5d1 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
>> @@ -74,6 +74,8 @@ static struct kfunc_test_params kfunc_tests[] = {
>>       TC_TEST(kfunc_call_test1, 12),
>>       TC_TEST(kfunc_call_test2, 3),
>>       TC_TEST(kfunc_call_test4, -1234),
>> +    TC_TEST(kfunc_call_test5, 0),
>> +    TC_TEST(kfunc_call_test5_asm, 0),
>>       TC_TEST(kfunc_call_test_ref_btf_id, 0),
>>       TC_TEST(kfunc_call_test_get_mem, 42),
>>       SYSCALL_TEST(kfunc_syscall_test, 0),
>> diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_test.c b/ 
>> tools/testing/selftests/bpf/progs/kfunc_call_test.c
>> index 8b86113a0126..5edc51564f71 100644
>> --- a/tools/testing/selftests/bpf/progs/kfunc_call_test.c
>> +++ b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
>> @@ -2,8 +2,106 @@
>>   /* Copyright (c) 2021 Facebook */
>>   #include <vmlinux.h>
>>   #include <bpf/bpf_helpers.h>
>> +#include "bpf_misc.h"
>>   #include "../test_kmods/bpf_testmod_kfunc.h"
>> +SEC("tc")
>> +int kfunc_call_test5(struct __sk_buff *skb)
>> +{
>> +    struct bpf_sock *sk = skb->sk;
>> +    int ret;
>> +    u32 val32;
>> +    u16 val16;
>> +    u8 val8;
>> +
>> +    if (!sk)
>> +        return -1;
>> +
>> +    sk = bpf_sk_fullsock(sk);
>> +    if (!sk)
>> +        return -1;
>> +
>> +    /*
>> +     * Test with constant values to verify zero-extension.
>> +     * ISA-dependent BPF asm:
>> +     *   With ALU32:    w1 = 0xFF; w2 = 0xFFFF; w3 = 0xFFFFffff
>> +     *   Without ALU32: r1 = 0xFF; r2 = 0xFFFF; r3 = 0xFFFFffff
>> +     * Both zero-extend to 64-bit before the kfunc call.
>> +     */
>> +    ret = bpf_kfunc_call_test5(0xFF, 0xFFFF, 0xFFFFffffULL);
> 
> Can we just use 0xFFFFffff instead of 0xFFFFffffULL?

Alexei, can you confirm if I need to respin with this change?

- Hari


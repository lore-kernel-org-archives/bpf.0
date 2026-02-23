Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DF823EA8B
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 19:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771875192; cv=none; b=cWdt4AmiUD4118v0g+bzh8O3P4B4gEDF45RX1oXGzzAOjuGi4q8/vvNibUdV33db77Mlnu77y37KzKcFiUUa/8VoSzAQ7cOuoA3YOQHqYOStx1/YWRMxy8CQn1EywH4Gp1ln/el4foYnNE5v6t3D0VhM2EGn6uTAtbW75gdn0a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771875192; c=relaxed/simple;
	bh=H92Fngy2jMaCQ9z6mHQcAPKLql/LE6cWbhzQviHkSeM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Gk5Zn/352Z/at0TR3tbdsnduOkaU2mU41Mq9EzQge8UvAFbqOQlMf+lEA/4NI+OjpliJHwlsnBd9Y5b4XJCPnI4tXlGwNG8fIbe5ZsqfsEWUPJlzG4LcvW2CBBycedDesQok1yEfjpSVxwXYa8k5BSXOGsGy0C4cvWCP53ngTMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KL5ZFkgq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KL5ZFkgq"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NITKG23172107;
	Mon, 23 Feb 2026 19:32:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+HAthE
	MD6C8u01c3UOpX9clz4coYeUnj/3U5RORe4cs=; b=KL5ZFkgqbKK8ko+Ncz0rsk
	OPQtmpgf3kPFesiDhR/mxfHNGaEG+eGum+khcj68nFWXs/4WHDXQlJ3EpZUhbPrw
	JkvKzfC4H9xNcWZCcLtj4YcmsW3kgu2BAaizYaho1a1hIMAOkT+VBiqAnumaAUQS
	8QSqNFcxui/QchcbmUKA0oCggUEHfqumMxzlidkAMj02bzufd0RQ/4oFANqhDFLU
	9HafE6IfPOcQ++fs0D7m9Rz7U2QPanqgn8EtlAyjZCDOb8lYcz/dUgzowNGx0VQY
	SgoBgo173eFueWUxPgWl9lMiVhmUOxvtv/re6sPZGFHqJ84CTRXIA1gyL5Ta/fbg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4cqrhhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 19:32:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61NG6JRs030298;
	Mon, 23 Feb 2026 19:32:40 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfrhk5xhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 19:32:40 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61NJWdQW20120074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 19:32:40 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2FE35805F;
	Mon, 23 Feb 2026 19:32:39 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A15BA58043;
	Mon, 23 Feb 2026 19:32:38 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Feb 2026 19:32:38 +0000 (GMT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 24 Feb 2026 01:02:38 +0530
From: adubey <adubey@linux.ibm.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: bpf@vger.kernel.org, hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
        clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH 2/2] selftests/bpf: Enable private stack tests for
 powerpc64
In-Reply-To: <1956c912-c880-4214-9bc3-e205902459b5@kernel.org>
References: <20260216152234.36632-1-adubey@linux.ibm.com>
 <20260216152234.36632-2-adubey@linux.ibm.com>
 <1956c912-c880-4214-9bc3-e205902459b5@kernel.org>
Message-ID: <4cfdd14fac3c4091c6616decfc5d6ab9@linux.ibm.com>
X-Sender: adubey@linux.ibm.com
Organization: IBM
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: EXtVg3WTOAebkMJ6Cyw6AXFkRhwBRc3L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE2NiBTYWx0ZWRfX2rC4xsxuUKjX
 xb2ITekNjn3DAZocQdBP7qq8+tfePxbCdSi2X5fZetY7yGEiI8cB4pzyrLY54YKyHfw6ymnynJR
 d6u8jzIkMW4vlA/PmtDdzzJWsCEQuxrHXuQzHD1kshmwWvH64UxOQxvkDv0pJjHx5ODgCprSOXm
 9cVqyDzTvm8FFOcXzJBdPAvro5ntVD/OT8FYX2dWlM8gZxCgtMuswTxxKhHQE446h5ovAVUDemj
 4CHHDx2mx1rvg7+n0DYOdCNMuQynycG1rvzkYENVROTfoXytmqvSo9EKVObq7zwW9vUNZiSFg0T
 ERogrBcunTlJlrDii/6bRVIWUxzNhQ7nQYatvR13jKvYlmArCw+OYQYqZs0fzwwPrLpAtDtVE2v
 c9JDltkZAsbj1X6o5pi9tR0ACLhB+HQg3tGKWWDjl/2LIa59Ehss77ERWhtedWcAk5jFjRm+Drz
 vjaWWUPcf7vg5u2Xn+w==
X-Proofpoint-GUID: gUw0PTrM_Pjy2ZOqm6Xa5dgujYzcmh57
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=699cab5a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=qmUj5T3_vRBoYhgTJiUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_04,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602230166

On 2026-02-23 16:41, Christophe Leroy (CS GROUP) wrote:
> Le 16/02/2026 à 16:22, adubey@linux.ibm.com a écrit :
>> From: Abhishek Dubey <adubey@linux.ibm.com>
>> 
>> With support of private stack, relevant tests must pass
>> on powerpc64.
>> 
>> #./test_progs -t struct_ops_private_stack
>> #434/1   struct_ops_private_stack/private_stack:OK
>> #434/2   struct_ops_private_stack/private_stack_fail:OK
>> #434/3   struct_ops_private_stack/private_stack_recur:OK
>> #434     struct_ops_private_stack:OK
>> Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED
>> 
>> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
>> ---
>>   tools/testing/selftests/bpf/progs/struct_ops_private_stack.c   | 3 
>> ++-
>>   .../selftests/bpf/progs/struct_ops_private_stack_fail.c        | 3 
>> ++-
>>   .../selftests/bpf/progs/struct_ops_private_stack_recur.c       | 3 
>> ++-
>>   3 files changed, 6 insertions(+), 3 deletions(-)
>> 
>> diff --git 
>> a/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c 
>> b/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
>> index dbe646013811..1df1111cd029 100644
>> --- a/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
>> +++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
>> @@ -7,7 +7,8 @@
>>     char _license[] SEC("license") = "GPL";
>>   -#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
>> +#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) \
>> +				|| defined(__TARGET_ARCH_powerpc)
> 
> Won't this also trigger the test on powerpc/32 ?
We have patch ready marking test separation b/w 32/64-bit ppc.
Planning to post it immediately after few concurrent patches are frozen.
With current tag, yes it does invoke on 32 bit. Our intent is to
support private stack for ppc64 only in this series.
> 
> 
>>   bool skip __attribute((__section__(".data"))) = false;
>>   #else
>>   bool skip = true;
>> diff --git 
>> a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c 
>> b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
>> index 3d89ad7cbe2a..e09c1a8782b4 100644
>> --- 
>> a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
>> +++ 
>> b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
>> @@ -7,7 +7,8 @@
>>     char _license[] SEC("license") = "GPL";
>>   -#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
>> +#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) \
>> +				|| defined(__TARGET_ARCH_powerpc)
>>   bool skip __attribute((__section__(".data"))) = false;
>>   #else
>>   bool skip = true;
>> diff --git 
>> a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c 
>> b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
>> index b1f6d7e5a8e5..791800835673 100644
>> --- 
>> a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
>> +++ 
>> b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
>> @@ -7,7 +7,8 @@
>>     char _license[] SEC("license") = "GPL";
>>   -#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
>> +#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) \
>> +				|| defined(__TARGET_ARCH_powerpc)
>>   bool skip __attribute((__section__(".data"))) = false;
>>   #else
>>   bool skip = true;
-Abhishek

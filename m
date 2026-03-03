Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2C7201278
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 05:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772514790; cv=none; b=DjzRdycmgzxZfmQuiFyiFd13qfWCPsdC2eOHHRA6xIIjwv5cjFqEC3ZuYyykEE/BUNBj9TSc8jEmKRDCv4BWSs4JaFtoyDBqfEMxYkvrmeEs77WZEVajErEXDVD2wOfM4tr44SPbtVNfXpQD0w7V8FLUfmtaMQ5B1Vvb8+OQoxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772514790; c=relaxed/simple;
	bh=bXYj13I6m7YpgmUz8icFjOffCIdtaP2wgIgNbUdOTYI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MPt1W5mxKD4xCOGsx9vOlSM6YCj3FUlQ5YNygbu8wbXYV3sH9qcxij3YVD7wvBrKD5KtryiE+zWjiavZLgoKT6hzDdkWqnhpb2OuKEg7jY6C6qiCA3vKnTEJl5NiEXQPd2JNyBSCjLHlJiyGOqmAfJiHPWwpKsJtsCtUwyY2/mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L7XfrGs2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L7XfrGs2"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622JOjAG573073;
	Tue, 3 Mar 2026 05:12:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UKjz2s
	ZuAPt8Ct2OqzfG8dM5JV8WxLLFGUO1trZhkIY=; b=L7XfrGs2NfbBGbyv2tQ1LZ
	q4X6guHTAt+jtH66huqTSwC+MLLB7+DSq8qOni8XBy3jC7c+wjvS5T9vEtyRSQN4
	LQGWC4AhtTOd1Is4jZkJHv2O7tR0QVUNxvj44WGD9NTZVIj11v2o58Zmf+YA2hrW
	a0Il1ckd2/HlinuNakWUI/05R+D9QMCfb3g6rmKX0jScLH0JSG9PrSq8A7j/tFoH
	zoS1bFs0RFD1V5mtadt8QhwAhBdJTAhFZ4WPu1B9V3w+1hkod7K0HooUxus9pnGJ
	Qywr3d5/IrsMAXBNXNosL92znhQ8NCuWaoiej7a67H0pagjJmkdQIF8YpJ/XXkSA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksjd9mpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 05:12:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6230nuOb027710;
	Tue, 3 Mar 2026 05:12:49 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmcwj8p10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 05:12:49 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6235Cm2M21037778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Mar 2026 05:12:48 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DB7558063;
	Tue,  3 Mar 2026 05:12:48 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 748AA58043;
	Tue,  3 Mar 2026 05:12:44 +0000 (GMT)
Received: from [9.61.244.206] (unknown [9.61.244.206])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Mar 2026 05:12:44 +0000 (GMT)
Message-ID: <879f600f-7c1e-4b54-a317-535412192371@linux.ibm.com>
Date: Tue, 3 Mar 2026 10:42:42 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] powerpc64/bpf: Add support for instruction array
 and indirect jump
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
To: adubey@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, bpf@vger.kernel.org, hbathini@linux.ibm.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        maddy@linux.ibm.com
References: <20260227014315.39980-1-adubey@linux.ibm.com>
 <72C902E6-BE4E-4C47-9F4A-D8095E7BEDE2@linux.ibm.com>
In-Reply-To: <72C902E6-BE4E-4C47-9F4A-D8095E7BEDE2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M9BA6iws c=1 sm=1 tr=0 ts=69a66dd2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=zdu5mjj0_Ug8kxfXQYwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ezhZlunt8Sw3LniPf81er-MOWZqVTsSP
X-Proofpoint-GUID: ezhZlunt8Sw3LniPf81er-MOWZqVTsSP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDAzMyBTYWx0ZWRfXxDmKrDNQMlLP
 6+lT9Gn6SxeMum4c5etX3ZVAQaMWpOgAilPyXHIsVgTp07F0QLhr74rGq2g7CyeFxM80UlXcmr7
 rABiuA7JoRh/m/EAO/HOliaOEHxwERJ/y55xqLGA6cIbQdyYIXkT0xfHMuI6lvWVsgQK2zUni3F
 TP0vkX3YcLxNaouLK3d2pZukEf3r47fa/uihbSVjq7yp+Q1vZio9j68HQhQZE/GQZWiJh3fBV21
 hm+Za779gKuaVoHBobXjJtinGUwLESTP0997BCMrkk1ivS9XUy/IpSecjCC2twG15osUox4rBi0
 p1QHcfnNdSAZHaQK118ypkDsP2v/qmhh+U1hkrLiIOjErSXotprNtbVNjYILzxxtK7f5+SNVEy4
 XpwrwTsc+NEqeQKTTpAkAJjCvVEofVTdlnuESreHeK9uMeduwHAoKC4DJGH71EfVWpc/p6m3HKl
 g1STPt5TUpghHvapVaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030033


On 27/02/26 8:58 pm, Venkat wrote:
>
>> On 27 Feb 2026, at 7:13 AM, adubey@linux.ibm.com wrote:
>>
>> From: Abhishek Dubey <adubey@linux.ibm.com>
>>
>> The first 2 patch enable support for instruction array. Now, the
>> instruction offset map maintain the mapping:
>> original inst -> xlated inst -> jited inst
>>
>> The last two patch enable support for indirect jump. Any eligile
>> register can store jump target address for control flow to jump.
>>
>> The features will be enabled on ppc32 in a separate series.
>>
>> The patch series is rebased over:
>> https://lore.kernel.org/bpf/20260226031324.17352-1-adubey@linux.ibm.com
>>
>> All selftest related to instruction array and indirect jump
>> are passing.
>>
>> ./test_progs-cpuv4 -n 20
>> #21/1Â Â Â  bpf_insn_array/one2one:OK
>> #21/2Â Â Â  bpf_insn_array/simple:OK
>> #21/3Â Â Â  bpf_insn_array/deletions:OK
>> #21/4Â Â Â  bpf_insn_array/deletions-with-functions:OK
>> #21/5Â Â Â  bpf_insn_array/blindness:OK
>> #21/6Â Â Â  bpf_insn_array/incorrect-index:OK
>> #21/7Â Â Â  bpf_insn_array/load-unfrozen-map:OK
>> #21/8Â Â Â  bpf_insn_array/no-map-reuse:OK
>> #21/9Â Â Â  bpf_insn_array/bpf-side-ops:OK
>> #21Â Â Â Â Â  bpf_insn_array:OK
>> Summary: 1/9 PASSED, 0 SKIPPED, 0 FAILED
>>
>> ./test_progs-cpuv4 -n 21
>> #20/1Â Â Â  bpf_gotox/one-switch:OK
>> #20/2Â Â Â  bpf_gotox/one-switch-non-zero-sec-offset:OK
>> #20/3Â Â Â  bpf_gotox/two-switches:OK
>> #20/4Â Â Â  bpf_gotox/big-jump-table:OK
>> #20/5Â Â Â  bpf_gotox/static-global:OK
>> #20/6Â Â Â  bpf_gotox/nonstatic-global:OK
>> #20/7Â Â Â  bpf_gotox/other-sec:OK
>> #20/8Â Â Â  bpf_gotox/static-global-other-sec:OK
>> #20/9Â Â Â  bpf_gotox/nonstatic-global-other-sec:OK
>> #20/10Â Â  bpf_gotox/one-jump-two-maps:OK
>> #20/11Â Â  bpf_gotox/one-map-two-jumps:OK
>> #20Â Â Â Â Â  bpf_gotox:OK
>> Summary: 1/11 PASSED, 0 SKIPPED, 0 FAILED
>>
>> v1->v2:
>> Handle image offset for ABIv1
>>
>> [v1]: https://lore.kernel.org/bpf/20260225010950.20218-1-adubey@linux.ibm.com
>>
>> Abhishek Dubey (4):
>> powerpc64/bpf: Add support for instruction array
>> selftest/bpf: Enable instruction array test for powerpc64
>> powerpc64/bpf: Add support for indirect jump
>> selftest/bpf: Enable gotox tests for powerpc64
>>
>> arch/powerpc/net/bpf_jit_comp.c                        | 10 ++++++++++
>> arch/powerpc/net/bpf_jit_comp64.c                      |  8 ++++++++
>> .../testing/selftests/bpf/prog_tests/bpf_insn_array.c  |  2 +-
>> tools/testing/selftests/bpf/progs/verifier_gotox.c     |  4 ++--
>> 4 files changed, 21 insertions(+), 3 deletions(-)
>>
>> -- 
>> 2.52.0


Please ignore my last results. Refer the below.


# ./test_progs-cpuv4 -n 21
#21/1    bpf_insn_array/one2one:OK
#21/2    bpf_insn_array/simple:OK
#21/3    bpf_insn_array/deletions:OK
#21/4    bpf_insn_array/deletions-with-functions:OK
#21/5    bpf_insn_array/blindness:OK
#21/6    bpf_insn_array/incorrect-index:OK
#21/7    bpf_insn_array/load-unfrozen-map:OK
#21/8    bpf_insn_array/no-map-reuse:OK
#21/9    bpf_insn_array/bpf-side-ops:OK
#21      bpf_insn_array:OK
Summary: 1/9 PASSED, 0 SKIPPED, 0 FAILED


# ./test_progs-cpuv4 -n 20
#20/1    bpf_gotox/one-switch:OK
#20/2    bpf_gotox/one-switch-non-zero-sec-offset:OK
#20/3    bpf_gotox/two-switches:OK
#20/4    bpf_gotox/big-jump-table:OK
#20/5    bpf_gotox/static-global:OK
#20/6    bpf_gotox/nonstatic-global:OK
#20/7    bpf_gotox/other-sec:OK
#20/8    bpf_gotox/static-global-other-sec:OK
#20/9    bpf_gotox/nonstatic-global-other-sec:OK
#20/10   bpf_gotox/one-jump-two-maps:OK
#20/11   bpf_gotox/one-map-two-jumps:OK
#20/12   bpf_gotox/check-ldimm64-off:OK
#20/13   bpf_gotox/check-ldimm64-off-gotox:OK
#20      bpf_gotox:OK
Summary: 1/13 PASSED, 0 SKIPPED, 0 FAILED


Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.


> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>
> Tested this series and below are the results.
>
> ./test_progs-cpuv4 -n 21
> #21/1    bpf_insn_array/one2one:OK
> #21/2    bpf_insn_array/simple:OK
> #21/3    bpf_insn_array/deletions:OK
> #21/4    bpf_insn_array/deletions-with-functions:OK
> #21/5    bpf_insn_array/blindness:OK
> #21/6    bpf_insn_array/incorrect-index:OK
> #21/7    bpf_insn_array/load-unfrozen-map:OK
> #21/8    bpf_insn_array/no-map-reuse:OK
> #21/9    bpf_insn_array/bpf-side-ops:OK
> #21      bpf_insn_array:OK
> Summary: 1/9 PASSED, 0 SKIPPED, 0 FAILED
>
>
> ./test_progs-cpuv4 -n 20
> #20/1    bpf_gotox/one-switch:SKIP
> #20/2    bpf_gotox/one-switch-non-zero-sec-offset:SKIP
> #20/3    bpf_gotox/two-switches:SKIP
> #20/4    bpf_gotox/big-jump-table:SKIP
> #20/5    bpf_gotox/static-global:SKIP
> #20/6    bpf_gotox/nonstatic-global:SKIP
> #20/7    bpf_gotox/other-sec:SKIP
> #20/8    bpf_gotox/static-global-other-sec:SKIP
> #20/9    bpf_gotox/nonstatic-global-other-sec:SKIP
> #20/10   bpf_gotox/one-jump-two-maps:SKIP
> #20/11   bpf_gotox/one-map-two-jumps:SKIP
> #20/12   bpf_gotox/check-ldimm64-off:SKIP
> #20/13   bpf_gotox/check-ldimm64-off-gotox:SKIP
> #20      bpf_gotox:SKIP
> Summary: 1/0 PASSED, 13 SKIPPED, 0 FAILED
>
> Regards,
> Venkat.
>
>

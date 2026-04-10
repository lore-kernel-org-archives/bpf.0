Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FF361FCE;
	Fri, 10 Apr 2026 17:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775841735; cv=none; b=GZ9/4nHuZlGTU4fnvF5ZtqTV1mcfwbioI8y92IXpcBS1k3fUnEHerKeu3BOQ/S34VSvkuVH0Ht/2UqiQg586a9DXbkvw2Jv3pKeTaWD8vyVDF4d/XL8idlMT7hb1wRdwz4nG7TlNm3du6UrdEL5KTjIer9I2g3JvLBQoJ/Oj49E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775841735; c=relaxed/simple;
	bh=ocDbpvpRdqyULGHuFNWVa53JSu9yS0W0biGjJbCIAJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LCpuC05yOLSr1sX2eaOZQhcaW8ZfaWGTjtczNS+2QxUc1oNlgeVJrRA6lysrVk8VBqoagJJxocS2OL45by2eIhi8x2ZKt4+LGg4062CqZluMlmz8MSdLkPdHsOrjSVGKft7DedeXw3Acsk+hc0txytlM6V+q6jruT4cPZTgYb14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lYD7b7Ry; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lYD7b7Ry"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63ABsEVw2297475;
	Fri, 10 Apr 2026 17:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=J4+su0
	Z71A8d0I1HPLF8ZtCFeb+HYaORkMbU+tlZtgE=; b=lYD7b7RyZEh4cY6chYysCZ
	ZnL4exOqbHB5VLc2mcxrWsGVt9UJ7qMhY+PrJVklSgR0i5zlUlqkqDdIAf2VW1sb
	Qph35B71mU2Ntn6/t/M9BE7yPSYAZZm5Ycs08BN2KO+eBpTWtEJtv0dFV62PceSY
	RZNUhB1maNU+632XY44eBzxJrgPftW0OODVOB2VJw2pPMTCpQ4KyhYFZ91+eBuEu
	sguhJUcTJG2yAxs4cPHnLAxP4shFaV6D8ORRLAbQoC5HRecFOxcgTZcSoId6/VUK
	BMjPrDDGxBpK/3J82CZjwMjPP7iE3ODbf65VVnmkXUEje18vutmtqjuOZ5W6BNmg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2ga3vw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 17:22:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63AGfped013821;
	Fri, 10 Apr 2026 17:22:02 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf4h4rv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 17:22:02 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63AHM1kc22086274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Apr 2026 17:22:01 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F41458061;
	Fri, 10 Apr 2026 17:22:01 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A78265803F;
	Fri, 10 Apr 2026 17:21:57 +0000 (GMT)
Received: from [9.43.123.103] (unknown [9.43.123.103])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Apr 2026 17:21:57 +0000 (GMT)
Message-ID: <8edf35db-c156-47ba-8f8d-1d269bb20cc3@linux.ibm.com>
Date: Fri, 10 Apr 2026 22:51:56 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf/selftests: remove test_access_variable_array
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, bpf@vger.kernel.org
Cc: skb99@linux.ibm.com, hbathini@linux.ibm.com, adubey@linux.ibm.com,
        ast@kernel.org, alexei.starovoitov@gmail.com, peterz@infradead.org,
        andrii@kernel.org, maddy@linux.ibm.com, linux-kernel@vger.kernel.org,
        riteshh@linux.ibm.com, alan.maguire@oracle.com
References: <20260410105404.91126-1-venkat88@linux.ibm.com>
Content-Language: en-US
From: Naveen Kumar Thummalapenta <naveen66@linux.ibm.com>
In-Reply-To: <20260410105404.91126-1-venkat88@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KeridwYD c=1 sm=1 tr=0 ts=69d931bb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=z6dCOv8DtXCLzIA9hsoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: oFhTf_DlGRMrlXBtFOhNyeqmtozGEv59
X-Proofpoint-GUID: Rl09qNKoCAA5OmkW6ua0EgqZZ6d8vH-f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDE2MiBTYWx0ZWRfX5omY+81BN6qR
 4CHt81uyCjeTXmZT7M04pQ8ZcyA7y8e9dR+RYYRC6bS0T9dwIy6vk99kIE/KAI1jYr5rV/dr4lc
 0GhTx/rV27qD9FcPrX/Qqj4h3qtLTcalx1yo3+ukMTBt26WdyUnBGvm/heq0Tu7p9Z337EeT05g
 AW9Fou10M+8a4zH7lphcGW70hOr18FrhlrZ6hHTYhtn56Msci3ZaDZAsplj4ybyBPPmKGQxvoMj
 I05MAaaIZKrHw8oUOvGkvHMgVumJ2A7h6EvhEqPAz9VwyfwoL6FGEEyqJCBSgncOtYv+L4MHFAD
 hvNra/TgVZ1OLQ7atortYp9t4Qs7godpLTsFtUgWc0KhjyLbJSP1ETzdbAaHQrrFFIYP9NOmWBB
 Vox2SZLfjpVr5M0d3tm8VR/UJWpNAMI9ZorLXJAWy1YR6o8/7tHRWfjoMsgLJiPb6FwLpl70Hls
 jIi9IEDrBRnYrA6z26g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1011 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100162


On 10/04/26 4:24 pm, Venkat Rao Bagalkote wrote:
> test_access_variable_array relied on accessing struct sched_domain::span
> to validate variable-length array handling via BTF. Recent scheduler
> refactoring removed or hid this field, causing the test
> to fail to build.
>
> Given that this test depends on internal scheduler structures that are
> subject to refactoring, and equivalent variable-length array coverage
> already exists via bpf_testmod-based tests, remove
> test_access_variable_array entirely.
>
> Link: https://lore.kernel.org/all/177434340048.1647592.8586759362906719839.tip-bot2@tip-bot2/
>
> Signed-off-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> ---

Hi,

Tested this patch and it is fixing the build issue.


Without this patch:

progs/test_access_variable_array.c:14:13: error:
no member named 'span' in 'struct sched_domain'
     span = sd->span[0];
                ^~~~

With this patch above build is fixed

Please add below tag

Tested-by: Naveen Kumar Thummalapenta <naveen66@linux.ibm.com>

Regards,
Naveen Kumar T

>   .../bpf/prog_tests/access_variable_array.c    | 16 ----------------
>   .../bpf/progs/test_access_variable_array.c    | 19 -------------------
>   2 files changed, 35 deletions(-)
>   delete mode 100644 tools/testing/selftests/bpf/prog_tests/access_variable_array.c
>   delete mode 100644 tools/testing/selftests/bpf/progs/test_access_variable_array.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/access_variable_array.c b/tools/testing/selftests/bpf/prog_tests/access_variable_array.c
> deleted file mode 100644
> index 08131782437c..000000000000
> --- a/tools/testing/selftests/bpf/prog_tests/access_variable_array.c
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/* Copyright (c) 2022 Bytedance */
> -
> -#include <test_progs.h>
> -#include "test_access_variable_array.skel.h"
> -
> -void test_access_variable_array(void)
> -{
> -	struct test_access_variable_array *skel;
> -
> -	skel = test_access_variable_array__open_and_load();
> -	if (!ASSERT_OK_PTR(skel, "test_access_variable_array__open_and_load"))
> -		return;
> -
> -	test_access_variable_array__destroy(skel);
> -}
> diff --git a/tools/testing/selftests/bpf/progs/test_access_variable_array.c b/tools/testing/selftests/bpf/progs/test_access_variable_array.c
> deleted file mode 100644
> index 326b7d1f496a..000000000000
> --- a/tools/testing/selftests/bpf/progs/test_access_variable_array.c
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/* Copyright (c) 2023 Bytedance */
> -
> -#include "vmlinux.h"
> -#include <bpf/bpf_helpers.h>
> -#include <bpf/bpf_tracing.h>
> -
> -unsigned long span = 0;
> -
> -SEC("fentry/sched_balance_rq")
> -int BPF_PROG(fentry_fentry, int this_cpu, struct rq *this_rq,
> -		struct sched_domain *sd)
> -{
> -	span = sd->span[0];
> -
> -	return 0;
> -}
> -
> -char _license[] SEC("license") = "GPL";

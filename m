Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C9A3D6479
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 22:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769036215; cv=none; b=uHE4F1j/TeIQoOl6GJL7SSE68n1Gt2cbfhzysOGpuPuH3nKdTr0vbl90T8O5pSjiHB9g/RnKYEiIdet5piP/XktCcZXgsmyE15hXiyzUZZya/fyV797keTGWy1jh4Md6Oi/DX1lAG0CQx5pjde9M7IhKxmJaDKdggNcUQW4q31Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769036215; c=relaxed/simple;
	bh=O5vMawaOOASJ7hKCxhOvoYYIBi8oG2t0KXpixYNxF3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SolDXfltvn38kPECNr4aJWeeduq0f9qr+o5BX50C4FXFBLAqaDRuhCGnGsXzJPjZEcyjJ48ziIMST0ULCsJrlJPeqIqb2TGzVf7aDHKvybIOpD/J0GF6G8u3w4P02kqduHlBuk/5tNYLDklTzfvsDl2NKQN5RQ0bEbksKAq0YPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iLFXt82J; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iLFXt82J"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60LD042Z020572;
	Wed, 21 Jan 2026 22:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=f3RJIq
	uf12zOhc1PlhM56qk2d7vrIRKE7/+lL4uoAFk=; b=iLFXt82JrR752toiCf85qe
	8vcEg+W1qNbQOQbB5kU96c+HQ68x9pXCvLZ0JgVBXcwVU/CW2BSlhlvOJ5aeD8y6
	BBnNoo5SZAiW6cZTD/m7ORoTvzX9L333rlixjz1iULlaGbQJFgtPnX6V2b5Gzy1R
	ZHJmep30FeR3MVURcs9+dbaE07SduFELhSTYLPoCLisQc7lzKuWBwEmL1+E87CPN
	pPH3PqPGHNWE5NNhOJFreMA65XWk2U2AXLhBQnB6qwkKiSUXFsIVyau2OltdOjfM
	ZP1aCTeKpLhFNYs4KAXQNa7eXn3182UHu+xcKQxh57GigT9blTH+jXHBl5aVs8hQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br0ufnjrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 22:56:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60LLpRYF024614;
	Wed, 21 Jan 2026 22:56:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brxarw947-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 22:56:31 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60LMuTrb60424474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Jan 2026 22:56:30 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA5CE20043;
	Wed, 21 Jan 2026 22:56:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A39A20040;
	Wed, 21 Jan 2026 22:56:29 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.153.49])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Jan 2026 22:56:29 +0000 (GMT)
Message-ID: <62cab7f1-06ea-434b-99e5-ba8b1a7d7eb5@linux.ibm.com>
Date: Wed, 21 Jan 2026 23:56:29 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BPF CI] OOMs on s390x runners
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>
References: <8553c4ab-9b42-46a8-9187-38ba4f63fff0@linux.dev>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <8553c4ab-9b42-46a8-9187-38ba4f63fff0@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UtLNMeQRxciA0yAaXrFXZjIGQa0HVRWZ
X-Proofpoint-ORIG-GUID: UtLNMeQRxciA0yAaXrFXZjIGQa0HVRWZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDE5MSBTYWx0ZWRfX8Df9mibtmdWy
 5mHcMPWk3NZIFASjwzBbQvhYJnt5ndVGrb/gK9SjsNx0SSI1vwBDUZ7IRtnUjq8jt6ex9fw9e6e
 lJUeLSS8wqo3EoDaicYbBikfebZyixTQKMgB+QFfEtvn7PK2RjFYyUnUP8s9zUGd1K14j+w5aMn
 ZGMVfzDEymRuCDhaIf+egTEuJf0F3R2R0PKbBLE92aMlcOiTy8hu7kkWxUBDdHoQHwbfF3r7SFt
 u1iwGByqOwQYzv4/n3e78G7IogIAzR0JFfkAta/Vhdv2qbiz1HppUZ8sK1JwQIBHVtwCT1EbScc
 AFGX8VPaSWpWYWfsVLAxKL1fizVpA3LWnYwji5RqTe/kOHpgzOdpXuosNA6BWvEpseD01w5wVfR
 ITahJwoKbOUsqiNC8sUeQBWDJmQfkfZQfOTHP0BbHk5ECVqq6oqsjeo+aYgq8l5KDPqe2fnz4RU
 XRFQwSW5g1GWI2fd4Cg==
X-Authority-Analysis: v=2.4 cv=bopBxUai c=1 sm=1 tr=0 ts=697159a0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=6r4niitUv21uFfEoDkIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_04,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601210191


On 1/20/26 18:59, Ihor Solodrai wrote:
> Hi Ilya,
>
> The BPF selftests regularly fail on s390x runners with OOMs.
>
> The s390x hosts that I've been maintaining have 16G of memory, hosting
> 2 runners each. VMs (qemu instances) running the tests currently get
> 5G of memory each.
>
> I noticed that the s390x runners didn't have swap set up, so I added
> an ansible config to set up a swapfile. This seems to have helped with
> OOM failures.
>
> https://github.com/libbpf/ci/commit/8767dc05ab84c88da198af3c651511e731ddbac7
>
> I spot checked a couple of recent failures, and all of them happened
> on the "ebpf1-worker-*" runners that you've been maintaining IIRC.
> Here is a couple of examples:
>    - https://github.com/kernel-patches/bpf/actions/runs/21178791628/job/60916006746
>    - https://github.com/kernel-patches/bpf/actions/runs/21163448380/job/60863171062
>    - https://github.com/kernel-patches/bpf/actions/runs/21157785072/job/60846570064
>
> Could you please re-provision the hosts with the swap setup?
> Let's see if that helps.
>
> Thanks!

Hi Ihor,


Thanks for the scripts!

I reprovisioned all 5 builders, everything looks healthy.

I will check on them again tomorrow morning.


Best regards,

Ilya


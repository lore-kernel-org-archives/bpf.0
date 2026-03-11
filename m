Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A486831AF3B;
	Wed, 11 Mar 2026 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773252209; cv=none; b=GsZgamVDOzdxpjXMmvzA7EQSYcP6w3Grc27/GlDDRzmRq4E2MoRkn5gveOOMjToqiXHhpVeIeuHt25uahgiXY1qggmKrFJ3joeFr6QuaeDwNJqIIPdT9VPAJxosW5N40CCUGqt1f09E7jGiMJIlZw2qGe7COCA4pqlrEbKJlElo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773252209; c=relaxed/simple;
	bh=4XtYgJZaM+JqN+IOLXVztWe3v60AQ32X7KOZ04NxOko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JljNXGtFsOGcFkTeIF7n7rcEg/I+JTAv5KuX5PLU1ntZIiHbS708cXc9GeR9/TyZ/W1VCpy+c0lHpUDmk9lc4inEjpD+qzCS1ZLu4TbNStT/vNsgSjhe7zMHZzNS3xsD77lm96X5R/Az7Il0VK828CJJQGQyyJ2tVeyiWbypyi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HcN5FfmC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HcN5FfmC"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BDllNZ1278613;
	Wed, 11 Mar 2026 18:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bCC3ML
	Rz3qT+gZlW0z4NYf9LVS1g4bWylU9B7JxDAN8=; b=HcN5FfmCXqkWakq1inWExM
	slmUYSfe49qbPCDaJ6XE7ndE6idFKhobgQKJyWkFws/D5x3ENrB2ZDl1teYfOQQq
	22nmB8Z1W5DQP923HHsGz2Ho26to5QLI8BhR+sRNC1iUvfKFzxcCGQN1me9ilr5c
	VvCfvlwNPC+xUYAXn9CBDGjv7rSvaqApE9qVx9vYUcpX6Myu0TCijkCbnXJG6i5W
	RTAYmX/TcPQ+NhHiISA17U3YoYb47Volssbw1CIvQobJTYqHCXBkbgap0U1m4pNP
	OhksER5QT2QDmkkqr194r8Y17qu7DAACtfZG5j+WHDRB7Ez6kOFBxbYPzodUFU7g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcungqe9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 18:03:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62BGAoJ9029850;
	Wed, 11 Mar 2026 18:03:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4csp6uu557-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 18:03:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62BI33MJ44761464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 18:03:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2832120040;
	Wed, 11 Mar 2026 18:03:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 166D320043;
	Wed, 11 Mar 2026 18:03:01 +0000 (GMT)
Received: from [9.43.104.94] (unknown [9.43.104.94])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Mar 2026 18:03:00 +0000 (GMT)
Message-ID: <09b101af-9722-4c45-bda0-c8a3dd417c03@linux.ibm.com>
Date: Wed, 11 Mar 2026 23:33:00 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/bpf: improve test coverage for kfunc call
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard <eddyz87@gmail.com>, Vineet Gupta <vineet.gupta@linux.dev>,
        "Jose E. Marchesi" <jemarch@gnu.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20260303131453.328674-1-hbathini@linux.ibm.com>
 <CAADnVQKuARvSirPjnTcSifLPunCiKC4Nenq0Mr61GpzbW5WxWg@mail.gmail.com>
 <bbf6a46c-37e9-4d8d-968e-a99bb12dcc14@linux.ibm.com>
 <CAADnVQ+4N4WWLxan_qibZ7HmONJyMZaP=RF+a9tMSPoz=0LqkQ@mail.gmail.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <CAADnVQ+4N4WWLxan_qibZ7HmONJyMZaP=RF+a9tMSPoz=0LqkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: b6xLeAZj1uH1PQvLUdtUXluCJJEvEDYS
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69b1ae5a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=O-nAQ4prQPj99qpvhysA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDE1MiBTYWx0ZWRfXwe3iurw3vLdE
 xTfM6RnsooyM/wkTnmYFAtzW5rESlFWO3HKGXD/tCEcOWaS4Ma778guTv/j+09dL/ALfUsYGfar
 JGv4JoF2wMHcUonmgm/DiQZ8FJ8soFJQZnKBttIIRWLroiLKrgbbHdx0h/vAF7TejN1YzEBsCSd
 o9Wbnqhco5yZksAe5sAeugl+SPFCXE/iZKKanFMzjTh7nz3sk6TQXKcjVAOyg6eUNZ0xKJYY/UK
 a6Y4V2WSI9wT7RLTAcgIw0zlzK9o3fKfqc5A7OOmTqrFdmDP1Pmv277bZAVZVfpoCX1chQw7o/f
 pWyiTfFUwXwIMOpH3hNegHMH1XERzYbB9JrNhLVbB55N8d4GchDslHamKXwdMy9dqJoUcUIEOdP
 Gwph68kVk+wUD4hMamYV9sb2k7yDy8QtwvTuHVLOhG5pggvJFKSsI9IMWLXgeMKABkBdwA7BgSN
 kLLyfH058VytQFwpqRw==
X-Proofpoint-ORIG-GUID: mYn3XE6InOnPspwkRfZvOenOhDMsAoOE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110152



On 11/03/26 9:32 pm, Alexei Starovoitov wrote:
> On Wed, Mar 11, 2026 at 8:10 AM Hari Bathini <hbathini@linux.ibm.com> wrote:
>>
>>>
>>>> +
>>>> +       /* Check zero-extension */
>>>> +       if (val != (unsigned long)a)
>>>> +               return 1;
>>>> +       /* Check no sign-extension */
>>>> +       if (val < 0)
>>>> +               return 2;
>>>> +
>>>> +       val = b;
>>>> +       if (val != (unsigned long)b)
>>>> +               return 3;
>>>> +       if (val < 0)
>>>> +               return 4;
>>>> +
>>>> +       val = c;
>>>> +       if (val != (unsigned long)c)
>>>> +               return 5;
>>>> +       if (val < 0)
>>>> +               return 6;
>>>> +
>>>> +       return 0;
>>>> +}
>>>
>>> Overall this looks very useful.
>>> I would expand with another test where a,b,c are s8,s16,s32.
>>
>> Slightly different approach but kfunc_call_test4/bpf_kfunc_call_test4
>> cover signed arguments already?
> 
> Ahh. Then may be tweak it to adopt similar fine grained
> error reporting as your bpf_kfunc_call_test5()

I Prefer this.

Does the below change to bpf_kfunc_call_test4 look fine:

diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c 
b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 48dcaf93bb9f..6237c2222633 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -760,8 +760,30 @@ __bpf_kfunc struct sock 
*bpf_kfunc_call_test3(struct sock *sk)

  __bpf_kfunc long noinline bpf_kfunc_call_test4(signed char a, short b, 
int c, long d)
  {
+       /*
+        * Make val as volatile to avoid compiler optimizations.
+        * Verify that negative signed values remain negative after
+        * sign-extension (JIT must sign-extend, not zero-extend).
+        */
+       volatile long val;
+
+       /* val will be positive, if JIT does zero-extension instead of 
sign-extension */
+       val = a;
+       if (val >= 0)
+               return 1;
+
+       val = b;
+       if (val >= 0)
+               return 2;
+
+       val = c;
+       if (val >= 0)
+               return 3;
+
         /* Provoke the compiler to assume that the caller has 
sign-extended a,
          * b and c on platforms where this is required (e.g. s390x).
+        *
+        * Original behavior: return sum for backward compatibility
          */
         return (long)a + (long)b + (long)c + d;
  }


- Hari

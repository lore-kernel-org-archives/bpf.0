Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA297214A64
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772544107; cv=none; b=fGxbZL2funNOHucr27uVdc7130mjIPM/cQbQg7Fzc43vY9jC3j8rdYZ1guuSC/56HcszKCIiaylzHkK0pw9IOxfN+pAz0UcrSovNVgHBVZ+S/rCEAeidfQsheo3fTiXBpeXCOiGZS9pp7yJLo2nkHTHatQ5FOTVBu8gg0D7XW5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772544107; c=relaxed/simple;
	bh=jQVxxzBzMW5ezrxE1H9WLpupUZdI6t6ikRyARMjxoZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ch1p/Dovrs5GzVL0TDagE6dc5ddasvDQyBaYjuRxuivKcnH3d3cHp5PCrvRvvYrbiQ9QghHk89wk34VOqwM8MIhNQmCKhEw266XQvNDejjtZgU56ZvKebeuh31gdtWJT5JoKzQVPQJt2kezcw8/sKQ8ivywF9jiX7GeIS01+6xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O1gvjVoJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O1gvjVoJ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623115Xg1621757;
	Tue, 3 Mar 2026 13:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QId7nP
	HDYS6tYYZeXC9mclSJa9ObH9GqTpYbu06gOEQ=; b=O1gvjVoJsBegsacEcXoEnO
	4tMk55F0Nt9W88fadLC/qSq0jWlnpkRNIf2BTjFDbtEmScZFtg8DxWyFqv8WSJFV
	ZvownYyIKy9UoWdXzvc0a5E4lQHdcestaM/m5r+vLMr3yY1CodDSFhC/iKjvz/g0
	PQiO7ZcYzQlf+DduvpG6pwUjXMXHXRNORRLnS9o5Ol+ps5omkkKbXUqG3dwK1aUi
	ydHy5ZrJ4zj4jVa2kB5jsaHSBO1JDSpZLq9QpqN9pTf6Mfx+7/zwUyVnxngNl9Wv
	DJ+Uso2RnQxDceyP6YDNFhusTbWpmVHSakImuksmAMGJTzsP4sbqB5GoAnXcvbrw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckssmjtcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 13:21:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6239aBsx003275;
	Tue, 3 Mar 2026 13:21:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmb2y2f25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 13:21:17 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 623DLDln9044312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Mar 2026 13:21:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E97A20063;
	Tue,  3 Mar 2026 13:21:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 195F420040;
	Tue,  3 Mar 2026 13:21:12 +0000 (GMT)
Received: from [9.78.106.17] (unknown [9.78.106.17])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Mar 2026 13:21:11 +0000 (GMT)
Message-ID: <29f1d295-a38a-42fc-98c6-20281278dc64@linux.ibm.com>
Date: Tue, 3 Mar 2026 18:51:11 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] bpf: zero extend function arguments while calling
 kernel function
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>,
        Abhishek Dubey <adubey@linux.ibm.com>
References: <20260220062959.195101-1-hbathini@linux.ibm.com>
 <20260220062959.195101-2-hbathini@linux.ibm.com>
 <CAADnVQKwCX6mUbQeLTCtG7dKe+P_UUBig5KMTkF+t-6SW7wAkA@mail.gmail.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <CAADnVQKwCX6mUbQeLTCtG7dKe+P_UUBig5KMTkF+t-6SW7wAkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDEwMyBTYWx0ZWRfX14Us5Vxa6tVl
 LnkztTPnuSqgjdb/yjFsFib939duywrWS+bzUxoVZfLsAmMlIkTF6rHh3EoEEtQFc13gRLi8zVM
 JuQXAPsxEY2vTe2p7zlIxgnPPXsgbdW7/mWnMGg9Pf07b50eeUg8kfMjLBaWdnwGQvR6XxGq4xR
 6vKrOpG0FJvhIPpaLd7MEhCfdytKRr4coTRDUOdxfnPdAoY32fE0/V3tza67hnSZLlEpETAjvDk
 74UALy2qM4vdyla2bBR0W0o/JbdTAGua/HTbXOeToS6QSF9MBODvsoQIIZmio5VDoShp+XfHbFZ
 AwQhLrs6SjNsRF6fW+j73WBty5/A62MJdtW0niGz7dKLhe3FyfOvV7K4LyZ7DRaRE073KF1EwFG
 mwKKfjZiFmoPbMYZO0s3BHArOpgAsQcwQYh/7yEsOMrDFRwc8SmF8mTzINksdeYvNT6PYd24CsD
 L4eBFhLIIVU/Wi0b4Pg==
X-Proofpoint-ORIG-GUID: x4yxWgm3hF98cFXOAluNDT5RTq0x0ajI
X-Proofpoint-GUID: q6AXym9kmdTuA2kpnZUa_4wRqtwwzu0Z
X-Authority-Analysis: v=2.4 cv=AobjHe9P c=1 sm=1 tr=0 ts=69a6e04e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=UFEoRwOCi9S2vwcJ2cMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030103



On 25/02/26 12:03 am, Alexei Starovoitov wrote:
> On Thu, Feb 19, 2026 at 10:30 PM Hari Bathini <hbathini@linux.ibm.com> wrote:
>>
>> For kernel functions, even if a function parameter is not of u64 size,
>> it may still be cast to a data type of u64 size. In fact, page_cnt, a
>> u32 argument in bpf_arena_reserve_pages() kfunc is implicitly getting
>> typecasted to long. Without zero extension for that argument, the
>> verifier_arena/reserve_invalid_region selftest fails on ppc64le. So,
>> be more conservative and do zero extension for all arguments. JIT
>> compile code can eliminate unnecessary zero extension code-gen.
>>
>> Fixes: e6ac2450d6de ("bpf: Support bpf program calling kernel function")
>> Reported-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
>> ---
>>   kernel/bpf/verifier.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index f0ca69f888fa..3f6e0e1c71e4 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -12018,8 +12018,11 @@ static void __mark_btf_func_reg_size(struct bpf_verifier_env *env, struct bpf_re
>>                  /* Function return value */
>>                  reg->subreg_def = reg_size == sizeof(u64) ?
>>                          DEF_NOT_SUBREG : env->insn_idx + 1;
>> -       } else if (reg_size == sizeof(u64)) {
>> -               /* Function argument */
>> +       } else {
>> +               /*
>> +                * Be more conservative and do zero extension for all arguments,
>> +                * as how these arguments get used in kernel is anybody's guess.
>> +                */
>>                  mark_insn_zext(env, reg);
> 
> This needs a selftest and better explanation of what's going on.
> So far the patch doesn't make sense to me at all.
> zext marking is only to simplify JIT's life for extensions
> from 32-bit to 64-bit. All <= 32 extensions are done by LLVM
> when it generates bpf code on the caller side.
> If native callee messed it up, it's a bug in JIT that
> doesn't do correct job for kfunc calling and translation
> from bpf ABI to native.

Hi Alexei,

Thanks for taking a look.

What we’re seeing on ppc64le is that the powerpc JIT implementation was
implicitly relying on the verifier’s zext marking for kfunc arguments.
In other words, the JIT wasn’t fully taking care of the required ABI-
level zero extension when translating from the BPF calling convention to
the native one. So as the verifier only marked sizeof(u64) arguments,
the powerpc JIT ended up passing non–zero-extended values in cases where
the native ABI expects them to be properly extended.

 From the verifier’s perspective, that assumption is indeed backwards —
the verifier shouldn’t need to compensate for arch-specific ABI handling
in JITs. The responsibility to satisfy the native calling convention for
kfunc calls lies with the arch JIT.

I’ve prepared a fix for the powerpc JIT to explicitly zero-extend
arguments as required by the ABI during kfunc call translation, instead
of depending on verifier zext state. I have posted the powerpc JIT fix
here:

  
https://lore.kernel.org/all/20260303130208.325249-7-hbathini@linux.ibm.com/


and proposed a test case in the selftests for the same here:

  
https://lore.kernel.org/bpf/20260303131453.328674-1-hbathini@linux.ibm.com/

Thanks again for the review and for calling this out.

- Hari

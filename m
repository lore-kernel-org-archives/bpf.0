Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CF440DFB4;
	Wed,  6 May 2026 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778079686; cv=none; b=ReF0OTkP590TyYIvCDNNdaxzB9rpb/lTw6GRYp7Cmg3R7wtgATh/UBz+A+gci5mr7aqtivdwit/CF7sZdtfNFd6hc7E+e/6b/AdKOu0CydKOtgZD10TMi6doUIUAekGCSQvBGZviLMB1utolm0mCmIZsK+n6oXo+aq1k/jWxBbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778079686; c=relaxed/simple;
	bh=LbVaH+sfk0sLFOtaiIL0fa6jjnS6UgssKTzx9dhqDAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lbdl7DMkZTqE9uD2gzrBEtlMFZ4HqIz0tpzJGcDyJClqiCW45mpHMMk9dhSR1vFNkuFlfVmVjVOh3B3duD1Zxgyxbwqxx9gHml3iHsYEnD0afJWHggBoaOpZ2GCXe9UnixvH1cWGbEE6S0OXeU7wHI4TzGCjdzHm5bzztILx76c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=judJkmtF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="judJkmtF"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646C0Cm13066719;
	Wed, 6 May 2026 15:01:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zZWhML
	4SNpsbKvRhplgF3UACUpYU7ecCVQk748GUcRk=; b=judJkmtFAopc5KAG2Lrh16
	Bo7Mhfhf25U6Rx0TthUgZfNN2boLPkQqkbNaGFV8WsAOuivUYwErophHasGV3gNR
	f9J9bUvGiD9kWpRcJ63Y/bTUIsNJCH8O6PEYlbZszoUGZ2WaqUKI5WFuSZ287m3R
	0VNHqFal9g40/ajtxjcdpc3/4t98rqTkoK39v84F3Vd9ala3ov/LFBNybIUGsSvh
	3RJmQ/ex3uVQSqVOyT54q8WPba3jGPoZgw+tby58yOUWK15JtnUbeVkip7m3f+/c
	szQGjZkuzKe20J5vQiJLbxPG+8lFSmcDPK008s9juBTxP8DBDAXK1HjBo5AldAnQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9v7hcm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 15:01:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646EdU6U001584;
	Wed, 6 May 2026 15:01:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkjxqgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 15:01:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 646F1IYw28967376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 15:01:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 882D92004B;
	Wed,  6 May 2026 15:01:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66D8320040;
	Wed,  6 May 2026 15:01:18 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 May 2026 15:01:18 +0000 (GMT)
Message-ID: <05f795f1-0c04-4b49-9051-beb6c146991f@linux.ibm.com>
Date: Wed, 6 May 2026 17:01:17 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 08/19] unwind_user: Stop when reaching an outermost
 frame
To: Steven Rostedt <rostedt@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: bpf@vger.kernel.org, sashiko@lists.linux.dev,
        Indu Bhagat <ibhagatgnu@gmail.com>
References: <20260505121718.3572346-9-jremus@linux.ibm.com>
 <20260505124034.B339EC2BCB4@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260505124034.B339EC2BCB4@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE0NCBTYWx0ZWRfX+03Rvc4JQ6mv
 HyWp9PjWSgT2qy21l2XeWOCixvW207TyLBMU48Wb3JMTT9RknSsxnEiWLcVKSBcb3HiJMwPlxiU
 SwpPXgs+6ivFm+fh32+WF4onsTEoJ9sqnyIryE3EmI53BaS8cyRHBwg0K23lytrNPRJt6f1Zbs5
 9BMFQbuUbCaE53zcZ6JyrW+b0wA5SB9xHgGfdef2nGzezaYCuyNkCvL699GSlbKt8bg7IEippLe
 QzeqW9/3t+RQqMr/YQy8mO3MUj2pXOg900x4lR5Lm1cSU2WeL3ZkLLfVZN6PUgUasDJueN2/fgO
 hbbcvIo4oCUPIBXik+JEU90pV4ZMOuHjDYMqgNTCw8zJCM3j7v0xKkxRxJpUWryEyQ5AxkUvTJT
 +GAlyecRj+QxrH+rwTCguyG77zVA7cDbYcrJ4AEMmh4L/hw7vT5cZ9lLoXZAbnCsCtouJ3PNJmP
 Zc4bK/8buQieQViFf+A==
X-Proofpoint-GUID: bXe1FL6VFD7_oQschN2XM_wXFuHAtrYf
X-Proofpoint-ORIG-GUID: LKchr3UBLJfcxMdHszPtIIz3X54X8m1K
X-Authority-Analysis: v=2.4 cv=eu/vCIpX c=1 sm=1 tr=0 ts=69fb57c2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=ttTKnQT0nSw-QaNoCZEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060144

On 5/5/2026 2:40 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The newly added `outermost` field in `struct unwind_user_frame` is read uninitialized during SFrame unwinding, which can randomly truncate stack traces.
> --
> 
> commit 84ee374fd6a62072e8d61545c4ceae42822e4e37
> Author: Jens Remus <jremus@linux.ibm.com>
> 
> unwind_user: Stop when reaching an outermost frame
> 
> This commit adds an outermost frame indicator to the unwind user frame
> structure, and modifies the unwinder to stop when it is reached.
> 
>> diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
>> index 1fb2724197332..fdb1001e37505 100644
>> --- a/kernel/unwind/user.c
>> +++ b/kernel/unwind/user.c
>> @@ -32,6 +32,12 @@ static int unwind_user_next_common(struct unwind_user_state *state,
>>  {
>>  	unsigned long cfa, fp, ra;
>>  
>> +	/* Stop unwinding when reaching an outermost frame. */
>> +	if (frame->outermost) {
> 
> Could this evaluate uninitialized stack memory during SFrame unwinding?
> 
> In kernel/unwind/user.c, unwind_user_next_sframe() declares the frame
> variable on the stack without zero-initializing it:
> 
> unwind_user_next_sframe() {
>         struct unwind_user_frame frame;

Should unwind_user_next_sframe() zero-initialize frame to resolve below?

>         ...
>         err = sframe_find(..., &frame);
>         ...
>         return unwind_user_next_common(state, &frame);
> }
> 
> Since sframe_find() does not populate the newly added outermost field at this
> point in the patch series, frame->outermost contains uninitialized memory
> when checked here.
> 
> If this evaluates to true, does it erroneously set state->done and silently
> truncate stack traces?
> 
> I note that this is fixed later in the series by the commit
> "unwind_user/sframe: Add support for outermost frame indication", but
> introducing the uninitialized read in this commit could break kernel
> bisectability.

Or should I merge this and the following commit into one?  Or disregard?

> 
>> +		state->done = true;
>> +		return 0;
>> +	}
>> +
>>  	/* Get the Canonical Frame Address (CFA) */
> 

Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/


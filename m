Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAC74A341E;
	Tue, 19 May 2026 12:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779193481; cv=none; b=gikKNrc8/maWt+ctgQPytkzyK4MnQVHb/NrH+8Z2HooPJwi2ZZzc6LlZes/62o6PreIUCiRU42WVxUXb/oBJBG5ChFmmRo0nOR2UNsbOviDsU406tBP8JZgEt5zgbKNFi6Qx8SbV0+ixS7GBzak72oAPQtz/dq0JEAYE3iBtThA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779193481; c=relaxed/simple;
	bh=v378/OOnuouH9GSkgdrAA6sJ4e1vmMJwFnDXc7SBol4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CJjk8+Yx1OmdtcRfw397LEh4jvUq5A2+sCIwZiTxYV7Livlak0Lv3MmvTtdDT1hi56DW+7QtNATSnQsci9IOohTj7K2P0pjBUP6F9jQV8Ifm3/I6fwsg9sA9eSSIJr76DXU68bBYJ8ZwuaGE09UY1f3lxCLvFV5cPeO3CZRKM5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g7GEV8Gk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g7GEV8Gk"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J1VCiW834424;
	Tue, 19 May 2026 12:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6RsEJ1
	ZIrFM8Z93E5XF/FZvHPlnufzppX7BrDEkcASI=; b=g7GEV8GkDUyE3HyqUCEDz/
	b49sQ8dHqEPswjTZjxGRmwzKRHzdyIGn+A2qLPBzdU3UC6afK+8iphR8yBUZUpru
	QGbxHVKZg5JCeHak2DwKg2t+rX0571PDL3vVfruCUE18WshMZrltKCPF5PgLwr7h
	7ChaAm8BwrxUjsicjXLLaQerUfsaoqNQTyIZialKqXqUYItrTyXkHsmModeorhkm
	HBACneeTrJ6tQm2CPRLBV8+1ua6CMVKjCDZKJC9BMEzJlOWZkN9zBonJ4xWuDpfk
	KEzFCcHNp3JBFx6A7ktDh8ZyLOvRdzI7y16WDJkK5cHMa/qzD9xrBszr1xfUcqVA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mmv13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 12:24:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64JC94FZ005398;
	Tue, 19 May 2026 12:24:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754gaa4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 12:24:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64JCOZ5J44368232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 12:24:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E849B20040;
	Tue, 19 May 2026 12:24:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC7EF2004B;
	Tue, 19 May 2026 12:24:34 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 May 2026 12:24:34 +0000 (GMT)
Message-ID: <4838400f-209f-4e78-b41f-04b61d129ee7@linux.ibm.com>
Date: Tue, 19 May 2026 14:24:34 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 13/19] unwind_user: Enable archs that pass RA in a
 register
To: Steven Rostedt <rostedt@kernel.org>
Cc: bpf@vger.kernel.org, sashiko@lists.linux.dev,
        Indu Bhagat <ibhagatgnu@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dylan Hatch <dylanbhatch@google.com>
References: <20260505121718.3572346-14-jremus@linux.ibm.com>
 <20260505183531.C9EE8C2BCC7@smtp.kernel.org>
 <8761b037-d8f8-4142-9091-cc51d0d19df8@linux.ibm.com>
 <bd711f74-a1f3-4410-975b-64e9009aaf30@linux.ibm.com>
 <20260518123112.20da820b@gandalf.local.home>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260518123112.20da820b@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: RFJ8kIdB5QGXvivTvHsoizeclZO_McW4
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0c5685 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=DT2LHYgYV7ePjqTwKPkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: d3D4apo1E-Xu4t4TMap9L9dDALS-BI5e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDEyMCBTYWx0ZWRfX0VN8XDARI53S
 g6H8YITbq4BKP3NJh2w4QplBMnvBpoj/kIhFMfQhLt89WIF25dOg++91kvsyiBuy7YunY+4ImwC
 DgCGgxnYC5nx5UGENlrqJ4hQtqOxYCq/YGE8bkoGsbzsbPLGjyVCdyow+N7Sutobzd7WeAzlnBX
 8gfQG4wtNExt9m1rSvYsGOBvR01qMSRjT+g6mSivDBATwYIrowMxi+NlAhpyqDF1QCUi9h8k356
 jV8TdXGdFi6+labzx46EKcLHLm8jqBdQeMJcXcilakIObkQCRcFfBgjYHWyGeWidiO3eewropKb
 YP4NheoyICHk+gcoBEYOtD71OEoNlc+VB3nnvdB58iZ9zUDabk8KAm6Kif2KB/wvc1eY624F9kg
 bJWHBK2LToxCoUkLXkk1bbPIOKazeW1OmXGQdZuljhZefnFSYiC8T5u04HOsoC2+69mJXCTPeay
 epEaDoer9hDTlqUy7VA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190120

On 5/18/2026 6:31 PM, Steven Rostedt wrote:
> On Mon, 18 May 2026 18:16:52 +0200
> Jens Remus <jremus@linux.ibm.com> wrote:
> 
>>>>> +#ifndef unwind_user_get_ra_reg
>>>>> +static inline int unwind_user_get_ra_reg(unsigned long *val)
>>>>> +{
>>>>> +	WARN_ON_ONCE(1);  
>>>
>>> Replace with the following to resolve below issue:
>>>
>>> 	dbg_once("unwind_user_get_ra_reg() not implemented\n");  
>>
>> Omit or replace by the following?
>>
>> 	pr_debug_once("%s (%d): unwind_user_get_ra_reg() not implemented\n",
>> 		      current->comm, current->pid);
>>
>> This did not work with dbg_once() defined in kernel/unwind/user.c as
>> follows, as linux/unwind_deferred.h includes linux/unwind_user.h and
>> therefore gets included into other modules that do not define dbg_once()
>> (e.g. via linux/irq-entry-common.h including linux/unwind_deferred.h).
>>
>> Steven, Should I omit the dbg_once() or could I replace by the above
>> unguarded pr_debug_once()?
> 
> Question, should the above ever get hit? That is, should all architectures
> that support sframes have unwind_user_get_ra_reg() defined?

No.  Architectures that do not pass the RA in a register, such as x86-64
that passes the RA on the stack, do not implement unwind_user_get_ra_reg().

> How can this be triggered? Does it require an architecture to implement
> only partial sframe to trigger?

On x86-64 it can be triggered from user space using forged .sframe that
incorrectly specifies no fixed RA offset and thus causes the common
unwind user (sframe) logic to recover RA from the RA register using 
the dummy unwind_user_get_ra_reg().

> If the trigger is due to an architecture not supporting sframe correctly,
> then a WARN_ON() is appropriate.
> 
> But if this is not implemented by the architecture for normal reasons, why
> bother printing anything?

For unwind_user_get_ra_reg() that might be appropriate.  Although the
dynamic debug message could help developers to implement sframe for
another architecture.

Let me outline this for unwind_user_get_reg() and arm64:  This is used
to recover CFA/RA/FP from arbitrary registers in the topmost frame.
In SFrame such rules require SFrame V3 flexible FDE.  GNU assembler
does not support/generate flexible FDE for arm64.  Therefore arm64
would currently not need to implement unwind_user_get_reg().  But if a
toolchain would be enabled to support/generate flexible FDE on arm64 in
the future, the dynamic debug message might be helpful to quickly
determine why some of the stacktraces are incomplete and which piece
is missing to resolve.

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/


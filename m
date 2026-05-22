Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8098B3B9DA6;
	Fri, 22 May 2026 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779443734; cv=none; b=pA7o4sL1FFSDlEloCQyiPZ1qg1xyb92mUwuMTB570MqcJJIALKP4pnYlkwLChgsiT5RDS6BhRPrCf3sbdc/JXT4TuNxAV5oi36jzx4jyprYkEcgViKSDVNN4SePtI3X5REbIgLlRitLrhtnyNAubGxFKbKIbogBBV/7aOKjJU5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779443734; c=relaxed/simple;
	bh=+RNJAC5SPlGpdPTV+940lMLMKGDe/Djle87cIXOSZds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PcNIWYnUVPtSYak7pcRKH+molQsrWRNIHjdLRJJyseSL923I/Y8LS74r9X2U+HM1LO6uY0gexRV20DiBdfydocspcGhdEzXYNu1zRt/urK6V8GxJlqDt4fjdaCjl6c9kyG3LspjJ418/yJraXje5+PFybFvrNOMYp8XTGlpxErw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fdLJOL16; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fdLJOL16"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LLkwO31950620;
	Fri, 22 May 2026 09:55:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bHF3vA
	VKXoEc2N0ZQY1iQ6vlpewKqHyotyPmMC4Dokw=; b=fdLJOL16Jdn0e35mmxMjyp
	6wNYFGe4X/WkL4+0QB4Zb3ENGh9WWxtDbYEkKiWgVIL7J1dUiyY5hshf2d3krWXB
	jiI2+rgoqA1NRpsFYBbdrUwiEYq/WtNB7IkpbAg1KGctLavT1XZV5sxgPlzBDGG9
	3iXJVUlip+yY5rBMLIiAKN/J+enhmKbAyFxv5+4PuFJQBnnUs2xq+7h+9N6i9uI3
	QUbryKH1pRwwYFGt45JITscO+ojA24QAELnC8FFRkwc2bTpLMTRALfO34H/Qxd1H
	MGTXjgo+v6YmysdSzqppUlGmEf40+BvBbIulSrEVIiyheMtJ0q/xDc82bGTGTDYA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h88sw34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 09:55:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64M9sQGj025879;
	Fri, 22 May 2026 09:55:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754gr4xv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 09:55:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64M9tMbP50528652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 09:55:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C031820040;
	Fri, 22 May 2026 09:55:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B0102004E;
	Fri, 22 May 2026 09:55:22 +0000 (GMT)
Received: from [9.111.153.207] (unknown [9.111.153.207])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 09:55:22 +0000 (GMT)
Message-ID: <8f6ebddc-ab0d-40c9-954a-71a7a284f3cd@linux.ibm.com>
Date: Fri, 22 May 2026 11:55:21 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 07/20] unwind_user/sframe: Wire up unwind_user to
 sframe
To: sashiko-reviews@lists.linux.dev, Steven Rostedt <rostedt@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc: bpf@vger.kernel.org, Indu Bhagat <ibhagatgnu@gmail.com>
References: <20260521142546.3908498-8-jremus@linux.ibm.com>
 <20260521145307.2FB1C1F00A3B@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260521145307.2FB1C1F00A3B@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: pM_cRmo3fkMhuAKjb6b7r3mtcfVzYPp_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5NSBTYWx0ZWRfX/5ilX93G+wLy
 XSgohm1J1nx/2UfsWK3mVNIKxoFd5SQ8rFdYEFafpBlS43H1+B0GLajvcKCy0Cosx1iTRpidn2M
 WwZ4shmaAkDy8oA4scEIA7KEh2YWoVmH8wpsUJqAUa8eCuWfgDpDBxqiMwSnnrMu/1V6qWfpHZR
 6gdwaZhrd0SDLO6j6dhWsCU+f/Q54gX8PVvfSBLmLkYlsWKreX8fAP+RdjoOd0bIdhL5tGGUUTT
 FAY54abOIYWEXtWfvU/NabWekrmJrDiWx3XP5gJR7QE+r/0JhLzTPhPnKtzu8LUDw+60bdrRguh
 OA46593KDX4JZ96Sn310HwliHffsZvSz+v5moBYWPC5QpncA1jH9uZu/qOSBn6088TmN+5qpawI
 MMTEmWeIhPVLRQclK/+rZT3FSeITjsSQLg9csulxheCd1EEq/tHhgujhSYn5MIXxFbEjKJSWMjG
 6zPChFr07TBfQR4q2kw==
X-Proofpoint-GUID: 1_ZHPxryyEuEL63KZ7QecWaD-BFF9kcX
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a10280d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=ukAI1KAtYdXLE2hiip0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220095

On 5/21/2026 4:53 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Missing instruction pointer adjustment for return addresses during SFrame unwinding of non-topmost frames.
> --
> 
> commit 9e76c3f974e7ef0d88d0ca8c60fa84ef664ebee7
> Author: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> unwind_user/sframe: Wire up unwind_user to sframe
> 
> Now that the sframe infrastructure is fully in place, make it work by hooking
> it up to the unwind_user interface.
> 
>> diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
>> index 90ab3c1a205ef..1fb2724197332 100644
>> --- a/kernel/unwind/user.c
>> +++ b/kernel/unwind/user.c
> 
> [ ... ]
> 
>> @@ -82,6 +83,16 @@ static int unwind_user_next_fp(struct unwind_user_state *state)
>>  	return unwind_user_next_common(state, &fp_frame);
>>  }
>>  
>> +static int unwind_user_next_sframe(struct unwind_user_state *state)
>> +{
>> +	struct unwind_user_frame frame;
>> +
>> +	/* sframe expects the frame to be local storage */
>> +	if (sframe_find(state->ip, &frame))
> 
> [Severity: Medium]
> For non-topmost stack frames, state->ip holds the return address, which points
> to the instruction after the call. If a call is the very last instruction of a
> function (like a call to a noreturn function), the return address will point to
> the first instruction of the next contiguous function in memory.
> 
> Could sframe_find() incorrectly match the next function's FDE and apply its
> unwind rules to the current frame? Other table-driven unwinders handle this
> by subtracting 1 from the instruction pointer for non-topmost frames.

Valid.  Every now and then during testing on s390 a stacktrace ends e.g.
as follows, because the return address of a function with
__attribute__((noreturn)), such as exit(), might point at the following
function in storage, which then confuses unwind user:

objdump    1060    26.324199:     100010 task-clock:ppp:
             3ff9ec908b4 dfs_traversal.part.0+0x34 (/usr/lib/ld64.so.1)
             3ff9ec90900 dfs_traversal.part.0+0x80 (/usr/lib/ld64.so.1)
             3ff9ec90e68 _dl_sort_maps+0x4b8 (/usr/lib/ld64.so.1)
             3ff9ec84aa2 _dl_fini+0x252 (/usr/lib/ld64.so.1)
             3ff9e856b06 __run_exit_handlers+0x176 (/usr/lib64/libc.so.6)
             3ff9e856c00 internal_addseverity+0x0 (/usr/lib64/libc.so.6)

$ objdump -d build-sframe/libc.so
...
000000000004dee0 <exit>:
   4dee0:       eb ef f0 70 00 24       stmg    %r14,%r15,112(%r15)
   4dee6:       a7 59 00 01             lghi    %r5,1
   4deea:       e3 f0 ff 60 ff 71       lay     %r15,-160(%r15)
   4def0:       a7 49 00 01             lghi    %r4,1
   4def4:       c0 30 00 0d 9b a2       larl    %r3,201638 <__exit_funcs>
   4defa:       c0 e5 ff ff fe 9b       brasl   %r14,4dc30 <__run_exit_handlers>

000000000004df00 <internal_addseverity>:
   4df00:       eb 9f f0 48 00 24       stmg    %r9,%r15,72(%r15)
   4df06:       c0 10 00 0d 9b 9d       larl    %r1,201640 <severity_list>
   4df0c:       e3 f0 ff 60 ff 71       lay     %r15,-160(%r15)
...

But this should then be addressed in unwind_user_next_common(), which
would simply need to determine the next IP as RA - 1.  I have not
addressed this yet, as signal frames might require different handling.

> 
>> +		return -ENOENT;
>> +	return unwind_user_next_common(state, &frame);
>> +}
> 

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/


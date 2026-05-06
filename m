Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEA6481AB3;
	Wed,  6 May 2026 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778079370; cv=none; b=oR0qk+e4PQYABRNkznqHvnX9Vz5aw3ccM0MGf7Lg+tIpnmAAlwVfCfSdyNVOJbMlwxjYpStizj6Ck8AjzDEHweTr5bgv/fnl8M8CLdzhumlgUHIpOqoypKXxnCZYyne23xQcsjYuc83vEs3qd+qs3BG+NpcUxeJZvkr2xeH/6kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778079370; c=relaxed/simple;
	bh=7m5Nk1qFzT5HOZSO4iQAlFqGXLIgBfP/vdLh8QinHjE=;
	h=Message-ID:Date:MIME-Version:Subject:Cc:References:From:To:
	 In-Reply-To:Content-Type; b=pgApUkZ9c/J0X3OFZg9TTuueiBjamncrC50iPOYNTT5m94+yUElLYj6qN59FJnVJ0l006jQ+0FSPB1l4oJZxo2v2tgMqh0BI8biP64+F/GYkmr1AdkQXpNQbY+AXt7vqGpItpTQykQzdhYmU0J17grl+gxGuGLr20Hk+53WOSCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eeGVRoka; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eeGVRoka"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645MmvLQ1237317;
	Wed, 6 May 2026 14:56:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=M9MBX9
	+NIAZjWaOE+0KfLBn8H5yVsQEBP3ovCkiG9F4=; b=eeGVRokajuV2p1NAw/a4c+
	dDs53OTl8S4CU9upfMU5CWKRx8qrVWaPTuDNt1j17feMdp9RTay8pGzbhgHXl6gR
	ZAgPIh1Uv68flB4BXlOSPRwQl5JJlCNgQf9e9sv7CsbIRuBx6byaTN9wM/i3Ulhk
	kTHpGK/+dYhHUS+aePA6e7yEOUANClDRxu+etmu9vnfaTV0AiIQX9SuaLs6JrzA3
	5wzaj9IjmiXhSIEGRUz7D3reTRMHeeRrh7tnz5w71Bg/L+8I0Yns13g8eawXUE28
	bYBAhdZvGHbNZStcF6qpHLXHksZk08UiUddrgtjm1s41QzkQtPTMZ0Q2TL+0rdbg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xxrhwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 14:56:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646EdTdZ025513;
	Wed, 6 May 2026 14:56:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9yef2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 14:56:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 646Eu26h48824712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 14:56:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09FA52004B;
	Wed,  6 May 2026 14:56:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D995520040;
	Wed,  6 May 2026 14:56:01 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 May 2026 14:56:01 +0000 (GMT)
Message-ID: <29d28c6e-2909-444e-b22a-7429464056dd@linux.ibm.com>
Date: Wed, 6 May 2026 16:56:01 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 06/19] unwind_user/sframe: Detect .sframe sections in
 executables
Cc: bpf@vger.kernel.org, sashiko@lists.linux.dev
References: <20260505121718.3572346-7-jremus@linux.ibm.com>
 <20260505125336.72A36C2BCB4@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
To: Steven Rostedt <rostedt@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>,
        Indu Bhagat <ibhagatgnu@gmail.com>
In-Reply-To: <20260505125336.72A36C2BCB4@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE0NCBTYWx0ZWRfXzodgEge2KT+o
 Yn4uKK8mIEwLF1kCVK6ZIQ06E29ebJpU01W+XFiiZnhkr7jKnPOqwPNrQvbHLppQYx3ZqqIBRPY
 RrMrwBJAN3Ab5vJYhXPW5/S9WxZ3sctq1em+9fYvitpOM1/q6D9uYdW6kEztwNqeqAoMhwM37nX
 85ITeKcUBomYlLoH0JZnEGmHtucnVNne10Qw8c29gzyw6ktMJwzEDe88DC+p53Vus7vTlqNMhSM
 vb52bz+ygDG7mmvNmlsWRaTBVZS6iO7+cGZ0li7lKARTl6cflxwFCIAuxqrhU1L/BMe8MUeBM+/
 WLdQ6tMyF8BbDcr3TBSEUjKjw2bgWhGuUyq0sPbZIx5SfiHfYVS4foFkvp11nD3lEHUYeNaHSym
 5/Po84p9o0BNexMv5Lu3Ygq829maxqIvGT3sGwE08Xk+bshDaZarl0jFBAs1diqPZISAVgF3COx
 kQa6GRYcPNyNJ6vkNeQ==
X-Proofpoint-ORIG-GUID: HxaccEGKrDuycevbiiSJr6pjguoIctNL
X-Proofpoint-GUID: Prnwh_zQgtkXNHSmvw4ZgNStvnEpqR6G
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69fb5684 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=UoO_1Pgrh8XTa-HTx5YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060144

On 5/5/2026 2:53 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Missing `PT_LOAD` segment type check when registering executable sections for sframe unwinding.
> - [High] Off-by-one error in maple tree insertion bounds causes adjacent executable segments to fail registration.
> --
> 
> commit 610ebc2ab2a7fd5ae4cd4a346076c9d5c2acc195
> Author: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> unwind_user/sframe: Detect .sframe sections in executables
> 
> When loading an ELF executable, automatically detect an .sframe section
> and associate it with the mm_struct.
> 
>> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
>> index 16a56b6b3f6ca..55047659a3cf4 100644
>> --- a/fs/binfmt_elf.c
>> +++ b/fs/binfmt_elf.c
> [ ... ]
>> @@ -637,6 +638,21 @@ static inline int make_prot(u32 p_flags, struct arch_elf_state *arch_state,
>>  	return arch_elf_adjust_prot(prot, arch_state, has_interp, is_interp);
>>  }
>>  
>> +static void elf_add_sframe(struct elf_phdr *text, struct elf_phdr *sframe,
>> +			   unsigned long base_addr)
>> +{
>> +	unsigned long sframe_start, sframe_end, text_start, text_end;
>> +
>> +	sframe_start = base_addr + sframe->p_vaddr;
>> +	sframe_end   = sframe_start + sframe->p_memsz;
>> +
>> +	text_start   = base_addr + text->p_vaddr;
>> +	text_end     = text_start + text->p_memsz;
> 
> Should text_end be calculated as text_start + text->p_memsz - 1?
> 
> Since the maple tree API strictly expects inclusive ranges [first, last] for 
> insertions, passing the exclusive text_end would cause the inserted range 
> to cover one byte beyond the actual segment.

Shall we keep the text_end and sframe_end is pointing past the
respective section end semantic and just adjust the value passed on the
call to mtree_insert_range()?

> 
> If an ELF binary has adjacent executable PT_LOAD segments, could the first 
> segment's inclusive end overlap with the next segment's start and fail 
> subsequent insertions?
> 
>> +
>> +	/* Ignore return value, sframe section isn't critical */
>> +	sframe_add_section(sframe_start, sframe_end, text_start, text_end);
>> +}
>> +
> [ ... ]
>> @@ -712,6 +729,19 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
>>  				error = -ENOMEM;
>>  				goto out;
>>  			}
>> +			break;
>> +		}
>> +		case PT_GNU_SFRAME:
>> +			sframe_phdr = eppnt;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (sframe_phdr) {
>> +		eppnt = interp_elf_phdata;
>> +		for (i = 0; i < interp_elf_ex->e_phnum; i++, eppnt++) {
>> +			if (eppnt->p_flags & PF_X)

			if (eppnt->p_flags & PF_X && eppnt->p_type == PT_LOAD)

>> +				elf_add_sframe(eppnt, sframe_phdr, load_addr);
> 
> Does this need to verify the segment is loadable (eppnt->p_type == PT_LOAD)?
> 
> If non-loadable segments like PT_GNU_STACK have the PF_X flag set, they
> typically have p_vaddr and p_memsz as 0. Processing these segments would
> compute bogus text boundaries and bypass VMA validation. If a legitimate
> PT_LOAD segment overlaps with these bogus ranges, could its insertion fail
> silently and break stack unwinding for the executable?

Do you agree?

> 
>>  		}
>>  	}
>>  
> [ ... ]
>> @@ -1242,6 +1276,14 @@ static int load_elf_binary(struct linux_binprm *bprm)
>>  			elf_brk = k;
>>  	}
>>  
>> +	if (sframe_phdr) {
>> +		for (i = 0, elf_ppnt = elf_phdata;
>> +		     i < elf_ex->e_phnum; i++, elf_ppnt++) {
>> +			if ((elf_ppnt->p_flags & PF_X))

			if (elf_ppnt->p_flags & PF_X && elf_ppnt->p_type == PT_LOAD)

>> +				elf_add_sframe(elf_ppnt, sframe_phdr, load_bias);
> 
> Similarly, should this also check if the segment is a PT_LOAD segment before 
> adding it to the sframe sections?

Likewise.

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/


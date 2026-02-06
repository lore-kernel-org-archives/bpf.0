Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B2917736;
	Fri,  6 Feb 2026 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770386566; cv=none; b=I6ao3VNOJGD/loxgPJfA3HRujdHSSiyPgytFbXs6T+o7cq3pdckSLN//u1U9wYOBnJ8kCJCTeMykNrxkG9b6df6i+dKkZRU+gV09adHdW3GnDCJtvTRsW6/8rQjea/ZXja294O82y1jxzvdV9a9N/6iE8R28T1HtNKpcgEJlqug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770386566; c=relaxed/simple;
	bh=pyqxtvILUQDZ95xel4viuI9ICwczsp4jTzU+/Z7hG9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QhSTrKjaItD8wMch3l+/CGlRtc+FBQBHpZucE5F7hIme/DuxSNToR3Nkp/UVIAdfwo/QDvwBEQIaiJNRsLh16KM70ZgZh9tXLQb7cdLOdfU9VAsEo4y6j+YXXtTdQlFq31rEy7hhk5R3cM8gVRKfDZ/n0d12tU1Sk0etdDaNHLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JZqyYoC1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JZqyYoC1"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 616CwKY8032189;
	Fri, 6 Feb 2026 14:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5rTeGm
	WivFmx0h9oCMWdLVhqyGHZ8vG/gGEjTr34nc0=; b=JZqyYoC1dCZuow2dTuRAPi
	kffhIzL9Y0wJIqwCSU3c3HmSKviWuFYqb3PfoV55hidOPBhuBCO74s+zVj/z8zZm
	N4LBY6V0RGVTVYeBFztucaQ+YS3hrEm8yacUO8q2BEwr+p9TCBh36bPyztTbRzoR
	Begvzdwn8bXQADuf/n/ApO4b00wNP3xDoJ3QkzZRf8G7fGOHYd9fDQH0gRM+BDm6
	oFQ9/y7nAI85tGzxsOTyW0rOd41nKXf6bo4N7kKpG2o/obkhlBVzRB6fUTdapjl/
	6kquZeyEniNNpQTsNvLzoezTPZGrtVmAHlfXCk7YVL/A73nczo95pyf1pNLG8PdA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c185h8q2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 14:01:28 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 616E1R8o000813;
	Fri, 6 Feb 2026 14:01:28 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c185h8q2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 14:01:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 616DPce0005914;
	Fri, 6 Feb 2026 14:01:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c1x9jp44x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 14:01:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 616E1Mv031129980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Feb 2026 14:01:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAB8B20043;
	Fri,  6 Feb 2026 14:01:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BB772004B;
	Fri,  6 Feb 2026 14:01:20 +0000 (GMT)
Received: from [9.111.140.182] (unknown [9.111.140.182])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Feb 2026 14:01:19 +0000 (GMT)
Message-ID: <832897ac-f1d4-4f91-8034-f6b2d9e86fa4@linux.ibm.com>
Date: Fri, 6 Feb 2026 15:01:19 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/6] x86/asm: Avoid emitting DWARF CFI for non-VDSO
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        x86@kernel.org, linux-mm@kvack.org,
        Steven Rostedt <rostedt@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>,
        "Carlos O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>,
        Dylan Hatch <dylanbhatch@google.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
References: <20260203171958.1522030-1-jremus@linux.ibm.com>
 <20260203171958.1522030-3-jremus@linux.ibm.com>
 <bd2fdf83-e460-46ad-8617-16319bc55ca5@zytor.com>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <bd2fdf83-e460-46ad-8617-16319bc55ca5@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=UdxciaSN c=1 sm=1 tr=0 ts=6985f438 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=oGMlB6cnAAAA:8 a=jT-ijHZqpt8M6Ml0j-IA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2JgSa4NbpEOStq-L5dxp:22
 a=NdAtdrkLVvyUPsUoGJp4:22
X-Proofpoint-GUID: AVfC4cfylaxogN-qGUTbmOpp_mw_Lu9E
X-Proofpoint-ORIG-GUID: jo5kE4wFwL9iNHMz-So3u1DkBXo94QrW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDA5OSBTYWx0ZWRfXwRUWWbWoJ2KN
 CXLjScrh6OEZpc1H9DcVlgdSwf7fQogYn0lBZS58ZcH4WKOluwVZCHAdIE21bCDLJZzxDtE7LKT
 jysaMiE4mmFaPcMrGdP6xLDE83DJ+DgZiWpU2L36p1K5tka+HlS3kZma+bpbxCwFsPEkCbw+t9T
 Hbt97yDxIRwaaZkZtvMLplPRnHMiXOouDOO400eJXPix2gt6KELn1L7jdEZ3Tw3RW9/gTGc/TSf
 pYSskOv7w/zPdxSEqmsvtp0SvBbKtb2RtVuNv/mIoeTxpurp30ptkGGGyXvAen/m7CorbIw3Z8U
 plzEaAu9zoUD2GwHHPVd3+wBEtSf2pys67iyRCHFm47xKTryaJaeh53jxQdVvMuTqUzxbS4u6dq
 El8w5bXcVMsUULdnamZ1AAGWN0FDuihRZQV2ULjFWWUtc76D1tcaB6YP/jbM5Us+v2kHIvQl/V6
 Wbtu1Nv/f3bIMaQa/NQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_04,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602060099

On 2/4/2026 1:43 AM, H. Peter Anvin wrote:
> On 2026-02-03 09:19, Jens Remus wrote:
>> From: Josh Poimboeuf <jpoimboe@kernel.org>
>>
>> It was decided years ago that .cfi_* annotations aren't maintainable in
>> the kernel.  They were replaced by objtool unwind hints.  For the kernel
>> proper, ensure the CFI_* macros don't do anything.
>>
>> On the other hand the VDSO library *does* use them, so user space can
>> unwind through it.
>>
>> Make sure these macros only work for VDSO.  They aren't actually being
>> used outside of VDSO anyway, so there's no functional change.
>>
>> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
>> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>> Signed-off-by: Jens Remus <jremus@linux.ibm.com>
>> ---
>>  arch/x86/include/asm/dwarf2.h | 51 ++++++++++++++++++++++++-----------
>>  1 file changed, 35 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/dwarf2.h b/arch/x86/include/asm/dwarf2.h
>> index 09c9684d3ad6..7cc30500c095 100644
>> --- a/arch/x86/include/asm/dwarf2.h
>> +++ b/arch/x86/include/asm/dwarf2.h
>> @@ -6,6 +6,15 @@
>>  #warning "asm/dwarf2.h should be only included in pure assembly files"
>>  #endif
>>  
>> +#ifdef BUILD_VDSO
>> +
>> +	/*
>> +	 * For the vDSO, emit both runtime unwind information and debug
>> +	 * symbols for the .dbg file.
>> +	 */
>> +
>> +	.cfi_sections .eh_frame, .debug_frame
>> +
>>  #define CFI_STARTPROC		.cfi_startproc
>>  #define CFI_ENDPROC		.cfi_endproc
>>  #define CFI_DEF_CFA		.cfi_def_cfa
>> @@ -22,21 +31,31 @@
>>  #define CFI_ESCAPE		.cfi_escape
>>  #define CFI_SIGNAL_FRAME	.cfi_signal_frame

I missed that this is new on tip:x86/entry and thus also needs to be
added below in the !BUILD_VDSO case.

>>  
>> -#ifndef BUILD_VDSO
>> -	/*
>> -	 * Emit CFI data in .debug_frame sections, not .eh_frame sections.
>> -	 * The latter we currently just discard since we don't do DWARF
>> -	 * unwinding at runtime.  So only the offline DWARF information is
>> -	 * useful to anyone.  Note we should not use this directive if we
>> -	 * ever decide to enable DWARF unwinding at runtime.
>> -	 */
>> -	.cfi_sections .debug_frame
>> -#else
>> -	 /*
>> -	  * For the vDSO, emit both runtime unwind information and debug
>> -	  * symbols for the .dbg file.
>> -	  */
>> -	.cfi_sections .eh_frame, .debug_frame
>> -#endif
>> +#else /* !BUILD_VDSO */
>> +
>> +/*
>> + * On x86, these macros aren't used outside VDSO.  As well they shouldn't be:
>> + * they're fragile and very difficult to maintain.
>> + */
>> +
>> +.macro nocfi args:vararg
>> +.endm
>> +
>> +#define CFI_STARTPROC		nocfi
>> +#define CFI_ENDPROC		nocfi
>> +#define CFI_DEF_CFA		nocfi
>> +#define CFI_DEF_CFA_REGISTER	nocfi
>> +#define CFI_DEF_CFA_OFFSET	nocfi
>> +#define CFI_ADJUST_CFA_OFFSET	nocfi
>> +#define CFI_OFFSET		nocfi
>> +#define CFI_REL_OFFSET		nocfi
>> +#define CFI_REGISTER		nocfi
>> +#define CFI_RESTORE		nocfi
>> +#define CFI_REMEMBER_STATE	nocfi
>> +#define CFI_RESTORE_STATE	nocfi
>> +#define CFI_UNDEFINED		nocfi
>> +#define CFI_ESCAPE		nocfi

#define CFI_SIGNAL_FRAME		nocfi

>> +
>> +#endif /* !BUILD_VDSO */
>>  
>>  #endif /* _ASM_X86_DWARF2_H */
> 
> I guess patch 3 justifies this.
> 
> Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> 

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/


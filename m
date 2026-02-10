Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA44530EF86;
	Tue, 10 Feb 2026 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770734231; cv=none; b=EHtzPcQ0AEb5r292wkMK9fGBwbWFeDl/caQoTGXdGbmx1oVrHJKygp2+90wXMi+MAK8z8j58I4+nFj3ffVCDUU2JbF3ANkiVf+svdZZC6KsUcW+IdPLgxrwltL1Uq1wZfnuJORY1ZYfDIbMbg3F98hwjKXVimtrDJ1zCo51HNdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770734231; c=relaxed/simple;
	bh=VzSEah1T+ifOQYUE3oxXjAmosA57tS83AXNBP80LXFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XMDQ5kOzNkNtt1Tza3FciLhJiGByc1stAz0foPy+UK1YKirPNlUtFwS+PqFxWAfLbMc7N8Zq4u4Wm3XzKEVUYKr/IKdd4ADQEEHVvVXtGMB1kgnXNSIOIUICWc0RP6DGwSmjS9HEcLUb/0cp/7dTolmo0sAA7vMMgWTg+t/hFq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NM2LxmOW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NM2LxmOW"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A96Rnu266057;
	Tue, 10 Feb 2026 14:36:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xv775C
	+v9f6XgR+p2D0lIDqSm39LsMcZTlhZaKAdvQw=; b=NM2LxmOWiEjAFbLNhICE0P
	HZBRnHh6GBpD30ndfsu3cCteV44nfoAg6DeOGmGMWH9uArQFfk273BHZ6e1ZJN87
	guK0Q3yVecFi4Q1JuEcYnOaPWUz5pczWy9wODSGIKibWf5gnNsSqMmMhJBYuF/S2
	hTOIH21cx8PvZ/UrMnprYrvtdF1hZZBqvYBEZHRUcsEuFyNLp8ER5zS7XYpT70Zt
	kN1TGXi0BukYV6J3Y7wQZM+/srTE5vjJS0rOH5GL1Pk9no7EkIQu5ZBESeeifMSJ
	soUwr3eXVT0ODdrovPlx/7f6VSaKAcEHyM9kbOHi+N1Dz0fWmYDFhVC87RwJuOzw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696v2g91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 14:36:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61ABMm4S019246;
	Tue, 10 Feb 2026 14:36:19 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6hxk1fwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 14:36:19 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61AEaF6256885560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Feb 2026 14:36:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC18E20043;
	Tue, 10 Feb 2026 14:36:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21BAD20040;
	Tue, 10 Feb 2026 14:36:15 +0000 (GMT)
Received: from [9.52.200.149] (unknown [9.52.200.149])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Feb 2026 14:36:15 +0000 (GMT)
Message-ID: <cb96d2bf-f2eb-46f7-be7b-8e144eda5d75@linux.ibm.com>
Date: Tue, 10 Feb 2026 15:36:14 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/6] x86/vdso: Enable sframe generation in VDSO
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        x86@kernel.org, linux-mm@kvack.org,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Steven Rostedt <rostedt@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>,
        "Carlos O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>,
        Dylan Hatch <dylanbhatch@google.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
References: <20260206193642.1580787-1-jremus@linux.ibm.com>
 <20260206193642.1580787-7-jremus@linux.ibm.com>
 <4304d18a-f647-4709-9f29-43d9995cc24e@zytor.com>
 <22bc8f74-1943-4ceb-bc6b-ea404ba013d9@linux.ibm.com>
 <b074b10e-6b3e-4c69-a986-6b2eb665e535@zytor.com>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <b074b10e-6b3e-4c69-a986-6b2eb665e535@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: SFmHdxr9wKQnrtOhu1rvepaBdYcztLgF
X-Proofpoint-ORIG-GUID: uMzqvdgEmena8fMVWt0oSzSFDtD_Sgk3
X-Authority-Analysis: v=2.4 cv=JdWxbEKV c=1 sm=1 tr=0 ts=698b4265 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=CCpqsmhAAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=bkxOAO0_A-Sbfl51zi0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ul9cdbp4aOFLsgKbc677:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDEyMCBTYWx0ZWRfX57jBsQYf2w65
 HRQ9vJa/ZJoCGkLqOtkikprfJcivSiqxr/yN5UWg/dOrd/GzSEudSeBmGDj3erlKO5D1MfSrd83
 7C1KWfVwokSjGLwsxSpI0qYjl5qMbPAtIYqVEN/jSnAUQXWwTRoTgnbgN4TU6n3s76ClL2SRXZl
 NPXYnPBDZvMphAyBfRlE/Kdnj2TJWHkWFvSKUysDoDgOtLEE5E5iI5TbhUiT/6iZWgf/yAo3gwz
 oLciIA9bktLvWqca24eaktQJkEX/p3xgie59BjO/h2KnDtaq67OdYCMqJSxXxHrLKNq/UUhqIWr
 C43TxvSMu8EphC9uPaek7m8kjzebNHXJkD77xogmrVmSRiP3ysqWfGztNl9NVBTmBcYlVoURNfK
 LUyMk0Dlc9cGJdvjwDycut64vYLKyLNOvGDgA/BrAeih49oiQYtDAEDDfL9NCqGvfTxCTwz/DKR
 JfrLJvGCnTUeCbNIXhw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100120

On 2/9/2026 8:13 PM, H. Peter Anvin wrote:
> On 2026-02-09 08:45, Jens Remus wrote:
>> On 2/7/2026 12:08 AM, H. Peter Anvin wrote:
>>> On 2026-02-06 11:36, Jens Remus wrote:
>>>> From: Josh Poimboeuf <jpoimboe@kernel.org>
>>>>
>>>> Enable sframe generation in the VDSO library so kernel and user space
>>>> can unwind through it.
>>>>
>>>> SFrame isn't supported for x32 or x86-32.  Discard .sframe sections for
>>>> those VDSOs.
>>>>
>>>> [ Jens Remus: Add support for SFrame V3.  Prevent GNU_SFRAME program
>>>> table entry to empty .sframe section. ]
>>>>
>>>
>>> This will not break the x86-32 build if the assembler encounters .sframe?
>>
>> I cannot follow.  Assembler option --gsframe-3 is only specified in
>> vdso64/Makefile if CONFIG_AS_SFRAME3, which affects the x86-64 and x32
>> VDSOs.  The latter as the x32 VDSO is built from x86-64 objects
>> converted to x86-32 objects using the X32 build step.  Assembler
>> directive ".cfi_sections .sframe" is no longer used in dwarf2.h, which
>> affected the x86-32 VDSO if cross build on x86-64 (so that
>> CONFIG_AS_SFRAME3=y).
>>
>> The reason to discard .sframe in the common VDSO linker script if
>> !KEEP_SFRAME is to remove it from x32 VDSO (built from x86-64 objects
>> having .sframe).  It should also prevent linker errors from linkers that
>> do not support R_X86_64_PC64 in x32 mode, such as the meanwhile fixed
>> GNU linker:
>> https://www.sourceware.org/bugzilla/show_bug.cgi?id=33807
>>
> 
> OK, the linker not handing R_X86_64_PC64 is probably a good enough reason to
> discard .sframe.

For clarification:

Binutils < 2.46 assembler generates SFrame V2, which uses PC32
relocations.
Binutils 2.46+ assembler will generate SFrame V3, which uses PC64
relocations, which the GNU linker will also support for x32.

The intent is to only support SFrame V3 in unwind user sframe and
therefore also only enable .sframe generation in VDSO using SFrame V3.

> The x32 ABI and object format is explicitly intended to be as close to the
> x86-64 as possible; it even uses the same architectural identifier. That's
> pretty much the reason we don't even bother recompiling the objects in the
> first place; the 64-bit objects can simply be downconverted from ELF64 to
> ELF32. This also means that the compiler doesn't need to support x32, although
> objcopy and ld does.
> 
> This also means the DWARF data is the one generated for 64 bits.
> 
> This works because the following is true for all vdso entrypoints:
> 	- No vdso entry point access pointers or explicit "long"s *in memory*.
> 	  (The latter formally violates POSIX for struct timespec, but that
> 	   was a deliberate decision imposed by Linus at the time the x32 API
> 	   was defined: "no 32-bit time_t in a new ABI.")
> 	- No vdso entry point calls system calls that do, either.
> 	- No vdso entry point takes a *signed* long as an argument.
> 	- No vdso entry point calls system calls that differ in behavior
> 	  between x86-64 and x32, making it OK to call the 64-bit system call
> 	  from an x32 process.
> 
> "unsigned long" and pointers *can* be safely passed in argument registers
> (because the architecture will zero-extend those registers), and in addition
> "signed long" *can* be safely passed as returns.
> 
> If ANY of the constraints above were ever violated, OR the binary format would
> start diverging to the point that objcopy can't properly convert it, then we
> would need to start compiling the x32 binaries separately.

Thank you for the detailed explanation!

>> The following works and indeed looks nicer with #if KEEP_SFRAME.  Will
>> wait for further feedback on whether or not to discard .sframe in x32
>> VDSO before sending a v9.
> 
> I think ld tripping over a bug justifies dropping .sframe at this point. *Make
> sure* to document that in the checkin, and add a comment to vdso32.lds.S that
> that is the motivation, so that if x32 gains support for .sframe in the future
> (which should be simple enough, since the formats are so similar) we don't get
> stuck in some kind of cargo cult programming problem.
> 
> It also will avoid issues on the off chance .sframe ends up being defined
> differently for x32 for some reason, perhaps for consistency with other 32-bit
> platforms.
> 
> 
> Include the version of binutils which fixed the problem in your comments.

Ok, will do.

>> diff --git a/arch/x86/entry/vdso/vdso64/vdso64.lds.S b/arch/x86/entry/vdso/vdso64/vdso64.lds.S
>> @@ -8,10 +8,7 @@
>>   */
>>  
>>  #define BUILD_VDSO64
>> -
>> -#ifdef CONFIG_AS_SFRAME
>> -# define KEEP_SFRAME
>> -#endif
>> +#define KEEP_SFRAME	(CONFIG_AS_SFRAME)
> 
> This needs to be IS_ENABLED(CONFIG_AS_SFRAME). Otherwise you get either "y" or
> "CONFIG_AS_SFRAME", neither of which are what you want.

Good catch!  Will fix.

> 
>>  #include "common/vdso-layout.lds.S"
>>  
>> diff --git a/arch/x86/entry/vdso/vdso64/vdsox32.lds.S b/arch/x86/entry/vdso/vdso64/vdsox32.lds.S
>> @@ -8,6 +8,7 @@
>>   */
>>  
>>  #define BUILD_VDSOX32
>> +#define KEEP_SFRAME	false
> 
> Is "false" supported by all appropriate cpp versions? "0" is probably a safer
> choice, and matches the IS_ENABLED() output anyway.

Will do.  I assumed "true" / "false" would be supported, given there are
a few instances:

  $ git grep "#define.*\(false\|true\)" -- arch/x86/

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/


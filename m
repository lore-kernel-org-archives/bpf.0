Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFD32BDC3D;
	Mon,  9 Feb 2026 16:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770655570; cv=none; b=B8KLslshHDrzInr9a4IyUXcoe35qgq8DdOptgiRKL5ZxAFkrOlZuAE/RuWAOYkEW9A+cmkW0JdVsowBWY7o87v/yvBgucvv95nfgrlsNNNFwRWN4WeVueQkmIRncjqgkfkE94GyKSxqqM+In/5RC733kTAcgT901XFTpaB3Ux9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770655570; c=relaxed/simple;
	bh=SacGcAFriRBfbeeol7Y8tVDpLla1QfnHx5e6X0PwsII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uv7yyY6bptAJrZ3+40NZYf1wSnzKuTFG6LmkjdOgVSB50eZ9wFzo2YmwXzllrEvr4fsRvPqYdE68V1nAPwIqOWtiReKeDUvTPxt3Sy0SSQmI+Z9oJAM9TvIrtfyXRsGOzmOoGwpgTWh0aVC7gogkTPUqu96ttUbj413idzytdQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VYGBqoIq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VYGBqoIq"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619F9Ugg198637;
	Mon, 9 Feb 2026 16:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mgWRp5
	BJpGIs54qvIzdHztXdVPFvfDEGzpCJ5H4U80U=; b=VYGBqoIqN8crw+1FMR6MJz
	2CJpZ1n3m2iW0HfwKjjiw/PvFOrJdC6/xtg9Q/ABP9cynXe29DYbA3/oJOCAmfpe
	UH9fS06nzY1qHGGyH/0B7RV1gl8ZZmrJx0DmElXWysyt6IrCbtm9P7lUcKY4u1wO
	ScNAmdgJj+gSdY6hq7IMNPmJ5czWJu1u+MxmAqgcKKiFgz1O/BM6Aq/V4Q/eZqQg
	v49/VBn4Vea5OLSm9YrgGXvG6e9wcEfOxQt3C6VlFCLFUIRI0J1UwLlKFc0RXYHC
	nGmh34I4jSkIF1vwYArwewClckrjXQAjKIz/shNEgHqdReLsh2kyxb4gI/QdhNqg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696u87kg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 16:45:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 619COh3D002575;
	Mon, 9 Feb 2026 16:45:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6fqse4g6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 16:45:39 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 619GjaQY61735258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Feb 2026 16:45:36 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9EF52004E;
	Mon,  9 Feb 2026 16:45:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30D6E20040;
	Mon,  9 Feb 2026 16:45:34 +0000 (GMT)
Received: from [9.111.207.126] (unknown [9.111.207.126])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Feb 2026 16:45:34 +0000 (GMT)
Message-ID: <22bc8f74-1943-4ceb-bc6b-ea404ba013d9@linux.ibm.com>
Date: Mon, 9 Feb 2026 17:45:33 +0100
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
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <4304d18a-f647-4709-9f29-43d9995cc24e@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KZnfcAYD c=1 sm=1 tr=0 ts=698a0f34 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=CCpqsmhAAAAA:8
 a=p0WdMEafAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=9N4VBBPUECb1X48xbtsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ul9cdbp4aOFLsgKbc677:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDEzNyBTYWx0ZWRfXygjrYvM1MW3L
 3sizdqIxHZ+wif6XZOz5yK/KXQ5K4/mfjuJLIdR0BHBvgMIpwocArcocHUIouFPPPnh7D+cKgJj
 CeyBsEzwC9H82+CgywwFjcfzNQizGDGj7OG6yQk9EbkOhLY5yUj4hHLtmEHo8KkEYT5/kTolkjz
 MuDhcNwT9RAYv+opTWHPrqvPmnTzyzldd6JmnOGCsAQ43JI3XMJaz3xKPc70g0Mz2y2ltq9negH
 cWEK3A1GW0IASw5RJDFhmEqBoOw6edrTWh5Z+/qT8u9LSHRL6ujkPW1OtYdA7O7j9l8aJ0jtRWN
 xR56tXxhgEObJx6aNJGAaUmGfeUEkOmR1ueKrEr7FpGZB0TeNjICbgHWYaS6VSlNtKzangGlfGm
 gHLVQMvmiO+Tupy1gsxVsk4Y/MG953kHRoahDecA6YnvgJpfumCEeqlK9aPTSFb8odfhMOjYxOS
 P3MD+QYIszbEajsvNmw==
X-Proofpoint-ORIG-GUID: IAWdWS6llLM78oQw-7cCQ61JU4e_TcVq
X-Proofpoint-GUID: IAWdWS6llLM78oQw-7cCQ61JU4e_TcVq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090137

On 2/7/2026 12:08 AM, H. Peter Anvin wrote:
> On 2026-02-06 11:36, Jens Remus wrote:
>> From: Josh Poimboeuf <jpoimboe@kernel.org>
>>
>> Enable sframe generation in the VDSO library so kernel and user space
>> can unwind through it.
>>
>> SFrame isn't supported for x32 or x86-32.  Discard .sframe sections for
>> those VDSOs.
>>
>> [ Jens Remus: Add support for SFrame V3.  Prevent GNU_SFRAME program
>> table entry to empty .sframe section. ]
>>
> 
> This will not break the x86-32 build if the assembler encounters .sframe?

I cannot follow.  Assembler option --gsframe-3 is only specified in
vdso64/Makefile if CONFIG_AS_SFRAME3, which affects the x86-64 and x32
VDSOs.  The latter as the x32 VDSO is built from x86-64 objects
converted to x86-32 objects using the X32 build step.  Assembler
directive ".cfi_sections .sframe" is no longer used in dwarf2.h, which
affected the x86-32 VDSO if cross build on x86-64 (so that
CONFIG_AS_SFRAME3=y).

The reason to discard .sframe in the common VDSO linker script if
!KEEP_SFRAME is to remove it from x32 VDSO (built from x86-64 objects
having .sframe).  It should also prevent linker errors from linkers that
do not support R_X86_64_PC64 in x32 mode, such as the meanwhile fixed
GNU linker:
https://www.sourceware.org/bugzilla/show_bug.cgi?id=33807

> 
>> Notes (jremus):
>>     Changes in v8:
>>     - Discard .sframe for x32 and x86-32 VDSOs. (Josh/Indu)
>>       Note that the use of KEEP_SFRAME enables to define it for x86-64
>>       VDSO only.  Unlike CONFIG_AS_SFRAME, which may also be defined
>>       for x32 and x86-32 VDSO.  In x32 VDSO it would result in superfluous
>>       .sframe (copied from the x86-64 build - could be removed in X32
>>       build step).  In x86-32 VDSO it would cause a bogus GNU_SFRAME
>>       program table entry.
> 
> For x32, this would be a "valid" sframe, right, even if the tools currently
> don't know how to consume it (and potentially never will)? If so, is there
> really any reason to explicitly remove it?

I am not an x86 expert.  IIUC the x32 ABI uses 4-byte pointers.  But GCC
with option -mx32 emits DWARF that suggests that at least the return
address (RA) and frame pointer (FP; rbp) are still pushed as 8-byte
values on the stack, which would be relevant for SFrame:

00000000 <foo>:
   0:   55                      push   %rbp
   1:   89 e5                   mov    %esp,%ebp
...

   LOC           CFA      rbp   ra
0000000000000000 rsp+8    u     c-8   <-- suggests RA is 8-bytes on stack
0000000000000001 rsp+16   c-16  c-8   <-- suggests FP is 8-bytes on stack
...

That could mean that technically the .sframe would be mostly valid.  The
fixed RA offset of -8 would be correct, the variable FP offset would be
tracked, and the implicit SP rule SP=CFA should be correct as well.  But
the SFrame header would incorrectly specify AMD64 as ABI/arch ID instead
of ILP32 (if I got the ELF x86-64-ABI psABI [1] correct).

AFAIK SFrame does not officially support ILP32.  At least GNU assembler
does not:

$ printf ".cfi_startproc\n.cfi_endproc\n" | as --gsframe-3 --x32 ; echo $?
Assembler messages:
{standard input}: Error: .sframe not supported for target
1

My take would be that it would be better to build x32 VDSO without
.sframe (or discard .sframe from x32 VDSO), unless it is officially
supported.

@Indu: What are your thoughts as SFrame maintainer?

[1]: ELF x86-64-ABI psABI,
     https://gitlab.com/x86-psABIs/x86-64-ABI

>>  	/*
>>  	 * Text is well-separated from actual data: there's plenty of
>>  	 * stuff that isn't used at runtime in between.
>> @@ -80,6 +87,10 @@ SECTIONS
>>  		*(.discard)
>>  		*(.discard.*)
>>  		*(__bug_table)
>> +#ifndef KEEP_SFRAME
>> +		*(.sframe)
>> +		*(.sframe.*)
>> +#endif
> 
> This #ifndef is actually not necessary: if we have already "consumed" the
> .sframe* sections they will not be encountered here.

It is necessary to remove .sframe from x86-64 objects (created by the
x86-64 VDSO build) converted to x86-32 objects in the X32 build step for
x32 VDSO, provided SFrame is not supported for x32.  The x86-64 VDSO has
.sframe, as the x86-64 VDSO linker script defines KEEP_SFRAME.  The x32
VDSO has .sframe removed, as the x32 linker script does not define
KEEP_SFRAME.

An alternative to the #ifndef (or #if !KEEP_SFRAME) would be to remove
the .sframe in the X32 build step:

diff --git a/arch/x86/entry/vdso/vdso64/Makefile b/arch/x86/entry/vdso/vdso64/Makefile
@@ -23,14 +24,14 @@ include $(src)/../common/Makefile.include
 #
 # Build x32 vDSO image:
 # 1. Compile x32 vDSO as 64bit.
-# 2. Convert object files to x32.
+# 2. Convert object files to x32 and remove .sframe.
 # 3. Build x32 VDSO image with x32 objects, which contains 64bit codes
 # so that it can reach 64bit address space with 64bit pointers.
 #

 # Convert 64bit object file to x32 for x32 vDSO.
 quiet_cmd_x32 = X32     $@
-      cmd_x32 = $(OBJCOPY) -O elf32-x86-64 $< $@
+      cmd_x32 = $(OBJCOPY) -O elf32-x86-64 -R .sframe $< $@

 $(obj)/%-x32.o: $(obj)/%.o FORCE
	$(call if_changed,x32)

KEEP_SFRAME (or then maybe better HAVE_SFRAME) would then still be
required to only emit a program table entry, if .sframe was generated.

Note that AS_SFRAME only indicates whether the assembler supports to
generate .sframe.  Not whether if it should actually be done.  That is
selected by adding the --gsframe-3 assembler option and defining
KEEP_SFRAME to true, which is done in the respective VDSO Makefile and
linker script.

> I would prefer to have KEEP_SFRAME always defined (as true or false, and using
> #if) instead of using #ifdef. I believe that also means you can do:
> 
> #define KEEP_SFRAME IS_ENABLED(CONFIG_AS_SFRAME)
> 
> ... instead of #ifdef.

The following works and indeed looks nicer with #if KEEP_SFRAME.  Will
wait for further feedback on whether or not to discard .sframe in x32
VDSO before sending a v9.

diff --git a/arch/x86/entry/vdso/common/vdso-layout.lds.S b/arch/x86/entry/vdso/common/vdso-layout.lds.S
@@ -60,7 +60,7 @@ SECTIONS
 		*(.eh_frame.*)
 	}					:text
 
-#ifdef KEEP_SFRAME
+#if KEEP_SFRAME
 	.sframe		: {
 		KEEP (*(.sframe))
 		*(.sframe.*)
@@ -87,7 +87,7 @@ SECTIONS
 		*(.discard)
 		*(.discard.*)
 		*(__bug_table)
-#ifndef KEEP_SFRAME
+#if !KEEP_SFRAME
 		*(.sframe)
 		*(.sframe.*)
 #endif
@@ -116,7 +116,7 @@ PHDRS
 	dynamic		PT_DYNAMIC	PF_R;
 	note		PT_NOTE		PF_R;
 	eh_frame_hdr	PT_GNU_EH_FRAME PF_R;
-#ifdef KEEP_SFRAME
+#if KEEP_SFRAME
 	sframe		PT_GNU_SFRAME	PF_R;
 #endif
 	gnu_stack	PT_GNU_STACK	PF_RW;
diff --git a/arch/x86/entry/vdso/vdso32/vdso32.lds.S b/arch/x86/entry/vdso/vdso32/vdso32.lds.S
@@ -10,6 +10,7 @@
 #include <asm/page.h>
 
 #define BUILD_VDSO32
+#define KEEP_SFRAME	false
 
 #include "common/vdso-layout.lds.S"
 
diff --git a/arch/x86/entry/vdso/vdso64/vdso64.lds.S b/arch/x86/entry/vdso/vdso64/vdso64.lds.S
@@ -8,10 +8,7 @@
  */
 
 #define BUILD_VDSO64
-
-#ifdef CONFIG_AS_SFRAME
-# define KEEP_SFRAME
-#endif
+#define KEEP_SFRAME	(CONFIG_AS_SFRAME)
 
 #include "common/vdso-layout.lds.S"
 
diff --git a/arch/x86/entry/vdso/vdso64/vdsox32.lds.S b/arch/x86/entry/vdso/vdso64/vdsox32.lds.S
@@ -8,6 +8,7 @@
  */
 
 #define BUILD_VDSOX32
+#define KEEP_SFRAME	false
 
 #include "common/vdso-layout.lds.S"
 
Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/


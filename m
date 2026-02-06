Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5600425CEF;
	Fri,  6 Feb 2026 17:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770400151; cv=none; b=h/CDdPUtTH5nSWRrIVnrmltI7i0wf9cX0mrRwdweDU12B70p5/x6AXCF2MBbK2FRogtQq4zFfiaH6f0bywWrNcvuSq/rUetzf2ly7OAGpJohpGwDyoeeR6G/OPYg15TZS/gMe4vHjVo01/sBT2fxlM+d14KnlbzD9RUmJ7O4FPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770400151; c=relaxed/simple;
	bh=G4QgfWRcBGu2ZsVdFdieDq7rPQIrkm5HC2umC1VTPCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CeautlXlN2tOGheAg9+xE1y23kakr/KuhCuNClPi5gOVv569mZsPNM6muUQ7+f69CvIn4F9wiAmH52UEc1j5465DPXa4iJaNHaZaaUg7tfI5hkn5Kca/b+5zBSP4rnltIL3562a9je9SV+VlCQoiDor+8hb6Rwxcq+sylloy4Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lGw4/sX+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lGw4/sX+"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 616CshDX023156;
	Fri, 6 Feb 2026 17:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=95V3b+
	ZVOs7mOp1p1nkpVTlGEQ1HKsAHiv7J4h8kLtM=; b=lGw4/sX+4FkoRgMhJJ6jlL
	v8YwLrK3myUbl+ahWma6HfLwuEQplmRh/7+BJyYf5FrwjUTRLnq6Jbt2oS8exR1W
	DkbxkavYeSRD8duqbowI58R9RYCU/u/LWbVCKST0pIy3lK/Bz6ykNY9PHTPOfeUr
	qdT7EX+sg/0OFloalatIZkFfrbjJFQF7oq9S29JSwENpE6QNT4E2Opk+NJZ6qKPx
	Y1C1hNa5vNegXOL+wxQ5pYu0Q2gRBnGLkMIeMdnc9Ysv3inhQaeTlu+H4UYpQDXC
	GfNdWQqWToCiK/biB7yfGtbemRRTcbAtjipNV7gDaygUClMUswnMMs16BGm5phSA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19cwhgea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 17:48:31 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 616HmUbn029982;
	Fri, 6 Feb 2026 17:48:31 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19cwhge8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 17:48:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 616FwNNC009156;
	Fri, 6 Feb 2026 17:48:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c1veyf9ef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 17:48:29 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 616HmPfR61669838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Feb 2026 17:48:25 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9E722004B;
	Fri,  6 Feb 2026 17:48:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D3D020043;
	Fri,  6 Feb 2026 17:48:24 +0000 (GMT)
Received: from [9.111.139.102] (unknown [9.111.139.102])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Feb 2026 17:48:24 +0000 (GMT)
Message-ID: <9a63ce89-84f0-4782-90bf-dfd7c8ec8c52@linux.ibm.com>
Date: Fri, 6 Feb 2026 18:48:24 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/6] x86/vdso: Enable sframe generation in VDSO
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        x86@kernel.org, linux-mm@kvack.org,
        Steven Rostedt <rostedt@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
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
 <20260203171958.1522030-7-jremus@linux.ibm.com>
 <f671c79a-ee73-4a12-af48-2811f97b9f3d@zytor.com>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <f671c79a-ee73-4a12-af48-2811f97b9f3d@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDEyNyBTYWx0ZWRfX6fNUOzCorNIn
 VVQclkHCe0KuRSlmimy0Dz8UEyaxTtXtzi13UaXTIN/jrjaGqGGDBAgPZzI0NQ2swZxWdGg35WX
 ODbkjEmlA2/+sSatI0IhSbV3cBq/wc2gpJkvhflKKGutxmgtCXiEn1cVPU1Cblt26OlgyRiAv/f
 ZYUqxp5jacyRoLDLUWRtNMT9w/OpHor3UVy0uVtIL/aNT++HPFJa8hhomQf6Kgd6qxSEV8jou5Q
 z9A0NpYqJMzpfa8MZ4LzIOfGfOw0wOpHjDfdpVeY/f7dVnxmdwGv4HvPFgver1QK1i9ToSmWJcJ
 D8EfW9kTf0EKwvXtKT3q0HmaN61f57u1Z7z/x9c01pnlB6HsL7c4YAmQwceotDfiKBYRPfqOVlz
 wxB7Poz+CVfdckaCuVTaUtGnJLercniNAgiJd37nH9ggyKBkEEYMXov5fqRpvMvrGi9mob8sB5L
 CdOdSqRgP988gXMtLWw==
X-Authority-Analysis: v=2.4 cv=UuRu9uwB c=1 sm=1 tr=0 ts=6986296f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=44IIZKTLfzUdFyxfebkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: kzzsbcp9iTOOGyukaKwzD6Q6COVYIuXo
X-Proofpoint-GUID: RqJI4D_4LN6rKVzpRhjzBBV7lsDjQNw6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602060127

On 2/4/2026 1:49 AM, H. Peter Anvin wrote:
> On 2026-02-03 09:19, Jens Remus wrote:
>> -
>> +#if defined(__x86_64__) && defined(CONFIG_AS_SFRAME)

My understanding is that you would like above changed to:

#ifdef CONFIG_AS_SFRAME

>> +	.cfi_sections .eh_frame, .debug_frame, .sframe
>> +#else
>>  	.cfi_sections .eh_frame, .debug_frame
>> +#endif
>>  
> 
> It would be better to:
> 
> #undef CONFIG_AS_SFRAME	/* i386 doesn't support .sframe */
> 
> in fake_32bit_build.h.
Due to (binutils 2.46 pre-release) GNU assembler supporting --gsframe-3,
but only for x86-64 not for x86-32 (nor x32) CONFIG_AS_SFRAME is enabled
even for my i386 cross build attempt.  This then wrongly causes the
.cfi_sections with .sframe to be selected (verified by adding an #error
for testing).

IIUC the .cfi_sections is there to have DWARF in both .eh_frame and
.debug_frame.  For .sframe it basically has the same effect as
specifying the common assembler option --gsframe.  Given the more
specific option --gsframe-3 is explicitly specified I think it would
be better to drop the changes to both dwarf2.h and fake_32bit_build.h
and solely rely on --gsframe-3.

Josh, Indu, do you agree?

Thanks and rRegards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/


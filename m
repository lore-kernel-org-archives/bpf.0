Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E77626FD9A;
	Fri,  6 Feb 2026 15:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390235; cv=none; b=VoFSDS6E79ONm1b95TCNcazHzKJ6Cq+yjABeik5GDARIAXL8arhJmaSU8PNTUEP8GYJ4nDheG9m/OiPKnQgFJgqOQ+wi9gYEMH1bfmIzXaz1PV8wmTcPjFruqxb/2tkAJ7A8Airi5BWBBFopKbYE9hAFydLA5l7XgVk1YRdQjxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390235; c=relaxed/simple;
	bh=0oI6B6aCvh81sh7jspiVR9r4ccHV4xkkybbTIVgyrPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3i2TNgUxC1zMhuL3+mvD6AMgJZJeF/otlJ9OIAR6qpwsK+A3yHjwRGE4Pq927j8LZ5STyRuvQUIQQ1sFHNcG8iyD4sd6WIMbqhfPBjFFs//xAR5wyJPUvR0HdNZCrVVpQ4I0UZgfukWFvWuf5nnPsWhwYdMkvBVZWhTBozFwb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ov9UhAPw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ov9UhAPw"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 616E7ZLa003772;
	Fri, 6 Feb 2026 15:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VN3a+f
	3EbdwsFVnFJtw/oh2DvyqCtoqH2KNK+3Lms/Y=; b=Ov9UhAPwfHJmZRAYiJOXHg
	vJm0/v5AHgJZhWCpDAwilGjtV/OF7TQVBsPtLi9bvtgQIpKOgvf5zcjUO9mNiCXw
	fXf5iVHoKzDfmZHsdLzWrka8wJe5gjCav2adWU6EDSTQibaR400GyuqM1lyvPEzC
	EakVzqJMUhppe/CCaHRB6fckccNsDcHZn5Ls15ReQL7SPYMIxLgKEdbihV5NashV
	ABrUWQvgz/mKDZXmGIuPyMtZ6DJ7mL+7B71Q/hVsI3qc7JK3TjGfXicQJBep3Ttp
	rTJytTwWozfWWZ0zCL8dkUhkA6VIg8qm4e2NRm5osyt7yxDT7bdqs4FwDEDIqYqQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19f6v70a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 15:02:53 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 616F2r1X010536;
	Fri, 6 Feb 2026 15:02:53 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19f6v704-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 15:02:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 616CKfap025812;
	Fri, 6 Feb 2026 15:02:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c1w2n6j7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 15:02:51 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 616F2lHI43057508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Feb 2026 15:02:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8C3220043;
	Fri,  6 Feb 2026 15:02:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDE2820040;
	Fri,  6 Feb 2026 15:02:44 +0000 (GMT)
Received: from [9.111.140.182] (unknown [9.111.140.182])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Feb 2026 15:02:44 +0000 (GMT)
Message-ID: <4fb3f0d2-b916-409b-995a-7dd801df0d0f@linux.ibm.com>
Date: Fri, 6 Feb 2026 16:02:44 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/6] x86/vdso: VDSO updates and fixes for sframes
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org,
        Steven Rostedt <rostedt@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
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
        Vasily Gorbik <gor@linux.ibm.com>
References: <20260203171958.1522030-1-jremus@linux.ibm.com>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260203171958.1522030-1-jremus@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ImRbMbpGp5l1xVrd7tdKYdOl20Lnib8d
X-Authority-Analysis: v=2.4 cv=drTWylg4 c=1 sm=1 tr=0 ts=6986029e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=VnNF1IyMAAAA:8 a=LFt20mCCc4CE-LtB3JUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: qFD-z8fzc_fSt-HH-25cq6VUYJ4hYEP4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDEwNyBTYWx0ZWRfXzbSAzP7G5FI/
 /p9zU2HRdzAJhmGvyn6CvnGcBWwc3prPDDoX2kOP0OPJfO02QCPe3WoppPBQ6JvzwaUBZTQiw27
 CP/vgygFJvLEheudQNfgp+vESKWb/gD9pXW7X28uaNdV3whDEkXmWn0PUSi8dxSX53h1Y+7QXN/
 PFXQCPZg/DRCD/Lh7G/QLNfebf1Tg6taqnZCYM1zZ6OLxQMmn5ZD2n1dsr5pGErvM0BPMo5qDjO
 4iruCMqYw7C0VazRVB9X70chykQngDeAuNow21AkAG7icwvVOumt/tdy2JQ+a7LmpiOILqBg8ZV
 QKMzabmVvL8Igy0eeEpZu9nw13WyhfgqwChukwS7niT0zhwdhnv/Gmno75h+i41sKTAe7Aa5xSh
 yGXainupced8BFgMAlfs8iyiTbdUJQshciT/LigVWiZQ7B5Iu7kyYnBUTCA4D/YJBW51DkxML4u
 7j/RUp1cEDMV8F7zApQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_04,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602060107

On 2/3/2026 6:19 PM, Jens Remus wrote:
> This enables generation of SFrame V3 stack trace information for VDSO on
> x86-64.  It's a continuation of Josh's and Steve's work:
> 
>    https://lore.kernel.org/all/cover.1737511963.git.jpoimboe@kernel.org/
>    https://lore.kernel.org/all/20250422183439.895236512@goodmis.org/

Above is the link to Steven's v5 of the series on which I based my v6:
https://lore.kernel.org/all/20260129112726.892340-1-jremus@linux.ibm.com/

I just realized that Steven's latest version actually was v6:
https://lore.kernel.org/all/20250425023750.669174660@goodmis.org/

That is why I also messed up the series' versioning and erroneously sent
mine as v6 as well.  Sorry for that!

I'll incorporate all of the missing original v6 changes and review
feedback into v8.  Following is an excerpt from the range-diff between
Steven's v6 and my v6 showing the only missing change in commit subject
of patch 3:

3:  6ce4adda138b ! 3:  9b59e14424b0 x86/asm: Use CFI_* macros in SYM_FUNC_* macros so they can be added to VDSO
    @@ Metadata
     Author: Josh Poimboeuf <jpoimboe@kernel.org>

      ## Commit message ##
    -    x86/asm: Use CFI_* macros in SYM_FUNC_* macros so they can be added to VDSO
    +    x86/asm: Simplify VDSO DWARF generation

         Add CFI_STARTPROC and CFI_ENDPROC annotations to the SYM_FUNC_* macros
         so the VDSO asm functions don't need to add them manually.  Note this
         only affects VDSO, the CFI_* macros are empty for the kernel proper.

    +    [ Jens Remus: Reword commit subject and message as suggested by Josh. ]
    +
         Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
    -    [ Fixed rebased issues. ]
         Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
    +    Signed-off-by: Jens Remus <jremus@linux.ibm.com>

      ## arch/x86/entry/vdso/vdso-layout.lds.S ##
     @@

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C042DCF57;
	Tue,  5 May 2026 14:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777991164; cv=none; b=C/DmbEPrrY/5iW3PXaxEJj7GBR8LiBiFmmspCQYHFsaUPgg6Ieu6le/3rLVmmID5R9lSBSggGxvDOJTOeHCUuKTC46trhSjRI/yAo+wh1lh/E19OzTJF0uRREsDkfqx7oriF/QmrxMKAxBi3PNz/g64k6r8aswv7mpJ00YpEY20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777991164; c=relaxed/simple;
	bh=dVMLlvpIsPqrrJ5OGyjATjQGXN8IXebHgRZ82n1YKqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B09iPv0OF2VTk/I4MTQ45UBIiOUXqfPrFA/h5AQhkRDbiN06kY1VrsX1LektYEBEgMoSlMahlJMhBIGM7JegIM7PIqdYQylS9K6CBAHMHcMrLr4o9em4kg+6Jx3+CkhXWPT4RdjF2nGcwcDhb7hpSsyZUWm8+tCzR+ZQ2HM+6Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kCK8AOLU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kCK8AOLU"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6458GFvT3351555;
	Tue, 5 May 2026 14:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OcbaiP
	rXeZHYc5M9HkIsXuvWd1b75GWDcR6c1FbMbYw=; b=kCK8AOLUroh6Op3oeyQ3tA
	kzVZqVy8brV9VXXxeWMe1xe0uegxlWAP7GlX8ovDne5GCGOJ6mN9A3M0+tQFZE20
	UTAuXEd/hKZHIZs8OG43OgomII2KZKukRUZem/GJs0sfy9YuMQpVUokP8VRGp6vL
	JYE+nxrBRCmpjDntN+grlI7ctrouR/3JLVJDZB5W5tbJlHV+UI8bCPaHaeHLc8UF
	TydQHg1610Pfo5WZB90/4C/nUKCa8SmXcog7SJZ71loAJvqR88Kk6S/w+8lgjgWF
	u2G30tRfEWu8a/MYl7AjhmB16dpF+9ri5gKb0s98DPHx1vLFSdz/DlD+IgM1lFng
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6bs5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 14:25:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 645EOgrs014230;
	Tue, 5 May 2026 14:25:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwukqa509-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 14:25:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 645EP1Rl29229442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 May 2026 14:25:01 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2A3F20043;
	Tue,  5 May 2026 14:25:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C4A020040;
	Tue,  5 May 2026 14:25:01 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 May 2026 14:25:00 +0000 (GMT)
Message-ID: <d272218d-214d-4a13-8f45-dacd3e94f5dd@linux.ibm.com>
Date: Tue, 5 May 2026 16:25:00 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/6] x86/vdso: VDSO updates and fixes for sframes
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        x86@kernel.org, Steven Rostedt <rostedt@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Indu Bhagat <ibhagatgnu@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dylan Hatch <dylanbhatch@google.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Kees Cook <kees@kernel.org>, Sam James <sam@gentoo.org>,
        Andy Lutomirski <luto@kernel.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org,
        Namhyung Kim <namhyung@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Carlos O'Donell" <codonell@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
References: <20260505123340.3770025-1-jremus@linux.ibm.com>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260505123340.3770025-1-jremus@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69f9fdc2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=VnNF1IyMAAAA:8 a=0MvmVg10__VCTnNSAJcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: OcluZmLD_x4gMqANWuezmnnGoe4w0tND
X-Proofpoint-GUID: li-2q0iBa1957f3jFzff7LHFnhy2TzmZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDEzNSBTYWx0ZWRfX6Qsc9D8QpNTK
 eVoHxsAXC1MYjkQwzPmUOAQB7ApXGRsFCVGUrUanv9+LtbWXKa8Xs78P+2QBoI1CTlDqq09Gjiz
 oZqcKyVJKtik+oZty+qxqmlj+kMooiyKvLBq+InO1eejVaKGNq7kmyFxN9lSCSsQFrc4dF6RmJM
 ZLddMM8FdmtlaVClPXWPZuFaMqChGvOV0aqCZrB3eWqdvV5q2SYrpm8lyfm+5j0TDhgpvk3sbNX
 W+Zddmf5VVe4Er1Znp8kaceVNpCH5C7lv68OsKF5h8pavFM3mfEi/7YBtcAQ5KrdgqDI5bKQGI/
 RdeauxQ6L2iNSOEYrMkYy6yNVNn4IJ0vz31CtwDVxm+EgcCNB/XWFsrg/UBVQjH9UYxM5/6ryUe
 7QymP34wcEkCc59eKn2qNka3xSO9ODNF2Ucp6Oi5iOXR0b5fDcoAFRink0RblFi82cdTiW7a9Ys
 no2tKJkXF/og3584JYA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050135

On 5/5/2026 2:33 PM, Jens Remus wrote:
> This enables generation of SFrame V3 stack trace information for VDSO on
> x86-64.  It's a continuation of Josh's and Steve's work:
> 
>    https://lore.kernel.org/all/cover.1737511963.git.jpoimboe@kernel.org/
>    https://lore.kernel.org/all/20250425023750.669174660@goodmis.org/
> 
> This series focuses only on the VDSO code. They are helpful fixes
> and updates that doesn't rely on sframes (although the last patch
> is sframe related).
> 
> This series applies on top of tip:master (a375022d6383):
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
> 
> Like the unwind user sframe series [1] it depends on the binutils 2.46
> release to be used to build the VDSO with SFrame V3 stack trace
> information (using the assembler option --gsframe-3).
> 
> [1]: [PATCH v14 00/19] unwind_deferred: Implement sframe handling,
>     https://lore.kernel.org/all/20260505121718.3572346-1-jremus@linux.ibm.com/
> 
> Changes in v10:
> - Rebased on tip:master (a375022d6383).
Apologies for the incorrect series version in the cover letter.

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/


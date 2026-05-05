Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2706266B46;
	Tue,  5 May 2026 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777983974; cv=none; b=dVrJ/4Ab6PCQd5fNgg3P/JKyw2x8dtAjy/Wb+jiN6Ce66a3M+/XfHOVA+UI8lcmWvAVdgH7CGSm35ear4oKaJSpm5zbNxre8kvSSzDmEuBzsPYIRmfrEMdm9nZPsabaIuF8bnm1jXwTtWVK3Fs+v6s81gSS5KWi4b/aYx2Kw+0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777983974; c=relaxed/simple;
	bh=SSzGheLxfH63C+BPoHDfVIFzYV3ZF/EWijsBQAasu28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qPrQb/19svLf7yNAjurC8/FrgNPVT3AQ2WPmq8x/1rTQfmnevhZ2Fem3Hcr/q7tNqmZCG3gmuVmOboHuA2ohHaqDhEkNdCH3ezhsJ1nou/O3sREria8j7MAErbSkz/Hz63+mKyloa9lOYWoK6fELIs8TgoJLrlXmSEr43F4nXbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GIM2vmV+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GIM2vmV+"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6458GFjI3351555;
	Tue, 5 May 2026 12:25:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iCOWk4
	XOOb4vtcraw1379WOq3zAGck0wfj3WDT9TNJQ=; b=GIM2vmV+9wx6cP+IduZG3B
	TI0bMI/1ja4/d9+QjEs9nzDQtIqhrhiRMix7vC5oJEucMH1Z6RHEQi36+sgtLfiY
	iTTHnFwL8PrBQk9WWK/Rj6DELX36l2id3xcsK3XbmubmyCRKZQfztt/FhY6Ochhv
	jbRnckLaHYXJu3kv9JrMHWIkcm5wi4DRx3UnShZ643ThGZguxNZfFZEDFemb1/Ag
	/PoN9kgG5biOexWa5iQari9tI7faj58NCwCl9+KcvTXHC+WWJ1QmobcsrJ+y2Uol
	CgrDUyisrCeHvUZBHImiQRW4peWLd2zv1JX9/8xsNU2pB/LVvHLZd6WYJqhleMNA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6b8cg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 12:25:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 645COPCC016264;
	Tue, 5 May 2026 12:25:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkjsgwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 12:25:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 645CPeWe49545694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 May 2026 12:25:40 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A12B42004D;
	Tue,  5 May 2026 12:25:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 020592004E;
	Tue,  5 May 2026 12:25:40 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 May 2026 12:25:39 +0000 (GMT)
Message-ID: <6eb9cbb6-c997-49ee-97a6-66a721073846@linux.ibm.com>
Date: Tue, 5 May 2026 14:25:39 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 00/19] unwind_deferred: Implement sframe handling
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
        Kees Cook <kees@kernel.org>, Sam James <sam@gentoo.org>
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
References: <20260505121718.3572346-1-jremus@linux.ibm.com>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260505121718.3572346-1-jremus@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69f9e1c9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=lNt1pmmDVPWPLV_8P3QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: PLhVfBiZn-aSt5WckmzZBbYhLO1gOr68
X-Proofpoint-GUID: ybGT5PYqAhNLFmbquT73cbhc8mA2NIVX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDExNCBTYWx0ZWRfX4WxFhGafDnwu
 h4Uo06QecP4Z+vTG+IBqEHK5gaPO6wxJxl9Xj3y/JBtxdsWpyGnyFFBxbKKoXMRx0aBFnzT0fJ+
 qkv+m8GgjVrSCFRe1VR26p5tq3ifVWviMJmFQ70DVSLUr4OILE9VSOybjGa2u76pBb6+4wnLBHN
 9LMzeJ13JPvZmu6Bqieop9zrVlm7hAV4jNqEUTdM6Zbx1UkfjLo3m2ZR87T+L+kM7oHML4EnfCS
 DRH6KcksTuS8yfL3/sXkVP8UnNXurhrYUK1pVWKyahQQQrJPL5lnBIHMNq8cyum5XYYVFxpP3Vb
 hKX8V8cpgTm/cqtriKD4P/FZp/uWa9+7d1ZE7AO8b1JIkaqqXg/Cpm6Stnmyzr/YugH0hAk6l0f
 Vk8cUNNr24eRLvwuAHY+vf+Y/JeEUjYBxDvzXGcRmc7oQ8YdpP4hFApjPJEEv0tZP0kiKBfk1Pa
 R0bLN4WHhLyjB+DpeDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050114

On 5/5/2026 2:16 PM, Jens Remus wrote:
> This is the implementation of parsing the SFrame V3 stack trace information
> from an .sframe section in an ELF file.  It's a continuation of Josh's and
> Steve's work that can be found here:
> 
>    https://lore.kernel.org/all/cover.1737511963.git.jpoimboe@kernel.org/
>    https://lore.kernel.org/all/20250827201548.448472904@kernel.org/

I forgot to mention that Steven is working on a system call for dynamic
linkers to register .sframe for .text in dynamic libraries (DSOs), that
is supposed to replace the last test-patch of this series.  Feedback
on that is much appreciated as well:

[RFC][PATCH] unwind: Add stacktrace_setup system call
https://lore.kernel.org/all/20260429114355.6c712e6a@gandalf.local.home/

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/


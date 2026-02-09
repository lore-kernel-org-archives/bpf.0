Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6575937A496;
	Mon,  9 Feb 2026 17:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770656944; cv=none; b=GZifzR58HYlQmmU66nbrxILAOJQLG6y99AML7vXsNyOctudtuHXPx6WI5bDocqdIHML4hN42bBnSP4ma/m9il9s+eypxj4pDs28fOHGSjDl5ewBguiR4UMshIaqVDSf4GO0PwGJE4MPE5k6Z7SvGva/8RZ/q9wh2tuHqNbBWAN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770656944; c=relaxed/simple;
	bh=NWWjlOH7B83pojJkHPF6piAg0Lbl4e/7rtUPf576tcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oY8pkMYoLBRPGm/YnBMiRoWGSLe7MRaN1QjcShIPI8xqjXvLV1L1JKl0Ra6FXMHIydnWcm8YSHU8gWLQ2KWDA2W3gJU/wKmGUbt8623YVZEuYhe72WtCdFJRcrXGQdSICsuuc4nFoo1msj4ckY0987rlp6UJjhQpZoKjdM2DcaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cYSdSNGQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cYSdSNGQ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619GkPnV501539;
	Mon, 9 Feb 2026 17:08:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=V+SiWg
	duwxees+zomWnRSsdKtq4DlrLkGTFXFHvdFGk=; b=cYSdSNGQSnFMx3NRwDFmIz
	TvgrvbcYdQvO8LbcyVdkAjIKYmlTWgeRJrXrYetV96mnVqZEqwviN7JV2gMSxcWO
	9I5IeI0TRVCyALVlHFJWWP5b7pZA0ahRIJROr2v4c2IlRLr4jp5mfN5L735zL1Ef
	9JKUaxeYnwP5Ijor/LBj/HZD6uILhDYVdzoNbLu+Sz7gX24UTY5AlmVnCk0f3lgl
	nx/8HkuDboBycUJ1Gx7Sb6jlbSPbLalJQP2N7rdSB6avBeCrz8q0n536Xk85/Gg6
	q0S31jhvnIYdV5cfjH9Dbrzu3x6bgJXJc7aqa0kYSx79NwI7WfB+VcfGRj6ncUaA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696w0buq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 17:08:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 619DWTH9001499;
	Mon, 9 Feb 2026 17:08:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6gqmx29g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 17:08:06 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 619H82Zo25494140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Feb 2026 17:08:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFE6420043;
	Mon,  9 Feb 2026 17:08:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6553820040;
	Mon,  9 Feb 2026 17:08:00 +0000 (GMT)
Received: from [9.111.207.126] (unknown [9.111.207.126])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Feb 2026 17:08:00 +0000 (GMT)
Message-ID: <113e4e4d-8b7a-437d-a3a2-de74acc9ecaa@linux.ibm.com>
Date: Mon, 9 Feb 2026 18:07:59 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 00/18] unwind_deferred: Implement sframe handling
To: Steven Rostedt <rostedt@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Masami Hiramatsu
 <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
        David Hildenbrand <david@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20260127150554.2760964-1-jremus@linux.ibm.com>
 <aYTgwoyRl8kxQShT@google.com> <20260205135411.5fb22df2@gandalf.local.home>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260205135411.5fb22df2@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=YeCwJgRf c=1 sm=1 tr=0 ts=698a1478 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=1wei54M0JlXa_cUNk-YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 6pOW16P1XhSQuI3JJirwxxHhVPPpl8Nt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE0MSBTYWx0ZWRfXyPk1TShJpjFg
 TRcEnZRgpTGTU6Gwj8TdWCJ3KO4QSZO01sZ3yCvl8pqdm3wyIxLYmUiMdtdy9p5YWSW34PwFfr/
 cVKshdKgZpu3sjpoF2+UHdlwdcIZSEY4bs8UZ2FTjswVBBikq+mvJXupgPi1dsdSrWm9tq469eN
 xvgsN3MRJwzWfd5lfkZeeMK+GQOg/m/FBIH4MewmaEcyFuFZ61fOCWMEuS9WXxnTqodYhRNncZ7
 WGmjiBiLu+dU4WiSl1nbTbo2YN4ZGuGWOCFVaXs+lkpEnuUo8tKKqyrHhgrhoiQBrynMFL7Ib1J
 ubA2JtF+UH6CwKeCbWUUWI2rXFa4c+ceaNJZV8h71qWMrHPtoz+mXQGj/FVDbszn2KIjdJW46Qd
 is5TOuqlE1/xaTnbuM7vcqNMwQLKP8AIdXZJw6r7GDoogA6eSKJ9Wok0CL4HdZXC96l7zkjdtR/
 Ih8Qs7LVYW1HAnzx2qQ==
X-Proofpoint-ORIG-GUID: O1UEHkJ3Y0btRd8FNQdSrr18n7ct04xA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602090141

On 2/5/2026 7:54 PM, Steven Rostedt wrote:
> On Thu, 5 Feb 2026 10:26:10 -0800
> Namhyung Kim <namhyung@kernel.org> wrote:
> 
>>> Namhyung Kim's related perf tools deferred callchain support can be used
>>> for testing ("perf record --call-graph fp,defer" and "perf report/script").  
>>
>> Is it possible for users to choose the unwinder - frame pointer or
>> SFrame at runtime?  I feel like the option should be
>> "--call-graph sframe,defer" or just "--call-graph sframe" if it always
>> uses deferred unwinding.
> 
> Currently no, and I'm not sure we want that do we? The idea is to use the
> best option that is available. Why use frame pointers if sframe is
> available and it's being called with defer?
> 
> If there's no defer, then sframes are not available, so it defaults to the
> best option available (which will likely be frame pointers).

Maybe it would make sense not to "overload" the perf record option
"--call-graph fp,defer" and use it for all deferred unwinding methods.

What about "--call-graph defer", "--call-graph any,defer", or
"--call-graph *,defer"?

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/


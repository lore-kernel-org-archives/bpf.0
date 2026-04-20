Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BE929A9E9;
	Mon, 20 Apr 2026 12:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776688609; cv=none; b=o9CCCxpWjqpdEIGHJp71MejK5xvGbMQjiec/ww7d9xAeaWyHE7CDPNrD7bHaD0xJ6EBcsAXf4MjNQm9jcrT+Lr5htqel8ikp8msLib7e/C5vUtaWsGmcDs49peuT8VyUk2aPnN7TNo8Jnk0T/UeJqB8t+rSozWEZDe9yJDTzgos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776688609; c=relaxed/simple;
	bh=0cf+45GINUGOImVFWN83LA1Mu26YMmVq2U3kUFyXOCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m7sF1HZ4Ecof3XDdaEmBk+Dy6a2w6waUWqfP6R6Xdfxzghl+EXQbB/FZtqUHGnne+Ip4lkXcqmLAwSHg+Q0Z/fnAs2lZQj3pzFnHuUjIQPC6XI2mmjMbf9GeV3fg1HUGqMMrbhoKEFL8/4/nNGhUbRk2QN+uDYJ/vA3aPKQ0SjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Cv6/mwSo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Cv6/mwSo"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JMqb1a3300702;
	Mon, 20 Apr 2026 12:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aCNrzI
	TNVxl4yTUtKDFANgAVBHA4yTO8UXj6JrWcXYM=; b=Cv6/mwSo4DJXeV5lnGAdOQ
	s2aNOOnXrBmvJlazNEKls0qSiMpS30NO4vGuxCWKikVlrU4Sb8xZrEwkECWcTO1/
	5KZlJhCCMbPgw5xpos347+Mkz9msF6SOtszSVIO/cK++mioCh+IErqYW18Qt2+kU
	vPFHN/saqkt0LcntqEgVW9d0Fs6W7Y4AAEo8Vl0J9sJ1Rtqzn6Zg5PMXIIS987oU
	QGOMfx+xtGUlgQ0V57CkNzKOOJE23eqYT2FTUl0lD7fJVJbAs/OlJTACQuwkKebx
	4W9tuRwRPAD2zXkpPBUkk4WCtqAo4q/hp1Bzxu4F1aQST6IKHIo9mSzRiNYMwp5A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2k4yr9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 12:35:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63KCZYP2015012;
	Mon, 20 Apr 2026 12:35:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmpgg4k70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 12:35:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63KCZj5M18219320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 12:35:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 044892004D;
	Mon, 20 Apr 2026 12:35:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58B4220040;
	Mon, 20 Apr 2026 12:35:43 +0000 (GMT)
Received: from [9.111.165.155] (unknown [9.111.165.155])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Apr 2026 12:35:43 +0000 (GMT)
Message-ID: <898449ac-f7eb-4d52-a4e6-ff356fcba6c5@linux.ibm.com>
Date: Mon, 20 Apr 2026 14:35:42 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 17/18] unwind_user/sframe/x86: Enable sframe unwinding
 on x86
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org,
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
        David Hildenbrand <david@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
References: <20260127150554.2760964-1-jremus@linux.ibm.com>
 <20260127150554.2760964-18-jremus@linux.ibm.com>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260127150554.2760964-18-jremus@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: h3AoDj-44Wmt0hRRhlhEyQIgXzwjY-6V
X-Proofpoint-ORIG-GUID: MG0BEFiON0tlFDeZyKyNDhb7WjUzOo-N
X-Authority-Analysis: v=2.4 cv=VP7tWdPX c=1 sm=1 tr=0 ts=69e61da6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=0MvmVg10__VCTnNSAJcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEyMSBTYWx0ZWRfX8/lw1wSomI2y
 lYC/8lq7Cy/Svc0dtCcdW472D061uFnbuNoa/VGW3T9O6YaynasdmU+Q3BEZ9OAGr9MpeyHd51m
 Pdk19TK/gCT9lYFLfkA6QvhkEZqrsmN8Xjcs1RMYLmLi/v7+ZBKN1Qai3qh+7kO4LFMBn2YqUnh
 aWHiYtPLP5GUvv0BryA+d+esOkhIMMSLWXVWgpi6SAQ5Y5x7m7C/QCX+CC1yNi0WIITN8/j50Tr
 1P0SC2FqvLWHjht4FX/dHzpQgyOEnqgW8ngaS5qpHnuF8ltWklHRWd/JQP4S5XYrdutFDqCNajR
 JA1iRSu3Ax43sZ1tVl1TF7PwkDIMlwTFy/1BXxBXoff3VzrlVYRCB8+Rk/TnVESvtR76utaCtAR
 2og6LL6euZqswjLM8xhfi4x01dibDabTTkyCCcGqrPNr1Tgo8s5uDSxCwOXVyBkjc2ESjbXiTFz
 Eihaj9aWs4OyRFvkWDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200121

On 1/27/2026 4:05 PM, Jens Remus wrote:

> diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h

> @@ -15,6 +15,40 @@ static inline int unwind_user_word_size(struct pt_regs *regs)
>  	return user_64bit_mode(regs) ? 8 : 4;
>  }
>  
> +static inline int unwind_user_get_reg(unsigned long *val, unsigned int regnum)
> +{
> +#ifdef CONFIG_X86_64
> +	const struct pt_regs *regs = task_pt_regs(current);
> +
> +	switch (regnum) {
> +	/* DWARF register numbers 0..15 */
> +	case  0: *val = regs->ax; break;
> +	case  1: *val = regs->dx; break;
> +	case  2: *val = regs->cx; break;
> +	case  3: *val = regs->bx; break;
> +	case  4: *val = regs->si; break;
> +	case  5: *val = regs->di; break;
> +	case  6: *val = regs->bp; break;
> +	case  7: *val = regs->sp; break;
> +	case  8: *val = regs->r8; break;
> +	case  9: *val = regs->r9; break;
> +	case 10: *val = regs->r10; break;
> +	case 11: *val = regs->r11; break;
> +	case 12: *val = regs->r12; break;
> +	case 13: *val = regs->r13; break;
> +	case 14: *val = regs->r14; break;
> +	case 15: *val = regs->r15; break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +#else /* !CONFIG_X86_64 */
> +	return -EINVAL;
> +#endif /* !CONFIG_X86_64 */
> +

Nit: Superfluous empty line.

> +}
> +#define unwind_user_get_reg unwind_user_get_reg
> +
>  #endif /* CONFIG_UNWIND_USER */
>  
>  #ifdef CONFIG_HAVE_UNWIND_USER_FP
Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/


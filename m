Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C947A47F2E4;
	Wed,  6 May 2026 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076627; cv=none; b=oHRkud8PttIb6P0UuOeNi6DmeUz4+rEwGfymkPoDI0p39HblQ1JIYJT/ZMSs/z4kOhU4HGLC1vaaJ4KvIK7dAbCIMUjftlhdE0UWgDG/31P7KovUH6jBYRl3tYPbFZfWrtQdeCG7VQPEfBoNQPCUI+e0erR7dkZ1oxymf0uFlc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076627; c=relaxed/simple;
	bh=QxVHOTHq7/y/TLjFK3dUJHgk/hwID4GguAfQmdZF2Ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Co0Md5DvpZftH7Ir5ENV1SOrHyAzTjEaJ93roX2IhIzvIBBDdso+sldxN/GJn2BzFrK6DfxA4g9u5jKza1FY4dBe24ShReShvHyTCbQAT5C2MH3qAbz/p9wznJskEWrhCWPwQeb5jLVg5e1iyZEkd785oEBXMsL5iHKIv9hJthg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A4PcQv80; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A4PcQv80"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64603Hqv067384;
	Wed, 6 May 2026 14:09:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JF0B3P
	exmDAtg/xwB4TCMJRjL/G29AeOJJCuvLBN0CA=; b=A4PcQv80Y6uXsYnj/xcjKv
	lhPmppnvmjqg8UNaKnJiZAooW6REJg5TTT94G0vCbZlKc4xAh+l9H3u5WbDjM0WL
	H6H/Pa6zPcZexVH2AKwgsNzNntr5PsLvEfFmju16Y5BeGUVwTJYw4rTgvcmOvWvA
	z3B+zvl2B/UrUc0cCNDr2Em5mHkZdvzC0EVcozoADoyrm7P0FefaTHHZmf36eYEw
	thCXbUuf/nosZPcgg045QagkC25xNqShMXBbF50hcQa92S19k1epTrzVW9D87mW/
	yVmob9GOeXEh1dDf4w4KydfYZH91KqkychHBoem45zF7ZYAmHPXD2XXx+B5dLL2g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1h24p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 14:09:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646DsPQL022750;
	Wed, 6 May 2026 14:09:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtgebp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 14:09:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 646E9HGe45416810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 14:09:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C63B42004B;
	Wed,  6 May 2026 14:09:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1546820040;
	Wed,  6 May 2026 14:09:17 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 May 2026 14:09:17 +0000 (GMT)
Message-ID: <9f85f092-c376-4350-9a12-479d7b70399a@linux.ibm.com>
Date: Wed, 6 May 2026 16:09:16 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 04/19] x86/uaccess: Add unsafe_copy_from_user()
 implementation
To: Steven Rostedt <rostedt@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        x86@kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org,
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
        Ilya Leoshkevich <iii@linux.ibm.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Indu Bhagat <ibhagatgnu@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dylan Hatch <dylanbhatch@google.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Kees Cook <kees@kernel.org>, Sam James <sam@gentoo.org>
References: <20260505121718.3572346-1-jremus@linux.ibm.com>
 <20260505121718.3572346-5-jremus@linux.ibm.com>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260505121718.3572346-5-jremus@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 2IiCT--Vp-RQVdUGSeMKj3NgFgjYnGxT
X-Proofpoint-GUID: KIizt9F92xnbY-nhRloRCta2VU3AXvFV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEzOSBTYWx0ZWRfX9/D4gt9JjNe3
 1dGTBSo20Nns4lWNkY2R57YNEBhiw6CjJFOYeKzOR9Auu8huq6ARaFbnF47vfs0iqzUPW0gQX3g
 Gk41rjmpwgzcz249VYsMTvez/E8WZQYBZY1oH3thtWHPZ97uWr18xWwOD8FHwgsCOPM6ysBPTlX
 cpL1ZL3m6lxsNe3O1IZ5qRcKdZwj7plK/csqi8Re91a4zGvn10HTOd8S71AZu/ipZjT4xPjqkWu
 f2AxY/01ggJqg/drUjJZxHCVfM1csDHt9KekdvSqv+xhOh/mtOzkF4P0S5XjhnXyQ9XbjHSUZcv
 7+ZHoSzHJED1lCNCurZ2wA2Yt4ZNRuqVCSxa1uWf/PhP3uLF2I9/QuRIUYLkTNgp9ddF4o9rNcp
 cpkEn9w4R6MMVSZWxLaMfCySy3maOK7BsokLWqbFVmrxKkBmW+om+0qSPpiN+JA1ilkuA2lomMF
 1KA7rirk8Kz+7jNbuJA==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69fb4b93 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=LFt20mCCc4CE-LtB3JUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060139

On 5/5/2026 2:17 PM, Jens Remus wrote:
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> Add an x86 implementation of unsafe_copy_from_user() similar to the
> existing unsafe_copy_to_user().

> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h

> -#define unsafe_copy_to_user(_dst,_src,_len,label)			\
> -do {									\
> -	char __user *__ucu_dst = (_dst);				\
> -	const char *__ucu_src = (_src);					\
> -	size_t __ucu_len = (_len);					\
> -	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u64, label);	\
> -	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u32, label);	\
> -	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u16, label);	\
> -	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
> +#define unsafe_copy_to_user(_dst, _src, _len, label)				\
> +do {										\
> +	void __user *__dst = (_dst);						\
> +	const void *__src = (_src);						\
> +	size_t __len = (_len);							\
> +	unsafe_copy_to_user_loop(__dst, __src, __len, u64, label);		\
> +	unsafe_copy_to_user_loop(__dst, __src, __len, u32, label);		\
> +	unsafe_copy_to_user_loop(__dst, __src, __len, u16, label);		\
> +	unsafe_copy_to_user_loop(__dst, __src, __len, u8,  label);		\
> +} while (0)
> +
> +#define unsafe_copy_from_user_loop(dst, src, len, type, label)			\
> +	while (len >= sizeof(type)) {						\
> +		unsafe_get_user(*(type *)(dst), (type __user *)(src), label);	\
> +		dst += sizeof(type);						\
> +		src += sizeof(type);						\
> +		len -= sizeof(type);						\
> +	}
> +
> +#define unsafe_copy_from_user(_dst, _src, _len, label)				\
> +do {										\
> +	void *__dst = (_dst);							\
> +	void __user *__src = (_src);						\

	const void __user *__src = (_src);					\

This was suggested by Sashiko AI review.  Any objections?

> +	size_t __len = (_len);							\
> +	unsafe_copy_from_user_loop(__dst, __src, __len, u64, label);		\
> +	unsafe_copy_from_user_loop(__dst, __src, __len, u32, label);		\
> +	unsafe_copy_from_user_loop(__dst, __src, __len, u16, label);		\
> +	unsafe_copy_from_user_loop(__dst, __src, __len, u8,  label);		\
>  } while (0)
>  
>  #ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT

Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/


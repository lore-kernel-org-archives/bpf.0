Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4700C39446D;
	Tue, 21 Apr 2026 08:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776760129; cv=none; b=APTk4dhRcSn+g44bSZpnqWr3tgqRWSQ+JCqnASg/Eqklgm8+GoraWxsD1YIZUjESYBXQHPdiNIYZBoGYKHaDKuVIImMgdXfbYa3kdA5jOp4AHPNzUA9JDmpS+Xx1elgeH+ZXYy1BXD5d6lAHGR8WHeXy2ab1IpX79+917jWCXN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776760129; c=relaxed/simple;
	bh=0kkbFYs28tq82k7Xb8Kxwalq0Tlu7xnGoxTLb0ZTNeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e6pdi9H2342ossCkvbIumzqXb/SEhBn3zG9Vu0gwEa99xXIiaCIAk74X6kRtkcViPzvQz8Q+75DvFB97y6vOPC/xQXDK0IlgzLPkl7pltgob3tNeDz086bFf17uOsEIMyyQ4VLfwEMYxSQIE0+xARNCsRNcmwglgB4DphjnNgPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b/enU9GW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b/enU9GW"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63KJgnN12037786;
	Tue, 21 Apr 2026 08:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=S37y6H
	E7oOJ4CNhNQJ8fCZpfyA4jum10NN4frBS0PCM=; b=b/enU9GW2mN3NHfq5I40+J
	yH8Jqw9uJBlV4dTdBU7tcEgO6iup7Q3QE5YY5sfaI+A0j/ASnR45eDJoFDHyoiVJ
	CjZajRXWfCd4u5PBKOn1zW/Sl+MbEG1ilAOecqGYpk08gK4DoTblfrFWCitxmyUL
	Bs9sP1rN6/dFGzbTuXiN3A1W42+bWiH6qlwEt9ranzl6TdIDloWUM+kds60UTEli
	jAim5bX5ak2cxyJpvGJKEkz/yBQQUVSxf0cQuvcHOLD1zk5sXpFbISeBlNRSuAeC
	wOuUTrIqZqYGhtEenYDt4nMdQRBvs9T3yqcnIbcG4rXcPAnVHZGLgxzASX8QYhvQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2h9jnv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 08:27:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63L8KFKo008086;
	Tue, 21 Apr 2026 08:27:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmn9jyxwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 08:27:52 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63L8Rl2p12255652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 08:27:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A135C20043;
	Tue, 21 Apr 2026 08:27:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F358F20040;
	Tue, 21 Apr 2026 08:27:45 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 08:27:45 +0000 (GMT)
Message-ID: <9115d2bc-781b-4e5f-9772-c0ebeecac91b@linux.ibm.com>
Date: Tue, 21 Apr 2026 10:27:45 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 04/18] unwind_user/sframe: Add support for reading
 .sframe contents
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
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Indu Bhagat <ibhagatgnu@gmail.com>
References: <20260127150554.2760964-1-jremus@linux.ibm.com>
 <20260127150554.2760964-5-jremus@linux.ibm.com>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260127150554.2760964-5-jremus@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 1goWuCKfC-7KiyC8K84-VTn1qdBVnTzk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDA4MCBTYWx0ZWRfXx0veQ28IaQW6
 fPpGKE4AGs52FLXRq6Os3Xi7WV4PA62uhAW5W5FYHNjTyGzvxoBYcO+upsEji4XkUq45iwHMnPa
 5uXe82pmmIHwh8j+XiOtB3QJgqbgEAJ3/nZGi3mxK1KJ8xn//G3zAIbnMl7vegYyhLS6kqtnFKl
 UU2LTeYDnNT9Ug9l0P9gDNLYsSWZdKb/n/eZpr/dZGX/UWb9W7Iw7+6d+M3hOlEbUTgFoPPTf/2
 FrAHbNm5p95qGcAThxOl52GrNE+iDowxuLDF6IRTKCHY2sv+z/Zumc5muCysXEGiyY2cVHjB199
 jr78obbMbd8xZJFoIlqxqqucb3hiNVm6TM/4K4Nc3rhgwrnMGBZ8FwBTnptCyruvZ4upXzRvruZ
 kztMNtG3p4Wrl882vpsH1sm+AsvYQMTYbE4Y8O0wTJn8ajhxRFAYSvMhcqqUW+7D4yplyA5jpbq
 mezHHgL1OpRdsRhZwTA==
X-Authority-Analysis: v=2.4 cv=XLYAjwhE c=1 sm=1 tr=0 ts=69e7350a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=rIsWgEjAf_fsY0NmbdQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: GDOmWqtYOiKgBotIL32-m-aTBWQC6JcH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_01,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210080

On 1/27/2026 4:05 PM, Jens Remus wrote:
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> In preparation for using sframe to unwind user space stacks, add an
> sframe_find() interface for finding the sframe information associated
> with a given text address.
> 
> For performance, use user_read_access_begin() and the corresponding
> unsafe_*() accessors.  Note that use of pr_debug() in uaccess-enabled
> regions would break noinstr validation, so there aren't any debug
> messages yet.  That will be added in a subsequent commit.
> 
> Link: https://lore.kernel.org/all/77c0d1ec143bf2a53d66c4ecb190e7e0a576fbfd.1737511963.git.jpoimboe@kernel.org/
> Link: https://lore.kernel.org/all/b35ca3a3-8de5-4d32-8d30-d4e562f6b0de@linux.ibm.com/
> 
> [ Jens Remus: Add initial support for SFrame V3 (limited to regular
> FDEs).  Add support for PC-relative FDE function start offset.  Simplify
> logic by using an internal FDE representation.  Rename struct sframe_fre
> to sframe_fre_internal to align with struct sframe_fde_internal.
> Cleanup includes.  Fix checkpatch errors "spaces required around that
> ':'". ]

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c

> +static __always_inline int __read_fde(struct sframe_section *sec,
> +				      unsigned int fde_num,
> +				      struct sframe_fde_internal *fde)
> +{
> +	unsigned long fde_addr, fda_addr, func_addr;
> +	struct sframe_fde_v3 _fde;
> +	struct sframe_fda_v3 _fda;
> +
> +	fde_addr = sec->fdes_start + (fde_num * sizeof(struct sframe_fde_v3));
> +	unsafe_copy_from_user(&_fde, (void __user *)fde_addr,
> +			      sizeof(struct sframe_fde_v3), Efault);
> +
> +	func_addr = fde_addr + _fde.func_start_off;
> +	if (func_addr < sec->text_start || func_addr > sec->text_end)

sec->text_end points after the last byte of the .text section.
Therefore the check for whether FDE function start address is within the
section must be:

	if (func_addr < sec->text_start || func_addr >= sec->text_end)

> +		return -EINVAL;

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/


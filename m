Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135F3313E2B;
	Fri,  8 May 2026 10:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778237460; cv=none; b=pCOpR7OjKSCxS0RJYQkqcDn8UmUoeohfC8kEDnJfKoAUK1+oauA4jYK7Z6WlqpNRg5llZH4RILSUOhyHJ4iZ2THUbwL8po0TuKAe31UYraOh62PraxU+zwTaghq/QiYsLAk0OrNqt2qkLdC4C/3oNeGic1M3uK4dObo0g+ZelnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778237460; c=relaxed/simple;
	bh=YFC8QwU/NhQYvNX+rX2DF+nP/wp/vjs7HVq+4jB6vP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gaMEkb6z6tTSXVTwYJHVchBy6c9CaBTSGw88GK2EmNbX60JOqidWYsWTxQuDOjwjHaWDhje4BPuMHFjqN+IDe0+0PJ1Ni4FhvpkX9BXuRVoi5zYcCJd2e2jSuH4PbjG25BUVT8vFjcTDH8WXrlMb3hOjOKZZbvReB2p8J5DBNjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gbU7u2kx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gbU7u2kx"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647MbqBO3351555;
	Fri, 8 May 2026 10:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4qyopV
	bNDsK1nvVk0S0OZZmFZASUZ2QQfuwkr1wO2k4=; b=gbU7u2kxFU7SE3WQlBX+x6
	Geq60OqOf2vJCnSKQhuZwiWbOZPqJ6M2pkRc9b4b+bNInIHDeIZOl5KyQCwSqQbx
	swAi1AlrZiP4e7pvIV7aOibJq3PGiFBjPlacjajY/UboeJA2tFQdqE51i9mnlqgl
	EbEB2HDDNxJ1q1n/medD/L8gZqavmJ2VbwfTSyfQjgFZ/E0Xqkzq8qphbzW+3Bs6
	CCb3payu31WyvbJWEp2ed40DzZwVSN3c5h63QeN7xLtX0E7TjOeZjbCoI5iG69EM
	rFjc7BT5R8NS4rz3KTx9mmyr+kaBrEuHo4wX6KNFXcP1SiyVRcXV83v8s2LePYwA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6t0sh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 10:50:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 648Addm6030050;
	Fri, 8 May 2026 10:50:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e10072vwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 10:50:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 648AoMKx49218034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 May 2026 10:50:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23FED2004E;
	Fri,  8 May 2026 10:50:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A20CB2004B;
	Fri,  8 May 2026 10:50:20 +0000 (GMT)
Received: from [9.111.207.158] (unknown [9.111.207.158])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 May 2026 10:50:20 +0000 (GMT)
Message-ID: <a420eb5d-06de-4600-8356-baa1dbf455f0@linux.ibm.com>
Date: Fri, 8 May 2026 12:50:19 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 05/19] unwind_user/sframe: Add support for reading
 .sframe contents
To: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Indu Bhagat <ibhagatgnu@gmail.com>,
        Dylan Hatch <dylanbhatch@google.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, x86@kernel.org,
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
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Kees Cook <kees@kernel.org>, Sam James <sam@gentoo.org>
References: <20260505121718.3572346-1-jremus@linux.ibm.com>
 <20260505121718.3572346-6-jremus@linux.ibm.com>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260505121718.3572346-6-jremus@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69fdbff3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=YuDcBBqGAAAA:8 a=f8iy6pEWjRDl6Rsn33oA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=V9_jqlfyBUA7Gw2gN5zN:22
X-Proofpoint-ORIG-GUID: cMxqurcr_z7KRrmEq6LDwDaloYuDU_hQ
X-Proofpoint-GUID: DVZllXSB0wfsGdZqR_3OWnuptH60tkEi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDExMCBTYWx0ZWRfX37YENEviiq0t
 bK7ypIgBvD4UujuUEIhlaw0h3qGO9xS/0tLcqxN50ASRgu+Wc9Y8nf0Cqck7yoSBl+fczXwAV+U
 0MI+Y3qiuoHotO+0aJDLhcefJy0AsbzdNIPzPjVcHZ60Nh3CP1PSzFJf57kHIarwKhSZsN+KXxO
 THyfzdSJ7pgkTtCm11UseFdbO+LRA6AAoi8P+K/CT9OSElfrjZWitpu88xoSdTuIgbdO+m81q20
 Ha7gb2J3P+bTjvx15wRmyaU3bRGPPQLgNPKyUQmc6avZg7dhs8bHCvKQ4dGuzsCJW69EVBN+s2t
 2eRwgz7sR+fJcjrsoxoH1ktMsAdDKeyCDNpZI9dMGJZaWU3yMhT+lraD3ir14gkiajvAffEjZSo
 4U5V1NsGZ65pSOmgI6TSuc0UDfURcT/2rnlcO00pUCpmpB0WJiwp+oxi71ckziH294JqA1g9ahR
 poSCTh0rQn1+dsHzCGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080110

On 5/5/2026 2:17 PM, Jens Remus wrote:
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

	unsigned long fde_addr, fda_addr, func_start, func_end;

> +	struct sframe_fde_v3 _fde;
> +	struct sframe_fda_v3 _fda;
> +
> +	fde_addr = sec->fdes_start + (fde_num * sizeof(struct sframe_fde_v3));
> +	unsafe_copy_from_user(&_fde, (void __user *)fde_addr,
> +			      sizeof(struct sframe_fde_v3), Efault);
> +
> +	func_addr = fde_addr + _fde.func_start_off;
> +	if (func_addr < sec->text_start || func_addr >= sec->text_end)
> +		return -EINVAL;

	func_start = fde_addr + _fde.func_start_off;
	func_end = func_start + _fde.func_size;
	if (func_start < sec->text_start || func_end > sec->text_end)
		return -EINVAL;

This would validate that the whole function described by the FDE is
within the text section and not only the function start.


Note that, unrelated to above change, this check in general causes
sframe_validate_section() to fail, if one sframe section covers more
than one text section (unrelated to whether it is actually registered
for multiple text sections), for instance in case of Dylan's sframe
kernel stacktracer on arm64.  Should the check therefore be made
conditional on whether __read_fde() is called from __find_fde() or
sframe_validate_section()?  Or shall we drop this check as it does not
provide that much benefit during normal stacktracing use:
- sframe_find() obtains the struct sframe_section *sec from the
  mm->sframe_mt based on IP.  So IP must be within sec->text_start and
  sec->text_end.
- __find_fde() only returns a FDE, if the IP is within
  [fde->func_addr, fde->func_addr + fde->func_size[.
Dropping the check would allow the function start/end to be outside the
text section.

> +
> +	fda_addr = sec->fres_start + _fde.fres_off;
> +	if (fda_addr + sizeof(struct sframe_fda_v3) > sec->fres_end)
> +		return -EINVAL;
> +	unsafe_copy_from_user(&_fda, (void __user *)fda_addr,
> +			      sizeof(struct sframe_fda_v3), Efault);

Can unsafe_copy_from_user() be used for unaligned fda_addr, at least
on x86-64, s390 64-bit, and amr64?


Do the FDE type, FDE PC type, and FRE type values need to be validated
here as well?

	unsigned char fde_type = SFRAME_V3_FDE_TYPE(_fda.info2);
	unsigned char fde_pctype = SFRAME_V3_FDE_PCTYPE(_fda.info);
	unsigned char fre_type = SFRAME_V3_FDE_FRE_TYPE(_fda.info);

The FDE type would get validatd by __read_fre_datawords(), which is
called after __read_fde(), if the read FDE is the one of interest.
So that does not neccessarily need to be checked here.  Do you agree?

The FDE PC type is currently not checked for supported values anywhere.
That one would make sense to be checked here:

	if (fde_pctype != SFRAME_FDE_PCTYPE_INC &&
	    fde_pctype != SFRAME_FDE_PCTYPE_MASK)
		return -EINVAL;

The FRE type would get validated by __read_fre(), which is called
somewhere down the line after __read_fde().  So that does not
neccesarily need to be checked here.   Do you agree?

> +
> +	fde->func_addr	= func_addr;

	fde->func_addr	= func_start;

> +	fde->func_size	= _fde.func_size;
> +	fde->fda_off	= _fde.fres_off;
> +	fde->fres_off	= _fde.fres_off + sizeof(struct sframe_fda_v3);
> +	fde->fres_num	= _fda.fres_num;
> +	fde->info	= _fda.info;
> +	fde->info2	= _fda.info2;
> +	fde->rep_size	= _fda.rep_size;
> +
> +	return 0;
> +
> +Efault:
> +	return -EFAULT;
> +}

> +static __always_inline int __read_fre(struct sframe_section *sec,
> +				      struct sframe_fde_internal *fde,
> +				      unsigned long fre_addr,
> +				      struct sframe_fre_internal *fre)
> +{
> +	unsigned char fde_type = SFRAME_V3_FDE_TYPE(fde->info2);
> +	unsigned char fde_pctype = SFRAME_V3_FDE_PCTYPE(fde->info);
> +	unsigned char fre_type = SFRAME_V3_FDE_FRE_TYPE(fde->info);
> +	unsigned char dataword_count, dataword_size;
> +	s32 cfa_off, ra_off, fp_off;
> +	unsigned long cur = fre_addr;
> +	unsigned char addr_size;
> +	u32 ip_off;
> +	u8 info;
> +
> +	addr_size = fre_type_to_size(fre_type);
> +	if (!addr_size)
> +		return -EFAULT;
> +
> +	if (fre_addr + addr_size + 1 > sec->fres_end)
> +		return -EFAULT;
> +
> +	UNSAFE_GET_USER_INC(ip_off, cur, addr_size, Efault);
> +	if (fde_pctype == SFRAME_FDE_PCTYPE_INC && ip_off > fde->func_size)

	if ((fde_pctype == SFRAME_FDE_PCTYPE_INC && ip_off >= fde->func_size) ||
	    (fde_pctype == SFRAME_FDE_PCTYPE_MASK && ip_off >= fde->rep_size))

For PCTYPE_INC the FRE IP offset must be less than the FDE function size.
For PCTYPE_MASK the FRE IP offset must be less than the FDE repetition size.

> +		return -EFAULT;
> +
> +	UNSAFE_GET_USER_INC(info, cur, 1, Efault);
> +	dataword_count = SFRAME_V3_FRE_DATAWORD_COUNT(info);
> +	dataword_size  = dataword_size_enum_to_size(SFRAME_V3_FRE_DATAWORD_SIZE(info));
> +	if (!dataword_count || !dataword_size)
> +		return -EFAULT;
> +
> +	if (cur + (dataword_count * dataword_size) > sec->fres_end)
> +		return -EFAULT;
> +
> +	/* TODO: Support for flexible FDEs not implemented yet. */
> +	if (fde_type != SFRAME_FDE_TYPE_DEFAULT)
> +		return -EFAULT;
> +
> +	UNSAFE_GET_USER_INC(cfa_off, cur, dataword_size, Efault);
> +	dataword_count--;
> +
> +	ra_off = sec->ra_off;
> +	if (!ra_off) {
> +		if (!dataword_count--)
> +			return -EFAULT;
> +
> +		UNSAFE_GET_USER_INC(ra_off, cur, dataword_size, Efault);
> +	}
> +
> +	fp_off = sec->fp_off;
> +	if (!fp_off && dataword_count) {
> +		dataword_count--;
> +		UNSAFE_GET_USER_INC(fp_off, cur, dataword_size, Efault);
> +	}
> +
> +	if (dataword_count)
> +		return -EFAULT;
> +
> +	fre->size	= addr_size + 1 + (dataword_count * dataword_size);
> +	fre->ip_off	= ip_off;
> +	fre->cfa_off	= cfa_off;
> +	fre->ra_off	= ra_off;
> +	fre->fp_off	= fp_off;
> +	fre->info	= info;
> +
> +	return 0;
> +
> +Efault:
> +	return -EFAULT;
> +}
Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/


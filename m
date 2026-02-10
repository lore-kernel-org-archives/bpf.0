Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819F43176E4;
	Tue, 10 Feb 2026 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770742046; cv=none; b=q9h7iBYsd8uxOSED3d2Kq/F8ELh29CHn99nn6ryGFO8M2r+QLTc8qrSlBpSIHWKabtwdQ3dj0UIHQPzNApeeJNFaGBUbRih5eCxEXfjrw6fjVspMd7UWfZ7MDgD5qxPo1pQPqRME+swh5TUvzznzuv6O4Ifb5dFwMlIScpOG0gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770742046; c=relaxed/simple;
	bh=BVm/5gq52CdaZjQ4djKa+p0um+0soZsJ3vLS+v1e+ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPHl+p5dUJxynEo/WRi70sRPknVoG+UNA6dgp7NwY6xpIhKEk/KzkC6FAIFghQxyNbXbVEMgLdfxf9EiFSHmAr22WVZpsd72lcoIrJscMaYLes4pbXGnhnmi0m91rgp+zWIP2B/bLNHstlk9qd4Sz8ryljtuXvNJ+4kQ/mzTG3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kysmhW/u; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kysmhW/u"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A3aBC93408670;
	Tue, 10 Feb 2026 16:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hWIG4k
	TyswI9jcJ/eF4E6+Aw6IleHIzONJBK1RVFQNA=; b=kysmhW/utq4d6wdVlZnUaF
	r/IRwiaChYl1wuGU3Uh8Wxo+msm6lJsXuxQfn7GsTpZJ9C62AKdIOQqgHrl9xwYS
	5BVJVGZ7LaQ19aQmhYkyPDunPolrBVTrc013Jh/HAe0kJ0+3ber0+89Z7VbNQttU
	zexHliC+wz/QSQA41kHSt9zwK/cxvSxQwZJS0AAmOKUy+N/RgTpKLOFaz4V01UzI
	sXvP6h5MpJEiZCZR0D0O3diDeHCVU/RH79T5Cg/vQJejaYG3H9m/DJ7XsLmXOLx6
	abDnwzd6xLbC2+zEzw6ZceagIEemby/9fcebel9/Sh8VrRya9Lx1fdezqUoNJ4ww
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696uu4qr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 16:46:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61AEbFxq001499;
	Tue, 10 Feb 2026 16:46:39 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6gqn27jx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 16:46:39 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61AGkZf230605964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Feb 2026 16:46:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBBD620040;
	Tue, 10 Feb 2026 16:46:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E7C020043;
	Tue, 10 Feb 2026 16:46:34 +0000 (GMT)
Received: from [9.52.200.149] (unknown [9.52.200.149])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Feb 2026 16:46:34 +0000 (GMT)
Message-ID: <15f2af3b-be33-46fc-b972-6b8e7e0aa52e@linux.ibm.com>
Date: Tue, 10 Feb 2026 17:46:33 +0100
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
        Steven Rostedt <rostedt@kernel.org>
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
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260206193642.1580787-7-jremus@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDEzNiBTYWx0ZWRfXx0hBg5sfg+Sm
 RCuatqOyNDSemteUA5F+r4Ge2cM0/zQOT5n/ZqVCnhyWG/QDD8i2JZhH1g/2iNZAlUWMjFcAQVv
 pLQReX4/gIcOywzLhe9vqmurQ5b392gkE0KkGwkYXtgA5vQqorSZO05XXfmGA7F3cHoV7IuOb0W
 SVobFFKAR0XUxdXlnR4vIoqeLG8O3jVoiY7hQ6NzvemQWA+EtgEVvD5AlP3e/vVG9Qaa3drVQy9
 /sgxePwtuEN1f8WRa82RYtNS9SVWFZlrfXcicv/IhhD80u3BXV48SQ2VkPvaBjKDUA9TbF4+KFb
 tMseD+WNlwQAAB+vVNDVm8wRqwnIolO5Etlys3u7FIrx9imuqvSssMtnTBNkfnBTmdc43e0kyV8
 9aIDMBhrzcmT5khDY9al2AMmIMlQjsBL1iF949YpEinx01JHeY8jM/0sXyRV+4rbE/yYRPRyR05
 564StLrk5fLK2GaTHmw==
X-Proofpoint-ORIG-GUID: lFUhbotL6mZHHQBIGQHNWFr4iFqXQvoQ
X-Proofpoint-GUID: yXXBPSDw6CtLkz2VIBzGSNLoMPEAqhQX
X-Authority-Analysis: v=2.4 cv=O+Y0fR9W c=1 sm=1 tr=0 ts=698b60f1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=1YTvd-3GSpCLN8fQQIoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100136

On 2/6/2026 8:36 PM, Jens Remus wrote:
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> Enable sframe generation in the VDSO library so kernel and user space
> can unwind through it.
> 
> SFrame isn't supported for x32 or x86-32.  Discard .sframe sections for
> those VDSOs.
> 
> [ Jens Remus: Add support for SFrame V3.  Prevent GNU_SFRAME program
> table entry to empty .sframe section. ]
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>

> diff --git a/arch/Kconfig b/arch/Kconfig

> @@ -479,6 +479,13 @@ config HAVE_HARDLOCKUP_DETECTOR_ARCH
>  	  It uses the same command line parameters, and sysctl interface,
>  	  as the generic hardlockup detectors.
>  
> +config AS_SFRAME
> +	bool
> +
> +config AS_SFRAME3
> +	def_bool $(as-instr,.cfi_startproc\n.cfi_endproc,-Wa$(comma)--gsframe-3)

Above tests whether the assembler supports --gsframe-3 to generate
.sframe in SFrame V3 format.  GNU assembler only supports to generate
SFrame for x86-64.  If the assembler is built for i386 (x86-32) the test
will fail unless option --64 is specified.  I wonder whether that could
happen in (the rather hypothetical?) case, when the kernel is cross built
for x86-64 on i386?  Should this therefore be changed to the following?

config AS_SFRAME_64
	def_bool $(as-instr,.cfi_startproc\n.cfi_endproc,$(m64-flag) -Wa$(comma)--gsframe)

An alternative would be to enable as-instr64 to accept an optional flag
operand, similar to as-instr, and use as-instr64 instead of as-instr.

Or is this not required, as in a cross build for 64-bit on a 32-bit
platform (or inverse) a respective cross toolchain is a prerequisite and
the m64-flag (or m32-flag) is not used?

I tried to simulate this using docker and an i386 image and then using
the i386 tool in the container to switch "uname -m" to "i686".  But both
of my following attempts to build for x86-64 on i386 fail with fixdep
not found:

$ docker run -it --rm -v "$HOME/linux:$HOME/linux" --platform i386 public.ecr.aws/docker/library/debian:13.3
# sed -i -s 's/^Types: deb/& deb-src/' /etc/apt/sources.list.d/debian.sources
# apt update
# apt -y build-dep linux

# make mrproper
# i386 make ARCH=x86_64 defconfig
# i386 make ARCH=x86_64 arch/x86/entry/vdso/

# make mrproper
# apt -y install gcc-x86-64-linux-gnu
# i386 make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu- defconfig
# i386 make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu- arch/x86/entry/vdso/

> +	select AS_SFRAME
> +
>  config UNWIND_USER
>  	bool

> diff --git a/arch/x86/entry/vdso/vdso64/Makefile b/arch/x86/entry/vdso/vdso64/Makefile

> @@ -14,6 +14,7 @@ vobjs-$(CONFIG_X86_SGX)		+= vsgx.o
>  
>  # Compilation flags
>  flags-y				:= -DBUILD_VDSO64 -m64 -mcmodel=small
> +flags-$(CONFIG_AS_SFRAME3)	+= -Wa,--gsframe-3

flags-$(CONFIG_AS_SFRAME3_64)	+= -Wa,--gsframe-3

>  
>  # The location of this include matters!
>  include $(src)/../common/Makefile.include
Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/


Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78943859C4;
	Tue, 10 Feb 2026 18:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770749473; cv=none; b=XribIM6Hl6FSsphHkxauywdbm/swBIHoIyb5DR2vTMBl7FO6UrGe7zO/zW1EcTv8/4nRwfk2i1p94pSwneH5wPQLKPabCM735cwiXqcfquAn2vpL5zX4DaQOgumq3Dj8OytI3UirsUAzRHNXoH+f0YMqGjsM5ZBv63aH/8RbRKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770749473; c=relaxed/simple;
	bh=Kvn4z6vTFdrLD0BqFpA/d82t4XvljEOfh7oCcHMOH2o=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Dc9nVV8Oqq5hUM75sXUJ8j/NAWobMoB5gbvvOjeqGCG83lJ39zt1UzEw+7ABX7zPdL4ylUBgP6PoLkcZmPdeOUldHs/HZvXWZVn+GqtC97dLjcbrEwqY+0XRnCgDe8FAzJ2x8bLWDOn5Yavx4xAX+owfyPtepDIssjvgR7oQGZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=f1rEPTPi reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="f1rEPTPi"
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 61AInRsk3481501
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 10 Feb 2026 10:49:27 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 61AInRsk3481501
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1770749375;
	bh=cWf1IsI/pAy5WPRGsYGUniAQCZpzMFbG3rOVk0odWQU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=f1rEPTPiSKPoUGeoDhdGaBgL5cSJ7VfH+YhsIfIOHrtGQ098Q+FHVrfNXowcbvMeA
	 yDadyDDtFhf9aL/9HGTXiQXE888P9HTS+6oLLYPrAc3TO0QKL//STzW0rAJBEyI1+i
	 O5dl9S4264EbhUb2yJqRo5qGewEGRvR8YXAwQ3WFJAvxTUdIBOS1v8o2EsX9jArBk2
	 C+5BQED2HdZm118lWFa+txDa2ddK0uhsk7rAfITy7T//sBYbF/ZD4f5/FPEoEdQic9
	 zb4h4++3+VOXGUlMVZ/yQ6ARpbbz/r4ge2yLKsqVRRwBEXuRqlMj/U+hmyt/ecLuUg
	 ePICMN/3/wSWg==
Date: Tue, 10 Feb 2026 10:49:21 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Jens Remus <jremus@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        x86@kernel.org, linux-mm@kvack.org,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Steven Rostedt <rostedt@kernel.org>
CC: Masami Hiramatsu <mhiramat@kernel.org>,
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
        Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: Re: [PATCH v8 6/6] x86/vdso: Enable sframe generation in VDSO
User-Agent: K-9 Mail for Android
In-Reply-To: <15f2af3b-be33-46fc-b972-6b8e7e0aa52e@linux.ibm.com>
References: <20260206193642.1580787-1-jremus@linux.ibm.com> <20260206193642.1580787-7-jremus@linux.ibm.com> <15f2af3b-be33-46fc-b972-6b8e7e0aa52e@linux.ibm.com>
Message-ID: <8929995D-26A5-4F57-A41D-634CEB3D7C29@zytor.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 10, 2026 8:46:33 AM PST, Jens Remus <jremus@linux=2Eibm=2Ecom> =
wrote:
>On 2/6/2026 8:36 PM, Jens Remus wrote:
>> From: Josh Poimboeuf <jpoimboe@kernel=2Eorg>
>>=20
>> Enable sframe generation in the VDSO library so kernel and user space
>> can unwind through it=2E
>>=20
>> SFrame isn't supported for x32 or x86-32=2E  Discard =2Esframe sections=
 for
>> those VDSOs=2E
>>=20
>> [ Jens Remus: Add support for SFrame V3=2E  Prevent GNU_SFRAME program
>> table entry to empty =2Esframe section=2E ]
>>=20
>> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel=2Eorg>
>> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis=2Eorg>
>> Signed-off-by: Jens Remus <jremus@linux=2Eibm=2Ecom>
>
>> diff --git a/arch/Kconfig b/arch/Kconfig
>
>> @@ -479,6 +479,13 @@ config HAVE_HARDLOCKUP_DETECTOR_ARCH
>>  	  It uses the same command line parameters, and sysctl interface,
>>  	  as the generic hardlockup detectors=2E
>> =20
>> +config AS_SFRAME
>> +	bool
>> +
>> +config AS_SFRAME3
>> +	def_bool $(as-instr,=2Ecfi_startproc\n=2Ecfi_endproc,-Wa$(comma)--gsf=
rame-3)
>
>Above tests whether the assembler supports --gsframe-3 to generate
>=2Esframe in SFrame V3 format=2E  GNU assembler only supports to generate
>SFrame for x86-64=2E  If the assembler is built for i386 (x86-32) the tes=
t
>will fail unless option --64 is specified=2E  I wonder whether that could
>happen in (the rather hypothetical?) case, when the kernel is cross built
>for x86-64 on i386?  Should this therefore be changed to the following?
>
>config AS_SFRAME_64
>	def_bool $(as-instr,=2Ecfi_startproc\n=2Ecfi_endproc,$(m64-flag) -Wa$(co=
mma)--gsframe)
>
>An alternative would be to enable as-instr64 to accept an optional flag
>operand, similar to as-instr, and use as-instr64 instead of as-instr=2E
>
>Or is this not required, as in a cross build for 64-bit on a 32-bit
>platform (or inverse) a respective cross toolchain is a prerequisite and
>the m64-flag (or m32-flag) is not used?
>
>I tried to simulate this using docker and an i386 image and then using
>the i386 tool in the container to switch "uname -m" to "i686"=2E  But bot=
h
>of my following attempts to build for x86-64 on i386 fail with fixdep
>not found:
>
>$ docker run -it --rm -v "$HOME/linux:$HOME/linux" --platform i386 public=
=2Eecr=2Eaws/docker/library/debian:13=2E3
># sed -i -s 's/^Types: deb/& deb-src/' /etc/apt/sources=2Elist=2Ed/debian=
=2Esources
># apt update
># apt -y build-dep linux
>
># make mrproper
># i386 make ARCH=3Dx86_64 defconfig
># i386 make ARCH=3Dx86_64 arch/x86/entry/vdso/
>
># make mrproper
># apt -y install gcc-x86-64-linux-gnu
># i386 make ARCH=3Dx86_64 CROSS_COMPILE=3Dx86_64-linux-gnu- defconfig
># i386 make ARCH=3Dx86_64 CROSS_COMPILE=3Dx86_64-linux-gnu- arch/x86/entr=
y/vdso/
>
>> +	select AS_SFRAME
>> +
>>  config UNWIND_USER
>>  	bool
>
>> diff --git a/arch/x86/entry/vdso/vdso64/Makefile b/arch/x86/entry/vdso/=
vdso64/Makefile
>
>> @@ -14,6 +14,7 @@ vobjs-$(CONFIG_X86_SGX)		+=3D vsgx=2Eo
>> =20
>>  # Compilation flags
>>  flags-y				:=3D -DBUILD_VDSO64 -m64 -mcmodel=3Dsmall
>> +flags-$(CONFIG_AS_SFRAME3)	+=3D -Wa,--gsframe-3
>
>flags-$(CONFIG_AS_SFRAME3_64)	+=3D -Wa,--gsframe-3
>
>> =20
>>  # The location of this include matters!
>>  include $(src)/=2E=2E/common/Makefile=2Einclude
>Thanks and regards,
>Jens

I think we can worry about that later=2E

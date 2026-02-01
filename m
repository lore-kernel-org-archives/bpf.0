Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69AA24A049;
	Sun,  1 Feb 2026 08:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769934330; cv=none; b=UABN1HRbg4Ns+faLcNATmAF5dMafBwaZ1y33mUDEkfheT6AruWcjDszYDBOTxhGJqYo9k4nc+znLkfylpA0QoIJKqkP/sKU4C38xFaoQegPJI6lmCZQSRwjewJWRmoSUCwMVR0WzFJeMf7wAG4FIynrz1HvP6Ui5gQedhjbvB2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769934330; c=relaxed/simple;
	bh=4l+jabMVHYrLnG985lOKU4sOR/4lZBhBaCMGPxK4Hpg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=E0qQbGrPiTBoi1ccmCxzA3kGATS/F0log1L1vudRhUvWVdf5SFMNPSDZccgJ6HVh6p2DxJVuRAOB08voGM5G6UFZgPcbTJ6PdgxsmoBOJVVwgHSPpkoZACYi1oeeiiy4eXBtb8dY6UX5rWgMF7j+DfeAIZv6/aa5kECE8JECefs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=YQXB7/oy reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="YQXB7/oy"
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 6118NbHC2133728
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 1 Feb 2026 00:23:38 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 6118NbHC2133728
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1769934220;
	bh=plHDA7QLJmcfQszbJlbjOYhF5Sm//GhH9ob/Ho1ZwUY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=YQXB7/oyziryyUrNtDf7kszFAnpmhF2NepxI+HHDQQrNJY7A5Yrs4EMHSsmkVFvq6
	 aUIbc52ZQjR/w5wSn7qpzj9962PvRGwfJ4wiKNsFhNpW2JFaUec0J1aCov8M6Q66wT
	 My2BtDMHUmvOITSNHlPFrTjo5elNnPW2gwaHTyjqQ7w0tbrtISg+wEJPQxzkU/7EtO
	 zoNFGnnpkYrzfM1wXCWRgeEh0v3Dc12ex5+thla7gIThvOSl5XbWjTcvlvn+lxJG+1
	 Re9XH6nub6A4SpAo98WVg8ZiY2ENY+b6Bn8xkkXZK+SNM2iPLx+6YNQNqyXs/qmK2r
	 edncvRF7Vno6Q==
Date: Sun, 01 Feb 2026 00:23:31 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Jens Remus <jremus@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        x86@kernel.org, linux-mm@kvack.org,
        Steven Rostedt <rostedt@kernel.org>
CC: Josh Poimboeuf <jpoimboe@kernel.org>,
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
        David Hildenbrand <david@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v6 0/6] x86/vdso: VDSO updates and fixes for sframes
User-Agent: K-9 Mail for Android
In-Reply-To: <20260129112726.892340-1-jremus@linux.ibm.com>
References: <20260129112726.892340-1-jremus@linux.ibm.com>
Message-ID: <B1CDD538-668D-48E3-A937-740B7D6575FA@zytor.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 29, 2026 3:27:20 AM PST, Jens Remus <jremus@linux=2Eibm=2Ecom> w=
rote:
>This enables generation of SFrame V3 stack trace information for VDSO on
>x86-64=2E  It's a continuation of Josh's and Steve's work:
>
>   https://lore=2Ekernel=2Eorg/all/cover=2E1737511963=2Egit=2Ejpoimboe@ke=
rnel=2Eorg/
>   https://lore=2Ekernel=2Eorg/all/20250422183439=2E895236512@goodmis=2Eo=
rg/
>
>This series focuses only on the VDSO code=2E They are helpful fixes
>and updates that doesn't rely on sframes (although the last patch
>is sframe related)=2E
>
>This series applies on top of the latest unwind user sframe series
>"[PATCH v13 00/18] unwind_deferred: Implement sframe handling":
>https://lore=2Ekernel=2Eorg/all/20260127150554=2E2760964-1-jremus@linux=
=2Eibm=2Ecom/
>
>Like above series it depends on the upcoming binutils 2=2E46 release to
>be used to build executables and libraries such as VDSO with SFrame V3
>stack trace information (using the assembler option --gsframe-3)=2E
>
>Changes in v6:
>- SFrame V3 support (SFrame V2 is not supported)=2E
>- Prevent GNU_SFRAME program table entry to empty =2Esframe section=2E
>- Integrate v5 review feedback=2E (Josh)
>
>Regards,
>Jens
>
>
>Josh Poimboeuf (6):
>  x86/vdso: Fix DWARF generation for getrandom()
>  x86/asm: Avoid emitting DWARF CFI for non-VDSO
>  x86/asm: Simplify VDSO DWARF generation
>  x86/vdso: Use SYM_FUNC_{START,END} in __kernel_vsyscall()
>  x86/vdso: Use CFI macros in __vdso_sgx_enter_enclave()
>  x86/vdso: Enable sframe generation in VDSO
>
> arch/Kconfig                             |  7 +++
> arch/x86/entry/vdso/Makefile             | 10 +++--
> arch/x86/entry/vdso/vdso-layout=2Elds=2ES    |  9 +++-
> arch/x86/entry/vdso/vdso32/system_call=2ES | 10 +----
> arch/x86/entry/vdso/vgetrandom-chacha=2ES  |  3 +-
> arch/x86/entry/vdso/vsgx=2ES               | 19 +++------
> arch/x86/include/asm/dwarf2=2Eh            | 54 +++++++++++++++++-------
> arch/x86/include/asm/linkage=2Eh           | 33 ++++++++++++---
> arch/x86/include/asm/vdso=2Eh              |  1 -
> 9 files changed, 97 insertions(+), 49 deletions(-)
>

This patchset clashes *hard* with the changes already in tip:x86/entry=2E

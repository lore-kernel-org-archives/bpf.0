Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7DB86348;
	Tue,  3 Feb 2026 17:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770140239; cv=none; b=WoUACkUAI7ofBtCH2WmCBR6WxXzbcWXbZU/oCR+S0oS3zCMbK2bTFYS6/Z+BjB16u0UQf8TSkh5A1dxoNinJ5+eHGCmPu5BGSjmlMwJ6jc/oCdDQ5b4pM5eSn7bwuGwwth8PBSwyZqWKakijws2QaXyPlNPqanMVa+J+K14Fhfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770140239; c=relaxed/simple;
	bh=wlq7sOz+cvn9OWR1H4KzX9avjeN7pYX6i6zRvsnztHA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=mnjZnHoS8E2XVPkbuwL436lZtpkynFvIdqm4V5cXb2bRb7lq3emoh6YYnd8l6YN7zLzG5utCnlW0179WTVzvctTQmrHJRLiXyqOEEQqduh5co4AQRM3IQvByqC1DaZn74G6UxOPy+/Gx+B/BfUURmnALjp7MYFPbApjeVnFa+T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=PLmnOTM+ reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="PLmnOTM+"
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 613HZcQG3503354
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 3 Feb 2026 09:35:38 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 613HZcQG3503354
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1770140140;
	bh=RaL2K556/b29Zc7mgPhyn+Wsge6D4MK7+AfuXFYE8Tw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=PLmnOTM+d1xnyLW9FTtb9/IJ/llB539xPwkf9n9id/lLbVqgxVwDhm16DkKJDkwCB
	 v/VqrKIvOSdXV3PP0zdH6jhkbHgEvtzah2DGnqfB8WLbn5sAERwaawtqcO+3ZDFryV
	 Kr5e8reRQydFNRfJ+r0YYMagJoxb5BsmywUyoYP4ZETc1vGRhE7KPL7nkJpJpnonu5
	 Xx4xZ0u7BuS1sIhZ2N9okj4b6vaVWvTZ9DRo0yFhvcjLfVoJ2M/6Z0MVhgRd6HJIiT
	 YH2816M8QHuCDD8U2wXu8NSIbEIATo0EG0tNoO1ZBIqWGdr6O2KFpl+alfJrhzNuyg
	 DBWsBSCV+A+6Q==
Date: Tue, 03 Feb 2026 09:35:30 -0800
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
        Vasily Gorbik <gor@linux.ibm.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: Re: [PATCH v7 2/6] x86/asm: Avoid emitting DWARF CFI for non-VDSO
User-Agent: K-9 Mail for Android
In-Reply-To: <20260203171958.1522030-3-jremus@linux.ibm.com>
References: <20260203171958.1522030-1-jremus@linux.ibm.com> <20260203171958.1522030-3-jremus@linux.ibm.com>
Message-ID: <F16410E4-43A2-4CC1-8049-AFB803733869@zytor.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 3, 2026 9:19:53 AM PST, Jens Remus <jremus@linux=2Eibm=2Ecom> w=
rote:
>From: Josh Poimboeuf <jpoimboe@kernel=2Eorg>
>
>It was decided years ago that =2Ecfi_* annotations aren't maintainable in
>the kernel=2E  They were replaced by objtool unwind hints=2E  For the ker=
nel
>proper, ensure the CFI_* macros don't do anything=2E
>
>On the other hand the VDSO library *does* use them, so user space can
>unwind through it=2E
>
>Make sure these macros only work for VDSO=2E  They aren't actually being
>used outside of VDSO anyway, so there's no functional change=2E
>
>Signed-off-by: Josh Poimboeuf <jpoimboe@kernel=2Eorg>
>Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis=2Eorg>
>Signed-off-by: Jens Remus <jremus@linux=2Eibm=2Ecom>
>---
> arch/x86/include/asm/dwarf2=2Eh | 51 ++++++++++++++++++++++++-----------
> 1 file changed, 35 insertions(+), 16 deletions(-)
>
>diff --git a/arch/x86/include/asm/dwarf2=2Eh b/arch/x86/include/asm/dwarf=
2=2Eh
>index 09c9684d3ad6=2E=2E7cc30500c095 100644
>--- a/arch/x86/include/asm/dwarf2=2Eh
>+++ b/arch/x86/include/asm/dwarf2=2Eh
>@@ -6,6 +6,15 @@
> #warning "asm/dwarf2=2Eh should be only included in pure assembly files"
> #endif
>=20
>+#ifdef BUILD_VDSO
>+
>+	/*
>+	 * For the vDSO, emit both runtime unwind information and debug
>+	 * symbols for the =2Edbg file=2E
>+	 */
>+
>+	=2Ecfi_sections =2Eeh_frame, =2Edebug_frame
>+
> #define CFI_STARTPROC		=2Ecfi_startproc
> #define CFI_ENDPROC		=2Ecfi_endproc
> #define CFI_DEF_CFA		=2Ecfi_def_cfa
>@@ -22,21 +31,31 @@
> #define CFI_ESCAPE		=2Ecfi_escape
> #define CFI_SIGNAL_FRAME	=2Ecfi_signal_frame
>=20
>-#ifndef BUILD_VDSO
>-	/*
>-	 * Emit CFI data in =2Edebug_frame sections, not =2Eeh_frame sections=
=2E
>-	 * The latter we currently just discard since we don't do DWARF
>-	 * unwinding at runtime=2E  So only the offline DWARF information is
>-	 * useful to anyone=2E  Note we should not use this directive if we
>-	 * ever decide to enable DWARF unwinding at runtime=2E
>-	 */
>-	=2Ecfi_sections =2Edebug_frame
>-#else
>-	 /*
>-	  * For the vDSO, emit both runtime unwind information and debug
>-	  * symbols for the =2Edbg file=2E
>-	  */
>-	=2Ecfi_sections =2Eeh_frame, =2Edebug_frame
>-#endif
>+#else /* !BUILD_VDSO */
>+
>+/*
>+ * On x86, these macros aren't used outside VDSO=2E  As well they should=
n't be:
>+ * they're fragile and very difficult to maintain=2E
>+ */
>+
>+=2Emacro nocfi args:vararg
>+=2Eendm
>+
>+#define CFI_STARTPROC		nocfi
>+#define CFI_ENDPROC		nocfi
>+#define CFI_DEF_CFA		nocfi
>+#define CFI_DEF_CFA_REGISTER	nocfi
>+#define CFI_DEF_CFA_OFFSET	nocfi
>+#define CFI_ADJUST_CFA_OFFSET	nocfi
>+#define CFI_OFFSET		nocfi
>+#define CFI_REL_OFFSET		nocfi
>+#define CFI_REGISTER		nocfi
>+#define CFI_RESTORE		nocfi
>+#define CFI_REMEMBER_STATE	nocfi
>+#define CFI_RESTORE_STATE	nocfi
>+#define CFI_UNDEFINED		nocfi
>+#define CFI_ESCAPE		nocfi
>+
>+#endif /* !BUILD_VDSO */
>=20
> #endif /* _ASM_X86_DWARF2_H */

Maybe we should move these into x86/entry/vdso/common instead?

Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F5C23C8AE;
	Fri,  6 Feb 2026 23:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770422292; cv=none; b=mcbvjFH00QzNzwkfCzvOLGAv51OyUlddO2QIDKPofVCk6EmbwCUtuLTnKWN4J+ZZ/Kl44lyq5PWbURiuONquygQBDGKh2es1nrydqqOpw7L3z8Z/e0cCWS4809rWVMx6K1SQn0ZDAQpH5T5uew/3KnNPvSfrTBaiu0aUEfBkORk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770422292; c=relaxed/simple;
	bh=aNceiIqQwD0cE1qqeyljG2hgz12x7OsfWe5rwTsofgg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=nBqoIYnA/v+70OdQ6GP33Z2EXqyMP5uSDdwuaPKxBuTsB0tK/HsDkid08/NeWX1RFbTg2oGghcmahDHHA+5ModXxA/YKUiB6vWGup7NAC00TALBCZiDuU8FFgyWQ2uphUxLolqPsTrixklV1waPFra14msSKtyF4V81wBnoavKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=r3FNeO88 reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="r3FNeO88"
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 616Nv5wn1409975
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 6 Feb 2026 15:57:06 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 616Nv5wn1409975
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1770422230;
	bh=qrRYtFR1PGHmyWdm1nw1biFHQwk7kZHfuvavlQRdIOg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=r3FNeO88r0RrnhV3YBVyg+iBIZuK7drEQKWqvPsgtjVOB80iUpyD9ZWIkp2SVJIeX
	 6GhpYllzsUGTGmGSG4hi5SZzYlxs7uUjM0QDA+ln71Wu2OhfR3NozOo0Q608eXhGET
	 DKr/v+GRHJr20m5R18bjdYsLVUeuQLh6UG7vzxclzO4z7LMNpzExpF3yD+QddoGlnf
	 bucheALVuE+6WxjwWkzddnE/J4Af53zMzfyRGmfpVhnLw3JOONTS2y2/5HkkhVl9JK
	 F9MePpObJToFaZVZlxW5iT8KQnP+crUCszIH00GX9xN6JfQAZiQ9eehxIcXMxLSDkb
	 hsGrh2zK8IPSg==
Date: Fri, 06 Feb 2026 15:56:59 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Jens Remus <jremus@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        x86@kernel.org, linux-mm@kvack.org,
        Steven Rostedt <rostedt@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>
CC: Masami Hiramatsu <mhiramat@kernel.org>,
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
        David Hildenbrand <david@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: Re: [PATCH v7 6/6] x86/vdso: Enable sframe generation in VDSO
User-Agent: K-9 Mail for Android
In-Reply-To: <9a63ce89-84f0-4782-90bf-dfd7c8ec8c52@linux.ibm.com>
References: <20260203171958.1522030-1-jremus@linux.ibm.com> <20260203171958.1522030-7-jremus@linux.ibm.com> <f671c79a-ee73-4a12-af48-2811f97b9f3d@zytor.com> <9a63ce89-84f0-4782-90bf-dfd7c8ec8c52@linux.ibm.com>
Message-ID: <1AE3ED79-C094-46AE-B455-06199D5699DD@zytor.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 6, 2026 9:48:24 AM PST, Jens Remus <jremus@linux=2Eibm=2Ecom> w=
rote:
>On 2/4/2026 1:49 AM, H=2E Peter Anvin wrote:
>> On 2026-02-03 09:19, Jens Remus wrote:
>>> -
>>> +#if defined(__x86_64__) && defined(CONFIG_AS_SFRAME)
>
>My understanding is that you would like above changed to:
>
>#ifdef CONFIG_AS_SFRAME
>
>>> +	=2Ecfi_sections =2Eeh_frame, =2Edebug_frame, =2Esframe
>>> +#else
>>>  	=2Ecfi_sections =2Eeh_frame, =2Edebug_frame
>>> +#endif
>>> =20
>>=20
>> It would be better to:
>>=20
>> #undef CONFIG_AS_SFRAME	/* i386 doesn't support =2Esframe */
>>=20
>> in fake_32bit_build=2Eh=2E
>Due to (binutils 2=2E46 pre-release) GNU assembler supporting --gsframe-3=
,
>but only for x86-64 not for x86-32 (nor x32) CONFIG_AS_SFRAME is enabled
>even for my i386 cross build attempt=2E  This then wrongly causes the
>=2Ecfi_sections with =2Esframe to be selected (verified by adding an #err=
or
>for testing)=2E
>
>IIUC the =2Ecfi_sections is there to have DWARF in both =2Eeh_frame and
>=2Edebug_frame=2E  For =2Esframe it basically has the same effect as
>specifying the common assembler option --gsframe=2E  Given the more
>specific option --gsframe-3 is explicitly specified I think it would
>be better to drop the changes to both dwarf2=2Eh and fake_32bit_build=2Eh
>and solely rely on --gsframe-3=2E
>
>Josh, Indu, do you agree?
>
>Thanks and rRegards,
>Jens

Seems a lot cleaner to me, too, assuming it actually works=2E

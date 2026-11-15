Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794726812;
	b=y1H3U2iRsAGe61Ny0f44nJsomdffj4JrhePU2w1fhlMCEahG86kPtoYWchG3gvt/kB7H
	 WS/3QaOGitTiykcUn9gtlJSxJ+RE8wPVpEUJdPgbLnrrrcFZzlCzz0O6+7fBJUvRZtBYN
	 wn7FJN1LgKOJW+JqW0ReuVO9vQFbugEoUj+11hL9Xjm/WZsM5GxxlE7ZnQUuCGW7u9oSd
	 A4GiME4s40rK4vWk5pIpT5UsBvC7H28NCPa3FUiA6ylTY2ESoEeoU6LPsuV1qm+8hQUyT
	 24vtpQlz/7K4fIBFKYDAm+UREGPQLJSaoOMrXz+SuV4VhRrOwTwz4k/YaQu3iT8IHeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794726812;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=i0sztYeDoa78GRxByi5DPGRDZ13zK/I8mczcB1W5Z+o=;
	b=dmYgoufBhDDsavtJ5wFBwtsCYkkAAVkUneMrs2N8DVIVcjba0EKPscPRl6FXTDjHKHdE
	 495wK7fJWFRhDweCsaBZk+L8DXymQzE3YWjc9P+hN2Axltn80pMXIzKOGfAF3QQ653EmR
	 UMppH9HlH1Ocs4tWtGNC65+jC87H9h02n7Y63DtXs+JB94s5yCwp58558VXpKNQ6wXJCS
	 WbPs12iQRMSlWTOSsN+imYO8HhEPHFb5oDptKjB6U8Cq2XI61bgz6cTTlMIkmL4rH1DbD
	 KrXTU/iOTMVJcu02dGVfg/WzFj84yD+ZX4mZyIQ3wL1ZVLnXvFacU4XRwR6/Da3FLGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f0EKiv+f;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC8F606A335
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 07:13:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EC8F606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f0EKiv+f
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1a2761c69fbso2761585c88.0
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 23:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794726811; x=1795331611; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i0sztYeDoa78GRxByi5DPGRDZ13zK/I8mczcB1W5Z+o=;
        b=f0EKiv+f25sXRcQmBoiK+WsCsclD9PQHa+U5z3sGf3KR1sS3ZNEEroqRh6RNiac07P
         vGJPEugwLNmQaWqJhCPHikaN8XT33PRVwWCxE9PqkkLJA6butk39sYE2ryU8qCsIMdGI
         yo50td1Os6it0j1WrNa5HxnLEw4W7aO/qgSsYPJply/RpIro6UCSg0Mbr4ks/thyRkDc
         jq1OBKLqGUt/bM6QVBsbrIsF1mbjoO/AbvtSri1zHl8+S2Sf3KoNhgqJldsJW2yIuTc5
         6FJrXgJQKS6UwdWBKS3YQ4l597qJpRKbmN+vGilzta6Rl47F1I/gy3R+i3U13Lj6DU+d
         z+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794726811; x=1795331611;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i0sztYeDoa78GRxByi5DPGRDZ13zK/I8mczcB1W5Z+o=;
        b=DrPH1WiJpy85Xck+vMivEfnPdl1LUIoO2CHJb1hi0Yd8LwmihpfD5oRIiSNvn/wSpQ
         26mw93XSVtmjBaIT6VirF3yNTjt8t2DykFgW8gJvkKMkmpVSeoo4tbmXnLoXMq3f1NHG
         gJOgC4JsMrWemdsuZNkhW61TAvIcXEdWdT0mFISl8NLbirF/Qfd7/QmMGJD+cQYNf9dF
         NZ4YugbmCX6e1ib8vPl7uqX7sT0bRHDpubsspgVdriCFaGwK++QSfb9QdcYoshz0TRp3
         ubaBDYTAqsvhKiyWwCCx+Jy9bWPpDNZER2jouBmj/CZ9cGAhbudbry+JFfBOPqi+JFhG
         63dA==
X-Forwarded-Encrypted: i=1; AL+hErFRcXzNfaKGDcmNV3ZPtnxf43970jHO1SN0ZubVeO//VQbP6x5gvdeIG/pnfUsD4J8LX7I=@vger.kernel.org
X-Gm-Message-State: APuU4Z//K4lrPe8WjqBUoaTMQsPvEvuedcdGKGht7H0VdPw/0OhjHbxt
	3Jyzk2cHrgJxDpmL5WKGmS0ud9rb5RmQSKU6lepx/Y/ygnMFmudSI28P
X-Gm-Gg: AYBFou1G24AzKMAJbyzA/KWhmLh2ZeedipQdH+CIi+R2laDstKxx/i4nbqhWuEQm5OH
	Bn7EsNfDe1P/S1wlsadwqoIs3FttqT4BuPp2y46bWTPAfb6eIuBRuYijGgO9eGsNhs9iMmXyjFR
	CKpOQh6lkSca5R6+sgTFXiQc0+2QLVV/fE4RtL1MBzdkVxKT9WFrsM2FU2eFjlzK0Is9rCqpqSg
	60ITITTS0CwCT6tA1EtdVKsYCSBLLmbyq16Enq8EIbm31zG4DTZJA62MomKp4834sjTzEFP5lMI
	g1H4HBjgDmcirOWQZEheePUJ/5OiXWIf7Q36HyMHrXgFDRRTmjBECN19oBg4/k8edxO5Y3nB9tZ
	iNQfI2ihJRrQkH3r4ErzyjAFJL1uNgWw3BOY9/7OFk6xRRB8jcH46YE5BeomOAmvAHJPZMJMCa9
	O5NnFXLuRRtCVtNRziwCNzaUbxfepGi0zJ8WPHGMBiTZPjyPLwSaH0COt3x2dR+hAlKu7qch66I
	kR5Uc2nu0kIKWTYAPjIfw0IiuJLUdW33X7Gp2vOu/FmSBy1kpEhR2cJBpr3IbaTUpIjMXbj/HmH
	ysFOEE53GWEywMjoagvIzdwK4pY=
X-Received: by 2002:a05:7300:6148:b0:36a:7bb7:4609 with SMTP id 5a478bee46e88-37967dd7e1dmr11471490eec.34.1794726811302;
        Sat, 14 Nov 2026 23:13:31 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bad134sm27441185eec.27.2026.11.14.23.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 23:13:30 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Mike Rapoport <rppt@kernel.org>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Andrew Morton <akpm@linux-foundation.org>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, "David S.
 Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>, Donald
 Dutile <ddutile@redhat.com>, Eric Chanudet <echanude@redhat.com>, Heiko
 Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen
 <chenhuacai@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>,
 Liviu Dudau <liviu@dudau.co.uk>, Luis Chamberlain <mcgrof@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Nadav Amit
 <nadav.amit@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Peter
 Zijlstra <peterz@infradead.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Russell
 King <linux@armlinux.org.uk>, Sam Ravnborg <sam@ravnborg.org>, Song Liu
 <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner
 <tglx@linutronix.de>, Will Deacon <will@kernel.org>, bpf@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 loongarch@lists.linux.dev, netdev@vger.kernel.org,
 sparclinux@vger.kernel.org, x86@kernel.org, Madhavan Srinivasan
 <maddy@linux.ibm.com>
Subject: Re: [PATCH RESEND v8 11/16] powerpc: extend execmem_params for kprobes allocations
In-Reply-To: <avlTdlK9ErlqVRYl@kernel.org>
Date: Sun, 15 Nov 2026 12:33:31 +0530
Message-ID: <4idi8tks.ritesh.list@gmail.com>
References: <20240505160628.2323363-1-rppt@kernel.org> <20240505160628.2323363-12-rppt@kernel.org> <3f7af771-87a7-4ae7-9919-bc4c23bd31c9@kernel.org> <avlTdlK9ErlqVRYl@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mike Rapoport <rppt@kernel.org> writes:

> Hi Christophe,
>
> On Fri, Nov 13, 2026 at 03:36:01PM +0100, Christophe Leroy (CS GROUP) wro=
te:
>> Hi Mike,
>>=20
>> Looks like I missed this change ...
>>=20

I didn't initially get what Christophe meant here. Then I came across this
reply of from him[1]. So looks like somehow between v3 to v8, something got
changed?=20

    On powerpc book3s/32, vmalloc space is not executable. Only modules=20
    space is executable. X/NX cannot be set on a per page basis, it can onl=
y=20
    be set on a 256 Mbytes segment basis.

    See commit c49643319715 ("powerpc/32s: Only leave NX unset on segments=
=20
    used for modules") and 6ca055322da8 ("powerpc/32s: Use dedicated segmen=
t=20
    for modules with STRICT_KERNEL_RWX") and 7bee31ad8e2f ("powerpc/32s: Fi=
x=20
    is_module_segment() when MODULES_VADDR is defined").

    So if your intention is still to have an executable kprobes, then you=20
    can't use vmalloc address space.

[1]: https://lore.kernel.org/all/1cb41761-29d0-5d33-b7c1-0ca3acaa810d@csgro=
up.eu/

>> Le 05/05/2024 =C3=A0 18:06, Mike Rapoport a =C3=A9crit=C2=A0:
>> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>> >=20
>> > powerpc overrides kprobes::alloc_insn_page() to remove writable
>> > permissions when STRICT_MODULE_RWX is on.
>> >=20
>> > Add definition of EXECMEM_KRPOBES to execmem_params to allow using the
>> > generic kprobes::alloc_insn_page() with the desired permissions.
>> >=20
>> > As powerpc uses breakpoint instructions to inject kprobes, it does not
>> > need to constrain kprobe allocations to the modules area and can use t=
he
>> > entire vmalloc address space.
>>=20
>> Using breakpoint means the segment must still be executable.
>> On book3s/32 VMALLOC segment is not executable, while module segment is.
>>=20
>> See commit 6ca055322da8 ("powerpc/32s: Use dedicated segment for modules
>> with STRICT_KERNEL_RWX")
>>=20
>> See report and fix at https://lore.kernel.org/all/ed03d290d440d579a81ae0=
b7de5243721291d903.1794543909.git.ritesh.list@gmail.com/
>
> I'll take a look, thanks!
>=20=20

Thanks Mike for taking a look. Sorry, I should have ccd'd you there, I
guess I missed it. However, the changes are these one here [2][3]

[2]: https://lore.kernel.org/linuxppc-dev/82c4973addebd82923c460cb44221f5b7=
6146afe.1794572365.git.ritesh.list@gmail.com/
[3]: https://lore.kernel.org/linuxppc-dev/f75f2cf97f44375fd2c8820e0caeab703=
cdb371c.1794572365.git.ritesh.list@gmail.com/

-ritesh


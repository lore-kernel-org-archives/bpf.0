Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02E85C613
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 01:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777082343; cv=none; b=WHheYKM2x7jibsz22YSR6V1PCa9+xVa6C8bMCRnkz+TOOc8aUbjkcLCuw4MGLVhJ8JyRKy8NzrnYPhoVVlzgjocc1FviKkJhVTkErGASx/3jM2VfDqK13jwhjwr/oBFUgWduz4q2fDOM1awAFSGZrRvabbburuw6VWF7LoQHkQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777082343; c=relaxed/simple;
	bh=GoUazX8xRY0dSUZ1wJWsZXrSTH5cbE28tHxVmCoMN9s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NtRoUVFT/xq9/Sr5Kid1BAjhELDFKr5YTW5XW1uTyblCVvjbV5YBZB8FIyvI7N+FKqOveqCPCYi32FZNXQibNMHsIQ1OLhTF821TJcEk4wGU4XZ6jEb8dvj19vdqml6rA7vgPMDl2/r9/PpqMnkQ6lB2DCDeF6CcIQIYA6M5Ihs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USvREqd9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USvREqd9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3A0C19425;
	Sat, 25 Apr 2026 01:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777082342;
	bh=GoUazX8xRY0dSUZ1wJWsZXrSTH5cbE28tHxVmCoMN9s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=USvREqd9lue07f2qW+5VdKZ0VB4KPGKltFvgh2xVdaVMY6IzXrv4AmAjexFHRK993
	 8OW9HVsm4zpbNjKrEdiJcIIp5MQ34eTqSItpWzMIrWbCS2SNLz4lPSmWhA869UvY0J
	 MTaR0YhLZ4vIi7C2b0nZKUqn+lVaAjVF3RC9iCZieydDb0xLK2eNQwTtgByFY3jT2q
	 aUcGQ++60eQneqLMtbuyy5AenIN1uSfaoTg4o9kf4bvqk4uQxhU0GNM1NEtV8AeRsz
	 vMxKEGA1a51e8hnsS1T+V6Ascgr0LP53wTr9dQyLUhKwW9cioHMqFiacEvrrxwQDTd
	 wti7uzdOOaXPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] kallsyms: show function parameter info in oops/WARN
 dumps
Reply-To: sashiko@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260323164858.1939248-2-sashal@kernel.org>
References: <20260323164858.1939248-2-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 01:59:02 +0000
Message-Id: <20260425015902.BD3A0C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 8 potential issue(s):
- [High] Build Tool Infinite Loop / Hash Table Exhaustion
- [Medium] Incorrect Parameter Attribution due to Missing Validation
- [Medium] Missing Architecture Dependency in Kconfig
- [Medium] Misleading Fault Address Highlighting for Non-Page-Fault Excepti=
ons
- [Medium] Conceptual Flaw: Statically Mapping Parameters to Clobbered Regi=
sters
- [Low] Build Error on x86_64 due to Incorrect pt_regs Fields
- [Low] KUnit Test Module Linkage Failure
- [Low] Unused Static Variable Causes Build Warning/Error
--

commit dc18a113b4058bc5d9640e6245bce2e390eeb331
Author: Sasha Levin <sashal@kernel.org>

kallsyms: show function parameter info in oops/WARN dumps

This commit embeds DWARF-derived function parameter name and type
information in the kernel image so that oops and WARN dumps display the
crashing function's register-passed arguments. It adds a build tool to
parse DWARF and stores it in .rodata, gated behind CONFIG_KALLSYMS_PARAMINF=
O.

> diff --git a/init/Kconfig b/init/Kconfig
> index 3e3acfc37be7e..bc1b38458029d 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -2105,6 +2105,27 @@ config KALLSYMS_LINEINFO_MODULES
> =20
>  	  If unsure, say N.
> =20
> +config KALLSYMS_PARAMINFO
> +	bool "Show function parameter info in oops/WARN dumps"
> +	depends on KALLSYMS_LINEINFO

Should this have an architecture dependency (e.g., depends on X86_64)?

The feature appears to be heavily x86-64 specific, hardcoding x86-64
registers and exclusively hooking into arch/x86/kernel/dumpstack.c. Enabling
it on unsupported architectures could inflate the kernel image with unused
tables.

[ ... ]

> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index e6f796d43dd70..af8de3d8e3ba3 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -501,6 +501,174 @@ bool kallsyms_lookup_lineinfo(unsigned long addr,
>  	return lineinfo_search(&tbl, (unsigned int)raw_offset, file, line);
>  }
> =20
> +#ifdef CONFIG_KALLSYMS_PARAMINFO
> +
> +#include <linux/ptrace.h>
> +#ifdef CONFIG_X86
> +#include <asm/special_insns.h>
> +#endif
> +
> +#define MAX_PARAMINFO_PARAMS 6
> +
> +/*
> + * x86-64 calling convention: arguments are passed in registers
> + * RDI, RSI, RDX, RCX, R8, R9 (in that order).
> + */
> +#ifdef CONFIG_X86_64
> +
> +static const char * const paraminfo_reg_names[] =3D {
> +	"RDI", "RSI", "RDX", "RCX", "R8", "R9"
> +};

Is this variable used anywhere? It doesn't seem to be referenced in the fil=
e,
which could trigger a -Wunused-variable compiler warning.

> +
> +static unsigned long paraminfo_get_reg(const struct pt_regs *regs,
> +				       unsigned int idx)
> +{
> +	switch (idx) {
> +	case 0: return regs->di;
> +	case 1: return regs->si;
> +	case 2: return regs->dx;

Will this cause a build error on x86_64? In the 64-bit kernel, the struct
pt_regs defines these fields as rdi, rsi, rdx, etc. rather than di, si, dx.

[ ... ]

> +	func_idx =3D paraminfo_find_func(offset);
> +	if (func_idx < 0)
> +		return;
> +
> +	/*
> +	 * Verify the IP is within a reasonable range of the function
> +	 * start.  paraminfo_func_addrs[] contains function start offsets;
> +	 * check that we're not too far past the start.  Use kallsyms to
> +	 * verify we're in the right function.
> +	 */
> +	if (!kallsyms_lookup_size_offset(ip, &sym_size, &sym_offset))
> +		return;

Does this code verify that the matched paraminfo function actually aligns w=
ith
the faulting function?=20

If the fault occurs in a function without parameters, func_idx will point t=
o=20
the closest preceding function with parameter data. Should there be a check=
=20
such as offset - sym_offset =3D=3D paraminfo_func_addrs[func_idx] to preven=
t=20
printing parameters of the preceding function?

[ ... ]

> +	/* Look up function name for the header */
> +	if (lookup_symbol_name(ip - sym_offset, sym_name))
> +		return;
> +
> +	/*
> +	 * Read the fault address for highlighting.  On x86, CR2 holds
> +	 * the page fault linear address.  On other architectures this
> +	 * would need a different mechanism.
> +	 */
> +#ifdef CONFIG_X86
> +	fault_addr =3D read_cr2();
> +#else

Can this produce misleading highlighting for non-page-fault exceptions?

The x86 CPU updates the CR2 register during a Page Fault, but for other
exceptions such as WARN() or General Protection Faults, CR2 retains the
stale address from the last unrelated page fault.

[ ... ]

> +	for (i =3D 0; i < num_params; i++) {
> +		u32 name_off, type_off;
> +		const char *pname, *ptype;
> +		unsigned long val;
> +		bool is_fault_addr;
> +
> +		memcpy(&name_off, data, sizeof(u32));
> +		data +=3D sizeof(u32);
> +		memcpy(&type_off, data, sizeof(u32));
> +		data +=3D sizeof(u32);
> +
> +		pname =3D paraminfo_strings + name_off;
> +		ptype =3D paraminfo_strings + type_off;
> +		val =3D paraminfo_get_reg(regs, i);

Could these caller-saved registers contain clobbered values?

Since exceptions typically occur mid-function, the compiler might have free=
ly
clobbered these registers to hold local variables or intermediate state,
which could lead to garbage values being displayed instead of the original
parameters.

[ ... ]

> diff --git a/lib/tests/paraminfo_kunit.c b/lib/tests/paraminfo_kunit.c
> new file mode 100644
> index 0000000000000..e09efc4ddeb0e
> --- /dev/null
> +++ b/lib/tests/paraminfo_kunit.c
> @@ -0,0 +1,256 @@
> +// SPDX-License-Identifier: GPL-2.0

[ ... ]

> +/*
> + * These access the raw paraminfo tables to verify correctness.
> + * The tables are defined in kernel/kallsyms_internal.h.
> + */
> +extern const u32 paraminfo_num_funcs;
> +extern const u32 paraminfo_func_addrs[];
> +extern const u32 paraminfo_func_offsets[];
> +extern const u8  paraminfo_func_data[];
> +extern const char paraminfo_strings[];

Can this test be built as a loadable module?=20

CONFIG_PARAMINFO_KUNIT_TEST is a tristate config, but the test directly=20
references internal unexported tables. Building it as a module might fail=20
with undefined symbol errors during the modpost stage.

[ ... ]

> diff --git a/scripts/gen_paraminfo.c b/scripts/gen_paraminfo.c
> new file mode 100644
> index 0000000000000..ea1d23f3ddd9a
> --- /dev/null
> +++ b/scripts/gen_paraminfo.c

[ ... ]

> +static unsigned int find_or_add_string(const char *s)
> +{
> +	unsigned int h =3D hash_str(s);
> +
> +	while (str_hash[h].str) {
> +		if (!strcmp(str_hash[h].str, s))
> +			return str_hash[h].idx;
> +		h =3D (h + 1) & (STR_HASH_SIZE - 1);
> +	}

Could this loop permanently hang the kernel build process?

The STR_HASH_SIZE is 16,384, but a typical kernel has around 58k functions.
If the number of unique parameter names and types exceeds 16,384, the hash
table will become completely full and this while loop will never find an=20
empty slot.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260323164858.1939=
248-1-sashal@kernel.org?part=3D1

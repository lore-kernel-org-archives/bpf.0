Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6688010785
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 02:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777083356; cv=none; b=ixEHTId9jTollz65ypEugI1l+SRfg1UwvTki5s2xx33MVPV+DIV4lqEZDg3qNHYD+EOSBMORb6lxa0pdgbYOPo/1NzWifKMjYOw+Aa/cZnA9uBhPSVmjPpQsuREYQpTW8AsqaZ6ObN/u31YmCd6EwV0l9a96BWaEMpTdJ0PanpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777083356; c=relaxed/simple;
	bh=E6dGwake8WZV9YtCBHq9SKBevRBIuhlxh1lMuFFDhhk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FhYUYcdOyarsBfo5FSWZeAfSEpnMSd7cgnoOHl3c8a2ggD780QfpFm1PHBOgZ9K42eFaTxFSbUzn7FcLAtsIICStmi4iUQt974OJK2hWVQ3YiymnkzMgfKI6R/3jU41pYf/W4QVeJDBnUAmlBq9QkGDzObuMzy2nYMU2CcSIf44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZX5fe9vl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZX5fe9vl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9BBC19425;
	Sat, 25 Apr 2026 02:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777083356;
	bh=E6dGwake8WZV9YtCBHq9SKBevRBIuhlxh1lMuFFDhhk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ZX5fe9vl+7gVsAo39NWdwU03asKdkuoHYxF6rrvqqVRkz3Bwjpg0JdSPj9HqRnCcz
	 NpanYk25opdGK8jo8ceFEjJG28RlqisohPvBGufuHgKdQxWrqx/sx7XiduHd0Jq+BK
	 MHvP0CIZ/cc6IFqz9So91vjW0dtUDDKpGLxZ4Oj4ng9Z93r0uO9yhvDalPAyoHedzT
	 ocdH30Gddq8dsBBM0RcFnI6I9D+wyr6URNw6Us6mblqyUmj7EapC2Ajs2HtnPJ8MW2
	 QR+Yl6rJQC/ZqFaEJuy6rIhy63aOCtvtuIX5KGGU18X7hFwnlJDE5H+ONNyPugPrUa
	 OAWlZGwCLE5Gg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] kallsyms: add BTF-based deep parameter rendering in
 oops dumps
Reply-To: sashiko@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260323164858.1939248-3-sashal@kernel.org>
References: <20260323164858.1939248-3-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 02:15:55 +0000
Message-Id: <20260425021555.DA9BBC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 7 potential issue(s):
- [High] Unsynchronized static buffers cause data corruption and KASAN out-=
of-bounds reads in concurrent WARN() context.
- [High] `dwarf_attr_integrate` incorrectly skips function definitions, bre=
aking paraminfo generation.
- [High] Out-of-bounds array read in BTF string coalescing logic.
- [High] Stack buffer overflow risk due to truncated `sym_name` buffer.
- [Medium] `extract_struct_name` silently fails on `const` and `volatile` q=
ualified struct pointers.
- [Medium] Spurious parameter info shown for module functions due to 32-bit=
 truncation hash collisions.
- [Low] Unresolved symbol link errors if KUnit test is built as a module.
--

commit dc1b9fb23e8dd955bb821b603ed59ecf1ae219f5
Author: Sasha Levin <sashal@kernel.org>

kallsyms: add BTF-based deep parameter rendering in oops dumps

This patch adds BTF-based deep rendering for struct pointer parameters in o=
ops
and WARN dumps. It introduces paraminfo_btf_show_ptr() to safely format BPF
data and updates the kallsyms logic to invoke this rendering for pointer
types.

> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -586,13 +586,13 @@ void kallsyms_show_paraminfo(struct pt_regs *regs)
>  	const u8 *data;
>  	unsigned int num_params, i;
>  	unsigned long ip, fault_addr;
> -	char sym_name[KSYM_NAME_LEN];
> +	char sym_name[128];
>  	unsigned long sym_size, sym_offset;

KSYM_NAME_LEN can be configured to larger values than 128 (e.g., 512 for
Rust symbol support via CONFIG_KALLSYMS_MAX_NAME_LEN). If this buffer is
passed to kallsyms APIs that write up to KSYM_NAME_LEN bytes, could this
cause a stack buffer overflow during an oops dump?

[ ... ]

> @@ -611,14 +611,23 @@ void kallsyms_show_paraminfo(struct pt_regs *regs)
>  		return;
> =20
>  	/*
> -	 * Verify the IP is within a reasonable range of the function
> -	 * start.  paraminfo_func_addrs[] contains function start offsets;
> -	 * check that we're not too far past the start.  Use kallsyms to
> -	 * verify we're in the right function.
> +	 * Verify the paraminfo entry actually matches the function
> +	 * containing the IP.  Without this, if the faulting function
> +	 * has no paraminfo, the binary search silently returns the
> +	 * preceding function's entry =E2=80=94 showing wrong parameter info.
>  	 */
>  	if (!kallsyms_lookup_size_offset(ip, &sym_size, &sym_offset))
>  		return;
> =20
> +	{
> +		unsigned int func_start_offset;
> +
> +		func_start_offset =3D (unsigned int)(ip - sym_offset -
> +						   (unsigned long)_text);
> +		if (paraminfo_func_addrs[func_idx] !=3D func_start_offset)
> +			return;
> +	}
> +

For an instruction pointer within a kernel module, the memory distance
from the core _text section can exceed 4GB on 64-bit architectures where
modules reside in vmalloc space.

Will casting this distance to a 32-bit integer truncate the upper bits? If
the truncated value coincidentally matches a valid entry in
paraminfo_func_addrs, could this incorrectly display parameter info for a
completely unrelated vmlinux function?

> diff --git a/kernel/kallsyms_paraminfo_btf.c b/kernel/kallsyms_paraminfo_=
btf.c
> --- /dev/null
> +++ b/kernel/kallsyms_paraminfo_btf.c
> @@ -0,0 +1,267 @@
[ ... ]
> +static const char *extract_struct_name(const char *type_str, bool *is_un=
ion,
> +				       char *name_buf, size_t bufsz)
> +{
> +	const char *p, *end;
> +
> +	*is_union =3D false;
> +
> +	/* Must end with " *" to be a pointer */
> +	end =3D type_str + strlen(type_str);
> +	if (end - type_str < 3 || end[-1] !=3D '*' || end[-2] !=3D ' ')
> +		return NULL;
> +
> +	if (!strncmp(type_str, "struct ", 7)) {
> +		p =3D type_str + 7;
> +	} else if (!strncmp(type_str, "union ", 6)) {

The extract_struct_name() function checks for "struct " at the very
beginning of the string. Since gen_paraminfo.c generates strings with
qualifiers for pointers like "const struct file *", won't this strict
comparison fail on qualified strings and silently bypass BTF rendering?

[ ... ]

> +void paraminfo_btf_show_ptr(unsigned long ptr_val, const char *type_str)
> +{
> +	static char buf[BTF_SHOW_BUF_LEN];
> +	char sname[64];

[ ... ]

> +#define MAX_COALESCED 8
> +		{
> +			static char coalesced[MAX_COALESCED][128];
> +			int ci =3D 0, i;

The comment states this is safe because oops context is effectively
single-threaded. However, since this function is also invoked during
WARN() dumps, and WARN() does not stop other CPUs, couldn't multiple
CPUs hit warnings and execute this code simultaneously?

Will concurrent lockless modifications to these static arrays cause data
races, garbled output, and potential out-of-bounds memory accesses if
null terminators are overwritten mid-read?

[ ... ]

> +				/* Gather chars from subsequent lines */
> +				for (j =3D i + 1; j < nlines &&
> +				     spos < (int)sizeof(coalesced[0]) - 2; j++) {
> +					char *s =3D lines[j];
> +
> +					if (s[0] =3D=3D '\'' && s[2] =3D=3D '\'' &&
> +					    (s[3] =3D=3D '\0' || s[3] =3D=3D ',')) {
> +						coalesced[ci][spos++] =3D s[1];
> +						lines[j] =3D "";

This evaluates s[2] and s[3] without validating the string's length. If
the parsed string is a single character (e.g., s[0] =3D=3D '\'' and
s[1] =3D=3D '\0'), won't this read past the null terminator?

If this short string is located at the very end of the buf array, will
evaluating s[2] read past the global array's bounds and trigger a KASAN
out-of-bounds read?

> diff --git a/lib/tests/paraminfo_kunit.c b/lib/tests/paraminfo_kunit.c
> --- a/lib/tests/paraminfo_kunit.c
> +++ b/lib/tests/paraminfo_kunit.c
> @@ -7,7 +7,8 @@
>   * Verifies that the paraminfo tables correctly map function addresses
>   * to their parameter names and types.
>   *
> - * Build with: CONFIG_PARAMINFO_KUNIT_TEST=3Dm (or =3Dy)
> + * Build with: CONFIG_PARAMINFO_KUNIT_TEST=3Dy (must be built-in; parami=
nfo
> + * tables are vmlinux-only, so module test functions won't be found)
>   */

This isn't a bug, but the comment notes this test must be built-in
because it relies on unexported vmlinux-only symbols.

If there is no corresponding Kconfig dependency enforced, could
configuring the test as a module cause the build to fail with undefined
reference errors during modpost?

> diff --git a/scripts/gen_paraminfo.c b/scripts/gen_paraminfo.c
> --- a/scripts/gen_paraminfo.c
> +++ b/scripts/gen_paraminfo.c
> @@ -341,6 +384,12 @@ static void process_dwarf(Dwarf *dwarf, unsigned lon=
g long text_addr)
[ ... ]
>  			/* Skip declarations (no body) */
> -			if (dwarf_attr(&child, DW_AT_declaration, &attr))
> +			if (dwarf_attr_integrate(&child, DW_AT_declaration, &attr))
>  				continue;

For a function definition that was prototyped elsewhere, the definition
DIE contains a DW_AT_specification attribute pointing to its declaration
DIE.

Because dwarf_attr_integrate resolves attributes through the
specification chain, won't it locate DW_AT_declaration on the
declaration DIE and evaluate to true?

Could this inadvertently cause the script to skip almost all exported
kernel function definitions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260323164858.1939=
248-1-sashal@kernel.org?part=3D2

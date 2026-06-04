Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C51D3C343B
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 21:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780609341; cv=none; b=n01HL8YLnv406fNEhtADaw3/k570y2afZfRQFPWgSDBQ13ro+lu0JWETmJZYCOAFr6VbjoXil1lMWUj1OWRKPZ6V6TU3vUwCbXCTlVmT1rI+QBi7b8daLqprxhTZ0Z+cWUmrnrbyjOrAOoaoPKc11EiJoZ1V0c2bySkvN5zHq1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780609341; c=relaxed/simple;
	bh=x0nl6ueFG+DwmcAz7es/Bey+UU4mZn90Dwx73mYVx3w=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OiylhnHQcym/uKgDoPd/Z1H37zhzjamIdT+QBYHyJo2eR/lQSJ01g4AnLtl49J/RbFA+7mgqWPAeg81hvucy36H8Ux8NSE7BMLv8sxwktKdDAeLerwl1nL899lifmZZ8NSaFOO1vfLWVXfy0D2c6zaWtfAxvAwmdwd+amYJIttY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7t5+JuH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7t5+JuH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD151F00893
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 21:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780609340;
	bh=uLvK846d4YVimJxvHAIbmEvlOvrh+NGqGQxU5zh/XUs=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=L7t5+JuHXSKUtEO2vXkgcRIXyxU5kdBLlt3CIOA3K/Hk0gEGTEPGXi3PnixxDOIjl
	 813NmBhceRM47WRFkj4kct77as7MpseJyDwQh80gqYpHuMpnvh0m6ZAZj5g6InCDSL
	 ShTGk9v00nO8L9Bb9Rd46ne1A/yBdeN65jd2XLbs1uj4TX0b0MtcE7cehO+EEcphhv
	 Af+WOUWnZCEYKTP0pMuEog/nL23RX9UvtgKI6pzGRGl4AHGJrIgihHgHDqbOQRzKE+
	 1rHlJEogGFKU2Kh83cZTdu0m3voks64+PtDu9M40KHZOuQP1BPQfasOXRpmhpwTDSw
	 78PVm3z3GLm8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 8/8] selftests/bpf: add tests to validate
 KASAN on JIT programs
Reply-To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
In-Reply-To: <20260604-kasan-v2-8-c066e627fda8@bootlin.com>
References: <20260604-kasan-v2-8-c066e627fda8@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 21:42:19 +0000
Message-Id: <20260604214219.CBD151F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] Double poison instead of unpoison corrupts KASAN state
- [High] Test fails reliably on default configurations due to disabled KASA=
N multi-shot
- [Medium] Insufficient read buffer size for /dev/kmsg causes test failure
- [Medium] Uninitialized context program name leads to weakened log validat=
ion
- [Medium] Missing file descriptor validation for manual program lookup
- [Low] Multi-line comments violate the BPF subsystem comment style guideli=
nes
--

commit 79343bf831cb7ab53c164d28efe25516ad5dc27f
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>
Date:   Thu Jun 4 20:22:06 2026 +0000

    selftests/bpf: add tests to validate KASAN on JIT programs
   =20
    Add a basic KASAN test runner that loads and test-run programs that can
    trigger memory management bugs. The test captures kernel logs and ensure
    that the expected KASAN splat is emitted by searching for the
    corresponding first lines in the report, hence validated that the needed
    instrumentation has been inserted by the JIT compiler before the
    relevant memory accesses.

> diff --git a/tools/testing/selftests/bpf/prog_tests/kasan.c b/tools/testi=
ng/selftests/bpf/prog_tests/kasan.c
> new file mode 100644
> index 0000000000000..adf61e230ec98
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/kasan.c

[ ... ]

> +static int read_kernel_logs(int fd, char *buf, size_t max_len)
> +{
> +	char record[512];
> +	size_t total =3D 0;
> +	ssize_t n;
> +
> +	buf[0] =3D '\0';
> +	while (1) {
> +		char *msg, *eol;
> +		size_t len;
> +
> +		n =3D read(fd, record, sizeof(record) - 1);

[Severity: Medium]
Can this buffer be too small for KASAN reports?

If a kernel log message, including its priority, sequence, timestamp, and
facility metadata, exceeds 511 bytes, the kernel's devkmsg_read()
implementation will return -EINVAL.

This causes the read() syscall to fail, which in turn causes the
ASSERT_GE() macro checking the return value to fail and abort the test.
Kernel logs, particularly long KASAN bug reports or concurrent stack traces,
can easily exceed this limit.

> +		if (n < 0) {
> +			if (errno =3D=3D EAGAIN)
> +				break;
> +			return n;
> +		}
> +		record[n] =3D '\0';
> +
> +		/* Each kmsg record starts with some metadata, separated
> +		 * from the actual content by a semi-colon
> +		 */

[Severity: Low]
This isn't a bug, but the BPF subsystem guidelines require the opening block
comment marker to be on its own line for multi-line comments.

[ ... ]

> +static int check_kasan_report_in_kernel_logs(char *buf, struct test_ctx =
*ctx,
> +					     bool is_write, int size)
> +{
> +	char *access_desc_start, *access_desc_end, *tmp;
> +	char access_log[READ_CHUNK_SIZE];
> +	char *kasan_report_start;
> +	int nsize;
> +
> +	snprintf(access_log, READ_CHUNK_SIZE, KASAN_PATTERN_SLAB_UAF,
> +		 ctx->prog_tag[0], ctx->prog_tag[1], ctx->prog_tag[2],
> +		 ctx->prog_tag[3], ctx->prog_tag[4], ctx->prog_tag[5],
> +		 ctx->prog_tag[6], ctx->prog_tag[7], ctx->prog_name);

[Severity: Medium]
Will this properly match the full program name?

In run_subtest_with_size_and_location(), the program name is stored in a
local variable but never copied into ctx->prog_name. Since ctx is allocated
with calloc(), ctx->prog_name remains an empty string.

This causes snprintf to format the string with an empty program name,
weakening the validation as it will only search for the tag instead of the
fully qualified tag and program name.

> +	/* Searched kasan report is valid if
> +	 * - it contains the expected kasan pattern
> +	 * - the next line is the description of the faulty access
> +	 * - faulty access properties match the tested type and size
> +	 */

[Severity: Low]
This isn't a bug, but the opening block comment marker should be on its own
line to follow BPF subsystem styling rules.

[ ... ]

> +static void run_subtest_with_size_and_location(struct test_ctx *ctx,
> +					       struct test_spec *test,
> +					       int access_size,
> +					       bool on_stack)
> +{

[ ... ]

> +	ctx->prog =3D bpf_object__find_program_by_name(ctx->skel->obj, prog_nam=
e);
> +	if (!ASSERT_OK_PTR(ctx->prog, "find test prog"))
> +		return;
> +
> +	info_len =3D sizeof(info);
> +	memset(&info, 0, info_len);
> +	ret =3D bpf_prog_get_info_by_fd(bpf_program__fd(ctx->prog), &info,

[Severity: Medium]
Is it safe to use bpf_program__fd() directly without validating it is >=3D =
0?

Although the skeleton is successfully loaded, the BPF subsystem guide requi=
res
explicit file descriptor checks when using manual lookups such as
bpf_object__find_program_by_name() before using the fd.

[ ... ]

> +static struct test_spec tests[] =3D {

[ ... ]

> +	{
> +		.prog_type =3D "ldx_patched",
> +		.is_write =3D false,
> +		.skip_multi_size_testing =3D true,
> +		.skip_on_stack_testing =3D true,
> +		.run_size =3D 4,
> +		/* Make the verifier patch instruction to test
> +		 * adjust_insn_aux_data logic
> +		 */

[Severity: Low]
This isn't a bug, but the opening block comment marker should be on its own
line to follow BPF subsystem styling rules.

[ ... ]

> +void test_kasan(void)
> +{

[ ... ]

> +	for (i =3D 0; i < ARRAY_SIZE(tests); i++) {
> +		test =3D &tests[i];
> +		run_subtest(ctx, test);
> +	}

[Severity: High]
Will the tests after the first one fail to capture a KASAN report?

By default, KASAN only prints a bug report for the first invalid memory
access. Subsequent invalid accesses are suppressed unless the kernel is
booted with the kasan_multi_shot command-line parameter.

Since the test suite does not enable multi-shot at runtime or check for its
presence, the first subtest will generate a report and pass, but all
subsequent subtests will fail because KASAN will not print the expected
reports in standard test environments.

> +
> +close:
> +	close(ctx->klog_fd);
> +destroy:
> +	kasan__destroy(ctx->skel);
> +end:
> +	free(ctx);
> +}

> diff --git a/tools/testing/selftests/bpf/progs/kasan.c b/tools/testing/se=
lftests/bpf/progs/kasan.c
> new file mode 100644
> index 0000000000000..670318a956a44
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/kasan.c

[ ... ]

> +SEC("tcx/ingress")
> +int stx_on_stack(struct __sk_buff *skb)
> +{
> +	struct kasan_write_val val;
> +
> +	bpf_kfunc_kasan_poison(&val, sizeof(struct kasan_write_val));
> +	switch (access_size) {
> +	case 1:
> +		val.data_1 =3D access_size;
> +		break;
> +	case 2:
> +		val.data_2 =3D access_size;
> +		break;
> +	case 4:
> +		val.data_4 =3D access_size;
> +		break;
> +	case 8:
> +		val.data_8 =3D access_size;
> +		break;
> +	}
> +	bpf_kfunc_kasan_poison(&val, sizeof(struct kasan_write_val));

[Severity: High]
Does this code inadvertently call bpf_kfunc_kasan_poison() again instead of
unpoisoning?

Leaving the task's stack memory permanently poisoned in the KASAN shadow map
will cause subsequent stack usage by the kernel, such as interrupts or
function calls, to trigger spurious KASAN stack-out-of-bounds or
use-after-free panics.

> +	return 0;
> +}
> +
> +SEC("tcx/ingress")
> +int stx_not_on_stack(struct __sk_buff *skb)
> +{
> +	struct kasan_write_val *val;
> +	__u32 key =3D 0;
> +
> +	val =3D bpf_map_lookup_elem(&test_map, &key);
> +	if (!val)
> +		return 0;
> +
> +	bpf_kfunc_kasan_poison(val, sizeof(struct kasan_write_val));
> +	switch (access_size) {
> +	case 1:
> +		val->data_1 =3D access_size;
> +		break;
> +	case 2:
> +		val->data_2 =3D access_size;
> +		break;
> +	case 4:
> +		val->data_4 =3D access_size;
> +		break;
> +	case 8:
> +		val->data_8 =3D access_size;
> +		break;
> +	}
> +	bpf_kfunc_kasan_poison(val, sizeof(struct kasan_write_val));

[Severity: High]
Is this also meant to be bpf_kfunc_kasan_unpoison()?  Leaving the map value
poisoned corrupts the KASAN state for future accesses to this map element.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604-kasan-v2-0=
-c066e627fda8@bootlin.com?part=3D8

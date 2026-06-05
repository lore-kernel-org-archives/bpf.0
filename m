Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347CF3FF885
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 06:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641760; cv=none; b=MqQOFyCdshBW4TwzjhkDBdQ0xH1DmJYtHtiYInv6n0mvskOz2uU3R+eZCsftT7imeARavIp2CPZwqYeStWmC4ITWV4S4G2aOHmkePprJkJPggmiA5/yFTgfsyEZKwlHt/6inF/fQnfv3nV8pvv8o75iVeyCNLMsOpIb++ucl538=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641760; c=relaxed/simple;
	bh=ngxwbEBsfOd1wrc2sKi8eSDaPxgAv0Wox66T/y8CQNc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iFg268Yu7w/uz9951sk5dz0LOLmByNTRve2Ky1fFWx52xpKEhc+vXKRwVv0FekMbJ33HWDchWGXVQhxzZn3pYTnWeKPsP8OzarECna4DDtdkkUobkJd1ZjpOiFZyoJgF2XYSFXunk67nEdvVDH+j981nxVpn4e7vVDNWJTYQgHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I52oYjzA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I52oYjzA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA12F1F00893;
	Fri,  5 Jun 2026 06:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780641758;
	bh=phSShjfjKkYpYApKYE7fJLBn8G/ks2by0eBAQu2Uibw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I52oYjzA6lYiMLXOa+R0n5ut0Mn+250hpFZuW3FhD7lWFJx9IiDTM9u2FX4EpaWrU
	 x3g/5dHC3gRSBKHlMXsERvauC5JTLvmAFWy5n2nxEOIA7YBFKd0hkEawtdE7IdwMvy
	 hUwEs9sOpYhmXlnDcnMOYcOqZewexkD2Edyd6ZI3We+jCUCIdyfw3ZMHmgD/K8Ydle
	 EMPlFlhJFFvbGhmfJDhzYUUsD1S/AhQ/GSSAp+RfTrFHOB+ZWvzw1tOquZ3wPlXPzr
	 t++yJNfxsKmFm05+7Rik7/ZK6jRtpxexc38L5+NRypYtg4B4FhWiYVopNXTNxYg7S0
	 bh7wwAkVM74Dw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 01/17] bpf: Add verifier diagnostics report
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260605063412.974640-2-memxor@gmail.com>
References: <20260605063412.974640-2-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 06:42:38 +0000
Message-Id: <20260605064238.AA12F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] High stack consumption in verifier diagnostic helper functions.
- [Low] Premature line wrapping when a word exactly fits the column width.
--

commit aa805d573ef7f7f7b9f1f0f42ddae783a0fb2690
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Add verifier diagnostics report helpers

Add a small diagnostics renderer for verifier reports and wire it into the
BPF build. The initial helpers emit the common text structure: a failure
header plus reusable report sections.

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> new file mode 100644
> index 0000000000000..a6684adc0c313
> --- /dev/null
> +++ b/kernel/bpf/diagnostics.c
[ ... ]
> +static void bpf_diag_print_wrapped_prefixed(struct bpf_verifier_env *env,
> +					    const char *first_prefix,
> +					    const char *next_prefix,
> +					    const char *text)
> +{
[ ... ]
> +		while (line[len] && line[len] !=3D '\n' && len < text_width) {
> +			if (line[len] =3D=3D ' ')
> +				last_space =3D len;
> +			len++;
> +		}
> +
> +		if (line[len] && line[len] !=3D '\n' && last_space > 0)
> +			len =3D last_space;

[Severity: Low]
Does this cause premature line wrapping when a word exactly fits the column
width?

If line[len] is a space where len equals text_width, the condition
line[len] !=3D '\n' evaluates to true, forcing len to revert to last_space.

This prevents the full word from utilizing the available line width.

[ ... ]
> +static void bpf_diag_vprint_indented(struct bpf_verifier_env *env,
> +				     const char *fmt, va_list args)
> +{
> +	char buf[1024];

[Severity: High]
Does this risk a kernel stack overflow?

A 1024-byte local buffer is allocated on the stack here. Coupled with the
512-byte problem_buf in bpf_diag_report_header(), and large allocations in
other diagnostic functions like bpf_diag_report_source() (over 1.3KB) and
bpf_diag_print_source_annotation() (768 bytes), the total stack consumption
in a single call chain can exceed 2KB.

Could these large stack buffers lead to stack overflow panics in the
deeply-nested BPF verifier?

> +
> +	if (!bpf_verifier_log_needed(&env->log))
> +		return;
> +
> +	vscnprintf(buf, sizeof(buf), fmt, args);
> +	bpf_diag_print_wrapped_text(env, buf);
> +}
> +
> +void bpf_diag_report_header(struct bpf_verifier_env *env,
> +			    const char *category, const char *problem)
> +{
> +	char problem_buf[BPF_DIAG_MSG_LEN];

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605063412.9746=
40-1-memxor@gmail.com?part=3D1

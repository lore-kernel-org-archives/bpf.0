Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6843733E348
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788173761; cv=none; b=IxY46ctu+OEFZz0okSTZGKTOZKUPp2RUCtozA8cQctLPRizke023J0HSIhPweX+L1FoMYhV/ndseBMeVL2C74nvFdSQLSP5b6TLgcGpZmuBtMdAUT9iuM8mNdkvsJNqanBmUP5HR2LoXbAbIrrGlDRhVqCcqThm3RyyOuZfhDtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788173761; c=relaxed/simple;
	bh=h9iZJDzDYl6S7KqCFx+cnWAJ7o8xcoGNsjEUAMfWTDk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dqmYMQzLiUQuqMHrpqECJKaQKsI/wsJOPTefS+kpVbyGdH8C7bMwF6pDrvqAp0QPgPMd+cvEqMIEhHAIUwIJHFNQa3jm552uzaz/8fRBQ3x2fnek3Yt9ljHaeO6OnRDYKATyI+K9aNz4oY8nVXr6LxG7qmNFcUKMnawZ9CANW6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1eTG3bt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1eTG3bt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E271F000E9;
	Mon, 31 Aug 2026 10:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788173760;
	bh=NRny87ZCCI+q5rz4mKO5w1SQifOQv0JJgK+T/D4Th84=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f1eTG3btoVcrxF96a71Bo3ZsQWPH+ik9h5K6QuT//5qDHYy5OpU3Rgf9q5mUA5ghy
	 Uoct3xr8CKrEygofKozBn8idzdtifO82r2VgvGH8xb9Bn3DiMXrda9ON18G6Xlsw8Z
	 w+nPH1sNCT/AN+HUfpUL2RWgByGYBHE86rSUJWTEFhR8n+BpHQec2y8E5Sw2xdhJkS
	 X5Z6dFNoW9c20jrc8zmCXpnqc1PLnhkhJQI9JglItJKxXbqOhMp+S9jTlMMSkaG66m
	 0FU+IfY50UwLjkffgIIR7sKyXV2zZBprFUKEgI+lynOndYQCQnFGgCjyfXKAJ3OWr+
	 mM2eIGEVX108A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 5/7] selftests/bpf: Cover trusted-or-null
 BTF pointer reads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anastasios Papagiannis" <tasos.papagiannnis@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260831092305.42062-6-tasos.papagiannnis@gmail.com>
References: <20260831092305.42062-1-tasos.papagiannnis@gmail.com>
 <20260831092305.42062-6-tasos.papagiannnis@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 10:55:59 +0000
Message-Id: <20260831105559.E8E271F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Tests for atomic RMW operations and BPF_LOAD_ACQ on trusted-or-n=
ull pointers are missing, despite the commit message claiming they are veri=
fied.
- [Low] Multi-line comment opening '/*' is not on its own line, violating B=
PF subsystem guidelines.
--

commit a8459550255e4dfc12584cd94a1820a3e538fba1
Author: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>

selftests/bpf: Cover trusted-or-null BTF pointer reads

This commit updates verifier tests for unchecked trusted-or-null BTF pointer
dereferences and adds tests covering scalar reads and chained reads. It also
adds runtime tests to verify that non-NULL reads return the field value whi=
le
NULL reads return zero.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe=
_null.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null=
.c
> --- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
> @@ -19,15 +19,15 @@ static void maybe_null(void)
>  	struct_ops_maybe_null__destroy(skel);
>  }
> =20
> -/* Test that the verifier rejects a program that access a nullable point=
er
> - * without a check beforehand.
> +/* Test that the verifier accepts a fault-protected read through a nulla=
ble
> + * trusted pointer without an explicit NULL check.
>   */

[Severity: Low]
This is not a bug, but does this follow the BPF subsystem comment guideline=
s?
The guidelines require multi-line comments to have the opening /* on its own
line, rather than keeping the text on the same line as the opening characte=
rs.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c b/t=
ools/testing/selftests/bpf/progs/test_tp_btf_nullable.c
> --- a/tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c
> +++ b/tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c
[ ... ]
> +SEC("tp_btf/bpf_testmod_test_nullable_bare_tp")
> +__failure __msg("pointer arithmetic on trusted_ptr_or_null_ prohibited")
> +int BPF_PROG(handle_tp_btf_nullable_arith, struct bpf_testmod_test_read_=
ctx *nullable_ctx)
> +{
> +	asm volatile("%[ctx] +=3D 1" : [ctx] "+r"(nullable_ctx));
> +	return nullable_ctx->len;
> +}

[Severity: Medium]
The commit message states that the tests verify that atomic RMW operations
and BPF_LOAD_ACQ accesses remain prohibited. Does this patch actually inclu=
de
those tests? The test for pointer arithmetic is present here in
handle_tp_btf_nullable_arith(), but there do not seem to be any correspondi=
ng
tests for atomic RMW operations or BPF_LOAD_ACQ accesses in this file or
elsewhere in the patch.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831092305.4206=
2-1-tasos.papagiannnis@gmail.com?part=3D5

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90259223DEA
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 20:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677603; cv=none; b=R0RkSXsPndskLBZXp+qWS2xRGPKccIcjwoiE1FPL0SJMrmqHJI471H1gJThij2u363W3pM4PLGVpWPzt8s6tf0tGQ14tY+a4bIXBUAM/foudJPZ+jvNx4XZQJtTahvJRRvUJf+M39GIxKlTvhQo+jBs93yFcx6yeOJqQOxfdh7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677603; c=relaxed/simple;
	bh=W95tfLlunkmYS2UQhXjsMo9/T3pVPgpU1oBeiTC0bJc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hrL9iJxnNowoq6PveoniZCISwFksInR6aJDxWCBPzb6Hw1ci7L4uxCMs4TphhW9hePgTd2+pazbG4RWQGYu7XnGd6kQfDe2XDS4UYJRpIApOPc6eFy3lHPZ8c8ySjQ2RcK2kde+Cewu2oEaDf61Vw2z20pChMhPe+K2CCrMdlLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrvDwVn8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrvDwVn8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024771F000FF;
	Thu, 17 Sep 2026 20:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789677601;
	bh=uIGfICdSdFqic0B6d+uuiOEQJVNZ5Z9FOFYE3msrIgA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QrvDwVn8lcl0HlspOtf5kxlqLaGZcy0d9S9yWolxCisXKeZm7zSDJh8O5lExx+UW0
	 gk9bMFab1mn+NhuUBuwIgmXUMJw/mk0xjcR+eF6uaWH06GO1yBwF1YwvNoS8SRCCg+
	 md4xZP6APL1B7wQ6fJml7z74Mck8L05ihBm3Yj+B9pGql+deJ5PVKfL4eBiR1aBSIt
	 p7Jazx9kSyYTebNL4E34zCXCz3oKnABVSqxPpXn7lN5RHJwlJQbogUdYBFsiytxxeL
	 globajDmUmi3AYdRqW1fHaUg8yAeJRbjVdW707I8rak85TbngpmZFv3pF3Y8xBy6aa
	 NTqlAj+ID5H9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 6/6] selftests/bpf: Cover BPF program manual
 loading
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260917203040.3150212-7-andrey.grodzovsky@crowdstrike.com>
References: <20260917203040.3150212-1-andrey.grodzovsky@crowdstrike.com>
 <20260917203040.3150212-7-andrey.grodzovsky@crowdstrike.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 20:40:00 +0000
Message-Id: <20260917204001.024771F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/bpf: bpf_link leak on assertion error paths in dynamic=
load
--

commit 0fd345ea8ecacebc3bb75a7415c7f51a2637fd25
Author: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>

selftests/bpf: Cover BPF program manual loading

Add dynamicload test covering the manual load/attach/detach/reload
cycle, declarative MANUAL via SEC("!...") and its imperative
override, bpf_object__prepare() alone being sufficient for manual
load, and a deferred load of a module BTF attach target.

> diff --git a/tools/testing/selftests/bpf/prog_tests/dynamicload.c b/tools=
/testing/selftests/bpf/prog_tests/dynamicload.c
> new file mode 100644
> index 0000000000000..979bdc14f4ffd
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/dynamicload.c

[ ... ]

> +static void dynamicload_verify_prepare_only(void)
> +{
> +	struct test_dynamicload *skel;
> +	struct bpf_link *link;
> +	int err;

[ ... ]

> +	link =3D bpf_program__attach(skel->progs.prog4);
> +	if (!ASSERT_OK_PTR(link, "attach_after_prepare"))
> +		goto cleanup;
> +
> +	usleep(1);
> +
> +	if (!ASSERT_TRUE(skel->bss->prog4_called, "prog4_called_after_prepare"))
> +		goto cleanup;

[Severity: Medium]
If this assertion fails, we jump to cleanup which calls
test_dynamicload__destroy(skel). Because test_dynamicload__destroy()
doesn't detach manually loaded programs, does this leak the bpf_link
and its file descriptor by bypassing bpf_link__destroy(link)?

> +
> +	err =3D bpf_link__destroy(link);
> +	if (!ASSERT_OK(err, "link_destroy_after_prepare"))
> +		goto cleanup;
> +
> +	err =3D bpf_program__unload_manually(skel->progs.prog4);
> +	ASSERT_OK(err, "unload_manually_after_prepare");
> +
> +cleanup:
> +	test_dynamicload__destroy(skel);
> +}

[ ... ]

> +void test_dynamicload(void)
> +{
> +	struct bpf_link *link;
> +	struct test_dynamicload *skel;
> +	int err;

[ ... ]

> +	/* load prog3 */
> +	err =3D bpf_program__load_manually(skel->progs.prog3);
> +	if (!ASSERT_OK(err, "load_manually"))
> +		goto cleanup;
> +
> +	/* attach prog3 */
> +	link =3D bpf_program__attach(skel->progs.prog3);
> +	if (!ASSERT_OK_PTR(link, "attach"))
> +		goto cleanup;
> +
> +	usleep(1);
> +
> +	if (!ASSERT_TRUE(skel->bss->prog3_called, "prog3_called"))
> +		goto cleanup;

[Severity: Medium]
Similar to the issue above, if this assertion fails, we jump directly to
cleanup and bypass bpf_link__destroy(link). Could this leak the link resour=
ce
for prog3?

> +
> +	/* detach prog3 as test_dynamicload__destroy doesn't detach manually lo=
aded programs */
> +	err =3D bpf_link__destroy(link);
> +	if (!ASSERT_OK(err, "link_destroy"))
> +		goto cleanup;

[ ... ]

> +	/* reattach prog3 */
> +	link =3D bpf_program__attach(skel->progs.prog3);
> +	if (!ASSERT_OK_PTR(link, "reattach"))
> +		goto cleanup;
> +
> +	usleep(1);
> +
> +	if (!ASSERT_TRUE(skel->bss->prog3_called, "prog3_called_reattach"))
> +		goto cleanup;

[Severity: Medium]
Does this error path also leak the reattached bpf_link when jumping
to cleanup?

> +
> +	/* detach prog3 as test_dynamicload__destroy doesn't detach manually lo=
aded programs */
> +	err =3D bpf_link__destroy(link);
> +	if (!ASSERT_OK(err, "link_destroy_reattach"))
> +		goto cleanup;

[ ... ]

> +	/*
> +	 * run prog4 (declaratively marked) through the same manual
> +	 * load/attach/trigger/detach/unload cycle as prog3
> +	 */
> +	err =3D bpf_program__load_manually(skel->progs.prog4);
> +	if (!ASSERT_OK(err, "prog4_load_manually"))
> +		goto cleanup;
> +
> +	link =3D bpf_program__attach(skel->progs.prog4);
> +	if (!ASSERT_OK_PTR(link, "prog4_attach"))
> +		goto cleanup;
> +
> +	usleep(1);
> +
> +	if (!ASSERT_TRUE(skel->bss->prog4_called, "prog4_called"))
> +		goto cleanup;

[Severity: Medium]
Can jumping to cleanup here leave the prog4 bpf_link leaked as well?

> +
> +	err =3D bpf_link__destroy(link);
> +	if (!ASSERT_OK(err, "prog4_link_destroy"))
> +		goto cleanup;
> +
> +	err =3D bpf_program__unload_manually(skel->progs.prog4);
> +	ASSERT_OK(err, "prog4_unload_manually");
> +
> +	test_dynamicload__destroy(skel);
> +
> +	/* separate scenario: imperative override of the declarative marker */
> +	dynamicload_verify_override();
> +
> +	/* separate scenario: prepare()-only is sufficient for manual load */
> +	dynamicload_verify_prepare_only();
> +
> +	/* separate scenario: deferred manual load with a module BTF attach tar=
get */
> +	dynamicload_verify_module_btf();
> +	return;
> +
> +cleanup:
> +	test_dynamicload__destroy(skel);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917203040.3150=
212-1-andrey.grodzovsky@crowdstrike.com?part=3D6

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AAF2AEF5
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 15:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791644634; cv=none; b=PcrCswhHslBNtiRzV1br15mKrJxAAAGQz4la5r32SRXZ9JaUq7eWjYF6gAMlW761yk5S3owO5ACrwksahVcaJjaaabAgIOJourDu+7BYxHTsGsUMPTj4fJow9BQ1oTGxYbFIX1QIf5M7ipwxXzfypXSgCthLekz0LTd9OjcWtP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791644634; c=relaxed/simple;
	bh=CWamhcfFkBsFN7JZjfyV1gLtaZ26oY+z8andW+rWOP8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=AtPHjsmXkFZkEFPJ1DvKXEUIUUpnHilhsixOyE0bPlFnbuBMxw6PQrcenwHVIOeLoeHPXoNRWM8VxhBDwDFdeGKBgV5kh5UYHOlWNQuTgHcbZn7tXN74kWkbXDZ/pFUaSr39qyC7SiT4ln2ji35JeQmjUhVQyJZyAdmvdp2TyWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4KJ4GtB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4KJ4GtB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D8B1F000FF;
	Sat, 10 Oct 2026 15:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791644633;
	bh=8AMopS3707utGIfbMc1nmVccB5quG/xB52Lp1oenOmo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S4KJ4GtBNYVmQ2Gm6cB3ekTaEf85VkAHm1OgR6IavJRpXTVtwff2KJc5NyDuEObbA
	 u5cgSF1OnLEORroENdhihfxlL1FnTJudH42W61/hD9naOJtTe17XhbAUpha01MaPNJ
	 zrc5IE9jRzCRLTWzmYYoc3Z7gzPLVLqv2E7EzYiSraVwhd0teH5E2yI599CiiKUssR
	 Zdqh/Tv3Q0qolEDZci96hE03EflA5fEZS3HlP2ZpLn50an2HvGLw4hlJkcJhWslWOR
	 uxFr+a9s+9m1qVVxRqMEqIz6tlp3M4goBnrZFLs9V1A0tzIo6dZEEa7uTZA9TU8Vib
	 H89udpeEIdD6A==
Message-ID: <sashiko-outbox-166679@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 6/7] selftests/bpf: Cover BPF program manual
 loading
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261010143156.379864-7-andrey.grodzovsky@crowdstrike.com>
References: <20261010143156.379864-1-andrey.grodzovsky@crowdstrike.com>
 <20261010143156.379864-7-andrey.grodzovsky@crowdstrike.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 15:03:52 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: flaky test due to missing PID filtering and RCU detach delay
--

commit 5554ecac607fedce9b924955d0f276b639ab57c5
Author: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Subject: selftests/bpf: Cover BPF program manual loading

This commit adds a manual load test for BPF programs, covering declarative
and imperative manual load strategies, attach/detach/reload cycles, and a
deferred module BTF attach. It also adds a signed loader test to ensure
that manual programs are rejected when a gen loader object is used.

> diff --git a/tools/testing/selftests/bpf/prog_tests/manual_load.c b/tools=
/testing/selftests/bpf/prog_tests/manual_load.c
> new file mode 100644
> index 0000000000000..e5bdf7e0f04ec
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/manual_load.c

[ ... ]

> +	/*
> +	 * detach prog3 explicitly: its link is kept in a local variable, not in
> +	 * skel->links, so test_manual_load__destroy() has nothing to detach
> +	 */
> +	err =3D bpf_link__destroy(link);
> +	link =3D NULL;
> +	if (!ASSERT_OK(err, "link_destroy"))
> +		goto cleanup;
> +
> +	/* reset the call flag after detach */
> +	skel->bss->prog3_called =3D false;
> +
> +	usleep(1);
> +
> +	ASSERT_FALSE(skel->bss->prog3_called, "prog3_called");

[Severity: Low]
Since tracepoint unregistration uses RCU, could a concurrent syscall on
another CPU trigger the program during the grace period and set
prog3_called to true?

This might cause the test to sporadically fail when run in parallel.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/test_manual_load.c b/tools=
/testing/selftests/bpf/progs/test_manual_load.c
> new file mode 100644
> index 0000000000000..6cdbfc21ca379
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_manual_load.c

[ ... ]

> +/*
> + * disabled at parse time; its attach target is resolved against module
> + * BTF via bpf_program__set_attach_target() before it is switched to
> + * MANUAL and loaded
> + */
> +SEC("?fentry")
> +int BPF_PROG(prog5, struct file *file, struct kobject *kobj,
> +	     const struct bin_attribute *bin_attr, char *buf, loff_t off, size_=
t len)
> +{
> +	prog5_sz =3D len;
> +	return 0;
> +}

[Severity: Low]
Does this tracepoint need PID filtering?

When tests are run in parallel, concurrent tests triggering the testmod read
with different lengths could overwrite prog5_sz, which would fail the length
assertion in the test.

Filtering on the test process's PID (e.g., bpf_get_current_pid_tgid() >> 32
=3D=3D test_pid) might prevent this.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010143156.3798=
64-1-andrey.grodzovsky@crowdstrike.com?part=3D6

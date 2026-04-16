Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EF633688C
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 19:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776369356; cv=none; b=bpX8bJtxlpWLWouVadH6NA8jhvRzykM1E9V1+YzA8zmEgRiLX5YIkbbrJu9qtvBTFo+PEdGxDKry0qB+heFVSQYbP4xOYMD9wmhk8KhQelVtpQXMMwxCZTSsVtQF6Yeon++Gl84fvIoWYC8GddxL1Y0W4qjoTxTAKVPVp8D5IPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776369356; c=relaxed/simple;
	bh=spZAlu2aB0NDR9D7cJgSQ80nNP7vdRYL1t6d5PtW580=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JI3FMzVLonjcX4TXS3zwU249LfrLj7wgOx7PIJbkJycPKOLmLKIxLMIyPX1FrgM6OWOzPJzgxXJ3IVTOoUFhzynxNUwtGmCvpGAOfD/MOl/WnySN7DLJ+mcA+nXfvA7i1q2CzLNqnNORacAE3ye1p4CjOnfkEWWw9hUwX4iKcKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAVZNh6j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAVZNh6j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFD1C2BCAF;
	Thu, 16 Apr 2026 19:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776369355;
	bh=spZAlu2aB0NDR9D7cJgSQ80nNP7vdRYL1t6d5PtW580=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=gAVZNh6j3Tch4LDYty2GHdTOJ1HYvdRi+yTCfn7AH6YQnqVJlHo4/xR7q69xAtWzN
	 7oHYFekKaW2E+z+Vwedk6shmOWhoihI8ywqzGqivkact0NtldHhsffnGQfl46a7RUq
	 baDhrty+hFHzokMRuymcjM/ltVhh4QMYxoHUERihycD82z1EUexq/TpTZvY707wbl3
	 wU+icM8iumz68dIf3Vq0jxFqN0/MHkKTRLVVSktsZTOmB6YmhM1N6aeYJT+PyXqxDS
	 DlglpLXryObLRM+b1ypZsEOz7y7rkcu7+9m/qYelN8IqYB9qjhFLrufaXP2kY7U85d
	 +H9M918hbwoLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 06/11] selftests/bpf: Tolerate test file
 compilation failures
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260416-selftests-bpf_misconfig-v7-6-a078e18012e4@suse.com>
References: <20260416-selftests-bpf_misconfig-v7-6-a078e18012e4@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 19:55:54 +0000
Message-Id: <20260416195555.7FFD1C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Tolerating test compilation failures breaks the build at the linke=
r step.
- [High] Omitting test objects causes the test suite runner to abort at sta=
rtup.
--

commit 3b7eac5b82169326acf885f820b425d42e131d71
Author: Ricardo B. Marli=C3=A8re <rbm@suse.com>

selftests/bpf: Tolerate test file compilation failures

This commit modifies the selftests build system to make per-test compilation
failures non-fatal when permitted. It removes the output object on failure
and skips the post-processing step for missing objects.

> Make the per-test compilation non-fatal: remove the output object on
> failure and print a SKIP-TEST marker to stderr. Guard the BTFIDS
> post-processing step so it is skipped when the object file is absent. The
> linker step will later ignore absent objects, allowing the remaining tests
> to build and run.

Is this description accurate regarding the linker step?

During linking, the Makefile rules pass the literal list of prerequisites to
the compiler. When a compilation fails and the object file is deleted, that
missing file is still passed to the linker.

This causes a fatal "No such file or directory" error that halts the build.

I notice this is addressed later in the series by the patch "selftests/bpf:
Allow test_progs to link with a partial object set", but it causes a build
regression in this specific commit.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index b3eaa4a93707c..5ad50d3ff2f8c 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -708,11 +708,14 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:		=
	\
>  		      $(TRUNNER_TESTS_DIR)/%.c				\
>  		      | $(TRUNNER_OUTPUT)/%.test.d
>  	$$(call msg,TEST-OBJ,$(TRUNNER_BINARY),$$@)
> -	$(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $$=
(LDLIBS) -o $$(@F)
> +	$(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $$=
(LDLIBS) -o $$(@F) $(if $(PERMISSIVE),|| \
> +		($(RM) $$(@F); printf '  %-12s %s\n' 'SKIP-TEST' '$$(notdir $$@)' 1>&2=
))

How does the test suite handle the missing objects at runtime?

The test framework generates the test header by scanning the source files
directly, so a test definition is emitted even if its object file was
skipped.

Because the compiled object is missing, the weak function pointers for that
test resolve to a null pointer during linking. When the test runner validat=
es
these pointers at startup, it prints an error and aborts the entire test
framework setup.

This prevents the remaining tests from running.

I see this is resolved later in the series by the patch "selftests/bpf: Skip
tests whose objects were not built", but it introduces a runtime regression
here.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416-selftests-=
bpf_misconfig-v7-0-a078e18012e4@suse.com?part=3D6

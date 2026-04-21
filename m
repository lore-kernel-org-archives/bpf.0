Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F223CDF76
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 01:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776735092; cv=none; b=mNtsdTTTkhwyGepwGlGJqD4W9szCgoygnuGVsPeZAUWZ9jJl8T2x/VvkhTV9XeYcElQVN+/xvcSAjXSWPEjgblOicambBtbQAmQCNScvQamBMRu39ka+a3dPyfZTL+/mJYUNHWvM6OxWgqB7PbRjCI1aC2k/dluiRNMeAdaMg10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776735092; c=relaxed/simple;
	bh=NisxC+hpohkcoI+wvlQpwTvxtnVy0J9729kxsWX4Zf0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rQj2YxT0fsElNZmuTyWIHR02REmjGxMQiGkVI9EDCt2rrKkNXjJf0ITVdk2GVGJJheNbocZ9rcjCFuBcxDbOY6MUgHGB746YCPjBw5mlavCCkjo3qFXepFcnJJk/+FGmUzgour//65k4VAgV21XFZlq6ym8eDOK3agwLW962uwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLYMmJX8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLYMmJX8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80787C19425;
	Tue, 21 Apr 2026 01:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776735091;
	bh=NisxC+hpohkcoI+wvlQpwTvxtnVy0J9729kxsWX4Zf0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=hLYMmJX8yIDsUaNx7QFc4eI5WULmzKg8nipOWeu6B8PmGXOIgEAGTtn+32a5oecPq
	 mS4wv/ven3xYAWBG/HRGI77WtAKHfSipbRiuNxwQX5Nj5z+FsZ79RofuGlSK3egRFf
	 XgjXrrnIroDoeqEOqCoFOxA+CzsdHepHfiYPs1BhCBdpwdEctmh7Mt7OFWmWK9j/AS
	 czsSWvzNk4ExACIB50KZg+4FpOX47+WEw6dXrjCXtdHKs0bhEzYIfHLJ5GAqoRnD5t
	 EZwkzeNfYhUZ83Tu1bU/pnXMU4OMzFt+hVPiIjwUqKkA7TB7yeG2XTFfIR0iJa+bmq
	 XcEGAmojDDvOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add test for map-stored
 struct file kptrs
Reply-To: sashiko@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260420203306.3107246-3-utilityemal77@gmail.com>
References: <20260420203306.3107246-3-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 01:31:30 +0000
Message-Id: <20260421013131.80787C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Wrapping `RUN_TESTS()` inside `test__start_subtest()` breaks subte=
st filtering and creates dummy subtests.
- [Low] Zombie process leak if an error occurs before `waitpid()`.
--

commit a0fbd925d86bff9e8b40a48dc8cff998dbbb50fc
Author: Justin Suess <utilityemal77@gmail.com>

selftests/bpf: Add test for map-stored struct file kptrs

This commit adds tests for map-stored referenced struct file pointers. It
verifies that the file reference remains valid after the original file
descriptor is closed, and checks that unreferenced struct file pointers are
rejected by the verifier.

> diff --git a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr_file.=
c b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr_file.c
> new file mode 100644
> index 0000000000000..173121377040c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr_file.c
[ ... ]
> +	skel->bss->file_kptr_insert_pid =3D child_pid;
> +	err =3D write_full(pipefd[1], "1", 1);
> +	if (!ASSERT_OK(err, "start_child"))
> +		goto out;

If an error occurs here and the code jumps to the out label, does it leave
the child process as a zombie?

It looks like the cleanup path closes the pipe file descriptors which causes
the child to read EOF and exit, but waitpid() isn't called in the cleanup
path.

[ ... ]
> +void test_refcounted_kptr_file(void)
> +{
> +	if (test__start_subtest("holds_ref_after_close"))
> +		run_refcounted_file_kptr_success();
> +
> +	if (test__start_subtest("reject_unref_ctx_file"))
> +		RUN_TESTS(refcounted_kptr_file_fail);
> +}

Can wrapping RUN_TESTS() inside test__start_subtest() break test filtering?

RUN_TESTS() internally parses the skeleton and creates its own subtests for
each BPF program by calling test__start_subtest_with_desc().

Since the selftests framework doesn't support nested subtests, if a user
filters for the inner program name (like -t refcounted_kptr_file/stash_unre=
f_ctx_file),
the outer test__start_subtest() will not match the filter and will skip
RUN_TESTS() completely.

Should RUN_TESTS() be called unconditionally at the top level of the test
function instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420203306.3107=
246-1-utilityemal77@gmail.com?part=3D2

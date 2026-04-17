Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24DB1EE7C6
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 04:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776400134; cv=none; b=B/0zJvsWvtR8fkJvNyRYTaMxesW0YypxhwL6k/wLUyRokO84IZByqPIhBEfEzln99+ZMvtqzxy/PhI5Tt5W2gIS8/YfwZkRUrXpv2t5L5gqlHWbJxejyio1Z5uhzCfLRTv0vGnqzhw7CbeJU9mTN1IigYglttwS3951sxmU/EpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776400134; c=relaxed/simple;
	bh=INeSdx2N6+jV4kWAFHDoqwGrC0Wt5O5S0UuB6rmGT9w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oIoqzl6uuYigVPD6m8Txhk+OmvP9LavoCIQqOWqo834mqwf/2u6f+TrYF9rWlIo0wah/hiRFfAp1f0EO8nyACbKOrhNqNMVhmBL9e3Us2bZUlbuLIymKdTHQIJRN91/a8OXwfC+RNTQSGzV9Zoz/c6e8Cl8RKqD6n07f9NKfylc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/AgoGpP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/AgoGpP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD1FC19425;
	Fri, 17 Apr 2026 04:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776400134;
	bh=INeSdx2N6+jV4kWAFHDoqwGrC0Wt5O5S0UuB6rmGT9w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=p/AgoGpPQzbiWMJMJla4EIUnt+sPSm1gkQcukK8Sr68fv+ESzxyZZz0ztti1MHb7o
	 iNFUIhB8USfLMjNi+Eva/47tlxnPDacDeTmYl1KcQzdTQ2mF29RvwFQ6/Z8iGX81jS
	 u6zjLSHcWnIB/0jtCKYyRtTYSeTpxCruH0Tat+4n2TavqYYDg7OMLG+r8gyOI5BTJS
	 gRexj+g7cXtm0XnirN3z1BhMw943Jw71igyDkV63Ll4ljEe0XfD5RxfliLMZymgILn
	 hz9wlf0m4tr5SEv3YUrw4cGA7aRBLISjl0txF0d4C6rxkJvGmFCUjw5ooyyNqPo0po
	 tMmz/V12/VcRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 15/16] selftests/bpf: Add negative test for
 greater-than-8-byte kfunc stack argument
Reply-To: sashiko@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260417034833.2636781-1-yonghong.song@linux.dev>
References: <20260417034833.2636781-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Apr 2026 04:28:53 +0000
Message-Id: <20260417042854.4BD1FC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] The `prog_test_big_arg` struct uses `long`, which fails to test =
the >8 byte limit on 32-bit architectures and causes BTF size mismatches.
- [Medium] Using `ASSERT_ERR(stack_arg_fail__load(skel))` masks the actual =
verifier error reason, allowing the negative test to pass for unrelated rea=
sons.
--

commit 1ec644adfded3aa88befcb32fc73958c68b7e018
Author: Yonghong Song <yonghong.song@linux.dev>

selftests/bpf: Add negative test for greater-than-8-byte kfunc stack argume=
nt

This commit adds a selftest to ensure the verifier rejects kfunc calls where
a stack argument exceeds the 8-byte register-sized slot limit. It introduces
a new kfunc taking a struct argument and a BPF program that attempts to pass
a large struct to it.

> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b=
/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> index 2c1cb118f8867..2a40f80b074a3 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> @@ -50,6 +50,11 @@ struct prog_test_pass2 {
>  	} x;
>  };
> =20
> +struct prog_test_big_arg {
> +	long a;
> +	long b;
> +};
> +

Does this structure achieve the intended >8 byte size on 32-bit architectur=
es?

When the test kernel module is compiled on a 32-bit host, long is 32-bit,
making the struct exactly 8 bytes. Since the BPF target always treats long
as a 64-bit integer, this makes the struct 16 bytes in the BPF program.

This size discrepancy between the BPF program's BTF and the host kernel's B=
TF
might cause the verifier to reject the load for a BTF size mismatch rather
than the intended stack argument limit.

Could these fields use explicitly sized types like __u64 to ensure the stru=
ct
is consistently larger than 8 bytes across all architectures?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/prog_tests/stack_arg_fail.c b/to=
ols/testing/selftests/bpf/prog_tests/stack_arg_fail.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/stack_arg_fail.c
> @@ -0,0 +1,24 @@
[ ... ]
> +	if (!skel->rodata->has_stack_arg) {
> +		test__skip();
> +		goto out;
> +	}
> +
> +	ASSERT_ERR(stack_arg_fail__load(skel), "load_should_fail");

Could this generic error assertion mask the actual verifier rejection reaso=
n?

If the program fails to load due to an unrelated issue, such as a missing B=
TF,
a syntax error, or the architecture-dependent size mismatch described above,
the test will incorrectly report success because it only checks that the lo=
ad
operation failed.

Would it be better to refactor this test to use the standard test_loader
infrastructure (via RUN_TESTS) with __failure and __msg annotations
in the BPF program? That would ensure the rejection is explicitly due to the
argument size limit.

> +
> +out:
> +	stack_arg_fail__destroy(skel);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260417034658.2625=
353-1-yonghong.song@linux.dev?part=3D15

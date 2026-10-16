Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73D317D6
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 00:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792109540; cv=none; b=M2nMWGAM53INWHQqWTN3HFYsJwAhcLA40PLFx1i/TBthUswe1wM1RtHjeLub/VuwOkt3KmnZtEnYMW7/WA50VynnF6HbN9LbXvg4sDFbsVukyy8NNRGhFpvgZPmuMVZTrBWVWJ3H2TwjPN5Lv+teWIBkLfUj4mzNMisAFAtBcZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792109540; c=relaxed/simple;
	bh=863TEG21esQeZ001LTsJU8zAqH1YK4E+9xI+dUgUPBE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DvGJwLn00FmuUxf8cLgx5fvy11RVz8R4R+xQIKHhKmbbabt6IWSZGeYX6686jmMUktIBOXzrRRW1npzPdx4DYw2EEqBuRXEEpCuxKykzAUWKflm06bo/ypeZjBy1pVCEt8+Xh542K0ycMMP1tSVF+CvbfP1rrhWJEkM7zkLB/Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mradwwFh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mradwwFh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0176F1F000C4;
	Fri, 16 Oct 2026 00:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792109539;
	bh=qv7NoB7Vfe/gtBjs1oIl8e5YRq2N8GUMaQTz7B3IFXY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mradwwFhDhmqxs88K9WB+LIHcTZvXTVqabOszNeINa2zJLZ2bCGITsynMY1s/f6jn
	 +NdJ32bZkcDTDLmJlZnmZBNaS01U2bj8NHB4fNyJjjCY55h++hC2wXCukDBSaAm2MC
	 JDTQ60hSyfqHKpCC40SPfjjV7UmcU1Y/oz+rYF8+ve7j9W8LBhMLJOz+6gf+lrtzDu
	 11cn47F6MJHLqfBVUv0jgsWDGuGPpaVL9p+as/THY1OdBwlQZ9shT2zhY1OVBthb7W
	 FQKhG6mG1AkimVwxy8uJ1aUcvC1xWmSOTYjn52H76tulTH3qgQig0XZd7D0A1GGNbU
	 RCkpQKlAWjTew==
Content-Type: multipart/mixed; boundary="===============7080161416199133746=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <09ff65e702dbde27dbdcda03069714faf85a6f5d98c860082177e8def01ac7f1@mail.kernel.org>
In-Reply-To: <20261015234125.3152346-5-memxor@gmail.com>
References: <20261015234125.3152346-5-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v3 04/15] selftests/bpf: Clone a program that calls a module kfunc
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 16 Oct 2026 00:12:17 +0000 (UTC)

--===============7080161416199133746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Clone a program that calls a module kfunc

TL;DR: Test issue: the new selftest may hard-fail instead of skipping when
bpf_testmod.ko isn't loaded, since it lacks an env.has_testmod check; the
review rates practical impact as low.

> diff --git a/tools/testing/selftests/bpf/prog_tests/clone_module_kfunc.c b/tools/testing/selftests/bpf/prog_tests/clone_module_kfunc.c
> new file mode 100644
> index 000000000000..fa6ccbaa7fd9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/clone_module_kfunc.c

[ ... ]

> +void test_clone_module_kfunc(void)
> +{
> +	struct kfunc_call_test *skel;
> +	int err, fd;
> +
> +	skel = kfunc_call_test__open();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		return;
> +
> +	err = bpf_object__prepare(skel->obj);
> +	if (!ASSERT_OK(err, "prepare"))
> +		goto out;

A subsystem pattern flags this as potentially concerning: the selftests
guidance says a test that fails because a capability or prerequisite is
absent should skip instead of fail.

This test depends on bpf_testmod.ko, since the kfunc_call_test programs call
module kfuncs such as bpf_testmod_test_mod_kfunc() and bpf_kfunc_call_test1(),
and the module BTF fd in slot 1 of the fd_array is the point of the test.
When test_progs cannot load the module it sets env.has_testmod to false and
prints that selftests relying on bpf_testmod.ko will be skipped.  Other
module-dependent tests such as ksyms_module.c, btf_module.c and tp_btf_ids.c
start with:

    if (!env.has_testmod) {
        test__skip();
        return;
    }

Without the module, bpf_object__prepare() would fail in
bpf_object__resolve_externs() with -ESRCH because the non-weak module kfunc
extern is not found, and ASSERT_OK(err, "prepare") reports a hard failure.

Should test_clone_module_kfunc() check env.has_testmod and call test__skip()
before opening the skeleton?

For context, the guidance names errno values like EOPNOTSUPP and ENOSYS, and
this test checks no errno, so the match is by spirit rather than by letter.
The sibling prog_tests/kfunc_call.c uses the same skeleton without a
has_testmod check, and the failure only appears where the module is not
available, so the practical impact looks low.

> +
> +	fd = bpf_program__clone(skel->progs.kfunc_call_test1, NULL);
> +	if (ASSERT_GE(fd, 0, "clone"))
> +		close(fd);
> +out:
> +	kfunc_call_test__destroy(skel);
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38826834739
--===============7080161416199133746==--

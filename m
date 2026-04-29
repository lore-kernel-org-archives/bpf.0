Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96DA38550A
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 21:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777496896; cv=none; b=qzwnywFYvuzic6MJJUksloR1gVHII1yMh/4IKwkBubocyh2jNFBxu4OnyZzTS90899QoIuQkdx/g0nNveCHJ0lwdBH5IA3yOWGOo/j90rpKljTT8VReInLvhw1sXSOgSj5DH2wf+N3+EhjQTO7sTxb2cTmacYL3tcJWfyS1dex8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777496896; c=relaxed/simple;
	bh=Ctj2AF5p+hGmcUpCMAGgVxU5o4TN3q/kApIC+UMFYoU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OEy4uvHRyPkvz0PRXMkwyCMX8F0BaFV6kZE0RgBJsFvNmH4Jq3Fah242bkTIxLSHY7L9AJulHabCu/GkW5uNzs5fH0srTs8/XnbR6TrdBn7RnemM7BsBS1UgRjlpl4Mr0b2lF8UgJLWv6mCOFcaA75Fz4KOkiT1UTk6MIjLt/Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/kk7UDq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/kk7UDq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29EA6C19425;
	Wed, 29 Apr 2026 21:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777496896;
	bh=Ctj2AF5p+hGmcUpCMAGgVxU5o4TN3q/kApIC+UMFYoU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=N/kk7UDqCgHdWR5K/Nq3WtfZnZgWmWXE1v8MxEIXgApvmgsYRdnzgkjz3ufTs8VJZ
	 opSGKkGpNuzL6ZH6Td2Jzeke1afd8U6QIzKQDU6ZVJ5iAiZwMIU84uwXas2YGI7A2q
	 4iZkVcODpWS+hZslxjJ9aFnpTbOtc6dCVXxSVPXTlTHoJg6p7BHaP4qCwiLeJ0Zn1N
	 BO72h9cmWvWxcNe7ki4F8hifxMLPXb0Y1iTwcXK1IHh2IyQesyLUVjuA9Fg/leLNXp
	 0NRRpQYd8kwk/dJP5TLAdvkhWgKUe8NeruZ8SAmgjAd3kI6IV+gNgKv+HnUJ7jTNUx
	 QgFfM6R0VvPNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v9 09/11] selftests/bpf: Tolerate benchmark
 build failures
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260429-selftests-bpf_misconfig-v9-9-c311f06b4791@suse.com>
References: <20260429-selftests-bpf_misconfig-v9-9-c311f06b4791@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 21:08:15 +0000
Message-Id: <20260429210816.29EA6C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Skipped `bench` binary causes `make install` to fail due to miss=
ing files in `TEST_GEN_PROGS_EXTENDED`.
- [Medium] Using `$(wildcard $^)` to filter missing prerequisites breaks `m=
ake -n` (dry run) and drastically increases compiler error noise.
--

commit 31a306fe854d559a436ecf84354b5b73a31012e8
Author: Ricardo B. Marli=C3=A8re <rbm@suse.com>

selftests/bpf: Tolerate benchmark build failures

This commit modifies the selftests/bpf Makefile to tolerate build failures
for benchmark objects when PERMISSIVE is set. It changes the compilation and
linking steps for the bench binary to emit a skip message and avoid failing
the entire build if a dependency is missing or fails to compile.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index a64e822dc540..db4ff951fc88 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile

[ ... ]

> @@ -988,7 +989,8 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
>  		 $(OUTPUT)/usdt_2.o \
>  		 #
>  	$(call msg,BINARY,,$@)
> -	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
> +	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$(if $(PERMISSIVE),$(wi=
ldcard $^),$^)) $(LDLIBS) -o $@ $(if $(PERMISSIVE),|| \
> +		($(RM) $@; printf '  %-12s %s\n' 'SKIP-LINK' '$(notdir $@) (some bench=
marks may have been skipped)' 1>&2))

Does using $(wildcard $^) here break make -n (dry run) and cause excessive
linker noise?

Since bench.c statically references every benchmark, omitting missing objec=
ts
from the command line forces the linker to run anyway, resulting in a large
number of undefined reference errors before it fails.

If $^ were used directly, the compiler would fail cleanly and immediately w=
ith
a "No such file or directory" error before running the linker, which would
then correctly trigger the || SKIP-LINK fallback.

Also, evaluating $(wildcard $^) in a recipe causes missing generated objects
to be silently omitted during make -n.

Will skipping the bench binary cleanly cause make install to fail, since
bench is unconditionally listed in TEST_GEN_PROGS_EXTENDED?

During make install, the selftest build system uses rsync to copy all targe=
ts
in TEST_GEN_PROGS_EXTENDED. Since the skipped bench binary won't exist on d=
isk,
rsync fails with a "No such file or directory" error and aborts the pipelin=
e,
defeating the purpose of the permissive build mode.

I do see this was fixed later in the series by commit
ce682ab9bce04cbe3adda3d7a63647774ad61f5d "selftests/bpf: Tolerate missing
files during install".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260429-selftests-=
bpf_misconfig-v9-0-c311f06b4791@suse.com?part=3D9

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AC93CB2C1;
	Fri,  3 Apr 2026 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775230313; cv=none; b=UmP39bAAVfBXR30mtBXOPxXyVlu+zHzHu1JFFNYHTJ4yguMnZpIqvjl5frddI/olp1d0kvoMK+hUQeJPpbsfoXGhUMkj9dBxTqKMrnfmRhTH4rDp1C3QLeU/9erS6U0ZpJh+QegDxk7sk2xzyTgThGpBtrSQLxcShVVinwTTo1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775230313; c=relaxed/simple;
	bh=Mp3ntR/iCOy4NhXi36GY202qgx9qFfoM+yk8F8xJzuI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=CF6fnAJyhVkKOg/Pk2/F5p2Xhnn2hmkuX9UA5g01t2UDlcMNFmnbNxGumFp0vc7bwYLjAp8qFfcVzCtQbbVZcYzHouPm6hEdC5a88+xn9P/GA/UrUkz9rB7iXLcftbbfeXMhZXLOs2VNJcUs+6ooYXOTqAnFkdzGzrhK/pxHEic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyPlX8x/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyPlX8x/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A89BC4CEF7;
	Fri,  3 Apr 2026 15:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775230312;
	bh=Mp3ntR/iCOy4NhXi36GY202qgx9qFfoM+yk8F8xJzuI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=FyPlX8x/gn+eo5S1Rg7TwWp8VogVOaiYXTlhKqr3DbR6o3KJGZdB19twzdr9LdnIo
	 lYfQJAfM1Cne3fHPRAHOgAMYEnGkPHwjGYxu9kninU8llAPDyVCpFFAf9uaag69F4+
	 1XoxXp6ZEH5se8q8V/9jSADRdDbTWwXc6UY0yp6TnC4deKF/adO1Dfs0J69JP5xP9e
	 OZpgSyvpzFzMiAtUIQseh2yMqJrqKTlokHKn/Tsu1uChF6/UUBrTbFWGK0k1l19fL/
	 nJjio8MpRxD+SHgb9hY5DqRm03/e5IwZB6ArhofNnzi+Gtmvp9zOkMlsbjVvKDmHts
	 XRkWmIVEX7liw==
Content-Type: multipart/mixed; boundary="===============6298061062702668847=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dc2906a8892a559e96eb401e2c334cd01e61027ce9c280a53ab890eed906de36@mail.kernel.org>
In-Reply-To: <20260403-selftests-bpf_misconfig-v2-6-f06700380a9d@suse.com>
References: <20260403-selftests-bpf_misconfig-v2-6-f06700380a9d@suse.com>
Subject: Re: [PATCH v2 06/10] selftests/bpf: Allow test_progs to link with a partial object set
From: bot+bpf-ci@kernel.org
To: rbm@suse.com,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,nathan@kernel.org,nick.desaulniers+lkml@gmail.com,morbo@google.com,justinstitt@google.com
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,llvm@lists.linux.dev,rbm@suse.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  3 Apr 2026 15:31:52 +0000 (UTC)

--===============6298061062702668847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 6a3835a58f87..ca64a7678dfe 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile

[ ... ]

> -$(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
> -			     $(TRUNNER_EXTRA_OBJS) $$(BPFOBJ)		\
> +$(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_EXTRA_OBJS) $$(BPFOBJ)		\
>  			     $(TRUNNER_LIB_OBJS)			\
>  			     $(TRUNNER_BPFTOOL)				\
>  			     $(OUTPUT)/veristat				\
> -			     | $(TRUNNER_BINARY)-extras
> +			     | $(TRUNNER_BINARY)-extras			\
> +			     $(TRUNNER_TEST_OBJS)
>  	$$(call msg,BINARY,,$$@)
> -	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) $$(LLVM_LDLIBS) $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@
> +	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^ $$(wildcard $(TRUNNER_TEST_OBJS))) $$(LDLIBS) $$(LLVM_LDLIBS) $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@

Does this change the link order in a way that breaks GNU ld builds?

Before this patch, $^ expanded to:

    TRUNNER_TEST_OBJS TRUNNER_EXTRA_OBJS BPFOBJ TRUNNER_LIB_OBJS ...

After the filter, the linker saw:

    test*.test.o extra*.o libbpf.a lib*.o

After this patch, the filter over "$^ $(wildcard TEST_OBJS)" produces:

    extra*.o libbpf.a lib*.o test*.test.o

BPFOBJ is libbpf/libbpf.a (a static archive). GNU ld scans archives
once, left to right, pulling in only the members that resolve symbols
unresolved at that point. With the new ordering, libbpf.a is scanned
before any test object is seen, so libbpf symbols referenced
exclusively by test objects will remain unresolved.

For example, ring_buffer__new() (in libbpf's ringbuf.c) is called by
prog_tests/ringbuf.c, prog_tests/test_ima.c, and others, but is not
referenced by any TRUNNER_EXTRA_SOURCES file. With this link order,
the ringbuf.o archive member is never pulled in and the link fails
with unresolved symbols.

There is no --start-group or --whole-archive in the link flags, and
LDLIBS (-lelf -lz -lrt -lpthread) does not provide libbpf symbols.

One possible fix would be to append $$(BPFOBJ) after the wildcard
expansion in the filter expression, or to place the test objects
before libbpf.a in the argument list.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23951016185
--===============6298061062702668847==--

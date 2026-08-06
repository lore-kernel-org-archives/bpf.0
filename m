Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02DD47F784
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 20:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786048570; cv=none; b=JF8iU+CUuHP+HwcMLNX3PFQE1lsnvXT852+vgBzqZ+6hNkfH92hr1f2xks9aTSsu5JcrYblBLSYR6FzVZpbFm7ycn9WmxDVxecf1bltk++/IlBLH9e9R1JvaBe2nMekFgJIwGdLyzqy7rySQX/2PndTBxtnFkcdoS0shS8IFIt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786048570; c=relaxed/simple;
	bh=HK/stiK0snN20FV/66pU3dzEM8eLuDF2fWmrLeiterc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JQ+owGkLSSfObKhnj1EmFawfLC3mdCWf+K1MyzElA/FUywqNsdu80VQrUbTcE0gpdAxFrH6FyGQMtvRtQIacaO29vH5cqxErFwwDPKMhXN6A342C2PA+lJL/R1WcYep/WTzDubuD/ZiOF7PnaarWKmwfVFw7lFV/O7z5eGRzr2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mg/hnzxa; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mg/hnzxa"
Message-ID: <de5afc86-fad5-4140-bdde-4da54e92915e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786048566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b2vBzBrgYplXrUdCTZCvF7A2T0H/vOdVAAbIRRJr3k4=;
	b=Mg/hnzxavZZCaxXr+UblvSj0nmHMMwMvxJPNMTau4vUimsEglXTmEknA3x4jIJj8IjdqZv
	0pLwoCAZLtjbe5SqBs8x42AzF+Ww/k5jgO+DEo6B6xM85+aS3l4x/GVV0s9pNXGKdNon8o
	qT8UAVvBsGBaVF+/5vT8A4P/VLzWlCY=
Date: Thu, 6 Aug 2026 13:35:36 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] selftests/bpf: Route test_kmods build artifacts to
 OUTPUT
To: =?UTF-8?B?UmljYXJkbyBCLiBNYXJsacOocmUgKFNVU0Up?= <ricardo@marliere.net>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260728-selftests-bpf_oot-v1-0-05feb15d94db@marliere.net>
 <20260728-selftests-bpf_oot-v1-3-05feb15d94db@marliere.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260728-selftests-bpf_oot-v1-3-05feb15d94db@marliere.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/28/26 5:06 PM, Ricardo B. MarliÃ¨re (SUSE) wrote:
> [...]
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 7d42632f9d42..b150a66f3c25 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -135,6 +135,9 @@ TEST_PROGS_EXTENDED := \
>  TEST_KMODS := bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
>  	bpf_test_modorder_y.ko bpf_test_rqspinlock.ko
>  TEST_KMOD_TARGETS = $(addprefix $(OUTPUT)/,$(TEST_KMODS))
> +# Build directory for kernel modules: routed to $(OUTPUT)/test_kmods when
> +# OUTPUT is set so that kbuild intermediates stay out of the source tree.
> +TEST_KMODS_OUTDIR := $(if $(OUTPUT),$(OUTPUT)/test_kmods,test_kmods)
>  
>  # Compile but not part of 'make run_tests'
>  TEST_GEN_PROGS_EXTENDED = \
> @@ -163,8 +166,8 @@ override define CLEAN
>  	$(Q)$(RM) -r $(TEST_GEN_FILES)
>  	$(Q)$(RM) -r $(TEST_KMODS)
>  	$(Q)$(RM) -r $(EXTRA_CLEAN)
> -	$(Q)$(MAKE) -C test_kmods clean
> -	$(Q)$(MAKE) -C libarena clean
> +	$(Q)$(MAKE) -C test_kmods $(if $(OUTPUT),OUTPUT=$(OUTPUT)/test_kmods) clean
> +	$(Q)$(MAKE) -C libarena $(if $(OUTPUT),OUTPUT=$(OUTPUT)/libarena) clean

This is broken. What happens if the caller set OUTPUT but not O= ?

If at linux root you do:

  $ make defconfig && make -j$(nproc)
  $ mkdir -p /tmp/kout
  $ make -C tools/testing/selftests/bpf OUTPUT=/tmp/kout clean

it destroys the root Makefile:

  $ git diff --stat -- Makefile
  Makefile | 2364 +------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  1 file changed, 5 insertions(+), 2359 deletions(-)

  $ cat Makefile
  # Automatically generated by /home/isolodrai/sandbox/2026-08-06.review.out-of-tree-fixes/linux/Makefile: don't edit
  export KBUILD_OUTPUT = /home/isolodrai/sandbox/2026-08-06.review.out-of-tree-fixes/linux
  export KBUILD_EXTMOD = /home/isolodrai/sandbox/2026-08-06.review.out-of-tree-fixes/linux/tools/testing/selftests/bpf/test_kmods
  export KBUILD_EXTMOD_OUTPUT = /tmp/kout/test_kmods
  include /home/isolodrai/sandbox/2026-08-06.review.out-of-tree-fixes/linux/Makefile

pw-bot: cr


Also the selftests clean loop runs clean rules this way [1]:

clean:
	@for TARGET in $(TARGETS) $(INSTALL_DEP_TARGETS); do \
		BUILD_TARGET=$$BUILD/$$TARGET;	\
		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET clean;\
	done;

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/Makefile?h=v7.2-rc6#n325


>  	$(Q)$(MAKE) docs-clean
>  endef
>  
> [...]
> 


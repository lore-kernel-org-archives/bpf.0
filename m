Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64A317C211
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 20:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786048368; cv=none; b=YAdWRnlkf55Nv4UtQ3qPbGgnFUvTmgc5FiPBRHHLz9yZ9W1cAUEpExFLWvwWAkKRruFRxBT02TT+uV9MP6PVw4q6iegf8D03WDod0POrtztnOX9B/XEum+VbUjjL8hS9WXu9dJ2OnyRRwYYN2DsHLsTbOa1AgUeigWjx4kbQfRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786048368; c=relaxed/simple;
	bh=637wyi+0PPIwdbUexh8Zu5aT1kZqVzeWESqLR/qm4+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uCImtdvzpuSNJn8VNzP2AfXRKgw2k3karcvuMFdgvX2mTg7RKI39w59HImnmNJzpmM/si5qO2VQgq0kTzqOVAy4aBvySfFICYCDF4eAjHF7mpmOj5OS74eEmUHTe/agcaimfYxRLzuQJ4DE+jic3HlXhuNGRHEHSXKtJYgvH2RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M+QWl9lW; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M+QWl9lW"
Message-ID: <0dc9287e-4981-49b1-a937-ac9bf416d94e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786048358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s18eVue8NifYzBxxeCFhraUorJVnglSn9El+yS6Pliw=;
	b=M+QWl9lWA3ubFbjUQfzA2CF5G7aoZOBVoYHDRPrk/MDTIRQ9pzCm+2fZSMBykiuQBGOMIw
	neabr5j42OB8WMABAvb+wc4xnVkMs5Me+0ZIdDzychvDLSKzChoa3czKJVXpcTehuu1tkp
	3JeAjkux9DYIXJPTx5HfqYFr25/wO8Q=
Date: Thu, 6 Aug 2026 13:32:20 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] selftests/bpf: Route generated test headers to OUTPUT
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
 <20260728-selftests-bpf_oot-v1-1-05feb15d94db@marliere.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260728-selftests-bpf_oot-v1-1-05feb15d94db@marliere.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/28/26 5:06 PM, Ricardo B. MarliÃ¨re (SUSE) wrote:
> [...]
>  
> @@ -923,14 +923,14 @@ $(eval $(call DEFINE_TEST_RUNNER,test_maps))
>  # It is much simpler than test_maps/test_progs and sufficiently different from
>  # them (e.g., test.h is using completely pattern), that it's worth just
>  # explicitly defining all the rules explicitly.
> -verifier/tests.h: verifier/*.c
> -	$(shell ( cd verifier/; \
> +$(OUTPUT)/verifier/tests.h: verifier/*.c | $(OUTPUT)
> +	$(shell mkdir -p $(OUTPUT)/verifier && ( \
>  		  echo '/* Generated header, do not edit */'; \
>  		  echo '#ifdef FILL_ARRAY'; \
> -		  ls *.c 2> /dev/null | sed -e 's@\(.*\)@#include \"\1\"@'; \
> +		  ls verifier/*.c 2> /dev/null | sed -e 's@\(.*\)@#include "$(CURDIR)/\1"@'; \

This can break if $(CURDIR) contains '@'.

In such case sed fails, but make returns success and generates
verifier/tests.h with zero #include lines. And this would silently
skip all the tests.

Also at line 1046:

EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)			\
	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\

These are the old source-tree locations. Should be updated?

>  		  echo '#endif' \
> -		) > verifier/tests.h)
> -$(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
> +		) > $(OUTPUT)/verifier/tests.h)
> +$(OUTPUT)/test_verifier: test_verifier.c $(OUTPUT)/verifier/tests.h $(BPFOBJ) | $(OUTPUT)
>  	$(call msg,BINARY,,$@)
>  	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
>  
> 


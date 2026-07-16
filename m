Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFC53BF692
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 21:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784236243; cv=none; b=Oi7eCv5wjhcYL9u91V1Bbx3WIUfPcL25nmeM6h34LDpb8Q2bgr8dxhwRxIuKw1d4y9WUBfzt3t/xbGFbPZTKUA2y9PZ3E+RvNNmVfS2VaRMrX31bYwslB7aNLC3oilKx8BiEqcy+KrDR3vEnt8jZ6YcDQB06WBl+WqvMrleogbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784236243; c=relaxed/simple;
	bh=oSe6esEAfgDCeUoz8BT1HUs0LHdcWpWM7oTl5W/a328=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lNGySY7wn7TowtfkQVjxPU88B9iCmUhhImM1mjAXMi/VA1fvPRTthG1zpO29GRB4TTclXNTxRmHcg6QVGDWM3nQLfA2ICmeywJn29XpldlQBbmLfP7VMHeWFhgk+rvL7wAcHtEsbCibjPlLdXTzYddjsIAS6vFN30OE5bbo8uz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tqFVGgkV; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tqFVGgkV"
Message-ID: <cebe82a7-203c-4b7e-a57f-0616850c58e3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784236239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qA8gusKTtpZqCfi4JGOZNGnEDiI7yt/qdildjgXKcMY=;
	b=tqFVGgkV45qJYnsNuyCpwFfQvR7l9Y6KHQHEuja29Ihd8mWWzAkVO7gIya2WmHz3/VEtap
	liEN3eh+JgtKT88mglxocJqZLtyeeo2dYG8Lj/KjrVWA4xtwyqnO1b7z3QxayaFGDMolyX
	YVSPcFW7MOYvJGMsfh/hDIEf2h1WQFs=
Date: Thu, 16 Jul 2026 14:10:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/4] selftests/bpf: Install resolve_btfids.test.o.BTF
 where the test expects it
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>, Christian Brauner <brauner@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260710-selftests-bpf_fixes-v1-0-aa24dfd6f4f9@suse.com>
 <20260710-selftests-bpf_fixes-v1-2-aa24dfd6f4f9@suse.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260710-selftests-bpf_fixes-v1-2-aa24dfd6f4f9@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/10/26 3:09 PM, Ricardo B. Marlière wrote:
> prog_tests/resolve_btfids.c looks for "resolve_btfids.test.o.BTF" relative
> to the running test_progs binary. resolve_btfids always writes
> <obj.path>.BTF next to the object it processes, so building
> resolve_btfids.test.o also produces resolve_btfids.test.o.BTF in the build
> output directory as a side effect.
> 
> INSTALL_RULE never carries it over: it is not part of TEST_FILES,
> TEST_GEN_FILES or TRUNNER_EXTRA_FILES, and it is not copied by the *.bpf.o
> rsync used for TEST_INST_SUBDIRS. After "make install", every flavor of
> test_progs, including the default one, fails with "Failed to load BTF from
> resolve_btfids.test.o.BTF", even though the file built fine and BTF ID
> resolution itself works correctly.
> 
> Install it next to the rest of the per-flavor build output, using an
> explicit rsync in INSTALL_RULE like the one already used for bpftool.
> 
> Fixes: 522397d05e7d ("resolve_btfids: Change in-place update with raw binary output")
> Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 47911c9b4977..7260d672acf7 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -1057,10 +1057,11 @@ override define INSTALL_RULE
>  	$(DEFAULT_INSTALL_RULE)
>  	@mkdir -p $(INSTALL_PATH)/tools/sbin
>  	@rsync -a $(if $(PERMISSIVE),--ignore-missing-args) $(TRUNNER_BPFTOOL) $(INSTALL_PATH)/tools/sbin/
> +	@rsync -a $(if $(PERMISSIVE),--ignore-missing-args) $(OUTPUT)/resolve_btfids.test.o.BTF $(INSTALL_PATH)/

I think you can squash patches #1 and #2 into a single "Fix make
install target" patch.

pw-bot: cr

nit: This hardcodes the filename, and even though we only have one
test that needs .BTF currently, you could add *.BTF to the loop:

	$(OUTPUT)/$$DIR/*.bpf.o $(OUTPUT)/$$DIR/*.BTF

Then any future test that consumes a raw .BTF gets installed for free.

>  	@for DIR in $(TEST_INST_SUBDIRS); do				  \
>  		mkdir -p $(INSTALL_PATH)/$$DIR;				  \
>  		rsync -a $(if $(PERMISSIVE),--ignore-missing-args)	  \
> -			$(OUTPUT)/$$DIR/*.bpf.o				  \
> +			$(OUTPUT)/$$DIR/*.bpf.o $(OUTPUT)/$$DIR/resolve_btfids.test.o.BTF \
>  			$(INSTALL_PATH)/$$DIR;				  \
>  	done
>  endef
> 


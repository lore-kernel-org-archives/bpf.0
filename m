Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ABB1643B
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 01:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784596755; cv=none; b=UXJY/fA0ZseGNg0U4WKQzCDypCx7bosbri3Kvxxfzn2BcN33gdR5Dmy71nx4/yIPZ6k0HoFTCKyatbbcMOJ0dNeuC0lM0IsaIkVj4ZDOz8Fcy8aHFcbPFutbSNpdzs7sA3TvEHA0evcHGo+diB8qjuI9aTqU+v6bFrFzz8szgj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784596755; c=relaxed/simple;
	bh=ej2Pmo6JrJv1jAdH1F16tD7Xqf2CTr2idSMnSEyP/sA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bue2MAIrw1RRG+ifN/EAHmw3d5MbCezfgw5N144dK6E85xItflYQdL53QbUBTdRUrrYxqPyaujithTkP1zreeMtQmuBYJP5lzIfXi6yAVXCk7tnuc741n4A1xFcGfQN3nzqP0n5XajGvGKLi0wAyLGrR2kSAaxy/mW9/haDWa4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RzDkedaM; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RzDkedaM"
Message-ID: <f35b0f91-68d3-4f83-9888-7e5c43e4a946@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784596750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m+f24Sc7UNgN1pE60/Pk0xM4WOjhh3VZu7lRqfXItFs=;
	b=RzDkedaMTu04BjmWltRlZgNaEfDKY9yaMFggpJXhnyP2Z4LfGD4/tZ3w2iQI8TF4UKDxBM
	1do6uGU+QKsQEbjBOo0OVzMR3/+wFHDBOY8IJX8MKD9qXkMgknwcHjGnr8gUDezhpfr69K
	oYduT56J6gGDZ0NCoNqNGU2wb/yA6W0=
Date: Mon, 20 Jul 2026 18:19:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] selftests/bpf: Fix make install target
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
References: <20260720-selftests-bpf_fixes-v2-0-b450eda93dfe@suse.com>
 <20260720-selftests-bpf_fixes-v2-1-b450eda93dfe@suse.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260720-selftests-bpf_fixes-v2-1-b450eda93dfe@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2026-07-20 4:13 a.m., Ricardo B. Marlière wrote:
> After "make install", test_progs fails because two files end up in the
> wrong place:
> 
> - bpftool: TEST_GEN_PROGS_EXTENDED flattens it into $(INSTALL_PATH), losing
>    the tools/sbin/ prefix that detect_bpftool_path() expects. Remove it from
>    TEST_GEN_PROGS_EXTENDED and install it explicitly under tools/sbin/
>    instead.
> 
> - *.BTF: resolve_btfids writes resolve_btfids.test.o.BTF as a side-effect
>    of the build but INSTALL_RULE never copies it over. Install all *.BTF
>    files alongside the rest of the per-flavor output.
> 
> Fixes: f21fae577446 ("selftests/bpf: Add a few helpers for bpftool testing")
> Fixes: 522397d05e7d ("resolve_btfids: Change in-place update with raw binary output")
> Signed-off-by: Ricardo B. Marlière <rbm@suse.com>

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Thanks!

> ---
>   tools/testing/selftests/bpf/Makefile | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index b642ee489ea6..55d394438705 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -324,8 +324,6 @@ TRUNNER_BPFTOOL := $(DEFAULT_BPFTOOL)
>   USE_BOOTSTRAP := "bootstrap/"
>   endif
>   
> -TEST_GEN_PROGS_EXTENDED += $(TRUNNER_BPFTOOL)
> -
>   $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(BPFOBJ)
>   
>   TESTING_HELPERS	:= $(OUTPUT)/testing_helpers.o
> @@ -1055,10 +1053,13 @@ endif
>   DEFAULT_INSTALL_RULE := $(INSTALL_RULE)
>   override define INSTALL_RULE
>   	$(DEFAULT_INSTALL_RULE)
> +	@mkdir -p $(INSTALL_PATH)/tools/sbin
> +	@rsync -a $(if $(PERMISSIVE),--ignore-missing-args) $(TRUNNER_BPFTOOL) $(INSTALL_PATH)/tools/sbin/
> +	@rsync -a $(if $(PERMISSIVE),--ignore-missing-args) $(OUTPUT)/*.BTF $(INSTALL_PATH)/
>   	@for DIR in $(TEST_INST_SUBDIRS); do				  \
>   		mkdir -p $(INSTALL_PATH)/$$DIR;				  \
>   		rsync -a $(if $(PERMISSIVE),--ignore-missing-args)	  \
> -			$(OUTPUT)/$$DIR/*.bpf.o				  \
> +			$(OUTPUT)/$$DIR/*.bpf.o $(OUTPUT)/$$DIR/*.BTF \
>   			$(INSTALL_PATH)/$$DIR;				  \
>   	done
>   endef
> 


Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0DA38394
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 08:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710924687; cv=none; b=cSD3NqquJAmK8IZFMDnigQGUsL0XCy7ga+wrRvWWvKZEQgmSqzyZw0W9roJp261LNf0uTvz20r3we8ZlBXmGBs5A0IEw/g+gebPtS1Gcs/LewWIIgCwYLp3WmFKK9ht1jPqnu8/mw7nlI+PpWlahSCCgW5//ZcxNSTMIlG2yOlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710924687; c=relaxed/simple;
	bh=O2GRfJW4aE1m8fiY1LgTiu82ugj3sCmlBkaaOkalukA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUKgtFh63rW7G4T+bj/+Yk/dqub7D6SuGSjekyARAFY6pU2e29kIeMgqxgwPGI8EdryrG351XDn7yr92gUqld2eF61vZmzjiGKQmZDaEMKd2g+9okdcYMUlm209yHSHEwN99/iuyKyGCw74k9+ulr7BsuRZ6mSQukeHjsIiP8e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhUc0hto; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhUc0hto"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5101cd91017so9857153e87.2
        for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 01:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710924684; x=1711529484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tJ4IfJgo+0eQLOvW2UxTn6ugb1SdJGzubE3oNgOHYcI=;
        b=EhUc0htosjdpP/KX6R/ENR1cK8tPJeStSMMyoUW69fzhVdOdvrc075uXVtIJCv76/P
         Dhd+GGPkTFPr9cJz5akpAWsXzz9IZHX/6Fne2qi6Z2mx6Ztotn4FqGiLc8uXDrXj0QHK
         Onk11Dzy0RxWdyvOduUt4gqhrxbjyN7ZW8TaPk8tvPQn3ZbTo/0EAtjtyY9CV6GJKWdq
         l13T9DM9XxNTKi1rfHTdBlRfLK4Z97hjgBGn4uj2UqpewpDqdf/YyHhZOY7UdcURUi7C
         bTdZfcU1mf43kYSGW+DFoea8wvqDSdeA5P1irHLHWu+CgLzqAj/mnxkm6Qf6elmayXwd
         7gzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710924684; x=1711529484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJ4IfJgo+0eQLOvW2UxTn6ugb1SdJGzubE3oNgOHYcI=;
        b=kyH6w+Y112nRqOGQ5d9dgq3Ic1a5TKn7WqXzqcifn2/50vAfceItpZDfCn1RouoDJ1
         EtutHBVIOWfokhOq+AWUmZbdIYhf7HDGkea8JoC5U+CT/krnKr/ANv+avreT8Xs8mtij
         9tQZULc1HLqhQIAJ4WPiIKE3E9zdBNV87DMlaxWeDJrIIqqjIf+aWRtUljtUoDqt3RPh
         KdtejYayXGum4/5DlG28XpGzC+8YxuqVvIpO6CPqv3StTT2QU1f/LM/ZZX24uh/yI6x6
         9U9g7sGqk/77Q2SR0DmIRViFvLvQXqDHn3KoxIHGDBQHnfUrR+Vz/cwOxbA0Xjaupv02
         IWcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM5I0Su9gAP7Nd88h1qrrxmQBTatLibW8WZvRqnoBqQH+JpuaSGd1ZHwPLO9f3cRjkdFECYtICl4pQZgxIz+W4UICV
X-Gm-Message-State: AOJu0Yz9SJSObD9DkChYK2VyDTeBrhRmVT9p6P/lYgBab0OxvRVPLPj9
	2b9LyjuHKqbO/Zfh62rI/oCEDLgVG3t+7JqnUZqFEgEf/BWSkJ4s
X-Google-Smtp-Source: AGHT+IH8rFJB9MTDVhD5RrjGK/OJntMW3T4vu8QEuk22rJPsN/vYfz61rJMrTxkEa6/Pf2aL6YrKAA==
X-Received: by 2002:a05:6512:b9e:b0:513:184a:ff5f with SMTP id b30-20020a0565120b9e00b00513184aff5fmr13963789lfv.50.1710924683538;
        Wed, 20 Mar 2024 01:51:23 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id p10-20020a5d638a000000b0033e206a0a7asm14112939wru.26.2024.03.20.01.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 01:51:23 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 20 Mar 2024 09:51:20 +0100
To: Quentin Monnet <qmo@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, bpf@vger.kernel.org,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH bpf-next] bpftool: Clean up HOST_CFLAGS, HOST_LDFLAGS for
 bootstrap bpftool
Message-ID: <ZfqjiFeHmLoIO-rS@krava>
References: <20240320014103.45641-1-qmo@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320014103.45641-1-qmo@kernel.org>

On Wed, Mar 20, 2024 at 01:41:03AM +0000, Quentin Monnet wrote:
> Bpftool's Makefile uses $(HOST_CFLAGS) to build the bootstrap version of
> bpftool, in order to pick the flags for the host (where we run the
> bootstrap version) and not for the target system (where we plan to run
> the full bpftool binary). But we pass too much information through this
> variable.
> 
> In particular, we set HOST_CFLAGS by copying most of the $(CFLAGS); but
> we do this after the feature detection for bpftool, which means that
> $(CFLAGS), hence $(HOST_CFLAGS), contain all macro definitions for using
> the different optional features. For example, -DHAVE_LLVM_SUPPORT may be
> passed to the $(HOST_CFLAGS), even though the LLVM disassembler is not
> used in the bootstrap version, and the related library may even be
> missing for the host architecture.
> 
> A similar thing happens with the $(LDFLAGS), that we use unchanged for
> linking the bootstrap version even though they may contains flags to
> link against additional libraries.
> 
> To address the $(HOST_CFLAGS) issue, we move the definition of
> $(HOST_CFLAGS) earlier in the Makefile, before the $(CFLAGS) update
> resulting from the feature probing - none of which being relevant to the
> bootstrap version. To clean up the $(LDFLAGS) for the bootstrap version,
> we introduce a dedicated $(HOST_LDFLAGS) variable that we base on
> $(LDFLAGS), before the feature probing as well.
> 
> On my setup, the following macro and libraries are removed from the
> compiler invocation to build bpftool after this patch:
> 
>   -DUSE_LIBCAP
>   -DHAVE_LLVM_SUPPORT
>   -I/usr/lib/llvm-17/include
>   -D_GNU_SOURCE
>   -D__STDC_CONSTANT_MACROS
>   -D__STDC_FORMAT_MACROS
>   -D__STDC_LIMIT_MACROS
>   -lLLVM-17
>   -L/usr/lib/llvm-17/lib
> 
> Another advantage of cleaning up these flags is that displaying
> available features with "bpftool version" becomes more accurate for the
> bootstrap bpftool, and no longer reflects the features detected (and
> available only) for the final binary.
> 
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Quentin Monnet <qmo@kernel.org>

got some fuzz when applying it, but other than that lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/bpf/bpftool/Makefile | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index e9154ace80ff..972f8d727130 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -89,6 +89,10 @@ ifneq ($(EXTRA_LDFLAGS),)
>  LDFLAGS += $(EXTRA_LDFLAGS)
>  endif
>  
> +HOST_CFLAGS := $(subst -I$(LIBBPF_INCLUDE),-I$(LIBBPF_BOOTSTRAP_INCLUDE),\
> +		$(subst $(CLANG_CROSS_FLAGS),,$(CFLAGS)))
> +HOST_LDFLAGS := $(LDFLAGS)
> +
>  INSTALL ?= install
>  RM ?= rm -f
>  
> @@ -178,9 +182,6 @@ ifeq ($(filter -DHAVE_LLVM_SUPPORT -DHAVE_LIBBFD_SUPPORT,$(CFLAGS)),)
>    SRCS := $(filter-out jit_disasm.c,$(SRCS))
>  endif
>  
> -HOST_CFLAGS = $(subst -I$(LIBBPF_INCLUDE),-I$(LIBBPF_BOOTSTRAP_INCLUDE),\
> -		$(subst $(CLANG_CROSS_FLAGS),,$(CFLAGS)))
> -
>  BPFTOOL_BOOTSTRAP := $(BOOTSTRAP_OUTPUT)bpftool
>  
>  BOOTSTRAP_OBJS = $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json_writer.o gen.o btf.o xlated_dumper.o btf_dumper.o disasm.o)
> @@ -238,7 +239,7 @@ $(OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
>  	$(QUIET_CC)$(CC) $(CFLAGS) -c -MMD $< -o $@
>  
>  $(BPFTOOL_BOOTSTRAP): $(BOOTSTRAP_OBJS) $(LIBBPF_BOOTSTRAP)
> -	$(QUIET_LINK)$(HOSTCC) $(HOST_CFLAGS) $(LDFLAGS) $(BOOTSTRAP_OBJS) $(LIBS_BOOTSTRAP) -o $@
> +	$(QUIET_LINK)$(HOSTCC) $(HOST_CFLAGS) $(HOST_LDFLAGS) $(BOOTSTRAP_OBJS) $(LIBS_BOOTSTRAP) -o $@
>  
>  $(OUTPUT)bpftool: $(OBJS) $(LIBBPF)
>  	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS) $(LIBS) -o $@
> -- 
> 2.34.1
> 

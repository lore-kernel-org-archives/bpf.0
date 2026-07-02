Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FA4381EBC
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 17:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783015142; cv=none; b=UDrrAfhBF3ObiASYzeWQ6Szh3ZIzilgC/4llDdd61kb9UwumdIYC0GXgOJl2lQPSxo1O0NUNC6lI8bZLknXTz5MvWHymTG0aAorODL+RcTEXsXX9/N/BtrUzVpIsX8MdhRpvfSC44izWufWLzSOH4qraLUpJwcmqd9U23NnBPi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783015142; c=relaxed/simple;
	bh=/EVp7vzWLJffPrUsHHYcU/91gPzHb8nCxVICEbWpxVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SmqYccKwcX+rf2JFFt/hrn3RVidRQjOd6o4VcyOTAbg84d3qxFG5HVMKIj4p8DurulYyAQY6QwIUU78O3AeuZVJEnluC84Y+lGnvILkqbgV4LXc5sNILbhsYcAPbbky4wa/aUhqeNOEPPGs7rkiOsRus/fZXw/DWTGu9NRHRhI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RsyyTXYu; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RsyyTXYu"
Message-ID: <a3a49499-8a0b-4b53-bd1f-4babf7968e27@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783015128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cRyqch+QKBhODAwJQBADCcHAMS9ECCUt1711G193ylg=;
	b=RsyyTXYu8mtytqPLEnXriVLL92GA5kHqhWxTGz5NEFMrPpMFsD9SY9hlowwIs7IIDwhdrM
	ZmSydwJ7xoAxj66qN53jy10EoqyWyTrzegVBRnWaJQIbyrtCgQaPGVB0n1QOisLZxr8FuQ
	kx+z8W1GeeTJdgjGoqo16XPoigSgyUA=
Date: Thu, 2 Jul 2026 10:58:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] tools/resolve_btfids: Include libsubcmd headers directly
 from source tree
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260702-libsubcmd-spam-v1-1-300ec142a62f@linutronix.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260702-libsubcmd-spam-v1-1-300ec142a62f@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2026-07-02 1:26 a.m., Thomas WeiÃschuh wrote:
> Currently each build with resolve_btfids enabled unnecessarily prints
> the line 'INSTALL libsubcmd_headers' from libsubcmd.
> 
> Use the libcmd headers from source tree instead, without installation.
> 
> The same was done for objtool in commit ac999926774a ("objtool: Include
> libsubcmd headers directly from source tree"), albeit for a different
> reason.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

LGTM, thanks!

Tested-by: Ihor Solodrai <ihor.solodrai@linux.dev>

> ---
> Changes in v2:
> - Rebase on v7.2-rc1.
> - Change the resolve_btfids rules instead of the libsubcmd ones
> - Link to v1: https://lore.kernel.org/lkml/20260303-libsubcmd-spam-v1-1-d0749e3c7998@linutronix.de/
> ---
>   tools/bpf/resolve_btfids/Makefile | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> index 7672208f65e4..bb0463b380af 100644
> --- a/tools/bpf/resolve_btfids/Makefile
> +++ b/tools/bpf/resolve_btfids/Makefile
> @@ -40,7 +40,6 @@ LIBBPF_DESTDIR := $(LIBBPF_OUT)
>   LIBBPF_INCLUDE := $(LIBBPF_DESTDIR)include
>   
>   SUBCMD_DESTDIR := $(SUBCMD_OUT)
> -SUBCMD_INCLUDE := $(SUBCMD_DESTDIR)include
>   
>   BINARY     := $(OUTPUT)/resolve_btfids
>   BINARY_IN  := $(BINARY)-in.o
> @@ -56,7 +55,7 @@ $(OUTPUT) $(OUTPUT)/libsubcmd $(LIBBPF_OUT):
>   $(SUBCMDOBJ): fixdep FORCE | $(OUTPUT)/libsubcmd
>   	$(Q)$(MAKE) -C $(SUBCMD_SRC) OUTPUT=$(SUBCMD_OUT) \
>   		    DESTDIR=$(SUBCMD_DESTDIR) $(HOST_OVERRIDES) prefix= subdir= \
> -		    $(abspath $@) install_headers
> +		    $(abspath $@)
>   
>   $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUT)
>   	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=$(LIBBPF_OUT)    \
> @@ -77,7 +76,7 @@ HOSTCFLAGS_resolve_btfids += -g \
>             -I$(srctree)/tools/include \
>             -I$(srctree)/tools/include/uapi \
>             -I$(LIBBPF_INCLUDE) \
> -          -I$(SUBCMD_INCLUDE) \
> +          -I$(srctree)/tools/lib \
>             $(LIBELF_FLAGS) \
>             -Wall -Werror
>   
> 
> ---
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> change-id: 20260213-libsubcmd-spam-1f52f0d0c579
> 
> Best regards,
> --
> Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> 


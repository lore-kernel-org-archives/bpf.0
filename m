Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721CC13D503;
	Fri,  3 Jul 2026 23:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783123068; cv=none; b=pDsut26Pv3r9xLtwVbWhP+YFJteBc+8Kc4uv2koZ1/X+fvY0fiTvdz/wrCdkl8Uytz1OpS2zx1kDiI1EiyaoRlg6eI7ZI8C4juSXigzIivxPY6PVLmVDW6xURf0lbvw/Yq7ao+9NI4TFoy7xEBfagukXXRKU8gBBYWF9knVV7cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783123068; c=relaxed/simple;
	bh=ENTl7z3TN91jBc+iAmUi7jcDozLWXfLEwdgXHj4Mqgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMXXAnrIXugO0OlJcQkw5eZXrflT4r8V+5RIh8U2cdfXG9ZiIQrnJ4dDR8MKfZm6QqJCTmKkr2Kk9F7DPXqc6e83ZZ9cPBFoUxwH6FSmvPvbxJ4fRPRQ1WkzMrRXDpOkFsVXXg736H+aAX3VB58g3NteAxm0oEDUlEY4ApnPQks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvnyUNib; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvnyUNib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83ACC1F000E9;
	Fri,  3 Jul 2026 23:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783123067;
	bh=KQ6QM7u06o+vMguvYNXIsh/RT+YusHp7obtYOfK8MFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fvnyUNibD+qNBZxEhUqZ6apmsHUDqMxpKFuQUoZ+FV4kZ5tZvpeZJQhmC6N1jYBYC
	 fi+rPGXxTTkAoqzvZKAXj8JMBM72yGg3JJqTUmJ6Ns23KPUMEvKelEOXHRemHXiOXC
	 vBYphWRODET1YCCcluPGYWTb4EcN2zwE8YsMQ3Cu2bwRYIQ9uE9pXFWsvK/3ulL5IU
	 32uYHsY95fMUvVMxEO6DgONxJkcRtcEcsYZ6gOlHlfGtvwDSC5RAIzW+/3/OV2XdDl
	 8ST+42QG7EYOXehS48uIk+HF01eKFarC57WRX1YRamjvhxZEz63rCI0vwBnk7iYb39
	 uKUGbqdd4gU4A==
Date: Fri, 3 Jul 2026 16:57:44 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] tools/resolve_btfids: Include libsubcmd headers directly
 from source tree
Message-ID: <akhMeJgrYvbW7Ako@google.com>
References: <20260702-libsubcmd-spam-v1-1-300ec142a62f@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260702-libsubcmd-spam-v1-1-300ec142a62f@linutronix.de>

Hello,

+CC Ian

On Thu, Jul 02, 2026 at 10:26:30AM +0200, Thomas Weißschuh wrote:
> Currently each build with resolve_btfids enabled unnecessarily prints
> the line 'INSTALL libsubcmd_headers' from libsubcmd.
> 
> Use the libcmd headers from source tree instead, without installation.
> 
> The same was done for objtool in commit ac999926774a ("objtool: Include
> libsubcmd headers directly from source tree"), albeit for a different
> reason.

I think the intention was to avoid dependencies on internal headers.
See af03299d8536d ("tools/resolve_btfids: Install subcmd headers").

Thanks,
Namhyung

> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
> Changes in v2:
> - Rebase on v7.2-rc1.
> - Change the resolve_btfids rules instead of the libsubcmd ones
> - Link to v1: https://lore.kernel.org/lkml/20260303-libsubcmd-spam-v1-1-d0749e3c7998@linutronix.de/
> ---
>  tools/bpf/resolve_btfids/Makefile | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> index 7672208f65e4..bb0463b380af 100644
> --- a/tools/bpf/resolve_btfids/Makefile
> +++ b/tools/bpf/resolve_btfids/Makefile
> @@ -40,7 +40,6 @@ LIBBPF_DESTDIR := $(LIBBPF_OUT)
>  LIBBPF_INCLUDE := $(LIBBPF_DESTDIR)include
>  
>  SUBCMD_DESTDIR := $(SUBCMD_OUT)
> -SUBCMD_INCLUDE := $(SUBCMD_DESTDIR)include
>  
>  BINARY     := $(OUTPUT)/resolve_btfids
>  BINARY_IN  := $(BINARY)-in.o
> @@ -56,7 +55,7 @@ $(OUTPUT) $(OUTPUT)/libsubcmd $(LIBBPF_OUT):
>  $(SUBCMDOBJ): fixdep FORCE | $(OUTPUT)/libsubcmd
>  	$(Q)$(MAKE) -C $(SUBCMD_SRC) OUTPUT=$(SUBCMD_OUT) \
>  		    DESTDIR=$(SUBCMD_DESTDIR) $(HOST_OVERRIDES) prefix= subdir= \
> -		    $(abspath $@) install_headers
> +		    $(abspath $@)
>  
>  $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUT)
>  	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=$(LIBBPF_OUT)    \
> @@ -77,7 +76,7 @@ HOSTCFLAGS_resolve_btfids += -g \
>            -I$(srctree)/tools/include \
>            -I$(srctree)/tools/include/uapi \
>            -I$(LIBBPF_INCLUDE) \
> -          -I$(SUBCMD_INCLUDE) \
> +          -I$(srctree)/tools/lib \
>            $(LIBELF_FLAGS) \
>            -Wall -Werror
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

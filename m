Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058713264F0
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 20:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772568390; cv=none; b=Z7pag0hfRJuV0rtDbOmKohSX1D6GGwlj4ZeZcuWm9U9ggZfdNTkNSORqZiWvTve9US3yOC7Kqwmha7t1Agmu4vvqwAmyK7Roki3vnJsRUT5klVM1PxeQPL9+KO/4fHuRNu7RoUox8ILRL9HpFKglXrb67LxexSngV4lNZMq7ctE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772568390; c=relaxed/simple;
	bh=Y6Rj33OmnjfnzsAXZI0lsSVr46CvveIp4yRhyTrUNMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPwDErhteFn6nOOVBMwJqKFlLx9bBfzftC9qIBsGDELqGFkzJdzgqvb55Oeo9PiPczKJmkZE2DOw2Y7ln4rU4jzYxE8PRDB09y8bIffxXv5k5aK/JdurowH8FmPjDXoEi5f+c++HnC1Jdj0wQpCqgy7WN2QaDK9cEbM4nmjKpUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 2FCFC72C8F5;
	Tue,  3 Mar 2026 23:06:21 +0300 (MSK)
Received: from altlinux.org (unknown [193.43.10.9])
	by imap.altlinux.org (Postfix) with ESMTPSA id 1BE3A36D00D3;
	Tue,  3 Mar 2026 23:06:21 +0300 (MSK)
Date: Tue, 3 Mar 2026 23:06:20 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH bpf v2] resolve_btfids: Fix linker flags detection
Message-ID: <aac-hefhJ8znydSb@altlinux.org>
References: <20260303193954.1879948-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20260303193954.1879948-1-ihor.solodrai@linux.dev>

Ihor,

On Tue, Mar 03, 2026 at 11:39:54AM -0800, Ihor Solodrai wrote:
> The "|| echo -lzstd" default makes zstd an unconditional link
> dependency of resolve_btfids. On systems where libzstd-dev is not
> installed and pkg-config fails, the linker fails:
> 
>   ld: cannot find -lzstd: No such file or directory
> 
> libzstd is a transitive dependency of libelf, so the -lzstd flag is
> strictly necessary only for static builds [1].
> 
> Remove ZSTD_LIBS variable, and instead set LIBELF_LIBS depending on
> whether the build is static or not. Use $(HOSTPKG_CONFIG) as primary
> source of the flags list.
> 
> Also add a default value for HOSTPKG_CONFIG in case it's not built via
> the toplevel Makefile.
> 
> [1] https://lore.kernel.org/bpf/4ff82800-2daa-4b9f-95a9-6f512859ee70@linux.dev/
> 
> Reported-by: BPF CI Bot (Claude Opus 4.6) <bot+bpf-ci@kernel.org>
> Reported-by: Vitaly Chikunov <vt@altlinux.org>
> Closes: https://lore.kernel.org/bpf/aaWqMcK-2AQw5dx8@altlinux.org/
> Fixes: 4021848a903e ("selftests/bpf: Pass through build flags to bpftool and resolve_btfids")
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> 
> ---
> 
> v1: https://lore.kernel.org/bpf/20260302231058.916946-1-ihor.solodrai@linux.dev/
> 
> ---
>  tools/bpf/resolve_btfids/Makefile | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> index ef083602b73a..7672208f65e4 100644
> --- a/tools/bpf/resolve_btfids/Makefile
> +++ b/tools/bpf/resolve_btfids/Makefile
> @@ -23,6 +23,7 @@ RM      ?= rm
>  HOSTCC  ?= gcc
>  HOSTLD  ?= ld
>  HOSTAR  ?= ar
> +HOSTPKG_CONFIG ?= pkg-config
>  CROSS_COMPILE =
>  
>  OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/
> @@ -63,10 +64,14 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
>  		    $(abspath $@) install_headers
>  
>  LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
> +
> +ifneq ($(filter -static,$(EXTRA_LDFLAGS)),)
> +LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs --static 2>/dev/null || echo -lelf -lzstd)
> +else
>  LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
> +endif
>  
>  ZLIB_LIBS  := $(shell $(HOSTPKG_CONFIG) zlib --libs 2>/dev/null || echo -lz)

Perhaps, this line is not needed either, as `pkg-config libelf --libs
--static` will add -lz.

Thanks,

> -ZSTD_LIBS  := $(shell $(HOSTPKG_CONFIG) libzstd --libs 2>/dev/null || echo -lzstd)
>  
>  HOSTCFLAGS_resolve_btfids += -g \
>            -I$(srctree)/tools/include \
> @@ -76,7 +81,7 @@ HOSTCFLAGS_resolve_btfids += -g \
>            $(LIBELF_FLAGS) \
>            -Wall -Werror
>  
> -LIBS = $(LIBELF_LIBS) $(ZLIB_LIBS) $(ZSTD_LIBS)
> +LIBS = $(LIBELF_LIBS) $(ZLIB_LIBS)
>  
>  export srctree OUTPUT HOSTCFLAGS_resolve_btfids Q HOSTCC HOSTLD HOSTAR
>  include $(srctree)/tools/build/Makefile.include
> -- 
> 2.53.0

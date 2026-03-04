Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397CC3101A0
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 19:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772653633; cv=none; b=t7HWjyK0oeGSHeKeHEzwqslcOOLepq7jz6QXQac3kPtly/3ID5iW8027b6N8bYRI1gqtmMnACNNGIq+VPdK5JM0zUjssR4AZ9PfqxwF0APybxsGIXYbD6XGmhdRl8Wr9pnlM6pYSFD2FmXh+TJSy7hmUeUcu5XQrlNPU8MQVZso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772653633; c=relaxed/simple;
	bh=mbcWJ1y/JSYEt1BCxjKYF7wja68dDdYb9FvgZ3GQLQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mN1yUNCg4Zp0ZJd7cqM/JJYkABD1LUdsl/EULN80hTVZUdFWD3r1nn5epk1F8hpJ5GcYZ9eCz8Hewwy1QDxNNrXleWBNO14+o+k1cWQGK+Er1XvbXkkw+Olgp6sfd5iiLYOejV4zYfUNxARGlVCELdFGzjcTcX8afODJhayBIdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id B538B72C8F5;
	Wed,  4 Mar 2026 22:47:09 +0300 (MSK)
Received: from altlinux.org (unknown [193.43.10.9])
	by imap.altlinux.org (Postfix) with ESMTPSA id A462A36D00D3;
	Wed,  4 Mar 2026 22:47:09 +0300 (MSK)
Date: Wed, 4 Mar 2026 22:47:09 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH bpf v2] resolve_btfids: Fix linker flags detection
Message-ID: <aaiLE0pz-YRHfxx5@altlinux.org>
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

Btw, pkg-config accepts -static, so you can do just

-LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
+LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs $(filter -static,$(EXTRA_LDFLAGS)) 2>/dev/null || echo -lelf)

Thanks,

>  
>  ZLIB_LIBS  := $(shell $(HOSTPKG_CONFIG) zlib --libs 2>/dev/null || echo -lz)
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

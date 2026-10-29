Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793278463;
	b=ZaIJImsylile2Hy5+F0IgSQWu7cinz4ZUEssECgTTFfdJ3UTqQ8hQaJtEi/jEOcdExFk
	 54eirW+fz+fnBKU32iqWOZNB2bxD2H9SjWWEfNKMG60th1oM6Q17m7REkZkF4aurF8MY9
	 bvvtbWKPSgmNoc+rBKI1tqtbK4TBwFAP1meKFfDr+jaZ99GD6Jc7DgQ/D35cEbX227EX/
	 vEeTyQzlaWhC8fxSQ+xtuQEtGYBEatYUtuT4MzVrK0yZhCoDwtGcX1ODgDgKOqZzSZ/5w
	 quMhbYx+Y9c2K6W5BszTYa2tE2al4rmcB5ZrQseZ+jAqjrXClGph6j4fWkHpxhIe+XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278463;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LOdfpoSoH5xDfKCpkm+SMk7r95nW+0FEtsmP57iByjI=;
	b=oP4Es5iNLlnWZumJihKrKNopQUBkJlc4Qq5RpqkBOmFytOXYxUk8fUv3UVCEs/OouSqd
	 lVEOt0/HZ6nqneFzrxystTImfA3t45p4AYL5REotRqfSnaGsgrIBfMW3KesalQ1Nstwfo
	 qxAdXyXrVWXzKpLQFJN48RtEo+8zMdapWfgu1i2Aj1GFUtzdGfge41Ea2gNzQc7FTNGCT
	 RDMK8zTxfDhtot99XqJSCuIGwXDN8pizmXuomnTIxUi4xGcgKZDGqU3HwseiOE+ELh2xO
	 xf6tQjOeJzJ/t9TQ3Jvt281QQytMNT3I59Mn9K1X0P4vK9UDLwe7MDerGSUXwPVlmOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NZxe2o2S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B9E606A31F
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 12:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NZxe2o2S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87991F031E0;
	Thu, 29 Oct 2026 12:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793278461;
	bh=LOdfpoSoH5xDfKCpkm+SMk7r95nW+0FEtsmP57iByjI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NZxe2o2SkkDn390XdL8NeG7TxUyr58opRz4ZfMLA3cKRNoV4A6ZvKjMklGbb2sjH2
	 IZcXJLCCAZgf7Gi9PncFd5PKwqiF7AKAcGZM6NSUXeT7+ttKzz54qMJ72NldTAH/ie
	 2NX6HBA+Ex+rJLe2auWyxKFjlsDzDFWiH+j9z/a5P7h9SAzHWdMmvx5xR5fKQsgl+x
	 ZpaTCC/Lz9NzEDozqAwjpW0LWT1zNJkp4IRZnpn7q33j8OJgIKWAO3Q/HdC9rIMcds
	 cxgB3hbMUtM5QPbpU9F52D2KejJyCAtaUAEUjqcUAjP8urOGTH1QwoqHjj94sk8/bz
	 R+zEDT5Ie2aFA==
Message-ID: <sashiko-outbox-189325@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] bpftool: Make the LLVM disassembler an
 optional runtime dependency
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mark Korenberg" <socketpair@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261029-bpftool-plugin-v2-2-1a47b2391b0b@gmail.com>
References: <20261029-bpftool-plugin-v2-0-1a47b2391b0b@gmail.com>
 <20261029-bpftool-plugin-v2-2-1a47b2391b0b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 12:54:21 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpftool: llvm_plugin_find() misses staged plugins and prefers sy=
stem plugin
--

commit aa662f293876360fc9cf9139e86022f88a5bbb64
Author: Mark Korenberg <socketpair@gmail.com>

bpftool: Make the LLVM disassembler an optional runtime dependency

This commit moves the libLLVM-based JIT disassembler into an optional
shared library plugin (bpftool-llvm.so) loaded on demand via dlopen()
when disassembling JITed programs or checking feature availability.

Link: https://github.com/libbpf/bpftool/issues/262

> diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disas=
m.c
> index 5ff144ce84a1c..2691252a115b9 100644
> --- a/tools/bpf/bpftool/jit_disasm.c
> +++ b/tools/bpf/bpftool/jit_disasm.c

[ ... ]

> @@ -45,7 +45,105 @@ static int oper_count;

[ ... ]

> +/*
> + * Look for the plugin in its install directory, then next to the bpftool
> + * binary so that bpftool also works from its build directory. Do not lo=
ok
> + * in the current directory: bpftool usually runs as root, and would then
> + * load any library planted in the directory it is run from.
> + */
> +static int llvm_plugin_find(char *path, size_t size)
> +{
> +	char exe[PATH_MAX];
> +	ssize_t len;
> +	char *dir;
> +	int n;
> +
> +	snprintf(path, size, "%s/%s", LLVM_PLUGIN_DIR, LLVM_PLUGIN_NAME);
> +	if (!access(path, F_OK))
> +		return 0;
> +
> +	len =3D readlink("/proc/self/exe", exe, sizeof(exe) - 1);
> +	if (len < 0)
> +		return -1;
> +	exe[len] =3D '\0';
> +	dir =3D strrchr(exe, '/');
> +	if (!dir)
> +		return -1;
> +	*dir =3D '\0';
> +
> +	n =3D snprintf(path, size, "%s/%s", exe, LLVM_PLUGIN_NAME);
> +	if (n < 0 || (size_t)n >=3D size)
> +		return -1;
> +	return access(path, F_OK);
> +}

[Severity: Medium]
Can llvm_plugin_find() fail to locate bpftool-llvm.so when bpftool is
installed into a staging directory via DESTDIR, such as in the BPF
selftests build?

In tools/testing/selftests/bpf/Makefile, $(DEFAULT_BPFTOOL) and
$(CROSS_BPFTOOL) are built and staged with:

tools/testing/selftests/bpf/Makefile:
	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)			       \
		    ...
		    OUTPUT=3D$(HOST_BUILD_DIR)/bpftool/			       \
		    ...
		    prefix=3D DESTDIR=3D$(HOST_SCRATCH_DIR)/ install-bin

Because prefix=3D is empty and libdir is not overridden, tools/bpf/bpftool/=
Makefile
sets libdir to /lib and compiles jit_disasm.o with:

tools/bpf/bpftool/Makefile:
	prefix ?=3D /usr/local
	libdir ?=3D $(prefix)/lib
	...
	CFLAGS +=3D -DLLVM_PLUGIN_DIR=3D'"$(libdir)/bpftool"'

Meanwhile, the install-bin target places the binary and plugin in separate
directories under $(DESTDIR):

tools/bpf/bpftool/Makefile:
	install-bin: $(OUTPUT)bpftool $(LLVM_PLUGIN)
		$(call QUIET_INSTALL, bpftool)
		$(Q)$(INSTALL) -m 0755 -d $(DESTDIR)$(prefix)/sbin
		$(Q)$(INSTALL) $(OUTPUT)bpftool $(DESTDIR)$(prefix)/sbin/bpftool
	ifneq ($(LLVM_PLUGIN),)
		$(call QUIET_INSTALL, bpftool-llvm.so)
		$(Q)$(INSTALL) -m 0755 -D -t $(DESTDIR)$(libdir)/bpftool $(LLVM_PLUGIN)
	endif

This installs bpftool to $(HOST_SCRATCH_DIR)/sbin/bpftool and the plugin to
$(HOST_SCRATCH_DIR)/lib/bpftool/bpftool-llvm.so. When the staged bpftool
runs, llvm_plugin_find() checks /lib/bpftool/bpftool-llvm.so and
$(HOST_SCRATCH_DIR)/sbin/bpftool-llvm.so, missing the staged plugin in
$(HOST_SCRATCH_DIR)/lib/bpftool/bpftool-llvm.so (causing "bpftool prog dump
jited" to fail and "bpftool version" to omit the llvm feature).

Additionally, because llvm_plugin_find() checks LLVM_PLUGIN_DIR before the
directory of /proc/self/exe, wouldn't running an uninstalled ./bpftool from
its build directory on a host where $(LLVM_PLUGIN_DIR)/bpftool-llvm.so is
already installed load the system plugin instead of ./bpftool-llvm.so next
to the binary (and fail without falling back if the installed plugin has a
different BPFTOOL_LLVM_ABI_VERSION or incompatible sanitizer flags)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-bpftool-pl=
ugin-v2-0-1a47b2391b0b@gmail.com?part=3D2

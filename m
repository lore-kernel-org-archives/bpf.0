Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F6B3C1D78;
	Wed, 23 Sep 2026 05:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790143147; cv=none; b=oag2JSqCWS6xji7ScrdLRt4DTosVyfhlZBvyNnb/EkjuOqNVl7g8+xBCY2arBAYrUEJ9neHOjZhtUputiXQE+C4eaeIbZeEK4a2ZJP4pdhN2AEnSpcZNOg4KbsqM6Iu/1w7S+BsdWTv3Nhh9G5DbKN1vRSeoKCHmdfqTgMMzu6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790143147; c=relaxed/simple;
	bh=M+Dh18T30Y7l0FjzQwUTMpr2r1Egz5+CpN8CPIQz6GE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uP8rd9qg5oFMPHsceq+BNnbFwH8Z1JKALQiF3bXMii5Dvqo0mZDFcg/vDBk3DwGUmAAQLMww1PvFdFW450S+sNIbE1egwqegxmis06eOKq3acg2xs9oglsjH5gcBET+cW6slE0nbSjK5yCptncegINqYp7qg/yZDYnAMWEsXd2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoP1fRht; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoP1fRht"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA941F000FF;
	Wed, 23 Sep 2026 05:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790143145;
	bh=KY6QslC0AqZ8ob0If7C66yuuQZpv9s+3WWjtuA9bAbk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MoP1fRhtHX5oYZsYLu0G4F+PfCY0R41F9z+bv8QX1Fel4IGIng3apFl1ZXU7sK9aB
	 +dI1O3c8LERKUCNKaXl/kwpevPHZn74v7ahQpoVe/twllW8MulA3KUiMyCWd1pT5m8
	 0yW53FpCVvDxqg+Xc+MHBlVxZFnXIyA+NbPcMC+RV4tXd9x33oHYO6zy5BGg74OUEk
	 tYqt7rqeZ2+0GxpqNUSUg5QFtg+UvzRDQnJYS5PMZnHBHGf68v+MEfi7kq3C8S5Xf5
	 FwsuSzak88JUGYgztekBcVNliP6AAX/qGadXMQeLp1X8zcYrDHPf0heU+Yt+S9F4iv
	 ktiiD+ENO+0Mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 6/6] kbuild, bpf: allow building the vmlinux
 BTF as a module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jay Wang" <wanjay@amazon.com>
Cc: bpf@vger.kernel.org, linux-modules@vger.kernel.org
In-Reply-To: <20260923053948.30617-7-wanjay@amazon.com>
References: <20260923053948.30617-1-wanjay@amazon.com>
 <20260923053948.30617-7-wanjay@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 05:59:05 +0000
Message-Id: <20260923055905.ACA941F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] kbuild: global module relinks when CONFIG_DEBUG_INFO_BTF=3Dm
- [Low] kbuild: non-POSIX head -c in gen-btf.sh breaks strict environments
--

commit 7587d72dd889263f91882b475224bac4cf470c15
Author: Jay Wang <wanjay@amazon.com>

kbuild, bpf: allow building the vmlinux BTF as a module

This commit makes CONFIG_DEBUG_INFO_BTF a tristate, allowing the vmlinux BT=
F=20
to be built as a module (btf_vmlinux) rather than part of the kernel image.=
=20
It defers loading the BTF until it is first needed, saving memory on system=
s=20
where it goes unused.

> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index 01a37ec872b90..ad182f84b5fcf 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal

[ ... ]

> -# Re-generate module BTFs if either module's .ko or vmlinux changed
> -%.ko: %.o %.mod.o .module-common.o $(objtree)/scripts/module.lds $(and $=
(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),$(objtree)/vmlinux) FORCE
> -	+$(call if_changed,ld_ko_o)
> +# Modules that get a .BTF section: all of them with CONFIG_DEBUG_INFO_BT=
F_MODULES,
> +# otherwise only the vmlinux BTF carrier module with CONFIG_DEBUG_INFO_B=
TF=3Dm.
>  ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> -	+$(if $(newer-prereqs),$(call cmd,btf_ko))
> +btf-modules :=3D $(modules:%.o=3D%.ko)
> +else ifeq ($(CONFIG_DEBUG_INFO_BTF),m)
> +btf-modules :=3D $(filter %/btf_vmlinux.ko,$(modules:%.o=3D%.ko))
>  endif
> +
> +# Re-generate module BTFs if either module's .ko or vmlinux changed
> +%.ko: %.o %.mod.o .module-common.o $(objtree)/scripts/module.lds $(and $=
(btf-modules),$(KBUILD_BUILTIN),$(objtree)/vmlinux) FORCE

[Severity: High]
Will this implicit rule globally add vmlinux as a prerequisite to every mod=
ule
if btf-modules is non-empty?

When CONFIG_DEBUG_INFO_BTF=3Dm and CONFIG_DEBUG_INFO_BTF_MODULES is disable=
d,
btf-modules evaluates to kernel/bpf/btf_vmlinux.ko. Since btf-modules is
non-empty, the $(and $(btf-modules),$(KBUILD_BUILTIN),$(objtree)/vmlinux)
expression will evaluate to $(objtree)/vmlinux for the generic %.ko target.

Does this inject vmlinux as a prerequisite for every module in the tree (not
just btf_vmlinux.ko), triggering broad unnecessary relinks of all kernel
modules whenever a built-in file is modified during incremental builds?

> +	+$(call if_changed,ld_ko_o)
> +	+$(if $(and $(filter $@,$(btf-modules)),$(newer-prereqs)),$(call cmd,bt=
f_ko))
>  	+$(call cmd,check_tracepoint)

[ ... ]

> diff --git a/scripts/gen-btf.sh b/scripts/gen-btf.sh
> index 8ca96eb10a69e..7fa3189a3ded8 100755
> --- a/scripts/gen-btf.sh
> +++ b/scripts/gen-btf.sh

[ ... ]

> @@ -133,6 +190,34 @@ if [ -n "${BTF_BASE}" ]; then
>  	BTFGEN_MODE=3D"module"
>  fi
> =20
> +if [ -n "${PLACEHOLDER}" ]; then
> +	btf_data=3D${ELF_FILE}.btf.o
> +	echo "" | ${CC} ${CLANG_FLAGS} ${KBUILD_CPPFLAGS} ${KBUILD_CFLAGS} -fno=
-lto -c -x c -o ${btf_data} -
> +	head -c 36 /dev/zero > ${ELF_FILE}.BTF.meta

[Severity: Low]
Is it safe to use the non-POSIX -c flag for head here?

The -c option is a GNU/Busybox extension and is not defined in the
POSIX.1-2017 standard. On strict environments where head only accepts
the -n flag, will this cause the kernel build to fail?

> +	${OBJCOPY} --add-section .BTF.meta=3D${ELF_FILE}.BTF.meta \
> +		--set-section-flags .BTF.meta=3Dalloc,readonly ${btf_data}
> +	${OBJCOPY} --only-section=3D.BTF.meta --strip-all ${btf_data}
> +	exit 0
> +fi
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923053948.3061=
7-1-wanjay@amazon.com?part=3D6

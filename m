Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757481F95C
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 00:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769560371; cv=pass; b=F/Mckeod63PA97BMiBce3hIYaqSdpz8gERNrVOx17z86G70bxOATkDqcgXoeGR9hjD+qnv6SqtNglIVu2O97GWRJheEcUyfHsfv8XqWK1W5jR4fV6LmjHndhTfPR5Aq7b4O2jVH/eX6Mq9PhT4xl0Bjuju6usMqibZDdEZzd6Hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769560371; c=relaxed/simple;
	bh=w9TxlwDu59BIqDU8hgTRIOzof0XNIh/h/3X35cFD74Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FJMAbxNcKw8KA89yXfOgiCYeuFb7ILQkHM4iIEfQJIP2JvxXe/LgBLdMonHvfl9SINjYjFur9iqT/pyh1QfeIGzBAYRQOc50P0IziSY1vf/b3wzB+4hDkTWVA38zDToet33anr45g7OiW1IDEVqW8gDwA1EfZWqEbRwa9PLAK0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHiJfsmo; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHiJfsmo"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-435a517be33so3866809f8f.0
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 16:32:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769560368; cv=none;
        d=google.com; s=arc-20240605;
        b=NV0dZNMNijVbwdeHshkNDfAk4grzKLNK1Fgn5owzp/QqMLPQJH8imC9R1RWWA6su/B
         dnfdcVMTJlnbF2JNFv4JPJ34coCBSGjVvpTOhRV8fi/GN9NvjttrApBXFytCodL9r0a+
         /S/FuF55o+zJqgF3fHfPjOVXL6vTAIwkmFT8/gTygBpsSiUunOUos2E05AAEz2DEcBHF
         A4hKJ+CsGE1mw65dkMTbxgwKssQ5WHlO621PxlTV09hrb+RYUlI3D2w33m0DpbcFJKSB
         zPzGlHOWti9clt14UlL+YnXi4qWrc1CVCEfUL2LtthTWNoCcAyLytPVH5Khb0JNVW0gG
         MyjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iN9JZM4kvzKxQQZGQEkWGRac6zc06hX8o9lUu8sgsow=;
        fh=07919j3mEGtUJ+mScCnPzO16vurW6cKq9ZaYr312Wzs=;
        b=Ztbvf7ktOSRUqfZcNRW6eRjGNNhMO2KY1nslZZa5mZqK3GMjSkPnWGgfl7rdeIeHqK
         RkhzBW37VjS0qqzZlUN9F9CAXpCIdqdXiWCYCtYRyrThzZLmEEQBlToSeo9avhwhQott
         6DdW0uh1Q6R5UhI7RKx+087xeaLMJKW9gB3x27ERE4RLDDj/GaZFu7BrcZwj0hR53BG+
         fStft8TOejnxlHXJFcB5Cd7X5NAqZtI8ZtR0c2UQZ4L1nx13HR6PkW86KTtixTcsH69K
         EnjXeTwoTptW3vQMLr5SjBwre/aIGuDKI2Xd154qLcsHoek6Fbe0SZdZukTWGVRLzv4c
         s8pQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769560368; x=1770165168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iN9JZM4kvzKxQQZGQEkWGRac6zc06hX8o9lUu8sgsow=;
        b=kHiJfsmoYKBpS9nC3BGpL+aFiiwv25AdtWITyxK5dDQMT/mB52fheVJTAqbOH6oQrh
         D2mHnNJw+dXTufIpIIr8c3Hme1UMZqIYQ4HzN/im5QVsBmRWV1TO5NFgDrtSo/BrqxL8
         SqEbqNaNgxL+53zvYWxFiZx56FMxeMgWlpN6ul3do9z54Rp+oOUNlym2PyxdVEIMayqH
         TyfDovtDBbzhJlyDQklpaXZ6Y1LNTZFFsJ1pNWSjqZdPjNI1sHXIUlsKDSiax65M/7q1
         G19YlppB5WdV2AWO4ekNoAetxPGItvgZGd8C0biIAjT4QEjMnAkqUjghoq6fMZ84cNKt
         QRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769560368; x=1770165168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iN9JZM4kvzKxQQZGQEkWGRac6zc06hX8o9lUu8sgsow=;
        b=N2Dd9Gbltk7wMsXfuX2ujG0zRbMFHmVM48etEkSI6c6B727mo72j+0yFDkupSO+h0Q
         noVUVOWh/uDck+InPgrvrW4RugUae8RfwlXas69TPPkrv6x57Re/3JKi1/NNfVBA1WIF
         /Z11cSU+z3TJLHXNkTbgYRCzOTAyAIUH2C07nqXcKtyuOe2em6unuZ8G5pa7Id1PMKc7
         oyU2ZeLBJwX4T09xdvw35bQSN/eXGgSc1/1Cae10ilKSFSdL+aYEO20TnMPzkCADunUk
         s3eE6SPPSAU1O1mzvC5FGkASf70ZrrkmwqDAykYcuKKQmXgDWUx9uL9llRJGWx7W8m5r
         Xzlw==
X-Gm-Message-State: AOJu0YyxtrQ3tcznS0sJH72s4Yj97+N+thto7TSTUN0gkoPGbYCYijuK
	I5is2lH7jTN4IlLdO9Uqu7jiMAqWmrKhT6/Eqs5LMaREsGI3dTlNOkbVbXANKDIzDBWHbCYZ2Tl
	J9wNbqAp6XpCjYksPF/UtKPi/KRXwioA=
X-Gm-Gg: AZuq6aIL2SE8FUhyJ3XpabAYjWF0r8SF/lo03C6qtEpfxqX117nTgYjlbEphEoqTDS5
	ynlPRzOhIDqXfGmyd/nevi7Gu4uhtJveHcWtPzNr2kbZf+j20FTvKBElTGX8TomCbhL+Aw68X3F
	1ms8YiCtHvEyQa7pIbLQrRzvCPYAzQjgTBoaARKO1d5zO9zm2/HsTQLEZYuPlUxnsJCKJTGS33Z
	Bu6PmxVrnEkNEQXR+hfOK/ujkc9rLLdWIuseCVWwwEc0XP+Rcz6lwV0BZkRYO4aI2iP4Xo7IoPm
	gwRGxtbeUNxSwhcizxk3SALROei4qXH2qdkHJ4LNkpZHhxlOROMYRU/quS+6KBRoXjrgJ5U/cQ1
	8U45WXz4OlRFPSw==
X-Received: by 2002:a05:6000:2084:b0:435:9ef7:5c3c with SMTP id
 ffacd0b85a97d-435dd0708d4mr4973542f8f.25.1769560367758; Tue, 27 Jan 2026
 16:32:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127181610.86376-1-emil@etsalapatis.com> <20260127181610.86376-6-emil@etsalapatis.com>
In-Reply-To: <20260127181610.86376-6-emil@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 27 Jan 2026 16:32:36 -0800
X-Gm-Features: AZwV_QjaiwAX4Sg6wN82XiV8PLs67R32DdIJ4-o7yOpx3SPvKYkXb8g3KIvo7xQ
Message-ID: <CAADnVQLHH4=VZoAbkcrXrHGZnSa1DnLj7KKW=MDVFwm=pVCJ7Q@mail.gmail.com>
Subject: Re: [PATCH v2 05/13] selftests: bpf: Add basic libarena scaffolding
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, 
	etsal@meta.com, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 10:16=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis.=
com> wrote:
>
> From: Emil Tsalapatis <etsal@meta.com>
>
> Add initial code for an arena-based BPF library. The current commit
> introduces a test runner and Makefile for the library. Library code
> can be added just by including the source file in the library's src/
> subdirectory. Future commits will introduce the library code itself.
>
> Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
> ---
>  tools/testing/selftests/bpf/.gitignore        |   1 +
>  tools/testing/selftests/bpf/Makefile          |  12 +
>  tools/testing/selftests/bpf/libarena/Makefile |  47 ++++
>  .../selftests/bpf/libarena/include/common.h   | 118 +++++++++
>  .../selftests/bpf/libarena/include/userapi.h  |  22 ++
>  .../bpf/libarena/selftests/selftest.c         | 243 ++++++++++++++++++
>  .../bpf/libarena/selftests/selftest.h         |  17 ++
>  7 files changed, 460 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/libarena/Makefile
>  create mode 100644 tools/testing/selftests/bpf/libarena/include/common.h
>  create mode 100644 tools/testing/selftests/bpf/libarena/include/userapi.=
h
>  create mode 100644 tools/testing/selftests/bpf/libarena/selftests/selfte=
st.c
>  create mode 100644 tools/testing/selftests/bpf/libarena/selftests/selfte=
st.h
>
> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selft=
ests/bpf/.gitignore
> index b8bf51b7a0b0..96b4a7e37427 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -48,3 +48,4 @@ verification_cert.h
>  *.BTF
>  *.BTF_ids
>  *.BTF.base
> +libarena/test_libarena
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 9488d076c740..49b275a7bfa1 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -915,3 +915,15 @@ override define INSTALL_RULE
>                 rsync -a $(OUTPUT)/$$DIR/*.bpf.o $(INSTALL_PATH)/$$DIR;\
>         done
>  endef
> +
> +test_libarena: $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ)
> +       +$(MAKE) -C libarena all \
> +               BPFTOOL=3D"$(BPFTOOL)" \
> +               INCLUDE_DIR=3D"$(HOST_INCLUDE_DIR)" \
> +               LIBBPF_INCLUDE=3D"$(HOST_INCLUDE_DIR)" \
> +               BPFOBJ=3D"$(BPFOBJ)" \
> +               LDLIBS=3D"$(LDLIBS) -lzstd" \
> +               CLANG=3D"$(CLANG)" \
> +               BPF_CFLAGS=3D"$(BPF_CFLAGS) $(CLANG_CFLAGS)" \
> +               BPF_TARGET_ENDIAN=3D"$(BPF_TARGET_ENDIAN)" \
> +               Q=3D"$(Q)"
> diff --git a/tools/testing/selftests/bpf/libarena/Makefile b/tools/testin=
g/selftests/bpf/libarena/Makefile
> new file mode 100644
> index 000000000000..70901bb5237f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/Makefile
> @@ -0,0 +1,47 @@
> +.PHONY: clean
> +
> +LIBARENA=3D$(abspath .)
> +
> +
> +LIBARENA_SOURCES =3D $(wildcard $(LIBARENA)/src/*.bpf.c) $(wildcard $(LI=
BARENA)/selftests/*.bpf.c)
> +LIBARENA_OBJECTS =3D $(notdir $(LIBARENA_SOURCES:.bpf.c=3D.bpf.o))
> +
> +INCLUDES =3D -I$(LIBARENA)/include -I$(LIBARENA)/..
> +ifneq ($(INCLUDE_DIR),)
> +INCLUDES +=3D -I$(INCLUDE_DIR)
> +endif
> +ifneq ($(LIBBPF_INCLUDE),)
> +INCLUDES +=3D -I$(LIBBPF_INCLUDE)
> +endif
> +
> +# ENABLE_ATOMICS_TESTS required because we use arena spinlocks
> +override BPF_CFLAGS +=3D -DENABLE_ATOMICS_TESTS
> +override BPF_CFLAGS +=3D -O2 -Wno-incompatible-pointer-types-discards-qu=
alifiers
> +override BPF_CFLAGS +=3D $(INCLUDES)
> +
> +CFLAGS =3D -O2 -no-pie
> +CFLAGS +=3D $(INCLUDES)
> +
> +vpath %.bpf.c $(LIBARENA)/src $(LIBARENA)/selftests
> +vpath %.c $(LIBARENA)/src $(LIBARENA)/selftests
> +
> +all: test_libarena
> +
> +test_libarena: selftest.c $(BPFOBJ) selftest.skel.h
> +       $(call msg,BINARY,libarena,$@)
> +       $(Q)$(CLANG) $(LDLIBS) $(CFLAGS) $< $(BPFOBJ) -o $@
> +
> +selftest.skel.h: main.bpf.o
> +       $(call msg,GEN-SKEL,libarena,$@)
> +       $(Q)$(BPFTOOL) gen skeleton $< name "selftest" > $@
> +
> +main.bpf.o: $(LIBARENA_OBJECTS)
> +       $(call msg,GEN-OBJ,libarena,$@)
> +       $(Q)$(BPFTOOL) gen object $@ $^
> +
> +%.bpf.o: %.bpf.c
> +       $(call msg,CLNG-BPF,libarena,$@)
> +       $(Q)$(CLANG) $(BPF_CFLAGS) $(BPF_TARGET_ENDIAN) -c $< -o $@
> +
> +clean:
> +       $(Q)rm -f *.skel.h *.bpf.o test_libarena
> diff --git a/tools/testing/selftests/bpf/libarena/include/common.h b/tool=
s/testing/selftests/bpf/libarena/include/common.h
> new file mode 100644
> index 000000000000..12fab01d60f9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/include/common.h
> @@ -0,0 +1,118 @@
> +#pragma once

Make sure there is SPDX and copyright in all new files.

> +
> +#ifdef __BPF__
> +
> +/* Suppresses definition conflicts between bpf_experimental.h and vmlinu=
x.h. */
> +#define BPF_NO_KFUNC_PROTOTYPES

That makes little sense to me.
bpf_experimental.h already includes vmlinux.h
There are no conflicts.

> +#include <vmlinux.h>
> +
> +#include "bpf_experimental.h"

pw-bot: cr

Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B16D197A7D
	for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 23:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777246823; cv=pass; b=m71EIop/WyQdjJ0rMSwviMonXNMcbi7XbzrV8iqb/f6LFryxQLPFAvsCsmzwAeIHpPoVToh2DQTDWD8LJx/Xq3RkKCElOyXVZBn833djJM3JNKPlF5uD8sen72dBWR45EUl9WXZIWBZAocx1yg2HVVvtqp+raiDdDpbPFS/cmiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777246823; c=relaxed/simple;
	bh=tgv9IbHsjDZGnGt955jyv5cdZ1cNdTK4AJhVlCube/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GtqIJDw3XnPlJ67ichOuih9qC1tudFd5NGVxul6QscL9JHCcup0typ/Y6DRgr4vYB+1Srkf8Uv/1ZpLFZCRvP1fVwRoW5jNiGxtTE+AXTTi2gWmODJs1bNgmg4u2j+59isrE0Facm2Uu6MCKZVnuaE3rGUnfaxoLvI49ZlyzUaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWCvmZDs; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWCvmZDs"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488b150559bso76414855e9.1
        for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 16:40:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777246820; cv=none;
        d=google.com; s=arc-20240605;
        b=SIK277kjQmstLWakjxWMN1J7cAxB+2bmj1yyafJjw3fo8BU8xZdS2DTD+Q+8LsGVlS
         HzedENWKln9G3aJcgIvxQpH+44n6jCz1JoVViWQJ84eez+bdvAHaulS0wbjBS5uDZFjo
         bBPGO6M0+ZKYe4mAzR/C+Znx667iz6CnZTnoxcOptasd64j/c5rXAPBW7oGhurXJbY/N
         YLDoYwwgB2DG8retmqDbPQHZnXXU7RCQJR40xDCIJ53chtw8qw0DKqyzBf52HSXsKw/q
         1mENBQ4bZpDs4b+BxbrdyKu0QXa6VybXBEoxvTHODgT1oe38bQUpK6w120Jj5svLtOuW
         pspg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FbCgn9rXCZJWWcYjZxlUF/1JgeA3ASV63XA0f6EaFq0=;
        fh=vBDNxc8ShJs6EcvnOusTqCjkS82AzexefUu+STh9XKo=;
        b=IrYlOWDneLUcL0XFIg06elfDfqJMRIwxEJAz/r7Ikit2tndlwaqSAzfYack3/NByW6
         fbIQidKEP/wQ7McGzXlSxd8pgZvhNkNmWgLnjbwh+UM13mVQLt+nlsGFAlbRVS/AAtWV
         KDoYK7cyXnwDOo6V7mJsI5/QcXex4cSLDAf46QGEkGVFjjIEyj38ZnN/5UgKgr0r+U6r
         csR02/+JSagc8ejUYAwNAqGuny1CEQ9msWhKUJ9D7C34CBxIr4aRVO1x1NI4aP1tHSig
         v8TuJU3WsQdsJkwQMalj7gh8s/OXpd94xN+cgvKTl58QhsU+/fdpR3EUzp6Fz7znQdoh
         zdNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777246820; x=1777851620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbCgn9rXCZJWWcYjZxlUF/1JgeA3ASV63XA0f6EaFq0=;
        b=ZWCvmZDswc0g1kZpD1tz8nUWnlhim//YjV/ueTP6tERTnzQKTwU8yBmt9V3L7zgF9y
         4l1pA062qMOxLIkPKtwLP4ZWP1Ei8Hg+FbIyVb8KagkYEsFS38x/C8PjjaFhKUeQFpF4
         KDxwLPx4J5KE93bOvuxTEKcIAeqypQo7YA9yPtRnGrQWw2DnZAvtWKX2zOFCMwfHHUwr
         pBM7eG0UTWdZGsIuKh+Ze7aiXW0HyS9QreiXaO/Lz+oJEbFhs1WPsuIbx6dFfS6uNgRA
         +2X8vAM/slz/jKoWMzE9XlGoA3QI/IUt4G/dp63emF9QxRpUUk7+La62bWM63+uVSQpD
         RNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777246820; x=1777851620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FbCgn9rXCZJWWcYjZxlUF/1JgeA3ASV63XA0f6EaFq0=;
        b=BFag9ObMzwiU6tVldMmY1O58hAqEkiPZxMwls+r+nVmPSiV6Zcc0YHSlygpXcF9prV
         5P61F4MK9JSeEDEcB7jdKCYHwHvyL8FbKOFkOkT3LVfBXCVBuJEVyyYP9N8AAv2ePX2g
         v3+ctTfqtMb195M+l/h57Rgt9wHzmQMSWCQtV0ee4P672um+j64K1sKOlwpA2KQgIUMQ
         SydYsT/RuU17rA2zVJ0o6hX2eXfAkoIBgyjvpi8xS/5ycIo8USlJaEIkgdWbpGlY/y5H
         4lUrSi6SovLsT4h3sOa3YA/zZ6I8+cG9yEtUy16cOu0qJT23WUYibkhcf2pi1uLdgwV5
         flbw==
X-Forwarded-Encrypted: i=1; AFNElJ9XyeCL67ZPmH2unjqYIk2qqlXxqwUHAirGiBnd9dnBfdkU2qgLBySzsP4hybesnmqAp2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye6O4OlGDuJNqCY7PJwvRdWbHgo0EapxRr4BxRV7o+rpfFlMb9
	4TPXYMaTRqbqM62oMT2qjpjwQld3Y55vS44O7/0dUzJVsDFIYHJRxmCHhheCx1ZFY9c/XcwxUTT
	aaW3yNJf2hD0qogYFmyQJTEcOAMs3AHM=
X-Gm-Gg: AeBDiesCggRPSdPIpybmhQjL2s7q+d7/IjsqLa38Qbz5775yTGadaJTmnZQd0wHWN7Z
	njLRmYLylgYbi532lddvkfolJI6o1qr1swXbjEHJ95ELYUvfVkGxuqIaEBnp0h2eU0NiLq4A7VZ
	X1w2Vv2p9D+q33umLi8sgnu2x2AAVSLzgu+cvUNd9KfBC428gobudtK2RXt0uzSEDuG90dC3a/U
	R6i5hcHCHGUTNE/Z77HixIemRnHhBRP2AvVD3SwnHIVGRU95R/NTBQ4YS9XxT4ReTeFo3oeonus
	WnDnm7xnpCvX8r4+BZSTNAVCTnmk4/HGPpTaHf5qFfndvBW/70y9qrMR9yJsgoLi5LC7Xfujwm2
	kTiSc
X-Received: by 2002:a05:600c:348b:b0:489:5022:39a4 with SMTP id
 5b1f17b1804b1-4895040c025mr436061715e9.9.1777246820349; Sun, 26 Apr 2026
 16:40:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416-selftests-bpf_misconfig-v6-2-7efeab504af1@suse.com> <20260416125321.7AF09C2BCAF@smtp.kernel.org>
In-Reply-To: <20260416125321.7AF09C2BCAF@smtp.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 26 Apr 2026 16:40:09 -0700
X-Gm-Features: AVHnY4L3bl7RsnqeiuApcRGkb6NMQeyc2g0VwPPmbTcx3VLul4GfBburwUZv50A
Message-ID: <CAADnVQLXvs_+c67FH5rk15L+QDGS0=UovgOaTvHeQ9-_suzo=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 02/11] selftests/bpf: Fix test_kmods KDIR to
 honor O= and distro kernels
To: sashiko@lists.linux.dev
Cc: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 5:53=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 2 potential issue(s):
> - [Medium] Relative paths passed via `O=3D` are incorrectly evaluated fro=
m the kernel source root instead of the invocation directory.
> - [Medium] The `make clean` target unconditionally fails and aborts the b=
uild if the kernel source tree is unconfigured and distro headers are missi=
ng.
> --
>
> commit 533e8d39cc98f56f3dff4f8c5bff0dcd49fc6ef1
> Author: Ricardo B. Marli=C3=A8re <rbm@suse.com>
>
> selftests/bpf: Fix test_kmods KDIR to honor O=3D and distro kernels
>
> This commit modifies test_kmods/Makefile to honor O=3D and KBUILD_OUTPUT,=
 and
> adds a fallback to /lib/modules/$(uname -r)/build for distro kernels. It =
also
> makes missing KDIR silently skipped when building in permissive mode.
>
> > diff --git a/tools/testing/selftests/bpf/test_kmods/Makefile b/tools/te=
sting/selftests/bpf/test_kmods/Makefile
> > index 63c4d3f6a12f6..10f202bd0d8c2 100644
> > --- a/tools/testing/selftests/bpf/test_kmods/Makefile
> > +++ b/tools/testing/selftests/bpf/test_kmods/Makefile
> > @@ -1,5 +1,7 @@
> >  TEST_KMOD_DIR :=3D $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LI=
ST)))))
> > -KDIR ?=3D $(abspath $(TEST_KMOD_DIR)/../../../../..)
> > +SRCTREE_KDIR :=3D $(abspath $(TEST_KMOD_DIR)/../../../../..)
> > +KMOD_O :=3D $(or $(O),$(KBUILD_OUTPUT))
>
> Will this break out-of-tree builds if a user passes a relative path?
>
> If a user builds selftests with a relative O=3D path (e.g. make O=3Dout),=
 KMOD_O
> captures this relative string and passes it unaltered to the kernel build
> system via make -C $(KDIR) O=3D$(KMOD_O).
>
> Because make -C changes the working directory to $(KDIR) before evaluatin=
g
> O=3D, the relative path will be evaluated relative to the kernel root rat=
her
> than the directory where make was originally invoked.
>
> [ ... ]
> > @@ -14,8 +16,24 @@ $(foreach m,$(MODULES),$(eval obj-m +=3D $(m:.ko=3D.=
o)))
> >
> >  CFLAGS_bpf_testmod.o =3D -I$(src)
> >
> > +# When BPF_STRICT_BUILD !=3D 0, a missing KDIR is fatal (the default).
> > +# When permissive, skip silently.
> > +PERMISSIVE :=3D $(filter 0,$(BPF_STRICT_BUILD))
> > +
> >  all:
> > -     $(Q)$(MAKE) -C $(KDIR) M=3D$(TEST_KMOD_DIR) modules
> > +ifeq ($(PERMISSIVE),)
> > +     $(Q)$(MAKE) -C $(KDIR) $(if $(KMOD_O),O=3D$(KMOD_O),KBUILD_OUTPUT=
=3D) \
> > +             M=3D$(TEST_KMOD_DIR) modules
>
> [ ... ]
>
> >  clean:
> > -     $(Q)$(MAKE) -C $(KDIR) M=3D$(TEST_KMOD_DIR) clean
> > +ifeq ($(PERMISSIVE),)
> > +     $(Q)$(MAKE) -C $(KDIR) $(if $(KMOD_O),O=3D$(KMOD_O),KBUILD_OUTPUT=
=3D) \
> > +             M=3D$(TEST_KMOD_DIR) clean
>
> Does this unconditionally abort make clean if the kernel source tree is
> unconfigured and distro headers are missing?

I think both issues flagged are valid and need to be addressed.

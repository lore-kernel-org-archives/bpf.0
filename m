Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D4C39B959
	for <bpf@vger.kernel.org>; Sun, 12 Jul 2026 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783846621; cv=pass; b=mU4Q/EFoQgsgaNhuP26V3uW5pRm2QhNCapiysjbyB909QIKEcJW68fQnWuDBzJyYzk3OpjPL6YpmGsTDBuFt0P6qSh96vVTguMysYeO7u/rm5PqHdwUrLfEzu+QTdZ8B2v3MXdDUEVhcrRHXdItJjWqGUVdbyTc+W/BB2TJ0JsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783846621; c=relaxed/simple;
	bh=BTKdcA8TI1tNpMMoU4EnrgdDcYmwA5L5/bKy9npVeAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebeLgdHCWRz/vJLRVFazJm+/LJcIJKoVGWu9RBLMpmGOGKxogY4RDnznAcPdUKFATwHlLxa5Ibv4vZpvUZOlLC/7xIhcc/ByKxc0eqwobpTLdi9nNShuGSyYsDqsZrZNMOxDWg7DuFJQKcLKT9ldj8CRpWdTUIkEniKCa6Sg2zY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROQcXRiO; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROQcXRiO"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-664b05d408bso1959367d50.1
        for <bpf@vger.kernel.org>; Sun, 12 Jul 2026 01:56:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783846619; cv=none;
        d=google.com; s=arc-20260327;
        b=PM8eaZcWNiAKgzRV4ubZxTbioEsz14UmpxcPcKuYrjGAhwgLVvzBrhVzJTWqfU+FJ4
         BHmwMkjc6HUE6zs0e6iTq1IUp5wnl3ycO791e+nmoo4yw5NkR7vz/K4zx5OcNF52Imp/
         IN4ZH5CV7m2jQyvmQ5X/znleLRyZM6GjmdSZLFKL9VVd91BrpN5bEMy5Yz6buvQfv/C+
         L+g8fR7kn5y4UAbQDMs8iOzuA1fvWOrt9tgRHrtddyFCj53/DtndSe1XJzVyQ3myllTJ
         JEWhK7ifvB76HEG3QHG/kJNUS3dwoG1necMN+Hs+aNTqhg+FuHxCf+YYKjoqv3wmM/eW
         K8Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OA4NjvqjjVgjSbCq8wm4XUY+Mt0pcYQZIok5F3x1dto=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=N5SXkY+75FX80EJWne+PpnpAzq18NceGwY9vg3Uy1R+iZlHPAqCESl0YHsyvyqon/L
         XcptO6WSkf7iiePZjQi5XIx1vzIw0ef4EKnPF30PgG5wg4WSzxdJOKTSAN97VOupz+jt
         negIL508A4BIoDH6L8qSZDYcbqfsyMmMBzBZ9IuqzVA/v7fm3ozUok1QpW7H0Isje3kn
         R/Pl0K/dRy6vb/ZM999aG6VGI3b0+iSpyIiyHnsfHaDyEkqKZspHDLwrD//rNfJ2LgnF
         1zNJJ97JgN6rHPq3qajfuH3ay7loQrmfyAzVFJQuv+LCSMcLUB8pBRw25JKksBbke/bs
         hdhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783846619; x=1784451419; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OA4NjvqjjVgjSbCq8wm4XUY+Mt0pcYQZIok5F3x1dto=;
        b=ROQcXRiOTSetoLGVyF0dkkTsRWov1ps7rdsVQRkTJ9uPZHvLTawUrw7oYH4InVXwsj
         TYOa7/TeLEkvh+m8YrUREX5UmRw8O4JiiLSRDWPdEHhg7vj5za88VW/bac0+W3Eag2sW
         Erf70z4VOrlfXzhShL24cAR2YfPYXCicQ7cEypAjaXmmPvsjp6pLWk8Vi721KO2/3UZQ
         S5Ar3HBSOo8ATnyP8siKr5vIFprppSLLIGDLLuERjY/s1ptG9NXnfuUbkAz1iYeH47i+
         zdcCXKEJbO5JPQPhfBBZOFLotpSgZiysQWhNjn4Qb5b93hwrXL5NT3BcsV7qmqBS0DwM
         fHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783846619; x=1784451419;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OA4NjvqjjVgjSbCq8wm4XUY+Mt0pcYQZIok5F3x1dto=;
        b=gDwy02VTmHiWSIiVv3N0zDh0hXy6MLCsQNouWt4Lnk0jv/EHv0ZWXPazPpdgfOcgFk
         L/Z+Y0h9V7CEEaHXgLOn0+Wn0w2jZtZ1kvBwTg70NGkaLFpa+2489wx6ZEq4X/Na+m1Q
         CltgA0YOLZpJqvwpPxvQnY3NE1AGyeE2+h1inZNGZ1fJ7nIjyDXUQNTm7gjpCm5Jg+si
         QsQkvCGx4HFpxz1jjLVTnX1rKP8aK+9PUXBSZW0bBDklQG4svlibgHzhI3URN6IhskWe
         lBe3ERFNoJfqJfhnwQS8oZlyk/B16azV6nvo7HgGd4vzU28cIomvem3ogdbnfnby6NxL
         zXnA==
X-Gm-Message-State: AOJu0YwuR28AMPTb9iU4osomitAOmvqqbzbGhKerG/aJARm4Wb1oy7lR
	Aap7O9Wgy/CXYe+9Dp7d6q++W385/OQ3pMGJabiivoKIq4blMSpIfxNZevos0QO+J9DajOze3Kz
	ykubpOlsxwO5VjZYdNTdrC03kGCeJij0PSePdI5c=
X-Gm-Gg: AfdE7cllfdkDwMHjCJo0XlfTmDF8tU00+i5SI62fvZc3MsorRdtqPyyvxTWSpjuLPcl
	W0jYZOXysoqi5qD9qC2MC+tr68m+/5hcA+O/Q9fD2Ql+uXWw+VAOEdbnlR2RegHBnKNwCYJx661
	aoLLRrglHDJ6jhzXQUyjWP5mrkxQJYVNlMKeTOv/xpvYDsq1IIQb+PYXuDex60bvvm3ZvGtzWc7
	DSlnPNYo0B771MX3axgJCjsFF0RN//3mo5JTXtQUvWbv/3HgxZYKaM4Zv7mtYGawKrAVWipfRpa
	aifeJ2ZuXuqdUqZPuWLE0nusQYmyvQ==
X-Received: by 2002:a05:690c:6384:b0:7ff:23df:b1e1 with SMTP id
 00721157ae682-81e9017c3d7mr38670937b3.49.1783846618776; Sun, 12 Jul 2026
 01:56:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712062834.77872-1-laoar.shao@gmail.com> <20260712063739.F1E5B1F000E9@smtp.kernel.org>
In-Reply-To: <20260712063739.F1E5B1F000E9@smtp.kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 12 Jul 2026 16:56:22 +0800
X-Gm-Features: AUfX_my42dTgxKS8E-tpDtyxxBdo1crIuxutnlED0A-sTjlfKJVEKo2oP9ejFxw
Message-ID: <CALOAHbAK2WqxnTWEL5+c8Q57i91mg8TMmHw1MPcK9duaBjgreQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rpm-pkg: Preserve .BTF section in kernel modules
 during debuginfo stripping
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 12, 2026 at 2:37=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] Unconditionally passing `--keep-section .BTF` to `find-debuginfo.=
sh` breaks RPM builds on older distributions.
> --
>
> --- Patch [1]: [PATCH] kbuild: rpm-pkg: Preserve .BTF section in kernel m=
odules during debuginfo stripping ---
> commit cf88f1e030f88c3862874c09c0ef198fa1f1e9ca
> Author: Yafang Shao <laoar.shao@gmail.com>
>
> kbuild: rpm-pkg: Preserve .BTF section in kernel modules during debuginfo=
 stripping
>
> This commit modifies the kernel RPM spec file to pass the --keep-section =
.BTF
> flag to the find-debuginfo.sh script. This preserves the .BTF section dur=
ing
> debuginfo extraction, ensuring that BPF tools can successfully resolve ke=
rnel
> types at runtime for modules.
>
> > diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
> > index c732415662ef2..abc73de019e0c 100644
> > --- a/scripts/package/kernel.spec
> > +++ b/scripts/package/kernel.spec
> [ ... ]
> > @@ -67,7 +67,7 @@ This package provides debug information for the kerne=
l image and modules from th
> >  %undefine _unique_debug_srcs
> >  %undefine _debugsource_packages
> >  %undefine _debuginfo_subpackages
> > -%global _find_debuginfo_opts -r
> > +%global _find_debuginfo_opts -r --keep-section .BTF
>
> [Severity: Low]
> Will unconditionally passing --keep-section .BTF break the build on older
> distributions?
>
> Older versions of the find-debuginfo.sh script (such as those shipped wit=
h
> RPM 4.14 on RHEL 8, CentOS 7, or Ubuntu 20.04) do not support the
> --keep-section option.
>
> Because those legacy scripts parse arguments strictly, they will exit wit=
h a
> usage error when encountering an unrecognized flag, which completely brea=
ks
> the make rpm-pkg and make binrpm-pkg build targets on those systems.
>
> Is there a way to verify feature support or utilize RPM conditionals befo=
re
> applying this flag to the host script?

What about the following change?

diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
index c732415662ef..2e16de54ed74 100644
--- a/scripts/package/kernel.spec
+++ b/scripts/package/kernel.spec
@@ -67,7 +67,7 @@ This package provides debug information for the
kernel image and modules from th
 %undefine _unique_debug_srcs
 %undefine _debugsource_packages
 %undefine _debuginfo_subpackages
-%global _find_debuginfo_opts -r
+%global _find_debuginfo_opts -r%{?with_keep_section: --keep-section .BTF}
 %global _missing_build_ids_terminate_build 1
 %global _no_recompute_build_ids 1
 %{debug_package}
diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index c604f8c174e2..00acef348ba8 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -65,6 +65,11 @@ fi
 echo "%define with_debuginfo_manual $with_debuginfo_manual"
 echo "%define with_debuginfo_rpm $with_debuginfo_rpm"

+# Detect if find-debuginfo.sh supports --keep-section (RHEL 9+)
+if find-debuginfo.sh --help 2>&1 | grep -q keep-section; then
+       echo "%global with_keep_section 1"
+fi
+
 cat<<EOF
 %define ARCH ${ARCH}
 %define KERNELRELEASE ${KERNELRELEASE}


--=20
Regards
Yafang

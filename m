Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9FC3D3D02
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784193108; cv=pass; b=szF8q50o44Px6Dw6wgjMGvnwUXJ578D+PBic8DjINUMdGma0HZPLbveclY/+Wmg7bsscTkwn8tdAUqVCQXzXP5i9zeOnP+C6mjfWTcVhBor59phgTuVXVQ+q71hQQJxCoFE0X1SHg7uCIFZvDaCuU6uJVLT0/WKrAZmjaMc5VeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784193108; c=relaxed/simple;
	bh=wVaUyhiHHt8mdGxE8HABkjb3Q1pGok7lbO2wwK1myg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZjYjDOVtlPsu0YBTIIg34uTo9F7UPqtj0ZmnfMMEKUmjVKvoY3oxt7ykaXVCc5p2ja/ioYGtHpzNDT9CVtBOQZvAMct1gv8dRF8PIH7nrsIE7f72OXR1MyIaFtkofcIc06mzyCVJGZ48kLa8MrMqMGjAgUGK3LIE+0v35tIW2Lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kml3kK1d; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kml3kK1d"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-80814edb536so31708357b3.2
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 02:11:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784193102; cv=none;
        d=google.com; s=arc-20260327;
        b=G5/fYvN2fXF4hY6ibwSoKJHmqWWLhVChG3XyJKfL4CwuX8RSyDL6DUT/Ut1/ruRKdA
         3bjPGpiUmINShhFqcftI1rYqEq6hcB+Vrlr7HJA2xLKo1rK+1eDbXlTynK9L2nclIBmX
         yWVwdECjxavKSswfVDcDnsayVANRFoXBU5SBy7XEkuMmEU31pvHmqPV6rvKPCCzbvCqB
         BG9HgfEWO6rOtLil6K8UAyVk9Jru0nn7NGZa0k0MXeYQQiEmuIfpXL7rRysO4SYIzOyf
         CsOI1jPI1oqXfsz919iABzJow7TCbT78J1fUNKrEnNOEiE6KHdiXfczzuF3/wvLixHIs
         wZ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fba8lwegZlYj1IsPa0gj15+gvYVmAsXII13vXbs6KfY=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=KfSWHO9evDn8JpeiXGVFPbhWkPAGLl9y34hRkLdPuuUxvBq26FokkXfNaWzHGiT+a2
         CrYA4ubqU3PvdYN/ji2yfIdBCAAC+uEZotlDJrfst3tM2dcy9hREmqyjdqN1B2yrJ1sm
         It9ZFvTn5xrEF3UdBPUKJR3f9TGHcJJ4MtCzxhqyCmwBBXEXr1cDdBTpnHA1ega4XogO
         Y71GdBWIbutCTb59ypWgucUVdfJONM1DR+z3ztrgPscjdQp3QO0HmfcOO5wpF/+Wt0+v
         MYJWAENulvMo6FIIM9BUnHXjPxJ4Ga/JOYP7U1xPoXubJik3D1knU20TtiADwNhhj1lf
         Aaag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784193102; x=1784797902; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fba8lwegZlYj1IsPa0gj15+gvYVmAsXII13vXbs6KfY=;
        b=Kml3kK1dt7LDwZR92FeQTxoSFdYLt4bavy5crVlznCvgs8K5JjYSSrY09S+PS1gl08
         5vVmAu284Thofa27KquqSgIvXfmE7aFD5w9lD2FtXs4isTRSXLRE4kRNOCEbb1u2eWWs
         HzKM/83ZFXuBu7CxY6hEWhZssLOkiUY11n+krnd/KQcM/YRQGaiGmtoyJKhfQJGWvHch
         HqzDNAp55jwzKVrCQE2pno/WrmX2N86upiGQGF0DHY7cE8n6yvjQeT6WYmMB+uvWQX/b
         mses+bECJ/ystI4K583rN5oJ8qs/52tu/n5hDDaqGkgDMCE3NHFvaTUdjYWUXmtFNj7z
         MI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784193102; x=1784797902;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fba8lwegZlYj1IsPa0gj15+gvYVmAsXII13vXbs6KfY=;
        b=LnrPGbm/nfJvCfHs5BFvWuEaMvQhXTQ/35M5t017l+H/PguIxVJNHl+V55Qsw6xMwX
         ATLX7+k9YvdpqlOnuH0pfhaGlxKcwW0zSsvYlRGlqb7uDFhoROyPjTqXT3cMc66FgZmm
         HAaSjNwEysQj5nh2DcZ0BihfpjfxLZqWXnXBg8Uh6nJaQ95JQKkJ8rMX4DT5An2TA3yD
         q5bf/6pgwxVwzKZV30maIgZaJB5yyKlcsmetTl4OXI8sO5x7uuRWBzKvZDGX0GRbSeQD
         Va8Pp3czt7thyH3LG+GSL6/mOt9Hpj+JRSwgayg+ChSVreTiHZ0JLb4gX+2ro9MtHnlt
         9qRw==
X-Gm-Message-State: AOJu0Yz0K9cFSbYPBgsPAQb5pbMuI/jZbAgsdNLRpR4CbVqg2uwifJ53
	1W3rgCBibhxscknmQ12w1IU954BX904qq6W8Kuq5HBU0UVMkyCNmipQMdGAdhUhByK+KEvWWcmn
	4CZXTk77qtl7Ka8hcZHRYuJidymTxU6Hc1wg7b9U=
X-Gm-Gg: AfdE7cmgG+qKEPdTAk0RwEYz+m5fHbiLEeuXF1ccRU7T3ems7eYhAgFpeMLGRaZ1wd/
	stOG+zBw0+uzWjj6r1iLVgO3iC2R9cmioEiK1HqZz19zrid1+SiK+vsmbR+oZaC9rTC1H0IvUx1
	YWHIpQNomgFHGOhmb5Ss+i9enkIqg14HU89fQFDCRS4PP4FxapjpEO5xFYOmIQ4e6S3v5/uNl1b
	Kx4j6W1kyIgSKHY6cO2ssMnSV05FwJk5MgbesOGntOo1kKFe6Vy2/UH0I8rqQ+ew19ND+Opf9ut
	H5OhyfcFC+JleQ/5OJ0=
X-Received: by 2002:a05:690c:6985:b0:814:5312:47bb with SMTP id
 00721157ae682-81e902edf4cmr160319997b3.69.1784193101804; Thu, 16 Jul 2026
 02:11:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716025342.42628-1-laoar.shao@gmail.com> <20260716030116.C613E1F000E9@smtp.kernel.org>
In-Reply-To: <20260716030116.C613E1F000E9@smtp.kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 16 Jul 2026 17:11:05 +0800
X-Gm-Features: AUfX_mzbQk6cyOjkJvVnkqd3j5MPhxg-oxSB2r6szyXH0u_dDwMsDN22ChRo4OE
Message-ID: <CALOAHbBQhAsTMHMMZH5Sen0cDYg8GREZMmQcT4Njc9VW_WHe4Q@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: rpm-pkg: Preserve .BTF section in kernel
 modules during debuginfo stripping
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 11:01=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The check for `find-debuginfo.sh` capabilities in `mkspec` har=
dcodes host properties into `kernel.spec`, breaking SRPM portability across=
 distributions and failing silently when the tool is not in `$PATH`.
> --
>
> --- Patch [1]: [PATCH v2] kbuild: rpm-pkg: Preserve .BTF section in kerne=
l modules during debuginfo stripping ---
> commit 99202060a54c32638e01a2bfdc4d23b190f3f77c
> Author: Yafang Shao <laoar.shao@gmail.com>
>
> kbuild: rpm-pkg: Preserve .BTF section in kernel modules during debuginfo=
 stripping
>
> This commit updates the RPM packaging scripts to pass --keep-section .BTF
> to find-debuginfo.sh. This ensures that BTF information is preserved when
> debuginfo is stripped from kernel modules.
>
> > diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> > index c604f8c174e2c..00acef348ba84 100755
> > --- a/scripts/package/mkspec
> > +++ b/scripts/package/mkspec
> [ ... ]
> > @@ -65,6 +65,11 @@ fi
> >  echo "%define with_debuginfo_manual $with_debuginfo_manual"
> >  echo "%define with_debuginfo_rpm $with_debuginfo_rpm"
> >
> > +# Detect if find-debuginfo.sh supports --keep-section (RHEL 9+)
> > +if find-debuginfo.sh --help 2>&1 | grep -q keep-section; then
> > +     echo "%global with_keep_section 1"
> > +fi
>
> [Severity: Medium]
> Is it safe to assume find-debuginfo.sh is in the standard user $PATH?
>
> On many systems, this script resides in /usr/lib/rpm/, which isn't typica=
lly
> in the $PATH. This could cause the check to silently fail and strip the .=
BTF
> section during a local make rpm-pkg build.
>
> Also, since mkspec runs during SRPM generation (make srcrpm-pkg), doesn't
> this statically bake the generation host's capabilities into the resultin=
g
> kernel.spec file?
>
> If the SRPM is rebuilt on an older distribution, rpmbuild might fail beca=
use
> the older script rejects the --keep-section argument. If generated on an
> older host and built on a newer one, BTF info would be silently stripped.
> Could we dynamically query the target host's capabilities using something
> like %(__find_debuginfo) inside the spec file itself?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716025342.42=
628-1-laoar.shao@gmail.com?part=3D1

I believe we could use the builtin _rpmconfigdir to locate
find-debuginfo.sh reliably. This avoids relying on $PATH.
What do you think about the following change?

diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
index c732415662ef..4335e99f2aca 100644
--- a/scripts/package/kernel.spec
+++ b/scripts/package/kernel.spec
@@ -67,7 +67,21 @@ This package provides debug information for the
kernel image and modules from th
 %undefine _unique_debug_srcs
 %undefine _debugsource_packages
 %undefine _debuginfo_subpackages
+
+# Preserve .BTF section in kernel modules during debuginfo stripping
+# find-debuginfo.sh (from debugedit) uses eu-strip which removes
+# non-allocated ELF sections like .BTF by default.
+# --keep-section .BTF preserves BPF Type Format information.
+#
+# Uses _rpmconfigdir for reliable script location instead of relying on $P=
ATH.
+%{!?with_keep_section:%global __fd %{_rpmconfigdir}/find-debuginfo.sh}
+%{!?with_keep_section:%global with_keep_section %(%{__fd} --help 2>&1
| grep -c keep-section)}
+%if %{with_keep_section}
+%global _find_debuginfo_opts -r --keep-section .BTF
+%else
 %global _find_debuginfo_opts -r
+%endif
+
 %global _missing_build_ids_terminate_build 1
 %global _no_recompute_build_ids 1
 %{debug_package}

Please let me know if this approach works or if there are any concerns.

--=20
Regards
Yafang

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AA8249E5;
	Fri, 24 Jul 2026 00:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784851221; cv=none; b=X0sNYw/iCWLCafqacfMjCAi1TLxSVsQf043aO7PPIV9WIWw/0Gsahlw7sxiaO2amv1Rctwq0OiKfH3zMzlAkq59wo4ikrS2bFBpi1pe/dFYiOox1UqPBmEbiRAx0XATfqb50lKQU0Iu+XdggfkgSOrHG7z40tx3fcYw4AgZsCOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784851221; c=relaxed/simple;
	bh=A6BjG7V3maScyVdothykROa06XIBQltTkbVLQn59nSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoeiMjYp2wOq+B2ExR15j1fAbVCinOPAFDIbXp+XJlWrg2GgchbQ6uJmZzEKf6nYH4j++FyWYcxIemRNDRtXJneZITCBYrgM6byWrPa/ohXiWh2Ae0s9+fmdfsJI9CFBy4jdq6YRzyOvT/slXZxgHRKXXNQku1iA0xYAOEE1oKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEyqbpl0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEyqbpl0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD3B1F000E9;
	Fri, 24 Jul 2026 00:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784851219;
	bh=KITy1CWLmlLON45EHyWDLHn6QBelbd0pl13DmwYpnko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GEyqbpl0FkgK7a4JYEK5q/8bt+AhTzhkrBZXe5aH+THraU6uqQJu3m7zGcELrr5n9
	 0ngjZ8BELCESsq3A4LxeVN3VtH5hRG+US4A14csGk0O7NLd3jm89HRsPwpjaejjEnJ
	 a8+cP/7I/q06hOSFEWMVEBTmld4i+2RPPwhyLNIiqc0GOr2WNACa+Ab2X/EOmwtlSs
	 MbhpdbnYSdTDV/QnxKgYvfL09F6VPU/Va/56zL0KKC0cbtDIiIWYwIuBrlpePCGFh0
	 bxApH0+1/Q+AjHN0DgBel4RVOmzazGhNemaQQQ7pzXoQrTs674KlC5HQ4GKUsTnier
	 3Fo8KjdXkaeTw==
Date: Thu, 23 Jul 2026 17:00:15 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org, Nicolas Schier <nsc@kernel.org>
Subject: Re: [PATCH v2] kbuild: rpm-pkg: Preserve .BTF section in kernel
 modules during debuginfo stripping
Message-ID: <20260724000015.GA2803569@ax162>
References: <20260716025342.42628-1-laoar.shao@gmail.com>
 <20260716030116.C613E1F000E9@smtp.kernel.org>
 <CALOAHbBQhAsTMHMMZH5Sen0cDYg8GREZMmQcT4Njc9VW_WHe4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbBQhAsTMHMMZH5Sen0cDYg8GREZMmQcT4Njc9VW_WHe4Q@mail.gmail.com>

On Thu, Jul 16, 2026 at 05:11:05PM +0800, Yafang Shao wrote:
> On Thu, Jul 16, 2026 at 11:01 AM <sashiko-bot@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Medium] The check for `find-debuginfo.sh` capabilities in `mkspec` hardcodes host properties into `kernel.spec`, breaking SRPM portability across distributions and failing silently when the tool is not in `$PATH`.
> > --
> >
> > --- Patch [1]: [PATCH v2] kbuild: rpm-pkg: Preserve .BTF section in kernel modules during debuginfo stripping ---
> > commit 99202060a54c32638e01a2bfdc4d23b190f3f77c
> > Author: Yafang Shao <laoar.shao@gmail.com>
> >
> > kbuild: rpm-pkg: Preserve .BTF section in kernel modules during debuginfo stripping
> >
> > This commit updates the RPM packaging scripts to pass --keep-section .BTF
> > to find-debuginfo.sh. This ensures that BTF information is preserved when
> > debuginfo is stripped from kernel modules.
> >
> > > diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> > > index c604f8c174e2c..00acef348ba84 100755
> > > --- a/scripts/package/mkspec
> > > +++ b/scripts/package/mkspec
> > [ ... ]
> > > @@ -65,6 +65,11 @@ fi
> > >  echo "%define with_debuginfo_manual $with_debuginfo_manual"
> > >  echo "%define with_debuginfo_rpm $with_debuginfo_rpm"
> > >
> > > +# Detect if find-debuginfo.sh supports --keep-section (RHEL 9+)
> > > +if find-debuginfo.sh --help 2>&1 | grep -q keep-section; then
> > > +     echo "%global with_keep_section 1"
> > > +fi
> >
> > [Severity: Medium]
> > Is it safe to assume find-debuginfo.sh is in the standard user $PATH?
> >
> > On many systems, this script resides in /usr/lib/rpm/, which isn't typically
> > in the $PATH. This could cause the check to silently fail and strip the .BTF
> > section during a local make rpm-pkg build.
> >
> > Also, since mkspec runs during SRPM generation (make srcrpm-pkg), doesn't
> > this statically bake the generation host's capabilities into the resulting
> > kernel.spec file?
> >
> > If the SRPM is rebuilt on an older distribution, rpmbuild might fail because
> > the older script rejects the --keep-section argument. If generated on an
> > older host and built on a newer one, BTF info would be silently stripped.
> > Could we dynamically query the target host's capabilities using something
> > like %(__find_debuginfo) inside the spec file itself?
> >
> > --
> > Sashiko AI review · https://sashiko.dev/#/patchset/20260716025342.42628-1-laoar.shao@gmail.com?part=1
> 
> I believe we could use the builtin _rpmconfigdir to locate
> find-debuginfo.sh reliably. This avoids relying on $PATH.
> What do you think about the following change?

Just an FYI, this was not sent to anyone with authority to comment on
said change, as the Kbuild folks were not included in the AI review
thread. I just happened to find this when browsing the archives.

> diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
> index c732415662ef..4335e99f2aca 100644
> --- a/scripts/package/kernel.spec
> +++ b/scripts/package/kernel.spec
> @@ -67,7 +67,21 @@ This package provides debug information for the
> kernel image and modules from th
>  %undefine _unique_debug_srcs
>  %undefine _debugsource_packages
>  %undefine _debuginfo_subpackages
> +
> +# Preserve .BTF section in kernel modules during debuginfo stripping
> +# find-debuginfo.sh (from debugedit) uses eu-strip which removes
> +# non-allocated ELF sections like .BTF by default.
> +# --keep-section .BTF preserves BPF Type Format information.
> +#
> +# Uses _rpmconfigdir for reliable script location instead of relying on $PATH.
> +%{!?with_keep_section:%global __fd %{_rpmconfigdir}/find-debuginfo.sh}
> +%{!?with_keep_section:%global with_keep_section %(%{__fd} --help 2>&1
> | grep -c keep-section)}
> +%if %{with_keep_section}
> +%global _find_debuginfo_opts -r --keep-section .BTF
> +%else
>  %global _find_debuginfo_opts -r
> +%endif
> +
>  %global _missing_build_ids_terminate_build 1
>  %global _no_recompute_build_ids 1
>  %{debug_package}
> 
> Please let me know if this approach works or if there are any concerns.

/usr/lib/rpm/find-debuginfo.sh might not exist on certain distributions
that can build .rpm packages like Arch Linux:

  $ ls -l /usr/lib/rpm/find-debuginfo.sh
  "/usr/lib/rpm/find-debuginfo.sh": No such file or directory (os error 2)

Even on modern Fedora, this is a symlink:

  $ ls -l /usr/lib/rpm/find-debuginfo.sh
  lrwxrwxrwx@ - root 19 Jul 17:00 /usr/lib/rpm/find-debuginfo.sh -> ../../bin/find-debuginfo

I think we would be better off just using the __find_debuginfo rpm
macro:

  $ rg -m 1 find-debuginfo /usr/lib/rpm/macros
  69:%__find_debuginfo    /usr/bin/find-debuginfo

This appears to work for me, it would be good if you can confirm this
works for you as well.

diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
index c732415662ef..590b5b2e1b40 100644
--- a/scripts/package/kernel.spec
+++ b/scripts/package/kernel.spec
@@ -67,7 +67,18 @@ This package provides debug information for the kernel image and modules from th
 %undefine _unique_debug_srcs
 %undefine _debugsource_packages
 %undefine _debuginfo_subpackages
+
+# Preserve .BTF section in kernel modules during debuginfo stripping
+# find-debuginfo.sh (from debugedit) uses eu-strip which removes
+# non-allocated ELF sections like .BTF by default.
+%global with_keep_section %(%{__find_debuginfo} --help 2>&1 | grep -c keep-section)
+%if %{with_keep_section}
+%global _find_debuginfo_opts -r --keep-section .BTF
+%else
 %global _find_debuginfo_opts -r
+%endif
+
 %global _missing_build_ids_terminate_build 1
 %global _no_recompute_build_ids 1
 %{debug_package}
-- 
Cheers,
Nathan

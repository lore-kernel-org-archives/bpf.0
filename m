Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C65233926;
	Fri, 24 Jul 2026 19:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784922639; cv=none; b=oBsfqryV6jy2JB6O3Fut0CPl4bUarcTTfXRDX490PEkIADBsz0kEQc2shf6XWkVNgK0S/oucUY0nZJVLSnGIVoMrdWBTrt5OjieWCnffyl696veV3814YRZ+OBsDoJxO28S33rJxoHbNRpWEPU4SBZKqExq3lovedjPKfDtelwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784922639; c=relaxed/simple;
	bh=NoE+xy0UkbhTAXqkSxv2IuMHsApWUps4QQDy0yXorHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbTTwQ7RdndXUTLXUOpyIszsmYEx5kc0FGN5NPBuQF1KS0RGr9u6ZCwHamTVA/zaHtE4uF/zSxYc4bKqqPFj4YhZLu0yhGmO9+y3RiVQPkWM/FNQvPT3vqKy2RTRp0NCmmLPG4bJT7mU8P9dOTvH7YDvF3IgSe6c8C44s8PazdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtYv7zqd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtYv7zqd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D67C1F000E9;
	Fri, 24 Jul 2026 19:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784922637;
	bh=uYZYJpTXfDcHeTDqTQZMaqHJlAmMBAVkn93HWhktHe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BtYv7zqddpucBXaaJwMzAyxzhsc9MJMRfHJFF5SqL5QEGqEUXUGuu7IPOHWq/tZxV
	 LwBmCOdkdB+JaC8madHMT6EVUv9zBdLXy6bxjjSG6c5XaRw1MZE+SQdQV5WqEej35A
	 kLqYD14gFOIW4jszjfZ+3z/yFT2thi8JUgnDRR5bJREoaLfW5UF+hM8nyv1nF8Mc8j
	 xRoE/PGRsR2v3AF7Ei9vOFpE+CBy5Gf0wxVjpoJxNgY20TilndiOCtfq8C7R04P9YD
	 +2kmJhPSQ/JPxxVuBTRs4TiUCg0w45n+JfaG0N4KbJivpNwpbuIGOLO/EiP4Ns1cQL
	 ONn50oT6sRcrQ==
Date: Fri, 24 Jul 2026 12:50:34 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org, Nicolas Schier <nsc@kernel.org>
Subject: Re: [PATCH v2] kbuild: rpm-pkg: Preserve .BTF section in kernel
 modules during debuginfo stripping
Message-ID: <20260724195034.GB1461047@ax162>
References: <20260716025342.42628-1-laoar.shao@gmail.com>
 <20260716030116.C613E1F000E9@smtp.kernel.org>
 <CALOAHbBQhAsTMHMMZH5Sen0cDYg8GREZMmQcT4Njc9VW_WHe4Q@mail.gmail.com>
 <20260724000015.GA2803569@ax162>
 <CALOAHbCaKNF2=Q0qCHbQttP4+LOwOdnxHKbdLeiJi0+2JKkvNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbCaKNF2=Q0qCHbQttP4+LOwOdnxHKbdLeiJi0+2JKkvNQ@mail.gmail.com>

On Fri, Jul 24, 2026 at 10:49:24AM +0800, Yafang Shao wrote:
> On Fri, Jul 24, 2026 at 8:00 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > On Thu, Jul 16, 2026 at 05:11:05PM +0800, Yafang Shao wrote:
> > > On Thu, Jul 16, 2026 at 11:01 AM <sashiko-bot@kernel.org> wrote:
> > > >
> > > > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > > - [Medium] The check for `find-debuginfo.sh` capabilities in `mkspec` hardcodes host properties into `kernel.spec`, breaking SRPM portability across distributions and failing silently when the tool is not in `$PATH`.
> > > > --
> > > >
> > > > --- Patch [1]: [PATCH v2] kbuild: rpm-pkg: Preserve .BTF section in kernel modules during debuginfo stripping ---
> > > > commit 99202060a54c32638e01a2bfdc4d23b190f3f77c
> > > > Author: Yafang Shao <laoar.shao@gmail.com>
> > > >
> > > > kbuild: rpm-pkg: Preserve .BTF section in kernel modules during debuginfo stripping
> > > >
> > > > This commit updates the RPM packaging scripts to pass --keep-section .BTF
> > > > to find-debuginfo.sh. This ensures that BTF information is preserved when
> > > > debuginfo is stripped from kernel modules.
> > > >
> > > > > diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> > > > > index c604f8c174e2c..00acef348ba84 100755
> > > > > --- a/scripts/package/mkspec
> > > > > +++ b/scripts/package/mkspec
> > > > [ ... ]
> > > > > @@ -65,6 +65,11 @@ fi
> > > > >  echo "%define with_debuginfo_manual $with_debuginfo_manual"
> > > > >  echo "%define with_debuginfo_rpm $with_debuginfo_rpm"
> > > > >
> > > > > +# Detect if find-debuginfo.sh supports --keep-section (RHEL 9+)
> > > > > +if find-debuginfo.sh --help 2>&1 | grep -q keep-section; then
> > > > > +     echo "%global with_keep_section 1"
> > > > > +fi
> > > >
> > > > [Severity: Medium]
> > > > Is it safe to assume find-debuginfo.sh is in the standard user $PATH?
> > > >
> > > > On many systems, this script resides in /usr/lib/rpm/, which isn't typically
> > > > in the $PATH. This could cause the check to silently fail and strip the .BTF
> > > > section during a local make rpm-pkg build.
> > > >
> > > > Also, since mkspec runs during SRPM generation (make srcrpm-pkg), doesn't
> > > > this statically bake the generation host's capabilities into the resulting
> > > > kernel.spec file?
> > > >
> > > > If the SRPM is rebuilt on an older distribution, rpmbuild might fail because
> > > > the older script rejects the --keep-section argument. If generated on an
> > > > older host and built on a newer one, BTF info would be silently stripped.
> > > > Could we dynamically query the target host's capabilities using something
> > > > like %(__find_debuginfo) inside the spec file itself?
> > > >
> > > > --
> > > > Sashiko AI review · https://sashiko.dev/#/patchset/20260716025342.42628-1-laoar.shao@gmail.com?part=1
> > >
> > > I believe we could use the builtin _rpmconfigdir to locate
> > > find-debuginfo.sh reliably. This avoids relying on $PATH.
> > > What do you think about the following change?
> >
> > Just an FYI, this was not sent to anyone with authority to comment on
> > said change, as the Kbuild folks were not included in the AI review
> > thread. I just happened to find this when browsing the archives.
> 
> My apologies, I failed to notice that the linux-kbuild mailing list
> was excluded from Sashiko's reply.

No problem at all, I just wanted to make it obvious why you may not have
gotten a response to your suggestion and for this issue to get lost.

> > > diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
> > > index c732415662ef..4335e99f2aca 100644
> > > --- a/scripts/package/kernel.spec
> > > +++ b/scripts/package/kernel.spec
> > > @@ -67,7 +67,21 @@ This package provides debug information for the
> > > kernel image and modules from th
> > >  %undefine _unique_debug_srcs
> > >  %undefine _debugsource_packages
> > >  %undefine _debuginfo_subpackages
> > > +
> > > +# Preserve .BTF section in kernel modules during debuginfo stripping
> > > +# find-debuginfo.sh (from debugedit) uses eu-strip which removes
> > > +# non-allocated ELF sections like .BTF by default.
> > > +# --keep-section .BTF preserves BPF Type Format information.
> > > +#
> > > +# Uses _rpmconfigdir for reliable script location instead of relying on $PATH.
> > > +%{!?with_keep_section:%global __fd %{_rpmconfigdir}/find-debuginfo.sh}
> > > +%{!?with_keep_section:%global with_keep_section %(%{__fd} --help 2>&1
> > > | grep -c keep-section)}
> > > +%if %{with_keep_section}
> > > +%global _find_debuginfo_opts -r --keep-section .BTF
> > > +%else
> > >  %global _find_debuginfo_opts -r
> > > +%endif
> > > +
> > >  %global _missing_build_ids_terminate_build 1
> > >  %global _no_recompute_build_ids 1
> > >  %{debug_package}
> > >
> > > Please let me know if this approach works or if there are any concerns.
> >
> > /usr/lib/rpm/find-debuginfo.sh might not exist on certain distributions
> > that can build .rpm packages like Arch Linux:
> >
> >   $ ls -l /usr/lib/rpm/find-debuginfo.sh
> >   "/usr/lib/rpm/find-debuginfo.sh": No such file or directory (os error 2)
> >
> > Even on modern Fedora, this is a symlink:
> >
> >   $ ls -l /usr/lib/rpm/find-debuginfo.sh
> >   lrwxrwxrwx@ - root 19 Jul 17:00 /usr/lib/rpm/find-debuginfo.sh -> ../../bin/find-debuginfo
> >
> > I think we would be better off just using the __find_debuginfo rpm
> > macro:
> >
> >   $ rg -m 1 find-debuginfo /usr/lib/rpm/macros
> >   69:%__find_debuginfo    /usr/bin/find-debuginfo
> >
> > This appears to work for me, it would be good if you can confirm this
> > works for you as well.
> >
> > diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
> > index c732415662ef..590b5b2e1b40 100644
> > --- a/scripts/package/kernel.spec
> > +++ b/scripts/package/kernel.spec
> > @@ -67,7 +67,18 @@ This package provides debug information for the kernel image and modules from th
> >  %undefine _unique_debug_srcs
> >  %undefine _debugsource_packages
> >  %undefine _debuginfo_subpackages
> > +
> > +# Preserve .BTF section in kernel modules during debuginfo stripping
> > +# find-debuginfo.sh (from debugedit) uses eu-strip which removes
> > +# non-allocated ELF sections like .BTF by default.
> > +%global with_keep_section %(%{__find_debuginfo} --help 2>&1 | grep -c keep-section)
> > +%if %{with_keep_section}
> > +%global _find_debuginfo_opts -r --keep-section .BTF
> > +%else
> >  %global _find_debuginfo_opts -r
> > +%endif
> > +
> >  %global _missing_build_ids_terminate_build 1
> >  %global _no_recompute_build_ids 1
> >  %{debug_package}
> 
> This works for me, thanks for the improvement.
> Do you plan to send the official patch, or would you like me to send a
> new version?

You can send a new version, as your message makes it clear what is going
on here. If you feel so inclined, you can add a Suggested-by tag but I
don't think this is substantially different from what you suggested.

-- 
Cheers,
Nathan

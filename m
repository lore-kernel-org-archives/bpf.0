Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F98F242D9B
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 02:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784861417; cv=pass; b=FNo3J+4bvsA33GC0nvPMXKfSKkR5M7Ax/wfCKU96c1Gm3Ie27V5IWTX3G8xcVb++zfJvK2lzm4lzSdMqxXfUsuYRHArNNg/a/PrRuJEk5yq6As6/cTg+9caVn7no/+x6x6dd4ptDTfhaU5kiLGUYpRFWHYcI+BpnzsXAviOaI2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784861417; c=relaxed/simple;
	bh=LlyMjsNHdsUuxQgVfFn6++gdurtIqbh4ZQGPRj0xAwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tPdVd9Yvuq++T0vvHD6VCp2o77QIfX7QxRE63UYygS17UdT1eYWwZLWW8zWBA77zLfB057vnbN3r+SKZ+hSfemG5Nvf6RfkTos8O2vVfC+tPgG2Xp1S4U7kyLd0jdq/8MBc6P7tZ0SsjlEoXXWE6NSxw6PBhrIQoZVkeLhUKiRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmH7iXuo; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmH7iXuo"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-81ed073fed0so12763857b3.0
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 19:50:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784861400; cv=none;
        d=google.com; s=arc-20260327;
        b=j406O3Xd+RryoLxPNQEBy4InYsqqL9FdQpc4rcBj5evYH9KlmRrU0N4fFSYG7u/cRJ
         z/XywoG8iGc+8k/aD4auyeszOtZDAvZPTLoOdbqFdehOBk+z7YI2VsIrzU3ZBf7ii3WO
         uNbgcgBbQQuTfOgBGcJAogMQFAie0H3Iak2LIZ8BT14v5CHvIUjiPUWld1XdT71voMT3
         9hozyFjGF+++/EOLh4sokTaacn30VmwdJCRiEpF+NCSw5A8k0o/KcjCqiTJbFs/iLHHW
         KZ1HyPzr5MhNFXWdr51w0v3xOS40FqLqwTDfRQDRErt/h0L87Ixah4Q2mnZmZDaclyST
         NKXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=00Cvm/3c2TLsfbxxx1AW+Cm3la7AGYnkd4OOPtsnuxQ=;
        fh=eu75U7t+v8trAFQBk7yY46OrBAA3DIG+YYL2fMv2/QI=;
        b=aDoFtg8Zv3EehLRlFawAihUieyR1/1G0lEdUSzMGYikVZRk4IIAOANdLa7xPzh4F9V
         +7s2WNZgdjS4l2akYoXZ9KqWUCzrZNJ7LNryE7s7w/U25v6dbOGLMTi5pp4pEZWJBTKq
         dtClpbZeSZv11tjBnvX1k3lzlkILdTXzU6gACZ5UCRu4OIo51Qu7qqTuXHRbISRXTBHQ
         7UGVXYoKja81ITHCs3vukLMpDwdoPlLuMP9RqI9ZXzBpZdLPXh6tDiSlROUEMvrcGkTg
         23PnG5YgIaYCuU53SBKZTqReq4ShUEg4abSn1PGCD97Ss9hcuE7koopseCIceTYWe9j3
         x++w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784861400; x=1785466200; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=00Cvm/3c2TLsfbxxx1AW+Cm3la7AGYnkd4OOPtsnuxQ=;
        b=FmH7iXuouxCLYrZ7rov30d5Slmj5fzncN6RwPTZAHi52treJejCRR68DY0c/soK6go
         YuaU2iwV9xIiotzOgE0lhLe8QEY2m2JFaCz7X/LYEURBLn6lXOVe2BRKQ1HvXWEkrh2j
         i5mIHWPilj6rHG8skVVFDD6YDW/3T5hk044fRnUGfpA6AiuqCcl0T7ASZkOdyjuXlvzk
         DN/Pq/0Skf7rYIbZdQt0AQbhq5AboL/pbSe9jxvHvxP+OErIAhs8npmEEjQH9KkCHaAt
         xLuTBx+aQNLGWiY2nUIdpP31GA1LlAhhjPelggikyzPnpzy09EC0GXZ170p3qGnxFryP
         uJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784861400; x=1785466200;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=00Cvm/3c2TLsfbxxx1AW+Cm3la7AGYnkd4OOPtsnuxQ=;
        b=fx4aUNZl6k+hNGDxWq6wCSbuuOjv7ZwO/6/QIHwZSbMrNDrIz9EScA///Dt1z9xQyX
         lzjQkDJH6OFk7URHOpU6CKL1169OylfXjgfyxckkRNaVOSL1VaJKOxjoOke+WpPd9M31
         GkK+NMJJBaB9JLc4utRSFRgkYVVb4/EUA/zxdftgB17XefEmXp9sLx09b7wYZp4Cq7V7
         7mtaCMsvKJVvVxdKNGWKP2WNUV6Yfy9m8A6n3ooQOAMWKWzdsmQRtTWzMzEtz98lu7UQ
         dbiYdXToBv5ZM2vaqhNXfJT1rLdREPVb+T9zevkdcQ5S5DHDhK6kPcalpiCHH1t9bc/m
         RpdQ==
X-Forwarded-Encrypted: i=1; AHgh+RrffZrZz9RMZ201qaD16iKM0Sy2cEFzyaSsfWo8QCauGNM6sQF1t3R761KqEgajn7jDvOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbWz9XbKQQjmwvSlpZt4FY555c6bxT5kxnwUdoeRirJkF2+Oz/
	2qZ9PpotoekTQ8RauOyjhgLqls62TP68DWlHm6RZCnWG9NMp++Mp+a+AG/J+NjMx53yiP5eksBk
	ehZrh5KFbZY57fCLSNGDd+5DA1g53dpc=
X-Gm-Gg: AR+sD10AKoMB+T4yCN6Pb7B4g1+AWPurIaDgGAGxKb29AVj9L2SxCJCpcMXEzd5/dmu
	7CyVL33Sou34xsZAM0AZ4Iv7+N/9CmOFnLXw2Cw/40B11/7hdWcDXcmU665dS5wj7fdosB7zvrz
	UIkD3yfpQ42hvX05gOfqXiXP8GDu34q7G5iDMNpSvmxwosaFpDzMTPuRZ57ts42uNqBsn97m6ah
	gaE3gIpp1rTzWdXwpqudCIFX1zO/i8br4fjLIkkGK0hmGMoTcsC+FD55HtQlVfQzLet5AE9F2ab
	1laoeHt/qnHrXMt/uEE=
X-Received: by 2002:a05:690c:600c:b0:81e:6800:47a3 with SMTP id
 00721157ae682-81f4c2cb486mr18496477b3.43.1784861400083; Thu, 23 Jul 2026
 19:50:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716025342.42628-1-laoar.shao@gmail.com> <20260716030116.C613E1F000E9@smtp.kernel.org>
 <CALOAHbBQhAsTMHMMZH5Sen0cDYg8GREZMmQcT4Njc9VW_WHe4Q@mail.gmail.com> <20260724000015.GA2803569@ax162>
In-Reply-To: <20260724000015.GA2803569@ax162>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 24 Jul 2026 10:49:24 +0800
X-Gm-Features: AUfX_mxJO5tjKSxpTooYrh9hBcU0-eLxdrln4YanzcWe_FR9ecfkIhSWbqDr-J0
Message-ID: <CALOAHbCaKNF2=Q0qCHbQttP4+LOwOdnxHKbdLeiJi0+2JKkvNQ@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: rpm-pkg: Preserve .BTF section in kernel
 modules during debuginfo stripping
To: Nathan Chancellor <nathan@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, Nicolas Schier <nsc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 8:00=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> On Thu, Jul 16, 2026 at 05:11:05PM +0800, Yafang Shao wrote:
> > On Thu, Jul 16, 2026 at 11:01=E2=80=AFAM <sashiko-bot@kernel.org> wrote=
:
> > >
> > > Thank you for your contribution! Sashiko AI review found 1 potential =
issue(s) to consider:
> > > - [Medium] The check for `find-debuginfo.sh` capabilities in `mkspec`=
 hardcodes host properties into `kernel.spec`, breaking SRPM portability ac=
ross distributions and failing silently when the tool is not in `$PATH`.
> > > --
> > >
> > > --- Patch [1]: [PATCH v2] kbuild: rpm-pkg: Preserve .BTF section in k=
ernel modules during debuginfo stripping ---
> > > commit 99202060a54c32638e01a2bfdc4d23b190f3f77c
> > > Author: Yafang Shao <laoar.shao@gmail.com>
> > >
> > > kbuild: rpm-pkg: Preserve .BTF section in kernel modules during debug=
info stripping
> > >
> > > This commit updates the RPM packaging scripts to pass --keep-section =
.BTF
> > > to find-debuginfo.sh. This ensures that BTF information is preserved =
when
> > > debuginfo is stripped from kernel modules.
> > >
> > > > diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> > > > index c604f8c174e2c..00acef348ba84 100755
> > > > --- a/scripts/package/mkspec
> > > > +++ b/scripts/package/mkspec
> > > [ ... ]
> > > > @@ -65,6 +65,11 @@ fi
> > > >  echo "%define with_debuginfo_manual $with_debuginfo_manual"
> > > >  echo "%define with_debuginfo_rpm $with_debuginfo_rpm"
> > > >
> > > > +# Detect if find-debuginfo.sh supports --keep-section (RHEL 9+)
> > > > +if find-debuginfo.sh --help 2>&1 | grep -q keep-section; then
> > > > +     echo "%global with_keep_section 1"
> > > > +fi
> > >
> > > [Severity: Medium]
> > > Is it safe to assume find-debuginfo.sh is in the standard user $PATH?
> > >
> > > On many systems, this script resides in /usr/lib/rpm/, which isn't ty=
pically
> > > in the $PATH. This could cause the check to silently fail and strip t=
he .BTF
> > > section during a local make rpm-pkg build.
> > >
> > > Also, since mkspec runs during SRPM generation (make srcrpm-pkg), doe=
sn't
> > > this statically bake the generation host's capabilities into the resu=
lting
> > > kernel.spec file?
> > >
> > > If the SRPM is rebuilt on an older distribution, rpmbuild might fail =
because
> > > the older script rejects the --keep-section argument. If generated on=
 an
> > > older host and built on a newer one, BTF info would be silently strip=
ped.
> > > Could we dynamically query the target host's capabilities using somet=
hing
> > > like %(__find_debuginfo) inside the spec file itself?
> > >
> > > --
> > > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026071602534=
2.42628-1-laoar.shao@gmail.com?part=3D1
> >
> > I believe we could use the builtin _rpmconfigdir to locate
> > find-debuginfo.sh reliably. This avoids relying on $PATH.
> > What do you think about the following change?
>
> Just an FYI, this was not sent to anyone with authority to comment on
> said change, as the Kbuild folks were not included in the AI review
> thread. I just happened to find this when browsing the archives.

My apologies, I failed to notice that the linux-kbuild mailing list
was excluded from Sashiko's reply.

>
> > diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
> > index c732415662ef..4335e99f2aca 100644
> > --- a/scripts/package/kernel.spec
> > +++ b/scripts/package/kernel.spec
> > @@ -67,7 +67,21 @@ This package provides debug information for the
> > kernel image and modules from th
> >  %undefine _unique_debug_srcs
> >  %undefine _debugsource_packages
> >  %undefine _debuginfo_subpackages
> > +
> > +# Preserve .BTF section in kernel modules during debuginfo stripping
> > +# find-debuginfo.sh (from debugedit) uses eu-strip which removes
> > +# non-allocated ELF sections like .BTF by default.
> > +# --keep-section .BTF preserves BPF Type Format information.
> > +#
> > +# Uses _rpmconfigdir for reliable script location instead of relying o=
n $PATH.
> > +%{!?with_keep_section:%global __fd %{_rpmconfigdir}/find-debuginfo.sh}
> > +%{!?with_keep_section:%global with_keep_section %(%{__fd} --help 2>&1
> > | grep -c keep-section)}
> > +%if %{with_keep_section}
> > +%global _find_debuginfo_opts -r --keep-section .BTF
> > +%else
> >  %global _find_debuginfo_opts -r
> > +%endif
> > +
> >  %global _missing_build_ids_terminate_build 1
> >  %global _no_recompute_build_ids 1
> >  %{debug_package}
> >
> > Please let me know if this approach works or if there are any concerns.
>
> /usr/lib/rpm/find-debuginfo.sh might not exist on certain distributions
> that can build .rpm packages like Arch Linux:
>
>   $ ls -l /usr/lib/rpm/find-debuginfo.sh
>   "/usr/lib/rpm/find-debuginfo.sh": No such file or directory (os error 2=
)
>
> Even on modern Fedora, this is a symlink:
>
>   $ ls -l /usr/lib/rpm/find-debuginfo.sh
>   lrwxrwxrwx@ - root 19 Jul 17:00 /usr/lib/rpm/find-debuginfo.sh -> ../..=
/bin/find-debuginfo
>
> I think we would be better off just using the __find_debuginfo rpm
> macro:
>
>   $ rg -m 1 find-debuginfo /usr/lib/rpm/macros
>   69:%__find_debuginfo    /usr/bin/find-debuginfo
>
> This appears to work for me, it would be good if you can confirm this
> works for you as well.
>
> diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
> index c732415662ef..590b5b2e1b40 100644
> --- a/scripts/package/kernel.spec
> +++ b/scripts/package/kernel.spec
> @@ -67,7 +67,18 @@ This package provides debug information for the kernel=
 image and modules from th
>  %undefine _unique_debug_srcs
>  %undefine _debugsource_packages
>  %undefine _debuginfo_subpackages
> +
> +# Preserve .BTF section in kernel modules during debuginfo stripping
> +# find-debuginfo.sh (from debugedit) uses eu-strip which removes
> +# non-allocated ELF sections like .BTF by default.
> +%global with_keep_section %(%{__find_debuginfo} --help 2>&1 | grep -c ke=
ep-section)
> +%if %{with_keep_section}
> +%global _find_debuginfo_opts -r --keep-section .BTF
> +%else
>  %global _find_debuginfo_opts -r
> +%endif
> +
>  %global _missing_build_ids_terminate_build 1
>  %global _no_recompute_build_ids 1
>  %{debug_package}

This works for me, thanks for the improvement.
Do you plan to send the official patch, or would you like me to send a
new version?

--=20
Regards
Yafang

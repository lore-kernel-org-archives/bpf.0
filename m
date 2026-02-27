Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B0F395DA8;
	Fri, 27 Feb 2026 10:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772188577; cv=none; b=XaWT9MT4bnBAQe/o2j6rCsr0qB2Lv1KMlm2UiTuPufCQ1zHixdeAnVRrS9x6A1u7M4KS26L+QxuROQ4d0pVv3uhtvWsMlnOjKXaKhYVW/lum0eQJI0qoZWh9HIr7GDvFjqYrrdAYorSbX2C5AnC+ZYRSfXr9R/FnESwp0Wddb6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772188577; c=relaxed/simple;
	bh=y7T7339wqgGkgXm1KaldrOq1fUHHJCkETOZ0kdpLtUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASCoYVCf9ns7IGhU1CUgP2Q7TQjIxDIFa1V99KeD9Ucy/6wcisO0+TbSXhQwyGyPHRSIgix7z64XVyex+Nn2m9YLGRcPWjfzZ67wIeIW2GU2ytJoEcDlVcVzrqXf9UhY/vniDWdPZF/0KSbE4Qy18B8VJ9qqp8Nb1WnFyEewlqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C8E814BF;
	Fri, 27 Feb 2026 02:36:07 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 588E43F7BD;
	Fri, 27 Feb 2026 02:36:13 -0800 (PST)
Date: Fri, 27 Feb 2026 10:36:11 +0000
From: Leo Yan <leo.yan@arm.com>
To: Quentin Monnet <qmo@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Kees Cook <kees@kernel.org>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH RESEND v2] tools build: Use -fzero-init-padding-bits=all
Message-ID: <20260227103611.GA1098637@e132581.arm.com>
References: <20260224-tools_build_fix_zero_init-v2-1-b1acc817a01e@arm.com>
 <aaCTC86U9KjnmZmu@google.com>
 <99e7fe4e-72de-4b55-9a9a-ae51718a0e73@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99e7fe4e-72de-4b55-9a9a-ae51718a0e73@kernel.org>

On Thu, Feb 26, 2026 at 10:52:01PM +0000, Quentin Monnet wrote:
> 2026-02-26 10:38 UTC-0800 ~ Namhyung Kim <namhyung@kernel.org>
> > Adding bpftool maintainer.
> > 
> > On Tue, Feb 24, 2026 at 12:16:40PM +0000, Leo Yan wrote:
> >> GCC-15 release claims [1]:
> >>
> >>   {0} initializer in C or C++ for unions no longer guarantees clearing
> >>   of the whole union (except for static storage duration initialization),
> >>   it just initializes the first union member to zero. If initialization
> >>   of the whole union including padding bits is desirable, use {} (valid
> >>   in C23 or C++) or use -fzero-init-padding-bits=unions option to
> >>   restore old GCC behavior.
> >>
> >> As a result, this new behaviour might cause unexpected data when we
> >> initialize a union with using the '{ 0 }' initializer.
> >>
> >> Since commit dce4aab8441d ("kbuild: Use -fzero-init-padding-bits=all"),
> >> the kernel has enabled -fzero-init-padding-bits=all to zero padding bits
> >> in unions and structures.  This commit applies the same option for tools
> >> building.
> >>
> >> The option is not supported neither by any version older than GCC 15 and
> >> is also not supported by LLVM, this patch adds the cc-option function to
> >> dynamically detect the compiler option.
> >>
> >> [1] https://gcc.gnu.org/gcc-15/changes.html
> >>
> >> Signed-off-by: Leo Yan <leo.yan@arm.com>
> 
> 
> Thank you Namhyung for the Cc.
> 
> I built bpftool with the patch, with gcc 13 (which didn't get the flag,
> as expected) and gcc 15, and it's fine with both. As far as I can tell,
> bpftool does not initialise any union with "{0}" anyway.

Thanks a lot for testing!

> One potential concern (I didn't try) could be for cross-compilation:
> bpftool's Makefile sets HOST_CFLAGS based on $(CFLAGS), but $(HOSTCC)
> and $(CC) could be different versions of gcc, for example.

To avoid confusion, we can use EXTRA_CFLAGS and HOST_EXTRACFLAGS instead
in Makefile.include:

-----

# cc-option
# Usage: CFLAGS += $(call cc-option,-march=winchip-c6,-march=i586)
cc-option = $(call try-run, \
       $(CC) -Werror $(1) -c -x c /dev/null -o "$$TMP",$(1),$(2))

host-cc-option = $(call try-run, \
       $(HOSTCC) -Werror $(1) -c -x c /dev/null -o "$$TMP",$(1),$(2))

# Explicitly clear padding bits with the initializer '{ 0 }'
EXTRA_CFLAGS += $(call cc-option,-fzero-init-padding-bits=all)
HOST_EXTRACFLAGS += $(call host-cc-option,-fzero-init-padding-bits=all)

-----

Then, in a project, its Makefile can append EXTRA_CFLAGS and
HOST_EXTRACFLAGS to CFLAGS and HOSTCFLAGS respectively.

If this is fine for us, I will repin patches

> The same concern could apply to perf with HOSTCFLAGS, by the way?

I don't see perf's HOSTCFLAGS to reuse CFLAGS.

Thanks,
Leo

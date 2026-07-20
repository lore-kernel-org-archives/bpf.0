Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98445412C02;
	Mon, 20 Jul 2026 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784549841; cv=none; b=Nu4IqPQVQbujdsnWMdm8UDgfInnT1wnlb65k1gn8hOf+PmyhGYXftYTvy2zWde7K0z1Jo/1W0pgy1w06/gd6aSRq+3SJLCJteI4kKPhr6Khk2wn1CHGh57fXSg3+7snJsAexcbxwtbR4QmTsZviGgYQQkNAOnulJ0jgtYRv9Z88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784549841; c=relaxed/simple;
	bh=cPX7SXrXVLS+Md/Og+OpWMa/gdCFVmsBTH7+hfks2i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHa3Snh1tkEjuMhEDWwWsS//R/+NbIYFDWG2Qx8jgumDoQyUGcES67JgjLrtG2IxN7IC5IAY5yYtOsLC613W55a9PrBUuw6L4gAr/aVM18K32pITTI3zIP679BNmf77fj+2EzfnMKhlx3INDYU4PYkAisUb9Cr6D4o/SMvhT6Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huO/1XA3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huO/1XA3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E271F00A3A;
	Mon, 20 Jul 2026 12:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784549837;
	bh=/XSoHtfwnRA/7pRbCd4J4TaF3gDg+Na1cNKc8e9+0y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=huO/1XA35fMX65XD+QsWbl+w6koW5GclLzxS/r1qcO1MJQjeSC35uku5Jqy+Gus/U
	 CEXOdENAiHqnBcZQYWZtw+hijs0Teh3ZTinUR+4QT/UrqV5cpRR2MrMp7zz72Tv5K7
	 Cb0tid4DXzHwuzkeVDk6ZB1Y9uIRVCNWwi65gfqBjoiWFMiuGtpPlQfNTyaIGjLxOA
	 aiUQG8q5AAovBSKUuylHimqkEkgrzo/6MwL9fzhmbtENhBdQ3DHJptN05bcwyFf+ZG
	 SY2iE1bqwfe+r9dkaW5HN/LJ4lgqE2HjsCYqV0Y/7g1PBex/7bpo+lv79pw6gonZaN
	 xNuI6i++5Atag==
Date: Mon, 20 Jul 2026 14:17:14 +0200
From: Christian Brauner <brauner@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH 14/21] selftests/exec: test the transparent binfmt_misc
 mode
Message-ID: <20260720-wohnen-goldfisch-einnahmen-cf2a640b57c8@brauner>
References: <20260720-work-bpf-binfmt_misc-ptinterp-v1-0-ddb76c9a508e@kernel.org>
 <20260720-work-bpf-binfmt_misc-ptinterp-v1-14-ddb76c9a508e@kernel.org>
 <20260720114447.4F62A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260720114447.4F62A1F00A3A@smtp.kernel.org>

On Mon, Jul 20, 2026 at 11:44:46AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Stack-based buffer overflow in binfmt_transparent_interp when concatenating strings into the `expect` array.
> --
> 
> --- Patch [14]: [PATCH 14/21] selftests/exec: test the transparent binfmt_misc mode ---
> commit 9d915ef86186ae5a0a73c74e07d46a93d08f7fe5
> Author: Christian Brauner <brauner@kernel.org>
> 
> selftests/exec: test the transparent binfmt_misc mode
> 
> This commit introduces a transparent dispatch test for binfmt_misc from both
> activation paths. The dispatch routes to a shared asserting interpreter that
> validates the kernel's constructed identity from inside the process.
> 
> > diff --git a/tools/testing/selftests/exec/binfmt_transparent_interp.c b/tools/testing/selftests/exec/binfmt_transparent_interp.c
> > new file mode 100644
> > index 0000000000000..2a71c47067582
> > --- /dev/null
> > +++ b/tools/testing/selftests/exec/binfmt_transparent_interp.c
> > @@ -0,0 +1,130 @@
> [ ... ]
> > +int main(int argc, char **argv)
> > +{
> > +	const char *binary = getenv("BINFMT_TEST_BINARY");
> > +	const char *argv0 = getenv("BINFMT_TEST_ARGV0");
> > +	char exe[PATH_MAX], real[PATH_MAX], buf[PATH_MAX];
> > +	char expect[PATH_MAX + 32];
> [ ... ]
> > +	/* Distinct from the binary path, so a classic argv splice is caught. */
> > +	want[0] = argv0 ? argv0 : binary;
> > +	want[1] = "argone";
> > +	want[2] = "argtwo";
> [ ... ]
> > +	/* And so did the kernel's copy of it: the same strings, NUL separated. */
> > +	for (i = 0, expect_len = 0; i < ARRAY_SIZE(want); i++) {
> > +		size_t len = strlen(want[i]) + 1;
> > +
> > +		memcpy(expect + expect_len, want[i], len);
> 
> [Severity: Medium]
> Could this overflow the expect[] buffer?
> 
> If the user executes this test program with BINFMT_TEST_ARGV0 or 
> BINFMT_TEST_BINARY set to a string longer than PATH_MAX, expect_len + len 
> could exceed the size of the expect[] buffer. Since there is no bounds 
> checking before the memcpy(), this would result in a stack-based buffer 
> overflow.

It's a selftest and the callers just don't do that. So let's not worry
about it.

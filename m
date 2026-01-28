Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C477528642D;
	Wed, 28 Jan 2026 21:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769634173; cv=none; b=M22KiEoWX8hFjA9+TydzQnNPCG5fZaDRvJnXZNFnFqDTQ8YfQG4MDgiYPlwf6la02jj4hXsaoDP3uIP2k4qdST9gytLdwqHZyZUp7fO7nzEpD8NqUcayo5iEynAl2TeSan6F2FiLJdNcM5XCsvutv40hPa22cOKwZ4k2BARaZR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769634173; c=relaxed/simple;
	bh=Em+1CFVsGAsUe/PMauooL4Cb4HFJrPLZWLtlAhkW/CA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=elDRcheAB02fdeW0Fhcreqb1CmlEGHJcpdkeaCekyu1oIZRpbibeizHjTAhoIdo3GGwRhsN/Wb9Q2G1DXW4+q91MQ+8Nq7Yi+Bg4irPKmFfF7U7UkTelX12Oy7zHXh8Am0UV7SgsPOExl8AwJOmJ86YPQClpFKWPrG7bgmFuFg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9sud/Oj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9sud/Oj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9049C4CEF1;
	Wed, 28 Jan 2026 21:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769634173;
	bh=Em+1CFVsGAsUe/PMauooL4Cb4HFJrPLZWLtlAhkW/CA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L9sud/OjQlo/A8mfYVJG4RYoCHr0nhu15eOZV8viCBJwMyvP70iv5PR2+yhazk3UH
	 8r9nOrBDvFeEtCKI0Pxd7lB4HmSf9Y4kCqCaF2uyICd/VipWRTepNSW3SVTtgmKRSg
	 9jlyZD3nNL/djj9ed/Ic1JMP32OVh/NddE/JTxt5zzrSOsRiWA1XugXm8DYPde+73e
	 4HgePSHGO0Peu97Z1U/vMnJ6/KZs5aKjw3G5m9oM/GnRs8f1Yu/1la43tFdlHnevBp
	 FPLBMoFxCIFt2CJuj7me5PshlVjXA+mGBCyQfySrEZjO3R9ZeqLzGIRwjXAG1ZLNu1
	 mNF9JwPDdqq7A==
Date: Wed, 28 Jan 2026 22:02:48 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, "Mauro Carvalho Chehab" <mchehab@kernel.org>,
 <bpf@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, Shuah Khan
 <skhan@linuxfoundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [Intel-wired-lan] [PATCH v2 23/25]
 tools/lib/python/unittest_helper.py
Message-ID: <20260128220248.7a0d5b9f@foz.lan>
In-Reply-To: <5b8fe4ae-25a2-4967-bb83-a52dd5907951@intel.com>
References: <cover.1769617841.git.mchehab+huawei@kernel.org>
	<f370f2a0dfcaa679c9969488c908eaac82026031.1769617841.git.mchehab+huawei@kernel.org>
	<5b8fe4ae-25a2-4967-bb83-a52dd5907951@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jacob,

On Wed, 28 Jan 2026 10:09:18 -0800
Jacob Keller <jacob.e.keller@intel.com> wrote:

> On 1/28/2026 8:50 AM, Mauro Carvalho Chehab wrote:
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---  
> 
> What is this patch trying to do? the title is not descriptive, and its 
> contents don't make sense.
> 
> >   tools/lib/python/unittest_helper.py | 16 +---------------
> >   1 file changed, 1 insertion(+), 15 deletions(-)
> > 
> > diff --git a/tools/lib/python/unittest_helper.py b/tools/lib/python/unittest_helper.py
> > index e438472fa704..3cf1075b1de4 100755
> > --- a/tools/lib/python/unittest_helper.py
> > +++ b/tools/lib/python/unittest_helper.py
> > @@ -8,21 +8,7 @@
> >   Helper class to better display unittest results.
> >   
> >   Those help functions provide a nice colored output summary of each
> > -executed test and, when a test fails, it shows the different in diff
> > -format when running in verbose mode, like::
> > -
> > -    $ tools/unittests/nested_match.py -v
> > -    ...
> > -    Traceback (most recent call last):
> > -    File "/new_devel/docs/tools/unittests/nested_match.py", line 69, in test_count_limit
> > -        self.assertEqual(replaced, "bar(a); bar(b); foo(c)")
> > -        ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > -    AssertionError: 'bar(a) foo(b); foo(c)' != 'bar(a); bar(b); foo(c)'
> > -    - bar(a) foo(b); foo(c)
> > -    ?       ^^^^
> > -    + bar(a); bar(b); foo(c)
> > -    ?       ^^^^^
> > -    ...
> > +executed test.
> >     
> 
> You delete a bunch of the output here, but don't explain why. If this 
> part of the doc is no longer valid this should be squashed into whatever 
> patch made it invalid. I suspect this is the result of the new wrapper 
> you added?

This patch came from a tool I wrote about one year ago for my own
personal usage. 

It was meant to be merged with patch 21/25, as it cleans up
the module description. I ended removing a function that was
requiring:

	from difflib import unified_diff

as it was unused, but, a second look at it, I guess we can just
drop this patch, as this is plain unittest output.

Anyway, I'll handle it either way at the next version.

Thanks,
Mauro

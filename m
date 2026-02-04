Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9CA30FC29;
	Wed,  4 Feb 2026 13:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770212836; cv=none; b=FAVQn+8ia0hOZxaH5i0zVhv2qQk31LEJzqIpF4IrsFKLVOafmnr51Kzsn3T+PdKk6j+mQJ7gVk1OV5kwISvqmTrrY6n4Q1aLxm2KqIcFXeUL0T9Xj6IbLIG57Dy7HDNi+sUcVB0fbnB8MqCZVRP2mlJDEu7LUADKtvzBDSXp0/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770212836; c=relaxed/simple;
	bh=uwO601VYhYVY61ObsCAsobuQ5Jyi6M7D0IeCgu4gCVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrpkfFhb2ntRjknNGYCRerv7sIyzykdVSZkr4eqK+Lth2SLiX5yK/iDjkVViZBPfUGZyJFqQf5iYm9WWjvGqbgAeO2XmakeFXHVkh1QICE4S5uUIyw57vYg0rvDNhLvDIiqjFS3KfK5n5EX5fvzGIs9yp0TVLrTnDPcAhc4Maaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KBN9+7lf; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KBN9+7lf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770212836; x=1801748836;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uwO601VYhYVY61ObsCAsobuQ5Jyi6M7D0IeCgu4gCVY=;
  b=KBN9+7lfFRfozr40gG4ysXSFhBmKtMlxEcBxe9ebBv+2pPGwDmNmnjSJ
   IWArqLdhNyEb+5q0ZHJC5BA+uf5JbZg3Mot7EgiK/ozh+NlY9Y4Mk0Ze0
   037gQEc2edo5vcdbRKO13apeaQ6IKKs/C4v+2yq+pSaAgH3ylnRo7YL/T
   bq5K2LFPEjswApKvy555GoIQtY4iXQ+OQie2bKBQd8GFikrWPxVNJ+pSj
   6ZHnbRFgq2ynH6ci4nTiDHUk5rOlctfPvxLgvMzY9i8X1TLDmKZ3A1q65
   AVP8R8EMg9N3us9jk16k2yjBHXGrXYCY9YekIU68yIxKfCPC8lrzOu53F
   w==;
X-CSE-ConnectionGUID: tfsRan2cSW2UAx6Ficuvrg==
X-CSE-MsgGUID: sxbI2GulSfmtCWHRiQdsag==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="88975963"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="88975963"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 05:47:15 -0800
X-CSE-ConnectionGUID: dwUlw+xIR1yKcXK+t5g2Ng==
X-CSE-MsgGUID: IWHwvpkdQjG57v3UFgJ0kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="247768479"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.188])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 05:47:13 -0800
Date: Wed, 4 Feb 2026 15:47:09 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] vsnprintf: drop __printf() attributes on binary printing
 functions
Message-ID: <aYNN3aPIIQqrRbaB@smile.fi.intel.com>
References: <20260204132643.1302967-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204132643.1302967-1-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 04, 2026 at 02:26:23PM +0100, Arnd Bergmann wrote:

> The printf() format attributes are applied inconsistently for the binary
> printf helpers, which causes warnings for the bpf_trace code using
> them from functions that pass down format strings:
> 
>     kernel/trace/bpf_trace.c: In function '____bpf_trace_printk':
>     kernel/trace/bpf_trace.c:377:9: error: function '____bpf_trace_printk' might be a candidate for 'gnu_printf' format attribute [-Werror=suggest-attribute=format]
>       377 |         ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.bin_args);
>           |         ^~~
> 
> This can be addressed either by annotating all five callers in bpf code,
> or by removing the annotations on the callees that were added by Andy
> Shevchenko last year.
> 
> As Alexei Starovoitov points out, there are no callers in C code that
> would benefit from the __printf attributes, the only users are in BPF
> code or in the do_trace_printk() helper that already checks the arguments.
> 
> Drop all three of these annotations, reverting the earlierl commits that
> added these, in order to get a clean build with -Wsuggest-attribute=format.

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



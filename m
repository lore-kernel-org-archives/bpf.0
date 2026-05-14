Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BDB319848
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 03:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778728835; cv=none; b=ehPy9RHQGxCcZfij5kJzxdpaGpthZw4jai6U16r4q9pZgN3axVRrzWwG401bNWdsLcmx7uCEdqMNRo1+5CfuBizHrgPUvr3b7yN8i1oO8GKf+k4oPWRmLNMW5iFRGXVe6X/BeL02uFBryCxYxQAMZkm6KXUyFeOk0IDjHGjN27s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778728835; c=relaxed/simple;
	bh=Oi/1+LN91lOMsDKeXf69Zlz9lr55WCnhfCkb8LI9jvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InO906S37rBPg+njKbmElP1iVhGm9ye1SCaRxUqerN+aD0Cg/PWcdyQ4v9sBaKxU1/4urKeaniC0fLRuoxqPSQpo6UkmIeOM1CkAFZlE17sXBAXTK9r1zekXDulYF0t3FrZ/R9YmbKOunmzbQob46kUQeM2Tudr6C88IH+XDXic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGb4CJFs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGb4CJFs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A7DC2BCB7;
	Thu, 14 May 2026 03:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778728834;
	bh=Oi/1+LN91lOMsDKeXf69Zlz9lr55WCnhfCkb8LI9jvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SGb4CJFs2buMZLG1d1qNWCK/3AcBbRdlqQWUvd6GEBDFWflbpJLJVQzHkjEOWPIbl
	 4gBwybVkPEJxhv1RMe5cfGR43W6GaPRzTVU2AwVUpHgg/jWLmZgkf6lPBQcm82Dxmq
	 zF3l3oiYUW7+UTywbgckni/o2eQRlrV3vPl8jYQgi5rgPVTWXM+EZZXKvrEuOQ9kvp
	 aR4jSEtqL1PhnH/HJ8p+e5Dl022FWKKDwWDEi5smiUnbnRygH5ceWx9fDJJYUUL2Ow
	 ICKpqyUpxZ3skV7Z4+vWDF+zDvx0T3g3pmt/ew/encA7vcy52IFdqRlf4kSMtc19rz
	 mUSAoxVrF3Hlg==
Date: Wed, 13 May 2026 20:20:33 -0700
From: Kees Cook <kees@kernel.org>
To: sashiko-bot@kernel.org
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH v5] libbpf: Use strscpy() in kernel code for
 skel_map_create()
Message-ID: <202605132019.50976E8@keescook>
References: <20260513050806.do.620-kees@kernel.org>
 <20260514015610.1D339C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514015610.1D339C19425@smtp.kernel.org>

On Thu, May 14, 2026 at 01:56:09AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The use of the 2-argument `strscpy` macro in `skel_internal.h` breaks compilation of light skeletons for out-of-tree kernel modules on kernels older than 6.8.

True, but this is strictly for 7.1 or later. :)

-- 
Kees Cook

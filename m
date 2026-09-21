Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4833C2786;
	Mon, 21 Sep 2026 23:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790032043; cv=none; b=BsVWEpk+Fy/IVaVrDZbV/sMbQIxVs+YLWldwV+y0MW/NGHmqHgK8y/LNSu/EKKkhypBn7gU81cTYh9HeVArOhKtVf9pZlwq4BHox66LHfzg9qyMdii/6MThII4axbpLJpQBZD1nhYY0SXekOev6IspiFlRvetT9O7fSEP11gM3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790032043; c=relaxed/simple;
	bh=HkEMdNV7TsOd2RtOy7vfVvq2B65cmc7G/qaKsYZjZi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKDQhW+z/HRjBSimvec2NLxeO+NNmfPxDwEofoK+8bQlZC8Dr3uXD0WAb3ToOhOLPhpJ4nX2aRTpiVdBZctaD0ySLhwqscNm0W43uR+PgOTiCSit9fQDlhWEM0NP2jtTl+nRqPV6sobBAaMczCOzrMHrOEmtaTEKqU/WGAN0mhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCSuXqGA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCSuXqGA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70921F000FF;
	Mon, 21 Sep 2026 23:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790032041;
	bh=daXKKomBZ0NKVSU/7uUzUFgb4eDK89Q9SQnZVbxUdpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gCSuXqGAvup3ENNFh3ha3jEYuQSPTG7w49m+Ih71MW0BhHexXmZnTHrRJwuBZgd5v
	 oeKw3v07zVuB/BOmFfniTSk1f+2raWfQEh1WWCmhzKyNB+06U7POBxjqoxdG30bGmT
	 mkPF6U3A5ALzekOScHj+DRRM28D7amhUNr5A6JP7SmeGUZS3jiwKv6TTCKUPVH4Cb2
	 BKhjilFd4TFGPRsfxzOdUWWSuCrCajopQlVDpxXcGrlJpLNQ5KQLC9N8F0qBYbQn0G
	 Hk48TuwoHwtJTZq2+e4gsUKEsJ9vOThFmaFeMPPBg6vvva3S56dewB7mvKP6aM7ZgD
	 b0jBX1Be3MvRA==
Date: Mon, 21 Sep 2026 16:07:21 -0700
From: Kees Cook <kees@kernel.org>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 0/3] kallsyms: Accelerate symbol name lookups by ~19x
Message-ID: <202609211605.9F15E5B1@keescook>
References: <20260919-ksyms-tune-v1-0-d85c97da1a32@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919-ksyms-tune-v1-0-d85c97da1a32@gmail.com>

On Sat, Sep 19, 2026 at 09:58:54PM -0600, Jim Cromie wrote:
> Memory footprint: +573 KiB .rodata for kallsyms_names_offsets (191k
> symbols * 3 bytes on x86_64 defconfig), minus ~2 KiB from dropping
> kallsyms_markers[].

The speed-up is impressive, but I have to say 500KB is not exactly
trivial. It's not _huge_, but it's not small. Is the rate of symbol
lookups in the kernel high enough to justify this loss of memory?

-- 
Kees Cook

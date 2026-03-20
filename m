Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D0C372B4D;
	Fri, 20 Mar 2026 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773996078; cv=none; b=PnL2nQ8/iUcc3UvARC1ApG/u5yC0A9De/h4ESjCGT/UhtuTjGjW3EA2Y5cOsnqRM/aoo77L0fJj1q9UoxFl3CmyLciDbwSmNd+173UjNuAAAA1+/kkyO3ZcyEiaan2p8AVhmDvGyJJH5sbujlDDJvkOuDcjJK21cghh3dAU4NJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773996078; c=relaxed/simple;
	bh=g90O7nn50XsDORolSKBsWrsdvCLSXXNC55dyYlhTatI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uOCPMPE5K15zg3oO6+qfLxqSjbe1iyADfNbRdU86LTPFgi03gdXRUgp53+MCFsdtR8dKgwi3YIpQZaQDoR8GcTnb2pBuoztEXIGK7StK+q+Kz4W2bcs0nk3qWtfZ7joQsJbeYFbNjeH9iFUC7FlgAAMpYIZgmfFnpVAsdlMx+rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INsX3Raa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INsX3Raa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B11DC4CEF7;
	Fri, 20 Mar 2026 08:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773996078;
	bh=g90O7nn50XsDORolSKBsWrsdvCLSXXNC55dyYlhTatI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=INsX3Raa6UuQBdkSKJPPW5RhopKsv3LU7PGRZr50uMqaj2nHfxcWdIUvjLhtMpYpX
	 3e/Taz5O9lc0pWNpHoNh/MZWXASooUaX8As4f/PCe8uWk22rJQ6R/L/B8TRWIpEhJU
	 zmuOffFTB4OHEbaKzQMbxxCeiv+G0s/eTPLjEfGOIPw4ASf8C/R7xFSNBKEPnaEu7C
	 2B9VNCvzJvlPLH8DKNuRm5clGTBqup1CVUnFag76gKdMrKoXdQJTgzVXKEDl0f6C1D
	 z77zj14HY4ZwuN6DzrRCsNZReM64LEjTmTtMLu4e5A8uZ3ATXF65vFugt2Vopzkv+i
	 3XJ1rPiWNcvwA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 larysa.zaremba@intel.com, aleksander.lobakin@intel.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH v2 net 7/8] selftests: bpf: have a separate variable for
 drop test
In-Reply-To: <20260319175538.479139-8-maciej.fijalkowski@intel.com>
References: <20260319175538.479139-1-maciej.fijalkowski@intel.com>
 <20260319175538.479139-8-maciej.fijalkowski@intel.com>
Date: Fri, 20 Mar 2026 09:41:15 +0100
Message-ID: <87ikaqopuc.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> Currently two different XDP programs share a static variable for
> different purposes (picking where to redirect on shared umem test &
> whether to drop a packet). This can be a problem when running full test
> suite - idx can be written by shared umem test and this value can cause
> a false behavior within XDP drop half test.
>
> Introduce a dedicated variable for drop half test so that these two
> don't step on each other toes.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

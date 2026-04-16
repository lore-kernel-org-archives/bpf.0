Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE6239E6F0
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 10:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776334838; cv=none; b=T4yCRdhZ6WQcFo2LK7YZsQnmkhmHsU079lTzejHyBZvXmV/32UsVkFgozKDDx1eSojc58Z5MRkvs7kycYT9CZeMEsQrfLiWHHionjwMuDEeIzSDcQCgTKQ/tDDQMNgwM9fawIvvyg9bpAW1Du8r7eWGpf7nacv+HlHABd20jTvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776334838; c=relaxed/simple;
	bh=HMci5dFjdPIeKEYg1iGbqvqwrYXZnr0W+mia6MqBBMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzBgltcNRaLm6BkHZHnL0dyLDh5mm4NDq18v8vuuuAjJZh2CwS/cSOH64tfd1cCzPSFKCYRCVM5XiLLbJpgxv2XG/ElVqoUt2FPghAQG54iTCpUerUT7vkruxk1CuOEH+/8+10wa+WsrnqNRYOuuM0t2aWKX+MkYocsN/T7Y968=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nh5KhjRv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nh5KhjRv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7831EC2BCB0;
	Thu, 16 Apr 2026 10:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776334837;
	bh=HMci5dFjdPIeKEYg1iGbqvqwrYXZnr0W+mia6MqBBMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nh5KhjRvIc6OjX1zQsjga+fDFfA4/m0AdDIkzAq1Qxjn95JzbOZK9BvQBmu4kvThf
	 0gYJgvYE4tYut6c3XZOphBhtmss1dOSzr+k0/zvgrd+WHjVYkloT1SSH+PND/3wpK8
	 roCzhTn74MTUHxw6PK6VhSRNG9PDvjRmMXQoSP4hxtoVUg24uEcZAOaDqfh1pXK9jU
	 E7aeQm1HVUndqAtZhr81zQqZTgQkz/sr/x2EdPYSoGLRPpnsckWldlh8aV4yytFphV
	 ufiWMcjcLT591/6ZzMh9s5QwW627m34XwjS5fgzbw4OPS+dnleVCFubwAtTOPeHgX8
	 1+mUgzd+EtFZQ==
Date: Thu, 16 Apr 2026 12:20:34 +0200
From: Antoine Tenart <atenart@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Antoine Tenart <atenart@kernel.org>, andrii@kernel.org, 
	eddyz87@gmail.com, bpf@vger.kernel.org, Paul Houssel <paulhoussel2@gmail.com>
Subject: Re: [PATCH bpf] libbpf: fix deduplication of typedef with base
 definitions
Message-ID: <aeC3ta43I7ZJFWZ5@kwain>
References: <20260416073826.142056-1-atenart@kernel.org>
 <74ee8ec0-904b-40ae-8fd8-25e1aa24b465@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74ee8ec0-904b-40ae-8fd8-25e1aa24b465@oracle.com>

On Thu, Apr 16, 2026 at 09:31:53AM +0100, Alan Maguire wrote:
> On 16/04/2026 08:38, Antoine Tenart wrote:
> > When deduplicating definitions for a module, typedef defined in the base
> > are not removed. This is because the hash used for base types differs
> > from the one used in the deduplication logic in btf_dedup_struct_type.
> > 
> > This was introduced by the referenced commit when moving the typedef
> > deduplication logic handling from btf_dedup_ref_type to
> > btf_dedup_struct_type, as this also changed the hash logic
> > (btf_hash_common to btf_hash_typedef).
> > 
> > This also impacts other types referencing those typedef (e.g. const). In
> > my test, the BTF section size of the openvswitch module went from 31KB
> > to 45KB.
> > 
> > Cc: Paul Houssel <paulhoussel2@gmail.com>
> > Fixes: 3781413465df ("libbpf: Fix BTF dedup to support recursive typedef definitions").
> > Signed-off-by: Antoine Tenart <atenart@kernel.org>
> 
> Nice catch! It would be great to have test coverage for this in
> prog_tests/btf_dedup_split.c ; adding a duplicated typedef to base and split
> BTF in test_split_simple() and ensuring it's removed from split BTF
> would do the trick I think.

Makes sense, I'll add a test for v2. Would you prefer a dedicated test
or reusing an existing one?

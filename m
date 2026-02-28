Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C3923C50A;
	Sat, 28 Feb 2026 23:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772322622; cv=none; b=bBwyFAxeY7VYG8aFBUh4QtjqrolswKNbGMUE5L3Yhfsfx1k7sUl8Kr05EwbuGikWi8t27Y6kdmT0neyev0K9T5xo8XlZN6SAG0fqubt7LsPVwZzGQ0xwfWp/xGE+1vEMcVEVp4KHwAb+99egJvzYBrBLi5PWBoqwq/98SvFUL1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772322622; c=relaxed/simple;
	bh=nVlPNvjcp5bH3FHH4gSFEM25vu7Wj0UJtLOs5CcgAmU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NL2LUdx/1G3PVm5adtC8XblMmF9AuzI6kDk+dUpOIcU1vX8EwrYOIDwFKFdYW+xuNEcAsrte4yUhAF9ky53o/WMkff/FCKS5ZxJ/morBCt/Rza6TQbvvfBNyEvIKc7NS+gQp4W7sVUU/PG3vxzUx0hBmK6+SZW1C6Eaie/xY+28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyqTiH9r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyqTiH9r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0A3C116D0;
	Sat, 28 Feb 2026 23:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772322622;
	bh=nVlPNvjcp5bH3FHH4gSFEM25vu7Wj0UJtLOs5CcgAmU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OyqTiH9rcOwH2NM3d0us8lnhjpGWEwpL9eT8h7L7vYWdy686PC/K+hP7Uium0c0Ig
	 HFRAzcdD9S40OFcFxR2jUoe/za+brX3OFaNfk4wGLN9LPcki9rrJ2PrEJgEb0E/tFc
	 CBqabPcX4cdQ35Bhsxv85QyMWzRv/M8I8cyuUbQeYF8ECnjTDtBXTCgABOqYKdyXs2
	 /mbOqa5qmSw0Ifq/P7xed047OGIc7LNoLXodTSNW3KIDLDXlkhegzAa1rDkhMSuPtG
	 E+kEA4n2mwCxeq9U+xPbpgsFG5kh3M70LVnIsnLbvMWlvwzcKJsVKRY4DEHm8FisjH
	 gbMI+fhVibQ8A==
Date: Sat, 28 Feb 2026 15:50:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jakub Sitnicki <jakub@cloudflare.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf
 <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Network
 Development <netdev@vger.kernel.org>, kernel-team
 <kernel-team@cloudflare.com>
Subject: Re: [PATCH RFC bpf-next 0/5] skb extension for BPF local storage
Message-ID: <20260228155021.1dc9b127@kernel.org>
In-Reply-To: <87wlzydk12.fsf@cloudflare.com>
References: <20260226-skb-local-storage-v1-0-4ca44f0dd9d1@cloudflare.com>
	<CAADnVQKVfyh3_OZshvYf7GJUF-ph2eMfmaQsxNgwBJd1AJgXTQ@mail.gmail.com>
	<87wlzydk12.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Feb 2026 21:11:05 +0100 Jakub Sitnicki wrote:
> So to exhaust all alternatives I gotta ask - would you and Jakub be open
> to the idea of a plain byte buffer embedded in skb_ext and exposed as a
> bpf_dynptr?

I'm fine with that, but admittedly I (like you?) live in 
the comfortable universe of controlling which .config options
are suitable for the narrow use cases I care about.
So I don't really trust my judgment. Adding Paolo..

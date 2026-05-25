Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16DB290DBB;
	Mon, 25 May 2026 19:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779738866; cv=none; b=Pmj1SIKm0eSQ21cPS0W8fyoI1ygJW4HhmUSd9DD/J83Q7gXSlCYcdue25AflM2vK3MOE85AeDfbwbwkRJDEeeO58qT79Kz2w3/JxZwie+hVrewNNx7q5vXe18g+Qu1Iqu+L5c1a6Z3kF+Ojrs8ADZTITaUs/quI/PBsvhevhZBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779738866; c=relaxed/simple;
	bh=u/qGy74QsXohW/BY+X5DqQ4oseT1pVTdC0g2DKtRwAo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=uIpgKINPgoUcAbFdNfdJM71j74SnbClU7amijUdus35ezyZTFaGDXSsCZsjq95QuGlffVkhiMoTkZKaRRwZa0s8+hEcak5xHdk82rmYFbOZxjGuvmCDMG+iieNoJJA74oQk8aDk6KE/Lsny7LGQH2CbMctelXrSjQGlnPx5fJRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqGm8cye; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqGm8cye"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1241F000E9;
	Mon, 25 May 2026 19:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779738865;
	bh=dii3jeukr9ExIOwor2LDBx6O9OEuTAMnAAZyBHgb1+k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SqGm8cyerm1SAKBPfWzdO911EPlHOkLgLQxNL2YxIKlaa2m0/wIkdLGaWuQk+uw3A
	 G0G816Zc+XLJqqK1siV/8whKehjGCchy2oHMQybI8D6VxAGgQVAUZ+vcgQRLeAYQye
	 dWwIkfUAttGN+Wsn0GfAh/zvhzjAP/ItOgIemH25wTluWa6DsZan0Y76olOHNS5Sr4
	 1O6OhHpe8Tujbolu0VpDx2Iq0Hz5cjSu60j0wNILiZ92QyrouncjKvYvJS4zM4WeC8
	 xq9487/+ZwKDyziuUXNXpYKOVQwNYYTPa2ufLfi6pMzaq7gRCTDprZ0o9epjoJI8jG
	 zQZEOSY357XFw==
Date: Mon, 25 May 2026 09:54:24 -1000
Message-ID: <240ca6a938e38d2af591f09a721d6e9f@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev, bpf@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCHSET v4 sched_ext/for-7.2] bpf/arena: Direct kernel-side
 access
In-Reply-To: <20260522172219.1423324-1-tj@kernel.org>
References: <20260522172219.1423324-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Hello,

Patches 1-5 went through bpf-next and are pulled into sched_ext/for-7.2.
Applied 6-8 to for-7.2.

Thanks.

-- 
tejun

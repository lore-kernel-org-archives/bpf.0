Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1363D9DA7;
	Thu, 21 May 2026 17:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779385194; cv=none; b=oEOLFPS4kFv3GpAmCYugEPujAN8d7uuZ006tk9fLZ5UMD2O6XoLMTnVV3I9DSD9lJO2SvO/sKBY+6idaEzN1s5pN78BmiEES9Y4TJZ8LbT1V2YtlHz4MhYQNMYlGiFwuQWgOxYMK5tUQbX+lO0ejRaiFHIJveEHxmVqL7PHvU2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779385194; c=relaxed/simple;
	bh=XC4bTD82SBCjMe8ND4JWiT6JV62kyNhLkSlwf37/Q38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dK2LuhLLqmYDjTQgYLRoRadnB5y7vP4Gl3/ZPDothPeoSxasHgd4V176BUOqN9Ik2KHQR0yTgxr0AlICFDydmESsshNdM4FWmsi05WgW82XTlz53lsI6l1A1lDl7ir8jeVAn5VcSGd3gjDTv/fCQgn85RvytyXxnFsem291xaNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Un7uQ1tr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Un7uQ1tr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522EE1F000E9;
	Thu, 21 May 2026 17:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779385192;
	bh=oJO1RcjiVrxikN4S2wMkT12NDdZvJEOL3uH9OszuZ6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Un7uQ1trx83eYUwW4uPp58qqvs/tOPLwPdqNWzVDB8TdjlrZg3PYemqiyguS3thAl
	 r5RMzSbCtDUCq1L5OYI8C19bFj43M0ei0laqWrel3mO9LzNY0PA/u8Ptgb2zjXkot2
	 eoZz4Kddz0tCIF+7fHSC4xxd2IiIXm2k+VY+P+lIsIDTjHT2/7ZXPguRju+yNr0L+f
	 pFtwpqfwkaItBOWCFBjHxFXJTPs51yxkfBgXyyyf7J3iVxNSXdfyacp6+G8MEDGXxr
	 FX3BkCtVScCsW3lP3RgenIgDaBUVQx1qv4re9v+xWcd0RfpNKUveGA3TM05F1+LFKb
	 tJVgWkvmEwd9Q==
Date: Thu, 21 May 2026 07:39:51 -1000
From: Tejun Heo <tj@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	bpf@vger.kernel.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] bpf: Recover arena kernel faults with scratch page
Message-ID: <ag9DZ84OyofILjHM@slm.duckdns.org>
References: <20260520235052.4180316-1-tj@kernel.org>
 <20260520235052.4180316-3-tj@kernel.org>
 <DIO99FYEHNC1.23KFEHRPTRB5N@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DIO99FYEHNC1.23KFEHRPTRB5N@gmail.com>

On Thu, May 21, 2026 at 02:42:50AM -0700, Alexei Starovoitov wrote:
> On Wed May 20, 2026 at 4:50 PM PDT, Tejun Heo wrote:
> First 5 patches lgtm. Should we create a stable branch out of them
> and pull into bpf-next and sched-ext trees?
> I'm preparing a followup for slab-over-arena on top of these changes.

I just posted a new version of the first patch w/ comment update. It'd be
great if we can make forward progress.

Thanks.

-- 
tejun

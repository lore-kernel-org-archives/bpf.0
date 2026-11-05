Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887325;
	b=IQr9phMyFpHaHTUx0BXfyjTpnKfEFN5rkHZzqkGxVqlX49BAREjkhvW8f4uWk0OitSbj
	 mJejqF7ZPOrHjRagk8Txu8NDw3sbaz7C76cSwfD9f2CijBB9BWJ+ls+bfNJA4mMRD259e
	 /fP9ILPBtcsv+bDjMYKiG2ctdLMKHbtc06Ini4M3OVATWebKzchNYAsHiNMyVhnu71u03
	 3/TGRTQ4zAvgP20fC4FddgxCS/12U1JGFOYr700Pn3Lm3W0tGRjourAA/OEq0OtFwqSQb
	 fpABNjuUWjXaz000WwF9SPFb7nSv/4mMOCFEJkO+ofdljEawcGYgIlUmSAMk8rKPzHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887325;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xsq3HeGsICcD9qR4LeaVPKieAjkKF0z7rahKgx3b78c=;
	b=M0p9Ysjv5P4s4uAFsqAc4r7YuhXRde3evJ8dfkA5aDWEx0qJe7KVmkIHMiNIXJZnCZWi
	 9TKm3V6SR6AheBPjuRq89yeOF+uh3V0HlKRP2bto4Czy5894ux9fP142ViM1U8Vxfv4Oz
	 ulcYzroJLrVr4I3mFgSIIQOAgMtzBKtEPFM7KEQQTcUd3etdZ4Yg6MFQVwNGu++/Z1Mfk
	 VxQpush+6+lt2/cSHBEmbop2+U8eGOEGryfA4oXf1bjZL+tukuA5n07O5eOu5D2rq1bj5
	 0BuB4Lj8jfXObYLNk/JTE6UAMnNphE5R08xPC9VFzHb2os4XEqsA5yz1MC73JVUJLeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VCXdsPfc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE69F606A32C;
	Thu,  5 Nov 2026 14:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VCXdsPfc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E023E1F000C1;
	Thu,  5 Nov 2026 14:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793887324;
	bh=xsq3HeGsICcD9qR4LeaVPKieAjkKF0z7rahKgx3b78c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VCXdsPfcQokl8f+rjLdNBL+YCFkzVLRKWrFySEE1WMzPl+ktC9vx0bBWrQsN9nihj
	 tI18V1AdcZLO2Wp4q/XVD+jddiqq8RxzmrwGeZc2I/5xJGlBmc/lzvB9ahZ8wbsrHo
	 2uxI2T8kn4sNtptex1MZV2ldZjPoTKOBNL315/ys3xnd96b7/OmUqv3SMvRknBUU6n
	 dlceNP+HUlg47v3tzKlUWNTjIKpN5HQZNGVg406HGvI1os0tGuxwamsSam0tHt6WI5
	 TLF6oIQU3Cawwx/shvdd/m82/qVvcUBjYJs1I074yQfHmmLWRCw4F5bVOdVN7WG+5r
	 flUIfgaLzHqIQ==
Date: Thu, 5 Nov 2026 14:01:56 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 2/5] mm/khugepaged: scan mm's more efficiently under
 mmap_lock contention
Message-ID: <auyL2gLT3lDVqwMJ@gremlin>
References: <20261103-khugepaged-latency-fix-v1-0-a07ab16ac860@kernel.org>
 <20261103-khugepaged-latency-fix-v1-2-a07ab16ac860@kernel.org>
 <dfa01a1d-0b95-4cd2-ab8a-390da5ffe2ab@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfa01a1d-0b95-4cd2-ab8a-390da5ffe2ab@kernel.org>

On Thu, Nov 05, 2026 at 11:23:41AM +0100, David Hildenbrand (Arm) wrote:
> I could have sworn I saw a similar patch from Nico at some point ... maybe it
> was in a private discussion.

Ah, yeah, it seems a fairly obvious thing to do (as often these things
are), was surprised somebody hadn't already tried it.

>
>
> Am I correct or is the short version of this change "Remember the next scan
> address per MM instead of starting from address 0 whenever we continue scanning
> a MM after a skip; and we might skip under mmap lock contention" ?

Yes!

>
> I think a lot of the commit message above can be simplified.

The book author part of me comes through sometimes ;) Will try and cut it
down for the respin.

>
> Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks!

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D35411664;
	Mon, 15 Jun 2026 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781545209; cv=none; b=KvPXQYRyX4ODHA1HguMgUonPjFRt8D+ktFWFb9Hn3u8Sfek78VnR1SDhf8RgpIEGiPvzavhQ0rVSEgMadz1kM9/7mWclsTs3lq0gOBY1sa9MIculRNdv/OKz4AUKHGo4Q9zrkI5o2l9uI/lJBm46k2VEtGx/ffT7LX7hQhffTRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781545209; c=relaxed/simple;
	bh=UEv2xi9E4osyscth+jwpIVLKR1VUQD3qe/6fAIiNmqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VESYG9i4QtwPihohnvXdCQvRBVPb+P5fezYTFtl6/ajQVGnJC1BTaCLX5c3ih2lYA0vd4OaPRhmsZn+ORf1RF1aAG3dMBgLovE2iNEqNUiiYOIxKKnjP36uRt0kk7awif/GlFdtcu6POZPxXd+7iPYna6jNqp3GUCfmQaVgsqsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPYwndpq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPYwndpq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44DB1F000E9;
	Mon, 15 Jun 2026 17:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781545207;
	bh=UF9tuXD0qQaVlmKMJ+WYam5R3vjuOlAQ9UZzDWobYyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VPYwndpqwNN8bVPja/h+B9Vf6gpt3GVs6I/fVvL/+ckkt+gB//E57E0DsUn708zTt
	 HzUiL6voPzDQNIZ5HmrdrnkN6JYacJBuzLGzfAFf2baCp8ljwNjPsc9vHs1f+Gv/6V
	 RKmYtBqw9QWyu0YCASzUw1tns01qvI5ADQiAriCjNYIo4D14+K3o5XBpsqtvnhZ4Gw
	 ryZ//Gcu/qbAYE/Ap7crhK2/2P//K+C61Xruvhagv7Ff9eGTAouFeDxHfCvqNKnu7P
	 smm4WtN+GsbxRCPHvYRunBUkH17kNyHygTg7tfo/80ZiQDgDxnY42fyq8clkLvW9ei
	 W2wwObVUUMczg==
Date: Mon, 15 Jun 2026 07:40:06 -1000
From: Tejun Heo <tj@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Will Deacon <will@kernel.org>, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	bpf@vger.kernel.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] mm: Add ptep_try_set() for lockless empty-slot
 installs
Message-ID: <ajA49jgCaMo_3KdB@slm.duckdns.org>
References: <20260522172219.1423324-1-tj@kernel.org>
 <20260522172219.1423324-2-tj@kernel.org>
 <ai50IpfcvBiTZ7Ss@willie-the-truck>
 <ai8PO0NThJeuQYzy@slm.duckdns.org>
 <f6e87467-2fa1-4edc-a739-9899be36196c@kernel.org>
 <31d1ac68dc230564301fc1e7dc748a1d@kernel.org>
 <79338662-e637-412b-84b4-71cef3883b3d@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79338662-e637-412b-84b4-71cef3883b3d@kernel.org>

Hello,

On Mon, Jun 15, 2026 at 07:36:19PM +0200, David Hildenbrand (Arm) wrote:
> On 6/15/26 18:27, Tejun Heo wrote:
> > Hello, David.
> > 
> >> Is BPF maybe picking up patches from other subsystems up too early
> >> without waiting for acks?
> > 
> > Do you mean the comment cleanup I just sent, or the original
> > ptep_try_set() merge?
> 
> I am talking about any patch that touches arch code without an ACK from the
> maintainer.
> 
> Maybe arm64 and x86 people are fine with that, but I heard other voices
> recently, thus my question.

I see. I don't know the dynamics here. I'll leave it for bpf folks.

Thanks.

-- 
tejun

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1BF277026;
	Wed, 25 Feb 2026 17:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772041686; cv=none; b=eyhI1DSbsCfMDte37ad8EIV7QUUWCSINaKyYs7yzIg+Z5xK10BuZ83KxqCTVKwbspfFKUnO1d3jU6ePW7VKtpxvRIAst1OxUpHTBUxeg1h9ymE3OMY2b23NWEkjy6qDA/dnu+v5QP64E5tr7YaCsNSXsTd/v/Vcgm0gVR45VQW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772041686; c=relaxed/simple;
	bh=1wbsQFL10vOCjR7gd2xx+GAzVqi7WDR9yfFR1BBQ+h4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGwYtIBxBEfhsJfBWuqjt3wLIRAoyIT3aM+TqqzWaub51H0dYxpcsGFj1p3wRB13NQY6XzMyJ9crhWaCVoBrCHG1HqcJ8pq6TApuMlu1xZzRCWhyR+bKwqIXn1HJcokHnHnpma+t33EurC6GVHBY6g3J7Xkq0ii4rI7a8FJiP38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okNZO/Vm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okNZO/Vm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C02C116D0;
	Wed, 25 Feb 2026 17:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772041686;
	bh=1wbsQFL10vOCjR7gd2xx+GAzVqi7WDR9yfFR1BBQ+h4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=okNZO/VmEPZrkpD8nxT5vi5jfjeRj5DqbaJDxE0MZa3Ty8btR8ITaF0lFsj5NHZH3
	 W1Mb26a9tgAPYGogKr0vqRovRgjSI6B+lWynyYBYEVB052fds3CCy3q04P0Fohpdn6
	 ozPmmrGkjjIlKUVgRvzXmybOSctAe4jCtENkmXGZRAXLTcTBt3cm9YqQu3Rlma1LAn
	 x2BV9t5iVLDMyyw1KRZ6q41x9YcxJzYXJFoquhYDnoWTQfCeq7Fzngjwo3s0wDHOtf
	 l5e9I5aGD6FH8FAzi0e37d1ZqDb4E+l9u7CCTZXZIr9F9F0uY7yUsJ4SP6WYfg7IEQ
	 QsbOD4S3hsJ2Q==
Date: Wed, 25 Feb 2026 17:47:58 +0000
From: Will Deacon <will@kernel.org>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Fuad Tabba <tabba@google.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jean-Philippe Brucker <jpb@kernel.org>
Subject: Re: [PATCH] arm64: bpf: Fix UBSAN misaligned access in BPF JIT
Message-ID: <aZ81zpP6ooG_19cI@willie-the-truck>
References: <20260224093128.1926610-1-tabba@google.com>
 <c402e95a-26d3-47eb-8249-52ece97989d3@huaweicloud.com>
 <CA+EHjTyXWqnr4Cu_cZyxDCVNCxto9pJN0WS18S_ri824oQhwug@mail.gmail.com>
 <2d0c6893-d4a5-42bc-a480-55bc669da130@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d0c6893-d4a5-42bc-a480-55bc669da130@huaweicloud.com>

On Wed, Feb 25, 2026 at 05:46:52PM +0800, Xu Kuohai wrote:
> Interesting, I think the plt target should be 64-bit aligned to ensure
> atomic reading on arm64. It can be updated concurrently by WRITE_ONCE
> in the bpf_arch_text_poke function while the ldr instruction in the plt is
> executed. If it is not aligned correctly, the ldr may read a half-old
> half-new value, causing the plt to jump to an invalid destination.

Thanks for pointing that out; I hadn't realised that we patched live
PLTs!

> To avoid over-aligning the entire buffer, how about fixing the padding
> method in build_plt to just make the plt target aligned correctly?

Makes sense to me.

Will

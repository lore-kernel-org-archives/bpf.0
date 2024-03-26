Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2B53C26
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 21:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711489912; cv=none; b=thfocc+gJQfukN4kPePQnyzxZOiOY6C+n8Y9IKfoYud7mHHwzNiz+tbYVc8T1lfrGiNVjWMd0PWWi1wF/E1+acVbzVBwqaujBs9lCRwv5MFGNglSFSkqovN6+pIeFo8NZ5m3pGjer1VNCLluMg9vFJnCLiIs5oOokP6PMyjV4HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711489912; c=relaxed/simple;
	bh=vYxmHLyzfgtwnYesg1Ae5G7k1t36YsDNaDLGLfhJRh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iPGtUmJlajMSaeusW81Nrav/JiACGQ6fPrXk+cdBLZYwmIAgbUYwyHvMVlqEx8E3JbKLIHSxJ2j00L/Tk/WMflfgDbfZhTXwwN2DBfasqH+0WZUV9zQq5/CiYj+Pj+8iiUkR4NWBg9lwRn43iqp0rE01/h2RMITxN/07pFtT5mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fKwhpSej; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fKwhpSej"
Message-ID: <4e5e51fb-b36e-4dae-b4b4-32ab5e05f303@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711489907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6k2u73YWr6uRihPOmodZIT3QRs4S+EKNrKvoI6HO22U=;
	b=fKwhpSejIsW52GDmecKgU36vV9Xc94+/+ArHT2XYaxqBncCKZ+kme8eC3gqJeF8HkPsSjs
	lp/3k2V6manen8+N3oG/in6Bj7SRYg1RPkd713zSHrL9SjgnT1su/E1PLXkdnzfoapo8Kq
	hnJKj61yiQRk2FLL72+o3L3KjLqmNJc=
Date: Tue, 26 Mar 2024 14:51:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 2/3] selftests/bpf: Add BPF_FIB_LOOKUP_MARK
 tests
Content-Language: en-US
To: Anton Protopopov <aspsk@isovalent.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
 Rumen Telbizov <rumen.telbizov@menlosecurity.com>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
References: <20240326101742.17421-1-aspsk@isovalent.com>
 <20240326101742.17421-3-aspsk@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240326101742.17421-3-aspsk@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/26/24 3:17 AM, Anton Protopopov wrote:
> +	{ .desc = "IPv4 policy routing, mark points to a policy, but no flag",
> +	  .daddr = IPV4_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
> +	  .expected_dst = IPV4_GW1,
> +	  .lookup_flags = BPF_FIB_LOOKUP_SKIP_NEIGH,
> +	  .mark = MARK, },

[ ... ]

> +	{ .desc = "IPv6 policy routing, mark points to a policy, but no flag",
> +	  .daddr = IPV6_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
> +	  .expected_dst = IPV6_GW1,
> +	  .lookup_flags = BPF_FIB_LOOKUP_SKIP_NEIGH,
> +	  .mark = MARK, },
>   };

[ ... ]

> @@ -159,6 +221,9 @@ static int set_lookup_params(struct bpf_fib_lookup *params, const struct fib_loo
>   	params->ifindex = ifindex;
>   	params->tbid = test->tbid;
>   
> +	if (test->lookup_flags & BPF_FIB_LOOKUP_MARK)

Removed this "& BPF_FIB_LOOKUP_MARK" test. Always set the params->mark 
regardless of test->lookup_flags. This should be the intention of the above "... 
mark points to a policy, but no flag" tests.

Applied. Thanks.

> +		params->mark = test->mark;
> +


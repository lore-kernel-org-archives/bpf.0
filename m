Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB7D331222;
	Thu, 25 Jun 2026 19:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782417104; cv=none; b=n+C1n5rpJMKLDXSoUsX6VkYP9lzZMffxwi2iNzoeACvnRvTHBLl0LRqe3m2QFTM1dyrFAm3cUJhjN2vXeYDYoRvlrQPm6BxFaDxIdinvonSus3soPlpSb0nWphy07bXV02YghlJ1nStwSn+slHnF8FYHqaEZhMsr05H+x36iaxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782417104; c=relaxed/simple;
	bh=ZMbRWDGYT2cMePAsL7p6001j/gyCaAcSvb+BhxpAgHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W3rzp4LsaUaq78SmN11ey5Z+RfAjDyr4nfaLBfEuYocYAP4CiEuWA2XvzUIrW+3RzbsqZRYMGMUO+lBCor8kiU86Q+owAXz9zWKeeACcMPBURm5vCn0wjgPzuKdMRaYNVQtlp31EPqe9CHucrEDQZOD/qLwnN/7w3UgM5WFCQeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGuCmW3D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGuCmW3D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02BE1F000E9;
	Thu, 25 Jun 2026 19:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782417102;
	bh=NVuojCEUe0/K2hHnFIrBmEZ2b/x4ky5BQMjFmpLmFuI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fGuCmW3DsN0FWyW9BonBzgkdavVrvHUrJDWTaoAc/yyIkYvQljDnrLgSNBSp/TrKk
	 p+2chAs7RvalD+HQ+Yc5/zot2qAPMx4VaWlRJYUMMmkLyqLxwwkOALyt5HzagS58Bh
	 0ayHCvTPTSahDVD9lzCFij0JgXeZ3MbQNKVLKo05btntGQifLAqmLd8yUPg/0G3/d0
	 g1RAqI9jKUdW4UoJpuEw60e/f2GeCQ3dmPairHGrdHG1JerqXZ8ET89XyXzH6iWY+B
	 1y2QW+YI4V2pRFpEvRWiiXhsXmr6M0BP4ln70/MD2r4bw2rjCxEXz3wyeVE9yCug5J
	 dz2zupudaEuNw==
Message-ID: <bcc3414e-f3c4-40c1-b9e4-f864bd875a2a@kernel.org>
Date: Thu, 25 Jun 2026 13:51:40 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/4] bpf: Initialize the l3mdev field for the
 fib lookup flow
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Avinash Duduskar <avinash.duduskar@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Mykyta Yatsenko
 <yatsenko@meta.com>, Leon Hwang <leon.hwang@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Anton Protopopov <a.s.protopopov@gmail.com>,
 Amery Hung <ameryhung@gmail.com>, Eyal Birger <eyal.birger@gmail.com>,
 Rong Tao <rongtao@cestc.cn>, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260616223426.3568080-1-avinash.duduskar@gmail.com>
 <20260616223426.3568080-2-avinash.duduskar@gmail.com>
 <87bjd9h6yh.fsf@toke.dk>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <87bjd9h6yh.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/17/26 3:06 AM, Toke Høiland-Jørgensen wrote:
>> The helper already initializes the other flow fields the rules path
>> consumes (flowi4_mark, flowi4_tun_key.tun_id, flowi4_uid and the v6
>> counterparts); flowi*_l3mdev was added to that set afterwards and this
>> helper was never updated to match. ip_route_input_slow() likewise zeroes
>> the field before its input lookup. Do the same here.
> 
> So how about we explicitly zero-init the whole struct instead of adding
> more fields ad-hoc like this? Otherwise this seems like something that
> is likely to happen again if we ever add another field to the struct?
> 
> -Toke
> 

+1. Piecemeal init of the flow struct has been a known source of bugs.

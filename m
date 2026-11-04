Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793772363;
	b=ZGKGpo5MH9ownIv2wWYIOPq0D4vYtZ6AHhErOnBrtnpw9lKHtJ1R6ZyCSo5f32w8vob6
	 pfAHWN09Waz2c48opjK66mLTD96RmvV4h5M3EdlXNBHQfYU8qzsNAqVYicSYPtFe0EN4A
	 6i5hDfqjskSd+xE4QnpMXkIpB1BeedSddpAcZFmr1YuuVVu7Bfhn9/eySNPk6GE0iDiH9
	 MWlRpvMP+tt42a3wk2ZZLQYZzuTqlyYDY83BMYeSrj+LRW08/oB0D7f3vWIa6+oiGAjoe
	 dIPIg0ow3Asphp7hD39eBQmzhwC48EuJjPmstP/FZIRflLUmSB0ledWj37Hglf00rxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793772363;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=AYliQvvoP9t2xBU+MfGX2zhe1ZgquUqopej93F/CQ4Q=;
	b=h6ngXKNxG6FNnK3ibHYRzgVHF8uVz5nYlW9pN8n8DbkVzNg/3wqsve4xvRJXhNRIuSMY
	 pgtiEIm90M5EtJBMbhmyD1uMbnHyKQJA5/s+CdwKfvjj1cvTi43jYn/79k33wemkQXRXT
	 o4D/iI+k4rvQ4joXA3lm2O69QdongVr1OEFekKRt7jcmLKCiLI/t7JHIcOb/RKRtPYT02
	 aNgx81Oi7S037La90rGV38G/psM1xJXKs4AFUCVQdSu/HhV5NQoBoLDoAlcw6rPPEXcWF
	 Gh4wnXQh3jgz9rlVzs1QbdhOtpUL2aXTLtURjOzZNwt6gPDY6GYtvPv3BIq4pliu7xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tG0OTtk0;
	arc=none smtp.remote-ip=91.218.175.56
Received: from mta0.migadu.com (out-56.mta0.migadu.com [91.218.175.56])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC53606A329
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 06:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDC53606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tG0OTtk0
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=AYliQvvoP9t2xBU+MfGX2zhe1ZgquUqopej93F/CQ4Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793772354; v=1; x=1794377154;
 b=tG0OTtk0f8ZcYcb+ozibhuTIE8MGWeWV43lqRPVcurrDR1RPMyw+7dPAjB2cpk+w+/sPh3WS
 H+cFhr11CppQ5DHLndMniEipQaOax5wvG23fFvUUerj5ERLXqGc+CrFbyriCPuNDOwogw40Z5mT
 Yx1TxtPR9oycfNTCLEH74xAA=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ba0b2edfcf9ab841;
	Wed, 04 Nov 2026 06:05:54 +0000
X-Mizu-Trace-ID: ba0b2edfcf9ab841
X-Migadu-Flow: FLOW_OUT
Message-ID: <b0e5f200-1860-4222-afc3-8d67161ea1c1@linux.dev>
Date: Wed, 4 Nov 2026 14:05:38 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 5/7] ipv4: convert do_ip_getsockopt() to
 sockopt_t
To: Breno Leitao <leitao@debian.org>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
 Eric Dumazet <edumazet@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 david.laight.linux@gmail.com, kernel-team@meta.com
References: <20261103-sockopt_expand_out_v2-v4-0-2d36da923578@debian.org>
 <20261103-sockopt_expand_out_v2-v4-5-2d36da923578@debian.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261103-sockopt_expand_out_v2-v4-5-2d36da923578@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/3/26 7:01 PM, Breno Leitao wrote:
> Convert the SOL_IP switch and ip_mroute_getsockopt() to sockopt_t, its
> last leaf on a sockptr_t pair. The IP_MSFILTER and MCAST_MSFILTER
> bridges go away.
>
> ip_getsockopt() builds the sockopt_t with sockopt_init_user() and
> writes optlen back unconditionally, because IP_OPTIONS and others
> report a length and can then fail. ip_mc_msfget() therefore stores its
> length only after its last copy, so a copy failure can't report a
> changed one.
>
> The write-back also happens before the netfilter fallback, so an
> unwritable optlen turns any error into -EFAULT and skips the fallback.
> Likewise optlen is now read before the level check and the MRT_*
> dispatch, so an unreadable or negative one wins over -EOPNOTSUPP.
>
> IP_OPTIONS with no options set and IP_PKTOPTIONS used to return the
> result of copy_to_sockptr(), the number of bytes not copied, so an
> unwritable optlen made getsockopt() return 4. They now return -EFAULT.
>
> sol_ip_sockopt() builds the sockopt_t with sockptr_to_sockopt() and
> stores optlen back as well. This extra code will go away when we
> convert sol_ip_sockopt() to talk sockopt as well, but for now we are
> converting the leaves.
>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Acked-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


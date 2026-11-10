Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316223;
	b=QV0ivJFfohcn0uRzoDksTa8dh4CwGGZahWPfQxNJjQJ3mRmF5zIsnZhOwwIlYDCvGAiC
	 C/O/HwEdYk5gizViU4ykZAkvK05QhQPHCFwxTIIm6IVNgyn66zFLtLwAgXdG+ph7rZZ5g
	 OQhLa1OgfFazKdCFLrNxnG7/xn2GrTcsU+cNdeLntHR88nUdEXtQarLWUWZFVaOQjVcUW
	 1KWfFVyfLceBYiD8Dq74pDVQ0Zux6OrWxV3vcBKtwGfNrnLHn04611RyaBaBXeCij+jV8
	 K4zGQAjaqnL7CyXJTpjJ2e+FK8Kkcz3yM4HkFi1ul3VjjTZ7B8STDFprqvsJCsWEBQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316223;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=6syMrSNRwGS6gjty+GgbOX5gHZbIzGMr07iLqxjqTOM=;
	b=IoHLZyIWxedX+8o2tnPAUpYpXL5lIXrD4efKev3DlFeoeO4DLXI1kG6MCM6V7hQ1bO+T
	 mAr81mfS7VYUemoksMntC5wvcoeTHvmEUZeEzODKHVYmeU+YeJHffEvA45ydigRVoaGIO
	 okGACI4vsB2fvEdQJ+CYwKfxaYHIWuii+wwr7ZKd7+kEXGQwCq2aFdmuzbklgtoU5J3TK
	 PdKs3l0PARlj+LAGhugnsxeCcFikbr66Zv8d0rbmRWgiUyJ1eYuVMEvkj6ZUOuMD2I9hK
	 Z+qHNge2426PidKmUVxpWiZqN2lBtdb4Q2mJzUBN5gBbWCmuM1O2i9SEdeoWxGq8Jiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oBT3jv+7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F00606A766;
	Tue, 10 Nov 2026 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oBT3jv+7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF0C1F0089F;
	Tue, 10 Nov 2026 13:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316223;
	bh=6syMrSNRwGS6gjty+GgbOX5gHZbIzGMr07iLqxjqTOM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=oBT3jv+7Uh8iNm1FkZPAz5lvI4+ePpC8H2PhjSKqdjsT2nXrnihcgVY5/fNRN/qkP
	 PdQe2p3NY1cjTf29GoUX5f7gXFwiXll+SNZDvqELr1jmfdnX9EgZsxiU79wdVAP/Nw
	 3jsIJyYX4kr20uaqGlla6FYKC7LjFoyvU8yp3KTayEwQ/iknj4SpxJ9iibIkz9ZyGt
	 24p2Kw4EZdFVhp4PGWqi25qvMUPoqlC6bNVjtS/MDaimyf7Al3GLinl8D2cYDKkrI/
	 i12mODcI/Nlo4fa7mHti/iQ3zd0OZv8KCdMu0JiFvJYTsRGST2GQEGUseIznQD5kJk
	 3vpkAAMH/xgPg==
Message-ID: <cec4e2cc-9544-4146-9c49-92e5cff7d670@kernel.org>
Date: Tue, 10 Nov 2026 14:10:13 +0100
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
Subject: Re: [PATCH bpf-next 01/15] xdp: reserve an skb core extension area
 after the xdp_frame
To: Tianyi Gao <tianyi@cloudflare.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Jakub Kicinski <kuba@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Vladimir Vdovin <deliran@verdict.gg>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Donald Hunter
 <donald.hunter@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Tushar Vyavahare <tushar.vyavahare@intel.com>,
 Jason Xing <kerneljasonxing@gmail.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Madalin Bucur <madalin.bucur@nxp.com>, Ioana Ciornei
 <ioana.ciornei@nxp.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Chris J Arges <carges@cloudflare.com>, Jakub Sitnicki
 <jakub@cloudflare.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 llvm@lists.linux.dev, kernel-team@cloudflare.com
References: <cover.1794281983.git.tianyi@cloudflare.com>
 <115997f55d63b507ce54fbe9e22900b59016f3c3.1794281983.git.tianyi@cloudflare.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <115997f55d63b507ce54fbe9e22900b59016f3c3.1794281983.git.tianyi@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/10/26 04:56, Tianyi Gao wrote:
> Reserve the skb core extension area in the headroom, right after the
> xdp_frame. An XDP program stores RX metadata there for the skb that is
> built later.
> 
> The area begins with a header, struct xdp_skb_ext. It records the offset
> of each entry and the end of the last entry, in 4-byte units.
> bpf_xdp_adjust_head(), bpf_xdp_adjust_meta() and bpf_xdp_pull_data() use
> xdp_skb_ext_end() as their lower bound, so packet data and metadata
> cannot overwrite the entries.
> 
> The XDP_FLAGS_HAS_SKB_EXT flag indicates that the header is valid. Most
> drivers reuse the xdp_buff between packets, so xdp_prepare_buff() clears
> it. With BPF_F_TEST_XDP_LIVE_FRAMES, reset_ctx() restores the flags
> before each run, and ctx_was_changed() compares them.
> 
> Suggested-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Link: https://lore.kernel.org/all/1d5521eb-84fc-4417-a3f5-6366694d160a@kernel.org/
> Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
> ---
>   include/net/xdp.h  | 45 +++++++++++++++++++++++++++++++++++++++++++++
>   net/bpf/test_run.c |  4 +++-
>   net/core/filter.c  |  8 +++-----
>   3 files changed, 51 insertions(+), 6 deletions(-)
> 
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 07231adfb5f8..c888353425d4 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -81,6 +81,9 @@ enum xdp_buff_flags {
>   	 * XDP program is not attached.
>   	 */
>   	XDP_FLAGS_FRAGS_UNREADABLE	= BIT(2),
> +	XDP_FLAGS_HAS_SKB_EXT		= BIT(3), /* skb core extension header
> +						   * is valid
> +						   */

This can be on 1-line (80 chars) of you change the comment to be:
  /* skb core ext hdr valid */

>   };
The rest looks good to me.

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

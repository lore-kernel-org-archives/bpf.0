Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cA0RNA2Z"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b0])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8518A6
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 16:02:35 -0800 (PST)
Message-ID: <36f7f017-ecea-4715-b352-2ce1d43c8cab@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702512152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EbVFFpEobNWdQHXshAr/NMnhj/JmFbUe7fxCcbtimqw=;
	b=cA0RNA2Z0fVci/KCO4mQrO1kuZeN227KjjcalKGlaFuP6Q7OtkgC84U5QIPZ62pAGEfrpn
	WsVCZ8w1W5GPcbsfaM8crkIGVqUqL6CHHyoHKWNPyw305OivKS/vsLartz/KVm/s2EhCzJ
	NwR/ksXxWS6wWuouH3Yh09btLF+oLEE=
Date: Wed, 13 Dec 2023 16:02:24 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 1/9] bpf: xfrm: Add bpf_xdp_get_xfrm_state()
 kfunc
Content-Language: en-US
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, devel@linux-ipsec.org, daniel@iogearbox.net,
 davem@davemloft.net, edumazet@google.com,
 Herbert Xu <herbert@gondor.apana.org.au>, ast@kernel.org,
 john.fastabend@gmail.com, kuba@kernel.org, steffen.klassert@secunet.com,
 pabeni@redhat.com, hawk@kernel.org, antony.antony@secunet.com,
 alexei.starovoitov@gmail.com, yonghong.song@linux.dev, eddyz87@gmail.com,
 eyal.birger@gmail.com
References: <cover.1702325874.git.dxu@dxuuu.xyz>
 <e8029421b1a0d045fadb214ba919cc25efab4952.1702325874.git.dxu@dxuuu.xyz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <e8029421b1a0d045fadb214ba919cc25efab4952.1702325874.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/11/23 12:20 PM, Daniel Xu wrote:
> +/* bpf_xfrm_state_opts - Options for XFRM state lookup helpers
> + *
> + * Members:
> + * @error      - Out parameter, set for any errors encountered
> + *		 Values:
> + *		   -EINVAL - netns_id is less than -1
> + *		   -EINVAL - opts__sz isn't BPF_XFRM_STATE_OPTS_SZ
> + *		   -ENONET - No network namespace found for netns_id
> + * @netns_id	- Specify the network namespace for lookup
> + *		 Values:
> + *		   BPF_F_CURRENT_NETNS (-1)
> + *		     Use namespace associated with ctx
> + *		   [0, S32_MAX]
> + *		     Network Namespace ID
> + * @mark	- XFRM mark to match on
> + * @daddr	- Destination address to match on
> + * @spi		- Security parameter index to match on
> + * @proto	- L3 protocol to match on
> + * @family	- L3 protocol family to match on
> + */
> +struct bpf_xfrm_state_opts {
> +	s32 error;
> +	s32 netns_id;
> +	u32 mark;
> +	xfrm_address_t daddr;
> +	__be32 spi;
> +	u8 proto;
> +	u16 family;
> +};
> +
> +enum {
> +	BPF_XFRM_STATE_OPTS_SZ = sizeof(struct bpf_xfrm_state_opts),

The bpf prog can use the bpf_core_type_size() to figure out the size also.

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.60.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794474384;
	b=xuRfbvoOeIk9OyAyFZCEOMxPlEYE3S8RnmHJCgzMbYG8STlVgchYp+kP8P2f+lDBKJFi
	 0PZlasAaEqTjCuD6WxDSpv+ckUkbf0Y3V3gH5LheSGxibiNRv3q4jgaLkWaMQ8T9ys6hA
	 4t8T/4f1oYIRp1kMiTG4y8p6a1ft2n9e0PmtpTOenm1LL091h9v2pEOeOWO5SEyg0RcBf
	 dXa82/no/ByePKuy3ugkNAFpU4be7KoQSPCL6xhG6jtQG+dzvlsheXsLaFK9KIKZH3Zsb
	 90Ez5xD/yS1nqilUYgB2/74EYQ2UW5EaalJQmkspma79wUODHzKGYv6p7+L1xSlcSJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474384;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=pZfLhLAZRarfjos4mDzX4e9ICCBeIlr8PK7cvQkamjI=;
	b=P+Qe3ZTnNa+nbbZ4HtPS3ubfkwYl2V56sJ5WYMtsow+d48hzcIIbOy1NtTm3Dc7eht+c
	 OaYXnumls2Qc3fC0KJhG3VnWYrdIz28DBltDyYQ7eJaRbdIgsQ9EfNveT/myjlPMT9o2s
	 3IJryUBF/nzk+r2yhOjJAVpTaceFuAw6lmAKkbVwIP9ObULesRbArDu133xgF1IyFkDo5
	 d1iDH/tylKN29RedKywjO53cowSmruM2nUs1XpZIhm4h+DxzCp93Rx5JJ7ziGlnHXhGfG
	 rNzjRE5AUGaAXSrt6XR+O0NUXCF5gib4hOAvIlOCtQN9g589777IULags3zFSsdH+UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=corp.free.fr;
	spf=pass smtp.mailfrom=corp.free.fr;
	dkim=pass header.d=corp.free.fr header.i=@corp.free.fr header.a=rsa-sha256 header.s=rcs header.b=cJ2adch3;
	arc=none smtp.remote-ip=212.27.60.169
Received: from rcs.proxad.net (rcs.proxad.net [212.27.60.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045DA606A330;
	Thu, 12 Nov 2026 09:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 045DA606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=corp.free.fr header.i=@corp.free.fr header.a=rsa-sha256 header.s=rcs header.b=cJ2adch3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=corp.free.fr; s=rcs;
	t=1794474374; bh=R5jgklfvYhY7a5tUlqxzaIMMvev7gNDRqMQWJEoks48=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cJ2adch3iUxAPhG+h3sK2gbExjP0NxOI63iZlJOaCbh/etVIfPJbFzJynS+ZOnPUQ
	 khdpRNLJiMlfdjWfTmdJi8I9y1U2vP6hiSD1x8iY1n9/01fENlbUn3hCulr0pICXP1
	 YF3QqVY57+r53VQ6S8L6NQEWwNVI9kWEnIlD21QCSUbeKzOf8ZnTuX8gOlnsx3drLr
	 9mjm3TpBMLQXhilvEmAoUPvGXGcfnZSDPh0noxLka9mZGPc1f8lqWLhMCb0ROHXefw
	 hq2BPA6G+3JDK0RuhrGhtEeWn3Ko+hWSLBpcKvysoz4kH3H7f0dPyQZAX/f+7ZyGEq
	 ctq5liz7sVIzg==
Received: from [0.0.0.0] (unknown [213.228.1.188])
	by rcs.proxad.net (Postfix) with ESMTPSA id 4BE4E44C2D6C;
	Thu, 12 Nov 2026 10:06:13 +0100 (CET)
Message-ID: <2ab2071d-776f-4dc0-838e-22b907d5a601@corp.free.fr>
Date: Thu, 12 Nov 2026 10:06:12 +0100
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
Subject: Re: [PATCH net-next v3 2/4] net/sched: honor
 TCA_ACT_FLAGS_NO_PERCPU_STATS in bpf, ife and skbmod
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Ido Schimmel <idosch@nvidia.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20261109124618.933149-1-acassen@corp.free.fr>
 <20261109124618.933149-3-acassen@corp.free.fr>
 <20261111172238.506fb9ce@kernel.org>
Content-Language: en-US
From: Alexandre Cassen <acassen@corp.free.fr>
In-Reply-To: <20261111172238.506fb9ce@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/12/26 02:22, Jakub Kicinski wrote:
> On Mon,  9 Nov 2026 13:46:13 +0100 Alexandre Cassen wrote:
>> -		ret = tcf_idr_create(tn, index, est, act,
>> -				     &act_bpf_ops, bind, true, flags);
>> +		ret = tcf_idr_create_from_flags(tn, index, est, act,
>> +						&act_bpf_ops, bind, flags);
> 
> Now that we modified all actions could you take a look at removing
> the unnecessary API variants? tcf_idr_create() has one remaining
> caller AFAICT, so we can probably rename tcf_idr_create_from_flags()
> back to tcf_idr_create() and make using flags the default?

ack, will have a look over the week-end (and try to respond to the 
sashiko boy on previous mlx5 patchset for tunnel key partitioning)

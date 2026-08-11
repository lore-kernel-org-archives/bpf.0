Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C5929D26E
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 03:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786417629; cv=none; b=Fm6zVtylpWmNkixT570xmhhBwX6TBcadaM0NVSS5x9Nh6GsWESxNDMPLIRvOhZxCe/4I66DMd0cwHLSA9JgTKjDBwmhJfgeuTyx6+XfgTYTv/EUXbEPsJ7HM+9Gkt/XYGirrj1SR7SE29eEiTUO0f7kkgnsDC3Xc0H8GfT3qzzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786417629; c=relaxed/simple;
	bh=peAroulPtJaexc5hKhN2jNo93rCe+JG7nBbh3dZWWwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mKQqWFcOUO8qKgpq5y1Eeo2FpkMEmYryunEmiCkfZ2TjhF7RvFWlRN+KQBmX3GF0nBVa0JsbDJJTluCT9r5Wcq6hMY1DXLtaweFNpTbUtLiDaEsCdlDE65nWSAiOVk9LHwkzY1BWIxvydLpjJNTqFePDFsenur9ivtdcY8xOG+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gm0h2MX0; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gm0h2MX0"
Message-ID: <cf8655ff-4e45-40ab-898e-aff2aa7145c5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786417625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ICr7w3qFPm3tjfGQauGXsymoV8+BoD7qeMU/1f4tyuY=;
	b=Gm0h2MX0bTaQxsyYEeUxNYuxxqoxL4H+dRYlftuFAHXIaAmqpTZzaa+fUXeEJ36kWV1Q8P
	Kg0G/OFZET27j4WJSJ8Fu4yCYLXhT2u27j6vsRobWuIKYonNkt3iN5S0R0jyvvlGaHdS5I
	semo5hEG2qDKIuyx3OZT3yT5mvo5VAM=
Date: Tue, 11 Aug 2026 11:06:34 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/3] bpf, xdp: move offload check into
 dev_xdp_install()
To: Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Hangbin Liu <liuhangbin@gmail.com>,
 Krishna Kumar <krikku@gmail.com>, Samiullah Khawaja <skhawaja@google.com>,
 Martin Karsten <mkarsten@uwaterloo.ca>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260810050621.82035-1-jiayuan.chen@linux.dev>
 <20260810050621.82035-3-jiayuan.chen@linux.dev>
 <20260810114958.64e6a83d@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260810114958.64e6a83d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 8/11/26 2:49 AM, Jakub Kicinski wrote:
> On Mon, 10 Aug 2026 13:06:00 +0800 Jiayuan Chen wrote:
>> bpf_xdp_link_update() calls dev_xdp_install() directly and skips
>> dev_xdp_attach(), so the checks in dev_xdp_attach() do not run. A user can
>> make an XDP link with a normal program and then swap in an offloaded or
>> device-bound program with BPF_LINK_UPDATE, which puts it on the software
>> path.
>>
>> Move the three program checks (offloaded, bound to another device, and
>> device-bound in generic mode) from dev_xdp_attach() into
>> dev_xdp_install(), so both the attach path and the link update path are
>> covered.
> Shouldn't we move all the checks that are not explicitly about the
> netlink API (so all but the first?)

Sounds great, the code would be much cleaner.


>
> It may be better to split the series and send this patch to net,
> the netdev CI has a netdevsim test for the prog offload, would be
> good to run that.


Though for now bpf_xdp_link_update() already does:

     if (old_prog->type != new_prog->type ||
         old_prog->expected_attach_type != new_prog->expected_attach_type) {
         err = -EINVAL;
         goto out_unlock;
     }

so the other checks can't be triggered on the update path even without 
them in dev_xdp_install().


So I'm thinking this patch works as a standalone fix (good for 
backport), and the cleanup goes as a followup (if necessary)?


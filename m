Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B8815AAA9
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 17:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712080637; cv=none; b=ZbhoeT9R4n+Nub9Nv9fLyq+o3WBquD5PfbzY/YYjL9BX/uJUo8zzG1HPmn13uv61vemLDl9QCeEwpD2smt1jLzF/bbiFp6sj+xqUxpBDNXHt4uA6wT6jh6XM4wd0yv/9tRzpGRGiwsoX0nnBbPgyfi6nqOS+vAbfe1d3H+RkaOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712080637; c=relaxed/simple;
	bh=yFcRLLpyOQW1rnm9mlDf1com3xrZssWLL1rJMfWcsxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CJUrRQXUD5FDfSj8XVkwCafRYeZAnD+99a0oO/WSMfLqV+bVKrjbzf4CIOLBpjrQEL5b3BhgfTFuNbCTmI5qKJPkhXNkXKfvwuggAWQzTCdjiSLNyCSeE385aHmnevkMd9KL5UWDWScijYXP0kDWvGWaTOaLK4zTHZgWbzuxy5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o8hcIydY; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o8hcIydY"
Message-ID: <007e30b4-31aa-41b0-9e19-f7e2a385773e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712080631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dTFgycdum/jOkWMjvVMiQFk5BSU3+QvQG08R75DKkSc=;
	b=o8hcIydYcKPWTI3wHafVq0PR2HRKIHivdinqEiKzhcEiZ20J6uwgaDHXz/dFa3NWqlvSFx
	W8ZjHlGxlMLVboe9fvKZOIbWffSTdhNF+gs7Et+2Q9selSFcTLw2oxHxVuZXUDiQFG9a4g
	piu68YyFNlraNG5gLj/D0/znp+UX7xs=
Date: Tue, 2 Apr 2024 10:57:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 1/8] selftests/bpf: Introduce
 sock_addr_testmod
Content-Language: en-US
To: Jordan Rife <jrife@google.com>
Cc: linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Daan De Meyer <daan.j.demeyer@gmail.com>, bpf@vger.kernel.org
References: <20240329191907.1808635-1-jrife@google.com>
 <20240329191907.1808635-2-jrife@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240329191907.1808635-2-jrife@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/29/24 12:18 PM, Jordan Rife wrote:
> +static int do_sock_op(int op, struct sockaddr *addr, int addrlen)

This function can be made as a new kfunc in bpf_testmod.c. The 
sock_create_kern() could be moved to here also. Take a look at the 
register_btf_kfunc_id_set() usage in bpf_testmod.c and how those registered 
kfunc(s) can be called by the bpf prog in progs/*.

If the do_kernel_{bind,connect,sendmsg} and the sock_create_kern need a 
sleepable context, it will need to mark the kfunc KF_SLEEPABLE. The kfunc can be 
registered to the BPF_PROG_TYPE_SYSCALL sleepable prog type. There are some 
examples in progs/kfunc_call_test.c and how the "syscall" bpf prog can be run by 
bpf_prog_test_run_opts().

The result (e.g. ensuring the addr and addrlen have not been changed) can be 
checked in the bpf prog itself. Then the new sock_addr_testmod is not needed.

> +{
> +	switch (op) {
> +	case BIND:
> +		return do_kernel_bind(addr, addrlen);
> +	case CONNECT:
> +		return do_kernel_connect(addr, addrlen);
> +	case SENDMSG:
> +		return do_kernel_sendmsg(addr, addrlen);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +


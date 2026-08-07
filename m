Received: from out-182.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94E144238E
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 09:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786093987; cv=none; b=ZxOE+9Nx7eFjjmslnOw494Z/kMp7gNuofIsJqNZtPPYj0fRVbUz3/zYvDo24Mddvl3KVC7Zcj1oB+ttS2DJnRY9594ro7jConFyc+lbXg46F/FHjRGjOWID0Wgd01PWAvOh8l1QXfEajBzEnrAEUdwS2Fdjvy6/zVG0xsdGh3RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786093987; c=relaxed/simple;
	bh=crII75xd+SdlUuxBA92ZDs3fjRIROp/o+7sjz3A6phg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EMnjY2rApPN31gk6soVf8p5+WRNVXi7f7200bCjjvw7v6psFDRFehCYJowZCH3wMZjdv/llY4JwQffkGGHqKjmxU0GN9y5EopQ7eg1XYg5i8Gpm1aap0DcL7/+79/uRvDEl0xB/u+BhwJns/S2uQqOrwwHIHOQJIlDkbPdtIWRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xKwwZSen; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xKwwZSen"
Message-ID: <c51bef73-17b0-430d-b473-7744141d6dab@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786093972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fnLj0Q0XyXsxquMKgTk+VBS3kxVOOHgc3yPVMUAr2/U=;
	b=xKwwZSenSEEHc8EKep/4Fjoi+oOHobDEfUgyw61WOYKD6/mCG6q9iA94x7G6EwFbzGVSxG
	mw8DfYPg+0CX9jAgjg90kbnTRnMtsUCsunn4IXtATtKDE0qytC615rtZM0NbkgjIWizne2
	rolalbV+epWmVmf2tKwUWyYolI8Y/no=
Date: Fri, 7 Aug 2026 17:12:21 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 3/5] selftests/bpf: Add ksock kfunc test
To: Mahe Tardy <mahe.tardy@gmail.com>, bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
 edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org,
 liamwisehart@meta.com, martin.lau@linux.dev, pabeni@redhat.com,
 song@kernel.org, netdev@vger.kernel.org, sdf.kernel@gmail.com,
 ameryhung@gmail.com, kuniyu@google.com, memxor@gmail.com
References: <20260806182234.380833-1-mahe.tardy@gmail.com>
 <20260806182234.380833-4-mahe.tardy@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260806182234.380833-4-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 8/7/26 2:22 AM, Mahe Tardy wrote:
> Add
[...]
> +
> +SEC("lsm.s/socket_bind")
> +int BPF_PROG(ksock_socket_bind, struct socket *sock, struct sockaddr *address,
> +	     int addrlen, int ret)
> +{
> +	struct __ksock_ctx_value *v;
> +	struct bpf_ksock *ks, *tmp;
> +	u32 pid = bpf_get_current_pid_tgid() >> 32;
> +
> +	if (ret || pid != target_pid)
> +		return ret;
> +
> +	v = ksock_ctx_value_lookup();
> +	if (!v) {
> +		send_ret = -ENOENT;
> +		return ret;
> +	}
> +
> +	ks = NULL;
> +	bpf_rcu_read_lock();
> +	tmp = v->ctx;
> +	if (tmp)
> +		ks = bpf_ksock_acquire(tmp);
> +	bpf_rcu_read_unlock();
> +
> +	if (!ks) {
> +		send_ret = -ENOENT;
> +		return ret;
> +	}
> +


Since bpf_ksock_send() is sleepable, every consumer of the kptr is
necessarily a sleepable program and thus has to open-code the same
bpf_rcu_read_lock()/acquire/unlock sequence before each send.

Given ksock_common.h already wraps the insert side, how about also
providing the get side, e.g.:

static inline struct bpf_ksock *ksock_ctx_get(void)
{
     struct __ksock_ctx_value *v = ksock_ctx_value_lookup();
     struct bpf_ksock *ks = NULL, *tmp;

     if (!v)
             return NULL;
     bpf_rcu_read_lock();
     tmp = v->ctx;
     if (tmp)
             ks = bpf_ksock_acquire(tmp);
     bpf_rcu_read_unlock();
     return ks;
}

These selftests will be the reference everyone copies from, so
encapsulating the RCU dance here also documents the correct usage.



Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2870D346E50
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 06:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781850969; cv=none; b=ElbAdAW6ys7/XopLtjyfHgM0FrHBCDBt39R1zn5BRNA3aS2OlCOZm4tB5jbECRDLLY6DndCHDrMisVSp5fGYE35pM/OQtyv0RQyIHUxR/w+0nzJSXnDTNvqXw/Bpljo8zCG06+H4KzjO/F0smo0yMqAUGBamsRaxCfLSWXuKAlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781850969; c=relaxed/simple;
	bh=rOArnfKPATJkYYumpandljz3xZTiXVcjL/j0XUj+YII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c0ATcB1R+XS5P3R3KtAnXKVc4+8zdqvsXwfBEUYX0TYnNX2EjEY+n77/2nk0Z3E7bhB5JxL3OGGNHB9bqEpncOmyFRVNFkFrZ2iyZbaFyXimdi1tVuE9AvetKdLhWpzbZqmG89Hqcd2Bh9sWBRF9YsHgQLC87PI02SI39ofuRlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZIdlrU9k; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZIdlrU9k"
Message-ID: <97e15692-af14-4a3f-99ed-61fda50fe68f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781850966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rOArnfKPATJkYYumpandljz3xZTiXVcjL/j0XUj+YII=;
	b=ZIdlrU9kkEk7gMIEDcoZTRyKTmSYK4eElAgHE0eYDq7kdhaPD1s7/wVFKarpoxd0yj4tbY
	ucxkXUZ75D+OIhiICK0xgULYcAy2alParSxDsHCB9mLwKbnaCZNJ1Rzp6YdzsTq8M73Wjy
	anF8szLSmHxjheQNWEr2AdZApi+Wa9U=
Date: Fri, 19 Jun 2026 14:35:49 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v4 3/3] selftests/bpf: test rejection of a
 packet-modifying SK_SKB stream parser
To: Sechang Lim <rhkrqnwk98@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, Shuah Khan <shuah@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260619062959.3277612-1-rhkrqnwk98@gmail.com>
 <20260619062959.3277612-4-rhkrqnwk98@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260619062959.3277612-4-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/19/26 2:29 PM, Sechang Lim wrote:
> Verify that attaching an SK_SKB stream parser that can modify the packet
> is rejected, while a read-only parser still attaches.
>
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>



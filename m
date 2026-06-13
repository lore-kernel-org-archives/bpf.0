Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B5A2C3768;
	Sat, 13 Jun 2026 17:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781371556; cv=none; b=Xw304U/AEv/OKSLOUUkl2zABlZqnwMvm7/slUKXw71AMbhp0ORk6nAAD/7QEoa7+I4Xrrenm12OetfzYZqiEjFlOPt2ayiBLl5GoFDzz8LUl3dxlMKBHP0h/LLwhkjBmOTvauZYCM1k6dv9d7bBobBV+SwW5lsiEr65df85jS9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781371556; c=relaxed/simple;
	bh=XQt8n1j62y4Z33sOEEHpLj2LyMhlFYqQz2yKhwdHTxE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bm6zL4gpbi7yAescsh+na0OhTwSLi2J+tCQG5a9NBVUjnbr0zR/PNhgI0A9OFH4dXHJDIipV6w5mAwga/AMaqYVygf9vA964s284eWXPhtYUFllVqLZK13bvTgMq4MOhLmOJRu67d3Buci/k7WGZRSheu+qrf3gumAQDsbJVv9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+lmQSVS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+lmQSVS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61EF1F000E9;
	Sat, 13 Jun 2026 17:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781371555;
	bh=XQt8n1j62y4Z33sOEEHpLj2LyMhlFYqQz2yKhwdHTxE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=M+lmQSVSP5qBsE4r0JwtuP00ps8iY6kFWwQnKCoYfE+tXicK6gwVqXw6tYfgHI8Uj
	 SOwbJxyybi8KdRTeMWT44alCU0z/pfRBrYJx6RDp6pS6zNs0u+Ne/sseIw+KiP9oGs
	 hY5N9XWXOHAxAE36TdKhjyFDSUw7Lo8mhtxG5rot0bMP8QxAC/HqsNyOmY93FKEtl5
	 e8/bPcQelAJHaTGOLumVF78EhSGd46DRmUFw0Lnr11a/+QwnzAXn2SzPsChFREgW5m
	 GOzxXKHSAnqWa2nRhIoyCPNwF9zRYm/Hu4fCLrScqHE2Z0cATfNKhF46Rzj0nqV9k4
	 yp27bqABvZdHA==
Date: Sat, 13 Jun 2026 10:25:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, davem@davemloft.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, shuah@kernel.org,
 jiayuan.chen@linux.dev, toke@redhat.com, menglong.dong@linux.dev,
 emil@etsalapatis.com
Subject: Re: [PATCH bpf v5 1/2] bpf: Run generic devmap egress prog on
 private skb
Message-ID: <20260613102549.0061a875@kernel.org>
In-Reply-To: <20260612114032.244616-2-sun.jian.kdev@gmail.com>
References: <20260612114032.244616-1-sun.jian.kdev@gmail.com>
	<20260612114032.244616-2-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jun 2026 19:40:31 +0800 Sun Jian wrote:
> Suggested-by: Jakub Kicinski <kuba@kernel.org>

I did not suggest this

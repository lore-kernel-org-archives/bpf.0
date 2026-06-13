Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7433E4501;
	Sat, 13 Jun 2026 17:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781370477; cv=none; b=ZrUBpnHQHx1FEJlcagKcMKsBmwWM/ccoCjba+8wACqRrPVJSBFgiz+sm8BRjUnaIqE6TjoqGqZ0rHZw6uXjN8JoN9CVRtlJaaKJDCjelSAf1wqua9mO7gUocgHy/1x1iaJ+2vzhsjyjzGkdZZM4hqJB9j+tSZinIm4O4qz65FZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781370477; c=relaxed/simple;
	bh=Dqm6AL3CLEzNOgzwcPR03gSbOJANOwQzOOBM3duUxm8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=RWO3Ry1H160UWAfvzDEw4SWLFIimAJD/4gIi1kUiYIDRuZWN9/6meCnzHZMEqc4pGcDgpRPt9beHk8JSrVMoK/yFxDYjNBZ6TY/Nlv9c5Km4x5fQgYR25mcvTsnnfqgqV1XQx5ntnfA62TvDPtdtkF+1+B0xWFBy6Eq6+6drB4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hE8VkXE4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hE8VkXE4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449ED1F000E9;
	Sat, 13 Jun 2026 17:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781370475;
	bh=Dqm6AL3CLEzNOgzwcPR03gSbOJANOwQzOOBM3duUxm8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hE8VkXE4ZBTtuORu9ZgLuIwT7WvzNnBTzZYtIXZPhJ9ihtv7Ck5x0DjKjhVAZUrO7
	 F1NPB/6Z3QlAPDGsa5Ff03WyDKmBVTz8Wik1hSl+k/Ghrx+HFyTZ3UhQe3cVo+94a8
	 d1i0tmAxoSgIOO2/SSaO3x3yBtOpdBKkzPNmJn8X7sngJSfvn0kVo0MKTo6edF1QLn
	 ECbxuSahxjB71/qrrc4APGVw1eitBX+45sTql3PqPo6e1zD6yN48+l7b2X3FlnEjhm
	 udj0CHJX5VEmSqWdAMTq4Xt4hO7Xw+CHa4aFc3ZcdrR7uuhV/7i6YELndil1GNzzNY
	 EIxOIxIxd2OrA==
Content-Type: multipart/mixed; boundary="===============4728993374088295216=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0f02feb3541edb69219f9f3b5dd90dc139e1554b325983fc4bb016e187cdaa7e@mail.kernel.org>
In-Reply-To: <20260613162443.60515-2-leon.hwang@linux.dev>
References: <20260613162443.60515-2-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Fix bpf_get/setsockopt to tos for ipv4-mapped ipv6 socket
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,john.fastabend@gmail.com,sdf@fomichev.me,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,shuah@kernel.org,leon.hwang@linux.dev,ihor.solodrai@linux.dev,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,kernel-patches-bot@fb.com,zhoufeng.zf@bytedance.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 13 Jun 2026 17:07:54 +0000 (UTC)

--===============4728993374088295216==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> When TCP over IPv4 via INET6 API, bpf_get/setsockopt with ipv4 will
> fail, because sk->sk_family is AF_INET6. With ipv6 will success, not
> take effect, because inet_csk(sk)->icsk_af_ops is ipv6_mapped and
> use ip_queue_xmit, inet_sk(sk)->tos.
> To relax this restriction, allow getting/setting tos for those possible
> ipv4-mapped ipv6 sockets.
> Fixes: ee7f1e1302f5 ("bpf: Change bpf_setsockopt(SOL_IP) to reuse do_ip_setsockopt()")
> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>

In an earlier review round it was suggested that "bpf_get/setsockopt
with ipv4 will fail" should read "bpf_get/setsockopt with SOL_IP will
fail", since the call uses the SOL_IP level rather than an ipv4 option.

The body here still reads "with ipv4 will fail" - was the s/ipv4/SOL_IP/
reword intended to be picked up?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27472657322
--===============4728993374088295216==--

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43D22798E8
	for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 09:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771235885; cv=none; b=TbPhZwAKScUJPLD7w4AhfGsCiunAzLldBmnh0yxhM/Ns8P9S5keXWtj4Y7jzFm7AwZhQKDwD8PrihTtBOgi65JyEU2QYkRbC31wtsyZKMWw/KQZActHmx+TKrUZ0iz+1D6GYY3vW/AtEFFrdZ9J8GL/NxBbpmRLuENNrG68ZXjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771235885; c=relaxed/simple;
	bh=xSc0sod2kmwnOQ/GIn0ZIvsaKVu7872SZl9Isg81E+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JdMDXI94kG0LA302q/Z98jeyCQGa0UgbNt7Xam7/XWmaEUcxnq8mTwCgorW9JzLyyizKFUZ9xyeE06UKs5q6IEwa1sXovSSyU27FPcg1UKgH9dotAD8yE+ix08ow0beFxw7geLaTZolaDci4vC+selpft0prcrwMH0BV2D2bxFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbTwxe/Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbTwxe/Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B97C116C6;
	Mon, 16 Feb 2026 09:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771235885;
	bh=xSc0sod2kmwnOQ/GIn0ZIvsaKVu7872SZl9Isg81E+U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LbTwxe/QpP5dOdIgBd+1W5/tW702h+4C5RyBg6Fuc/T0RYJYgH8gCA7SzBWt7t5Cn
	 lEJ1iroylySxy803yiuTaWooIzi2p3nY+MqEhm7nL8yzv+j08Buep06mOB2+IsNeGL
	 T2yMf+nnm9Zgbr6+QUAtq2L0uJKoBzLM1oIvqBENkgG6YlZlJ6YZ9AjDF5DH+CFSgg
	 rb641xre5z48jfzsjcuHIGLRjoRV9IUcsyS9bHeG2fx5FLdeYq1pWcDhSZpvzX6LAq
	 QBUINjyMpSGkBCJMW+JA72cj6BQuqEOLB+N9p/Mjfsc6EV3EF3qKp0Fcwen80rFvyj
	 aVtf14syzZywA==
Message-ID: <8c8f6906-e6b1-4a8a-98dc-51d467b16a53@kernel.org>
Date: Mon, 16 Feb 2026 09:58:01 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2] tools: bpftool: fix truncated netlink dumps
To: Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
References: <20260215000656.323486-1-kuba@kernel.org>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260215000656.323486-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-02-14 16:06 UTC-0800 ~ Jakub Kicinski <kuba@kernel.org>
> Netlink requires that the recv buffer used during dumps is at least
> min(PAGE_SIZE, 8k) (see the man page). Otherwise the messages will
> get truncated. Make sure bpftool follows this requirement, avoid
> missing information on systems with large pages.
> 
> Fixes: 7084566a236f ("tools/bpftool: Remove libbpf_internal.h usage in bpftool")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Sorry for the long delay! I haven't CCed netdev@ on v1, and it appears
> that CC: bpf@ + kuba@ gets misfiled in my inbox.
> 
> v2:
>  - make the same change in libbpf_netlink_recv()
>    note that libbpf_netlink_recv() does a PEEK and then realloc
>    if the message is larger, so it's technically already safe
>    but probably better if we are consistent
>  - fprintf(stderr) -> p_err()
>  - adjust msg
> v1: https://lore.kernel.org/bpf/20251205011823.751868-1-kuba@kernel.org/
> 
> CC: qmo@kernel.org
> CC: ast@kernel.org
> CC: daniel@iogearbox.net
> CC: andrii@kernel.org
> CC: martin.lau@linux.dev
> CC: eddyz87@gmail.com
> CC: song@kernel.org
> CC: yonghong.song@linux.dev
> CC: john.fastabend@gmail.com
> CC: kpsingh@kernel.org
> CC: sdf@fomichev.me
> CC: haoluo@google.com
> CC: jolsa@kernel.org
> CC: bpf@vger.kernel.org
> ---
>  tools/bpf/bpftool/net.c | 5 ++++-
>  tools/lib/bpf/netlink.c | 4 +++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
> index f25d66c8395e..974189da8a91 100644
> --- a/tools/bpf/bpftool/net.c
> +++ b/tools/bpf/bpftool/net.c
> @@ -156,7 +156,7 @@ static int netlink_recv(int sock, __u32 nl_pid, __u32 seq,
>  	bool multipart = true;
>  	struct nlmsgerr *err;
>  	struct nlmsghdr *nh;
> -	char buf[4096];
> +	char buf[8192];
>  	int len, ret;
>  
>  	while (multipart) {
> @@ -201,6 +201,9 @@ static int netlink_recv(int sock, __u32 nl_pid, __u32 seq,
>  					return ret;
>  			}
>  		}
> +
> +		if (len)
> +			p_err("Invalid message or trailing data in Netlink response: %d bytes left", len);
>  	}
>  	ret = 0;
>  done:
> diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
> index c997e69d507f..96c6b09c433e 100644
> --- a/tools/lib/bpf/netlink.c
> +++ b/tools/lib/bpf/netlink.c
> @@ -143,7 +143,7 @@ static int libbpf_netlink_recv(int sock, __u32 nl_pid, int seq,
>  	struct nlmsghdr *nh;
>  	int len, ret;
>  
> -	ret = alloc_iov(&iov, 4096);
> +	ret = alloc_iov(&iov, 8192);
>  	if (ret)
>  		goto done;
>  
> @@ -212,6 +212,8 @@ static int libbpf_netlink_recv(int sock, __u32 nl_pid, int seq,
>  				}
>  			}
>  		}
> +		if (len)
> +			pr_warn("Invalid message or trailing data in Netlink response: %d bytes left", len);


CI bot is right about libbpf's pr_warn() not adding the line break
automatically. Other than that, it looks good to me, thanks!

Acked-by: Quentin Monnet <qmo@kernel.org>

Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305792D73AE;
	Fri,  6 Mar 2026 06:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772778399; cv=none; b=c1f9uauMTcbYc07QsVEw6yNTLryv1g1eiv2PVj9Ln/1nHGS+d0Lh7i5Gr06OJpaGkAjrbPspi5uFWvhnXETENRp8QTRtgYUTvRVnWH7beud4ZM7LWW/+mcIrJKQ71aEkowXGTksLWcM5mF7NSvYT1w/aAdRk+j4SdMf8Beybufs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772778399; c=relaxed/simple;
	bh=25QvG2yZnP5uqJd6i/I/B0t5485vNvbOGdUykbfABmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n5FwLx0GjFdrJ/JCaBCPxwr9TgWYwlFNr/b8Ccy7qYR4TF/Eoy8NXBMjr86PM89rmH+13odXyjRALrxHpHTfeooMzG7WKCg0gX4josgftAINlB6bmblAQ0SAAYq5S1IHp8gFb0heFQNIap6PvLTsf2OxvKlF27xXuk3qRwvW3lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gTaoWxiF; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gTaoWxiF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=25QvG2yZnP5uqJd6i/I/B0t5485vNvbOGdUykbfABmA=;
	b=gTaoWxiFXgZv55Q1RxJGCPTPSGVbn0Rs1V/XZKo4oUVmgbpG6lVwwHDE7Sj8hY
	O0nrMtMToCKFh+wKpwHsC7yauVd+G0cGGn/LMAG+Y4k+TtN5pDagVwSDwlfxa80p
	xT35qAPXhxCqVKQ5fskgFzo0yCfGAfV/3ZYfdRRQrtwEQ=
Received: from [10.54.24.32] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAHBbo2c6pp7zL4PQ--.30886S2;
	Fri, 06 Mar 2026 14:24:57 +0800 (CST)
Message-ID: <9cd041bb-9db7-4550-aa59-e1e0db6b4f93@163.com>
Date: Fri, 6 Mar 2026 14:24:53 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 1/5] bpf, sockmap: Annotate af_unix sock^sk_state
 data-races
To: Michal Luczaj <mhal@rbox.co>, John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Yonghong Song <yhs@fb.com>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Cong Wang <cong.wang@bytedance.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260306-unix-proto-update-null-ptr-deref-v3-0-2f0c7410c523@rbox.co>
 <20260306-unix-proto-update-null-ptr-deref-v3-1-2f0c7410c523@rbox.co>
From: Jiayuan Chen <mrpre@163.com>
In-Reply-To: <20260306-unix-proto-update-null-ptr-deref-v3-1-2f0c7410c523@rbox.co>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wAHBbo2c6pp7zL4PQ--.30886S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU1c_-DUUUU
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbC6xnvl2mqczm2zwAA36


On 3/6/26 7:30 AM, Michal Luczaj wrote:
> sock_map_sk_state_allowed() and sock_map_redirect_allowed() read af_unix
> socket sk_state locklessly.
>
> Use READ_ONCE(). Note that for sock_map_redirect_allowed() change affects
> not only af_unix, but all non-TCP sockets (UDP, af_vsock).
>
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>



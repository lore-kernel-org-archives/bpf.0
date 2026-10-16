Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7B73E40E3;
	Fri, 16 Oct 2026 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146331; cv=none; b=cYYao7CSAJLBaHOUnjTzvWkNlG4ReiS+gldvyzJd1Y3LUCP4YXsxyvH/EAQZdJrWishmbxA3AhuesuEdDhVw8dxYmKt7OwT8Am4LuiN923SbPONbEs3/5ABB+2ezVkFFnT8M77TYhLpI8eU7pm+AndusYZGdanpU/jVg0I5YhA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146331; c=relaxed/simple;
	bh=fjOAV6aOjxvcvXLXicN3XlwbhPGhh9bSPP0818d/eXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IWH31F6aSU/R7akiwRO5MTae5qCKRbLUkZDUjHnXWrjV3FbSCWigB3eyrXvUhZGjNEHR9Lfs2FMvLTHa6ajGdkC4TmEtuOAvUrD7x3etxY0+wC/6FNfNDByAbg/24ndo5GxtYGvHL8Q0RiPwsN/CMXMSwl/fP9cclPd6JmY0W8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=a8oIbztX; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="a8oIbztX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=dAFssueGI2YeIn7DG4ltEAeRdn0r+4XXsyyQqEkAn/g=; b=a8oIbztXMQRxtNoFzBq3M8hLTR
	Rx+4oeCIgL71DQRpYzHXS8WYUSb28Kxr+TDnwlCgdpTJuB4GhJFG5cY/pU8I1Mujc8FOi3fQwY3aD
	gG2g9TtzQcihrW+HMKPPAR0//76FM8PS6kmCqXALP8nTmndQkNAI5sJcqIaG7yvZqg3bIPIX9gqGr
	ncovpKGnQFIIQbmCKlEqvn2ie1JQ5rSrSJwC/Y2Nrvpy0dWsJQXfXe4gx4BKnlhqPG9JhpuuU5L7P
	+JVOVK5PdDdZDoyvskwfC8YX0/30ySH8E4NDNKQsf1ywcqhOcdeQ8/3DATnaVGjnVkNNKk+S89r4V
	I+eOjbOQ==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xHf7t-000Bjb-16;
	Fri, 16 Oct 2026 12:25:25 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1xHf7s-0000JL-1G;
	Fri, 16 Oct 2026 12:25:24 +0200
Message-ID: <bc6ba1a7-8a96-4f0c-86a9-51a6e397f4ee@iogearbox.net>
Date: Fri, 16 Oct 2026 12:25:23 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Record only the test ICMP echo
 in tc8 of tc_netkit_scrub
To: Qiliang Yuan <odys.yuan@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>,
 Nikolay Aleksandrov <razor@blackwall.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261016-selftests-bpf-tc-netkit-scrub-v2-1-b484a7ce2a63@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <20261016-selftests-bpf-tc-netkit-scrub-v2-1-b484a7ce2a63@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28155/Fri Oct 16 08:24:17 2026)

On 10/16/26 5:25 AM, Qiliang Yuan wrote:
> tc_netkit_scrub attaches tc8 to the primary netkit device, sends an ICMP
> echo with a mark and a priority through it, and checks the mark and the
> priority that tc8 saw against what the scrub mode lets through.
> 
> tc8 records the mark and priority of every packet it sees, and the
> device also carries what the system sends on its own once the device
> is up, like IPv6 neighbor discovery or the mDNS of avahi-daemon. When
> such a packet goes out after the echo, it overwrites what tc8 recorded,
> and the test finds a mark and a priority of 0.
> 
> Record only IPv4 ICMP packets in tc8.
> 
> tc_netkit_scrub run 100 times on a bpf-next kernel with KASAN enabled,
> x86_64 VM with 32 vCPUs and avahi-daemon running, before and after this
> patch:
> 
>              before                                after
>    outcome   2 of 100 failed (mark and priority 0)   0 of 100 failed
> 
> Fixes: 716fa7dadf11 ("selftests/bpf: Extend netkit tests to validate skb meta data")
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
> ---
> V1 -> V2:
> - Check the packet in tc8 the way tc1 and tc7 do, with
>    __bpf_constant_htons() and a goto out for each check (Daniel)
> - Add before/after data
Looks good, took this into bpf-next, thanks!

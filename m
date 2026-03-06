Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6C6313E2C;
	Fri,  6 Mar 2026 14:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772806020; cv=none; b=aBlDg+ABqfCMSD+Cwg15+9aRSJjwuALY9eZYlvgrz6PmVzvTUknGBNNCUBTOPumQ2O+gHvtSudX8RAIJhMXMt5AddyO7v0LSr2uBWwMFZTowpwGK+4ZBtR5k7Xr3cvtLh03CWvF1ZOfg9tEiWAV4hIvy73WSHId0VyWvMfxb/JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772806020; c=relaxed/simple;
	bh=zOMrDzt6Kt+O7lNavb64k4pt1LqFU3bftY7nK/1uQZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KqWLnenCnwvaeuw/qjgPxQaUCsszY3h9lxVRdaJPJ+wXDLV5XL7LyTAWnAjai8ZpnaT6v8BCo90PFITzspY/fyt5vuLuRKK6Z8nZS9EqQQABO7HokeaAKD+kaLfOYzcDfWgfo6VWdQToVDMx3X+R8shUGPaSRhxZSR2CrWYQpwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=tZ88noAj; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="tZ88noAj"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vyVpA-002b4g-Us; Fri, 06 Mar 2026 15:06:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=tC4hDySprxrT/Gr+j4+xPNKNNmZSdgwoLCHwVwT6ztI=; b=tZ88noAjFpW5Nv/sqE9VS4pza5
	hPbP4uJ4fe57vF2JmAJ/yKvFEzygbyKWj3mC5t/ylL+43p/IFKIzQFzZyS3gjCR5V9WMm1IKZpBB3
	liXKtSTtDgsyRZqZxlm79Ncm0HpPJOAXL1O81qTCMRBZKT1flLqgBD66rm8bkVA+XEthNDMYstXE8
	ipngfsGAbLtFtLQ69Dhze++67yIKq+eqE5UE0gUa+MZKStoDUec4Y7XjHz5kJ/FLuw84ZSbd6tGgr
	3U6P4zbehVpOOi+kfCEndJeH8JYHTsoksN9R/BTXvYp3mzsgfBRbcdsT1jsSEz+OGyxDq91UQbDMl
	3JvQNP/A==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vyVpA-0001kw-Ba; Fri, 06 Mar 2026 15:06:40 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vyVor-0008GC-Mo; Fri, 06 Mar 2026 15:06:21 +0100
Message-ID: <6b02c177-69a2-4e08-a936-65bfa8e85b7e@rbox.co>
Date: Fri, 6 Mar 2026 15:06:18 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 3/5] bpf, sockmap: Fix af_unix iter deadlock
To: Jiayuan Chen <jiayuan.chen@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
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
 <20260306-unix-proto-update-null-ptr-deref-v3-3-2f0c7410c523@rbox.co>
 <b2218c30-a704-4395-a67e-95c62b75586f@linux.dev>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <b2218c30-a704-4395-a67e-95c62b75586f@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/6/26 07:04, Jiayuan Chen wrote:
> On 3/6/26 7:30 AM, Michal Luczaj wrote:
>> @@ -3729,15 +3729,14 @@ static int bpf_iter_unix_seq_show(struct seq_file *seq, void *v)
>>   	struct bpf_prog *prog;
>>   	struct sock *sk = v;
>>   	uid_t uid;
>> -	bool slow;
>>   	int ret;
>>   
>>   	if (v == SEQ_START_TOKEN)
>>   		return 0;
>>   
>> -	slow = lock_sock_fast(sk);
>> +	lock_sock(sk);
>>   
>> -	if (unlikely(sk_unhashed(sk))) {
>> +	if (unlikely(sock_flag(sk, SOCK_DEAD))) {
>>   		ret = SEQ_SKIP;
>>   		goto unlock;
>>   	}
> 
> 
> Switching to lock_sock() fixes the deadlock, but it does not provide mutual
> exclusion with unix_release_sock(), which uses unix_state_lock() exclusively
> and does not touch lock_sock() at all. So a dying socket can still reach the
> BPF prog concurrently with unix_release_sock() running on another CPU.

That's right. Note that although the socket is dying, iter holds a
reference to it, so the socket is far from being freed (as in: memory
released).

> Both SOCK_DEAD and the clearing of unix_peer(sk) happen under
> unix_state_lock() in unix_release_sock(). Without taking unix_state_lock()
> before the SOCK_DEAD check, there is a window:
>
> iter                              unix_release_sock()
> ---  lock_sock(sk)
> SOCK_DEAD == 0  (check passes)
>                                   unix_state_lock(sk)
>                                   unix_peer(sk) = NULL
>                                   sock_set_flag(sk, SOCK_DEAD)
>                                   unix_state_unlock(sk)
> BPF prog runs
> → accesses unix_peer(sk) == NULL → crash
>
> This was not raised in the v2 discussion.

It was raised in v1[1]. Conclusion was that bpf prog bytecode directly
accessing unix_peer(sk) is not an issue; bpf machinery will handle any
faults. That said, should a "bad" value of unix_peer(sk) end up as a
parameter of a bpf helper, yes, that is a well known[2] problem (that have
a solution unrelated to this series).

[1]:
https://lore.kernel.org/bpf/6de6f1bf-c8ee-4dfb-9b8c-f89185946630@linux.dev/
[2]:
https://lore.kernel.org/bpf/CAADnVQK_93g_KkNFYXSr8ZvA1fYh4hoFRJCJFPS-zs4ox0HhAA@mail.gmail.com/


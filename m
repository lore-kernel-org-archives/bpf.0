Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA7937881C
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 21:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771882997; cv=none; b=HLjIeZgrqH0Vg6FVoHFls2K+do/Au90zL4ZjoiJvWOvaGAH0E5hwiqANmaNnb6ft+erfk4pfsBqwo3BXtoAkQfVzknamWdxvalsi3PVwAU4AGiJhlfe+arJcbWngqt0VNJv9j5XohqFE3ULmecW6CSnZ1bxNCsVpKhkRcvi+TDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771882997; c=relaxed/simple;
	bh=8x3+GaARO3sIasJgNw+lz23WiKvjHUHZs7cHUaZ6qwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wer7tTfXW3qBXjgnPno0wUgHli7ezZJrzj5rtBxi5jox7leAXzIgjUHenZJB/HMeXjcEX+cH8vG3CNsYGtIr7mK1PZ6HM7/E+YCjs3yBDdb8Aih0gPwm813BviQvWlnLXpG4vX/Z1DlgDha27WPlD06zAdd1L+hvi9c6wPy9l/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=McoNbNT9; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="McoNbNT9"
Message-ID: <d122ed8b-ebfb-4d59-96ce-10c361e76676@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771882994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ZYcupND28PGAqaDkbT7jqLJ1TI0n/gP/2am0PmSi9g=;
	b=McoNbNT9vjwf2I2pNyeCv3x53PejvJMiSF7SiH5fi27UYl4kcLGt//K/xRN1I5Atzs1uJo
	zPoyam07zdN+LgsrrFJad6W947WyoNLVSd1zIpC5z6+ZL/zeA3eYLSNNYfbfC170YMLnUq
	B/GYtwlpPVkZQ9Beg6i1e5s9pVApOIg=
Date: Mon, 23 Feb 2026 13:43:06 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 3/4] bpf, sockmap: Adapt for the af_unix-specific
 lock
To: Michal Luczaj <mhal@rbox.co>, Kuniyuki Iwashima <kuniyu@google.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Willem de Bruijn <willemb@google.com>, Cong Wang <cong.wang@bytedance.com>,
 Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260207-unix-proto-update-null-ptr-deref-v2-0-9f091330e7cd@rbox.co>
 <20260207-unix-proto-update-null-ptr-deref-v2-3-9f091330e7cd@rbox.co>
 <CAAVpQUA+8GL_j63CaKb8hbxoL21izD58yr1NvhOhU=j+35+3og@mail.gmail.com>
 <c4eaead1-ad69-42f0-9699-5f2d555a7693@rbox.co>
 <a2f2c260-38e8-4ba3-8655-cffbee046259@linux.dev>
 <b75bbc3f-85fd-4209-9ce1-3bf685ba62ff@rbox.co>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <b75bbc3f-85fd-4209-9ce1-3bf685ba62ff@rbox.co>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2/11/26 2:02 AM, Michal Luczaj wrote:
>> It should also be helpful to be consistent with tcp/udp iter and use
>> lock_sock() instead of lock_sock_fast() in bpf_iter_unix_seq_show().
> OK, I'll tweak that in v3.

Hi, Michal. Are you planning to send v3 soon? I don't think the 
sock_owned_by_user for the non-tracing prog needs to be addressed in the 
same set.


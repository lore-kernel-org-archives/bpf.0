Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F90125DB1A;
	Wed,  1 Jul 2026 23:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782947982; cv=none; b=DPPBZB3RKZr7fwKYwOwxSvZNz4bF337fPzqBZigxxHCoikMMa/lksDcYquQqucvoj+BbOc+j9DhA09pLzso2qPw16g0+EAqqhD6lhiLldRTLLqPsaxBPbTTBWSGcPGvrOhfYBJAoVEV17Er0g0RAMMJfHV2rQUnKK5xS/WuRmYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782947982; c=relaxed/simple;
	bh=ACVs32HKWN2l3qCT6bt9KBgDlyw8SC7EYSY5BD+cHRU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=vDbuPk+xmqJ4axmYoDD7EZYN0Q4PnsvZP+7lYaCzy+p9V86Z33XKIsaXuKhD3vqgBlIGyVqWAh9qHxOWUl1thgEcdg4jsFbGkReuc8zXBDj5SfZJwKXZejQd+w7USo+OSHNn4FZPGMTZsHWrRySyb/Iobw63drK7EQmGDXx1RfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=YBGQeJ3D; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="YBGQeJ3D"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wf4DC-007iXU-Rg; Thu, 02 Jul 2026 01:19:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=D7gpsjXmZbo5dRBO6A6NJQHjVIE5sRJoWkGO/ABu8lM=; b=YBGQeJ3DPPzedHUKrfFkT9zxGS
	DbYxTPy6f/G1xYOnX0mms0/xSw3aUIS3b7jqEWE2RMdZb1QU+xh2C0UDeF6AaxbLjdNbOH4168RrG
	bSitLWXaal17eEINvjAFD1J2pDvOw6gNHgEr/W8x2/X1cizsGeO31be/1QfLBDU8xfPWGcrJ+ppgG
	Dt4FhqquUWaq/2MYAkzqEbPTSdKnwziTixFRMFrxO+U2ndK0JW0x8kwn3Vz75hSnS0E78e5OdeK4q
	MO+TVn6LVnp3RoZJjfHTOA9OQIaczUW2SUPXNI62aR9MoFgsv6PUGfOfACnvjIuiEXptvLZOvUTFE
	wWt9Ogtw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wf4DB-0004Z9-PC; Thu, 02 Jul 2026 01:19:21 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wf4D9-004HBn-Qq;
	Thu, 02 Jul 2026 01:19:19 +0200
Message-ID: <92dfafa5-3465-458e-b57f-00b23a0f9a46@rbox.co>
Date: Thu, 2 Jul 2026 01:19:17 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH bpf v2 4/4] selftests/bpf: Fail unbound UDP on sockmap
 update
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen
 <jiayuan.chen@linux.dev>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Cong Wang <cong.wang@bytedance.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co>
 <20260626-sockmap-lookup-udp-leak-v2-4-7e7e201c951a@rbox.co>
 <CAAVpQUAJYkOBEtgUpL5UgnwM9Hu3Y57a9xZWRy7zHg5XkGnW5w@mail.gmail.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <CAAVpQUAJYkOBEtgUpL5UgnwM9Hu3Y57a9xZWRy7zHg5XkGnW5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/26/26 23:03, Kuniyuki Iwashima wrote:
> On Fri, Jun 26, 2026 at 1:37 PM Michal Luczaj <mhal@rbox.co> wrote:
>>
>> sockmap now rejects unbound UDP sockets. Adjust test_maps.
>>
>> This effectively reverts commit c39aa2159974 ("bpf, selftests: Fix
>> test_maps now that sockmap supports UDP").
>>
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
>>  tools/testing/selftests/bpf/test_maps.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
>> index c32da7bd8be2..81cd5d0d69c1 100644
>> --- a/tools/testing/selftests/bpf/test_maps.c
>> +++ b/tools/testing/selftests/bpf/test_maps.c
>> @@ -759,12 +759,12 @@ static void test_sockmap(unsigned int tasks, void *data)
>>                 goto out_sockmap;
>>         }
>>
>> -       /* Test update with unsupported UDP socket */
>> +       /* Test update with unsupported unbound UDP socket */
>>         udp = socket(AF_INET, SOCK_DGRAM, 0);
>>         i = 0;
>>         err = bpf_map_update_elem(fd, &i, &udp, BPF_ANY);
>> -       if (err) {
>> -               printf("Failed socket update SOCK_DGRAM '%i:%i'\n",
>> +       if (!err) {
>> +               printf("Failed allowed unbound SOCK_DGRAM socket update '%i:%i'\n",
> 
> nit: Maybe s/Failed/Unexpectedly succeeded/ ?

Sure. I've tried to align with the other printfs ("failed allowed..."), but
I agree it was unclear.

> If we want to avoid breakage, this patch needs to be squashed to
> the fix patch, but it's discouraged in netdev, not sure about bpf tree.

I guess I'll just post v3 as is, and squash if requested.

thanks,
Michal

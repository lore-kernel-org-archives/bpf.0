Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DDC3A0B10;
	Tue, 24 Feb 2026 15:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771946957; cv=none; b=XUR0QhJgwuWZM8djp9JAnM7QxtzAZ6vBT3cnzEJAYr0QJu16G1AgYMXO+Zf42IGhd9/po4NykkB++OyJ2Sxsf4rM5/ZPPDOWxSelHVzYgsVyf57teLqPR+/w2xd6OJ/QSsF1EsTU4uVZjLj5ey97UIxBosjskem14p5btFkhyj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771946957; c=relaxed/simple;
	bh=h86C3V5JvvlSa2UJrY5/TH/M97TcSlk1fzWKis0fUwk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Fh9G1DhBbealwJn6RyA6RSfqJPq94oDSQcUGqQa+a84RcAZzyDZW72HoCWa9WcOsT3mxOC6L3/+AIxlG6U/FfsT1TBRH0/EBdydJhjaXlRrsWfKMv7EkqNPFOw8KcK6kKUod2bnOxukSvBgrdvlMbLIcqJq5VSzB5NBigr1IrRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=I39Y1r/i; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="I39Y1r/i"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vuuLL-002NkO-1U; Tue, 24 Feb 2026 16:28:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=vzri9he9eL5F6+/jJk0wXdf9KvtVklQVrYlr1ndXvBA=; b=I39Y1r/ibfEnZzAU19DikM53hs
	DNHQ9JNfSEUsy9OpYL0uEHhKG9QiXjdGbb61ppeLiIe/lQGyUVAbzcUm08qyvxVWvvz//Bobzm0xe
	EJf6MlLxnNZkYC4F96DaMCEG5SGyT1FunPvtbhn4Uas4E05WsEvKKUFb1BxdeJ/WLKwlzDP35xRbX
	4mPzUYpnMR3M5X1ejsV6mVWBGORky/APOB407sKONK5MkjldiKW+fMVDzs3nLRV9Xyaf3GGZ7zUUR
	mhXtoGO4Bvk/oiqZYEp8CZNObR5e99CIiSiyyqDJuJxqPmEjjgSPcVvezO96e+H8mkaKKhKjM/VTZ
	k9UHd+QA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vuuLK-0007qa-2o; Tue, 24 Feb 2026 16:28:58 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vuuLE-008TwW-Vj; Tue, 24 Feb 2026 16:28:53 +0100
Message-ID: <1022fcaf-ca38-43d2-84cb-f66a504335e1@rbox.co>
Date: Tue, 24 Feb 2026 16:28:50 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH bpf v2 3/4] bpf, sockmap: Adapt for the af_unix-specific
 lock
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Kuniyuki Iwashima <kuniyu@google.com>
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
 <d122ed8b-ebfb-4d59-96ce-10c361e76676@linux.dev>
Content-Language: pl-PL, en-GB
In-Reply-To: <d122ed8b-ebfb-4d59-96ce-10c361e76676@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/23/26 22:43, Martin KaFai Lau wrote:
> 
> On 2/11/26 2:02 AM, Michal Luczaj wrote:
>>> It should also be helpful to be consistent with tcp/udp iter and use
>>> lock_sock() instead of lock_sock_fast() in bpf_iter_unix_seq_show().
>> OK, I'll tweak that in v3.
> 
> Hi, Michal. Are you planning to send v3 soon? I don't think the 
> sock_owned_by_user for the non-tracing prog needs to be addressed in the 
> same set.

Yes, I'm working on it. Sorry for the delay, I'm taking my sweet time to
come up with a selftest.

I think I can neatly fit the sock_owned_by_user()-related stuff in this
series, but let me know if you'd rather have it separately. Whichever way,
I don't mind.


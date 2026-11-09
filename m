Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794190515;
	b=4LFqXTxKW4nlPAQNkvltAB023qytZSYRZ/a1fZiYwa8GvpRQCJ00T93D9xRuoRIgYhRO
	 IrjsA9nTgYQyNpIaoI/kKxr0jMV0hhiMpRptU6bqt+zYSkigZLooOzdBr0OklHHZ7gIa5
	 e5UwNP+WmjlpfR3LJAuqKZR9v0dCqm/Zd+noGLBS1EwCX8QHe/ftXUGhqLzxDP4/baAVy
	 jFwBe5SufEj6+e/wYoU8h2oZWsYSZss7UfaTGflUhPIRoaKkRu4o0Wq0eDUW+lL5z/C/L
	 RMkYnRTFvCNrrBK+z7Qs5XVeBiNycdhG7Il8Y/0EnfPKVQK0zazLARcA7sYHBP60LOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794190515;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=bIloYSK3+4K/KkpgHLmr3ED9jzQvebQcrpQM//1CZGo=;
	b=T+wXWCQ7cJNJbpkAbDoDNyECcyC90LER32IHwBExCq/M27XQDj00TxOwQwV9VoD/FDe9
	 LxMyNNaW095JSdLJ+VkF4IWvCTf4ZKEGHtxUReEvxJ1v+7yn4tF2qGeOp0Q8UPLcw4YIH
	 FGQ7ZUPhiFiVd587K09fsEdElsZ6A2dsy1CWi2wUYZAsS0HvnrbtuCpPu6210K/jWmqvF
	 XpSkp0zH84xhyyKMPnr/MlK+F06OHY0lwER08/ybb0sFy2hGJ8zKPSPkqhojpovaXxOip
	 W30P3bWbKjMCdd7N5i8gCKdtX+serFeT+4Xk7asLZRjtyUe5NwHfhU5wgC8nePcBQ2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Xa1Jr9pq;
	arc=none smtp.remote-ip=91.218.175.181
Received: from mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89451606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 02:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89451606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Xa1Jr9pq
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8n8V1yRl+iYZ7zK/bT1eTEsTmfpO4TUveKPsBFyRf8k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794190511; v=1; x=1794795311;
 b=Xa1Jr9pqz1vr1rqOZrFS0+WmpycF+gQF5QftMAeWPB9sFvpuO4IeHLZLxsBioaslsF2tXWUH
 64HHIz9xOEMmMctAASxPTKtUGNKqcuxlQSNGlNGKU7HN3Yecn/SoQRS9vWLWaKb2FzCUZ5mPR+3
 aEOTp+nUxZJiQVqxrg2/+1F4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e4b351546fe3877f;
	Mon, 09 Nov 2026 02:15:07 +0000
X-Mizu-Trace-ID: e4b351546fe3877f
X-Migadu-Flow: FLOW_OUT
Message-ID: <65d109ab-3dca-4521-bc1d-bb1f8810bb14@linux.dev>
Date: Mon, 9 Nov 2026 10:14:57 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/8] selftests/bpf: Remove sockmap update from
 bpf_iter_unix
To: Michal Luczaj <mhal@rbox.co>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Eric Dumazet
 <edumazet@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen
 <jiayuan.chen@linux.dev>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20261107-sockmap-update-limit-iter-v3-0-7c0bad1ad036@rbox.co>
 <20261107-sockmap-update-limit-iter-v3-1-7c0bad1ad036@rbox.co>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261107-sockmap-update-limit-iter-v3-1-7c0bad1ad036@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/8/26 1:58 AM, Michal Luczaj wrote:
> BPF iterator programs that can update sockmaps will be limited to
> iter/sockmap. Remove the update from the unix selftest.
>
> This reverts commit 997b8483d44c ("selftests/bpf: Extend bpf_iter_unix to
> attempt deadlocking").
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>



Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


> ---
>  tools/testing/selftests/bpf/progs/bpf_iter_unix.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_unix.c b/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
> index 3061b148f338..90beada0386d 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
> @@ -7,13 +7,6 @@
>  
>  char _license[] SEC("license") = "GPL";
>  
> -SEC(".maps") struct {
> -	__uint(type, BPF_MAP_TYPE_SOCKMAP);
> -	__uint(max_entries, 1);
> -	__type(key, __u32);
> -	__type(value, __u64);
> -} sockmap;
> -
>  static long sock_i_ino(const struct sock *sk)
>  {
>  	const struct socket *sk_socket = sk->sk_socket;
> @@ -82,8 +75,5 @@ int dump_unix(struct bpf_iter__unix *ctx)
>  
>  	BPF_SEQ_PRINTF(seq, "\n");
>  
> -	/* Test for deadlock. */
> -	bpf_map_update_elem(&sockmap, &(int){0}, sk, 0);
> -
>  	return 0;
>  }
>

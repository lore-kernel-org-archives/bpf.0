Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.165
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795761219;
	b=qZ2o5piPALjpyye41AfsiTtf/FYf2UslhJaxD54jsOcSsYBDycBzwkmw08aT0cevxqP5
	 Sxi4QsEWcbFO5EuACAdxRylHcQwNjeXZZjhilFl2ZG5lzpPpfOQpx/jZlqjLubAKUTJrU
	 PKwKSSYnWr6FC/WIPz7mMHn4QYUs5lh1D/ICCTIpGYY624/4R7eazr8VA5XmI1A88K4yF
	 +pplYsoi5oNvZe6wlp8Om3DFE6Xpujvx64I4DZkYXTHAoWvW3CmpJKTjZWfwc20hvHKUr
	 jnCMQeb2FG6HilEGrIhoo8onGjDVggENUlgI1gwViGkNAD18QNQJGj5lfRUUX6kEeYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795761219;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=6LC43k933l8Ek/GrSPWgwkIQo2nW1+6+OwznWt8NdeU=;
	b=aTB3m/zuW5EbXo1SHSNgWlnzthpqL1SRvnbJ1edj4NwgU8pDwekrAuj5eQP95Aj910hB
	 BYICxsm95WlUw0YnQKDMO+BrsEQbaxusBUIdF9gd6yd4VQwV0RLXKL0z00Klc1MVK8RLc
	 wfLF6sUxuX26KeTC5B5Ww6zAtCPlYEc+jFDjtkGa2IS5I1+KFdZkC92Z1eLkiJckxWk6f
	 CbDBRL3RBmxCJZ6Oh+5nKbwT2doYBCMeoWNhQvlqwh7v1+1sQVyPPjU6KTCeQgH73a3W+
	 NujkvPqdnhUMlr0ZtC8u6/hPiQzy2A8U0wVJkcjuTkfkXpaoVrlevYBjvsFhg5dUFnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Pyc4YtWB;
	arc=none smtp.remote-ip=91.218.175.165
Received: from mta0.migadu.com (out-165.mta0.migadu.com [91.218.175.165])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F11606A32D
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 06:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85F11606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Pyc4YtWB
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Aqo9Gh/z13+vrH5nhABhxwXDDFLj9lawY51vL3ULqrs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795761215; v=1; x=1796366015;
 b=Pyc4YtWBMb+uDyjRZFohccHRXDcqxjekMGI9XBuOksTtl7RsTdQSl90YeRagfq6ustsfEyj9
 RXxSbMkwBQgQSKiCwi2CDTcdMz72XIz3prRT/9iFhHufQspLXgM2e/yR5BFUF99cVMJIl7Yeejd
 l3jHHduYcvGqugwctNqkEQD4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bf87ac2432157dd5;
	Fri, 27 Nov 2026 06:33:35 +0000
X-Mizu-Trace-ID: bf87ac2432157dd5
X-Migadu-Flow: FLOW_OUT
Message-ID: <bffee809-2992-40eb-97c7-72d919de0aed@linux.dev>
Date: Fri, 27 Nov 2026 15:33:15 +0900
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
Subject: Re: [PATCH net-next v1 0/6] net: avoid stack canaries in TCP/IPv4
 fast paths
To: David Laight <david.laight.linux@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Matthieu Baerts
 <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
 Phil Sutter <phil@nwl.cc>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, mptcp@lists.linux.dev,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20261124130631.1886963-1-xuanqiang.luo@linux.dev>
 <20261126102058.1fecf50f@pumpkin>
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
In-Reply-To: <20261126102058.1fecf50f@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026/11/26 at 19:20 David Laight wrote:
> On Tue, 24 Nov 2026 22:06:25 +0900
> Xuanqiang Luo <xuanqiang.luo@linux.dev> wrote:
> 
>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>
>> With CONFIG_STACKPROTECTOR_STRONG=y, a function that has a local array or
>> passes the address of one of its locals to another function needs a stack
>> canary. The canary is set up and checked on every call, also when the
>> local is only used on a path that almost never runs.
>>
>> This series removes the canary from functions of the TCP/IPv4 fast paths,
>> by returning results by value, by using storage that is not on the stack,
>> or by not calling a function that has nothing to do.
>>
>> Patch 1 returns the two mptcp_space() values in a structure, so that
>> __tcp_select_window() no longer needs a canary.
> 
> While all (I think) architectures can return a big integer in two
> registers (dx:ax on x86), not all ABI do the same for small structures.
> For those architectures returning a struct by value is implemented by
> passing the address of a hidden on stack structure.
> So code generation may be worse than passing the values by reference.
> I can't remember the list of architectures, mostly old ones - but not
> 32bit x86 because the compiler option was set when regparm=3 was added
> for 2.6.
> (Note that this is different from passing small structures by value.)
> 
> David

Hi David,

Good point! thanks for bringing that up.

The small-struct-by-value pattern in patches 1 and 4 follows the same
approach Eric used in commit 7a4cd71fa451 ("net: add
vlan_get_protocol_offset_inline() helper"), which returns a 2-field
struct vlan_type_depth to avoid stack canaries in callers.

I did note the 8-byte struct ABI distinction you mentioned:
- On the main 64-bit targets (x86_64, arm64, riscv64, ppc64le, loongarch64)
   as well as 32-bit x86 (with -mregparm=3 / reg-struct-return), both
   8-byte structs (struct mptcp_space_info and struct skb_coalesce_res) are
   returned in registers and the stack canaries are dropped cleanly.
- On ABIs that return structs (> 4 bytes on 32-bit ARM EABI, or any struct
   on s390x) via a hidden stack buffer, it indeed falls back to a hidden
   pointer. Even there, the callers previously passed *two* pointers to
   locals (&space/&full_space in patch 1, &fragstolen/&delta_truesize in
   patch 4), so passing one hidden 8-byte return slot should not be worse
   than before, while keeping the code cleaner and type-safe.

That said, if maintainers prefer packing the two fields into a u64 so that
even 32-bit ARM / s390x return them in registers, I'd be happy to change
patches 1 and 4 to do that in v2.

Thanks,
Xuanqiang

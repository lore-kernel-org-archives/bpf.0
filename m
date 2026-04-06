Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C1D2C15B5
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 02:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775444378; cv=none; b=eas8ut7V+g+5IFlSfxHEuNxPzR7bB18ysne37msN1kShJ+KHFZEF9VGFfVKdKvjIR8hxFjf3Vzx3znm4G496LJfx/V6OF/xlJnvgTYC/VBBhH3Svb0TusIJiYP/D1FWlAdo5L1vnDmUzXCud20cDek5CMgu8+L5SuNFDuQxNz5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775444378; c=relaxed/simple;
	bh=NEjNx16X3MvrbK8jLNLSnKWkbI4CxRfzz8rCKoiMhYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g3AifrDBNi8+6TMegOSYJYw/mU1AvRgXlSWjIUIGkI8HDKu1amgtVPA+8CLeDXLLspX72pbK6eLDiowU9DXEgSF+AApU5CHvZkRxfXZbj6LXPGZlD3kgbkho4u5BLGLUEAcw579t7cmMjGtZ2YkRX8W4zcSqbMaF2CjZYHmvs48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rPM1uad7; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rPM1uad7"
Message-ID: <346597fc-1703-45d7-bcef-55f5d4a7579c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775444373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=67hA3OliRUcWeRg8i0BeGw487zxvix2e4GTW3l9b4HI=;
	b=rPM1uad708uPb3invdA5OX4dYmQkrrWyi7Hmf+JSTIzvhx/GBdbohacnaGfkfMOQ1QyxJN
	482g7pFD7xNrcdd6mJEZe4cjjbEic0nEmpIx6zLj29T+FHovMhlskf2mnOk6Q35/ET8fMG
	tI+ilWhhYrRVIZqyApyjsRwS02msv98=
Date: Mon, 6 Apr 2026 10:58:56 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v1 1/2] bpf: Fix SOCK_OPS_GET_SK same-register OOB
 read in sock_ops
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: Quan Sun <2022090917019@std.uestc.edu.cn>, Yinhao Hu
 <dddddd@hust.edu.cn>, Kaiyan Mei <M202472210@hust.edu.cn>,
 Dongliang Mu <dzm91@hust.edu.cn>, Martin KaFai Lau <martin.lau@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260404141010.247536-1-jiayuan.chen@linux.dev>
 <DHLMGWNKBI4K.3LM87NOU4XB3O@etsalapatis.com>
 <DHLMKFBINRKW.BS0BEK9AMU86@etsalapatis.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <DHLMKFBINRKW.BS0BEK9AMU86@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/6/26 7:54 AM, Emil Tsalapatis wrote:
> On Sun Apr 5, 2026 at 7:49 PM EDT, Emil Tsalapatis wrote:
>> On Sat Apr 4, 2026 at 10:09 AM EDT, Jiayuan Chen wrote:
>>> When a BPF sock_ops program reads ctx->sk with dst_reg == src_reg
>>> (e.g., r1 = *(u64 *)(r1 + offsetof(sk))), the SOCK_OPS_GET_SK() macro
>>> fails to zero the destination register in the is_fullsock == 0 path.
>>>
>>> The macro saves/restores a temporary register and checks is_fullsock.
>>> When is_fullsock == 0 (e.g., TCP_NEW_SYN_RECV state with a request_sock),
>>> it should set dst_reg = 0 (NULL) so the verifier's PTR_TO_SOCKET_OR_NULL
>>> type is correct at runtime. Instead, dst_reg retains the original ctx
>>> pointer, which passes subsequent NULL checks and can be used as a bogus
>>> socket pointer, leading to stack-out-of-bounds access in helpers like
>>> bpf_skc_to_tcp6_sock().
>>>
>>> Fix by:
>>>   - Changing JMP_A(1) to JMP_A(2) in the fullsock path to skip the
>>>     added instruction.
>>>   - Adding BPF_MOV64_IMM(si->dst_reg, 0) after the temp register
>>>     restore in the !fullsock path, placed after the restore because
>>>     dst_reg == src_reg means we need src_reg intact to read ctx->temp.
>>>
>>> Fixes: 84f44df664e9 ("bpf: sock_ops sk access may stomp registers when dst_reg = src_reg")
>>> Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
>>> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
>>> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
>>> Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
>>> Closes: https://lore.kernel.org/bpf/6fe1243e-149b-4d3b-99c7-fcc9e2f75787@std.uestc.edu.cn/T/#u
>>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>> This patch only seems to fix the problem when dst_reg == src_reg.
>> Why is this not an issue when is_fullsock == 0, but dst_reg != src_reg?
>> In that case the dst_reg is unmodified by the whole macro but is still
>> marked as PTR_TO_SOCKET_OR_NULL. Isn't that a problem? Can you add
>> a test case for is_fullsock == 0 but dst_reg != src_reg in patch 2?
> Sorry for the double post, but also check sashiko.dev:
> SOSK_OPTS_GET_FIELD seems to have the same issue as the
> SOCK_OPTS_GET_SK. Can you add the same fix to it?
>

Thanks for the review!

The AI reviewer's observation about SOCK_OPS_GET_FIELD() is correct —
it has the same bug when dst_reg == src_reg and is_locked_tcp_sock == 0.
I've folded that fix into patch 1 in v2.

Regarding dst_reg != src_reg: this case is actually safe. When
dst_reg != src_reg, fullsock_reg is dst_reg itself, and the generated
sequence is:

LDX_MEM   dst_reg = is_fullsock
JEQ       dst_reg == 0, +jmp
LDX_MEM   dst_reg = sk

The JEQ only branches when dst_reg == 0, so dst_reg is naturally
zeroed on that path — no extra MOV_IMM needed. The same-register bug
exists precisely because dst_reg == src_reg forces the macro to borrow
a temporary register for the is_fullsock check, leaving dst_reg (the
ctx pointer) untouched.

I will add a get_sk_diff_reg subtest in v2.

The other suggestions (moving the detailed comment to the BPF program
file, avoiding vague "the fix" wording) are good points — addressed
in v2 as well.


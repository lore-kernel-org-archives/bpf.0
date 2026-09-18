Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35573515DC;
	Fri, 18 Sep 2026 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789720940; cv=none; b=fAClXYJTTUjdMJLq9lJos14Su8t/hNHFIgulgLMstn2MVjiCdAn7xUfKY4JgceDD+3Oxx4d94nA5xjjXxAdMFgQPf6INSRXLkLuWrB2eN6FaiyoTrkjCQE/bi1yNVIcMt41oaKUJ63PflbqXig3LOPjqDHzUt9Wg5+rNw//dawk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789720940; c=relaxed/simple;
	bh=UkGF0YC33byALLEuGDa275w43y143/p2k+lrlu7VXN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QdF5sH/rewFzEprcdIQrQiYrucgxp6FbQSacfGq2paKceSIlBKp1oj7v/oeTMKcW/1ZrPoQarKTkSDjwafEgZIT/N3pYk44XMLxNINJRhWdDotPTNV9/mGT8PPwih6y7Mq7BFsnvGlNmM/s/9C6q7HCR+yE9yZoiH59HAXpbLS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFcF+liK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFcF+liK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DDD1F000FF;
	Fri, 18 Sep 2026 08:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789720938;
	bh=ZcbrHI4XgWy/MfG8S7unCzAqZb7eoZaFhNOWmRY/mzY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=eFcF+liKLTFrLBEUKEESNxnl+R3l971/THfnnofiMbhgnpEH74SusvDZRQ/78mpA+
	 wTwL770+TKj5YcmOdhOIXK6pzCYWOUl8L7C6GV90U5NynC2vsvwamkvDpMVVsSCm5V
	 uMLLk96FjK8VOenhv5LigN/V8ZDEBzgIKiKA4esAmK4/tXL0BhZJdv++m8zutYRZZT
	 dTw6q9eiYZsp6opTHGSjKwwdaWLaxBNIDY7ldzb1A+e4xe+KNUPG/pKgiRGh0uXN8r
	 KnJ2xRz7BboGPmhDQeCyK3B+irsNKIOAjGJvL9W0VLLWr3uJyDq/0RxT85d05ANtQJ
	 lQjbAW1O5Ypmw==
Message-ID: <e54401aa-9dcb-433e-bdd9-ca3fc4f3865b@kernel.org>
Date: Fri, 18 Sep 2026 09:42:14 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/3] bpftool: Compute light skeleton ctx.sz
 without relying on links
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Leon Hwang <leon.hwang@linux.dev>,
 Emil Tsalapatis <emil@etsalapatis.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260918040919.3402577-1-tweek@google.com>
 <20260918040919.3402577-2-tweek@google.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260918040919.3402577-2-tweek@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2026-09-18 14:09 UTC+1000 ~ Thiébaud Weksteen <tweek@google.com>
> When generating a light skeleton, gen_trace() unconditionally sets
> skel->ctx.sz using (char *)&skel->links - (char *)skel. However, if a
> BPF object has no programs and no struct_ops maps (prog_cnt +
> attach_map_cnt == 0), do_skeleton() omits the links struct, causing the
> generated skeleton header to fail compilation.
> 
> Compute skel->ctx.sz from the end of progs (if prog_cnt > 0), maps (if
> map_cnt > 0), or ctx instead of relying on skel->links. Also remove the
> unused opts.data_sz argument passed to codegen().
> 
> Fixes: d510296d331a ("bpftool: Use syscall/loader program in "prog load" and "gen skeleton" command.")
> Signed-off-by: Thiébaud Weksteen <tweek@google.com>
> ---
> No changes since v2


In that case you're welcome to keep my ack from v2 :)

Acked-by: Quentin Monnet <qmo@kernel.org>

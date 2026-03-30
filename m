Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1A4372B2C
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 05:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774849109; cv=none; b=EUnbHeBl7IlrBzw/mWKFCZxHcc3eWa/wKRBNgfohG1Adk5Za0bsUVxBrsWIOjiJnsKi8oJNyEuJk3q26//zq1nMhsPo9uX1ruW5jU5CbgbecVDQqe0itPVezl4jMY1yyVtjvehbEMtQhPF7fH0kJkJ9dLvk1CNlc7gfQR2VeUlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774849109; c=relaxed/simple;
	bh=4A2AmJQeheBGu1UUWZvKo0KEJ8O2rjA+fqDcDhvkjoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sLdZhDgQNgIedtWk6HR1d11xELe3ikvBt9vJtDPCTorT19DEJg8p1Prv1jXd5GjVgg36gGffl84UJwUde4bEJI8UpDgMqnNzaaW+K/VyS0uiENcmVL2g9CYpCGkY4YbzMkOiqfXUqXos+A/c+Ya0jjKpBkw11Sh6PxX47LJkZ/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xoo7RXtf; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xoo7RXtf"
Message-ID: <d19336f5-5373-483e-81e4-326aa9c7801a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774849096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UC7S6U4jkOT/S8tS6bcCxKzTr/oSR5FCgpqhFk2yhAE=;
	b=Xoo7RXtfW4czjwrYwYEInXmup/OoUumSjHfDqyung9Hn/WQP8cke2hIqrx69GDI1lwq8QC
	VctjyY4W9U5BWLQHReR9Uk98vzOdShNHcX0jNQXMG96YmH5pLaJGCf8MflAKKufaLIyKqC
	MRwEv3UZzn5ZPft396W67SkI0EpKoVY=
Date: Mon, 30 Mar 2026 13:38:06 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Fix abuse of kprobe_write_ctx via
 freplace
Content-Language: en-US
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Feng Yang <yangfeng@kylinos.cn>,
 Toke Hoiland-Jorgensen <toke@redhat.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
References: <20260326141718.17731-1-leon.hwang@linux.dev>
 <20260326141718.17731-2-leon.hwang@linux.dev>
 <CAPhsuW7vwp6pW5RntKC+Gbn5gTcVg3vsm6LVc-y2ssTeauZayA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAPhsuW7vwp6pW5RntKC+Gbn5gTcVg3vsm6LVc-y2ssTeauZayA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 28/3/26 05:39, Song Liu wrote:
> On Thu, Mar 26, 2026 at 7:17 AM Leon Hwang <leon.hwang@linux.dev> wrote:
[...]
>> @@ -3733,6 +3733,11 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>>                 tr = prog->aux->dst_trampoline;
>>                 tgt_prog = prog->aux->dst_prog;
>>         }
>> +       if (prog->type == BPF_PROG_TYPE_EXT &&
>> +           prog->aux->kprobe_write_ctx != tgt_prog->aux->kprobe_write_ctx) {
>> +               err = -EINVAL;
>> +               goto out_unlock;
>> +       }
> 
> This also blocks uprobe+freplace when prog and tgt_prog have different
> kprobe_write_ctx, right? Is this the expected behavior?
> 

Intuitively, yes, this also blocks uprobe+freplace.

However, how can we distinguish uprobe/kprobe here?

At attach time, uprobe/kprobe is recognized by the target perf event
flags instead of BPF prog's expected_attach_type. Thus, we cannot infer
the use of prog by prog itself.

If we can distinguish them here, I'd like to do it.

Thanks,
Leon


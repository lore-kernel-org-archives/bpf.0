Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365F434CFA7;
	Fri, 16 Oct 2026 20:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792181308; cv=none; b=hBXbhnT+MBeYaVsXx6PBMh1puuljwpLuqqQNo0oPPuQIfHousQ6opdtJe9iZxpPmGtpanX3nWJMN8fFGqWjEC6dRL0GifjWASIs5QIuUJTjScHGv4tUNmtH9Cg2m2heyU44UpILO3bJaJY4EcuDpcHw632bp15NyIDejice8Yn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792181308; c=relaxed/simple;
	bh=SMibgxvZhdi4jqVIx3qvhpOUW6NsOtaHTumouZfcSfI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Kle8rM7BE8gR8MxksM4UaP/mVucK+Az2Ua5kLItDcTqA+4nIK2WoJMGNjxVALBC5n+DWqT94w3fKqz1PVfsHi2PzwXZPGWj89lUEeKIM+ZgbNWUVTNW7lqU/m4BIQm284j3KvkURTtUvtszLc+cIrdRyIu/Qkww7urVcQyAUv0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNLprhJ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNLprhJ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB881F000C4;
	Fri, 16 Oct 2026 20:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792181306;
	bh=+o4i2xp6uDTkn8JIM376bpUhzetYxeCnxwxfCtEKmfI=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=SNLprhJ2OibLzw+7WP2mS5Ui0dpJAS3jwJqMT7YW5AVlNQPS6s0+lW3rO343UcsM9
	 y3+1AAi8ukoiXHQ9MPcM7raQUUXmwBooxYcb+/k6KZthBlCKWr1dju/FwWi4CyX1dc
	 QDIinjS72HJ3iacd8Gqg3JbxSkA/Ka/I+snYczyDORS7OzjNH1zUyMnBlmUfd82qnf
	 9OxSnMb+lFf7rlPnI1Q3bKfRU+/SnRgG/51ucn/cl17INTjxuMM7nP1I36ZhH8zid4
	 YTdWWcRx92MEizh+xlpbtJqWkdNuji6whZNotuKBy8q1J226RzLXCili4VmUOzRmwR
	 a6K0Ft/DrTOtQ==
Message-ID: <bcab1d31-7103-4f29-9078-8683c3d4e3ae@kernel.org>
Date: Fri, 16 Oct 2026 21:08:21 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH bpf-next v5 1/3] bpftool: Print ENOTSUPP as "Operation not
 supported"
To: Maxim Skokov <skokovmaksimevg@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, kuba@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, hi@tychen.cc
References: <20261016194825.230433-1-skokovmaksimevg@gmail.com>
 <20261016194825.230433-2-skokovmaksimevg@gmail.com>
Content-Language: en-GB
In-Reply-To: <20261016194825.230433-2-skokovmaksimevg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-10-16 22:47 UTC+0300 ~ Maxim Skokov <skokovmaksimevg@gmail.com>
> Some BPF commands return ENOTSUPP (524) to user space: iterating local
> storage maps, element operations on ringbuf maps, creating an LRU hash
> map without preallocation, freezing a struct_ops map, or running a
> program type that has no test_run. ENOTSUPP is kernel internal, so
> strerror() only gives "Unknown error 524":
> 
>   # bpftool map getnext pinned /sys/fs/bpf/sk_storage
>   Error: can't get next key: Unknown error 524
> 
> Add a small helper that knows ENOTSUPP and use it where bpftool prints
> the error of map create, map element operations, map freeze and prog
> run.
> 
> Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
> Assisted-by: LLM
> Signed-off-by: Maxim Skokov <skokovmaksimevg@gmail.com>

Acked-by: Quentin Monnet <qmo@kernel.org>

Thank you

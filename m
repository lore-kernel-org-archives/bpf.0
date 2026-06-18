Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28E240D59E;
	Thu, 18 Jun 2026 22:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781820381; cv=none; b=FNwldfXDgo/vA9isOHr52UwK+4MAUmYvwf0hTVjyS0z3KQfyWYfYoxHhE6PTxSHEukTi8L6ZYqaZgidFRJxlZB18FMIDl3dfDLO3AXzDy+2zXMj1qItaTnnoUV/aAxN4nsIp8YvUrvHzQI9ku9Nx9bBFlK/DZE+Bbb9dvdmKmgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781820381; c=relaxed/simple;
	bh=BCfA7OUEjiIo7vlte14H45PN5VLooei0zGsciPqMa0U=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type; b=fQQo1XBLjZ0QGteb6xdcdA3D9JKj80odw33yIC+W11NnnSShvvTmfjEc+MOuWqt4Q+qAGVmWBz1k2DrX3EyeE7rHOLn8pRABNj2xlSn5w9eEsGRM422NDyjzOJC/Qa7/BnaAO9ZUVDCEeBMayO7m7AQiehSJHuMkSs17TH1O2bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhXMHD6H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhXMHD6H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1C51F000E9;
	Thu, 18 Jun 2026 22:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781820380;
	bh=I1JwEoDsa4qC0Sw9IhYIPA2L5ZiNGXjDJdUzPXpJ/xo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KhXMHD6HniAs9rx53B6jB+11bDRRGTl4bd9I+EvQUHueKGEBA9kWbQZHGhBydl8nq
	 RZSQ/kqbqlYT7O5pDkV7WmA9dIq4RKyJUTOY8SGktYzB/G4Gxu/2SRLvEh/G8Ca7bm
	 LPw6lAIYxFiFkgaE3kdTr2aS8d8ya0f5RewdxPzDfv2j09a7ioxqqwU/p6BCP0+N9L
	 PTbc6roPtiqfpJ3noFJTekWl/2pFORk8gYYLDfw3L+T5DVnLAO8UQnnSt8h3NyDrlL
	 2YAPZ1JOKrPfEkiBXr3EeGgZyBmSo5Bpba8cPFKNQ8OzdHJ5KgIfrrNaPsE+MjGy/Z
	 S1HlM9b+uIsOQ==
Date: Thu, 18 Jun 2026 18:05:31 -0400
Message-ID: <e46ccf4915a3358e42a372643eafa4b9@kernel.org>
From: Tamir Duberstein <tamird@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>,
 Andrea Righi <arighi@nvidia.com>,
 Xu Kuohai <xukuohai@huawei.com>,
 bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 Andrew Werner <awerner32@gmail.com>,
 Zvi Effron <zeffron@riotgames.com>,
 Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH bpf 5/6] libbpf: ringbuf: Prevent missed wakeups
In-Reply-To: <DJBYY5JF4YBQ.2QJVU2QKJ16N2@etsalapatis.com>
References: <20260613-bpf-ringbuf-fixes-v1-0-e623481cb724@kernel.org>
 <20260613-bpf-ringbuf-fixes-v1-5-e623481cb724@kernel.org>
 <DJBYY5JF4YBQ.2QJVU2QKJ16N2@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Thu, Jun 18, 2026 at 02:41:54AM -0400, Emil Tsalapatis wrote:
[...]
> Sashiko is right on this, let's use regular kernel style for new
> comments.

Done in v2.

[...]
> The extra new variable feels overly complicated. I think this is
> becuase the new code is going off of the got_new_data pattern, which
> imo is also unnecessary. We should just remove got_new data and just
> do:
>
> while (true) {
> 	prod_pos = __atomic_load_n(r->producer_pos, __ATOMIC_ACQUIRE);
> 	if (cons_pos == prod_pos)
> 		break;
>
> 	while (cons_pos != prod_pos) {
> 		...
> 	}
> }

V2 removes `needs_wakeup` and leaves one fence after each batch that
advances the consumer position. I kept `got_new_data` because the
proposed unconditional outer loop would retry the same busy record
indefinitely. The revised loop retries a busy record once after
publishing progress and returns if the record is still busy.

[...]
> We just add an smp_mb() here. And since AFAICT smb_mb is available
> here, we can also avoid the move from smp_* to __atomic in the
> previous patch.

I kept the compiler atomics because `smp_mb()` is not a portable full
barrier in the tools headers. Only x86, arm64, and RISC-V define it
directly; the generic fallback can reduce `mb()` to a compiler barrier.
A single `__atomic_thread_fence()` after each batch orders the preceding
consumer-position stores without a full barrier after every record.

[...]
> Why __ATOMIC_RELAXED here? Maybe just declare the variable volatile
> and do regular reads?

I kept the stop flag as a relaxed atomic because `volatile` would leave
a C data race; the flag needs atomicity but no ordering.

[...]
> Label is unnecessary, just call break;

Done in v2.

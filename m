Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F574AE10E
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595849; cv=none; b=lGk5GlREq/Fxyg1pFASY/9Gx94CMEfQ+xu+bQb1Q4qpOoRCAEg/2eGHncp0reezkaUBOmgN18M0TcGd+NeOA7wCjYW1DvrqM3Wvbp9feKOH+NRD25pl9xrEYWSE9xfZgxYAvU+AIKjZso7Z6zp/uVIY9EG3cXhO8y0iGgtKrgyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595849; c=relaxed/simple;
	bh=cin3DA6LiiavF71OaCw7ERldYl18r+ePcBDy/rOokZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSzqkLy86VfE5BiLDe6JAPYP1hWG+/BgDprOn7ViftUowN0or+o+nxRxW6V2soRtUyKg5KD2v/It33z7dth0uX9TtmoVcj7p5x2eZN9n2Qyjix6qpbbXZ3viHJT1Qa46NbtG7/griqTnIYxLM54zQcLPnLZwY3HTyGueBArDTwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bobrowski.net; spf=pass smtp.mailfrom=bobrowski.net; dkim=pass (2048-bit key) header.d=bobrowski.net header.i=@bobrowski.net header.b=NnqQ7GA1; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bobrowski.net header.i=@bobrowski.net header.b="NnqQ7GA1"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-39b2ad83dc6so1909882a91.0
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 04:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobrowski.net; s=google; t=1790595847; x=1791200647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mM0tUwt9blVsQ5lfP9VYBXJMfXAVsYP/kX/KBYmBv4Q=;
        b=NnqQ7GA1r7wYXuKWAQSR708sRw2nmPDhhOLjAcaLlS5Vag0uGBZB/AwRKx89U4dM7U
         0JJdoYsiWPvndg0hJWobjakfItElaJafFlPAXnl3MAYUXuvms7YFC/PqzPmMOPGGupHH
         pxuQiNOIq8TOI2/OcJiM1wljGExsmHTUdoT1qQkXi3y7ELRlIs0dU8lp5SUEn5uuLnH1
         A4p2beU4wz/M7iH9hRUystlfkGOw4/VxrDDoJK/m15Wy6iJ22w6VTx+UxHImPYLW4icI
         vtlGY0RNqJWUP8GH92PezqzxdpZgBOYo5l6owF6toVj6TIoefBaN/d9kwZJgmG/yPl1i
         roXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790595847; x=1791200647;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mM0tUwt9blVsQ5lfP9VYBXJMfXAVsYP/kX/KBYmBv4Q=;
        b=Y9TAHvuX8jKNVvKTRpcaRRyuvNw7unvwExtAB9zoOCe7bHwaprG4J4ZTfxzWaVITna
         wHIrqzk1W5nM1YWovN2HLcOMcvYkPNYBY5Ds2vbFflYueN4TFV3KOb7JbChG0/cpF1Ym
         ckZ5dK8noIyBm7P/k6v6Iz3vfazNy90uaaB9HYi518sJgDDfdZIJwjlT7U1fb1i12dCL
         bwg9hWX6Be7TB6hlOel62lRwKehv9tBsgJG86WH0D3es/cH5Z8+ceYS4JylljUu8CCsY
         bW0F3JAuzlYPnjWCyuY05Ix8SEAdCsagJkQ3FabzvrjR2h1+E5ttsawF9QO3/1IB7gyq
         0Hfw==
X-Forwarded-Encrypted: i=1; AKwUvBxvgGsJQ/WS1LYUbmZwsM+ABFuoYXyXJ4JoMNn4tOCANze7VdTkDj7YesJZzHJ6HTTV8Uc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJbyTDuZSesTuoXymfFWpYDQPpb50EU2Ha0KLtek74HR7UpmyId
	PKdHLxQQ9o9wnN3ToQVqBhIeyEQ1jdNVLanxR96rHxTfhIzArpRIPJRWcw/SJuVTRoAl
X-Gm-Gg: AYBFou3cMY3NCCGvYZjj5n1+9ptcmEnKDebjQSs4+M5HbgvN435zWypjWS/NE0FBoXq
	S8N0heMDFymOOaQz8lVTNFT/g6xTBpHjs+tR2veqiw/gMbwqCelFjc+PIhD1hbdkopnzfdxr4wt
	ox8gWVvCNY5AkO00FAOYkQidIXtu58b0c91Md2/RxeJYNmrhWwpocdjbRQH9gZWA+JQq5R70E+f
	ze3sI+6r8sHjpcGxX4ZTnSir4B8ouDZ1EaJP27PlZL9iZxgkO3qYQfs+FePx5gi8+Vm3Bja76sw
	6EIYI+JfmAze0JV49HKF9GCzW8woFNCP3ThQ/6BoEAamCeg0sYRzjJlZzVNN2a13zxDSYvAJwde
	cMuAsQ1G/AojVmFdaqXMCILJcCEyiaGluF2pAObnlD7ysdFXhEs+5jAi7Vp22YTw/ab4GxC0QJT
	jkK81dWMjnol5P2GoLUGfIKaEAqHOmfIQ/vga1Nhq/SW1qR9Qe1KioqXR7lNpyMOifRo7vec2yq
	obBRSpfHj9SHnuYnI7X4+xajYLABDTMpIlQzOewxjsQ8Y59ZNDFT7ZeVZXC43w=
X-Received: by 2002:a17:90a:e7ca:b0:3a0:e4ce:320f with SMTP id 98e67ed59e1d1-3a0e4ce6d0emr5463799a91.9.1790595846977;
        Mon, 28 Sep 2026 04:44:06 -0700 (PDT)
Received: from lima-development (163-53-146-100.ip4.superloop.au. [163.53.146.100])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b498fb12sm8196746a91.0.2026.09.28.04.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 04:44:06 -0700 (PDT)
Date: Mon, 28 Sep 2026 21:43:53 +1000
From: Matt Bobrowski <matt@bobrowski.net>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiale Yao <yaojiale02@163.com>, KP Singh <kpsingh@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Roberto Sassu <roberto.sassu@huawei.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] bpf: Initialize IMA hash helper output buffers
Message-ID: <arpS-YZMmwRN0oUT@lima-development>
References: <20260927121400.1188165-1-yaojiale02@163.com>
 <DLQS1EUNZG5T.1ZCONM8DQM45@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLQS1EUNZG5T.1ZCONM8DQM45@gmail.com>

On Mon, Sep 28, 2026 at 07:38:57AM +0000, Alexei Starovoitov wrote:
> On Sun, Sep 27, 2026 at 08:14 PM Jiale Yao <yaojiale02@163.com> wrote:
> > The output arguments of bpf_ima_inode_hash() and bpf_ima_file_hash()
> > are marked as ARG_PTR_TO_UNINIT_MEM, so the verifier considers the full
> > range initialized after either helper returns.  The IMA hash functions,
> > however, leave the buffer unchanged on error and only copy the digest
> > length on success.  A BPF program can therefore read stale data from
> > the untouched portion of the buffer.
> 
> That's not a bug.
> These helpers are available to LSM progs only and LSM progs
> require CAP_PERFMON to load.
> With CAP_PERFMON the verifier allows reading uninitialized stack
> with or without the helper call.
> 
> Since commit 5da4a9f26fca ("bpf: Preserve stack initialization for
> generic output buffers") MEM_UNINIT helpers don't have to write
> the whole buffer.

I suppose it's also worth noting that the return value already advises
the caller how much of the destination buffer is meaningful. On error,
nothing is written. On success, the returned hash_algo value identifies
the digest, and only that many bytes are written, so an oversized buffer
is expected to be only partially filled. This is also by design as
bpf_ima_{inode,file}_hash() already recommend passing a buffer large
enough for the largest possible hash (being IMA_MAX_DIGEST_SIZE). A
caller that honours the return value literally never needs to read the
untouched bytes.

With that said, this is a NACK from me.

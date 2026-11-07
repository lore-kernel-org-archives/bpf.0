Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.54.127.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794057187;
	b=I9c9yhxSePVihS62TgWxKMy3tLxLt8cPJu+6pQ2d2TMzjRhMDj6ScIvgC7XDWPUmXFEZ
	 bKRW8uWZ8efsS/PTTMo79espJXwNZJUav3mFdl0tS4F1QsZLXhpnTGe3aenbK615sXgam
	 Tg/IharZUKg/YAONLXuNcitvh/GirLy0nXIrrh7K9B0JJ70S3fFCEGiS4KrO8IV7clHHn
	 5+Bs7KApVHCgpYpRkN9xHMgZc64DR1a++bhSPvXuiEV7IukUhMhkDv3PXudmjAu8nliMv
	 vv9hIAntSOeznysQc4zbkkl5iiAoNMQ9ezSAeDBawCbmCoJeQ4j33rRHx8SrQLICKCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794057187;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-Envelope-From;
	bh=8eYCv6BK5RvT4W8fjZT8lKb3F197VD0DZTz3XVRDtgM=;
	b=0+7E2Kj815uwbR0WQQWIs2B/dyhNpiqBMC2CI/DIds5+nRZyalevyEXAbdjlJRrRCuyz
	 ZNggISx51MfGkUUhB2IyaJdd+ptYniB+P4OF819un6vYP9YKgnobjztflYZ+95186AbV4
	 Ez+k497GSfCRtdlp/6nCVNZW/F6po6w1NNeaaY6s9mEsl6TN2sE4yX1EWDqRmInwdpKnL
	 9N3dygtPOs0HUn4s4qtOncgPejSuRLfnqBxUPJMPb0a08Qeg/8ruLUlQGqvAo5tCx2vqL
	 nqejLXnOjRdohHjeochBSChU3U2X0vlq/alEs+Gzs0eHZ0f4bzCIiQKyHC4BCAbfzWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tychen.cc;
	spf=pass smtp.mailfrom=tychen.cc;
	dkim=pass header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b="WmZmfS/E";
	arc=none smtp.remote-ip=198.54.127.77
Received: from out-zbxj-a77.jellyfish.systems (out-zbxj-a77.jellyfish.systems [198.54.127.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EE9606A32C
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 13:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49EE9606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=WmZmfS/E
Received: from [10.18.116.108] (ec2-52-197-241-54.ap-northeast-1.compute.amazonaws.com [52.197.241.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4jMGgG0tBcz2x99;
	Sat, 07 Nov 2026 13:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1794057165;
	bh=8eYCv6BK5RvT4W8fjZT8lKb3F197VD0DZTz3XVRDtgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WmZmfS/Efi59PKXICsPFIg61izwlVwGRjDyiJ+7INGktvuU8J/b+vb+ubkdMFkfpW
	 zXoLr4ZQdcXHbBRDAqstEt9XYmjMfKIMiV6y+3eVITDru14q7vSdD8emdvFI/tZ6J6
	 CRWp6ab0HtN+6kb4XxVzutzg8X8ciDEeo5UXDEemA0aNc41eZy9tUQjhM1twZkmIm2
	 DBf+WscKQgXy8zmPVDtRef922vbf/djG+PvHFOpqdnQK+YHvZlXBxQ/RmIdAp8tgtC
	 uB+mF7ndcygp+yf+ccr67kzuhEPrLiMS7b8uLKumltl/O45/VmB61R2blOgP5xpRlZ
	 NYsmmbDrtsKxQ==
From: Tianyi Chen <hi@tychen.cc>
To: bot+bpf-ci@kernel.org
Cc: hi@tychen.cc, bpf@vger.kernel.org, qmo@kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, ihor.solodrai@linux.dev, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, daniel@iogearbox.net, ast@kernel.org,
 alexei.starovoitov@gmail.com, martin.lau@kernel.org, yonghong.song@linux.dev,
 mason@kernel.org
Subject: Re: [PATCH bpf-next v9 1/2] bpftool: Use batch lookups for map dumps
Date: Sat, 07 Nov 2026 22:12:40 +0900
Message-ID:
 <179405716056.245416.10251936908462372924.rhash-batch-review@tychen.cc>
In-Reply-To: <33b057d852c258c157f6aa31e45083418944efe0efaad1d72bcb5513205a67f6@mail.kernel.org>
References:
 <7a728136ad18840c94836ec1ce988f8bc2fcfb35.1793821981.git.hi@tychen.cc> <33b057d852c258c157f6aa31e45083418944efe0efaad1d72bcb5513205a67f6@mail.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Envelope-From: hi@tychen.cc

Hi,

> For BPF_MAP_TYPE_RHASH, can the kernel return -ENOENT before the real end
> of the map, so that this code silently produces a short dump?

Yes, I reproduced it with a thread deleting and reinserting the first
key. The dump returned success after printing one entry while the other
63 keys were still present.

I've sent a separate RHASH fix to return -EAGAIN for this case:
https://lore.kernel.org/r/cover.1794056839.git.hi@tychen.cc

With that fix, the existing bpftool fallback handles the race, so I've
left the batch series unchanged.

Thanks,
Tianyi

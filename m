Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981D33321A1
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 18:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683385; cv=none; b=PNoamvOgzrFLgjI0Hp5wSU8uDurBBXZN8p4GIGzF+TAaTws+fr9A4K7prLUoMxp1SMV9YExbHAw38NKwWBN+utWzoO2w5AdrCAnRZpaXDi1IIRnvJaG65zQPQrUVXeG8vmBkkIOAX27qSBIj+YNaOTUm/MeDvEHPRhF1MbyQDgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683385; c=relaxed/simple;
	bh=Nv3H5cCqNb9tntigeTYUiPA8EGy+gWRVf43Zlw0FNoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fIhwdlnFw6sIgoiCeV01vdnxiZ2R++cSF3xnKjoc9/Jw35RALC3I1avTVB58sG+t8NRsF1OY9++pOoyufuKKM/tYxEFQ5xC9iL51B+2Yb+uY3gYa/XNizzF38dA7Gr2AFdyiqnSFDd4iuBEGN/MSr2wItcJ9FeP+eat7Kyn7iCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YrxqKDC8; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YrxqKDC8"
Message-ID: <feeb60d5-8158-4d80-84cb-ed28c292a2fd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780683372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQVF+0DmAQAv7/ZYF2g7H3iWfGxmI6ESUHSW2GlDPB8=;
	b=YrxqKDC8IwalN0pn7bzFNRG0Ao7Hh1/zZsnA+HLOsbNip4CiUG1JwCdcslAGLU14nBUlti
	Z11JCOWK24CGnWyAu+H6ErqyKypnyguvY7HiCy46R1G0rHdk8EMRHcBcrJ5gU0bolIb+kq
	G8lPsYfivmt2TtcC1kEESHMkPD32nfk=
Date: Fri, 5 Jun 2026 11:15:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: reject sleepable BPF_LSM_CGROUP programs at
 load time
Content-Language: en-GB
To: David Windsor <dwindsor@gmail.com>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org
References: <20260605145707.608579-1-dwindsor@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260605145707.608579-1-dwindsor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/5/26 7:57 AM, David Windsor wrote:
> The cgroup shim runs under rcu_read_lock_dont_migrate(), so we should
> not attach any sleepable BPF programs there. Add support to the verifier
> to explicitly reject attempts to load sleepable BPF programs destined
> for LSM cgroup attachment.
>
> Without this, we get the following splat from a BPF_LSM_CGROUP
> program marked BPF_F_SLEEPABLE attached to file_open when it calls
> bpf_get_dentry_xattr():
>
>    BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1567
>    in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 34317, name: load
>    preempt_count: 0, expected: 0
>    RCU nest depth: 2, expected: 0
>    Call Trace:
>     down_read+0x76/0x480
>     ext4_xattr_get+0x11f/0x700
>     __vfs_getxattr+0xf0/0x150
>     bpf_get_dentry_xattr+0xbb/0xf0
>     bpf_prog_e76a298dac9218c6_test_open+0x6a/0x85
>     __cgroup_bpf_run_lsm_current+0x326/0x840
>     bpf_trampoline_6442534646+0x62/0x14d
>     security_file_open+0x34/0x60
>     do_dentry_open+0x340/0x1260
>     vfs_open+0x7a/0x440
>     path_openat+0x1bac/0x30a0
>
> libbpf provides a .s named section variant for every sleepable
> program type except lsm_cgroup, reflecting that per-cgroup LSM programs
> are intended to only run in a non-sleepable context.
>
> The above splat was obtained by bypassing libbpf by using bpf(2)
> directly.
>
> Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")
> Signed-off-by: David Windsor <dwindsor@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


Received: from mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57FF3F12E2
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 12:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787575469; cv=none; b=rkpi+vvIV/r0VuNhuvswkQOkA5nzFKFhEMRepJhxPXRs7Kk7EjyWMKtCIjZJi79KIPLTr0NJ1Dtbnh+cqWkG7qMFTWcfwbq4q9KYlzq5diLWFMBYWmpXPYI4ClEXPvglCcyZESZhvPkGCzE0DFDV/c2xL3Te48PUrEAk7++tGg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787575469; c=relaxed/simple;
	bh=vT3O2EFG7/yjVwFg0uSlFnkUl6zDMUcxN7qLIgRmen4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u9Mzx5ZgHyf2/+uM2TxbsqmdbvrmU9S1mfPH4CMGkePUX1yWqQdegUW5tYEVS7HKa9yBp3M6eNwb2lrWEyNaKKiATHEBtgrZC7eO71EiYHnEXzmCmgJGObX8+s4nCNgvmCtKHmIeihU67T1u+E/qdBosl+2anIFOjNBOhvJrgRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O+tkFzfn; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O+tkFzfn"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=vT3O2EFG7/yjVwFg0uSlFnkUl6zDMUcxN7qLIgRmen4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787575465; v=1; x=1788180265;
 b=O+tkFzfny4HA/lFv8f/P24sIDt3lMhVGFYRdiF20ls1wpgrPzAfrd8gPa7sPcCMUBUpYuDuF
 4LVgAp0vxLbHwFVN2z1XCGTbc6QlvOvb7/ELyUm9OHxHcTGlATzTW0D5M+8FFQjLtQYGpciY4Hm
 rEaFnCVE9AzZps8ghRgaiAkw=
X-Envelope-To: bpf@vger.kernel.org
Received: from [10.54.25.56] (222.72.143.228)
	by smtp.migadu.com with ESMTPS id 773f15d935439da7;
	Mon, 24 Aug 2026 12:44:25 +0000
X-Mizu-Trace-ID: 773f15d935439da7
X-Migadu-Flow: FLOW_OUT
Message-ID: <de12ff1b-2f7c-4efe-ba1f-95e0b8d259f2@linux.dev>
Date: Mon, 24 Aug 2026 20:44:18 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 1/4] bpf: Add a sleepable page allocator for
 map memory
To: Michal Hocko <mhocko@suse.com>
Cc: bpf@vger.kernel.org, Emil Tsalapatis <emil@etsalapatis.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20260821050250.35112-1-jiayuan.chen@linux.dev>
 <20260821050631.39784-1-jiayuan.chen@linux.dev> <aow4YNCDa0gDwbfj@tiehlicka>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <aow4YNCDa0gDwbfj@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/24/26 8:26 PM, Michal Hocko wrote:
> On Fri 21-08-26 13:06:12, Jiayuan Chen wrote:
>> bpf_map_alloc_pages() picks the allocator via can_alloc_pages(), a
>> conservative guess for BPF program context that is always false under
>> PREEMPT_RT. So even a caller that really is sleepable gets the
>> non-blocking allocator, which never reclaims and never engages the OOM
>> machinery.
> I thought one of the main motivations was reentrancy. As you cannot
> really assume the context bpf_map_alloc_pages is called from there is an
> extra care needed so that this doesn't re-enter the allocator from bpf
> program called from allocator path and deadlock.


Agreed, bpf_map_alloc_pages() is designed to be safe to run in any context.

The commit message should be precise.


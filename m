Received: from mta0.migadu.com (out-122.mta0.migadu.com [91.218.175.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3605A3A5E64
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867837; cv=none; b=Ls/RO+/e0yASfr8gL6p+iNOfJzG8Gy/v+5G8TMrg7cl2EX9MFyxbcKPX4swtauVCuGUxjbm06XtAL1VVnFHQzdfBbRZSnV2Hd0tcy48OGEFVu0WNs8vXuTMISKBPf9gyY/8YFgqC90AaplVjnedsDdVPMXHZbpPso5tqFzx2ovs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867837; c=relaxed/simple;
	bh=9oQFArQoVApJG2XOxXtlcI73PSxMD0lkExs7IJfn1Jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UiFDxq0LoAxvQ4aUmTgLHw9j+8KdOakq6juFihk/IUyODfXBnl23Xt/xmYSV1hYNTUqf0l6k0LARXC2q5SSRT8ZW7uameiJuCCKEUauPpquChrJmP0km/O16VDIIRnFUcT8c0w34144D+VM/YvJ0wFEvdF7kJyDkfZYUq12yAFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KfoRaPWj; arc=none smtp.client-ip=91.218.175.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KfoRaPWj"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9oQFArQoVApJG2XOxXtlcI73PSxMD0lkExs7IJfn1Jk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790867833; v=1; x=1791472633;
 b=KfoRaPWjhceDaTH3/PCQsRIaxZlWGFw4nmLk96AD/3JAF+newJ9skL38Euco6BupexCHCLwy
 sEjNGJMda8wXM2DaRVEG/OP1DGHiwNq5JXMDd3L3Cj4zYacLjX8m842w7le/4UwlncBTbkD9EoB
 ycY7Iv5JT99uhAKxyKsc/R9A=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bb950e30c6b294cc;
	Thu, 01 Oct 2026 15:17:13 +0000
X-Mizu-Trace-ID: bb950e30c6b294cc
X-Migadu-Flow: FLOW_OUT
Message-ID: <9d233b9f-4eb4-4550-8dfa-f56b2b6492ad@linux.dev>
Date: Thu, 1 Oct 2026 23:17:09 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] selftests/bpf: add test for percpu map flags
 combination
To: Masoud Aghasi <maghasi@disroot.org>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev
References: <20260930135753.1063495-1-maghasi@disroot.org>
 <20260930135753.1063495-3-maghasi@disroot.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260930135753.1063495-3-maghasi@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/9/30 21:57, Masoud Aghasi wrote:
> Add tests to exercise usage of a combination of flags for
> percpu hash map updates.
> 
> Before the fix, these tests fail to respect user flags combination of
> (BPF_F_CPU | BPF_EXIST). With the fix applied these tests pass.

I think combinations of (BPF_F_CPU, BPF_F_ALL_CPUS) and (BPF_EXIST,
BPF_NOEXIST) should be covered for all per-CPU map types where applicable.

Thanks,
Leon

> [...]


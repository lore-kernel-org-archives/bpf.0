Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707201;
	b=mfMlsVIJbzQyEyfIpXKqV5+N8OClQ5B0b0rWIJknsgIjsvYSI2/MwicB1xQYA9QmlV6l
	 stkBhot+ujTO1eO3RVhGnPxz1F+/e0IG+f6/k+hmspXxtYATlQA1Df8UEI9OtK04OW3GK
	 /7v/05qRhjT20GDkvmsXkHV4GzZd5VZG/syT349xDH/lHKidjwSIRh80RcWwSBdXwhang
	 0k0rklKneI85B/TMKdCIBb/zXUfcuOK1y5nAx5+WS6a04fa+MBdgzqb8TkPQ6KOekJjhY
	 SIyjB4mWlQtu0I3YuiQRhscODsNDMBtYHZ9jYsWWW1zVhuo/kWWxf0JVmkntRfp2Lnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707201;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=kRp4wRTGUX5Nc07ITKcIm26w+g1oTAepPRAIzZzp2p0=;
	b=MGVR8GIM4pH1Ah1oBe0yO6zu7mK9tDRh1kIdEVahpEAncdOOAiuvjg6sOT4vwgjCiq4u
	 3T2pxkClD2/k1HprcftGXJA3y0FZPZd0KB5aunRUnlNT9+9nh3YhztuQ1GdJTzctD6RHB
	 M7i80SJ6N4SdSD2Bym0T1vggG+7uidVjLVYxkmalZzpMD69HFMeYJtVwhgL4DBx18th28
	 +3DC6OwMbXvYrrmcQ4PiHLrDPJ94j+vJUHfkkiEJ+8ZHe1x1dl1NXrDhdBVv2X39GTsw2
	 XRlBs88I8w32UUzAWQ1+xzAjrnLg8xt8/pyfn9veYYZeDNEdUa9ZSg6rifSu2B6o1OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=E5m87UiI;
	arc=none smtp.remote-ip=91.218.175.94
Received: from mta0.migadu.com (out-94.mta0.migadu.com [91.218.175.94])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0010E606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 15:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0010E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=E5m87UiI
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mwJLewJ9zSnI5WWBwaIqRXXu8I3527mjgT72PP6DPTc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795707198; v=1; x=1796311998;
 b=E5m87UiIVTh5aopPtUryf6t8fVBmYN+bUlyQ4rnpUAZHpP9mjtBCzfgg1/lhENZlPf25of+g
 88MVClLSBrsuTUFIQhV5sF0ncqYPl7qw4rJd2umGGbPK74hH4rPDkUjp0aWQivEJV4YYMDehdI6
 UZ1g0FLlfvuO+4sOCo50a8tw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id fa146ce35f58f9d5;
	Thu, 26 Nov 2026 15:33:17 +0000
X-Mizu-Trace-ID: fa146ce35f58f9d5
X-Migadu-Flow: FLOW_OUT
Message-ID: <a3f3f62b-7642-423f-ab86-9faf6bbc0ffd@linux.dev>
Date: Thu, 26 Nov 2026 23:33:13 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-6.12.y 0/4] bpf: Fix interpreter-unsupported insns
To: Guillaume Laporte <glapt.pro@outlook.com>,
 Vincent Thiberville <vincent@harfanglab.fr>, stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261126153002.162337-1-leon.hwang@linux.dev>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20261126153002.162337-1-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

cc Guillaume and Vincent.

Guillaume, please test them.

Thanks,
Leon

On 2026/11/26 23:29, Leon Hwang wrote:
> Request from Guillaume and Vincent [1][2], backport the following commits to
> linux-6.12.y with editing the commits manually.
> 
> 9a6df65d5c6a ("bpf: Introduce jit_required flag and remove bpf_prog_has_kfunc_call()")
> f1c27922576e ("bpf: Reject programs with inlined helpers if JIT is not available")
> 34746b5a84ec ("bpf: Disallow interpreter fallback for arena-related insns")
> 7a0855e73757 ("bpf: Disallow interpreter fallback for BPF_ADDR_PERCPU insn")
> 
> As there was a big code refactoring in linux 7.1, the changes in the new
> file kernel/bpf/fixups.c will be backported to the positions in
> kernel/bpf/verifier.c.
> 
> Patch 1 introduces a new bit 'jit_required' in struct bpf_prog. The
> other patches set 'jit_required' to fix the issues.
> 
> Links:
> [1] https://lore.kernel.org/bpf/BESPR02MB12296D62B1B3F33BA21C4F24AF1432@BESPR02MB12296.eurprd02.prod.outlook.com/
> [2] https://lore.kernel.org/bpf/MR1P264MB331494502C9D13D8A9EAFB99B7E82@MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM/
> 
> Leon Hwang (2):
>   bpf: Disallow interpreter fallback for arena-related insns
>   bpf: Disallow interpreter fallback for BPF_ADDR_PERCPU insn
> 
> Tiezhu Yang (2):
>   bpf: Introduce jit_required flag and remove bpf_prog_has_kfunc_call()
>   bpf: Reject programs with inlined helpers if JIT is not available
> 
>  include/linux/bpf.h   | 22 +++++++++++++++-------
>  kernel/bpf/core.c     |  7 ++-----
>  kernel/bpf/verifier.c | 21 ++++++++++++---------
>  3 files changed, 29 insertions(+), 21 deletions(-)
> 
> --
> 2.55.0
> 


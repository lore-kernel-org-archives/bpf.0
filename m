Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795800704;
	b=oODRb7LiLZgxhloX3R+YK408+SzG5CqhA/JsoOeljM/3p5xovDtd0H3qGsvIUO43ATeT
	 3E9i8AiHHcMxeo63mP5LREZWy+tTeX9IEkUvzOsT9ozehiF0pFy2C6Vt4lQO0duniOZFD
	 8U7rGoZR9IIzqP4NSrVkLvtQV+0cXGEg9qMAHpQRO5rrFlj6d8PlietvjLlMlzfaQGVcn
	 s2elfX/Rrp2vU3SXrS6YUayf+Za56LYY8y134Psz0zGXxHl2RXPzfGeUcDXsIWwAUmR6z
	 2v0zN0vCMh4nZ1uLf4cpbsXpv6ss+W16bIrHaWWbdGt2I63iBbexGwEwqWSNaNKZXGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795800704;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=AWQWqXywBDDIWRU4zWJSNieOsk7Xn0x93AX3BFvtQ/g=;
	b=cHLXVpameWQbJTRP1b4edqPAWoUC1HSAdRO/xF88z2k+P4pFkx0DS2lLnhy6bXtGWANQ
	 f/iz4J9Upp01NyluhUgwZRNJbkY5tzoQZAm82i6owjQYE8baiMZ+3aG8ZepnNDE2EQvql
	 Co25Pd4+nU73JmYHeaTM6XBV760VisIK4rPj708gW86Y8Zp40xkOtck2g/hUP/wW+rvf3
	 f77u1UdQ4EBZ+SgSF+vAXN1RdTqyr1SRLc+rmM0BHI661UJXAw4tahMQxuzhDq1zlpnhu
	 u2yJadELyZyZtYM7H6zv9ho7OkB9OotiFCrmlb0D7Og2HypumFG2HWGzvGCf3ZcDkUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lYUJXOPO;
	arc=none smtp.remote-ip=95.215.58.195
Received: from mta1.migadu.com (out-195.mta1.migadu.com [95.215.58.195])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA8C606A31C
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 17:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FA8C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lYUJXOPO
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=AWQWqXywBDDIWRU4zWJSNieOsk7Xn0x93AX3BFvtQ/g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795800701; v=1; x=1796405501;
 b=lYUJXOPOld0Hvr3XUnF582/5EMDxc/17bMRAGsF0xD3Q+bPVMxME66GD+mnW69VXhyp6W3Vr
 urKNWECySjoaKSD4BCHhLUxLl29iwyB5JysKweVisx7pUltc+qUj3iCIkLzniGBpH+MeteHv8WW
 dxNGTQyZynAu5OLpjlomY/HI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 30ae3ac87ed445b5;
	Fri, 27 Nov 2026 17:31:40 +0000
X-Mizu-Trace-ID: 30ae3ac87ed445b5
X-Migadu-Flow: FLOW_OUT
Date: Fri, 27 Nov 2026 17:31:35 +0000
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
To: Will Deacon <will@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Maxwell Bland <mbland@motorola.com>, Sami Tolvanen <samitolvanen@google.com>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH bpf] bpf, arm64: Fix jited line info off by kCFI hash
Message-ID: <20261127-jf-arm64-bpf-linfo-reply-will-r2-648665e850e0@linux.dev>
References: <20260925-b4-arm64-bpf-linfo-cfi-v1-1-e930ab335170@linux.dev>
 <awmhAIbMV7qo608O@willie-the-truck>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awmhAIbMV7qo608O@willie-the-truck>

On Fri, Nov 27, 2026 at 03:25:52PM +0000, Will Deacon wrote:
> I'm just chasing up old patches sitting around in my inbox and noticed
> this one. It doesn't _look_ like it's been applied anywhere. Is it still
> needed?

No, please drop it. v2 fixed this in the BPF core and landed in
v7.4-rc2 as commit 3e4279dc5144 ("bpf: Fix jited line info off by the
CFI preamble").

- Jose

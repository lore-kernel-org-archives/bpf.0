Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573CF41DDF0;
	Fri, 16 Oct 2026 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792155186; cv=none; b=mJ0TTBq28pPySqIdQ5d8fCe0KgLEeeaoIrelsAwdvoBVWnkr9xZ5/lLfMyZVXWDUUzAiqpon+ivb+wZafVe+IXdn5uMoFXHGWd3/ry0HKmAl+mw3s/ijXMZ1QHFYAyRukw1sp46ETs+upPombJptE9yxqtLzyMeKeRuqCOKzNcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792155186; c=relaxed/simple;
	bh=p5phTgyJAy4x6Y0ZYrc7ihJGiwnNB0nlCFH4bMB+PBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HF6XK2Vd6JTk2nTgtq+oJpQ5wG5Zof1WlG0cu9Xl/q2CRxvKEsU3XYDM+hdRhTHJ6d6PGCGbvz42wXow8Z6odXJgMGKP6YO4sOJCnZYD8pfPS9ct0rhMCz8JH2BsMddxgHWqOTYOBJMJf9kSAcSEo4typKr9zbnBdUUxUvhl6n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=YTfArEgo; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="YTfArEgo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=SVO7i3/Ny73slpjewLG09xplK0/4WWpT2rzBA73OteQ=; b=YTfArEgoGjqQWrVldiJhedd/lR
	CumQBCw0R0dXctcZrKOStF5r1JQBVB+E/wEO9CZfLxk0gzzGRaa0uyMDCIZdSP+TV/706Flzywn0N
	Q2HfI8JKNkZKa0bG1wjFc6BJX4slTSeZYmlg01AdVJtsFBgxwg5qB7xWFLrLT4Xp/hTCCVumO3zk0
	BLzDsNIbnwWtAqLRo9dMl9eyYrbHGr7l+4amh+ZcFhgvIgsPVZFip6MgIHBgQYJMZxwrdBwQG0vfg
	Taek0o+cgRFJNpIfpt30lCJN4kRCAfKEHaa0XyRj3WE1wXwjomj5F8nR8cQLSnICC4DIUXXBEQFHM
	Vtpdio4g==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xHhQJ-000KNw-1q;
	Fri, 16 Oct 2026 14:52:35 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1xHhQI-000Min-1v;
	Fri, 16 Oct 2026 14:52:34 +0200
Message-ID: <61f7315e-c835-425e-a99b-d2470ba9a875@iogearbox.net>
Date: Fri, 16 Oct 2026 14:52:34 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: Fix packet length loads into X in bpf_dbg
To: yanxia <yanxia@cmss.chinamobile.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 linux-kernel@vger.kernel.org
References: <20261015135702.352284-1-yanxia@cmss.chinamobile.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <20261015135702.352284-1-yanxia@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28155/Fri Oct 16 08:24:17 2026)

On 10/15/26 3:57 PM, yanxia wrote:
> bpf_single_step() handles BPF_LDX | BPF_W | BPF_LEN by assigning the
> packet length to A instead of X. This leaves X unchanged and clobbers A,
> so bpf_dbg can report the opposite verdict from the kernel for a valid
> classic BPF filter.
> 
> For example, load the following filter and run it on a nonempty pcap:
> 
>    load bpf 3,0 0 0 0,129 0 0 0,22 0 0 0
> 
> The filter initializes A to zero, loads the packet length into X and
> returns A. The kernel rejects the packet, but bpf_dbg reports it as
> passing because the length load overwrites A.
> 
> Write the length to X, as required by the instruction, preserving A.
> 
> The issue was found by reviewing the load cases in bpf_single_step()
> and comparing them with bpf_convert_filter(). Tested the complete
> bpf_dbg executable before and after the fix with GCC 12.3.1 on x86-64
> Linux 6.6. The fixed tool agrees with SO_ATTACH_FILTER on 21 cases
> covering X updates, preservation of A, and LD LEN, LDX IMM and LDX MEM
> controls, including a truncated capture with a larger original length.
> The original tool disagrees on 12 cases; the nine controls pass with
> both versions.
> 
> Fixes: fd981e3c321a ("filter: bpf_dbg: add minimal bpf debugger")
> Signed-off-by: yanxia <yanxia@cmss.chinamobile.com>
I don't think anybody uses this anymore. At this point, we should just
remove bpf_asm.c, bpf_dbg.c, bpf_exp.l, bpf_exp.y, bpf_jit_disasm.c
from the tree. Only bpftool and resolve_btfids is needed. Could you
respin with that?

Thanks,
Daniel

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793582461;
	b=lUaVK5XaScwh3OZJKFaRJfkAHGPTPhNqCx7flKTyjYDZFjW8JiJIVMcErJmadZ9zjgpK
	 imw+nElcn4jNPcNPrzk7o6tPx6nDcL+xfU1WhXH1IGYT4OVslr9A3fKIbeWCQXQAUoL9b
	 qvRdPmd+KaDdXhgmkwR51/xTEkeI+xO3iXn48kCDUzB34t0owlSNdIz8ACw/pGrlel5A7
	 zxnxCBCG9x2mnOPH9FXcqfGGqB1Ewpr2DGgg4UZ57WCmil4ezTeLGPkVnd6hSCO7OHRdu
	 uD2C6rniK2s9Dt5GwAklogxh7adbU32f6me+FU0QZupepyNw732k5y7gJ1/cvCyRhrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793582461;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=G90+AFF7kEGEqmo5bVvMlpAQaZeZsFPxsjzSqr1O6BE=;
	b=lUJtejNGtZttRjpsjhZSut0kTLkf3jtOgAXKimmJ37QEq4ucS/noLk8Q5iFdr9+oxFZ6
	 9y8E0YDmjwR5aYMYzqRHtUpflV/km5M9wpWw+PvSkcbYRfVvCR0BoZ7/IiaVLktXft10A
	 OIN5YZLAh1/tDcpfRDrUM9fsZid0ukI00B16CPpM4TNS3ldi+8Snq4KQlI5toXE5fux0G
	 BIzLO6JZU11DDAW938FtU6fd0wbNRyC0geFNhPeKG70MfdAEU8gctWYohiOXGrM6tO4wb
	 X3TZJlmgFR5/JS4Li7/iUQmS9DQmokjL9n9RbxkPUCvKndNWvYcOkJxtoMiemvSYj8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=Y2CS9Qot;
	arc=none smtp.remote-ip=185.226.149.37
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88C5606A32D;
	Mon,  2 Nov 2026 01:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B88C5606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=Y2CS9Qot
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xNgjH-008BDZ-DP; Mon, 02 Nov 2026 02:20:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=G90+AFF7kEGEqmo5bVvMlpAQaZeZsFPxsjzSqr1O6BE=; b=Y2CS9QotRZ6XM39LE5XVcV5tTd
	GL/X2Yl2GJPKe0Uw/Ci66wfiyopZWD4QIvEi5IAPjcq7f4WYZHgrgMJ9BnyvCsfJFslnH+XSt0MZP
	UsHlyKFNPAWbbDwss2RMajcwjr9MpdNbI9fEdMRY0t01T/uLLWt9OaWgZHNk7aWoebFYpzOcyubEo
	86wTPCqck8Esd71GkQrQy5BAwElwzCWuvGUZsBtgzrNIXNiza5zb/5o1wHQpHRqDkNe1t9fJ7obYi
	8EQ9XP77UojVn0hfZ7NMJSz4+9d6p0eACZuCjrgyQtsEidSB0IbVeOmlCKOUQh1tVHHsMZ8gVcpNg
	Sfv5bdJg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xNgjH-00067f-3b; Mon, 02 Nov 2026 02:20:55 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xNgj8-00AE9Q-C3;
	Mon, 02 Nov 2026 02:20:46 +0100
Message-ID: <d60bea00-6273-427d-8fbe-ff59fb6d83fe@rbox.co>
Date: Mon, 2 Nov 2026 02:20:39 +0100
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
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH bpf-next 2/3] bpf, sockmap: Restrict iter-context sockmap
 updates to iter/sockmap
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Lorenz Bauer <lmb@cloudflare.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
 Jakub Sitnicki <jakub@cloudflare.com>
References: <20261016-sockmap-update-limit-iter-v1-0-23fa946db59e@rbox.co>
 <20261016-sockmap-update-limit-iter-v1-2-23fa946db59e@rbox.co>
 <DM6O08VBRY20.1PFUYACCZ38JL@gmail.com>
 <a9ba4549-4bae-4516-85ef-ee38f13551cd@rbox.co>
 <DM92JCFA4X4U.30MTDH0KCPTJ@gmail.com>
 <0bcebb4f-4b36-4f8e-a3cd-1eb0455081a8@rbox.co>
 <DMJHFZPKETD8.PUM30IJH9D66@gmail.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <DMJHFZPKETD8.PUM30IJH9D66@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/26 02:28, Alexei Starovoitov wrote:
>> Ah, sure. So the same bit for unix_reg_info left for later?
> Yes. iter/unix cannot update sockmap after this patch.

I've meant setting PTR_TRUSTED on bpf_iter__unix::unix_sk for the sake of
unix_sk-consuming functions other than map update. bpf_setsockopt() came to
my mind, but now I've realized it doesn't really need that. So this
PTR_TRUSTED it's just a preparation for plain-PTR_TO_BTF_ID removal?

>> I've noticed commit 7cc639dc45c5 ("bpf: Don't take an extension for an
>> iterator program") got merged. Should I post v2 with the env->prog->type
>> check dropped or you guys don't want to restrict iters anymore?
> 
> The former. We still want it.
> bpf-next doesn't close during merge window. Only people that
> can process patches get busier.

Ok, I got confused by Documentation/bpf/bpf_devel_QA.rst: "for the time
when the merge window is open, bpf-next will not be processed".

> Pls send the PTR_TRUSTED part in v2.
> 
> I'd also limit tracing_iter_filter() to iter/tcp and iter/udp.

Oh, right. Commit 4ddbcb886268 ("bpf: Add bpf_sock_destroy kfunc") says
bpf_sock_destroy() expects a locked sk. So if I get it right, with
bpf_iter__sockmap::sk being PTR_TRUSTED, we allow iter/sockmap to invoke
bpf_sock_destroy() on an unlocked sk?

As for now, v2 posted:
https://lore.kernel.org/bpf/20261102-sockmap-update-limit-iter-v2-0-e96a63c43b39@rbox.co/


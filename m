Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792488952;
	b=E2N7zlVf3mv9HtD3+AXIIRmZgrN++QW75jj+BtiCsESUGDiiMKNHTn5G+hmsrLhlU830
	 i8pJefzGYTRsv1lZLxXweiOAlnlOrv8riKO9G4KRArnznpRao0QwjPk1Xn8bele12M3eU
	 GuTv8NJp9EfLabR3RY0ptQEADFlwgQWupTrrKTtF4831oC3ckZzrnjVuXmykS+JbX8TiI
	 AbwA+/z42F74ebt/fFzyrLdZX2IEAtgKMhKVpdtpMgfBllJQtbKHRzcxwdcnoo9HK6Az9
	 xytJq2sxWInQ0xkJyD+N4XVK9ekdQEo0Zy8bQNWabe8pak0wJA5DByycCz69sxh4ghQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792488952;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Virus-Scanned;
	bh=xQaeHm0XXJnSVYUyU+gItJomu67kge3hzFFJ233evnA=;
	b=5nmdxGb+Jn6sxwCRmKtdvXGaXwA95uecfCNv3YwkhKR/q3wfceb7VMJAVvAWv47jRRyZ
	 2/WqzJs6HOpeDVFwABPpxMcxrEFAJbKcbrJbwf6XwKcbpsRpT2SQyiY2eiJjvQa+QbP+D
	 8slp9dvFeuALsk3vb/60Q+TKQFeL5YnbxwmtfyPK9BWrOdvRKL1bdAp4aPaT2WIY2zNil
	 reNywPneXsqQhx4ICth+NgvGOHWnwahSR57r7s30eSwfLLzCUN2gK+sedbNIEqOOC/jdv
	 RHosbQtI21kh3wSROIQ5pZ2DUZTmtDQ25JlChtj5Y6P8q5WCe0RrKzBQ4PWFAQZoFSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b="KX9nX4r/";
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3FC606A31E;
	Tue, 20 Oct 2026 09:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B3FC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=KX9nX4r/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=xQaeHm0XXJnSVYUyU+gItJomu67kge3hzFFJ233evnA=; b=KX9nX4r/77OBqaWv1pfPEM2nNn
	euS5Kp2IO52RYFZ6jDNwqVGFGS6a43yqxMwqf8QwoTfvTQtiGS6/VmzLkJSk2sQQe8FlUSyYVYR7b
	y+ZdD5l0CkVn/3ZKKgKFtddI9IPxH51oQ2TQpfC6V2cwb4qt9XYNvJY2NU0HyfDQwrRHwSpDDnOED
	QiZLSBmKgsk2XK8r2jKJYoCDIkJbp6csYpSmnlV1nQtfRskfidAwY7YlB1OaCqu4rSzcsfY7Cs691
	FAkBIOv0sX/oOLYkqfOfS78jx0OF+RXgNewBnWymz7WdWRlowF0PtE5CAG57iUi/nnGfZSRV+SJj/
	bMnLNiTQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xJ6Ft-000E6m-0U;
	Tue, 20 Oct 2026 11:35:37 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1xJ6Fs-00063z-0P;
	Tue, 20 Oct 2026 11:35:35 +0200
Message-ID: <d86445fe-aae3-4d37-9289-7e06cb210a74@iogearbox.net>
Date: Tue, 20 Oct 2026 11:35:34 +0200
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
Subject: Re: [PATCH bpf-next v2] tools/bpf: Remove legacy BPF tools
To: yanxia <yanxia@cmss.chinamobile.com>, bot+bpf-ci@kernel.org,
 bpf@vger.kernel.org
Cc: yana06070@163.com, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, richardcochran@gmail.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 martin.lau@kernel.org, mason@kernel.org
References: <20261020083713.905006-1-yanxia@cmss.chinamobile.com>
 <a02301c0ff8593349602f81cdf0c21f1b38db0b60118f8eed3199a6a38330234@mail.kernel.org>
 <20261020092119.918464-1-yanxia@cmss.chinamobile.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <20261020092119.918464-1-yanxia@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28159/Tue Oct 20 08:24:12 2026)

On 10/20/26 11:21 AM, yanxia wrote:
> Thanks for the review. Agreed: the table lists mnemonics, addressing
> modes and descriptions. I'll fix the wording in the next revision:
> 
>    The instruction set consists of load, store, branch, alu, miscellaneous
>    and return instructions. This table lists the assembly notation and what
>    the corresponding opcodes defined in linux/filter.h do:

sgtm, and please add a full name to the Signed-off-by once you respin [0].

   [0] Documentation/process/submitting-patches.rst

> Best regards,
> yanxia


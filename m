Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792675310;
	b=sNr3PdG2GKEHi+rWIeoJpiKue02CeFEEvB1BiCwXx8zSiOSdcNTmJursFRcmHuwOm5mi
	 46MWcC2u89wWDEWgv80rQVjRfthbkS5YIv0U6qIi0HzJpIHNsbmIMeyifDgSQnOMXb0Td
	 WLRkenEmzJr8ZSD3PkUw/VUOYiJ3yN6hy9evW7AOqs5vcLG8rWlpjjkm4hOgxCs/glCF7
	 9kBTwHkSfI7ER5IikFiz2rU7vQKee2yp34CCjyNPzM7E9njkEHHtF8UWHdol/hwRFsVem
	 jmfc4bxw5dyJE5UP3Pz01ox6urvMesd7szG5xZ2ow7StaTulEJ2CTZ5NtrLzi3D/5cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792675310;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Virus-Scanned;
	bh=XwX0hLYTzcYPjpwj+QbShak5jjguWIKNoBPLmC/pwf4=;
	b=1h5Q18bUAhL0fOZysogT3U4rZ5nBNWd9Sy+frjyXWUpvDm9MQGTcUMqXwZLHMqH7z2iW
	 OabiOhysu4c8PqIBqHALpmWZAXv43OAix7GLwPU6oqZ3gnElrhgI6zs8P0HGs+jkTn8ui
	 PgD2a04we7mb1XAgIFu7BqaSE0701LJ3V570UT0/tXsKxhUW6DwNI7h7G0lbfBowFoFBx
	 uelCmPKCAKV0ShGQlP5sDXjqiPurXKaPW+bPS5/4xoCq8w577VKLnnmhgokfn7tY7A5AR
	 dWAJddB0MIuc7YcbPl+CJxK6Qn+ZXkNZeoUcVkEeL+Jmw2pIR36ALeBXrKJGKKJf4XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=GSNhlLFS;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC9F606A31A
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 13:21:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BC9F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=GSNhlLFS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=XwX0hLYTzcYPjpwj+QbShak5jjguWIKNoBPLmC/pwf4=; b=GSNhlLFSRkZV1xZyg4l/DAi4Ab
	xAtqPQfw1h/XLCMh8+mYiej74LSLHfvlr4cMMF+6ZE6CEkCOs1PFOeSg6Ncqo2Ev40JiG4izAgxyZ
	A8tXqbBJfhlEBAVM5cjS2ff9QSE4VhkMjSkx4YIWwAKuPvXR5uh87U+zjCcUULVjkuGTeoYohzihH
	nYDdL6cHeusDcvT4HSjVjPiucvlO4TJUG5okCEEdGytHDfcGfJAQwapdm64LZ63sWlJEyLS02AWQk
	YNuIndKXMl5yViMsJ/1l6jdSOgAY6AYKVDnQIBIEBNTabTYYsIDniyWVn4awK3fld46ppqIoBmw6S
	XfxhrFsg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xJsjm-0003Ht-2e;
	Thu, 22 Oct 2026 15:21:42 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1xJsjm-000Ojl-0H;
	Thu, 22 Oct 2026 15:21:42 +0200
Message-ID: <fd6839a2-4840-4102-a21a-6c5a27d51989@iogearbox.net>
Date: Thu, 22 Oct 2026 15:21:41 +0200
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
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Test JIT jumps which
 change at a repeated image length
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, kernel-team@meta.com, eddyz87@gmail.com,
 memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20261022-jit_size_fix-v2-0-4bee6921b218@meta.com>
 <20261022-jit_size_fix-v2-2-4bee6921b218@meta.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <20261022-jit_size_fix-v2-2-4bee6921b218@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28161/Thu Oct 22 08:24:11 2026)

On 10/22/26 2:04 PM, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Cover the case where two JIT passes give the same image length while
> jumps still change size, which used to fail with -ENOTSUPP on x86-64.
> 
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

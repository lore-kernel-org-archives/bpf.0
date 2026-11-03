Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711778;
	b=ewUP7C+G433jt4OF4hYH4GnTsyaL5IcEG1Xt+cSwKeGYAwozXRkgvcz4/+UQi/Fi2XRo
	 +qWylaofHNgNcCwq4KHplA+VOe/JyhrwHSOWyeG8MIi/juTbInnIP/82Mcyuc9DTLzqBb
	 rXETsXNdigcmCxH/UXMrEvD5dOjr7DVOiO3GFdO/UTcmOr0gKNYNcWrmNzgfdip8cnpGP
	 3yAzr9e+b0Rx7z1yGeZ1garfqahPJCee04Jw2HPO6G9NC/g6rgeWE4NZSTV4oO3DhivEZ
	 bxdTTR2lYXAYmqVx9lYJ5M6akEjAYDkOWVGma1Hk2OJOxtudbN+Ka/uNxEtkdn7jtLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711778;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Virus-Scanned;
	bh=VnMglMUnTSveHp67jPBfYdcL2bkNKEXhLWJZAiYWdLg=;
	b=sxS0V4ffTHLlGh+G/gv9iyxJD1lO7YkpvLS8tnBfp1u8u6tevIS0AxtlZAhJpZG8/HoH
	 qpJ40KWLGrZx71rhVI1Il9+qMTTQggmj/bJAbd2zH3dIBbOmm+3PiJkOVB1TYfnqxRpHy
	 wkiNovFZCnHiPfiUtpPVwC/2NntcyhAiq73ynkYLWZCdyEiPpgeVYaBC5Ul6JM+uPP5ef
	 Z/molJgxnjslAoKQxOI3I57Y77ropSRlYX/qyvROrS9yduqaPJi5yYULyVRI7wAhlgnd0
	 +m0ay+BWwGs43cgAfbuYyahaVxONksATE2e86bZkJoGmprUxB8RPTeR9jZkE8Q0usqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=Ge7EbqJY;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EC1606A32E
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 13:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44EC1606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=Ge7EbqJY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=VnMglMUnTSveHp67jPBfYdcL2bkNKEXhLWJZAiYWdLg=; b=Ge7EbqJYeG/O0NjC2w6So6hpkB
	PHJWYddMeSPY69REtG8QmCnMTpDak3cuk5SgWUkfhWimkzYmWBO6gyqdn9CvL2Dh0SYDKo/bLH4d4
	lzvYThLu05+r4S3a17wMXAIQrJm4+1avvHeE2TUOtarB6YHQBZZ4nuJGlKmx2AbG8iUczsCo08CZ1
	M2Q1b02VeIBV1PVp6oZluI6nbJ7ETk49HDaBRWwtp/NvIHhqq6QaolVqrsT+/BySk7ENTefL3TBk1
	uRcf5GJOBey4rdYeQdPt9hMCD/SdAuNF2Kp8QsHu4iP1Vqaxmtxs0Jw7zKMxUAmCFad0pstgEISvH
	m5N7NAjA==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xOEN4-0005dj-1c;
	Tue, 03 Nov 2026 14:16:14 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1xOEN3-000PIR-17;
	Tue, 03 Nov 2026 14:16:13 +0100
Message-ID: <1754bef0-6789-4295-913c-9548be999ece@iogearbox.net>
Date: Tue, 3 Nov 2026 14:16:12 +0100
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
Subject: Re: [PATCH bpf-next v2 07/20] bpf: Move the division magic number
 selection out of the x86 JIT
To: bot+bpf-ci@kernel.org, ast@kernel.org
Cc: puranjay@kernel.org, memxor@gmail.com, xukuohai@huaweicloud.com,
 bpf@vger.kernel.org, andrii@kernel.org, martin.lau@kernel.org,
 eddyz87@gmail.com, yonghong.song@linux.dev, mason@kernel.org,
 ihor.solodrai@linux.dev
References: <20261103122733.1383002-8-daniel@iogearbox.net>
 <241dc212e4511cc5c0aacd95e05d56548b14f600c345122ffe8ea54b47eb4ad9@mail.kernel.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <241dc212e4511cc5c0aacd95e05d56548b14f600c345122ffe8ea54b47eb4ad9@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28173/Tue Nov  3 07:27:52 2026)

On 11/3/26 2:06 PM, bot+bpf-ci@kernel.org wrote:
>> bpf: Move the division magic number selection out of the x86 JIT
> 
> TL;DR: Nit only: the long comment above bpf_magic_div() is hard to follow and
> repeats the in-function comments and struct field comments; suggest trimming
> it to what it fills in and when it returns false.
Ack, ok, will fix in a v3.

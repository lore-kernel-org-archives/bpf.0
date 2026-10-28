Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194697;
	b=ec1SWAtZXqJsLe33O8cC+IOCqQXBF9SswBzHQcM2t73Dd05mN61T757PNKshdvk7F4t4
	 q7V2Cb6u3d5OxszQa3EA5Rbvs/mzh6EEzfJn+IfBpK/fDjErrOM3Lf2mCDGh/P+qOsNhQ
	 zTVhjwE2Ycg6gmKy1IUULVRl6sGGx1jch7cSO/sTBP0DeIFmkbxpSvxem6LKNqCTqaTJv
	 VnD+j/CQFe7liprMwNBKL0Z7F/QF9D0DtCuhxfNgStz0WYy6PIXhujjNQe+g35HrXxMcD
	 9dG47Z8nI+ng8iamFm+b36S/w3psYzm2Ws1gYDFEyMAqEztGReWShiwBJmHTGNLbKrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194697;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Virus-Scanned;
	bh=gfwXJLk8i++kOQcvdVyodjBROK7tzv7ohtlTvD85oMQ=;
	b=JrGIwwPY1zTal/yHvQ3SGANzuJAilg/sobZeH0sg9Q+473O5epxWGYboMxqIP37ews+k
	 PO3SCN7Db9+qIFoE31U+67RM9NppEfojn4LXDEJ6Nhtyvtkn4meRJ3PWDN+oG+F4OYtyS
	 LE53oGxVqDml6U0COC0qikD+IrCKsfRb7RFMufmlLg/eTCsQAyZVxm9MhQX4XIagRfc+s
	 PPF+mi76rx8eK/TFNO2wbwH/JaWGXdv9j9D4mj1jUFJtp44W6kj7TUZ5zJIDPgT/YG2mo
	 KRvg9PqEk0mAM8fq7mXoXW4oCiTK6iwyxEfrWcz+9f+s/MRqhnImvm1Z05a1noXjVIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=U3MbdEni;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA35B606A31A
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 13:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA35B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=U3MbdEni
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=gfwXJLk8i++kOQcvdVyodjBROK7tzv7ohtlTvD85oMQ=; b=U3MbdEni0HeNPPAVYB8ZY+f5V8
	Fsm7izBI+4Vhx0kUC75FADKUBcA8EmYn3VVQfFW3y5sgVvSZBdi08AYOUwcHTeBK0wwTRxjOV7DxJ
	s0YD3pfQizFCHUVnEsovqVO+FfbUOev0w/bToxgQNvmtqXqo2YoPewxGNbWFNbFn1Jdp3buAlEEoR
	7baWztfW2yrYNkc4oQOhHVzog2n1+WYD1wsPRmgMRVl/+/0ZWieSNyVK7xn2ux7E6IQwxzL9AVgd6
	sVnWFeBhRXKeaAXZ2FH+M9SRPbOZB66csjFOArcnxVNigENyrkBbHd/CeAKbpAeU+vzmnsf45+Tlq
	B8hi3eOw==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xM3r3-000Its-2j;
	Wed, 28 Oct 2026 14:38:13 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1xM3r3-0003RU-16;
	Wed, 28 Oct 2026 14:38:13 +0100
Message-ID: <6f8f4c92-47c1-4d7e-846d-dad558a3dbe3@iogearbox.net>
Date: Wed, 28 Oct 2026 14:38:12 +0100
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
Subject: Re: [PATCH bpf-next 03/21] bpf, arm64: Emit ISB SY in the speculation
 barriers
To: Luis Gerhorst <luis.gerhorst@fau.de>
Cc: puranjay@kernel.org, memxor@gmail.com, ast@kernel.org, bpf@vger.kernel.org
References: <20261027182445.1156335-1-daniel@iogearbox.net>
 <20261027182445.1156335-4-daniel@iogearbox.net> <87h5i6uf5v.fsf@fau.de>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <87h5i6uf5v.fsf@fau.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28167/Wed Oct 28 07:24:17 2026)

On 10/28/26 2:29 PM, Luis Gerhorst wrote:
> Daniel Borkmann <daniel@iogearbox.net> writes:
> 
>> The Spectre-BHB loop of the epilogue and BPF_NOSPEC on cores without
>> FEAT_SB end in an ISB, which the JIT took from
>> aarch64_insn_get_isb_value(), the template of the instruction matcher
>> with CRm 0. The Arm ARM lists every CRm other than 0b1111 as reserved:
>> those encodings execute as a full system barrier, but must not be relied
>> upon by software. Emit ISB SY with CRm 0b1111, as the assembler does for
>> the isb of the kernel's own barriers.
>>
>> Before/after:
>>
>>    d50330df  isb #0
>>    d5033fdf  isb
>>
>> Fixes: 0dfefc2ea2f2 ("arm64: bpf: Add BHB mitigation to the epilogue for cBPF programs")
>> Fixes: dff883d9e93a ("bpf, arm64, powerpc: Change nospec to include v1 barrier")
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> 
> Tested on ThunderX2-99xx in KVM (BHB loop forced on).
> 
> Tested-by: Luis Gerhorst <luis.gerhorst@fau.de>
Thanks Luis, I'll carry your tag for v2.

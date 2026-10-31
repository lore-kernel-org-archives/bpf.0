Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793406433;
	b=keiO4BtBJDnlh6fNbmJBdr/hg2uPCb2bNb2tDimCmSLtfqKnJmNOMk6OWvw+uKcVwIjw
	 PwRZc5QSAi/DggonlwDq/kHjEA0b5biOmpN6qIykpQffnPfIHldl4ReOhDricCCN5Ljdx
	 QF2sALs6epPS/VF1bdPI6xwdzzT93uebEXSDTBwofhTOj+xKcwRnGqU/uKbBLhZr+MtgZ
	 ruSLsT6c7X0B/Zl6voNpQm/EXv1nuQ/oxHxaLHjZN2aJGWwAVHLmmvvH5tk3OK5/dv802
	 wgx2P+BPpg/AdUnU9OjWiy6XCeBYxgq0Wcs4P4Uy2PaI6hT0LoajxHQL0u638/YTOVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793406433;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=mqZlAtEH2kLh/9YKwUOPtokEZXz+PFSnU6rmqLljUNA=;
	b=3aMORVS/hdPMBPAIf/auzYFg8vQDoJ/u9t3f273eKefsTNjt7lKTx9E5EljBVvCd1++l
	 TPfKGT02fULPnfgyjSBRx4el/SKLIyKBgyYzek8uFz5vx1VZaAw51b9BsBzwiZpRmQjae
	 s9aKdMQNXVTf2+ixGwviEDjZA5Xjnd2M3TGw7JeetuL6JdK0Qik4PwGCtHYEcmpNwffK2
	 OZsdJoJhuOAbupuBYOjO4rCBtSxjY8VyyrDsSrolrTdDH9Ijy+IFN95qAiigboLdRkSgD
	 m7Vy/Bm8mfeku6JTgtkUf67U8quMu7egbLzqRfUhOPpkUwjTmY+jxBs8firvEhdG0Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wDYeqjgN;
	arc=none smtp.remote-ip=91.218.175.132
Received: from mta0.migadu.com (out-132.mta0.migadu.com [91.218.175.132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D102E606A31A
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 00:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D102E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wDYeqjgN
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WmQxFxEKtu7P5pwGmnwKcuV02MR6wLcQK0UoYlGQeGQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793406429; v=1; x=1794011229;
 b=wDYeqjgN7chQSmFwwYH9mwqGDjZ+/rkbx16Kax946tNtJ/J270QpJbBybzLRQwXn7rgwjj82
 RWClZHYN9zB6YNcAyn9k+uVtvmCsZrOL9SPEf5FousrXV4y1/MwJ+NncCAcvSBp4hBKPYAW/BLn
 SDdMzE5MZaYu5X21SOLmoD/A=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5ea1c3354c20902f;
	Sat, 31 Oct 2026 00:27:09 +0000
X-Mizu-Trace-ID: 5ea1c3354c20902f
X-Migadu-Flow: FLOW_OUT
Message-ID: <c9fe17cf-a321-4a70-ba32-dc99225559dd@linux.dev>
Date: Fri, 30 Oct 2026 17:27:00 -0700
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
Subject: Re: [PATCH bpf-next v3 03/13] docs, libbpf: Document complete BTF
 annotation strings
To: bot+bpf-ci@kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, qmo@kernel.org
Cc: bpf@vger.kernel.org, alan.maguire@oracle.com,
 cupertino.miranda@oracle.com, david.faust@oss.qualcomm.com,
 irogers@google.com, jose.marchesi@oracle.com, vineet.gupta@linux.dev,
 yonghong.song@linux.dev, martin.lau@kernel.org, mason@kernel.org
References: <20261030233355.1836749-4-ihor.solodrai@linux.dev>
 <68d4cce002dd78be96cb549d4d228cec0fca46ae9be77a82b7521bd56c06f684@mail.kernel.org>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <68d4cce002dd78be96cb549d4d228cec0fca46ae9be77a82b7521bd56c06f684@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/26 5:16 PM, bot+bpf-ci@kernel.org wrote:
>> docs, libbpf: Document complete BTF annotation strings
> 
> TL;DR: The BTF docs drop the old bare attribute-list form for kflagged tags
> without noting it. Older kernel BTF uses it, so consumers following the new
> text may print "address_space(1)" uncompilably. Should btf.rst mention it?
> 
>> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
>> index 29de1222c3e7..98c1f0440f8b 100644
>> --- a/Documentation/bpf/btf.rst
>> +++ b/Documentation/bpf/btf.rst
> 
> [ ... ]
> 
>> @@ -539,8 +540,9 @@ normal type tag, and the ``name_off`` encodes btf_type_tag attribute
>>  string.
>>
>>  If ``info.kind_flag`` is 1, then the type tag represents an arbitrary
>> -__attribute__, and the ``name_off`` encodes a string representing the
>> -attribute-list of the attribute specifier.
>> +annotation. As with decl tags, ``name_off`` encodes the complete annotation
>> +string, which ``btf_dump`` prints unchanged. An attribute specifier must
>> +include its wrapper, for example ``__attribute__((address_space(1)))``.
>>
>>  2.2.19 BTF_KIND_ENUM64
>>  ~~~~~~~~~~~~~~~~~~~~~~
> 
> The old text, which described the string as the attribute-list (for example
> aligned(4)), is removed without any note that BTF in that older form exists.
> Should the format reference say something about it?

I don't think so, because the only significant consumer of the old
format is bpftool, and it handles it correctly.

> 
> [...]

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795103727;
	b=Wens0jNkCQyB26zow77w82Xd1J4U2c6OqlFC57u82ah3deFK7jYnaSHjf8rTX7NiwqWI
	 1l8v2Xd8zeP/b6eDWEmDowo6ZEbIZhbec/BqinA2FtIar9+R3x8blpwHY8RdcPOMH28L1
	 qOSoMh8cB7dP1vk6CDO9xcE+c2U8nftbcMk5SnLKz4inxiGQ2EGXu3g631dFaIuBAcH0H
	 MrycFQy7NRnDJ0gq5nNXl/6O7vq7ErPqDb8HR4I4iwqKQNxW5wpKAB73s+3GuNBtKztVE
	 PvIbaL27znc4DnLkwI/FWy98npS7JMQ6/5bSlkUGpJPyoYmLL0ByqQY7Dw+yPThi7Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795103727;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=S5y3ehFMX7xvuESlETM5iyydoSlAvrzV5co1ZGUk+2g=;
	b=14ZnD87iNsCSbHoHgU/4BRdF0pDuFdJp854ZH5KbH6MKIRSl4IkxsZbRvkJYYH2v7Erb
	 6pPAkkZWhKHO6lP5Ut+LRh2HCNxFdR8dDN38a/EMWIi5pD3zg2b1goYTADon6Cwy2hOJC
	 PVZefJ44p4bImsVuxRl+g+W0yiIb1PLYv8spHr0Ungpsd53euweFav6GEnz6qe/aTbV/A
	 MGCn5Sm9rWVnEjiMU9DWBmkFGSHpHqsOR+EKPhC3jXntVkziot0hqTLQvmsATCaYp4SYq
	 mML8/WzthOrZNokF88Pv/szTsW7y3+/h6bLUaMKsvikcTA/2icZP6hK3HHGCDa7IxQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=d3Dm0Vvf;
	arc=none smtp.remote-ip=95.215.58.112
Received: from mta1.migadu.com (out-112.mta1.migadu.com [95.215.58.112])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08973606A338
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 15:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08973606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=d3Dm0Vvf
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=MI6m1fgzE90WCP6fVltAGE9g/FHvo2S3/U94edN9OKc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795103723; v=1; x=1795708523;
 b=d3Dm0Vvf/4m9jdxmDoQKFrXPR0EnI9N9CkEOwtfRJXk4D9vBxoC/37pheTAG9Iy5SxN1Sa9r
 uHcry29GnKbBP+ezfQLJRZGTAKKc83wh6VKhqEqQ5VxKsC/6se2n52agztE0CNSvKFodewLYKnf
 ofKIRCID08s8RoB0Aii+M324=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e82867066facb70b;
	Thu, 19 Nov 2026 15:55:22 +0000
X-Mizu-Trace-ID: e82867066facb70b
X-Migadu-Flow: FLOW_OUT
Message-ID: <4ee1f1de-ae9e-42b6-b7a8-b0e37633b51f@linux.dev>
Date: Thu, 19 Nov 2026 07:55:16 -0800
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
Subject: Re: [PATCH bpf-next v2 1/4] libbpf: Zero-extend unsigned 32-bit enum
 values in CO-RE relocations
To: bpf@vger.kernel.org
References: <20261119051448.1902442-1-yonghong.song@linux.dev>
 <d711aef177c86b8b225bdf52e9b0a47894d8ec2f2b5432010c78f3a275501d43@mail.kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <d711aef177c86b8b225bdf52e9b0a47894d8ec2f2b5432010c78f3a275501d43@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/18/26 9:54 PM, bot+bpf-ci@kernel.org wrote:
>> libbpf: Zero-extend unsigned 32-bit enum values in CO-RE relocations
> TL;DR: Commit message only: the Fixes tag may be wrong, since the
> sign-extending enum read predates 23b2a3a8f63a and was introduced by
> eacaaed784e2; the tag may need to change.
>
>> libbpf: Zero-extend unsigned 32-bit enum values in CO-RE relocations
>>
>> [ ... ]
>>
>> Fixes: 23b2a3a8f63a ("libbpf: Add enum64 relocation support")
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> The sign-extending read of btf_enum->val in bpf_core_calc_enumval_relo()
> predates 23b2a3a8f63a, which only wrapped the existing read in an
> if (btf_is_enum(t)) branch.  The old code already had the same __s32 to
> u64 sign extension:
>
>      e = btf_enum(t) + idx;
>      *val = e->val;
>
> The sign-extending read was introduced by eacaaed784e2 ("libbpf: Implement
> enum value-based CO-RE relocations").  Should the tag be:
>
>    Fixes: eacaaed784e2 ("libbpf: Implement enum value-based CO-RE relocations")
>
> The unsigned-enum (kflag) distinction was added later, so the unsigned
> symptom could arguably be dated to that, but the faulty read itself comes
> from eacaaed784e2.

I don't think we should use the following:
    Fixes: eacaaed784e2 ("libbpf: Implement enum value-based CO-RE relocations")

This commit is dated back to 2020:

commit eacaaed784e2c9da69dea3030c81062c1fd66a37
Author: Andrii Nakryiko <andriin@fb.com>
Date:   Wed Aug 19 12:45:18 2020 -0700

     libbpf: Implement enum value-based CO-RE relocations

and I don't think this can be backported due to in between a lot of changes.

I will choose this one:
     Fixes: 776281652ddc ("libbpf: Permit 64bit relocation value")

commit 776281652ddcd98bb292335ea3634da341c849b4
Author: Yonghong Song <yhs@fb.com>
Date:   Mon Jun 6 23:26:05 2022 -0700

     libbpf: Permit 64bit relocation value

This commits allows 64bit relocation value and this is directly related
to this patch set.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44465301903


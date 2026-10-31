Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.238
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793407007;
	b=JPuKT0plEaQXMT6k67LrLGoYAj3dgj+eg/FKvVJF/baZP15w4nasEaqLrTcZhQ5mcZIN
	 KPM0e5sdU8ianMuaVLjbOiefDtW1QrtcVLDk1D3N4Sm6IJIwywpk0ugUpO7F3+oK5stdo
	 Mul2z0LZkrKxvph9Bos6/q0/GZ5zeUsPa28p+81PGLG4jndlbeJl+faY3i1/P3HQx1jzw
	 9aOV7gYLYPMgFKPvrpRjLf+10X1Fm79jBYKwGBktfCx1vCgq4jQBSVDx1swrhTkp6Y8g4
	 rER5oUrDdilkS9Ya0b/ymvyYKQJiJ4+OfLQ9UqcWi1ri3AqB3gZ/L1Rdevsa+/f5/Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793407007;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=eNNMv1smt/9U8smrcJZftdbcffNT8a1wWdDAdyo73Bk=;
	b=OhdgH/cH1aYCM5Uk2gRHr3RJUIVV08e0kC24nzw+RvJHWQoF0FYOXTHOHHevZFVCpN9y
	 Git6IahR4grZ9UJi5U/LaSV7AcT4hgYkh76hMWAxCJMW/FNt3odmIjKHY6Dovo2OfOGT1
	 d4iqfJ7uv80K8D2x20tHE8/bHJEKUKlyUYaUKtkHAcn+CBtIBSgptFPq5TiZfhYzizVnx
	 gO9slKHWm60n/ITdBLkFLLkF2NHQmlMDwpZPyZm4UxxVODasug1F+P99hjc3x8hlFXKQJ
	 7GQEemnixgsOsFv3T3yWBsuYNFU/RS1Md54uaq8wKzcKCzuuFXOG1zp2J0p2v4Z5+7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GSB9fhuJ;
	arc=none smtp.remote-ip=91.218.175.238
Received: from mta0.migadu.com (out-238.mta0.migadu.com [91.218.175.238])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003DB606A31A
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 00:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 003DB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GSB9fhuJ
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=bwAxQ5w7pz2L35jWlOYGqcCfuwG7nI/hBI0hhTWBmx0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793407003; v=1; x=1794011803;
 b=GSB9fhuJbcs7dalLtSQXAd5si71mqXwjSExvTHy6g6W4Tl/Q6mFBIH1Ys084mDHv4X9ATXC7
 +wY6VPlPF3jVzBuMUv1oEry27tHdLCrERwx/C3h8fZMUQleHwIwRAP0kWgEsCRxevfJeahPNME9
 pHvPI/4CYb9D22Byh0SyM7nM=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1ed613904694c759;
	Sat, 31 Oct 2026 00:36:43 +0000
X-Mizu-Trace-ID: 1ed613904694c759
X-Migadu-Flow: FLOW_OUT
Message-ID: <eab20bce-ea0a-4936-9fb1-dc5ef5a7822b@linux.dev>
Date: Fri, 30 Oct 2026 17:36:38 -0700
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
Subject: Re: [PATCH bpf-next v3 02/13] libbpf: Dump kflagged BTF tags as is
To: bot+bpf-ci@kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, qmo@kernel.org
Cc: bpf@vger.kernel.org, alan.maguire@oracle.com,
 cupertino.miranda@oracle.com, david.faust@oss.qualcomm.com,
 irogers@google.com, jose.marchesi@oracle.com, vineet.gupta@linux.dev,
 yonghong.song@linux.dev, martin.lau@kernel.org, mason@kernel.org
References: <20261030233355.1836749-3-ihor.solodrai@linux.dev>
 <b8912e062900f51fd8c8f44c44ef43d0788ce6af12582abc0060dd6cd4c05065@mail.kernel.org>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <b8912e062900f51fd8c8f44c44ef43d0788ce6af12582abc0060dd6cd4c05065@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/26 5:16 PM, bot+bpf-ci@kernel.org wrote:
>> libbpf: Dump kflagged BTF tags as is
> 
> TL;DR: Printing kflag type tags as is may make C dumps of existing kernel BTF
> emit invalid "address_space(1)" for arena kfuncs, possibly breaking vmlinux.h
> and bpftool builds until a later patch in the series.

This is the reason for resolve_btfids change and bpftool patch that
handles "address_space(1)".

The in-tree bpftool and selftests compile and run on every commit
of the series.

The incompatibility affects:
  - old kernel BTF + bpftool before patch "bpftool: Normalize legacy 
    arena type tags before C dumps"
  - new kernel + old bpftool, in which case the users will have to
    update their bpftool


> 
>> [...]

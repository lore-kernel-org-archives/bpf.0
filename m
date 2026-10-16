Received: from mta0.migadu.com (out-113.mta0.migadu.com [91.218.175.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A58755D882
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172490; cv=none; b=Fo4u2Ttq9eTHFhe+jyXt9mQIiu4dJsHgTF/FdJ7Tnm4Mu0rWhwDgMYfJ1L/I45UNmlIOxUrC9lajLYHUJpGYNWTTpKyzYnjCJ5u3J4kDTcZGqpSsjia1NXG0tNnh82dwuKvoSpaGERuHnngBvtki+7BJ+lkhBAnA6+qaNfxKISU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172490; c=relaxed/simple;
	bh=89Oe+lhg/rvO7bdrIKOY3xa1C56UJ4KmkQ/we1ZYuew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=olu4GxpThSKu+JfngqEudxWDKD8v2uTYGOwfAox7TyGVn/H6/hjZ5cdV2QmWbLTPP4j637CiuHGYcNjpB3iCMKMu2zsirGar7w+bfWlE++lso8eW8Pv0Zju3HRoMeuXOPuoFKSGC1XFC8UOdYC6mMUb5zIqnhRdYru73EpzFP9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jmp32L4m; arc=none smtp.client-ip=91.218.175.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jmp32L4m"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=89Oe+lhg/rvO7bdrIKOY3xa1C56UJ4KmkQ/we1ZYuew=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792172485; v=1; x=1792777285;
 b=Jmp32L4mNqBEugDZjbgNEz8BeVH07aq0Feu348l+LVhhe33FWYW74v4AKFVobzmbwjSLX3Us
 VKcIo0MomcK86aDGx9Vgcn0ty8m6GdfH1/lwy61znA5yw2IgJnweKZKvL659L2ESVW7tCqzY5a6
 MBNqP8wSUgloUotlbt5P4zy4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7e3bcc132f46556d;
	Fri, 16 Oct 2026 17:41:25 +0000
X-Mizu-Trace-ID: 7e3bcc132f46556d
X-Migadu-Flow: FLOW_OUT
Message-ID: <3e601367-06e5-487f-91e2-948bcd18191f@linux.dev>
Date: Fri, 16 Oct 2026 10:41:20 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 1/8] bpftool: Dump C from a detached BTF copy
To: Alan Maguire <almagui@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
 Cupertino Miranda <cupertino.miranda@oracle.com>,
 David Faust <david.faust@oracle.com>, Ian Rogers <irogers@google.com>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>,
 Vineet Gupta <vineet.gupta@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>
References: <20261016000012.2232059-1-ihor.solodrai@linux.dev>
 <20261016000012.2232059-2-ihor.solodrai@linux.dev>
 <b05d0c61-6b4d-41cf-adfa-c5b1da0133d3@kernel.org>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <b05d0c61-6b4d-41cf-adfa-c5b1da0133d3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-10-16 2:25 a.m., Alan Maguire wrote:
> On 10/16/26 1:00 AM, Ihor Solodrai wrote:
>> To emit per-record attributes in the C dump, bpftool needs to add decl
>> tags to the BTF it dumps.
>>
>> Modifying the parsed BTF fails for some valid input: libbpf refuses to
>> modify BTF whose header carries unknown nonzero extension bytes, so
>> such a dump would stop with -EOPNOTSUPP.
>>
> 
> Curious here; did you run into such cases? 

Nope.

> ...I would have thought the
> only case would be something like where we have kind layout info in
> a bpftool that does not know about kind layout, but that can't happen
> for an up-to-date bpftool with libbpf that knows about kind layout

I was thinking about forward compat.

Consider a bpftool (with this series) dumping BTF from an even newer
kernel, with data libbpf doesn't know about. has_hdr_extra check
correctly refuses to modify such BTF, and that's what bpftool is
doing.

But if we use the split BTF then this is not an issue, because input
BTF stays read only.

> unless there are issues with out-of-date UAPI headers for btf_header
> or something. Wondering if there's something we need to fix somewhere?
> 
> Thanks!


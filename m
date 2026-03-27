Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D273A1A6827
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 20:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774644943; cv=none; b=etPW6OhnCJhL03Ii0wS2SZT65mBNVhOzlSwH0Pega/7H0mKlqy3sZlP3DX3Kyc1loTEkr2+OwvEtBdqrI354U196skvFhVEOzmeE9EvABqIDB/xXP//uUciOpXhaJYTPDZ6oHFMuCmLaSNaE0xeGtVLf35E0PJbX5jbHvKvEPsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774644943; c=relaxed/simple;
	bh=ikIhOhiD3m2+pifKDVmwVFRLv/ifaN8zysX2YJeuFbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qXxjs/jC5tzvJfKFrrzbWMVQpk6e6gZAULwNe0ss7apwEnaoKmHiIo/zr96sH/MgBcZ/tZNrsjkR9zyPZiMlHREDx/fMKzfbQoSGg2A1m/Vo8zlQxaiGchN6EzcettW53TD++iYl3YsJjKk/NLAEEwHDTDZuQ2P+3q/MZUohDnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k/kW82SD; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k/kW82SD"
Message-ID: <676332b5-1f7f-4c8d-b41e-e2dbbc1d7e4e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774644937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0aHef+GvUQu5lvLgebrYAYak1bZiz01bUSgW0M62JXI=;
	b=k/kW82SDPtJ5hJf9Tbski6DMaUbMyEoFz8WmwnZcKrAftia4VfBJr351fscUGWDgNUVhMG
	3/oyQWRE/1BhQCWIC4AJ7dG52wl1v6yt//g7e+iwZrrg4aD3OuDSf255GR+sy9vGTh6MEl
	RtP7cB43dWiTsqmNi3GkSOyD9P+ya5E=
Date: Fri, 27 Mar 2026 13:55:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Support struct btf_struct_meta via
 KF_IMPLICIT_ARGS
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>,
 Kernel Team <kernel-team@meta.com>
References: <20260318234210.1840295-1-ihor.solodrai@linux.dev>
 <CAADnVQ+iXJK46cFcGN-Ta8KGxe7Y+m_DxgWNS=QC-gOWT=WxCw@mail.gmail.com>
 <b040711c-0fd1-475f-b807-e4e0b4324f6e@linux.dev>
 <CAADnVQKVEYhFXGXJ0u6TWQDe4t=zmq_tLpGKe2n_pOYT-J58qA@mail.gmail.com>
 <21e5333c-0b57-46ce-99c8-f6c414270e70@linux.dev>
 <CAADnVQ+bj2z0kzLcGTJ62NJgReTvqEu8fn6=7=bn+WKmfe9iTQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAADnVQ+bj2z0kzLcGTJ62NJgReTvqEu8fn6=7=bn+WKmfe9iTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 3/27/26 1:48 PM, Alexei Starovoitov wrote:
> On Thu, Mar 26, 2026 at 12:13 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> [...]
>>
>> The above works, and the question now is if we like this mechanism
>> more than current setup with explicit enums.
> 
> Got it. Thanks for the explanation.
> Your approach does sound a lot better than explicit enums.
> Make a proper patch out of it.
> 
> If we do this can we remove <counter><line> approach everywhere
> while at it and only use named ?

This crossed my mind too. I'll try to *replace* the suffixes and if
it works fine submit that.

One inconvenience is that with named suffixes BTF_ID() macro will
have to accept an additional arg (the list name), but I think
that's ok. We already have to pass struct/func everywhere too.


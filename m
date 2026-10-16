Received: from mta0.migadu.com (out-100.mta0.migadu.com [91.218.175.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3534255C1CE
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172412; cv=none; b=JJgD+CqKzw5CGya/5aRDkqmgUsMhMprck6J4doo80KDrGYI5sEQiL9gnYTx20l7Q08oPDr0xolVQay3ENG8CNxn7G2zBVds8MnlJ7PVUB1uv9HfTT28rQ3simq6JntOPENAoAWFrCy9BTTlMCfwLx4366ar2dadkJWU+lZr60p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172412; c=relaxed/simple;
	bh=z+C4Se9BeGPNK4NErnTTmR/XD4qG0OhezLPkQ7okpdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OmW6CN6wn3kuUKwmWiX9jd2QbgAJOSYj3YntwPvGATzqxNI17IfF2qWG2umAef4PwfdA2tzPAEzc6iUh3UtWWMCQE4D42MWahvsxIyso/bbryexp590n0cr+7AOzEE1ZOQLZ6RFmy8i/ofQbSqf0mhTODVgH1m4Ufgs4NxIWftY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IJD4skq1; arc=none smtp.client-ip=91.218.175.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IJD4skq1"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=z+C4Se9BeGPNK4NErnTTmR/XD4qG0OhezLPkQ7okpdQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792172407; v=1; x=1792777207;
 b=IJD4skq1IQNIYBpTdpOhBPPvnfHQPSkY+fMoug5zbuI7ZTgo/iSl7tT64eaVrG0C6u+RyZh1
 v/H9bQ1szq/hKIUzOkOx/RA5I41A/gvUsXaHqJJxXDva4MbaZGk9ZSo2HF/qzDC4YYBy5SYJ58f
 bjrnWhDcbykAJe28YZJgULr8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d5e4133b1b50294d;
	Fri, 16 Oct 2026 17:40:06 +0000
X-Mizu-Trace-ID: d5e4133b1b50294d
X-Migadu-Flow: FLOW_OUT
Message-ID: <b62cef2d-1353-4721-9a85-e89036f51250@linux.dev>
Date: Fri, 16 Oct 2026 10:40:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 1/8] bpftool: Dump C from a detached BTF copy
To: Alan Maguire <almagui@kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
 <DM5V83GMXC13.B0KDKO805LCG@gmail.com>
 <f59b81f4-74e6-46c5-bc0a-ad12ce2ecb53@kernel.org>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <f59b81f4-74e6-46c5-bc0a-ad12ce2ecb53@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-10-16 2:44 a.m., Alan Maguire wrote:
> On 10/16/26 2:18 AM, Alexei Starovoitov wrote:
>> On Thu, Oct 15, 2026 at 05:00 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>> Modifying the parsed BTF fails for some valid input: libbpf refuses to
>>> modify BTF whose header carries unknown nonzero extension bytes, so
>>> such a dump would stop with -EOPNOTSUPP.
>>>
>>> Dump from a flat copy built with btf__add_type(), which only requires
>>> the destination to be modifiable.
>>
>> can we do btf__new_empty_split(btf) and add decl attrs there
>> instead of copying all types ?
>> It fails on such BTF only because btf__add_str() does
>> btf__find_str(base) and that calls btf_ensure_modifiable(base).
>> The lookup shouldn't need it.
> 
> +1 on using split BTF for new decl tags; even in the case of module
> BTF we can use multi-split BTF to cover decl tags for vmlinux and
> module BTF I think.

Yeah, these are good points.

I briefly considered this, but didn't look closely at what needs to
change in libbpf to make it work and just went with the copy. The
libbpf fix should be simple, I'll use a split in v2.

Thanks.


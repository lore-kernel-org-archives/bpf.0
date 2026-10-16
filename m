Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C073F9F5B
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 09:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143895; cv=none; b=UUyNQXlEMAZ9FpkTpARXecAjcghEx2y+93Gy9JxiQyD0k3vz4NzAguSKILlKuhyFJ4sIwapbP4FGiv6XMDve+/35lMCi+xtg6ZRJe4g6vI9+CvJed6a/zRyOeT0DCsKwJJ68LJCQvk+eeoiY/0t/o2g27+52/e6Prf9Wv33CN30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143895; c=relaxed/simple;
	bh=pOJg4bE2iXJWDgZAd1CLbs24z3vH2truCTy9zkn+zPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OMYjjrGX2jGHna+w+dd8ZZjkru7mJorX7Q7I78qAlxoFvpcZDlL4M8YcngLz1KQg2TuGaG0h+fMWY1d7m/1tQDzSj4gBNLQHygp6apAdlYtYXQg7zQtIzX+W9yOm/H4u94NAqEuUAVnsnorihTyIv5Zz6UKGdY9P7BzxnBxLvPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBqXXS9z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBqXXS9z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA371F000C4;
	Fri, 16 Oct 2026 09:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792143894;
	bh=8O2UWqRPaWzy05KK+6MXx1lL8jbA2Dl5vUCn0jpfpbA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZBqXXS9zWBvuDFSYWAYPI9WA8LRIqitYck498gMMUdPXSDiiJl4ya/gJGVxTpX/4f
	 fl8cywIvpySQoydBrwDCZnkIH86SjHMhulS1OoSM6Ra8VV4YKHNtxyUuaKKkb+EoEs
	 mDor8pLBMZzs95OHqZzfbF3CaaBPF4uCG4qFfXVK/lgKsoZZLECZlq4sujBN7o44LF
	 g3Rt2z64hcOw7hld1SE/NN/uwSJ4fzjVr9Jot1ctaHWp9YKEg1BU0Ee2VrUi6/i6zH
	 XikWAbnCR0X82YVbz5CwdvmxLGWdNWIvTClUe5VgjG94BY50WdVtUwM8Z2ixx6uei0
	 oI++OU92fgbxQ==
Message-ID: <f59b81f4-74e6-46c5-bc0a-ad12ce2ecb53@kernel.org>
Date: Fri, 16 Oct 2026 10:44:49 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 1/8] bpftool: Dump C from a detached BTF copy
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Andrii Nakryiko
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
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
Content-Language: en-GB
From: Alan Maguire <almagui@kernel.org>
In-Reply-To: <DM5V83GMXC13.B0KDKO805LCG@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/26 2:18 AM, Alexei Starovoitov wrote:
> On Thu, Oct 15, 2026 at 05:00 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>> Modifying the parsed BTF fails for some valid input: libbpf refuses to
>> modify BTF whose header carries unknown nonzero extension bytes, so
>> such a dump would stop with -EOPNOTSUPP.
>>
>> Dump from a flat copy built with btf__add_type(), which only requires
>> the destination to be modifiable.
> 
> can we do btf__new_empty_split(btf) and add decl attrs there
> instead of copying all types ?
> It fails on such BTF only because btf__add_str() does
> btf__find_str(base) and that calls btf_ensure_modifiable(base).
> The lookup shouldn't need it.

+1 on using split BTF for new decl tags; even in the case of module
BTF we can use multi-split BTF to cover decl tags for vmlinux and
module BTF I think.

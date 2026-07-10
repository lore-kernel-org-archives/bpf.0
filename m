Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8342F25B0B6
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 02:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783648931; cv=none; b=jluolPubWCNrvgP9e9xiglfhs0A5mcGca6wIgLzKrD5WhkokxUcNlBQiEC3K75irkYM4q1/65ylgyqOQW9Qa5QeyuBBgn2LcGH0E2O10wmdMgTWg7bdA6os2BgxNdZftmCXmOyG03fr+LHzOsWXBovZGg/1DWT1/+Z+C+GBrKMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783648931; c=relaxed/simple;
	bh=1tqW0HCnGJV3gPK0Wd7HCH+GhrrkOBNyH1sirP8RGgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xa16EcoMW22NE2I2iVcY/PZwnWPegz26bMyEzPA1pozjIXd2mOvO3FJvv5q1Xe8uEojPsbYa2x/Y6hg/oABpLMhpVof4nFgxpK+p+rTQjhZ0a1x3V+f2lpDMw3+cYdp4d2ChtYzMj8/UPblr46qrQRdihhf/Sk+j9j4BeD5DIbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l+vjBnM7; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l+vjBnM7"
Message-ID: <245ec82f-4301-4fd5-b10f-8ce1b191b6f3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783648925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9pSvxvTLCeh72Ru+OhnYGfMiou7sRoWstPj60oLeSpw=;
	b=l+vjBnM7x0iQXCa3CCpDzGnf4ZlWHlFOHgaTj/kIQSnL0byDYA/hVq9WieBKkurQXYxkq8
	zNNCS2FcB+hYViiiNjcChIQsEslaSNXmff/dNlXkK3euvBDe9Jh1sfl9Bsq8sx+Yw3ytWR
	P4ulDgswVQkLXng+/bM84KjbEZS2lEk=
Date: Fri, 10 Jul 2026 10:01:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 07/12] bpf: Reject >8 byte return values on
 return-reading trampoline paths
To: Yonghong Song <yonghong.song@linux.dev>, Leon Hwang
 <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
 <20260708201015.2159760-1-yonghong.song@linux.dev>
 <b1e6bb7d-8729-4baf-b64a-e514118fef75@linux.dev>
 <61150c2e-948e-4dc7-ab00-09547906bc1d@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
Content-Language: en-US
In-Reply-To: <61150c2e-948e-4dc7-ab00-09547906bc1d@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/7/26 00:52, Yonghong Song wrote:
> 
> 
> On 7/8/26 8:16 PM, Leon Hwang wrote:
>> On 9/7/26 04:10, Yonghong Song wrote:
>>> btf_distill_func_proto() builds the function model used for kfunc calls,
>>> the fentry/fexit/fmod_ret/fsession trampolines and struct_ops. A
>>> following
>>> patch relaxes it to accept a >8 and <=16 byte return value, which for
>>> the
>>> BPF target is passed back in the R0:R2 register pair.
>>
>> Do you have a plan to add >8 byte return value support for them?
> 
> I tested with vmlinux BTF built from the latest bpf-next. I got (from
> vmlinux BTF):
> 
>    total number of functions: 67500
>    return type size (> 8 && <= 16): 51
>    return type size (> 16): 10
> 
> So in the initial version, I didn't support >8 byte for trampoline related
> bpf programs.
> 
> But I can certainly do this, we just need to allocate another 8 byte for
> return value
> in trampoline.
> 

The following support should be mentioned in the cover letter.

Thanks,
Leon


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792774279;
	b=WfBRui/QtpCPbD4p1r3jrBvs/qX7SZsOKzW1Jzj01+wEIoOhnn55W7AC1AYd6i3II5A8
	 2JUgkQXhDvB6J/Z3Sf5ST8oXvgxvS3xsopee4OPBaRspuUYn0mRJi+vOz4UgfK1pU3VVz
	 6B91RskONatn1pEWo6JNUY9R1/nJiHZYRhuqMlVq2kMon/VPOE3muSeD6SsocFwhCIbIe
	 tu4PLs6u2VeQRE4GHN0o5VQh20sK2/LP4Rg5sEHymlwVBV28i2QzI/OTX8xRrZIFaZpQv
	 g9zsjacvyIg/aBN1Lv94UqYco7XTzvsJtM+l6Xl66Uyqowbu4uNB5uMANF3NbL1oRcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792774279;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=cFqEgYrBw+qYgIhudWkQb+5FXjEgcrd0aSkwH7+IoZ8=;
	b=HyuMZ5Vxc+04o2r95zZYUCNDqSX80QmSOHFMe6W7GW2WtuBhbIjo5oP3mmq+Az26J+BE
	 aoDKZjWMoOCaehDrNYDZA8fdVT9T2RmM0fG4Qsk8vyNhNmtcTG3pcFdadUzuGCZ4b1TfC
	 5/GH+r4Pw/u3y0+YjdYjpuIlafJjlfn7bM0imMWVzTLRaIjqyZu5gVqvWeNl1niVMcD1h
	 aNh1GDUvpsPGAZtjwEs7b8mikY4rQ9iiK2Fdp6lptTPW/oawprrQg9rxsf3C5XTWGZPZ8
	 JGlowQDW+W+Rmk81cv6LV7MoUfyntbrgnaL8AE3Y/hzd8iO0RQpCXK0bRhzRpYSBdEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nvU75Nui;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C85606A31A
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nvU75Nui
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B0E1F01828;
	Fri, 23 Oct 2026 16:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792774279;
	bh=cFqEgYrBw+qYgIhudWkQb+5FXjEgcrd0aSkwH7+IoZ8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nvU75NuirYefNI3A3ZtG/z+wuPENs5qmJX180kBBom29EzyCN5yhurQMfLbLZUSY+
	 DpaIMaBguNwB0Sx00sUca6fI8yDzSHAHPriyGVBXxjA+agHztZaQnXsz0WHyJfKCs3
	 gWaC7HCgMNmC6Jrd4a+M610NHzm7kISF1N59qi9OavEn+pwXleVpb8pEEVxTpgmjwc
	 U4Gikx5/yLA5kldYj/nMjtyi0zFiZCAu4LyBdBl9W3Wxo9NSTKU+nAAeh7c681uAXh
	 g2QCNPeWkLZ630imexiRI7aOri+BrfbnOjE8ZD8VTP5015nrvQp/l5DYPNlfQ6tVcs
	 wvPQpyYmtQzVw==
Message-ID: <ec68350c-f1cc-40a8-84e1-14b63117972f@kernel.org>
Date: Fri, 23 Oct 2026 17:51:14 +0100
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
Subject: Re: [PATCH bpf-next] bpf: Propagate btf_add_type() errors in
 btf_check_all_metas()
To: Mahe Tardy <mahe.tardy@gmail.com>, Feng Yang <yangfeng59949@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, bpf@vger.kernel.org
References: <20261022064727.747304-1-yangfeng59949@163.com>
 <atuNUC7MrIBIsN5X@gmail.com>
Content-Language: en-GB
From: Alan Maguire <almagui@kernel.org>
In-Reply-To: <atuNUC7MrIBIsN5X@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/26 5:37 PM, Mahe Tardy wrote:
> On Thu, Oct 22, 2026 at 02:47:27PM +0800, Feng Yang wrote:
>> From: Feng Yang <yangfeng@kylinos.cn>
>>
>> btf_check_all_metas() ignores the return value of btf_add_type(), so a
>> type that could not be registered is silently dropped while the loop
>> keeps walking over the type section.
>>
>> Both failure modes are reachable:
>>
>>   - -E2BIG.  Once the types array reaches its capacity (BTF_MAX_TYPE),
>>     every following btf_add_type() fails the same way, so
>>     btf_check_all_metas() still returns 0 and the BTF object is created
>>     with btf->nr_types capped while hdr->type_len claims more records.
>>
>>   - -ENOMEM.  btf->nr_types is not incremented and the array is not
>>     grown, so the next type is recorded at the slot of the dropped one
>>     and btf->types[] stays off by one with respect to the type ids for
>>     all remaining types.  btf_type_by_id() then returns the wrong type
>>     for those ids for the whole lifetime of the object, and the last
>>     type is silently left unresolved.
>>
>> Propagate the error so that the object is rejected instead.
>>
>> Fixes: 69b693f0aefa ("bpf: btf: Introduce BPF Type Format (BTF)")
>> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> 
> Reviewed-by: Mahe Tardy <mahe.tardy@gmail.com>
>

Acked-by: Alan Maguire <almagui@kernel.org>

Thanks for the fix! 
> As sashiko pointed out, also makes sense in the context of this other
> patch: bpf: Fix out-of-bounds btf->types write for split BTF[^1].
> 
> It seems it dates to the original introduction of this codebase with no
> good reasons given the two points above listed by Feng.
> 
> [^1]: https://lore.kernel.org/bpf/20261023063133.563998-1-yangfeng59949@163.com/
> 
>> ---
>>  kernel/bpf/btf.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index d870bc5e50bc..80b6f96263f1 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -5459,6 +5459,7 @@ static int btf_check_all_metas(struct btf_verifier_env *env)
>>  	struct btf *btf = env->btf;
>>  	struct btf_header *hdr;
>>  	void *cur, *end;
>> +	int err;
>>  
>>  	hdr = &btf->hdr;
>>  	cur = btf->nohdr_data + hdr->type_off;
>> @@ -5473,7 +5474,10 @@ static int btf_check_all_metas(struct btf_verifier_env *env)
>>  		if (meta_size < 0)
>>  			return meta_size;
>>  
>> -		btf_add_type(env, t);
>> +		err = btf_add_type(env, t);
>> +		if (err)
>> +			return err;
>> +
>>  		cur += meta_size;
>>  		env->log_type_id++;
>>  	}
>> -- 
>> 2.25.1
>>
> 


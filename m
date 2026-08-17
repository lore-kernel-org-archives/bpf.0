Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA2D3AFD18
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 08:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786954141; cv=none; b=N7O6hIfzh05Y1gkB8flLOZtjCOiIJ5rtkV9KZQvunVa4hNeHu4s5GeRSL9a+81AhnrlKqlCpBNsPVfzqjzFgkP82/s9yJ0OYEYhXfY/9qCq5ZpPGSUD0QjYmvRx7nmOqO9lmc7F/m6Q4ebACwH/R+vFWWCdJxy2nEy58gLIsPbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786954141; c=relaxed/simple;
	bh=m4XOK46BcY5inScuiaFlfNLeBU/cXuSd/ZLWrs+hQcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jh7Q5fppRMg+sw9YbM7lSCCwz/PMWMLiyDBNfe8wJDLpCekcRH3KE1fm7k1EmSvvhUx0mjMWnOF9s+aS9Dk9FYlKsegd4UtBjoSklSnJIxJ9JA0DfNcVgnhDpkKrWG2zOXrE9AVsvGM0GLM/TQoFmk3MZAumlYSTgJejjNiCMbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=CQGAfEYV; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="CQGAfEYV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=x9HrhWpaaCI8CVUCgkunC6X7b3qTLyo+GNO5J57H+fg=; b=CQGAfEYVyG9X6GzTtMNkWXkH/m
	+gieG1gKkUPJXOvDSylyST3NSYn9VL2KNx+hdO1y/ZVvNkbfbtJ4MUZ2+8anTd2SnrsYOsVdeb6nc
	lUY9x7YOWmubwRyzZIbQ54h2HyoyC7Bi6YBHjayrzN2Plv7a+9zpZ9hjQhv2/V5kZrsTkbrJk626d
	T9uwEv7KBHshvN4aN1205zLHuNHfw/M4uhGRO/1WvkvtuKm2f4/YycoHDYE4VD54DJNdL1nHMo2P2
	BHJulNUhaOK3eRztPvQBmB8EwUquc3oy8wtVpE5ySuk24/L5bqp9TAew6pdckeE8LfAN2fpwu8Uxz
	DwsoSCYw==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wvsOo-0005O3-11;
	Mon, 17 Aug 2026 10:08:50 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wvsOo-0008DP-1J;
	Mon, 17 Aug 2026 10:08:50 +0200
Message-ID: <6e83e8f2-3b69-40c9-a516-d947568bff57@iogearbox.net>
Date: Mon, 17 Aug 2026 10:08:49 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 5/6] selftests/bpf: Add tests for pointer type
 merge at a shared load
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: memxor@gmail.com, bpf@vger.kernel.org
References: <20260814215301.709827-1-daniel@iogearbox.net>
 <20260814215301.709827-5-daniel@iogearbox.net>
 <2d1e698da4802d4c1870f60db8e201333eeba05a.camel@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <2d1e698da4802d4c1870f60db8e201333eeba05a.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28095/Mon Aug 17 08:23:59 2026)

On 8/17/26 12:32 AM, Eduard Zingerman wrote:
> On Fri, 2026-08-14 at 23:52 +0200, Daniel Borkmann wrote:
>> Cover the ways in which the type recorded for a shared load used to lose
>> the BPF_PROBE_MEM rewrite which would then trigger a NULL deref if not
>> handled properly.
>>
>>    # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t mem_rdonly_untrusted
>>    [...]
>>    #238/1   mem_rdonly_untrusted/btf_id_to_ptr_mem:OK
>>    #238/2   mem_rdonly_untrusted/ldx_is_ok_bad_addr:OK
>>    #238/3   mem_rdonly_untrusted/ldx_is_ok_good_addr:OK
>>    #238/4   mem_rdonly_untrusted/offset_not_tracked:OK
>>    #238/5   mem_rdonly_untrusted/stx_not_ok:OK
>>    #238/6   mem_rdonly_untrusted/atomic_not_ok:OK
>>    #238/7   mem_rdonly_untrusted/atomic_rmw_not_ok:OK
>>    #238/8   mem_rdonly_untrusted/kfunc_param_not_ok:OK
>>    #238/9   mem_rdonly_untrusted/mixed_mem_type:OK
>>    #238/10  mem_rdonly_untrusted/mixed_mem_untrusted_btf_id_type:OK
>>    #238/11  mem_rdonly_untrusted/mixed_mem_btf_id_type:OK
>>    #238/12  mem_rdonly_untrusted/mixed_rdonly_mem_btf_id_type:OK
>>    #238/13  mem_rdonly_untrusted/mixed_mem_mem_type:OK
>>    #238/14  mem_rdonly_untrusted/mixed_map_value_mem_type:OK
>>    #238/15  mem_rdonly_untrusted/mixed_stack_mem_type:OK
>>    #238/16  mem_rdonly_untrusted/diff_size_access:OK
>>    #238/17  mem_rdonly_untrusted/misaligned_access:OK
>>    #238/18  mem_rdonly_untrusted/null_check:OK
>>    #238/19  mem_rdonly_untrusted/ldx_is_ok_commuted_addr:OK
>>    #238/20  mem_rdonly_untrusted/helper_param_not_ok:OK
>>    #238     mem_rdonly_untrusted:OK
>>    Summary: 1/20 PASSED, 0 SKIPPED, 0/0 FAILED
>>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
[...]
> 
> GCC-BPF fails for the series [1]: because of the difference in
> codegen some __msg patterns do not match. How would you like to handle
> this, land first 4 patches and do the tests as a follow-up or as a v3?

Yeap, I'll push the 4 fixes and send the selftests as follow-up and add
one as well for the bpf qdisc one.

Thanks for the review!
Daniel

> [1] https://github.com/kernel-patches/bpf/actions/runs/31970050902/job/95222785689
> 
> ...
> 


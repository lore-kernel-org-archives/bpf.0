Received: from mta1.migadu.com (out-195.mta1.migadu.com [95.215.58.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CA63DAAD2
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 16:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341218; cv=none; b=kpcAuyE+Jg0LraNDEe1fDGMdrjD36A+7JHH8BYnv5Khv4Cr1RH4PXWa6s8FQ3JZ8gHX3Df2B7hdE7Gwt+qomsMlZkY1BFxCJ0Fo/GUaP8Hl8xLLAe0bl+mLzenpC/QMPSJMMfN/xTZlHQcVLLmz0RIlMsu4ZLQRq0YZeAJVLcBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341218; c=relaxed/simple;
	bh=fwOw3eqwEIOqybjjAJDDdPhaGAScdIoPMfsgoZAj0Rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h1z462weDUrbzMYXcjkpPQ8tmP8tk85JHEn3EQdr71KEk3+POoAgIk/ynugduZsmwlCWGAlcMnHExCKL8oIKbRfIDDcTFguzuAX32RcWJ46vhChVWh9xynct79Ce92I8IpgcntZTwpOEI3vWTtvf4fkXTL0dCj4HFTVp7auiX0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wveEgMyO; arc=none smtp.client-ip=95.215.58.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wveEgMyO"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fwOw3eqwEIOqybjjAJDDdPhaGAScdIoPMfsgoZAj0Rs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792341212; v=1; x=1792946012;
 b=wveEgMyOBWq9vUsHNN5ijR8M8EcyN3CgTyDeH5t+41g+S4DoYZDQUrd1n/5hcCCYDUqeY+TA
 N93445JAQJiR4Y3vCBRAVmeP2wB4dLxE6WeLgjzRuGU5AjhNEYpQ/k/j6HVHQIH3UCnJo3wPoRo
 EclqAGB63yuZ+R02EILqm9Tc=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5a78a752332e31e8;
	Sun, 18 Oct 2026 16:33:32 +0000
X-Mizu-Trace-ID: 5a78a752332e31e8
X-Migadu-Flow: FLOW_OUT
Message-ID: <a2d2baee-68f1-4f92-ba64-0863621b0882@linux.dev>
Date: Mon, 19 Oct 2026 00:33:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 5/6] libbpf: Add bpf_link_create_log API
To: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
References: <20261017142649.51047-1-leon.hwang@linux.dev>
 <20261017142649.51047-6-leon.hwang@linux.dev>
 <sashiko-outbox-175565@kernel.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <sashiko-outbox-175565@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2026/10/17 22:43, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] libbpf: missing OPTS_VALID() check for log_opts in __bpf_link_create()
> - [Medium] libbpf: bpf_link_create_log added to released LIBBPF_1.8.0 in libbpf.map
> --
> 
> commit 5adb04f5088a9ab6aa21d83e4c9370c13ebdaab6
> Author: Leon Hwang <leon.hwang@linux.dev>
> 
> libbpf: Add bpf_link_create_log API
> 
> This commit introduces the bpf_link_create_log() API to pass struct
> bpf_log_opts when creating BPF links without modifying struct
> bpf_link_create_opts.
> 
>> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
>> index 17e73e443bc7a..eb127d71f3c83 100644
>> --- a/tools/lib/bpf/bpf.c
>> +++ b/tools/lib/bpf/bpf.c
>> @@ -788,9 +788,10 @@ int bpf_prog_detach2(int prog_fd, int target_fd, enum bpf_attach_type type)
>>  	return bpf_prog_detach_opts(prog_fd, target_fd, type, NULL);
>>  }
>>  
>> -int bpf_link_create(int prog_fd, int target_fd,
>> -		    enum bpf_attach_type attach_type,
>> -		    const struct bpf_link_create_opts *opts)
>> +static int __bpf_link_create(int prog_fd, int target_fd,
>> +			     enum bpf_attach_type attach_type,
>> +			     const struct bpf_link_create_opts *opts,
>> +			     struct bpf_log_opts *log_opts)
>>  {
>>  	const size_t attr_sz = offsetofend(union bpf_attr, link_create);
>>  	__u32 target_btf_id, iter_info_len, relative_id;
>> @@ -965,7 +966,7 @@ int bpf_link_create(int prog_fd, int target_fd,
>>  		break;
>>  	}
>>  proceed:
>> -	fd = sys_bpf_fd(BPF_LINK_CREATE, &attr, attr_sz);
>> +	fd = __sys_bpf_fd(&attr, attr_sz, BPF_LINK_CREATE, log_opts);
> 
> [Severity: Medium]
> Should __bpf_link_create() validate log_opts with OPTS_VALID(log_opts,
> bpf_log_opts) before passing it to __sys_bpf_fd()?
> 
> Currently __bpf_link_create() validates opts, but not log_opts:
> 
> tools/lib/bpf/bpf.c:__bpf_link_create() {
> 	if (!OPTS_VALID(opts, bpf_link_create_opts))
> 		return libbpf_err(-EINVAL);
> }

Will move OPTS_VALID(opts, bpf_link_create_opts) to __sys_bpf_fd() in
the next revision.

> 
> When a caller passes a malformed struct bpf_log_opts (such as an invalid sz
> or non-zero unknown trailing fields) to bpf_link_create_log(),
> __bpf_link_create() forwards it directly to __sys_bpf_fd(), which accesses
> log_opts via OPTS_GET() and OPTS_SET() without checking OPTS_VALID().
> 
> For comparison, bpf_map_create() validates log_opts before calling
> __sys_bpf_fd():
> 
> tools/lib/bpf/bpf.c:bpf_map_create() {
> 	log_opts = OPTS_GET(opts, log_opts, NULL);
> 	if (!OPTS_VALID(log_opts, bpf_log_opts))
> 		return libbpf_err(-EINVAL);
> 
> 	fd = __sys_bpf_fd(&attr, attr_sz, BPF_MAP_CREATE, log_opts);
> }
> 
> [ ... ]
> 
>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>> index eeba4072a5dac..990e2f926ecc3 100644
>> --- a/tools/lib/bpf/libbpf.map
>> +++ b/tools/lib/bpf/libbpf.map
>> @@ -458,6 +458,7 @@ LIBBPF_1.7.0 {
>>  
>>  LIBBPF_1.8.0 {
>>  	global:
>> +		bpf_link_create_log;
>>  		bpf_map__attach_cgroup_opts;
>>  		bpf_prog_stream_open;
>>  		bpf_program__add_flags;
> 
> [Severity: Medium]
> Should bpf_link_create_log be placed under the LIBBPF_1.9.0 stanza in
> tools/lib/bpf/libbpf.map instead of LIBBPF_1.8.0?
> 
> LIBBPF_1.8.0 is already succeeded by LIBBPF_1.9.0 at the bottom of
> tools/lib/bpf/libbpf.map:
> 
> LIBBPF_1.9.0 {
> } LIBBPF_1.8.0;
> 
> Adding bpf_link_create_log to LIBBPF_1.8.0 exports the new symbol under the
> previous version node rather than the current LIBBPF_1.9.0 development cycle.
> 

Oops. Will move it to the LIBBPF_1.9.0 section.

Thanks,
Leon


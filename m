Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C323EFD3D
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 10:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787653291; cv=none; b=t3OhbXyFVU0jafw6VqUNkogrvXZxb+LdE+mx0vdI4UHG0NwxJE4rUJkrr2GMhCbzC9ghLtty0nef1BdqXqEUBG74JSx/6A7kvT4+uMBsULIqMJUs4v8OemuO1AAct1yB4A3hQ6RI7XmdTbLYk0WN9BmV0Ia1Pw7MpYtlPHRq9Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787653291; c=relaxed/simple;
	bh=gb/tLdLrlfHXhuPQSVz1y27HTVyNt5PGDlFHCMrOkio=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZzeNCMoHtARN5rsd4I1PYdoUgOKIQXXwH4z/DiD5DzW3+xCYQ8+8VoSYNbn1mN11L1r0yM7kNE934Lk37Bil09NxtS9k/wCIJh8YVQCnkUDi1Jd2Pxug5f/hGzUxud0pehcdofE6/IKFR8WzzbULCS/kexF2roDMy2XhUQweQeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=hr7d8a/i; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="hr7d8a/i"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 0840387E39;
	Tue, 25 Aug 2026 12:21:26 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wUicToN18WNR; Tue, 25 Aug 2026 12:21:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1787653284; bh=gb/tLdLrlfHXhuPQSVz1y27HTVyNt5PGDlFHCMrOkio=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=hr7d8a/iPoxUEM1qDEA+rUUKm05SL9vTjujnOUvV8Kmgf+NRknV33TI7ZxCYEIvLe
	 p86REGiJ5JTn+TGt4qP/jAs2ICUOYmkcuCPwIjSou53FOnZKsRiAB32HDBRXrFPmXS
	 XFoy96Nvenb8p84qEXTtMett4a/EZ8UkwjPMKcoICdd1W/xWdfvJmOuQPruzmWcJg5
	 y8Hrq5jl9vPAi7Lr2AaGvkfTYOCgfqFm8KGsaq9h0Su/+B1uhSywDPFMfr//XW+Ib/
	 IvsjLPfRKmPCXmZFChvHYotn9cTrDbS8aeKLIQgasUu3Gib+++I1NqOP+IYnFO2ndU
	 R1ErBpcQTwuVg==
Message-ID: <317cc6ae-eeb6-4de1-b986-cdbaa16bcc2f@disroot.org>
Date: Tue, 25 Aug 2026 11:21:18 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Masoud Aghasi <maghasi@disroot.org>
Subject: Re: [PATCH] bpf: Fix u32 overflow issue in map batch operations
To: bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, john.fastabend@gmail.com,
 brianvv@google.com, maghasi@disroot.org
References: <20260824113123.270057-1-maghasi@disroot.org>
 <20260824114216.6CFFE1F000E9@smtp.kernel.org>
Content-Language: en-US
In-Reply-To: <20260824114216.6CFFE1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/08/2026 12:42, sashiko-bot@kernel.org wrote:
> 
> [Severity: High]
> This is a pre-existing issue, but does key_size * bucket_cnt or
> value_size * bucket_cnt also need a size_t cast here?
> 
> If value_size * bucket_cnt exceeds 4GB, the 32-bit integer overflow would
> truncate the length argument to copy_to_user() in
> __htab_map_lookup_and_delete_batch(), causing it to copy less data than
> expected. This could result in silent data loss since the elements are
> permanently deleted from the kernel map, while the syscall falsely returns
> success.
> 
>>  	    value_size * bucket_cnt))) {
>>  		ret = -EFAULT;
>>  		goto after_loop;
> 

Yes, I was able to produce "bucket_cnt > 1024" using a map with
BPF_F_ZERO_SEED flag set, 64bit key_size and generating an special
sequence of keys using the below code:

```c
int counter = 0;
__u64 keys[1025];
for (unsigned long i = 0x10000; i <= 0xffffffffffffffff; i++) {
  if ((jhash2((__u32 *)&i, 2, 0) & (0x10000 - 1)) == 0) {
    keys[counter] = i;
    counter++;
    if(counter > 1024)
      break;
  }
}
```

So the overflow is possible and I will include the fix in the patch v2.

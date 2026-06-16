Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33783C5838
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 04:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781583495; cv=none; b=X1ZptWs6jxyDKD/fmOboRUnbf/UULydEzcrzkPc8jolNaxJ8NrKSIZsJOIADRKYC8b6LvFAKdtMIRU2gKEEGKnYzUajZAKWbWVvsIESOGtcwhSh4px0glqYLqxWyVfBdgpmzYbOaaoXsiIYqXNZIS7o73oN6GEv+CNxGZlzD78U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781583495; c=relaxed/simple;
	bh=c3EHK/GDQ9/UgN/+TZkX+9madTRbccOtKjwDz4S1P8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=btdcV3NGYYhyv8jip76VXFywcIs7mmdRCbmFQy9OB/qQUB9Y1NnFFTBYWEfmEj+poVWhxx8xA00CobZqH9Df9of3cD8SeUSwsB3G4Gaf5dfMBmDRacJGT0A7U6BWuraEQNZd782kbf5JNDyBAZF01lusMpfmG+vSlLWWPOY5KNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fTEBNbRE; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fTEBNbRE"
Message-ID: <eee4d7d4-fb6c-4222-9cc7-82201bc1c85e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781583491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NUIeb3r0a9LpD0Mvbud4KGe9ON8KSsYcNR1A5GmnpTk=;
	b=fTEBNbREdh8kldnrtIec+bGJ4jDdl9ww8vCmJJZ3iMUhVM9cg922vySjxoy7xN9Z+JT93e
	G6u+cbuob5BFM/tKePQTeUGH5TSM59gUud4iCmEQfpmB2z3hCDYvvA8OD1QFPVpq39gSxd
	q9Ll5tUCP2nZ02BbpU1/AFpLgUO8wWw=
Date: Tue, 16 Jun 2026 12:18:03 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 10/12] selftests/bpf: Add tests to verify
 verifier log for global percpu data
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260615152646.27639-11-leon.hwang@linux.dev>
 <20260615154049.6A4161F000E9@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260615154049.6A4161F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 15/6/26 23:40, sashiko-bot@kernel.org wrote:
[...]
>> +SEC("?kprobe")
>> +__failure __msg("R{{[0-9]+}} points to percpu_array map which cannot be used as const string")
>> +int verifier_snprintf(void *ctx)
>> +{
>> +	u64 args[] = { data };
>> +	char buf[128];
>> +	int len;
>> +
>> +	len = bpf_snprintf(buf, sizeof(buf), fmt, args, 1);
> 
> [Severity: Low]
> Should this be passing sizeof(args) instead of 1?
> 
> The bpf_snprintf helper requires data_len to be the size of the data array
> in bytes. Passing 1 makes the test brittle if the verifier's argument
> evaluation order changes in the future, as it would fail on the data_len
> argument before checking the fmt argument.
> 
Will use sizeof(args).

Thanks,
Leon


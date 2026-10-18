Received: from mta1.migadu.com (out-32.mta1.migadu.com [95.215.58.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A264F3D1ABD
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792340937; cv=none; b=Gg4YAS02UxbmGQwme62lOEZcOF1hTCdkyko0NL/oX6hO5e/Rk4y1ksSXtNA30KqoDJfi//Fyi89AqgEA+r72tyIV7h5/UjHsZ0IhIwIjt3xv58WKGFOH6i2bwOgFrEX8LmBI5POe+3DdM4sdCeuLFvylzHVbEWLIMYS8l6Bce28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792340937; c=relaxed/simple;
	bh=L42fux9FkX7PdFA0Fbfsqg8O/3baLdxzaRMtvglaHYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h7s//eN+vfKs5LlNCnLmqOGpTsY7GN6Xn94VKv+kVRGviDMVkx4EnGdi5J4LeAEBE62qTU0wyXxZppP7OjNhngyT3oCRPmoQiN4URQqdCWPG2UZbPVrT+2x0z3Vz3Gh58Xzi5tGiOjXDCKxk++2rsPQRumM/HjA5x+/r2ip44jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sjCLl7hz; arc=none smtp.client-ip=95.215.58.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sjCLl7hz"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=L42fux9FkX7PdFA0Fbfsqg8O/3baLdxzaRMtvglaHYw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792340933; v=1; x=1792945733;
 b=sjCLl7hzK8/AzsPIANOdRQPqWK1kpU/4pi7aC8CdEmi6UYMc3x3yzhDK4+VyuWAqnSLVb4P/
 NQxO9EzQCJWJMx/u9+j9OlD3eNydBNjf20/pj3YQZ4tzpE7ySCelYOFN/rC3Sc30lSNJ5grJCfg
 pjblbGYVYHDSPNRSWk985q4s=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 67c9c5eea7512f8c;
	Sun, 18 Oct 2026 16:28:53 +0000
X-Mizu-Trace-ID: 67c9c5eea7512f8c
X-Migadu-Flow: FLOW_OUT
Message-ID: <6dc8b3e5-b4fe-45f6-9ed6-137c00e7d7db@linux.dev>
Date: Mon, 19 Oct 2026 00:28:48 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/6] bpf: Add syscall common attrs support for
 link_create
To: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
References: <20261017142649.51047-1-leon.hwang@linux.dev>
 <20261017142649.51047-2-leon.hwang@linux.dev>
 <sashiko-outbox-175562@kernel.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <sashiko-outbox-175562@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/17 22:39, sashiko-bot@kernel.org wrote:

[...]

>>  out:
>> -	if (ret < 0)
>> +	/* preserve original error even if log finalization is successful */
>> +	err = bpf_log_attr_finalize(&attr_log, log);
>> +	if (err)
>> +		ret = err;
>> +
>> +	kfree(log);
>> +
>> +	if (ret < 0 && prog)
>>  		bpf_prog_put(prog);
>>  	return ret;
>>  }
> 
> [Severity: Critical]
> Can this underflow the refcount on prog and leak the newly installed link
> file descriptor if bpf_log_attr_finalize() fails after link attachment
> succeeds?

Correct.

To avoid such prog leak, I'd like to report the log_true_size twice.

ret = bpf_log_attr_report_size(&attr_log, 0);
if (ret)
	goto out;

switch (prog->type) {
	/* ... */
}

out:
if (ret) {
	int err =  bpf_log_attr_finalize(&attr_log, log);

	ret = err ? err : ret;
}

if (ret < 0 && prog)
	bpf_prog_put(prog);

kfree(log);
return ret;

Thanks,
Leon

> [...]


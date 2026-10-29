Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.27
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270000;
	b=fnIzhiuSIUVvGlNymKhSSIy/gt+vMdMY6bO2k5I96HL+ObI7Y5QAjzvwZZNdCETI6e1N
	 LGK4owzRMnGA4SNvZU+dATuIvOVZi9QoeBOfDJJ4ru14BrYFvlDB1qNzQnbZkfqmwGaad
	 QSfVjojyuHKF5LPgTZotyY5bZW38erGAh9/dx3pWZa7sP4B5WWErSvOFnPe4hJDwuE4UX
	 odOVIFMHXnYK5NhX2p5rtzt4WyxgQYINenuAej1ukju6YpPAxOf8/dUrC2Pg5p+ME6c22
	 8c2PQ1tN0NJPL7SOUWF/pPrvbWnA4sQe5RVaynHOuaQj+XjFNhBAEekVfdp5U18ga1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270000;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=AQbbcg15G9Rdgl9nUgK2PYtfP3hcLsC+WTRWlyTICwA=;
	b=ULdXTtfIMKaXPOEAHl3ZUlYTT44VDg9BftyOGBGnC3EKY5oRE2rTf9u9T1SSAPp1Rrpk
	 XRrXN/osPeglDrQOX/wHjWMnKs1JpLWJ7P5dL8tUrlAnS5QPl2yXAMDoMvWx7FFW+xJL8
	 jeKnClAaWcSumeFVKK4vasmMl0QC77ZEFcrDQjWrtdwGkVEAq0g8R3PsgDkDa2ATfdHX1
	 MjVoRMV5qJg2u1HgICUtCk/7yZ2wDnUiQSODFOxzQqGmrfL6kA0M9TSTthnb3bD/OdZQU
	 gwuu6KQPNbd83N8+MTCwGzcgUH9RfQRyeRJfVk+CpZz8DRlbCAm26vpyQ5gMJgLfkHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VcAcw2Oh;
	arc=none smtp.remote-ip=95.215.58.27
Received: from mta1.migadu.com (out-27.mta1.migadu.com [95.215.58.27])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE44606A31F
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 10:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFE44606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VcAcw2Oh
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=J85rkoN1XnhCBt+ZBRQtQySMprDThVLpEudrWZLX1rQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793269997; v=1; x=1793874797;
 b=VcAcw2OhNb8Ngx6ElwFkLwLvwMVCY+eOq9jXaMCps/cuSKMXma2q+6gtBUpqiyDHqHWChBTN
 sng+jaxnGEVj+2NcVZtDgDphJmHuw8dIxMXkNJP2G5KqGsnI7dLXHHnjDFexuTJqJK/Ig+VXs6y
 Rf1EiBQI5fsrasMWufpxL95M=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 14e5668ba4a579be;
	Thu, 29 Oct 2026 10:33:17 +0000
X-Mizu-Trace-ID: 14e5668ba4a579be
X-Migadu-Flow: FLOW_OUT
Message-ID: <ce3ede81-f70b-4324-9fa4-21cf716e1e33@linux.dev>
Date: Thu, 29 Oct 2026 18:33:09 +0800
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
Cc: cui.tao@linux.dev, josef@toxicopanda.com, axboe@kernel.dk,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 linux-kselftest@vger.kernel.org, cuitao@kylinos.cn, ameryhung@gmail.com,
 alexei.starovoitov@gmail.com
Subject: Re: [PATCH 5/5] docs: cgroup-v2: document the iocost BPF cost model
 attachment
To: Tejun Heo <tj@kernel.org>
References: <20261028143534.135968-1-cui.tao@linux.dev>
 <20261028143534.135968-6-cui.tao@linux.dev>
 <72deb196d0dfc413a48f0739013bc610@kernel.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <72deb196d0dfc413a48f0739013bc610@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Tejun,

在 2026/10/29 04:09, Tejun Heo 写道:
> Hello, Tao.
> 
> On Wed, Oct 28, 2026 at 10:35:34PM +0800, Tao Cui wrote:
>> +	When CONFIG_BLK_CGROUP_IOCOST_BPF is enabled, a BPF cost
>> +	model can be bound to a device by attaching an
> 
> Users can't select CONFIG_BLK_CGROUP_IOCOST_BPF.
> 
The sentence now reads "When BPF cost model support is available".

>> +	Only detaching removes the model, after which "model=bpf"
>> +	fails and the device prices with the builtin model again.
>> +	Device removal ejects the attached model as well, while the
>> +	struct_ops link remains until userspace destroys it.  "ctrl"
> 
> "Only detaching removes the model" is followed by "Device removal ejects
> the attached model as well".
> 
Dropped "Only".

>> +	accepts only "auto" and "user" and never selects a model.  It
>> +	keeps describing the builtin coefficients, which take effect
>> +	again when switched back.  The automatic profile stepping does
>> +	not switch profiles while the BPF model is in use; as with
>> +	user-set parameters, the profile selected from the device
>> +	class still applies.
> 
> cgroup-v2.rst doesn't describe automatic profile stepping anywhere else.
> 
Those sentences are removed.
>> +	defined.  They remain readable and writable while "model" is
>> +	"bpf" but take effect only after switching back to "linear".
> 
> The builtin coefficients taking effect again after switching back is
> already said above.
> 
Removed.

Thanks,
Tao

> Thanks.
> 
> --
> tejun


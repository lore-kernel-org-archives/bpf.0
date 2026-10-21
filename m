Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602912;
	b=OVXOKaPYJh8sklcMjz4fLYv+vVtITNILGAuHt7GLnsBDe+J+q9cgvKW/CzKUZdlvUzMx
	 w8FNXW3JoGaxZzmH1fvtBesMNp+Ls1s45D9WrLcXgLlsMQ3Xlm98XXXX3arsG6da4dkLd
	 XpeNkStKDkrd3NYBLlGC8EELqYY5GirPC9vrAo+e+2zyo6alF6EiqVdpl5SCcvVoEunBX
	 7sBA1pkwfYDOPXV75IQnNOlwU4rDhfuveG5Yp6uoZqmVdCxSfWESRNK+BHEtwSLiltT13
	 B14mXFPSFFMwNOJc3d2roCAMnQXzwf/ypGRalSVw2wmMMbgbHsNHK0KiqyDePNP5lCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602912;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=sqCbFUq57Nyuhu/s5jZ25/qkUoiEw9rvaZCGhH+XBfk=;
	b=QsDRegExTrOo0Z7JYGyYe7SGV/b7vSTPg3lko8xcg7nvnatxX+6qrHBx/M3yVRgzvB32
	 b0qe1b9dn7Tz9SjrVGrwFLDFLrmEWpV1UKQ2o49ze8GD7MeKvNEL1Dn+5Cd/ntjfU5GWu
	 s08k47gk9es70moP4DvW5FzNeyrvJrwUbeHX4u1p7FybiF4uow2x/JNurQpi2pMZuAyE8
	 dB+jILrSqZVwCJLLkU1WGV9LcKOZ3Fa4dLSNTpv1VxpV3EWFGy+ngZvkzvTV7G1s4qviS
	 Sb9xLfYQAZpXd5wukRJpB10leJSJ1r7m5mRHDfDT1DKEcxP4KAL05pFgDr8ydQrKbPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qrwyXJRZ;
	arc=none smtp.remote-ip=95.215.58.66
Received: from mta1.migadu.com (out-66.mta1.migadu.com [95.215.58.66])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC62160A261F
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 17:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC62160A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qrwyXJRZ
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=R3rO7GMpAxVm6n8cNV2L8vfbkvcKtRqwWc2DdbOuAQk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792602908; v=1; x=1793207708;
 b=qrwyXJRZ3lpugnMoJ4mbaM3vfmAUAnlNLD14G7yZraBru/h/gfcEr5+2CsyTG4NWESKHbspz
 zWqJkTz0XE6Lb+iCNCanD+rLkHz/z6Gw7pEERkOi2ATP32zJpI0aIzGYGXgord4ShhyiPWuyR6q
 bqjNXnfzv58jiBjROv4tvaCE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2c2eaff682f769ba;
	Wed, 21 Oct 2026 17:15:06 +0000
X-Mizu-Trace-ID: 2c2eaff682f769ba
X-Migadu-Flow: FLOW_OUT
Message-ID: <9bb73098-57c1-4754-9ecb-66cbb1e205ee@linux.dev>
Date: Wed, 21 Oct 2026 10:15:01 -0700
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
Subject: Re: [PATCH vfs v2] bpf: Allow bpf_d_path() from filp_close_sync()
To: Christian Brauner <brauner@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 NeilBrown <neil@brown.name>, Jiri Olsa <jolsa@kernel.org>,
 Mark Brown <broonie@kernel.org>, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260925210347.1364191-1-ihor.solodrai@linux.dev>
 <20261021-ananas-siegen-kurstadt-24cc3e5c1ce6@brauner>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20261021-ananas-siegen-kurstadt-24cc3e5c1ce6@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-10-21 1:54 a.m., Christian Brauner wrote:
> On Fri, Sep 25, 2026 at 02:03:47PM -0700, Ihor Solodrai wrote:
>> The d_path selftest closes its descriptors with close_range() so that
>> its fentry program on filp_close() runs. The vfs commit
>> c1ed65ea167b ("fs: make close_range() synchronous") switched
>> close_range() to filp_close_sync(), so the program still attaches but
>> is never called:
>>
>>    test_d_path_basic:FAIL:close trampoline for filp_close was not called
>>
>> With that series, close(), close_range() and the closes on exec and
>> exit all go through filp_close_sync(). Few paths still reach
>> filp_close(), dup2() being one of them, so a program on filp_close()
>> no longer sees most file closes.
>>
>> Allow bpf_d_path() from filp_close_sync(), but only from fentry.
>> filp_close_sync() drops the last file reference inline, so by the time
>> an fexit program runs, file->f_path may already be freed, with no RCU
>> delay for NORCU dentries such as pipes and sockets.
>>
>> Attach the selftest program to filp_close_sync() and keep triggering
>> it with close_range().
>>
>> Add a test rejecting bpf_d_path() from fexit/filp_close_sync.
>>
>> Assisted-by: LLM
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>>
>> ---
> 
> This seems fine to me. Sashiko has some comments though.
> Maybe go through them and resend as necessary.

I looked at them when sashiko replied and dismissed.
Should've commented.

I'll respin anyways to rebase, it's been a month.

Thanks for taking a look.


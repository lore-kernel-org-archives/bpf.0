Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80033803DB
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 11:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781694558; cv=none; b=i3b+cS11OxYBUXJbRmFruc/vvLI5QQPuBrWdnxt5fDDJqVzqtP2JwF5BQd4q7jetgr2X+Q7S8jcfpNXd3yJvxWdOpsuZ/RcFjqcjBLaxO/vXs6D1xk+gthouv8vRaC2w2YNM2n1zzCB6RqXGUNrYPEY+4/sjO68vnHdeSr75IAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781694558; c=relaxed/simple;
	bh=XzP0Cyg7IV+GZuzJzF01SzhIskMBRbALCcY9nKUynKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HD6UAjo2gbcC1iKIInQ1Vge55w7Cnx/6FclDz+dwUInJGT7GUEU52yXJQEO2RayTy65CVSH0X1+8PWJTSECgUmR0QRGckMICQJiZ9KNEwN6aRFrqy4GpawhMBr5pNNnb0YLUy63D4xFMIIL7ns0zJFK5tCyT8dg1Pe7NlH/ohCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HJvYPWTP; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HJvYPWTP"
Message-ID: <14d43777-e979-42b4-a9ec-cc5d46f4e01e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781694544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hit5OWWdmyaqHN3p4Sv7rLdforBDEson2Ovw95DWC3o=;
	b=HJvYPWTPl7x7tkSX4cfnotjTzOBWQd9dE5AfyePTqFzwNeijn7f70P0KFkpnlILfgL1h7z
	tGGAm8eqzsxC/ndCNRdvXEsbJWpeq/4ndE35vBrPyIJJdJnWld0l/9T7ez7JgQqwEM4xcj
	PuAJ8MNaEblHLune/5T2sOpib1FndjE=
Date: Wed, 17 Jun 2026 19:08:40 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 1/2] bpf: Fix stack slot index in nospec checks
To: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Luis Gerhorst
 <luis.gerhorst@fau.de>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260617-f01-11-stack-nospec-slot-index-v1-0-e3a080b0cd7e@mails.tsinghua.edu.cn>
 <20260617-f01-11-stack-nospec-slot-index-v1-1-e3a080b0cd7e@mails.tsinghua.edu.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260617-f01-11-stack-nospec-slot-index-v1-1-e3a080b0cd7e@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 6/17/26 12:57 AM, Nuoqi Gui wrote:
> check_stack_write_fixed_off() computes the byte slot for a fixed-offset
> stack write as -off - 1, and records each written byte in slot_type[] with
> (slot - i) % BPF_REG_SIZE.
>
> The Spectre v4 sanitization pre-check uses slot_type[i] instead. For a
> 4-byte write at fp-8 after the lower half of fp-8 has been zeroed, the
> pre-check scans bytes 0..3 and sees STACK_ZERO while the actual write updates
> bytes 7..4. That can leave the second half-slot write without nospec_result
> even though the bytes being overwritten still require sanitization.
>
> Use the same slot index in the sanitization pre-check that the write path uses
> when updating slot_type[].
>
> Fixes: e4f4db47794c ("bpf: Fix pointer-leak due to insufficient speculative store bypass mitigation")
> Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>


I think the Fixes tag should be  2039f26f3aca ("bpf: Fix leakage due to 
insufficient speculative store bypass mitigation") ?

Otherwise, looks good to me.

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


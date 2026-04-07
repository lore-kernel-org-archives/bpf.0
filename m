Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92E03783B0
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 05:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775541187; cv=none; b=S2av9p7K5+rqp/riWChx3OtrDklqhPXbEq2LLfa8gP8Ja3jidqdd0EiAqTdzRO0rKASeR/WyfUBf9Z70PWO5xd3Lv/mUoHacUV4W7XtuUuktsvxXxHLYKD8CqPINMyfSIR6hReseFStRyURStCdaqbFtLGJ0e9CcwnqYDn0PGLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775541187; c=relaxed/simple;
	bh=2JLbYnj0+atE0hI/DWj600dRm4KXgIMvxQ9/vMKWoDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SEac4GZdV79Rz9Hz36Ii3IucPbsKKwRbtiGMROe0aWT7hvo/CxITAJOk55bytIa8ZCdtEn1HMCxGL3ABWZZaSGDKh/D39mW5MUsgSHYpzTYq/y775pl61bQUC0LzkA8w2f2eDxXL5xrMZDY6fjjh3nvhY3+IxAvXK52cjUbiiE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GfHw+wEM; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GfHw+wEM"
Message-ID: <5fd28a3d-2a82-4e6c-a906-3cc91643bab1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775541183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oRTh4KAPB6rDIsy0DotZ1SR2XVnCsJDQQQ57Q2qJsxk=;
	b=GfHw+wEMgDfg3/rG2Kq+Lq0yORJHjpnNdp4m5Vf8JpnwrJQA3HQDDZVjKYUabB38Fl0/vl
	mQFONI9rBa+dwpRjTM4/vnTg8Z3JpyyTwyFCGqwjBcNNsn3yQMqaStj3scK215TiWLgpLz
	VVLvIlA+pzBoHDXLhXGEY3JimZ6qt/4=
Date: Tue, 7 Apr 2026 13:52:49 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 1/9] bpf: Upgrade scalar to PTR_TO_ARENA on
 arena pointer addition
Content-Language: en-US
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, memxor@gmail.com,
 daniel@iogearbox.net, eddyz87@gmail.com, song@kernel.org
References: <20260407045730.13359-1-emil@etsalapatis.com>
 <20260407045730.13359-2-emil@etsalapatis.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260407045730.13359-2-emil@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/4/26 12:57, Emil Tsalapatis wrote:
[...]
> +
> +			/* We have a SCALAR_PTR_TO_ARENA operation,
> +			 * propagate the info to dst_reg. */

NIT: should keep consistent comment style.

> +			*dst_reg = *src_reg;
> +		}
> +
> +

NIT: dup blank line.

Thanks,
Leon

>  		if (BPF_CLASS(insn->code) == BPF_ALU64)
>  			/*
>  			 * 32-bit operations zero upper bits automatically.


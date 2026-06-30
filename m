Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064823DFC93
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 20:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851037; cv=none; b=JtOUx1q1jNnJxPskZAAfATs/FmAx/kOy/bVJwu+1y9jEJ9LXw3ASnoHpZHWE4kdjZ6DHkdWBm2+3tRUbl7f6Az8abvcJWBw2cuIoEf3tZmd92fH/frG/lej9iG4eKcfv7+P8Bk5Rh7ihKrYiH4l3XhSxOvpxWwpktFVwNP9uogI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851037; c=relaxed/simple;
	bh=5WexpDvYnJ7FGAeKPTfNs2+MUSKhePoo/c9u+PFD/YA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s4QxBVJ6WjDLQHG8wMKxVY+ZSXrEQ7zYXYjpzQ6Y94hI10GUDCD8FZ5OZW/MQZANnVxQ+9jV2lwSIp8kL+OOqobqJsrS1dly8VgdGgM13jkSLG0EIk9kQEBFwwR83HD0fviYucIdKi3sOGDpoIIBkQAPHt1BfPGhUercUyncOU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M2M2DviB; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M2M2DviB"
Message-ID: <e22f47b6-8b48-4f55-91ff-18b753e02222@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782851033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a86fwoPayD1kKt80mhjUtd61ZRFixjzgsV1dkCXYE8s=;
	b=M2M2DviBZTm1tBm1cH3YDjvYUkZabPEvGo0NyTaFcJQTNXbBgrAbz/lmfsjUShyDl/eTVt
	ZGOhSFBljeVRz5MS7drY75Vig5So3DUIMQkbgDI/qh3hEZxtS60dWIrwiaMOkHnDBTXd0H
	OAEMODjx9HzEPB8sHVZOrd3jzoHHlEg=
Date: Tue, 30 Jun 2026 13:23:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 3/5] selftests/bpf: libarena: Clean up allocation
 state before buddy tests
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, memxor@gmail.com,
 daniel@iogearbox.net, eddyz87@gmail.com, mattbobrowski@google.com,
 song@kernel.org
References: <20260618085626.19633-1-emil@etsalapatis.com>
 <20260618085626.19633-4-emil@etsalapatis.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260618085626.19633-4-emil@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/18/26 1:56 AM, Emil Tsalapatis wrote:
> Summary: The buddy allocator requires the global BPF buddy allocator
> to not be already initialized. However, the test currently merely resets
> the allocator before the buddy tests instead of destroying it, and the
> test worked because the buddy test happened to run first. Properly
> destroy the allocator instead of resetting it.
> 
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

> ---
>  tools/testing/selftests/bpf/libarena/src/common.bpf.c  | 6 ++++++
>  tools/testing/selftests/bpf/prog_tests/libarena.c      | 8 ++++++--
>  tools/testing/selftests/bpf/prog_tests/libarena_asan.c | 8 ++++++--
>  3 files changed, 18 insertions(+), 4 deletions(-)
> 
> [...]

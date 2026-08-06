Received: from out-173.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133863D903E
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 20:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786048217; cv=none; b=Yjy1hz6ZjZsFA9r29TNhzW/XPbUUdwPgAH2NDyNqsr9KJhT2LanLZe6fcTPTTydoZH6tk9W0bUwPzyfeUGm2Hkl9rfB+9EMSLdz6b/9/1g5LKj8hHlfitsLudtS4sTyqKQWqW667fKRFBx5bo3nvfi7UHxT3tLSfd36jfS7A+PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786048217; c=relaxed/simple;
	bh=p6LZX1eSh7OiICqAmn3/p2e/P7OsJa9OIknN76EyCis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aepNI2pvXdInncK+bZUTHuv/eTe47veoK9v+CLWL9OZPQGQ7G0smsUMYJr30g65KqUWFlNB29gOjc0YQ0zChoISGXPDL2G3n9V7nIUIl+CjkxVaS5X5ZUoOkQcpoL2iDoGLAwdKKCORiiNpTvfTTxTMP6r3CeJF3DA7doVnjmzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mBQJb8gT; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mBQJb8gT"
Message-ID: <455a0c97-9507-4035-ba12-82afc30ae51a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786048213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HHBNxU8iQ9bhuCdbWfe0js0K+5MqccYz2yBcRa2afJk=;
	b=mBQJb8gTVmEyaIq7YZKUh31T4UMYQHN2xNWQjH7Y1jO52xSf4pqrwbKiKcl4rqiZPPPuy7
	ihajCDiXFJITdsporXo+C0LcuqXs/MBumUjg2wv/U5ZsKVVPJ0XQe2kIxM6LScfS9TGvvQ
	9rQEA96ifDbOU8uFMB9fsSs73VaFLJw=
Date: Thu, 6 Aug 2026 13:29:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] selftests/bpf: Fixes for out-of-tree builds
To: =?UTF-8?B?UmljYXJkbyBCLiBNYXJsacOocmUgKFNVU0Up?= <ricardo@marliere.net>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260728-selftests-bpf_oot-v1-0-05feb15d94db@marliere.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260728-selftests-bpf_oot-v1-0-05feb15d94db@marliere.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/28/26 5:06 PM, Ricardo B. MarliÃ¨re (SUSE) wrote:
> Hello,
> 
> When doing a simple out-of-tree build, e.g.:
> 
> $ git clean -fdx
> $ mkdir ../build
> $ make defconfig O=../build
> $ scripts/kconfig/merge_config.sh -O ../build ../build/.config tools/testing/selftests/bpf/{config,config.x86_64}
> $ make O=../build
> $ make -C tools/testing/selftests install O=$PWD/../build SKIP_TARGETS= TARGETS=bpf
> 
> Will leave behind several build artifacts:
> 
> [...]
> 
> This series fixes this.

Hi Ricardo,

I think we should wait for the selftests makefile refactoring series [1]
to land first, and then address the issues you've found.

When you do the respin, please test both build and clean with an
in-tree kernel build and with O=

Sending a few comments in a bit.

[1] https://lore.kernel.org/bpf/20260804170156.1709916-1-nickolay.lysenko@gmail.com/


> 
> [...]
> 


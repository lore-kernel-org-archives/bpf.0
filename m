Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC681D6187
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 10:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773743374; cv=none; b=Vlq9JuDjI490IuyoZyyGv035JU4VUywBKFsDjkZKR1UFI3Tp7+8QWyiITy8H5eJZUxoaYbaKP1E9a6CLTA4HCn8m/TgrEjkdYXJNgFt0TWX53T5xpmUZ1cliwk/enOuBsx9+Lxgh/UJUab9gA7YFC3A9pXuAi2VTByMXoKl5BY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773743374; c=relaxed/simple;
	bh=HLPPLhjp5KslT7kqZKRXNouOJGu7xGVhpd5tFSUWGyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uLyXsaq+5fVb645c21bR3a/Ov3sUz7MU+R3DWKeQ9WdYsjj7qi87Ek9RVq3ZNQvpSyOOj5cenBiq8TEwrRSlKx6l8YEw2p7Zwq14TfK7DAn01F6PfTV+xm5oS+lXUEYEg9uXnHbDO5x5B+WCrVo0EWcsjayeDVoMrsyC1e1a0KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYeQE2AK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYeQE2AK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05D9C4CEF7;
	Tue, 17 Mar 2026 10:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773743374;
	bh=HLPPLhjp5KslT7kqZKRXNouOJGu7xGVhpd5tFSUWGyU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZYeQE2AKAVTwtuKh9/o00xodR8rzyAhbiAP1gUD9Drcx2rlSXspoMih21ZiliV1+o
	 1t3czUDK6/964mJbQiuA3kN5mEZZrMEdDgCBnPKs7tlls27xBjMznCFISH+BAlRunv
	 EMlAlyxfHY6jWWmqZY3AuZL6/HnARXfxYVzxbmpz4rRSQj07N48KXF2nIyjTI3dxYz
	 jb0CYquZe6+s9DeUisMnZrHEVS5raLQCAlg9HnSC4mkSwRsFH3k7i5ub/UpLoQr8x4
	 +O+VM0Kc+3/Vr2/PM9WegEtGQxhmRwC3R515oG4EKHspK6WWWC6KOYRyzQhC59dj0y
	 PHanWEFor9+gQ==
Message-ID: <ad8a783b-7b8c-46f2-9a3c-953315aafe38@kernel.org>
Date: Tue, 17 Mar 2026 10:29:31 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpftool: Allow explicitly skip llvm, libbfd
 and libcrypto dependencies
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20260312-b4-bpftool_build-v2-1-4c9d57133644@meta.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260312-b4-bpftool_build-v2-1-4c9d57133644@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-03-12 17:03 UTC-0700 ~ Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Introduce SKIP_LLVM, SKIP_LIBBFD, and SKIP_CRYPTO build flags that let
> users build bpftool without these optional dependencies.
> 
> SKIP_LLVM=1 skips LLVM even when detected. SKIP_LIBBFD=1 prevents the
> libbfd JIT disassembly fallback when LLVM is absent. Together, they
> produce a bpftool with no disassembly support.
> 
> SKIP_CRYPTO=1 excludes sign.c and removes the -lcrypto link dependency.
> Inline stubs in main.h return errors with a clear message if signing
> functions are called at runtime.
> 
> Use BPFTOOL_WITHOUT_CRYPTO (not HAVE_LIBCRYPTO_SUPPORT) as the C
> define, following the BPFTOOL_WITHOUT_SKELETONS naming convention for
> bpftool-internal build config, leaving HAVE_LIBCRYPTO_SUPPORT free for
> proper feature detection in the future.
> 
> All three flags are propagated through the selftests Makefile to bpftool
> sub-builds.
> 
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>


Sorry I'm late for this one, I see Andrii applied it - I just wanted to
say thank you for this!

Quentin

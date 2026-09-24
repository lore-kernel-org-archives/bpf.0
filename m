Received: from mta1.migadu.com (out-74.mta1.migadu.com [95.215.58.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED9242E409
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 19:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790279436; cv=none; b=ROVt+gzukw7ChpYx1BBvj7t7GdbH5BaTWM9ETkceUdusDPb88Xf4xIAUBnHs1m09KA3txHEDgC7coCuDyWeVSntK5vU/9tYq5cG2HVWeGX2LGjXAzAgFACbCZUKoVQO0w/im6olG9Rz3SDnJX+ac1zb0jn2VkokhvrrTLqv9HUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790279436; c=relaxed/simple;
	bh=aKZTR9UmXIUM+ZuJhj9lrNYV2VcUVjjMrWUianxOCpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O3G1brKh7ehStjfutOCQGhYM61bP8hTCfP7DqHPAE1vbCKCWMBIMru9m6TBdsDhkc0mByUrMCaLCuYam2uEpFT2rxSl8Dzkyqhf6sWjiQfYuY47xPDKiZaPANUj3iB8GNZKf+Yx0nl4+ihIsVfBoti7L9JSmErtVbaqiq95/Ofc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XNBkfC0e; arc=none smtp.client-ip=95.215.58.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XNBkfC0e"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=aKZTR9UmXIUM+ZuJhj9lrNYV2VcUVjjMrWUianxOCpE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790279430; v=1; x=1790884230;
 b=XNBkfC0eOvKknIJMF8RZG+O/shIhGVDO1NMe6vSRnTdE4KqsquH0a4i1PiHkUbtb88SUtljz
 LYnR+MsjnIku0pyFalqxxL3tLx/YmqDNqN6CGHfJ0bqMJ8znE+Qa2RYZeX7m1zRrBJNc6mVscK9
 XM2ND2qSLqI86awBO2cFV+zw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 928ef052ab13ac34;
	Thu, 24 Sep 2026 19:50:29 +0000
X-Mizu-Trace-ID: 928ef052ab13ac34
X-Migadu-Flow: FLOW_OUT
Message-ID: <d9aa643c-438f-4658-a82c-f16b9ca944e3@linux.dev>
Date: Thu, 24 Sep 2026 12:50:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix build of callx tests with GCC
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com
References: <20260924182104.261823-1-alexei.starovoitov@gmail.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260924182104.261823-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/26 11:21 AM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> GCC doesn't support indirect calls in BPF:
> 
>   progs/verifier_callx.c: In function 'apply_op':
>   progs/verifier_callx.c:977:1: error: indirect call in function, which are not supported by eBPF
>   progs/verifier_callx_rodata.c: In function 'use_shape':
>   progs/verifier_callx_rodata.c:746:1: error: indirect call in function, which are not supported by eBPF
> 
> Build verifier_callx, verifier_callx_rodata and callx_rodata progs
> with clang only. Skip callx_rodata_lskel test when progs are built
> with GCC.
> 
> Fixes: e9b22d50796d ("selftests/bpf: Add tests for callx")
> Fixes: b018e998e645 ("selftests/bpf: Add tests for callx through pointers in read-only data")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Tested-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Confirmed the patch fixes the GCC BPF selftests build:
https://github.com/kernel-patches/vmtest/actions/runs/36043955840/job/107785910578

> ---
>  .../bpf/prog_tests/callx_rodata_lskel.c       |  6 ++++
>  .../selftests/bpf/progs/callx_rodata.c        | 28 +++++++++++++++++--
>  .../selftests/bpf/progs/verifier_callx.c      |  3 +-
>  .../bpf/progs/verifier_callx_rodata.c         |  3 +-
>  4 files changed, 36 insertions(+), 4 deletions(-)
> 
> [...]

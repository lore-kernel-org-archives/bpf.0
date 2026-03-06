Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B972F290B
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 02:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772762692; cv=none; b=bRFEBszSQZU/ICRydI5sKv2Ld+iJVMlCQ0vn4psLLY90hHpT+LFKGLeZNTw7sOBrA6MJP5O27z9kFtm5bPKliXxdzjZAukiSSHcuX+L5a/6ooZWkBdnqP1od2Rt6lp7vndJZFdWatlkv6tSVwUd12bg44Q1ZMzGPqeVY2ujD6T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772762692; c=relaxed/simple;
	bh=o0o/qPLEfUOBnxjF58SNQnIsic4OD2uzr0qmDw0kvFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WOVPv06X5X4qUhc7xR0VpSS27+jknjdrP76ht/VTADj4+WHlnCoAqitXnfdBaqu0ZOHHjqKGg+vehnZkNIsdp2tUVovilhTcRavfBOTwqcxKh6ZudG3zDLtb8p/DUBwXRVx8/uK3rU1oC/fX3+K78tYTlxb1cCSvff1bv9Tb1E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YY6GpMSb; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YY6GpMSb"
Message-ID: <f93e9762-fa64-481a-8537-12f6af95abf6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772762688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6j5NZvLpOCbBPmbe7VWMLECVWtMZP9fWm7QaalJPpKc=;
	b=YY6GpMSbDqrhlYZ+Ka3NFfgKVzymVgSgaJwe/YmmriF7G4FcN8umCFM08EIifhm5V8IUhk
	mY4VFO+t48lTjmBeKvvEfBb/sBd11Ct3JrAs8DMR3/0P3vWvF/SmNB516lsU80rD3RGjTk
	pJMgHapfTfkdXf0iqZqHtb7j6iyjnUw=
Date: Fri, 6 Mar 2026 10:04:32 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 0/3] Always allow sleepable and fmod_ret programs
 on syscalls
Content-Language: en-US
To: Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Shuah Khan <shuah@kernel.org>
References: <cover.1772721009.git.vmalik@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <cover.1772721009.git.vmalik@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Viktor,

On 5/3/26 23:25, Viktor Malik wrote:
> Both sleepable and fmod_ret programs are only allowed on selected
> functions. For convenience, the error injection list was originally
> used.
> 
> When error injection is disabled, that list is empty and sleepable
> tracing programs, as well as fmod_ret programs, are effectively
> unavailable.
> 
> This patch series addresses the issue by at least enabling sleepable and
> fmod_ret programs on syscalls, if error injection is disabled.
> 

Could you please explain more about the purpose in cover letter?

I'm curious about enabling fmod_ret programs on syscalls, as they are
able to modify the retval of syscalls.

Thanks,
Leon

> Viktor Malik (3):
>   bpf: Always allow sleepable programs on syscalls
>   bpf: Always allow fmod_ret programs on syscalls
>   selftests/bpf: Move sleepable refcounted_kptr tests to syscalls
> 
>  kernel/bpf/verifier.c                         | 79 +++++++++++++++----
>  .../selftests/bpf/progs/refcounted_kptr.c     |  4 +-
>  .../bpf/progs/refcounted_kptr_fail.c          |  2 +-
>  3 files changed, 68 insertions(+), 17 deletions(-)
> 


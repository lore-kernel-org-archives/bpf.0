Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB83140D592
	for <bpf@vger.kernel.org>; Sun, 21 Jun 2026 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782056319; cv=none; b=vDbq5JbE8H8V6wfUa51czLqQVVlDFXI1qT8hegUEvEuzXTMxjqoRcUOfs9Ct9d+qa22ywazbUca5OqUardYWSAc9LtYpICj3BxjpVzYNC3ATlnSDYNu4PjKI/dhHqVrvQpLuCWSnb7+4CiI3ipQhWI+eu+8pskRbrQnx8n63opA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782056319; c=relaxed/simple;
	bh=TKVqp4Bjdv6zsaFFfojBFe/y3vjoX7IqaH2F78T3//U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FvhIq70njgRrauH3vTjtd8q4CteGnZMlB5aUdd83cvAZy3EHy5UdWTI9mIE0nZ3+HuIGaZvGbrUA7vfvT65UpRXTawk3ndWoF8ErwtHK83gb7fvRY24hjlajnOZ6Y+jpPnCim/GfPtQkFqYIP0fnDP0vKodsMz8mTHJDMC+/MDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dLRQY+ut; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dLRQY+ut"
Message-ID: <3d2c5cd7-1159-4e0d-b294-6106decc04a7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782056316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cjuhakBRdZfrfMuL+GgSiUD5exlCzqH5bVT4cQh5Vuk=;
	b=dLRQY+utOY4gFUZ9QqV5GCijtAqGvLNb95qm1ueZFDeu99icnrpDD0Vj0bhoIrR33rQOnp
	88hJsxWi5BIATmdLGyQhXARUWctSbzD9GXh49iYJ2p/dRJA9TWtHIhFo+5BzTcFaXGZJxv
	YuEPqoPOfnQJ8qyMUsT2I20W5TUvet0=
Date: Sun, 21 Jun 2026 08:38:30 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Emit verbose message when prog-specific
 btf_struct_access rejects a write
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com,
 eddyz87@gmail.com
References: <20260615232146.5491-1-alexei.starovoitov@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260615232146.5491-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/15/26 4:21 PM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> When BPF_WRITE goes through a PTR_TO_BTF_ID register, check_ptr_to_btf_access()
> delegates to env->ops->btf_struct_access(). Most implementations
> (bpf_scx_btf_struct_access, tc_cls_act_btf_struct_access, etc.) return
> -EACCES for disallowed fields without logging anything, so the verifier
> rejects the program with an empty message. For example a scx program doing
>
>    1: R1=trusted_ptr_task_struct()
>    ...
>    4: (7b) *(u64 *)(r1 +0) = r2
>    verification time 83 usec
>    the program is rejected
>
> leaves the user guessing which field is off-limits.
> Emit verbose message.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Indeed, e.g. bpf_scx_btf_struct_access() does not emit any verifier log
for failure. So it makes sense to have a generic verifier log after
env->ops->btf_struct_access().

Acked-by: Yonghong Song <yonghong.song@linux.dev>


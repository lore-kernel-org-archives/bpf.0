Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ABF3A3E67
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 13:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774878940; cv=none; b=hot+iEUazmPnxkGMmewN6VEizQw8pcg17MkwS0dTp13cDFyTMUfKYaZjqwbSQaIQKBbz5lcl44n3qSq7Hlq058vGqacy1KF+C8jPl5ILgz2ol6Bu0JOLxE774Z6ev7sYt6xYCzOAYh+Igqrqe/K3+Sl+YH74TRU8HR0gTWNapJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774878940; c=relaxed/simple;
	bh=JuzlJXEAHGcSiF6n+n3yInCM4todvtFnYHvB3lvFcrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+JwKXiTaTF8WnKtlMbhL4Rwl8yZhCNBLnUn9+IjhW2MNpjQ/Ck6inV6a2o4scCJWGTUwufAFO8V6z/D5EkyYjJGcna7viivevApWE83q0q/qzT28KfN1FjEwScg7K9oR7C1ixIRfthx0SbkzacnRTbKbXhwhfOWQBuctecSG/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qDWaEm9+; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qDWaEm9+"
Message-ID: <cd12a2fc-8fc4-40ab-a5bc-bf7b0f4ce766@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774878926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Oe2X5q/5SHXJHJJnjteGS61bN/fIuINUCylSG5ydx4=;
	b=qDWaEm9+oGVVjbVmrl8Z31/SC85DF2KQ+is//Zhbm9jWFgjFDtcN1k5WYLoJYlAPCQ3nWX
	FjngGBEVHXsZJJk8hrVEpcw/2nL8IKi0tGg1wWcwXzbP8VUYsjW8JLP4m+SYaV9rTJvA1s
	Nx7DGI+a+0EJn9VyWvlIZTMOOxOwuSs=
Date: Mon, 30 Mar 2026 21:55:02 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add test to verify the fix
 of kprobe_write_ctx abuse
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Shuah Khan <shuah@kernel.org>,
 Feng Yang <yangfeng@kylinos.cn>, Toke Hoiland-Jorgensen <toke@redhat.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-patches-bot@fb.com
References: <20260326141718.17731-1-leon.hwang@linux.dev>
 <20260326141718.17731-3-leon.hwang@linux.dev> <acpCWX6h-1IJtorN@krava>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <acpCWX6h-1IJtorN@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/3/30 17:28, Jiri Olsa wrote:
> On Thu, Mar 26, 2026 at 10:17:18PM +0800, Leon Hwang wrote:
> 
> SNIP
> 
>> +	prog_fd = bpf_program__fd(skel_kprobe->progs.kprobe_write_ctx);
>> +	bpf_program__set_attach_target(prog_ext, prog_fd, "kprobe_write_ctx");
>> +
>> +	err = kprobe_write_ctx__load(skel_ext);
>> +	if (!ASSERT_OK(err, "kprobe_write_ctx__load ext"))
>> +		goto out;
>> +
>> +	prog_fd = bpf_program__fd(prog_kprobe);
>> +	link_ext = bpf_program__attach_freplace(prog_ext, prog_fd, "kprobe_dummy");
>> +	ASSERT_ERR_PTR(link_ext, "bpf_program__attach_freplace link");
>> +	ASSERT_EQ(errno, EINVAL, "bpf_program__attach_freplace errno");
> 
> nit, I prefer libbpf_get_error call instead, because it's not obvious
> that ASSERT_ERR_PTR sets errno, smth like:
> 
>         if (!ASSERT_EQ(libbpf_get_error(link_ext), -EINVAL, ..
> 

Yeah, libbpf_get_error() is better. Will use it.

> anyway lgtm
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 

Thanks for your review.

Thanks,
Leon

[...]


Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127A41E5B63
	for <bpf@vger.kernel.org>; Sat, 11 Jul 2026 12:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783772306; cv=none; b=GXaa/EH7E1xdFZKB9Wc/TK9P4c7352Yczn9Bm8JmSs0NaayCA3irMmywnmldmWD9g+J0DHMWswO1uWgsVB1kH4XX+YTi1JuPMmnVKiwyD5K8dKfBulrYwb7PqzR7mzj77rvn1AbPElxh+nka9Bd+X4jgfUQf1EYYZGFvnWkNZ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783772306; c=relaxed/simple;
	bh=WiH+ZYA4OneRgj2PjrnjHfHThUEU1KYc5WXIJ0HnmZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A52OnfWZK0ngcuyDEiFI7qUlxNtXf9H6P57pso66YDct6+FivoQxVtCg350DKqhQpF7WApEImrhUOy7weLvoab+YnHf0/so1JfE+J2TNd26jV8kPbWh3O7NtotH1fHFsb0XNilaMsK+5VF0L+PcdlrYz8lUj1tVWfXk5UYsxdWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XHsA9w91; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XHsA9w91"
Message-ID: <e5a9125a-6966-4eef-af52-f8c5318d3496@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783772302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MfX/vN/GSviOWc1GrYE2ymGCv9b0QY2mWJlJawFmqT8=;
	b=XHsA9w91UX2bmshgh5lq448cgeeG4foBtlGE6cYut4RJkK8SM8k+xqpjenjl4n4ebwNhh8
	IBhevrfkvjmeQF09Y5PoHZeNLpnf2x0cIDPLi4W3z8CEuz8OzT7hPhsdo++YXCcofaaa0m
	kqAa01BcjqQqfkiiws8W05qindgDOwY=
Date: Sat, 11 Jul 2026 20:18:07 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 0/3] bpf: Fix trampoline handling of 128-bit
 values
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20260710225206.4013062-1-yonghong.song@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
Content-Language: en-US
In-Reply-To: <20260710225206.4013062-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/7/11 06:52, Yonghong Song wrote:
> The BPF trampoline preserves only 8 bytes of a target function's return
> value (R0), and its register save area under-allocates space for 128-bit
> arguments for x86_64. These two problems lead to memory corruption or
> incorrect values observed by BPF programs and the real caller.
> 
> This series fixes both issues and adds two selftests, otherwise, each of
> them will fail if without the corresponding fix.


lgtm,

Acked-by: Leon Hwang <leon.hwang@linux.dev>

[...]


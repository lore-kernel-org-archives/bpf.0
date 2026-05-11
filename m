Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1873CE481
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 16:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518089; cv=none; b=lg/NPxts7k2qfwWueWi6ndnZkeAsPgY836F6/ThBbHnaz6yk3bL4ROYuiZncOG/DhYQ9n+LE3Hk2iZVxHSBdP8lcj2o6ZDyBZggMyCmuzb1aZiKTXjiBY7/F5IwKkQiknikBb3aD7EGQiQSZYG4w3fMdpeGo5aYJR4x3IViZiUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518089; c=relaxed/simple;
	bh=Cug5hOJHraoEyMpkcAa5rXUA3VUo0z4Fn/CWgDpo1sI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DGBKpWhimTy6cn90c5kHyRCUvg0IMB3s/SoOOJlkT3OR9Nou4Q2F7Gl4VDaKhbnwfn2KBmE71ekaA8PG8mdNRGwvm2MQ6N807QGBxkVMtMouDL6G8lbHlX2DKgvuXurN8A9ctCY/aJug0MeqJ0NvxiP1AvV2ZZAwbruAETp8IF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jGgvCE23; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jGgvCE23"
Message-ID: <d4362d8b-93c3-4199-bb6b-bd9537d856f7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778518086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QwShQm+sgyFH/OFfTP5/27mbTba9iweJ3ow/gpbWCiM=;
	b=jGgvCE23li1A+YZ6PN0hwTg7YO+bDWgs+MhF/SVwsiKlmDgndLk6PzEos8AWEVgmTdrL/X
	on/1wevkcCLCO6Yz7Aj3QwgLmme2NJ2PPAhlBBScrVJrhgP+yHY4CCE6px9YX0lM2EIihZ
	mHZZjBF2LgpSN+eikCwbAl/nnDkyOMU=
Date: Mon, 11 May 2026 09:47:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 16/24] bpf,x86: Implement JIT support for
 stack arguments
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>
References: <20260511053301.1878610-1-yonghong.song@linux.dev>
 <20260511053432.1889692-1-yonghong.song@linux.dev>
 <DIFZV6EYXKW7.220V3470QWX01@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DIFZV6EYXKW7.220V3470QWX01@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/11/26 6:39 PM, Alexei Starovoitov wrote:
> On Sun May 10, 2026 at 10:34 PM PDT, Yonghong Song wrote:
>> -static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *addrs, u8 *image,
>> +static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog,
>> +		  struct bpf_subprog_info *subprog_info, int *addrs, u8 *image,
> Same issue. Do not add subprog_info.
> env and bpf_prog is enough.

Ack.


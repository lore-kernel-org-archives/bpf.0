Received: from mta1.migadu.com (out-71.mta1.migadu.com [95.215.58.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0034E06E4
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167757; cv=none; b=ivjbAPETIT/EyGj0WB2DqQJWcUKQC6wMS6tvlMs2nYItHtreIh/6mG24b9EgUKPftbJ61T6RxVlPQRbIEXsbB6PFpIsFkf1OGY330FdmsDHg+W29QX6c8fdb9M6RpoIuk3prYRdP4SbJUGfXTO3jKiwCLvQu5VFSFqChxP4eilw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167757; c=relaxed/simple;
	bh=YoHan/PNaYv9KhMqN8U0voMBKICl7UrwUJhE3M67gSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sv6u3JJoLrHzTffm5IFvcoRTv5G+a82+2k3YvqKTWzI7g7KfGOa0BZXZXX9sqjeHcOmh9FKtHzx5vhNTHNq/pxrcIZodqoyazDRJW516aXkq1pEpvRRGzBok36bP3KBqkdwAC3li5bKXdbBV7GloCAh3itDfD6N7/MMmT80gICc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k/Ilo99f; arc=none smtp.client-ip=95.215.58.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k/Ilo99f"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=YoHan/PNaYv9KhMqN8U0voMBKICl7UrwUJhE3M67gSc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792167751; v=1; x=1792772551;
 b=k/Ilo99fN2RmB9xg1CHnjweoxKc3Zt9CiGfUWTZpjinz1N+UWPZcCm1uUFUR8OZDdx/i/aVN
 QD1JDzQOpJLqqjvYT7h4tNa8GJiQN7j0CU0t62qmR1oCDuZW9FMYlNVdrHDO7Y7O9jtKPQr5cdb
 u3ZXdLk+elToi03c5/XJTWkY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5604be9e0a5dd168;
	Fri, 16 Oct 2026 16:22:30 +0000
X-Mizu-Trace-ID: 5604be9e0a5dd168
X-Migadu-Flow: FLOW_OUT
Message-ID: <dfa562d4-23fb-46ff-bbf9-5a56d2e51860@linux.dev>
Date: Fri, 16 Oct 2026 09:22:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 00/11] bpf: Follow up by-value struct and
 __int128 argument support
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20261013170910.2126673-1-yonghong.song@linux.dev>
 <DM5X4L58MG5M.2AK0D6DRZ5ERF@gmail.com>
 <a420e9de-4546-4be8-9fc0-d9e9c9fa6fb3@linux.dev>
 <DM6DYYV4XVKO.G5S77C0FGIYG@gmail.com>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DM6DYYV4XVKO.G5S77C0FGIYG@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/16/26 9:00 AM, Alexei Starovoitov wrote:
> On Fri, Oct 16, 2026 at 08:50 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>> This is not enabled on s390, right?
>> Okay, I will enable s390.
> No need.
> I meant that all users of LO/HI are x86 and arm64 only,
> so it's dead code. Just drop it.
> s390 JIT has no bpf_jit_supports_stack_args(), so with clang that
> has stack args tracing_struct_int128_tgt.c won't load there.
> s390 can be a follow up if there is a real use case.

In patch 7, we have the following code:

+__noinline __u64 callee_odd(__u64 a, struct int128_arg v, __u64 b)
+{
+	return a + (__u64)v.v * 2 + (__u64)((unsigned __int128)v.v >> 64) * 3 +
+	       b * 4;
+}

This one can exercise for s390x, x86_64 and arm64. Do you think it is worthwhile?

Two other bpf functions, which has stack arguments, need rejection with
   ... && !defined(__TARGET_ARCH_s390)



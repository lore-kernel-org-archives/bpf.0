Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A902A3515F5;
	Fri, 24 Jul 2026 19:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784922691; cv=none; b=mJGf2f8gfl6qtlT5p7cRILkMBdvZDHs4ttGMjbL5eZDiREk37LT1yw7mK3VOvpeU1sOusa/B/4u4vntSwFPfQMpAqKRaWiIL9foh2KD9gYxqOsfO7Fy/1M4uQIZ4/mdMVgr4h3qY3BzqAYwB/beOeMYmwlJpS15N+zd0xEpuOtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784922691; c=relaxed/simple;
	bh=HEVHWQn2aNR/OtnJyCo+SOT/LHLhNEl4AX1lx1Jo5m8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M7LET/+ppv9s61uazfSD8NMsFJzD8J7W8wd8CXH8u3t/BlsJwbgt/d9j2xLYIK1zUVqYPT+LSW6zAczru+RWE7Wd0Fs8+xZ8MXLIMLtpyGIIOE8dz9KCx0dnKTwQpuQ0kj49tbSr7lksIBdmxF6BbV7EblSmGguhU7WYyFdFwYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XV1l3QmC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XV1l3QmC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65181F000E9;
	Fri, 24 Jul 2026 19:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784922690;
	bh=xufiH9DXV0tiDlC53cxtndN+yZzoXD3SbTD8L2MaEcU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=XV1l3QmCJopHKETwzxiAgbXzhlAijMPuRFb/b3z+OHELp1gLI8eaAg5F2NaA8Uimv
	 OX0bpN696svmDT7tORfIMj+B74bhwd/JlczFOz9vp+xc/ugrzX1yfFuXlap5m28tk+
	 doaqbth7w1MA5+We8/NhMbh/1Wq0Lc7T1OfvdAGAfnSDBMVUK4fka5XWz73YJAjchs
	 7owhszZSQDsFBVFQHy9/s36SjV2XJ4G4J61taNyplS5wrtMRSiPO3nRKrzmgsPbSDG
	 TNOhJqjwuTVKFvN+35SkB9xpooPG8L4O8MpBa8d2Wkxd6jKJfgiUDJFcnBcRSXtZuR
	 Qua9UQf/o9GmA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huawei.com>, Feng Jiang <jiangfeng@kylinos.cn>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, Luke Nelson <luke.r.nels@gmail.com>, Xi Wang
 <xi.wang@gmail.com>, Puranjay Mohan <puranjay@kernel.org>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Shuah Khan
 <shuah@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 3/3] selftests/bpf: enable timed may_goto
 tests for riscv64
In-Reply-To: <15ceb481-ae3e-4c51-aeb7-513a3d213959@huawei.com>
References: <20260723-riscv-bpf-timed-may-goto-v5-0-86acb54e5642@kylinos.cn>
 <20260723-riscv-bpf-timed-may-goto-v5-3-86acb54e5642@kylinos.cn>
 <15ceb481-ae3e-4c51-aeb7-513a3d213959@huawei.com>
Date: Fri, 24 Jul 2026 21:51:27 +0200
Message-ID: <878q70qi80.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huawei.com> writes:

> On 2026/7/23 13:41, Feng Jiang wrote:
>> Enable verifier_may_goto_1 (raw instruction tests), stream_cond_break
>> (250ms timeout path), and the may_goto_interaction fastcall test on
>> riscv64 now that the JIT supports timed may_goto.
>>=20
>> Reviewed-by: Pu Lehui <pulehui@huawei.com>
>> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
>> ---
>>   tools/testing/selftests/bpf/progs/stream.c                | 1 +
>>   tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c | 3 ++-
>>   tools/testing/selftests/bpf/progs/verifier_may_goto_1.c   | 4 ++++
>>   3 files changed, 7 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/=
selftests/bpf/progs/stream.c
>> index 92ba1d72e0ec..8d8e53d37266 100644
>> --- a/tools/testing/selftests/bpf/progs/stream.c
>> +++ b/tools/testing/selftests/bpf/progs/stream.c
>> @@ -64,6 +64,7 @@ SEC("syscall")
>>   __arch_x86_64
>>   __arch_arm64
>>   __arch_s390x
>> +__arch_riscv64
>>   __success __retval(0)
>>   __stderr("ERROR: Timeout detected for may_goto instruction")
>
>
> This test fails because it relies on arch_bpf_stack_walk to fetch the=20
> prog. It's fine to leave it on though, since support is on the way.
>
> https://lore.kernel.org/bpf/20260722140015.1982158-1-varunrmallya@gmail.c=
om/

I'm inclined to do the same here -- but only since it's RISC-V, where
the tests are not run by any automation yet. In general I *don't* like
that a series introduces a failing selftest merely because another
unmerged series is expected to fix it later.


Bj=C3=B6rn

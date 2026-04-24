Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948B8266581
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 20:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777060946; cv=none; b=DxPw4ogfmMRpEtl9Ep01hQ/h5KHWldh2NKcLQGiI/ZtjC36R0j1qy+zsll9tH3qMH8Edkyv4Sn+/mp0WTjOjU17KmnqvRiunU+ZV7oAvqSE6TGc/wepLWtPM2+j2nkg34tcCrh0AfxQ3n4n+0pC5pwMZee6UxE9AwPv65/Bgw/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777060946; c=relaxed/simple;
	bh=vGrI+yWlz7FU9p33iqKuh+zUOn62MLk8NTdZsUbnW90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=smUdPEmK9QxeIPBIkVXiAHtRk7H2sr92feau4zRbrkULNb+N8myyfvRTujszMkRib4ZqKaba4fpvcwgmBw5AAdNxbS7aGcGVQD2xCmFYhLqmVtoCFNoNk30AyFJZvYeCQwOa2CCC1bpJiT/pddhiZqWL7ISj3Z3ZGSoOdtZS36M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LyaIlvJO; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LyaIlvJO"
Message-ID: <635af96f-3a8e-4d39-9df5-8c66945bf9e5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777060932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wNicmwiurmxIHeGmSS36Rf7vXFuO7MHXW0X7JPARuSM=;
	b=LyaIlvJOT9BRKU8QUPYM2XkgMsocA6jHFL/ah9K0DC0MmyLGbvtxvUWiEAhCdfEuHOlEIc
	lBt3EHpmfx+WacrDVMMmDOgEFicHQsb5ZgdMgTzS2H4VQC5zwDRsUc+gtezxAvjzFK+KHf
	aG5m+OYpD5W9c7J/b7nc0o9I9xxVaaI=
Date: Fri, 24 Apr 2026 13:01:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Add test for arena VMA
 use-after-free on fork
To: Emil Tsalapatis <emil@etsalapatis.com>, Weiming Shi
 <bestswngs@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Barret Rhoden <brho@google.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
References: <20260411112944.1455470-1-bestswngs@gmail.com>
 <20260411112944.1455470-3-bestswngs@gmail.com>
 <DHQI86CY1QDQ.16RMS5QSX99EC@etsalapatis.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <DHQI86CY1QDQ.16RMS5QSX99EC@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/11/26 10:33 AM, Emil Tsalapatis wrote:
> On Sat Apr 11, 2026 at 7:29 AM EDT, Weiming Shi wrote:
>> Add a selftest that reproduces the arena VMA use-after-free fixed in
>> the previous commit. The test creates an arena, mmaps it, allocates
>> pages via BPF, forks, has the parent munmap the arena, then has the
>> child call bpf_arena_free_pages. Without the fix this triggers a
>> KASAN slab-use-after-free in zap_page_range_single.
>>
>> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
>> ---
>>  .../selftests/bpf/prog_tests/arena_fork.c     | 86 +++++++++++++++++++
>>  .../testing/selftests/bpf/progs/arena_fork.c  | 41 +++++++++
>>  2 files changed, 127 insertions(+)
>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_fork.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/arena_fork.c
>>
> 
> The test doesn't work for me as advertised. Does it fail for you under
> vmtest without patch 1/2?
> 
> The test doesn't fail on base vmtest for me, even without the previous patch,
> because KASAN isn't turned on for the CI. With KASAN the test triggers
> the splat just fine. 
> 
> Should we maybe turn on KASAN and panic_on_warn by default on vmtest?

Hi Emil,

I just noticed this message. BPF CI has KASAN enabled by default
(disabled only on s390x) for almost a year now [1].  Did the test fail
locally for you, but not on CI?

[1] https://github.com/kernel-patches/vmtest/commit/5db11d295888c3f048021a15c3a8a9875c8612c3

> 
>> [...]
> 


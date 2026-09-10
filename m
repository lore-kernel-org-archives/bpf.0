Received: from mta1.migadu.com (out-240.mta1.migadu.com [95.215.58.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D99836A363
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 05:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789019387; cv=none; b=ussZ+Q+yKqq5xtckxX2BXZDvLDKRvhcYiL5r3Y8FyBR5iCU9fmDxCE9y4GFIpYaGWFbXisljH2GTV9xEJzABHfBj0dRs0CqZgl3CR+jcjY+rDaiNOvkkv3yChGzL+FBcG8wbj2y4Gjd5JqFCoGQOduYlmCNS0uw58LPF5cUYfXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789019387; c=relaxed/simple;
	bh=EsjpiLCg3j4sSZFIaJZiwYu7gVBnOusP/hUoo6eG9Ng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LjR+gyTz6pdSRxHtZwVqQ8dlU7tciOXxM/3Fo/LW/V7yoxdlKsM4wPomrw53WjiJ8IMDnQMH+JXy8j/OCu3XRj12F9ZnIKUgyY6HSfU4OqWh50h0s7k7jWAtdSvQEovNWDl/m6YI1c9cy2tcSBudJ2z8TBit06JLg5IRsmquwk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h7V4gHeo; arc=none smtp.client-ip=95.215.58.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h7V4gHeo"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=EsjpiLCg3j4sSZFIaJZiwYu7gVBnOusP/hUoo6eG9Ng=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789019382; v=1; x=1789624182;
 b=h7V4gHeohvvPxmraEtOHyNdHRIB+VoMhuZJLi8wX2rT96B+Xq7kTaWQ2ZowGGZePetoEp0RB
 qlkBw9LYtxI8/QMzHZNXRKVRjH6nD1/u3vqKQdaUTruYtsp3g+4iFM7kszmzFKFzK6tHit5JvoB
 UUojjrqBJ42hykPqOa6yMJDg=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1cf7bbdbdc900923;
	Thu, 10 Sep 2026 05:49:42 +0000
X-Mizu-Trace-ID: 1cf7bbdbdc900923
X-Migadu-Flow: FLOW_OUT
Message-ID: <424ef244-f0e0-46e7-bc27-fffee80f348d@linux.dev>
Date: Thu, 10 Sep 2026 13:49:34 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Verify program FD after
 non-autoload programs in lskel
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
 Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260909042433.1775591-1-tweek@google.com>
 <20260909042433.1775591-3-tweek@google.com>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260909042433.1775591-3-tweek@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/9/26 12:24, Thiébaud Weksteen wrote:
> In test_global_percpu_data.c, dump_percpu_data is defined after two
> non-autoload SEC("?kprobe") programs (verifier_strncmp and
> verifier_snprintf). Verify in test_global_percpu_data_lskel() that
> lskel->progs.dump_percpu_data.prog_fd is properly populated (> 0) when
> loaded via the light skeleton.
> 
> Signed-off-by: Thiébaud Weksteen <tweek@google.com>
> ---
> No changes since v1.

The Fixes tags of v1 are dropped.

> 
>  tools/testing/selftests/bpf/prog_tests/global_data_init.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> index 7c539cbcf3a1..ebda60200b71 100644
> --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> @@ -214,6 +214,8 @@ static void test_global_percpu_data_lskel(void)
>  	lskel = test_global_percpu_data_lskel__open_and_load();
>  	if (!ASSERT_OK_PTR(lskel, "test_global_percpu_data_lskel__open_and_load"))
>  		goto out;
> +	if (!ASSERT_GT(lskel->progs.dump_percpu_data.prog_fd, 0, "dump_percpu_data.prog_fd"))
> +		goto out;

When the light skeleton does not skip the non-autoload progs,
lskel->progs.dump_percpu_data.prog_fd is 0, actually.

But, theoretically, this ASSERT_GT() is not good enough to prove the FD
is the correct FD of dump_percpu_data prog.

How about running the iter subtest against the lskel? Factor out
test_global_percpu_data_iter_fd() helper first. Then, add an iter
subtest using lskel.
When factoring out test_global_percpu_data_iter_fd() helper, pls change
'do { } while (0);' to '{ /* no-op */ }' btw.

Thanks,
Leon


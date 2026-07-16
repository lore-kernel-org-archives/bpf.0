Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E128F288B8
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 21:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784236096; cv=none; b=I0/KE8AXCFCGIq21m0ElBAAxX9gFOUy05ow+nJwEuPmLTQExHZ2ZVHVM35VeBhqRpAoFiH53/soTpEz08qG0RP1AJjPlBeicnqiV6no155mp2yOM0cksmz0CkmfGbdT78yjQVk5x9psn6VoQxDB2RmxCsjkSpKhr2mQYzHA8tPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784236096; c=relaxed/simple;
	bh=1ZqsNE/GmuCHMw4+SH1qNwiOv1l3GY9bjLTtcewpyug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SsH+MI7ooEcK0Hqz/t1YZLKk0KuFUCYcj/C+uqVXzIhrgYu3Y/nEe+J7gnfjo2DF0lpIoanki/L89/PfTnIgelY16b/9x+mLMgtQW9mT5N8PjuT0b6jcGlTjplIhOoo2kyu2efxrDI4SIP4mIL56o6JSvQQlU3YEssZdrMC3TcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TrsWmkOV; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TrsWmkOV"
Message-ID: <820ebdfa-b409-47d4-bff6-1b82dbdafbc5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784236088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Um0PMghg5xIGihHGzEaxKhXMlsjSe3s7HXenTfVGsn0=;
	b=TrsWmkOV2UUmOqBXbg4KSMy7MVqbFWJPbCWjILDlZnQrmHkD7i2Nyjiry4edyXobSZh8Ka
	XS1uaMU9/Y+0cG0Xdl/PKGYCsV6g2LBSKQDOACPb7II6iWkoJJVNrJDJcOYkHzxPSa+dN7
	je2I10XecRaAciSUf4aqn8/mK5HQBMg=
Date: Thu, 16 Jul 2026 14:07:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] selftests/bpf: A few edge case fixes
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>, Christian Brauner <brauner@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260710-selftests-bpf_fixes-v1-0-aa24dfd6f4f9@suse.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260710-selftests-bpf_fixes-v1-0-aa24dfd6f4f9@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/10/26 3:09 PM, Ricardo B. Marlière wrote:
> Hi,
> 
> Please consider merging the following fixes, found by means of targeting
> BPF selftests through openQA [1].
> 
> [1]: e.g. https://openqa.opensuse.org/tests/6087703
> 
> 1/4 ("libbpf: Search /lib64 and /lib in resolve_full_path()")
> - Hit by testing an older SLES root filesystem.
> 
> 2/4 ("selftests/bpf: Fix lsm_bdev dev_t encoding mismatch")
> - https://openqa.opensuse.org/tests/6087703/logfile?filename=test_progs.tap.txt#line-2706
> 
> 3/4 ("selftests/bpf: Install resolve_btfids.test.o.BTF where the test expects it")
> - https://openqa.opensuse.org/tests/6087703/logfile?filename=test_progs.tap.txt#line-3332
> 
> 4/4 ("selftests/bpf: Install bpftool where test_progs expects to find it")
> - https://openqa.opensuse.org/tests/6087703/logfile?filename=test_progs.tap.txt#line-806
> - https://openqa.opensuse.org/tests/6087703#step/test_bpftool_build_sh/1
> - https://openqa.opensuse.org/tests/6087703#step/test_doc_build_sh/1
> 
> The build process is done at runtime with BPF_STRICT_BUILD=0:
> https://openqa.opensuse.org/tests/6087703/logfile?filename=serial_terminal.txt#line-1937
> 
> Assisted-by: Claude Sonnet 5
> Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
> ---
> Ricardo B. Marlière (4):
>       selftests/bpf: Install bpftool where test_progs expects to find it
>       selftests/bpf: Install resolve_btfids.test.o.BTF where the test expects it
>       selftests/bpf: Fix lsm_bdev dev_t encoding mismatch
>       libbpf: Search /lib64 and /lib in resolve_full_path()
> 
>  tools/lib/bpf/libbpf.c                            | 3 ++-
>  tools/testing/selftests/bpf/Makefile              | 5 ++++-
>  tools/testing/selftests/bpf/prog_tests/lsm_bdev.c | 3 ++-
>  3 files changed, 8 insertions(+), 3 deletions(-)

Hi Ricardo,

Thank you for the patches, it's a good set of fixes.  We don't use
make install on CI, so it's not tested regularly.

I have a couple of comments, sending in a bit.


> ---
> base-commit: a635d6748234582ea287c5ffeae28b9b23f91c7e
> change-id: 20260710-selftests-bpf_fixes-06e9a2eb3c67
> 
> Best regards,
> --  
> Ricardo B. Marlière <rbm@suse.com>
> 


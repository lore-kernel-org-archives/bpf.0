Received: from mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3064B5156
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790272251; cv=none; b=THs1KxWDkoEQqaMvnohy7csromPRtkfc9PDXkax4GkllvBhTT+o14Q28Vt8PlXLsmICArlfdaAyjeEaFeog9MGJ0ediaB3hjPOsCazFK2LDPVukCEpB0YvOXtp7aN9LPQtKoe1Q9PpQ0+ZzcJJ43inR2ZAiLkfENmMNnjrr/eMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790272251; c=relaxed/simple;
	bh=N9IlZmV+dc33qNm8iXRdamPF7z77GrffJORokPIWQHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jM24qVP7H5XujIseCd7DXtb/gX5Cf9PD39nD/BcHK3KkW9E9cHzep/oX8kgkX07ldRKKch7qPM3Fm5koPVmGFvlEeM3A93coqjqdnQyWFbT/RevbWpAXAWKtRk/0UtDi9ehtCULzlDEy2TZWU6XDEwV0EW0VqLN/w8HcpZ5yfqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=scmHPL4I; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="scmHPL4I"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=N9IlZmV+dc33qNm8iXRdamPF7z77GrffJORokPIWQHc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790272246; v=1; x=1790877046;
 b=scmHPL4IT/Bs8ADSvzAxJZejsJw4/LvbTLvvd1hj4UrIU1KwMtjl/4uPI1ViZJr50Q+oGVGZ
 Ld2gNDXllpjrlOGBh9Xxu42dZI/i3XsOs0YSr27ZB1bIYkr4RQycaaWZj3CxzmEJt6mqKhkczxY
 IYWMyKR/Ik4S/XsPxUbBpR58=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e175e615348a9ef4;
	Thu, 24 Sep 2026 17:50:46 +0000
X-Mizu-Trace-ID: e175e615348a9ef4
X-Migadu-Flow: FLOW_OUT
Message-ID: <cd0ce2d0-8c56-4382-a384-24c8a52d6494@linux.dev>
Date: Thu, 24 Sep 2026 10:50:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 00/17] bpf: Indirect calls of bpf subprogs
 (callx)
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com
References: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
 <179022901639.1337807.12766583921039284951.git-patchwork-notify@kernel.org>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <179022901639.1337807.12766583921039284951.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/26 10:50 PM, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to bpf/bpf-next.git (master)
> by Alexei Starovoitov <ast@kernel.org>:

Hi Alexei.

Looks like this broke GCC BPF selftests build:

  progs/verifier_callx.c: In function 'apply_op':
    progs/verifier_callx.c:977:1: error: indirect call in function, which are not supported by eBPF
      977 | }
          | ^
      GCC-BPF  [test_progs-bpf_gcc] verifier_const.bpf.o
      GCC-BPF  [test_progs-bpf_gcc] verifier_const_or.bpf.o
      GCC-BPF  [test_progs-bpf_gcc] verifier_ctx.bpf.o
    At top level:
    cc1: note: unrecognized command-line option '-Wno-initializer-overrides' may have been intended to silence earlier diagnostics
    cc1: note: unrecognized command-line option '-Wno-microsoft-anon-tag' may have been intended to silence earlier diagnostics
    make[1]: *** [Makefile.skel:92: /codebuild/output/src4258392908/src/actions-runner/_work/bpf/bpf/src/tools/testing/selftests/bpf/bpf_gcc/verifier_callx.bpf.o] Error 1
    make[1]: *** Waiting for unfinished jobs....
    progs/verifier_callx_rodata.c: In function 'use_shape':
    progs/verifier_callx_rodata.c:746:1: error: indirect call in function, which are not supported by eBPF
      746 | }
          | ^
    progs/verifier_callx_rodata.c:746:1: error: indirect call in function, which are not supported by eBPF
    At top level:
    cc1: note: unrecognized command-line option '-Wno-initializer-overrides' may have been intended to silence earlier diagnostics
    cc1: note: unrecognized command-line option '-Wno-microsoft-anon-tag' may have been intended to silence earlier diagnostics
    make[1]: *** [Makefile.skel:91: /codebuild/output/src4258392908/src/actions-runner/_work/bpf/bpf/src/tools/testing/selftests/bpf/bpf_gcc/verifier_callx_rodata.bpf.o] Error 1

Could you please take a look?

https://github.com/kernel-patches/bpf/actions/runs/36028658230/job/107735139837

> 
> On Thu, 24 Sep 2026 03:10:25 +0000 you wrote:
>> [...]

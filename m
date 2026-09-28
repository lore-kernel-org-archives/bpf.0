Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370FC4A99A1;
	Mon, 28 Sep 2026 11:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790594836; cv=none; b=PC5fA3lJkogwx3h8P+9R6+yaKd1Gg17RztTSnxn/9L7iCy2ofg9P1yW9gJuAEkZObBlIn2mDQWL169b074vK3EPxoS+dMY4kPnz7GUYU3/XSGRTu/zu9vdCi0KBOcSAQjc/wJj7Ab+8yA3PM3fhDydPTsgHqjU1pYy3jzRpf01w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790594836; c=relaxed/simple;
	bh=sxmgudj3J7olxSOAQ0bhyanq3FP8da+zjs0WKCztNjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KKiDjP/hfQEjVQ7n1AydLog4wVzepFkP6e+rjVRQaEvsXVm1K9aUn+EDXHjMG3vvllcyphXeyp0KUPhNWdHLPIfkSoQd7Q/jScEnTSJAJjZiBiTOPiJHtvDsgMvK5BjlNBQ2mLIqo0lMMRcH+Z7edXkNGMoUDgrjpilBsLe/Jk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4qMKr8y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4qMKr8y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2581F00898;
	Mon, 28 Sep 2026 11:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790594835;
	bh=q6hWO7YA1Ork+9KWDHWrL1Ww9nSjGuM1MEJC+Lz3PpM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Q4qMKr8ypDpbGy697SVBRgxDehHNUWE6R0SLJmrF00OAvECgydpjZp81GfuYez3KK
	 SIdn2FtfsocnWmmmGDcI29XbHjNhmtd9zAH10cZ3GxkQU+FEDXAoBOUHdU5VP/xS/c
	 3/8AMKdhNOL2K4+DCGsQ0K/flhOKpqdfHGlOc1HpKBU/YGIgcCURLIkGIQj+wkPWi3
	 LOJLceXxk+OEgPv2nRF3XAyaknO3DGz0INuNqQlZ4rpE4722MWSfbQT7S/AbaSzU4n
	 lTwfp/+393hoGQrZBg4x8abPicqjQsPC91vJf9eYEMDyO/WIMfW/JJ8OL49qDmq7zO
	 XCuSSjRhnI+pg==
Message-ID: <042f378b-f053-42fc-bc5c-40f7e63edb95@kernel.org>
Date: Mon, 28 Sep 2026 12:27:11 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Test bpftool map dump on
 maps that can't be iterated
To: Maxim Skokov <skokovmaksimevg@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, kuba@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, hi@tychen.cc
References: <20260928001513.7072-1-skokovmaksimevg@gmail.com>
 <20260928001513.7072-3-skokovmaksimevg@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260928001513.7072-3-skokovmaksimevg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-09-28 03:15 UTC+0300 ~ Maxim Skokov <skokovmaksimevg@gmail.com>
> Socket storage can't be iterated from user space. Create a
> BPF_MAP_TYPE_SK_STORAGE map, attach storage to a socket, pin it, and
> check that "bpftool map dump" fails with nothing but an error: a JSON
> error object with -j, no elements on stdout in plain mode, and the
> reason on stderr.
> 
> Socket storage always has BTF, so its plain dump goes through the BTF
> writer and never prints an element count. Check that path with a queue
> map created without BTF that holds one element: its plain dump must
> fail without a "Found" line, which bpftool printed as "Found 0
> elements" before, and give the reason on stderr.
> 
> Assisted-by: LLM
> Signed-off-by: Maxim Skokov <skokovmaksimevg@gmail.com>

Acked-by: Quentin Monnet <qmo@kernel.org>

Thank you

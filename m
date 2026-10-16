Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6D23815F3;
	Fri, 16 Oct 2026 20:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792181338; cv=none; b=C505OKdSS2hYvNVMR+n2PXT6+4DP90YveCDvmiovctDufNKbhfT0NjR8qrvLV0fNKTHjWzBAqTzpuMP3mabxKSBzn3mVxOmhMQpR3hL/Pp3GvGWnd/Qu1+Xr+ws0HVOidvvCPYNlEy4jd1nBevkRxpq1MxMHO0r27PzY6x3jq+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792181338; c=relaxed/simple;
	bh=SaKQs2zNUpZhns8GSIivVjs3nmPkYdyU4za+qrQnZMI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=J2+wnj68CdIgBfpYRjJI4kvbtK5rU794GlNDjjsWCIXLL+MTy+mENS+4Syj2O0ORDZ4+EmIHK5ew4d1khpvUgyuiA+bZuHMwtRXirzDmo9t/SVTbtakaX9nu5PPDrtqoQK8KxvDBj5ED1Pod5Yc8bRCgC8gpxAfUmdgxpyE1Hn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYSe7qRL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYSe7qRL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F3E1F000C4;
	Fri, 16 Oct 2026 20:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792181337;
	bh=elXysiFudGVOWloF9IMd9idCC4oJs/gNj25iAElSsVc=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=jYSe7qRL9zNYz1bkXb9x2XlJ6/7bsAmgu7Pvpn2oZDF9Gu0avzd9lBS0Xa4shb2hd
	 sq0ZUu7sVnfE6juOxOzw/2PHxS7CImz/5KwnDrqM1UzXW9yjLqBNARd7K00FwwlmFA
	 jmLuKDH4fz15hZsvc51w0MBZyELp1d/SO112HyfNyMyoCTExblKVhSfQ7QxxyBU0iv
	 jtB3/aWfLNhCPKFWNNFcUvWTsmQOK0QgOLo3wwYs0WmzgveS3r4bsLxiPbT+2CrJt9
	 +ym2fuaRj3gM3P4hT3t/GS1NbPBF4x6Vr0O1BDpyOFkTIZpG4veV5zdtZATPObrcxF
	 vwtwcZgwFmrjg==
Message-ID: <e875e8a4-71f4-4518-b17a-140a4cc54d4b@kernel.org>
Date: Fri, 16 Oct 2026 21:08:52 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: qmo@kernel.org
Subject: Re: [PATCH bpf-next v5 3/3] selftests/bpf: Test bpftool map dump on
 maps that can't be iterated
To: Maxim Skokov <skokovmaksimevg@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, kuba@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, hi@tychen.cc
References: <20261016194825.230433-1-skokovmaksimevg@gmail.com>
 <20261016194825.230433-4-skokovmaksimevg@gmail.com>
Content-Language: en-GB
In-Reply-To: <20261016194825.230433-4-skokovmaksimevg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-10-16 22:47 UTC+0300 ~ Maxim Skokov <skokovmaksimevg@gmail.com>
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

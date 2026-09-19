Received: from mta0.migadu.com (out-20.mta0.migadu.com [91.218.175.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D0038424C
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 20:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789849949; cv=none; b=Uy3GrTeGHDDoQV6ttZs0PVzEbvHC7dcGdMHAyDDeyMKtXVEZscEh55IRDZQVeiABzXBj9p5hDgt/PNxuy7uGMDDLOvvIwSnhcDZfAKcnq3kJSFVcUjFP7WF80giXcC2aIiLv74C5ayKaw3TtO9dBNHT1v/4O272b9r3rc8oBTHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789849949; c=relaxed/simple;
	bh=WVtUx+dGDHgFc5tAIFSSh8TIVFAiQUjiXQsNFhwtf4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zhcki23vdy/mX10soEC1//4VHCq3nMC+25+GvfgGinCHYwQYUQHJV5a7bAvL7Pem/l8MrSFJaFaNIm6QiWw5QZYdEfs9SzTsxdWXDa46AAdkp6U6+quNorVt8gwxUQyMZvOUBm3W1kFRBk2PitikeD0RTCfQkEEE4Z+hoRZuUvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QhmIxS6h; arc=none smtp.client-ip=91.218.175.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QhmIxS6h"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WVtUx+dGDHgFc5tAIFSSh8TIVFAiQUjiXQsNFhwtf4A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789849944; v=1; x=1790454744;
 b=QhmIxS6hItrDFpfoqoW8usJEgteO/PeLniaCFAYBhy4qE803DHCgbODeDExROGMnlfRGGw0g
 Y1AHsBOS54vPoOs53+ihp5CHULNBXe8x2xCwiYV1QLwMGf4ajqceYETTHLyRrQaOxKxKI4n9Bt6
 pp/0IXKE9qjd/LHziApiu21Q=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e3c4d50c32b625a1;
	Sat, 19 Sep 2026 20:32:24 +0000
X-Mizu-Trace-ID: e3c4d50c32b625a1
X-Migadu-Flow: FLOW_OUT
Message-ID: <d93b7ef0-c7fa-45eb-8116-d424c211bc90@linux.dev>
Date: Sat, 19 Sep 2026 13:32:20 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 17/20] libbpf: Let the static linker carry
 .bpf_cleanup relocations
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260918044327.3292986-1-yonghong.song@linux.dev>
 <cf4e0c0bad4199fe7d97ba1fad39634daa6852dbda2f5292912e5d880523f963@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <cf4e0c0bad4199fe7d97ba1fad39634daa6852dbda2f5292912e5d880523f963@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/17/26 10:44 PM, bot+bpf-ci@kernel.org wrote:
>> An object that carries a compiler-emitted exception cleanup table cannot be
>> linked today. The table's fields are byte offsets into a code section,
>> materialised by a 32-bit relocation against that section's symbol with the
>> offset itself as the implicit addend, and the linker rejects both halves of
>> that: the relocation type is not in the list it accepts, and a relocation
>> against an STT_SECTION symbol from a non-executable section is an outright
>> error.
>>
>> Both spellings of that relocation have to be taken. LLVM emits
>> R_BPF_64_NODYLD32 for a .long against a section symbol; GNU as emits
>> R_BPF_64_ABS32, which is what bpf_reloc_type_lookup() maps BFD_RELOC_32 to.
>> They describe the same value, and the selftests are built with both
>> compilers.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> This looks like a bug fix for objects that carry compiler-emitted exception
> cleanup tables. Should this include:
>
>    Fixes: 9f0c317f6aa1 ("libbpf: Add support for new llvm bpf relocations")

No need for a Fixes tag.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35308528711


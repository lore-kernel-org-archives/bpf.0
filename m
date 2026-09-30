Received: from mta1.migadu.com (out-62.mta1.migadu.com [95.215.58.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE00547057
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 01:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790730658; cv=none; b=LeM8v1aQbgv5ObYw6b8XM711cz0Thp0pgfblNSjlv1gazvNHdfBLCUJTq0e0FupjKgIs+fGpweRNQvjcjaddJJiYJJPwwXJW96U1IkC7E42CLvXgSYvrp2eQXwimeP+lXuil/6LqUVOSOd/EqQ/yakH6NvUirf2Hr18irl8nMm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790730658; c=relaxed/simple;
	bh=yx3DpsZ1G/AAcMu4KmoGKktezWS1Sp/r+miLA11rH/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BrVKfXLwgrvXZWuNKq2gryW2jqcvfAFqBdok4RWDipjN3hYyPvkg6R+uFTOxWxZH/QLS1TWaDogmvkSrIq0H4bJM5EsOo/YAglgi/YMDmtaGz445RMODFoT255bCPetKWK/WVYAL6HKzq3sdGITb6TN7XHmArFclqvm7yyftKlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wpBKNwz8; arc=none smtp.client-ip=95.215.58.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wpBKNwz8"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=yx3DpsZ1G/AAcMu4KmoGKktezWS1Sp/r+miLA11rH/U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790730654; v=1; x=1791335454;
 b=wpBKNwz8Rx0EgqfiIJQuELKozLiuyQ7WMq9frwlq/dOEQbzY4FHOgw+y+rUnVqxaRWUZO+9Z
 dWGMur1cquEjMGsiEOjSWw6+GSUsd15G3kmI6IteypEjgesWKvgVYEfJjoe5xhlrqFZnhQG4zgF
 j6eUY0EYNZezE8a6JHTa3xBw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3aba92b707a0c9bf;
	Wed, 30 Sep 2026 01:10:53 +0000
X-Mizu-Trace-ID: 3aba92b707a0c9bf
X-Migadu-Flow: FLOW_OUT
Message-ID: <837734d4-de88-437f-bc16-3ffadb713ec1@linux.dev>
Date: Tue, 29 Sep 2026 18:10:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 08/22] bpf: Require an unwind to leave a frame
 holding what it entered with
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260929001643.3249386-1-yonghong.song@linux.dev>
 <7d45bfa94899a2626f053f2c0fd517a074a422d796ed64389a9033c9512efd7b@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <7d45bfa94899a2626f053f2c0fd517a074a422d796ed64389a9033c9512efd7b@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/28/26 5:52 PM, bot+bpf-ci@kernel.org wrote:
>> A landing pad's entry state is the state at the call it belongs to, taken
>> before the callee ran -- push_cleanup_pad_branch() snapshots it there. That
>> is right for the frame's own registers and stack, which the callee's
>> epilogue puts back, and wrong for what the program shares: nothing restores
>> the locks in bpf_verifier_state.
> Is the claim about the callee's epilogue restoring the caller's stack
> accurate?
>
> Looking at the BPF calling convention, the callee's epilogue only restores
> r6-r9 and the frame pointer. It does not restore the caller's BPF stack
> slots. A callee that receives a PTR_TO_STACK into the caller's frame can
> write that stack freely, and those writes are not restored on return.
>
> For example, if the caller spills a map value pointer to fp-8 and calls
> foo(fp-8) under a landing pad, foo can store an arbitrary scalar to
> *(u64 *)(r1 + 0) and then call bpf_unwind(). The caller's pad would be
> verified from the pre-call snapshot where fp-8 still holds the spilled
> map value pointer, but at run time the pad would load the
> attacker-controlled scalar.
>
> The same issue applies to any stack slot type change that the callee makes
> before unwinding, such as spilled pointers overwritten by stack writes, or
> dynptr and iterator slots clobbered by the callee.
>
> Should the commit message clarify what the epilogue actually restores?

Yes, this is a problem. I had some comments in patch 7. Will fix.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36502848904


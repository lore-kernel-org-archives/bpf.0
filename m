Received: from mta0.migadu.com (out-80.mta0.migadu.com [91.218.175.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100C737E5C9
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791475896; cv=none; b=c4XIzuYt7FooUotrmSrrc34bPMvIiS7Udwnm0xQnlALDeusxi4a1bY6lpbnm6mN8DpPFM4CW0uXP8YSxYFCvXWHuZbduei48O26RFSbHQLWdZxDen3YFtmzpInPu4omoBEr2OiW/e6ttjIFOrPGF1GKS7s7E66H9y6qh4xCMfI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791475896; c=relaxed/simple;
	bh=viLF2fq9nz2A2Gd/wk/7gphl0d3dKNZi0BcFnoenXRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDs1ita2HpU06HGK2LbI4nKj71gqLZeDRgAIQpA84PlurFlYtumhY456C931cijn7T8o9WNXUfvox3g7yNRssZWa96v/poqvkA+o7DXRq/TOsF2LvWi3CcXQX6LyDiBnt170aAPwWW/Gn7C9eMzIWAbUzJCmSFEYr04l8WnZYCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HV7l6IK0; arc=none smtp.client-ip=91.218.175.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HV7l6IK0"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=viLF2fq9nz2A2Gd/wk/7gphl0d3dKNZi0BcFnoenXRM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791475893; v=1; x=1792080693;
 b=HV7l6IK0Pe4oXt5Zi7HOAf+egHl8hKY/DTUSumFygFTF3IT6+s/w1AuONog7LBUtzeYZjwFu
 Gfb0WLdidbq5GGTt8cu+Dd1OavgrJlOpfkiZYsbsVUv87xJoAByE7/SXoXcX4vH+FUIuCKb/qD9
 JiziafBVnw6nN7kdqRGRXgUA=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d49d3be0aea5b4c7;
	Thu, 08 Oct 2026 16:11:32 +0000
X-Mizu-Trace-ID: d49d3be0aea5b4c7
X-Migadu-Flow: FLOW_OUT
Message-ID: <22958731-c1d0-4f8e-891f-1e58b4c321ba@linux.dev>
Date: Thu, 8 Oct 2026 18:11:31 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v9 08/23] bpf: Refuse a landing pad that does not
 resume
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20261008075040.2999036-1-yonghong.song@linux.dev>
 <14b2036055b5d1e4aa4d8fb77308eece081ef7326ef7afe208f7bd0ff3092136@mail.kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <14b2036055b5d1e4aa4d8fb77308eece081ef7326ef7afe208f7bd0ff3092136@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/8/26 10:57 AM, bot+bpf-ci@kernel.org wrote:
>> bpf: Refuse a landing pad that does not resume
> TL;DR: Commit message only: the patch also makes push_callback_call() reject
> callback subprogs that may unwind, even without a cleanup table, but the
> message doesn't mention it. Mention it or split it out?
>
>>      bpf: Refuse a landing pad that does not resume
>>
>>      A cleanup pad runs drop glue and calls bpf_unwind_resume(), so its frame
>>      returns and the unwind goes on. A catch pad carries on in its frame
>>      instead. Only the first is supported: bpf_unwind() rewrites every frame's
>>      return address in one pass, so a catch pad's caller would still resume
>>      at a pad.
>>
>>      Nothing in the record says which kind a pad is, but the code does: a
>>      cleanup pad reaches _Unwind_Resume, a catch pad a return. So the unwind
>>      marks the frame whose pad it enters, and refuses in the marked code:
>>
>>        refused                                  where
>>        ---------------------------------------  ----------------------------
>>        an exit: how a catch pad ends            the pad's own frame
>>        a tail call, a BPF_LD_[ABS|IND]: it      the pad's own frame
>>          leaves through an exit on a failed
>>          load
>>        an indirect jump: nothing a compiler     the pad's own frame
>>          frontend emits in a pad needs one
>>        a bpf_unwind(), a call to a global       the pad and its callees
>>          subprog that might_unwind
>>        a bpf_unwind_resume() outside a pad      any program
>>
>>      The first three are refused only in the pad's own frame: a subprog the
>>      pad calls may do them and still come back.
>>
>>      Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> The patch also adds a refusal that this table does not list.
> push_callback_call() now calls bpf_exc_check_callback(), which returns
> -EINVAL for any callback subprog with might_unwind set:
>
>    verbose(env, "subprog %d may unwind and is used as a callback\n", subprog);
>
> This check is not about landing pads, and it is not gated on
> env->cleanup_info_cnt.  might_unwind is set for any bpf_unwind() call, so
> it also applies to programs with no cleanup table.  Later in the series,
> bpf_prog_may_unwind() makes that case reachable.
>
> The restriction looks needed, since bpf_unwind_rewrite() stops walking at the
> helper frame between a callback and its caller, while the verifier would model
> the unwind continuing into the caller's frames.
>
> Could the commit message mention this restriction and the reason for it, or
> could the callback check go into its own patch?

This is not a bug as mentioned in the above. It indeed may worthwhile to
have a separate commit for callback checking since this commit is about
'refuse a landing pad that does not resume'...

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37747693645


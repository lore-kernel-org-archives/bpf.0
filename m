Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE96E388E5B
	for <bpf@vger.kernel.org>; Sat,  9 May 2026 13:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778333371; cv=none; b=JMIzNGzrdBFUb7WUCRXn+eT7tHB5oruYYSH9dmF36OyrtQGK2COYq6jHGQG2YnaBaGNCimAqgbjhMpkL8bkT/zlBxX4DyYHAMxWQPslhGchY03qYR+Q2I3mNUMcloh2jtkcA6oR1hnlpTcTBmKCjw8F8I1cFRQ9cbvWfypcqvAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778333371; c=relaxed/simple;
	bh=/PnKJAaXGqoBpHYQj8xT6FlijieoI81I75VzZ8wBz/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fqvnA1+lcm69flXhmPBBju8gHtGuFAKMG+WzGyHfeE1lWJwhAHMRzLPrhw1n/kzP859kW9mI/+nQYFM0G9yjxumRbDkSurndT5X6pUSwSpXzL9yD1akmF4aVfnJJzw7kr8N5+ZCekg8mutEuZuMgqbvjHSn8LXZ2eAm/52ctZDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T2XOel3P; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T2XOel3P"
Message-ID: <73ffbbd8-9230-4070-b49e-01f2319356fd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778333365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/PnKJAaXGqoBpHYQj8xT6FlijieoI81I75VzZ8wBz/s=;
	b=T2XOel3PnCppSBoAZPXFVQD/y4SAK7Vy6T84COllyv9i0HOYTO8tjW9xkKQYevo+vmepxy
	naLKSszgE51VODdrDu7R0xrzTEsnT4buIGYBFSiEvj/0kM6zZtW4UCHgQjzQDaERarKTg8
	Lqfr9VmLpcVqv6M8M6kTEscxqN/M7Ww=
Date: Sat, 9 May 2026 14:29:07 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 09/23] bpf: Extend liveness analysis to track
 stack argument slots
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260507213029.1130085-1-yonghong.song@linux.dev>
 <40b4fbd223c043b2a8d74fc2e5e57a59dda472f13279e8062792c84723cd5af8@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <40b4fbd223c043b2a8d74fc2e5e57a59dda472f13279e8062792c84723cd5af8@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/7/26 12:11 AM, bot+bpf-ci@kernel.org wrote:
> commit 66a19f95afbdbdfe3c3c887c8656037ebcca1be1
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Extend liveness analysis to track stack argument slots
>
> BPF_REG_PARAMS (R11) is at index MAX_BPF_REG, which is beyond the
> register tracking arrays in const_fold.c and liveness.c. Handle it
> explicitly to avoid out-of-bounds accesses.
>
> Extend the arg tracking dataflow to cover stack arg slots. Otherwise,
> pointers passed through stack args are invisible to liveness, causing
> the pointed-to stack slots to be incorrectly poisoned.

We should be okay since is_stack_arg_{st,stx,ldx} will explicitly
handle the liveness and then return. So there is no out-of-bounds access.

>
> This commit fixes a bug introduced in c364b7a0f7ae ("bpf: Support stack
> arguments for bpf functions"). That earlier commit added support for
> stack arguments but did not extend the liveness analysis to track them,
> resulting in incorrect poisoning of stack slots when pointers are passed
> through stack arguments.
>
> Should this commit include a Fixes tag referencing c364b7a0f7ae? The
> commit message describes fixing out-of-bounds accesses and incorrect
> poisoning that were introduced by the stack argument support.
>
> Suggested: Fixes: c364b7a0f7ae ("bpf: Support stack arguments for bpf functions")
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25523765323


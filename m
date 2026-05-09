Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6926336896
	for <bpf@vger.kernel.org>; Sat,  9 May 2026 13:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778332153; cv=none; b=ttlPCFhQR6Jc5P+bmM8n0zmCJI0JzZqqEtUJFgjDxN3MTk9ICcIVBBznIxnnMgR0NXhZDhMJd1gorudXxEuDhWo3/TfVMoYt+UpORwAaiuTAN10IrQ8Gvy0kYPQDG6GOGgDsdPS14QBcLlkNcqSZevU0iF6QujTbJSJAJhiH6zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778332153; c=relaxed/simple;
	bh=xkWlj1Kls9e5bK6ohiVf7AvpI7VWn2U2yFxb35Pb6Bw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZgn+GXHAMdXmbuLu+VRhlsZIE0agrgfrE13ejdhFiledXNEjHkKT3Ce9pVI1ru4kNI3vJjNnRLJO1ZlGd8rb7yFnsaaRrAQAbgwRe5nmgFD4BheJ9Zv8bFwj59c9KblhWSJNBjHvsGTxUkZsIHw68bJjtz3Dm8GbhQ33Nfm3Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qBvYAH3e; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qBvYAH3e"
Message-ID: <0dcccc25-8fdd-4fd0-9c71-52cd8bbed332@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778332125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkWlj1Kls9e5bK6ohiVf7AvpI7VWn2U2yFxb35Pb6Bw=;
	b=qBvYAH3eqPn/x0qwR7cHswbRkKm7QPMnCCaENzfRBoRR2xq4BQeA/I8HwAnruGI0aM/G+x
	m73aha7xfuJoqdnlFeDreqCplXTluvkenmxGYac7O0flTKlmK4JERXhFJ2kkRSxUFjV8qM
	hLRdm8UoiMCtAQ9qX8PS522cp6wejog=
Date: Sat, 9 May 2026 14:08:43 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 07/23] bpf: Add precision marking and
 backtracking for stack argument slots
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260507213018.1128602-1-yonghong.song@linux.dev>
 <08f7cab25b4acf6b4e71984b18fbfcf0754aec96742559fa689a6819302eb551@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <08f7cab25b4acf6b4e71984b18fbfcf0754aec96742559fa689a6819302eb551@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/7/26 12:11 AM, bot+bpf-ci@kernel.org wrote:
> commit 4c0111fe676cd1905f81c3bd7d7f87d41cc028f0
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Add precision marking and backtracking for stack argument slots
>
> Extend the precision marking and backtracking infrastructure to
> support stack argument slots (r11-based accesses). Without this,
> precision demands for scalar values passed through stack arguments
> are silently dropped, which could allow the verifier to incorrectly
> prune states with different constant values in stack arg slots.
>
> This commit fixes a bug but lacks a Fixes: tag. Looking at the commit
> message, it addresses a verifier state pruning issue introduced when
> stack arguments were first supported in commit c364b7a0f7ae ("bpf:
> Support stack arguments for bpf functions").
>
> Should this include: Fixes: c364b7a0f7ae ("bpf: Support stack arguments
> for bpf functions")?

We should not add a 'Fixes' tag. At this stage, r11 based insns
will be rejected in check_and_resolve_insns(). The precision marking
and backtracking handling won't be triggered.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25523765323


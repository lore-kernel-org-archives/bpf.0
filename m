Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8DC40F8E2
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777385330; cv=none; b=mr7Yd9V6CNnfEG1BBLFlnnqB2HR0GUSQz96WgDyGGvCm5LTBshYYRQ5TvSlL3/buoY0FdS0ytPDBBYdarf8wRaaBs/8C4bwtYtrKpA8jHbuZTL570e0/61Ez5tYZq3hpHkuHgJrjxSZw3ncxoKu+B2LknoK+nbshDNwWc6wY35k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777385330; c=relaxed/simple;
	bh=s05krf9lI5FgYYG2rRHim8V0GrKVCkvmXt+UgjJhwuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ROMajRRIgHdUVWoKkw6I3uexABEqG0k+QgpuKN+NAX/AyjeEKoHvBXWvOWvp9NaYASw6NS4SaRLYJaFseR2l85xcsv7qSUdMG2bBmJb4Y9vjAlyn/CT5ojahR50ZlizG6R5MhwKsj3QH46ZckEMChJFqNvR2j94934egs/3V4+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ulTniidq; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ulTniidq"
Message-ID: <13fb8e15-e859-490e-8306-b878ce9ffb31@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777385326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m+CI/JUF1i/9Bjk4NtfrR/COSHKq7dZSOHbjpfSQUj8=;
	b=ulTniidqOkQNEMU9FP4YlM4rHRFPUA1BKHvQ1UICQwV6N89NXqS1R5KKMYccoOoMGvSUT9
	gHI7+qc5PycM/JOJjOcbIqA1tjh9zrW8bT1Xz9MUTl/hbPFKpJHuJZGeidY542OWiKBV6Z
	ut2qLW6w400azhwTLPMkKuuB4xEkcf4=
Date: Tue, 28 Apr 2026 22:08:00 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v10 2/8] bpf: clear list node owner and unlink
 before drop
To: bot+bpf-ci@kernel.org
Cc: martin.lau@linux.dev, john.fastabend@gmail.com, yonghong.song@linux.dev,
 song@kernel.org, eddyz87@gmail.com, daniel@iogearbox.net, ast@kernel.org,
 linux-kselftest@vger.kernel.org, chengkaitao@kylinos.cn, shuah@kernel.org,
 jolsa@kernel.org, haoluo@google.com, sdf@fomichev.me, kpsingh@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, martin.lau@kernel.org,
 clm@meta.com, ihor.solodrai@linux.dev, andrii@kernel.org
References: <20260427165906.84420-3-kaitao.cheng@linux.dev>
 <bf44910330f919336457c4196379b221c8e7dcbd6c569cc9ed3c1a98d962155c@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kaitao Cheng <kaitao.cheng@linux.dev>
In-Reply-To: <bf44910330f919336457c4196379b221c8e7dcbd6c569cc9ed3c1a98d962155c@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2026/4/28 02:43, bot+bpf-ci@kernel.org 写道:
> 
> commit e4bda22d1a0e4a2ede811c0a776c6aba8b315b5a
> Author: Kaitao Cheng <chengkaitao@kylinos.cn>
> 
> bpf: clear list node owner and unlink before drop
> 
> When draining a BPF list_head, this commit ensures each node's owner
> pointer is cleared while holding the spinlock and delinks each node before
> calling __bpf_obj_drop_impl() to prevent invalid next node references.
> 
> This commit appears to fix a bug but is missing a Fixes: tag. The issue
> being addressed traces back to the introduction of bpf_list_head support in
> map values. Should this commit include:
> 
> Fixes: f0c5941ff5b2 ("bpf: Support bpf_list_head in map values")
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25009536772

The issue only appears after the later patch "bpf: Introduce the
bpf_list_del kfunc" is merged. Versions before that are not affected.
Therefore, there is no need to add the "Fixes: f0c5941ff5b2" tag.
-- 
Thanks
Kaitao Cheng


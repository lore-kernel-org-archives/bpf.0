Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB4A398902
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 08:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775552361; cv=none; b=Epe+UHl/3x/O2z4EV1+iel4knk7sstCSupdu9CqLv0GdiTZfohT3hxuCSKf3fKFGtBlSJF7/GBV9dM+7kT/7dTe3VzLLVvA8O6Xl8SUTxwUbFj/r/FJGXfkoldH1KC78AwrMtt2BD6gR/CgewStfg8vPe/cYmhBpO7mTPOfBI08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775552361; c=relaxed/simple;
	bh=kzPe7cYguztd8pYB4EPn6rZ8xQIR55TaLdq+PC14FuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CyDnYi8idOMzSbAKFYWswPyCrQbeQB7E3rXC8uhBTQWz+wx+WQ6xTqjrf5iEwR42xoiXfxve1+q3C4/8WgDj05KZZkYATZtWnrFKSsrZ4Q6grApAwiL2icst0pCd9OCGflaOM6yP8cFqsrCrTs1EzFiv9NdlPmZ2VlxoCLaaE4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kxvmNTtf; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kxvmNTtf"
Message-ID: <6adf726f-f51b-4a89-aadc-077a58feb311@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775552356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XDWb0lJ3wW4F+ozwtBvXRz4Q6WE9zw5Sm1x2OH2NoXg=;
	b=kxvmNTtfikqX4n8FX6S2BqjVmTkjfbT/mNhmOhMtBYH2zyBjObbiGmwZRLO2wN8vLRsFen
	GzGUEU1S1YMC5IXuaauStUpheD1Uu38Ewz8Fjdwn0ZG2NCkCx/RSB+2VrmobYNRVzSYUnd
	xo2t7po0FbJyErA5kIN0g4CQYZV2gIE=
Date: Tue, 7 Apr 2026 16:58:54 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: fix btf_types_are_same for cross-BTF type comparison
Content-Language: en-US
To: chenyuan_fl@163.com, martin.lau@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yuan Chen <chenyuan@kylinos.cn>
References: <20260407080900.551797-1-chenyuan_fl@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260407080900.551797-1-chenyuan_fl@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

pls also check sashiko's review:
https://sashiko.dev/#/patchset/20260407080900.551797-1-chenyuan_fl%40163.com.

Target tree should be specified: [PATCH bpf] bpf: ...

On 7/4/26 16:09, chenyuan_fl@163.com wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
> 
> When comparing types from different BTF objects (e.g., module BTF vs
> vmlinux BTF), the original btf_types_are_same() returns false because:
>   - Type IDs are local to each BTF
>   - Pointer comparison of btf_type_by_id results always fails
> 
> This prevents kfuncs with KF_IMPLICIT_ARGS flag from modules (like
> bpf_kfunc_multi_st_ops_test_1_assoc) from properly recognizing implicit
> arguments such as 'struct bpf_prog_aux *', causing the verifier to not
> inject the aux pointer value during fixup.

Should add a selftest to verify the BUG and this fix.

Thanks,
Leon

> 
> Fix by comparing actual type content (kind, size, name) when BTFs are
> different instead of comparing pointers.
> 
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---
[...]


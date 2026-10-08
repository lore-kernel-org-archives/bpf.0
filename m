Received: from mta0.migadu.com (out-149.mta0.migadu.com [91.218.175.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150174908AE
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791466040; cv=none; b=uq2TYA0mPfpBIjzjAinvvL1rYEwscpdE8gIBSPwI5EjRTFF1ToXgj6z+0tfzG8gZMy848l8mDpoA1E6Xu6a+Eynl8brNQmDt2AjhKrW65UAvHY1UMsq97oyOZdvuwTQD6wz98CjAG28t+sek+W2/N8V4LQJsKJj6+bJttjt7VlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791466040; c=relaxed/simple;
	bh=Un6FTkAp0ZC1YXZwaOKzOroevof1eNzgpS3AXOHS0hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=An2+jxif+KIcfYMWBMRYEYtdpftJ87UkQcxlLH2fOysPVjbalPmRkNGdqtKf4HbywCSL7io+sh+3ClfaDpQ6CNUwkR6AqNW+zUpYfz6yoamkH+hAZbe0klKJTk40++ik+pxbI+vbOepY4ZDsgfJD+Qpb3jy4QD9X8xc7wEAhZMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wXMY5aXp; arc=none smtp.client-ip=91.218.175.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wXMY5aXp"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Un6FTkAp0ZC1YXZwaOKzOroevof1eNzgpS3AXOHS0hc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791466036; v=1; x=1792070836;
 b=wXMY5aXprRPl57gK3Z0yDl9ZN6zkz1Y97X7SoBrKxGlOT3Z0PtaP2xBZKctTbIkwuW0O+Sqb
 BhKlblFp+ALc2CeXX7gKZDGqrkb30NCp4x5XbcB7f0OW637Ok/5tLqp8fNfWafg1bsjKOUFvVuQ
 MyY5Oj6yVda8UccFIfttX8/I=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2920918310c1af16;
	Thu, 08 Oct 2026 13:27:15 +0000
X-Mizu-Trace-ID: 2920918310c1af16
X-Migadu-Flow: FLOW_OUT
Message-ID: <3e620809-3049-49db-bdcd-e451b9264100@linux.dev>
Date: Thu, 8 Oct 2026 21:27:09 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v6 1/3] bpf: Fix incorrect handling of user flags in
 bpf_percpu_array_update
To: Masoud Aghasi <maghasi@disroot.org>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, john.fastabend@gmail.com
References: <20261008120734.1565972-1-maghasi@disroot.org>
 <20261008120734.1565972-2-maghasi@disroot.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20261008120734.1565972-2-maghasi@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/8 20:07, Masoud Aghasi wrote:
> For BPF_MAP_TYPE_PERCPU_ARRAY map, bpf_percpu_array_update()
> is not considering the possibility of a combination of
> (BPF_NOEXIST, BPF_EXIST) flags with (BPF_F_CPU, BPF_F_ALL_CPUS) flags.
> This causes the (BPF_NOEXIST, BPF_EXIST) flags to lose their effect
> in some cases.
> 
> For example, using the (BPF_F_ALL_CPUS | BPF_EXIST) flag combination
> with bpf_map_update_elem() results in an incorrect EINVAL error
> response, even though the flag combination is valid.
> 
> This patch fixes the bug by adding proper flag validations and checks.
> Before this patch, bpf_percpu_array_update() rejected
> BPF_F_ALL_CPUS | BPF_EXIST and BPF_F_ALL_CPUS | BPF_NOEXIST with
> -EINVAL. Also the BPF_F_CPU | BPF_NOEXIST were accepted.
> After the patch BPF_F_ALL_CPUS | BPF_EXIST is accepted and
> BPF_F_ALL_CPUS | BPF_NOEXIST and BPF_F_CPU | BPF_NOEXIST
> result in -EEXIST.
> 
> This patch also starts returning -EINVAL for (BPF_EXIST | BPF_NOEXIST),
> with or without BPF_F_CPU, which was previously accepted.
> 
> Fixes: 8eb76cb03f0f ("bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_array maps")
> Signed-off-by: Masoud Aghasi <maghasi@disroot.org>

Should carry my Acked-by in v5.

Acked-by: Leon Hwang <leon.hwang@linux.dev>

> [...]


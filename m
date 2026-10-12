Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2972C4746A9;
	Mon, 12 Oct 2026 10:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791799707; cv=none; b=Q6qclkV3Yn23wdezYSTnmIg5UvMbfBE60grf/w4aKq2auYnQtdOXGh3AnFCFoFMKibCDwU79cA22E+qFo1i28dMwfcbDvlEq5hWbvYKa100iBFEkdDjKANCxn36Yzvm/AeqUr81++SuOE9/34rDvqiNR+jPvPTCpq29DOCGQ3gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791799707; c=relaxed/simple;
	bh=EANPvdMPPdF9G7Wuza0FjvuLPse359NhvAJU1DgpR9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZK2G1RWNOKmKMx8jg0RjYeA/3qn+t2F4PaY5PqrYEYDzQ1BCiul/KcjNe+O3Rmj/tqHZA3CSrVZ2nWAzeR42eqGHQzZmw1dgj6Cjf37iLB6Xtd8MrZwqOrJMFp2C1TqE9tAumNUiAytpTf9pXtNiRxCWuuXkVfneXNZByd1Y/Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPOsx+Ac; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPOsx+Ac"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BAF1F0089B;
	Mon, 12 Oct 2026 10:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791799699;
	bh=kBTDTmXMGVxkxkdqj7Gd6GlBQTYcDIFXPtq2QB1c/xA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UPOsx+Ac0zqZCgm8ellgTD66XuK5zlqYYjB1l8hHGWi5f8U7jvGlXpeqkWRBCcBJa
	 bGPW3Y41qQqfGqdPE3gN0LhlVQiCZHBpPx/mXgJvt0WRFcsjoHN2RSr4s+YK/dlr+m
	 OZXNX0caCBrD/3QKMSAVB3bYFTF1OpmiTEMK+d4lalk7WncwPDtfpBOlMkSbLrMKX4
	 bqwtcWxRxu+EZBV/y617jXW8QOsgXtrqf1P9Jb5y/sWfoI9fcf5VT9WBqOsM/QOleb
	 co4dm0rbWZCX53LYSWbszfLq+TPMlPFnaXnwe2RU2BcMBtYI16vX8jMGiDgM3/YMWq
	 L0N3m949R01cw==
Message-ID: <a98bd4b9-932c-4b76-9c93-7ede4768c525@kernel.org>
Date: Mon, 12 Oct 2026 11:08:16 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpftool: Fix out-of-bounds read in kprobe_multi link info
 dump
To: chenyuan_fl@163.com, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, laoar.shao@gmail.com, linux-kernel@vger.kernel.org
References: <20261010074435.1415234-1-chenyuan_fl@163.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20261010074435.1415234-1-chenyuan_fl@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-10-10 15:44 UTC+0800 ~ chenyuan_fl@163.com
> From: Yuan Chen <chenyuan@kylinos.cn>
> 
> show_kprobe_multi_{plain,json}() walk the sorted kallsyms array against
> the sorted addr/cookie array with j as a cursor into the latter. The
> loop terminating condition is checked after the cursor has already been
> used to access the array:
> 
>     if (j++ == info->kprobe_multi.count)
>             break;
> 
> After all count entries have been printed, j has been bumped to count,
> but the loop keeps running and dereferences data[count] -- one element
> past the end of the calloc(count, sizeof(*data)) allocation -- while
> comparing every remaining kallsyms symbol. If the out-of-bounds value
> happens to match a symbol address, a bogus entry with a garbage
> addr/cookie pair is printed to boot.
> 
> Fix the off-by-one by advancing the cursor before the comparison, so the
> loop terminates as soon as the last entry has been printed.
> 
> Verified with an ASAN build of bpftool against a live kprobe_multi link
> of 3 symbols:
> 
>   before: ERROR: AddressSanitizer: heap-buffer-overflow READ of size 8
>           at link.c:860 (show_kprobe_multi_plain) and link.c:352
>           (show_kprobe_multi_json), 0 bytes after the 48-byte
>           get_addr_cookie_array() allocation
>   after:  clean output, no ASAN report
> 
> Fixes: edd7f49bb884 ("bpftool: Show kprobe_multi link info")
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>


Acked-by: Quentin Monnet <qmo@kernel.org>

Thank you

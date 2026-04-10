Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AABC1DC1AB;
	Fri, 10 Apr 2026 08:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775808266; cv=none; b=GVLn/OD8953872SOoCa3MZ1GJRcz1LuAYlhcFzfBTeXnUkGej75qyocedZxmPFSP0rqSekc4fehEKzChOLDRHno2Rp3mXWQJZ/rCwbeo3aGkv5HpfS32joGF0phyjTHWjnSlEEBGrGh9NwZ2bJSgtqe6OqL34lI9jKwKUGLFGZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775808266; c=relaxed/simple;
	bh=jrVu8XWsjxZwQuTVH3EWBOXQhHNrB9oge9KGU/njLPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jMdcH4XyzUEOmpq8W5bD6KkoqqLEv3PaL46X+hcKcdyRZo9xCuZ4gN3CoYJhEK0V5huPLXQXM5BQ15KDAOSSmR9w2hHmLTg56XpF6vGq01V1Q68zg+bVUEZLNZR8BLkWe+aJl63tnlt3a9UYtk99xOFS+xXQ5M1GUlSmwyH51fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FR0/h576; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FR0/h576"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=IE
	5nBF8P1ysGKQ0zp3fGcSHFrKNPjEwK1R/h//vIGfc=; b=FR0/h576yDNTgBaS8E
	XursAMBC1vhcMj0tqJXk9OCfI1fjIg+rmgkzYeEhvm7lLiHFjwGTOAds+UdOaHCn
	AFw5LEslZPb8Aok6v10/K/AveT6ksPZ1PCkkrtOF910mgKRRfgHTVVG9VAj+EF+R
	kRNbIh11G7Io7/XxLgjk6robY=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3P8PXrthpRdjWAQ--.103S2;
	Fri, 10 Apr 2026 16:03:40 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: yangfeng59949@163.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	jiayuan.chen@linux.dev,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev,
	mattbobrowski@google.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH v2 bpf-next 1/2] bpf: Fix Null-Pointer Dereference in kernel_clone() via BPF fmod_ret on security_task_alloc
Date: Fri, 10 Apr 2026 16:03:35 +0800
Message-Id: <20260410080335.196379-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260410061037.149532-2-yangfeng59949@163.com>
References: <20260410061037.149532-2-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD3P8PXrthpRdjWAQ--.103S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrW5tF45JFy3Xr4rAFWDArb_yoW8tF1UpF
	W7GwnFyr4qvrW29F47XF48XF1Fy39rKrWSgF95W3sFvw4Yv3srJrsrK34UtrWfCrWDJw15
	Zay2gFn0kFWUAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEEdgtUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8hxz62nYrty2FAAA3X

[...]
> +static int modify_return_get_retval_range(const struct bpf_prog *prog,
> +					  struct bpf_retval_range *retval_range)
> +{
> +	unsigned long addr = (unsigned long)prog->aux->dst_trampoline->func.addr;
> +
> +	if (within_error_injection_list(addr)) {
> +		switch (get_injectable_error_type(addr)) {
> +		case EI_ETYPE_NULL:
> +			retval_range->minval = 0;
> +			retval_range->maxval = 0;
> +			break;
> +		case EI_ETYPE_ERRNO:
> +			retval_range->minval = -MAX_ERRNO;
> +			retval_range->maxval = -1;
> +			break;

This refers to the documentation in fault-injection.rst:

Each error injectable functions will have the error type specified by the
ALLOW_ERROR_INJECTION() macro. You have to choose it carefully if you add
a new error injectable function. If the wrong error type is chosen, the
kernel may crash because it may not be able to handle the error.
There are 4 types of errors defined in include/asm-generic/error-injection.h

EI_ETYPE_NULL
  This function will return `NULL` if it fails. e.g. return an allocated
  object address.

EI_ETYPE_ERRNO
  This function will return an `-errno` error code if it fails. e.g. return
  -EINVAL if the input is wrong. This will include the functions which will
  return an address which encodes `-errno` by ERR_PTR() macro.

EI_ETYPE_ERRNO_NULL
  This function will return an `-errno` or `NULL` if it fails. If the caller
  of this function checks the return value with IS_ERR_OR_NULL() macro, this
  type will be appropriate.

EI_ETYPE_TRUE
  This function will return `true` (non-zero positive value) if it fails.

Restrict EI_ETYPE_ERRNO to only return error codes.
However, it was noticed that the self-test bpf_testmod_test_read uses 
ALLOW_ERROR_INJECTION(bpf_testmod_test_read, ERRNO); and returns 0, which causes a failure.
So should returning 0 be considered valid for the EI_ETYPE_ERRNO type, or should the self-test be modified instead?

Thanks.

> +		case EI_ETYPE_ERRNO_NULL:
> +			retval_range->minval = -MAX_ERRNO;
> +			retval_range->maxval = 0;
> +			break;
> +		case EI_ETYPE_TRUE:
> +			retval_range->minval = 1;
> +			retval_range->maxval = 1;
> +			break;
> +		}
> +		retval_range->return_32bit = true;
> +
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}


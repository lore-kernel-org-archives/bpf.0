Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB22E199FAB
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 06:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781071243; cv=none; b=m1OCjECkWH8uSZbxrmZNvKm4QlgAsJiVELZ2IBI4+/18SZT2UoLLCcvrtO9HkDbMfbOQacH4C1zf+NrUgy20twOfELme90Gom7EMYpmW8xUzwdqvZgKPWug4Ep6ElfBgOp7UVtjK0YAspI8e6KVtQ2swmlJXWPZKmIzp7ScnkFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781071243; c=relaxed/simple;
	bh=TtR8ArGj63R0+Vfoyu6nftWOSb2TV1TEPenHRCY6y1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ppc3b7c/B+LhLLByuZROddGwjJcm6RReJNBgyzTB67gUWqbznI7aQbGQ3VhZ/5Mx4W513Zzm+vHL9CwTEMh22ZdTQK3pq9uvtGB7+D7K5SOQkB1LEqsHCD4eIalwnAaw5oTZIvdb7LYXj7gHVMBe51EfonvCHQuzy3X4xbthE8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=azAKtmdL; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="azAKtmdL"
Message-ID: <74d31362-b1cc-4143-b112-ac0975dcb789@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781071238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IiPbqeIJzrNOL2ZTj5V52zsDbys6K23ngHiomc9DOX8=;
	b=azAKtmdLxNeS8UeUCybct+qkpCu6mMFuWEdaE/gkq9lQuS2FcnLYWCaGYx9WjMx59AyhKf
	wLP6iLY9kost4oPi+oCGL3gIGnP7TRbz5gjgngI8o8qi6vGJgNIv3j98XZ5SWEDl+Ph1ul
	x4PCCJej4ZVRTnj6dNA9tl3a71UJifA=
Date: Wed, 10 Jun 2026 14:00:25 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix bpf_iter/task_vma test
Content-Language: en-US
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20260610051831.1346659-1-yonghong.song@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260610051831.1346659-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/6/26 13:18, Yonghong Song wrote:
> For selftest bpf_iter/task_vma, I got a failure like below on my qemu run:
> 
> test_task_vma_common:FAIL:compare_output unexpected compare_output:
>     actual
>     '561593546000-561593585000r--p0000000000:241256579534/root/devshare/bpf-next/tools/testing/selftests/bpf/test_progs'
>     != expected
>     '561593546000-561593585000r--p0000000000:245551546830/root/devshare/bpf-next/tools/testing/selftests/bpf/test_progs'
> 
> Further debuging found out file->f_inode->i_ino value may exceed 32bit,

NIT:      ^ debugging

> e.g., i_ino = 0x14c2eae35, but the format string is '%u'. This caused
> inode mismatch between bpf iter and proc result.
> 
> Fix the issue by using format string '%llu' to accommodate 64bit i_ino.
> 
> Fixes: e8168840e16c ("selftests/bpf: Add test for bpf_iter_task_vma")
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Acked-by: Leon Hwang <leon.hwang@linux.dev>

> ---


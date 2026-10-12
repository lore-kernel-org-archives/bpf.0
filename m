Received: from mail-m49230.qiye.163.com (mail-m49230.qiye.163.com [45.254.49.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB83533A6F1
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 09:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791797872; cv=none; b=mRDFgIGw2lKXFsMykb5HJmgCJ+b1XQOqSlD1Kzc5Y/iXpj9kCYE8s3++18g+Pt06ydv3yTnPmHdcbkiW3Yleo3nRGwpNJ6SB5LeFOGq7QdwqQf+zOqqqyW61O9YJmb5UPyWHX8p68j2fsohxdhcXb4QWPD5TXEYEQ31pWAhxaRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791797872; c=relaxed/simple;
	bh=Hvt7MnDQjjBWOU9NchLOcOp7tp7tOJ/DAFW+UpkAgks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uPge4euAQKZk6XUh/HsB2PKxu1fARkQNgvnyrlVLXEx99cSTkxpOWrZHFBTAxRVc6+6+63hngpIK87x+N7iS2G3phjsAVaMVPJKEQSnpLk2r50YaZK7k7spl1jcbVjj1eq7XtPDnZl4WMoi9HF4/Q5wij9BhTsXoRlG2iGba1VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=45.254.49.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from [192.168.0.59] (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1ff574f2d;
	Mon, 12 Oct 2026 15:15:16 +0800 (GMT+08:00)
Message-ID: <c0e2960e-29be-4e80-8843-f0d11bb68c16@easystack.cn>
Date: Mon, 12 Oct 2026 15:15:15 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] selftests/bpf: add tests for the page_owner bpf_iter
 target
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261009112308.240769-1-zhen.ni@easystack.cn>
 <20261009112308.240769-7-zhen.ni@easystack.cn>
 <sashiko-outbox-165565@kernel.org>
From: "zhen.ni" <zhen.ni@easystack.cn>
In-Reply-To: <sashiko-outbox-165565@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa12ef738160229kunm575c19f55919f4
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTk5NVh8YT0gfHk4aTRhNHVYVFA
	kWGhdVGRETFhoSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVCQk
	lOS1VKS0tVSkJLQlkG



在 2026/10/9 20:50, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] bpf: missing __sz suffix in kfunc buffer size parameters bypasses verifier bounds check
> --
> 
> commit 40eb734de063d435912cf0b8932fbb912e64be44
> Author: Zhen Ni <zhen.ni@easystack.cn>
> 
> selftests/bpf: add tests for the page_owner bpf_iter target
> 
> This commit adds a sleepable BPF program and a userspace runner to test the
> page_owner BPF iterator. It exercises the seq_file and open-coded iterator
> paths and verifies the contracts of the get_nid, stack_snprint, and
> get_memcg_info kfuncs.
> 
>> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_page_owner.c b/tools/testing/selftests/bpf/progs/bpf_iter_page_owner.c
>> new file mode 100644
>> index 0000000000000..fada6a314a157
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_page_owner.c
> 
> [ ... ]
> 
>> +extern int bpf_iter_page_owner_new(struct bpf_iter_page_owner *it) __ksym;
>> +extern struct page_owner_scan *
>> +bpf_iter_page_owner_next(struct bpf_iter_page_owner *it) __ksym;
>> +extern void bpf_iter_page_owner_destroy(struct bpf_iter_page_owner *it) __ksym;
>> +extern int bpf_page_owner_stack_snprint(depot_stack_handle_t handle,
>> +					char *buf, u32 buf_size) __ksym;
>> +extern int bpf_page_owner_get_nid(struct page_owner_scan *scan) __ksym;
>> +extern int bpf_page_owner_get_memcg_info(struct page_owner_scan *scan,
>> +					 struct memcg_info *info,
>> +					 char *buf, u32 size) __ksym;
> 
> [Severity: High]
> Does the kfunc ABI exercised here bypass verifier memory bounds checking?
> 
> The BPF verifier requires size parameters for memory buffers in kfuncs to be
> explicitly annotated with a __sz or __szk suffix (e.g., buf__sz). Without this
> suffix, the verifier treats the size parameter as an independent scalar and
> enforces no relationship between it and the buffer pointer.
> 
> In mm/page_owner_iter.c (which this newly added test relies upon), the kfuncs
> bpf_page_owner_stack_snprint and bpf_page_owner_get_memcg_info define
> buffer size arguments as u32 buf_size and u32 size, respectively, omitting
> the required suffix:
> 
> mm/page_owner_iter.c:bpf_page_owner_stack_snprint()
>      __bpf_kfunc int bpf_page_owner_stack_snprint(depot_stack_handle_t handle,
>                                                   char *buf, u32 buf_size)
> 
> mm/page_owner_iter.c:bpf_page_owner_get_memcg_info()
>      __bpf_kfunc int bpf_page_owner_get_memcg_info(struct page_owner_scan *scan,
>                                                    struct memcg_info *info,
>                                                    char *buf, u32 size)
> 
> Consequently, the verifier only validates that buf points to a 1-byte valid
> memory region (based on the char type) while allowing arbitrarily large scalar
> values to be passed as the size.
> 
> A BPF program could exploit this by providing a small buffer alongside a large
> size argument, causing the underlying kernel functions (stack_depot_snprint
> and get_page_memcg_info) to write past the bounds of the provided buffer,
> potentially leading to kernel memory corruption.
> 
> Could these kfunc size arguments in the kernel be renamed to include the __sz
> suffix to ensure proper verifier bounds checking?
> 

This is the same __sz issue. Will fix it.


Thanks,
Zhen

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2938B3112DC;
	Tue, 10 Feb 2026 18:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770748877; cv=none; b=FYYHg95EEvEXZ03gi3Gq76Lqv9RHG/7GtzTpVihXumanxoJDYhSSLRpKkM2dkZ7VYqHZptwEFS1dw3pKcgQ6CjMCeymLzaTFUogUxEMETldCfT9wWT1u8fry2EIywhLtmcCB0X89KOEtcGdxQsdPM4F8NRE/+QvA3wbz1r84nFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770748877; c=relaxed/simple;
	bh=xyaw/tigngjCc+lT0XSZU87P0bu/6oUrpBcq/awZ6pg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sERoPWGgpQ37uRrOm7qbOfIyIvyWeiSwPpvgkFYh+bAeEP42E7ZXm2pZ6mCQ3VxH+yI0OHN/GBIWWKQUqDvaZtztEpR/I9kV/ObMIhiSKw8EaitgrihbsMP5wF+5MNg/pE8KnCC35oFrTnYLBlOpKdYn4qUHe86XGPqlEDpZhds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUPdjKUb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUPdjKUb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D29EC116C6;
	Tue, 10 Feb 2026 18:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770748876;
	bh=xyaw/tigngjCc+lT0XSZU87P0bu/6oUrpBcq/awZ6pg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=IUPdjKUblQnCIt8Q/w/JRLJb8Gx7ptOW77kn3FGAXaYjfly5xRyki92go3bp75Y7d
	 1r0x4yHnke4si+ewjkp6ktvmAQr8YuW8B3AdLZKGoMqDMqoCBkMCwCv8VpNYR0PqJH
	 e081OwOi4as9xBzv+Ekzl+N99A+gJf4Hy2v+N7Vc+wEjU6pevo8G+WdsxcXigvR50y
	 GHDiEuYWEKW58PnOPcjSVwH64bM43R8KyFtpQYQydT6mwhkV8dagbuHyrcQQKIgFJv
	 h0fdSq7WQyjqjONaLQHvJFcT0dEDhedr+gNUH+PogPba5pMM3lqL9d3AMrEoixEgwj
	 u8wyX4jpaxf2g==
From: Thomas Gleixner <tglx@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, surenb@google.com,
 shakeel.butt@linux.dev, Andrii Nakryiko <andrii@kernel.org>,
 syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com,
 syzbot+237b5b985b78c1da9600@syzkaller.appspotmail.com, Peter Zijlstra
 <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [BUG] [PATCH v2 mm-stable] procfs: avoid fetching build ID while
 holding VMA lock
In-Reply-To: <20260129215340.3742283-1-andrii@kernel.org>
References: <20260129215340.3742283-1-andrii@kernel.org>
Date: Tue, 10 Feb 2026 19:41:12 +0100
Message-ID: <87qzqsa1br.ffs@tglx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jan 29 2026 at 13:53, Andrii Nakryiko wrote:
>  	/* unlock vma or mmap_lock, and put mm_struct before copying data to user */
>  	query_vma_teardown(&lock_ctx);
>  	mmput(mm);
>  
> +	if (karg.build_id_size) {
> +		__u32 build_id_sz;
> +
> +		if (vm_file)
> +			err = build_id_parse_file(vm_file, build_id_buf, &build_id_sz);
> +		else
> +			err = -ENOENT;
> +		if (err) {
> +			karg.build_id_size = 0;
> +		} else {
> +			if (karg.build_id_size < build_id_sz) {
> +				err = -ENAMETOOLONG;
> +				goto out;

Introduces a double mmput() here.

> +			}
> +			karg.build_id_size = build_id_sz;
> +		}
> +	}
> +
> +	if (vm_file)
> +		fput(vm_file);
> +
>  	if (karg.vma_name_size && copy_to_user(u64_to_user_ptr(karg.vma_name_addr),
>  					       name, karg.vma_name_size)) {
>  		kfree(name_buf);
> @@ -798,6 +808,8 @@ static int do_procmap_query(struct mm_struct *mm, void __user *uarg)
>  out:
>  	query_vma_teardown(&lock_ctx);
>  	mmput(mm);
> +	if (vm_file)
> +		fput(vm_file);
>  	kfree(name_buf);
>  	return err;

See:

        https://lore.kernel.org/all/698aaf3c.050a0220.3b3015.0088.GAE@google.com/T/#u

Thanks

        tglx

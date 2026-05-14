Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA773A48FA;
	Thu, 14 May 2026 19:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778787453; cv=none; b=G1dIgKDWSWpJjixPNFfDsS67JUAXNcB/g9LlRBAdgvup1TRdxgZC8hfJ6o4M/X0F+1mCXkRJPZkTzsmu9KVhIAT81b053eBZQjLRCa5EkdXYigj++Ewz70eY8stTl4eRkcQx5ZrPUADdnQP1/hW/GOrSalVnFmd3sf/fJFDP7Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778787453; c=relaxed/simple;
	bh=/+dZ8nGJZuybUzq06kQIFsXoZz+u3cDkmPP3cu6PGTs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=KnuPzQZgGcCw/oQTeEBfFhvIienfKcrMvstHeH902nflKc4pGckwkkfTN77ZudVAEzRhnOhHkMtj1odbS9eBdbXdguCpTxJaiO+WCu9BQ+46hIEgNH36mITynNyCrCypQsNm7pq8zjPanZatEb5GBKuCg2RwG17qwkFMzHj3xEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmf+zqSf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmf+zqSf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2EEC2BCB3;
	Thu, 14 May 2026 19:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778787452;
	bh=/+dZ8nGJZuybUzq06kQIFsXoZz+u3cDkmPP3cu6PGTs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=bmf+zqSfHvNr30yyAXG2PAqyMQaMHr5evOwuK9sPC+grYdQUZuMmX9aCHkJXBYExz
	 HZezWVDA4wP87tS9gPEVJ9T9k+k5O2zstAEsAmp0olHrsOlUS0+Yym62Ck6F9k7wj3
	 wXQ9EBuEkQvo3Hr7dCJJcE7rtLOJPv5t12M6Z+gYcPZE6UiATVdqHmr0Af7cLhYYn4
	 giYmHmf7Ml8ET7fiBLbJkR+mammHsHjEVUtwW3dm0tlxSbw5dmpSqUZvZFfefAjfwj
	 I2FdTDXMxc+W0iinW423aNdpr3HxovWzw7poKCtttvRqjCSzN/Fiq8OoGGxTgQ/Z4W
	 Vd41JqHAFf6AA==
Content-Type: multipart/mixed; boundary="===============7940487679058569714=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <60d93fdedd03f85f50445e3648790e150b418775c03f1b5f0ae0dab4b72ff821@mail.kernel.org>
In-Reply-To: <20260514184727.1067141-4-ihor.solodrai@linux.dev>
References: <20260514184727.1067141-4-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf v4 3/3] bpf: Cache build IDs in sleepable stackmap path
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com
Cc: puranjay@kernel.org,shakeel.butt@linux.dev,mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 14 May 2026 19:37:32 +0000 (UTC)

--===============7940487679058569714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index c1e96df360c3..8a18c9645933 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -226,13 +226,33 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
>  		.vma = NULL,
>  		.mm = mm,
>  	};
> -	unsigned long vm_pgoff, vm_start;
> +	struct {
> +		struct file *file;
> +		const unsigned char *build_id;
> +		unsigned long vm_start;
> +		unsigned long vm_end;
> +		unsigned long vm_pgoff;
> +	} cache = {};
> +	unsigned long vm_pgoff, vm_start, vm_end;
>  	struct vm_area_struct *vma;
>  	struct file *file;
>  	u64 ip;
>
>  	for (u32 i = 0; i < trace_nr; i++) {
>  		ip = READ_ONCE(id_offs[i].ip);
> +
> +		/*
> +		 * Range cache fast path: if ip falls within the previously
> +		 * resolved VMA range, reuse the cache build_id without
> +		 * re-acquiring the VMA lock.
> +		 */
> +		if (cache.build_id && ip >= cache.vm_start && ip < cache.vm_end) {
> +			vm_start = cache.vm_start;
> +			vm_end = cache.vm_end;
> +			vm_pgoff = cache.vm_pgoff;
> +			goto build_id_valid;
> +		}
> +
>  		vma = stack_map_lock_vma(&lock, ip);
>  		if (!vma || !vma->vm_file) {
>  			stack_map_build_id_set_ip(&id_offs[i]);

During v3 review, sashiko-bot@kernel.org raised a concern about VMA
classification that remains unaddressed. While the !vma->vm_file check
predates this patch, could this cause issues with anonymous VMAs that
still have a backing file?

For example, private mappings of /dev/zero or driver memory can have a
non-NULL vma->vm_file but are still considered anonymous. If the
stackmap path proceeds to parse the ELF build ID from these files,
could it trigger unintended side effects, such as consuming FIFO data
or altering hardware state when reading from character devices?

Would it be safer to check vma_is_anonymous(vma) here to properly
classify the VMA?

Reference: https://lore.kernel.org/bpf/20260513043154.24483C2BCB7@smtp.kernel.org/

> @@ -240,9 +260,21 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
>  			continue;
>  		}
>
> -		file = get_file(vma->vm_file);
> +		file = vma->vm_file;
>  		vm_pgoff = vma->vm_pgoff;
>  		vm_start = vma->vm_start;
> +		vm_end = vma->vm_end;
> +
> +		if (file == cache.file) {
> +			/*
> +			 * Same backing file as previous (e.g. different VMAs
> +			 * of the same ELF binary). Reuse the cache build_id.
> +			 */
> +			stack_map_unlock_vma(&lock);
> +			goto build_id_valid;
> +		}
> +
> +		file = get_file(file);
>  		stack_map_unlock_vma(&lock);
>
>  		/* build_id_parse_file() may block on filesystem reads */
> @@ -251,11 +283,29 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
>  			fput(file);
>  			continue;
>  		}
> -		fput(file);
>
> +		if (cache.file)
> +			fput(cache.file);
> +		cache.file = file;
> +		cache.build_id = id_offs[i].build_id;
> +
> +build_id_valid:
> +		/*
> +		 * In the slow path cache.build_id points to id_offs[i].build_id.
> +		 * Cache hits leave cache.build_id pointing at a prior slot,
> +		 * triggering the memcpy here.
> +		 */
> +		if (cache.build_id != id_offs[i].build_id)
> +			memcpy(id_offs[i].build_id, cache.build_id, BUILD_ID_SIZE_MAX);
> +		cache.vm_start = vm_start;
> +		cache.vm_end = vm_end;
> +		cache.vm_pgoff = vm_pgoff;
>  		id_offs[i].offset = (vm_pgoff << PAGE_SHIFT) + ip - vm_start;
>  		id_offs[i].status = BPF_STACK_BUILD_ID_VALID;
>  	}
> +
> +	if (cache.file)
> +		fput(cache.file);
>  }
>
>  /*

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25879521172
--===============7940487679058569714==--

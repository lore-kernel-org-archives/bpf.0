Received: from mta1.migadu.com (out-169.mta1.migadu.com [95.215.58.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD7A383320
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 21:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791496100; cv=none; b=ijZeGShJMg21YqURyOwT/GvGiDD3ZvyDAwM3vjgNa5QWATQxG73aBuc7/cLhrrPhcH6I040LpUjtgJGutwt7Y72SGou5mdVAimtkIxS4Ge1qEJYorSqt7g3W55DEmVoDIFQGQe0V2K8D45siif2sBVeMaDc3/hb1wS3/0aXcn58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791496100; c=relaxed/simple;
	bh=JHSucTSg3QijIyFlRiljDu/KhLUuZiBG3coap6ISBt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IwLhSXcrBG7RZ/sk6ecUcDrwue90evwwp8fu919UHxSBLkyTTwq06h32nUHR6/TJGTnin4owiA978cgPIBx1TnQL8V9/ecFirhunpsH+7P794qbZgjHXqru+oRwq7V5cK6fTwVoXcbfopBu8TDlyyRNgERau6+J8pybFUEzA/8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xkSnrgLF; arc=none smtp.client-ip=95.215.58.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xkSnrgLF"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JHSucTSg3QijIyFlRiljDu/KhLUuZiBG3coap6ISBt0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791496094; v=1; x=1792100894;
 b=xkSnrgLF/dlsQEamjwaapG2CON4B1Vul0chudMCXr48T0B1DYxYi5112t+61hanWqqLcBiRl
 Ntcfo/4UsCEC2WpdrOneHifKEpPnrOh6RVwMLRfjv1CiNvEIKzyPf4gF+6BjVQab5/WpXOUohtw
 LDnAMeGBO703HZYExiav+loQ=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 871702971b78ecae;
	Thu, 08 Oct 2026 21:48:14 +0000
X-Mizu-Trace-ID: 871702971b78ecae
X-Migadu-Flow: FLOW_OUT
Message-ID: <e139339c-1e55-438b-86bf-0960ad4029f1@linux.dev>
Date: Thu, 8 Oct 2026 14:48:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/vma: keep the unlinked VMA off the file across
 unmap on mmap hook failure
To: Oleg Keri <okerixx@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, bpf <bpf@vger.kernel.org>
References: <20261007101800.58d50b1b20a10738e630bfd5@linux-foundation.org>
 <20261007194708.2009-1-okerixx@gmail.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20261007194708.2009-1-okerixx@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/26 12:47 PM, Oleg Keri wrote:
> Since commit 2ceb21171dd9 ("mm: consistently validate VMA state after
> mmap[_prepare] hooks"), the mmap error path clears vma->vm_file only
> after unmap_region(), so free_pgtables() unlinks the never-linked VMA
> and drops i_mmap_writable. Once it goes negative, every later shared
> writable mmap of that file fails with -EPERM until reboot.
> 
> Clear vm_file across unmap_region() only, so that free_pgtables() does
> not unlink a VMA that was never linked to the file, and restore it for
> vma_close(): when the hook succeeded and the validation failed, the
> driver's close() still runs and may use vma->vm_file.
> 
> Fixes: 2ceb21171dd9 ("mm: consistently validate VMA state after mmap[_prepare] hooks")
> Signed-off-by: Oleg Keri <okerixx@gmail.com>

Tested-by: Ihor Solodrai <ihor.solodrai@linux.dev>

BPF CI caught this bug on linux-next as well:
https://github.com/kernel-patches/bpf/actions/runs/37736351874

The patch fixes it:
https://github.com/kernel-patches/bpf/actions/runs/37829434215


> ---
> v2: keep vm_file for vma_close(): with the hook succeeded and the
> validation failed the driver's close() still runs. Reported by Sashiko
> via Andrew.
> 
> Seen on next-20261006: one refused PCM mmap probe from alsa-lib left the
> device unmappable, so PipeWire could not play anything.
> 
>  mm/vma.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/vma.c b/mm/vma.c
> index dfa45c64222c..531e4f53fdd7 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -2616,12 +2616,15 @@ static int __mmap_new_file_vma(struct mmap_state *map,
>  	map->vm_file = vma->vm_file;
>  
>  	if (error) {
> +		struct file *file = vma->vm_file;
>  		UNMAP_STATE(unmap, vmi, vma, vma->vm_start, vma->vm_end,
>  			    map->prev, map->next);
>  
> +		vma->vm_file = NULL;
>  		vma_iter_set(vmi, vma->vm_end);
>  		/* Undo any partial mapping done by a device driver. */
>  		unmap_region(&unmap);
> +		vma->vm_file = file;
>  		/* Only safe once unmapped. */
>  		vma_close(vma);
>  


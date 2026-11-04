Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793778385;
	b=iXakARvz/PJB6wQnlA4h824CHXHdpMmou4dk5hlGq4YRmSo7scUAFXAJMJpZSYHaxYb3
	 Ne/HGIog790oj1CQEyDKjp/f2YrvF1df9iR5X93cgrTwbfAw7844OgTH4C18wklWLFL4p
	 5E6xMH5Kwxw9sqm5zV6iFQNvB5uJ6Wj49lfYkXGRfdfkun+/PfLCsTLBF26C4uKKmEfE+
	 sNK0pn6qzN2LS0oXGKmi+RCJhkEFN90B1b9rqW2hzR262ygP6ra2til3RTc/bKOqlMlEH
	 C5eO6lmOd/nobc4RVTlzgKzhtuv91XnJk3gi0TOef2TAqLGEC7fgOArL2wYIppRpcWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793778385;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=lsvew4WfCYakXj0qeP5Ol6UCHiG3rtzUc6TCtTcDj38=;
	b=yoP77gsj33jg3tkp7Ah0Iav39mfQPCVF+L2BoOi/E09CUVRunNfmcusSJY4x2t2WpKwi
	 MK0UrGBJO0CORrfCEDnniqCVAmAgchGo1ET9Np/1LO5PLE2iw9t3ElJ9eu4PoJIbQhgHC
	 2Z0aePSjDtbhlZxYoQfRW9ZiTWig8ZuAC/lvuAyQtqcIe6Uf7XZMXlLqNLeBaCqNSLBjl
	 Zuf8vzMvbx3zPXT1Kl/0XRQKWWg/xsMS0jHLLkuVcWxtwOaeUZwhcRtODrflScEek6Pyr
	 T5q9BQEn+GfmfU6qMkWtu64zecfaZfwGzt/2G1yMGMGhKDWkQ7PnsQ3vONuQd3TpQ9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SrUDrC1n;
	arc=none smtp.remote-ip=91.218.175.184
Received: from mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC82606A32E
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 07:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DC82606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SrUDrC1n
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lOeRWLkwojHUr+kCvKucNzS99VgHJLzpoVD7LuCzBQU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793778380; v=1; x=1794383180;
 b=SrUDrC1nEYDfnDbcjhM6U8YikKVcoVmMepiQ6kH0khyq+37Cz41vPf1A6NfktIbZup9kWkDF
 TOQXoVJizKP5XMi9kWwwoYvJDEJ9lfVjWTc4YY4geW02Jzkqf2EcMY2RbcYoGPvpwyXhG6JPIlE
 5Jr2093XGM9q6FtQWqh9izns=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ee7e5ef34284ef57;
	Wed, 04 Nov 2026 07:46:19 +0000
X-Mizu-Trace-ID: ee7e5ef34284ef57
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: ljs@kernel.org
Cc: david@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun@kernel.org,
	longman@redhat.com,
	surenb@google.com,
	vbabka@kernel.org,
	shakeel.butt@linux.dev,
	yonghong.song@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 1/5] Revert "mm/khugepaged: remove definition of struct khugepaged_mm_slot"
Date: Wed,  4 Nov 2026 15:46:13 +0800
Message-ID: <20261104074613.30583-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261103-khugepaged-latency-fix-v1-1-a07ab16ac860@kernel.org>
References: <20261103-khugepaged-latency-fix-v1-1-a07ab16ac860@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Tue, Nov 03, 2026 at 08:27:42AM +0000, Lorenzo Stoakes (ARM) wrote:
>This partially reverts commit b4c9ffb54b32 ("mm/khugepaged: remove
>definition of struct khugepaged_mm_slot"), as a subsequent commit needs to
>resurrect this type to store additional data alongside the mm_slot.
>
>The stated intent of the commit was to address a NULL check in
>__khugepaged_exit():
>
>	mm_slot = mm_slot_entry(slot, struct khugepaged_mm_slot, slot);
>
>slot can be NULL and mm_slot_entry() is an alias for container_of(), so
>this is container_of() a NULL value.
>
>This was benign as there was only 1 field in khugepaged_mm_slot (offsetting
>NULL at 0 results in NULL), however it was right to fix this, so retain the
>fix.
>
>It also unwrapped KMEM_CACHE() in khugepaged_init(). This was a mistake,
>and was itself reverted in commit c14bdcc9f274 ("mm/khugepaged: use
>KMEM_CACHE()"). Therefore, retain the KMEM_CACHE() form in this revert.
>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

With patch #02 adding a per-mm scan position, bringing khugepaged_mm_slot
back looks reasonable to me ;)

Reviewed-by: Lance Yang <lance.yang@linux.dev>

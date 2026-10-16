Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797FC313540
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 02:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792116204; cv=none; b=GZL2vSOprK21693h1J8HIgeFugKvgaLLGUd2aL7mLivQkTCMipif5NJoKlGxyjYSopA/6BP40wAHTZWXz0pbx2b5ahQUU7XAcc8huBewlGPnXmHWjPTfPZFcL9QpTWbooI8aNb5TFbilrpZmHZYihZ49OeokLybii2N91CyLWP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792116204; c=relaxed/simple;
	bh=BDzKme1r9B5reKp41Cx6YU8lkToy0z0spfcwxXdCLO8=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:MIME-Version; b=t+z4f41QUmeboMzBGX+ukVTgqU4Jz4XRqn5bvBNtpj4No7UB09RQQrgga+p79cxa5k026I+gFyTwO6pHYHAdf2tYLW4GG5SThH3VlvGTrD947wEYrQhQegD4S8v0gLN7UIIcdmailDY0y9N/aZtid3axVPBXnJf8z+GkCgqq2NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTLez0kY; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTLez0kY"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-88b7d853b11so1159937b3a.1
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 19:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792116203; x=1792721003; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1Gh9i/gzVaTG78m+B2ZMMISjZ0R1I9br9qV5pX4BcyQ=;
        b=NTLez0kYmSEJ/zKk2vMt/TT0QuDhe+gISzTiQ2WtPK7cSsZ2jK/dIlvodHR6Q1ibRz
         XpSz0Mp4KrN6ocd36HECtHrwAnp7NoTCd7lm9asIJfomBsZGG1KdKA6rJGdP4666XK9x
         H8VPff8NmZIz2S9Eu3Ia2WqEX8URYfIe3nfYAy3bSS+DltdVlg+1FQVpPzJ1iu4R4lVt
         PzWzi4huZJziD1QG9BZ9XuWk0jikuDDChdZ13FZVHLfoo4Ya/qUmlxZymXLZNeEz8IDe
         WACiTbl+nbmN63iIyTMq4pDizxeT8q0aCPxMlCbDrPd/xycdjsJu96JN9keuNiM+PEV/
         4rUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792116203; x=1792721003;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Gh9i/gzVaTG78m+B2ZMMISjZ0R1I9br9qV5pX4BcyQ=;
        b=P7lJgek+IblvRn4xJqBpIIsCBHglFCimdL1YOcD89MoMKuQxpIz5wpChv6MhzDpY6T
         xeJxq0Oflfgld3naRFdF1VR+SaAL0l6lvJo4J9abeZel9zt0YvK4cMRMoT0Z2RzL+vNS
         lsq0Yhk9asTHiJy+HBkVRiX6wqC0dMSW4slDxZSrFN4ALvDV5DjmhyskuE/KqEZDRKHW
         eMUJheSMHbkzamFvmkrAgwSdwT0KWmOIeewx1yBBK0YzAeHwXBDFHvqfUbIFD5xLnoM6
         Y+v3GC0Ho1liQB7aT4rFtlnZ+Vztl41197w6hOSJypEkGlwJD6wNuZ1zk9RbrzEGoPRx
         3zpg==
X-Forwarded-Encrypted: i=1; AKwUvBz+OcLFlo0781fgf8SF0cT/OvVvoJsLeEMgfZpaXkXvLsn07GZboTOfJBC8u2P+26hLags=@vger.kernel.org
X-Gm-Message-State: AFq9FYIluS1yUxMVDr6pnf5Vs7S28td/Ljj3bEnVKpKcAKf2jyQQTy4o
	6oJyNGLg7mgXsYblagnBnpqGD/95cVNPn59MO2BqUEkhhyrk2xO/8OXc
X-Gm-Gg: AYBFou1efpHg+rVuFmZrjDv+xYV/xpdmnuO7p9y7Mlj5y3a2MoK63900gJZ0ptyGrTT
	+MPvVlOeEgaAVj0q0R4OJ0lauRpaYGLiKjdCD+pRZJxlQhpZ4NGSgdOB6fgvuXieoR0fBpq0ICe
	iu9ewbLrsXzSmVKB5xeQ366F9jhRbtKytpNAwUxMmpV1nDQxFXUmQgaJUtIW5+pgIUXH0ns3Qc8
	akiriBKns7lYr4XkXlYkNi7l+xa36PnohABKEsf+IVVteNwaTp+vRycDBPFEsPaDHXP1FD6aq17
	TIlVUI8W4xinCXPf60eeKZqSm0H9f0yhgl0iFMLSPHRPhjX8zLj7JCVYbah7tOEBVYviVyFDaXR
	cb5x1U4mX+vWOpsZju0ZOLN56lU+/TeYambGVGMGDfRYYDM3Gx2v83cMjXIRdHLNEiZqyIZnqtZ
	fHmOcj6PcsfywJjL+Roj219zb+HEXv1RQ3pOt2y3/tQ6F2JHsgr2ReKlgZo8RM4adEDxgW09UDg
	MvRuMG+Tj63kQeZ3tEXIi8VRDqe/9QyhfY1pgM9CLTVA9Kl8DsyCGQ8jyYV6cCP1V44d3dRtdrL
	9Z0=
X-Received: by 2002:a05:6a00:4b02:b0:87c:b126:8e4d with SMTP id d2e1a72fcca58-897c3ef9479mr17932674b3a.3.1792116202621;
        Thu, 15 Oct 2026 19:03:22 -0700 (PDT)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f580173efsm343863b3a.50.2026.10.15.19.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 19:03:21 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 02:03:21 +0000
Message-Id: <DM5W696SHG8H.2O783XL6H1PG2@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, "Puranjay Mohan" <puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v4 0/8] bpf: Fix arena memory incoherence
In-Reply-To: <20261014233442.8392-1-emil@etsalapatis.com>
References: <20261014233442.8392-1-emil@etsalapatis.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Oct 14, 2026 at 11:34 PM Emil Tsalapatis <emil@etsalapatis.com> wrote:
> Address the problem by more finely tracking the state of each address.
> Expand the range tree used for address state tracking with a third
> state, used to denote whether an address range is unavailable, either
> because it is being freed or because it is being populated by a VM
> fault. Use this extra state in the arena page freeing/fault logic
> to ensure that operations on a single address properly serialize.

In v3 I asked to keep the range allocated until flush_tlb_kernel_range()
and zap_pages() are done instead of adding the 3rd state.
You replied that arena_vm_fault() would need a marker similar to
the 3rd state to skip such range:
https://lore.kernel.org/bpf/CABFh=a7z3pdJy6LW+Kc3sQ+chp7iun8t3x+XH2OmuSKNFN6icg@mail.gmail.com/
It doesn't. The range tree has it already.
When vmalloc_to_page() is NULL and is_range_tree_set(pgoff, 1) fails
the page is either reserved or being freed.
Return the same error as for scratch_page few lines above.
The free path does range_tree_clear() and clears ptes under the lock,
then flush, zap, and range_tree_set() at the end.
range_tree_clear() allocates only when the range sits in the middle of
a free range, so nothing is allocated before the pages are unmapped.

Disabling bpf_arena_alloc/free_pages() without BPF_F_SEGV_ON_FAULT
is not an option. Nothing in selftests, libarena or tools/sched_ext
sets that flag.

[...]
> - Add per-arena anonymous mappings and associate pages with them
> - Return VM_FAULT_LOCKED and let generic MM install user PTEs; wait
>   for locked fault pages before TLB flushing and zapping (Alexei).
> - Add mutual exclusion between arena free and fault operations to
>   prevent incoherency.

v3 was +851 lines. v4 is +1013.
On top of the 3rd state there are span flags, opref with a wait queue,
an inode per arena, page->mapping and a new bpf_map_ops callback.
These are two ordering bugs. See replies to patches 1, 2, 6, 7.

pw-bot: cr

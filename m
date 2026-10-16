Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCBD37F33B
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 19:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792178281; cv=none; b=QX4QS3Yp0XpuFL8dubrUFX1Dv6sHWwJDBu3dKAbfT/zRPJcLEBGoaLhgRCxslOXO1RoIR8Q/m9iQHqWUOB4HXUNOgmaMcJIxk9MXV72L2M2JRCRGHVli+y/JRxDnXZjzIZgzyxafOqhltNVaiImkGgy15BHddT6Sp1QxcmPeRXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792178281; c=relaxed/simple;
	bh=kj6iazxl2pEmTduChN9pCz61Cw7fdC1TKLeAVjzB60E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hm54j25YGjRXXdhlgcoAUaBJep2Ot4heLi6crFtNccCTkoIK6wuL55uNYzwie7J6c4PBkaiRjGkXYufsopcsLyO3oREFwkOzP3wIcmJ8ySIgmFnLNzsPF+kZn5UI9kxg+Y8KnAKIrt0/ozAkwK7mNeEVwAqFCtPDRRhhsPOroDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=VmaJOqTt; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="VmaJOqTt"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-878b44611ffso200197b3a.3
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 12:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792178279; x=1792783079; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RVj03Ehys4DFDEAuhhoNP6gBmlrE5KOErmc+6xJMi0o=;
        b=VmaJOqTtcpQ3Kz86vuDc4eP8QkIGt3EPxL0daE0vgEaHMoP7DKJF8CntePJCZgsTwv
         OlxOVjUFYYoKfaFO9bQq69suC6ItGkdP++DN5BL3cILKVl8aBqe/VzEK6Ahhv54a3/UY
         a6wci5mGob+LFYEfFPBxSJLC+9FEB+DYtLljvLlDqNG79rO8PjLJxKglfNZLS2ZZzYLb
         OOcup9QnO3rcuQfWXgjx3ngPM2k/KFA8FCS2OLMVecZLSVXC5LMGPLKQ7b+c2FisMw4Z
         JssD+fIHh3pB+QZ92XLgQoY+68EGwp+6oS7JFJWUgeSFZApZ8lUjv3uGmzv5V9dWleB6
         Wvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792178279; x=1792783079;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RVj03Ehys4DFDEAuhhoNP6gBmlrE5KOErmc+6xJMi0o=;
        b=uWRBRuCNbFNrNZv/FyRP0VEwCs3V87jxnhNU4ftw7jDSRfisbIKHaEVkdqJagup1W2
         79vkdgGWrzI8keb/wI9F8oIy06BKV9iOQeXXKe9gzqQc7IoR5Yzpi73C5rnU7glqHgCS
         c3ILKoFiUwMWAwSYgZ+fovvqS2TmhKX0YIZXarqTYR9J/a7OmzFAGbJwWh3mZjfU+bqC
         FB2Nu4imIsi7W6f3+2htHNBmWn9V3YOUm2ATToEBpG5SHKsnvuOz1IULe7A9vlWzcy4q
         0RCHSkVr7UDn7hv7PgNRnDQuJ/u3HiNHp7jEKPyyd2dVSyFs1C0yn5dLZX7p4hl6m9Q1
         cUtQ==
X-Forwarded-Encrypted: i=1; AKwUvBwKRcbxWIe3pBeJSOA78SRHpQIUpQimPE2ARQO6TNJRTIMCneFL1y+sxCHKUdoWWAeMq1Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYILDEZXEjLBfJZN2yzIyPt2Cs1So9LiBr/BLJ2pMFny4T0vf1s5
	j2ke1rAWvgEEhnlOi/sjIxLGCGlV0Q25F3kcoLv+FJxFNRGmhb25JV21cCMiqNtYNQ8=
X-Gm-Gg: AYBFou1DLPmS8A5c9O9sgTZtGQj4UO2nCecLlcDs5jzv3ZrMrRw27ie48PCABZBbFwt
	KmDgTtK5HpBAJq4pT7yvoYFb26jmvzt9ZfVQI0N6ci4iAwZ+QxmO7EEyOeSuC31MO9Jl2/aId3Q
	XYnl4MwJim6+tRxwcsFCa8Zk6u5AwH4PaT2RIdpmnLSi+m2cvEy+VjzTx7ty6nMrDuJcgAT+K67
	6ZccZv9Qix7EEP/22F49wQqZozBsZoOjmnoSy0FSNfyNCLfxl2mxpN/mrVS5dSs10RWntDPQ6aV
	ACmkctOpijDJebqy/hLd3FbsOX6SMmhEZBWMgakbBb/jasGZvxBD3cebz8Qdxh0gZjZ5d3Bn3bA
	ERUsTOvgeG5TeBItftviMus7b0JxKeoo0G0I7AHgpjD7uJEmpQZJKDKVGbNlV09iCkqVp7VyrXx
	b84K/sMpiRvCxtiraNk8oJ3IhD5GQHplAc9wZdhrvl31YmSNazGf5tfjUGFVYLFgFB25XLBr/cU
	sUjnpFSS5XwwGsgwxJ6KX+9uofb
X-Received: by 2002:a05:6a00:2386:b0:89d:eb23:4e83 with SMTP id d2e1a72fcca58-8a04bc2f0e4mr488410b3a.30.1792178278972;
        Fri, 16 Oct 2026 12:17:58 -0700 (PDT)
Received: from localhost (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f54b3199dsm1666297b3a.3.2026.10.16.12.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 12:17:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 19:17:57 +0000
Message-Id: <DM6I6ERQ4DJA.25JXLLIZJ75E9@etsalapatis.com>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v4 2/8] bpf: Associate arena pages with their
 mapping
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20261014233442.8392-1-emil@etsalapatis.com>
 <20261014233442.8392-3-emil@etsalapatis.com>
 <DM5W5RGVPBAW.2F70WVQ24HT6W@gmail.com>
In-Reply-To: <DM5W5RGVPBAW.2F70WVQ24HT6W@gmail.com>

On Fri Oct 16, 2026 at 2:02 AM UTC, Alexei Starovoitov wrote:
> On Wed, Oct 14, 2026 at 11:34 PM Emil Tsalapatis <emil@etsalapatis.com> w=
rote:
>> Associate arena backing pages with the arena's private mapping and set
>> their page offsets. This allows the fault handler to delegate user PTE
>> installation to generic MM code, which is itself useful for avoiding
>> races with kfunc-related arena operations.
>
> arena_vm_fault() returns vmf->page and finish_fault() installs the pte
> today. That doesn't need page->mapping. VM_FAULT_LOCKED doesn't either.
> tcmu_vma_fault() returns it for alloc_page()-ed pages.
> mm folks were removing page->mapping and index from drivers. See
> commit 6cdef2ddce2b ("fb_defio: do not use deprecated page->mapping, inde=
x fields").
>
> [...]
>> +/* Arena pages are not page-cache entries and must not be evicted by MM=
. */
>> +static bool arena_release_folio(struct folio *folio, gfp_t gfp)
>> +{
>> +	return false;
>> +}
>
> The only place that looks at folio->mapping because of VM_FAULT_LOCKED
> is PageHWPoison() branch in __do_fault().
> If that's the reason for this patch then check PageHWPoison() in
> arena_vm_fault() and return VM_FAULT_HWPOISON.
> Drop this patch.


Agreed on dropping it, but the check in arena_vm_fault() does not close
the hole. memory_failure() sets PG_hwpoison before it takes the folio
lock, so the page can become poisoned after arena_vm_fault() checks it
and before __do_fault() does. __do_fault() then sees VM_FAULT_LOCKED on
a poisoned page. If another process that maps the arena already has the
page mapped, it calls unmap_mapping_folio(), which takes i_mmap_rwsem
of a NULL mapping.

The next version doesn't return VM_FAULT_LOCKED. arena_vm_fault()
locks the page, rechecks vmalloc_to_page() under arena->spinlock, and
installs the pte itself with finish_fault() before it unlocks the page.
It checks for poison before finish_fault() and again after it, zapping
the new pte if the page got poisoned in between. It returns
VM_FAULT_NOPAGE, so __do_fault() never reaches its poison branch, and no
page->mapping is needed. As you suggested, the free waits for the page
lock before zap_pages().

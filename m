Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793130776;
	b=J+hCnM6bLHUhZkjdCPifZKpoiCQieYYV7QTeSVLW58Cc62VB9rxYr/a07Y6/mzgs9hJH
	 6VEJYtlziuaxd6YnSHiWz8nuyYlfKZzjZeeOtyca9eAbAwqy5uRGWggMGGf4ds7JOvZFF
	 0LP0n6OpxL5Vr9D0XmrNtT2GGDljpD84yTB2IHHzWPg30nfqGlNtOi6LQMoofpAjo/Si7
	 qgpEdaG6rpNvfTiZdTE9OPyhRba6MTNcqGtq47L5I498P7l00TMr+InN19brek1LePGbP
	 0HXmtEtBzj/druj2xCKmmNkEHKVv3Syr77K3eTQsA7PiVQO0hFb4EAVFlJIadsuiv6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793130776;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=heWDW7R1UKid7wqseIgUF+53ZHZd0L+s/OvDuhibSi0=;
	b=ICTXudP7efmD0lcRYOw9KomHVcuU5YUkMfajFtAy31+2Xh8n0NAMpDEc+rKfQzvBrIsM
	 RwgxDCgvtXGX9wUNzNoSqep84Fq5zdVzi5EujQj687FWupAJEcCCysbQM/9UMhFdYbpCC
	 1z7pJ+/BU+Kc/D3skUjVy8S3/TWz/4uo3Fd5uiBay98/eaQUIyE5iejie7PlFZ/58Nstw
	 VNWEB3eedo0/fzRkrxPRH6+WU+BefEKWLeADkKPOrZPs/oVCkHM6Y9hbzAOCUyVFkTJ32
	 cQdv8z6aQN+5QvQv3TH0fdWARRTJ28NlB+cCe9NU5tRhQ9KGGg8mLSoQRigGjbCEiSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mpvj4cDN;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7107606A31D
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7107606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mpvj4cDN
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e940d5d2beso699845ad.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 12:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793130775; x=1793735575; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=heWDW7R1UKid7wqseIgUF+53ZHZd0L+s/OvDuhibSi0=;
        b=Mpvj4cDNdOsHqrBntd5rUKOZP9hRUm1gRaPCcTdBzzE3NpQaou1Mcm+fTXBw6DhL+X
         QtT5Szzt3HiMhtuRCn//Tfz26Ikp6AeSZElaQQSPapIR6vrEJjIL3CuahEtpGdOonbF5
         Da8M+WYk6nAC9QXKRb8UFAn4C+hone5LV7bTlzDFBvDTIPeIr7moWZITTvk5Le/w0eFb
         C1BZjmg2UNgN+sBCuvOZtEmP9mL+oXW9G0KIQ7VSBGfmCZ35TZhx60K1pBAi+WbEcDRg
         wjaQXUEObAcZy57mgcU5luHlhifQh6ZAN/Ne6qWm/vWLDPdHgWmZwlUi9hhtLEqxAezF
         KOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793130775; x=1793735575;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=heWDW7R1UKid7wqseIgUF+53ZHZd0L+s/OvDuhibSi0=;
        b=poc1objAwrqsQa0E1mnJ0QYBbdgqqCeFejU4kYpkLZh+UG3MMrCfJSFf/dL8MidtCk
         WFUWdsD7YjAUTQO4KGnrbZUQUsF57p6XJ62Q8X0Hxf5GPJcnnSOQrcDrkhAyt6FppScE
         j2dfg3forsP2ghuYRXI+pIV2k2+IY93aa+XBwR5VoPRhutCLw2RyTaVEi0zIxniFDQtU
         5NHSP1fE0n83A51ZWwdENMhr7C5MmBpDCaY5867BgrpIA6T/Bi7tfQKPMY3nEtmRdwsF
         3MPCQ+grJ4p+drg9Ktu9JiZZkGsL2l96PX290MH/KLDzGuj3UoM3J8A2ksgMd6Orec47
         Ssrw==
X-Forwarded-Encrypted: i=1; AKwUvBxGQK7hHBjzhNMVZSY2eMcdgBwojzr1Td8CQV+R935WVLRHHd+xbPK0q6MTUliYnnqe4m0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLDpqSwt7UkrZL4pmOt+egVlz9CSAJjmPv4XE7CkApYwxcKkYlv
	LpQLa/6/iFM3TN8uEsuk0lVlnzUaW3mYZhrQLbsLmO69NU9gRhlRbJWH
X-Gm-Gg: AYBFou0Ew/tY1exhfmX+QuF5/eY4faqowXjqa4DNlUJNyG5GYG7yHfgKStZ0WuotSOi
	bAwIEwAOmywCD6Nw+gjwxEksO3ejtzb/CE6ax9wkfz+se4XJbpTEbyQpO25bRU/NqAqjrboAzRI
	yN2rxetP+6H/wkoo+OceE/Nz5jfSDczY59OTa+9F+LUpQ4wPEoAmSiSCunQ62WfAA5VYr7YGhxl
	GmExCnTFHP6dsHh+/P1Exc1DHJtkUzH5MxNaEhTqzMV0e0mf2J2bvbDOtWVSeNR8PIL1xJStcHD
	wTiCUTilxAmd3+RNozBs4E2/YpivbytQ2daNR34T+rPokBZUkYA0XZg+sS83/17J/rl5URaP6tI
	syakBILc0b5k3/rFohildNiMbysn93Mw4qS2qsWfn9w6R1wAuuSZncaH1aMkJphi2qZeHNySGbh
	rQU+3TzvSKo6Wj/PklZF6PmtaWK7+aJrmhSGfEELCyXD+50P14LA5DJxVYjXX25+LtGUihpAAKZ
	trnZQz+ZevI7TXbkofzhSXDHuvKo5spjSZq9H/VPS0nGADjg5IC1KQhqfxR4XfHGCK7Ew+MBAw5
	3I9k7uXFKOkMuhVHJUIfNcT0Nn8CnMsLWHYOTbZ4cO9uvscr6rb+3Ez0yzDV
X-Received: by 2002:a17:903:2c06:b0:2e9:5507:b545 with SMTP id d9443c01a7336-2eb0054f510mr2827555ad.59.1793130774980;
        Tue, 27 Oct 2026 12:52:54 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6bdf3a0sm14141965ad.33.2026.10.27.12.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 12:52:54 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Oct 2026 19:52:54 +0000
Message-Id: <DMFVT5P2IT5V.3U8JXPSPQR8CG@gmail.com>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v3 6/7] selftests/bpf: libarena: Add a transfer
 cache
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
In-Reply-To: <20261023002056.6647-7-emil@etsalapatis.com>
References: <20261023002056.6647-1-emil@etsalapatis.com> <20261023002056.6647-7-emil@etsalapatis.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, Oct 22, 2026 at 05:20 PM Emil Tsalapatis <emil@etsalapatis.com> wrote:
> When the array is full or its lock is busy, spill the local batch to the
> buddy allocator with buddy_free_bulk(), so the next frees fit in the
> local cache instead of each taking the transfer and buddy locks. NMI

My earlier feedback must have been lost:
Pls add the buddy_free_bulk() spill in patch 5, next to the batched
refill. Keep only the transfer array in this patch, on top of it.
As posted buddy_cache_spill() arrives here with both branches. Until this
patch a free into a full cache takes the buddy lock for every object.

Also your libarena compatibility fixups series changes the same lines of
buddy.h, it seems. I suspect you want them to go first and rebase this one.

pw-bot: cr

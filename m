Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EFD1B4224
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776178099; cv=none; b=RZDpDT9WOtGJEJLllPCgbpxOKl8DL1PBemiMlciArCO/b+8NJLX+roNSNCCpKz2J50vbCasMpdhwBkh1i9c48h2dZpA2KZm4fml9yH3JiELEA0RIANnIbIUyNpDmexL+nulIj5pJTLnGxHpFdg5ZgZMtDq/4bN0ToEjkDA7gYJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776178099; c=relaxed/simple;
	bh=+HuZaVweJXgTyzQ6erpXIoY9txv2iB96rPKNVFlaNJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAHrKMQW9LI46ZrgvOQ1wGbjynHqIi5xYi8d9RlHauup1UNcp6HwwDUGHgcrkwNQaWLDlaaAuZIOFaFailsVROgbUk8RjZfgJF7K+y3XkRJtulHmnHypiCEuvi9CoQio3hydJR0kEYkkeM07CNSFYjsJoiec7O8kEu3JL+BhTxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=id8E5AfT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="id8E5AfT"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4887ca8e529so37665775e9.0
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 07:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776178096; x=1776782896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qs3FTaDVrhGRqFvZSZtkN7YawmSROR8+0cRgAi/+3fA=;
        b=id8E5AfTFD7k4N+ZFNSxnzr6knH8KRm1miE5Yx9HkvzNETF5lns+6fUfNYjiom8N70
         2JTSdG3qoh1EhNH8QvcQkFeQygpKyq3uGn/+rUiZ8qxM4yi2Yf0eJza4+EUCczPQSRqO
         t6Iw4gW63kw3Xbj9Hr4xrx28rUbICqxqpaJ/m3Y/aV0U+nlzuHvJO43PfNwRhK2bNWf6
         U7o18Z0X3Db054JBiAJJsH/PeJpOv2Y2WvcglvS1YTNiYZFj7DsL/LwSgtt3OItsXTvo
         PuYfoBXFdPHOd4EzQ7GbTfNCm1Q5wBfeKn2y+xeTxx8JuvtBPK9rEz64GclwKnx3LszY
         f/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776178096; x=1776782896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qs3FTaDVrhGRqFvZSZtkN7YawmSROR8+0cRgAi/+3fA=;
        b=X5eydDccXk1mPkYhhCqxInwgrEX3xXU4X0Jg3dJrXIM6Amw9KtBEXLEeR7UQxKg6kn
         TSQBNOsB7AOgtOxvFf7ceGvDmrYU4ptFJJa6wytq8czMxgYRPI3B4Kd02vL7lkQduoDP
         fxYJNZsGxMEQCeAdDYd+sAAs+eYnB5cFNj4xRFwDVTQEix5z/jYm6Kr1ka0uiGtUBrNw
         0PDmtGS2jNXG2fIcsO4fS8hW5MNVNfFuQ5yu9FFKN8d/vbrRh1ihJQdWu7385iimB8uV
         jhvnrMEnSkW1XKKbzeMbug2+CVwg7sjPqZt7miayh/NgYcAIp4502h2C5vpmLEyh8WBv
         YBDQ==
X-Gm-Message-State: AOJu0Yx1VjxNMdy4v4/z+qUPgk77KbR7cE6kruoN5h4F9BOhT4t7/iEu
	zbymTc2EVuy6uDITkm+xRpCnW4we3sgwkMN5nv0BSxtoM+FAqHqI7kT6
X-Gm-Gg: AeBDiesbKy/MYdBkYBgv/bHibgu1oEp0L/F4t/BNFSu+dlu9sbKc7pimHu7BnBmWcNy
	6OPxy2GCYn0jPTGM56PqkLkRwbKNTKbHGgyyy5e8doEYBNX8lTTjkBwqlriIa6xsNzhLlykGkxT
	GONqb5FX1Bl/MEVdEi3UIfiwCwRrrHpAvEGCwiOrtVek7UCwcBE3MXKPU47CcjJeYZ1O+kGc0Iz
	4MnjhvXCdD7OlhC3/rdzCiszmTTGEe5ZV9nYsCYzi9ycEhXHPoBcq62R4F2A9A2rqQuNgsAhW/h
	xJRcnA6FCtaO1MNrGikh7Y3R8jPx9PYI+dCq/LK605lg4aixLtggHXQpJSO5En3i7JV4S6kv2Z5
	AetbIPXHcrIz9hLfHZ3NHCBluftB1MIgOxNQmbNlXF3qh1MkG0Y34PF6COD48Lv/H3tp7IHSVj+
	VPftPFBWq9u70xOdyJFjj9VBOSnAKaXtQ0zynpWR8MrnAUWwPtt+wNCmOuYXbEODHwtlQpze5zK
	CpPlrzJHfWD16opLFJZWBWJvW6o+gHfGxfS5jGWsO+s6ub2SzLo2U3v6qlQeRMV020daD4I+fcg
	jop+kGVdryztPAtznzRb0cpj1JFjRUqa2IEIl0jE2FYemMzsV5p/iQ==
X-Received: by 2002:a05:600c:19cd:b0:488:c239:d498 with SMTP id 5b1f17b1804b1-488d68712d5mr246717425e9.8.1776178096002;
        Tue, 14 Apr 2026 07:48:16 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e002e3feaf8ac5b1b0d.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:2e3f:eaf8:ac5b:1b0d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d768afsm183992125e9.2.2026.04.14.07.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 07:48:13 -0700 (PDT)
Date: Tue, 14 Apr 2026 16:48:12 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>,
	Xi Wang <xi.wang@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] bpf, riscv: Remove redundant
 bpf_flush_icache() after pack allocator finalize
Message-ID: <ad5TrE-wIiw4rHvg@mail.gmail.com>
References: <20260413191111.3426023-1-puranjay@kernel.org>
 <20260413191111.3426023-3-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413191111.3426023-3-puranjay@kernel.org>

On Mon, Apr 13, 2026 at 12:11:09PM -0700, Puranjay Mohan wrote:
> bpf_flush_icache() calls flush_icache_range() to clean the data cache
> and invalidate the instruction cache for the JITed code region. However,
> since commit 48a8f78c50bd ("bpf, riscv: use prog pack allocator in the
> BPF JIT"), this flush is redundant.
> 
> bpf_jit_binary_pack_finalize() copies the JITed instructions to the ROX
> region via bpf_arch_text_copy() -> patch_text_nosync(), and
> patch_text_nosync() already calls flush_icache_range() on the written
> range. The subsequent bpf_flush_icache() repeats the same cache
> maintenance on an overlapping range.
> 
> Remove the redundant bpf_flush_icache() call and its now-unused
> definition.
> 
> Fixes: 48a8f78c50bd ("bpf, riscv: use prog pack allocator in the BPF JIT")
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Tested-by: Paul Chaignon <paul.chaignon@gmail.com>

[...]


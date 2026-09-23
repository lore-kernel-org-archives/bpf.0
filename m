Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C92A296BA9
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 23:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790205156; cv=none; b=iZ56EwRIAOWP3t4DxcmlnRb/5yHkWSTtGEyPPTu9GcfJLvr9ogNkBR4+rYhqcJqLpWlNumojmkjl1JD3YAkUh2KWwaHgw3f3vaH3mRi///RzA0fIXqhYOYM+BEy1OXqwrdikK6exqn2e6MBRLawvJrXER+wp6y1J8Wm/clFtVA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790205156; c=relaxed/simple;
	bh=BqS+cOqcHOYBiE2LSIpObwiVa9whezFeRc9j5NUjGPU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=UCb997j86xDn6ESr7z+knqY6ENtHs5DOOUMs42pPrLduBXOhlBmfiJNKwV/VOZP8pY4QhWgugIhkeAUF/LvBACCLEju4Y/Tt86kElvIMN0UIg9dy1QSCir7AGEonGUUs+IYsoNH1kJLIRvFjTzdmZ1p+BPbvpVZLdSUGoqP42HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5zr2oWw; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5zr2oWw"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2d747ec6188so7116795ad.3
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 16:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790205155; x=1790809955; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BqS+cOqcHOYBiE2LSIpObwiVa9whezFeRc9j5NUjGPU=;
        b=k5zr2oWwBV/9+gSMFq7P+DQVtNIzW8bC8LrVHr1rV4lsja+KXQ2lILBvH+79x+cKBK
         VIQ/96zOZWLzAQH2zlnb+mk66k2Mn3k20Pu08T4CM7VXomhQjRPBj753qfP9XNNNNud4
         GGTf8XgSXn86lKRqSCmhH66FBFA+SimkfxuoRYrH0/X7Shq018Jex7iVefzoIDJj3AgJ
         4fyOQ+XCoS/uahc645KvTwc6iSUPTVKdIEvxJGb5HgIPd57oZ9olugbWsnjl+Msf6h6H
         Vd2Zl2dZ4fWw0/zUi+9DGlamvKy7YlHCT91Euwn4lmxnLJVTibJ3zk86Q2Ef1Et47tHB
         hL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790205155; x=1790809955;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BqS+cOqcHOYBiE2LSIpObwiVa9whezFeRc9j5NUjGPU=;
        b=XUsBiT255QVjndtbFA2RdXNR+Z/c5MO28P+y9aom0wC7NN6uOeYhBqDD5XwEuq6SWN
         kIagV845upzL5nbpNsnkvvDt6BrQjsA0/s7I4br/pLfLtp99fLclLEQ+98X7x5b9zI2t
         kM+Pi+8m8OMKkJm7XNwQc9DDBEjJ5zyj9KMYUIgZwPVjQwzT9b8PIGd2pF9yIWnsnMso
         a0DUl4B1uK1dCzqC0vHhrIfZ5UBEX98ZMC514zOgTeSNIvzWpzOX1LCUb4xB+IRhteLt
         6vFl0g+9KQ6ziXLSgIl/XrTsBd0X9QWChHmCAA/LWFQ6oyBlCVI05TUmCnxkQmUE7tq7
         O6iQ==
X-Forwarded-Encrypted: i=1; AKwUvBzeh+UsszuP1ISC/vz0v+L4V7ZHqbRpfF8DZ3/sr1L2gZtZOmjN9sgWO64hNB7+hNTrWxU=@vger.kernel.org
X-Gm-Message-State: AFuF++nAv4IedefMGPy8e8QFC+tQcNP3XiIUoMJWOibHSzlJEfCAkUmh
	5HdBh82duTDNSpCouhbMZZf5Y6oZRM11oGOe98zKtBW/Ldl+x+p1Xu54
X-Gm-Gg: AYBFou34jpePzZFBVshvFMD7kdfncB0yVhF9zkKrjnnEpHg51KJR9xiFVqYmEGK9iQF
	UIeLklmywCpRuxkvJBHU9mACPqYLTSERf1mEZzjU9NRy+klKf9YhYxhv/y1tbBX7xCFdWODg92/
	4eJ1vyfmJz38y4wjOw6BEHBy46a3VBXaHRMf+g1lQx/kL45yVfyERy70VvKQCug5F/MdgqyDHgG
	bAShEXsWOyqeGRyM5NC9t/+5XoWXnbaFA5bTLUKIpdk9sI516+WWqM3oqYCMfnufAQu+pPqSK/y
	IHlrhppjZx2mZr6P9SQ7peCFbDj3BwpfySULbnlJVXu9MEsZcNRAZ2K8YrQHNZkPAHeZxl/m0Jw
	a2zGFUJktX5ha32wdtj8hkYsZdtdZaHWGVFTTXw3jxo+h1ST72h/EiGVRL/DcCMWt+D+C7OUR2n
	viVppC2hOLKw7zJgO0Xx5bRvPMIxl4fMuHfyb8Zf6XHC1ps1ynIGLHpqrXzaV+jJlLe+/XDqexU
	VLoU32/1E7dscwbFV7vG817daDSooq/W1KezRwW+HUd+mOR77mCqdEt8SZj69VNBZG9aOFdP1HR
	Tm7v
X-Received: by 2002:a17:903:3bad:b0:2dd:c100:4257 with SMTP id d9443c01a7336-2df7e2630demr4737175ad.59.1790205154602;
        Wed, 23 Sep 2026 16:12:34 -0700 (PDT)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5db05dsm16945695ad.49.2026.09.23.16.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 16:12:34 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 23:12:33 +0000
Message-Id: <DLN2RI3FHMQP.2BQATI3U0ZFPU@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <memxor@gmail.com>,
 <a.s.protopopov@gmail.com>
Subject: Re: [PATCH bpf-next 03/17] bpf: Don't fold loads from insn_array
 maps into constants
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <c53e2a2ae43adef1e9ba3eb4dccfc032d9ce2f11.camel@gmail.com>
References: <20260922011323.1298619-1-alexei.starovoitov@gmail.com> <20260922011323.1298619-4-alexei.starovoitov@gmail.com> <c53e2a2ae43adef1e9ba3eb4dccfc032d9ce2f11.camel@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Sep 23, 2026 at 03:39 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>> verification. bpf_map_direct_read() returns zero, the register loaded
>> from the first two elements of a jump table becomes const 0 and
>> bpf_prune_dead_branches() may rewrite a conditional jump on it.
[...]
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> This one does deserve fixes tag, though.

Sorry that was confusion.

This check is already part of bpf_map_direct_read().
Will drop this patch.


Received: from mail-pj2-f34.google.com (mail-pj2-f34.google.com [74.125.227.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592863C2BB0
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 06:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790662189; cv=none; b=WuuN2bCud7ieVZkUP+Sh3myW2vaHsu3e5RM5HGkd6Jk4aU8xuqL6GRUtz0YzlbI2y0+zqTBs9lccOjqTlYf7m7uMEotPjzdcz4na9h7tNI7UZty5S71WXcTO9ll86CoB+UqIZW/4viGnmSY5UecUcltCHVmVBoyqnF6ouSUE2Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790662189; c=relaxed/simple;
	bh=kZWWt0EAbhwxvZLPqdZFstn76wKJyVJU2ugalDWAaRo=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=OsKP9/YspwLJu5OVvAidjs30GdzA33L+ltam1BP/HqwgvP1hANmZrQWppN/jd+iHFHynLMj6Xz09W0dVn60xwBwAXqBpkRwNwNoztbU/NbLnjShpoX2KwLpaKRl6xPmlvK3e9GuBr3jmbXFk2c55iQxcthigPZK+/crsJOlH7vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nq1EemL+; arc=none smtp.client-ip=74.125.227.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nq1EemL+"
Received: by mail-pj2-f34.google.com with SMTP id d9443c01a7336-2d747eb79f7so17092785ad.1
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 23:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790662187; x=1791266987; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kZWWt0EAbhwxvZLPqdZFstn76wKJyVJU2ugalDWAaRo=;
        b=nq1EemL+ii657ovvniP7Iy68oWbN7pZB3bCGtzJ0RcttWCb2s5VcBCir8ZGzV4SldT
         q0KYZET16lnI0SWrIENK1zk4kVMOLt4iNvFksEc6wOGQ0jb4mf67SCQqvccXWbdL/bxU
         mSuXc2QRPiGrtNFPoybj1uHUCOS4c+STT9GWA5m1vlNNEzmDrnfBQ5NDcuXdcHBK+qri
         lYcAYyYPdYNOyWr30i7ghwYgeoHOPTaaDqLUFEtv//reuaMtnpAUREanshTVZBqLgeJD
         LWgYIvS/BE0iG80HC7YEXk4gBwOETCasDcIM1L2vRwJSEnZzApMFXOLG0vyKxSu0RksA
         myoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790662187; x=1791266987;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kZWWt0EAbhwxvZLPqdZFstn76wKJyVJU2ugalDWAaRo=;
        b=nBIoNJ1CQt6Bc9XofziOujdXtH0pa5DFJvR12pw211AwGmRV0BtPm0OpZ/AD2F96/b
         OWyJDgmDvvaunZZ5z56OJsahukAumkuQOJhLtvxg07zKL18hVfnR9s8PwVhmfLsZd4j5
         jKpLHrTTOp5dZPzd3VY1/0sf1ZlzXEMJbONsE8rpMaE7mITbZmTywVb/EWKySY+Mmgmd
         WWm/ozrPAGa39dXwnXoro8TvWdjc8309DnTnTPpGoo7YLKfXwhvqRvl8TJ+j8Q82Wx6e
         Q0AFHGEFKHc5BTI0mQYBguynqFEVM/CySpf5peXJ2+S4h/Z5/m5vU4EKJ2a0rz6BUEDo
         rkDw==
X-Forwarded-Encrypted: i=1; AKwUvBybsWB/Dn6eSkZHI5EsIHkhPk17zM1sFOl3s9K/sEttn03CvPnQq7l/ZMQneUgL4LN96Oc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKQc/BwHxOFvCY/W8jdGf+CcH2Qa9z8F+uzvTjvu6yeUrH7aB7p
	uN3pIDohjYqQxbjUkdfPydenb0tVGVJlMgGQMasWCHMCtVl65Vfe2HEs
X-Gm-Gg: AYBFou0Vwt7BUt+bddhdWHLQU5R0wj+oqE9ewsDuMge/Z9hD4ooMCllQ388+rBavXzr
	mgrUFBA9PW1UVkD0glJrW5f8GAaypWM8IAVZcmVu9VHnhJnZw7bR3BlKevgODbtZ+nnHcp4o+8s
	xFMLBvyA4zSt9ZQLn0StT/vUdarP//uepUwX9qC1p1sCOYAx5/t8cf4VJhioZHaO/kzMu0nDnh2
	QBUefSENdIrAklbc54G55Bo0/NodpgEFYdtQ64dzFbGUO5rncMSrxWhcGdb7tVJe6K1tG+2/o6B
	bLusVrb/HctR6+pvzQh1DnE5tDygMxNLBBTztV8WMpMpM3wxVRiLIjIRVYLuS6yKY0P30/UDxhK
	B+r8KnAQ03RPrCh5z4+kOiwDEr/wc25p/bEiqs7laFEFX06JdJx+8EjRHqRuhghIDGa+yPcnGO2
	66VZrtGVpZKT6YJFLtMHISUQPDDJ0lhbBtbQ9CY+A+2/nYM1d7fYPewUXNkWoN795E/kZX5kQOI
	HPOh2Ao5IXcJeF/B1MJoLI+8reT2/YA1J9Lk0T29Y7qDJrdj1fNPYzIIQtD6Iwxt0ATP4OtIHQb
	mIc=
X-Received: by 2002:a17:903:2f50:b0:2dd:c0ff:e72a with SMTP id d9443c01a7336-2df7dff64ffmr113965515ad.60.1790662187466;
        Mon, 28 Sep 2026 23:09:47 -0700 (PDT)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df9142b00dsm50889685ad.49.2026.09.28.23.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 23:09:45 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Sep 2026 06:09:44 +0000
Message-Id: <DLRKRNCH0N6U.2CRAUPOWA8P2D@gmail.com>
Cc: <john.fastabend@gmail.com>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
 <ihor.solodrai@linux.dev>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>,
 <syzbot+fd7e415d891073b83e1f@syzkaller.appspotmail.com>
Subject: Re: [PATCH bpf] bpf: Fix smp_processor_id() warning in
 rhtab_delete_elem()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: =?utf-8?q?=C3=96mer_Mete_Kaya?= <omermetekaya0@gmail.com>,
 <daniel@iogearbox.net>
In-Reply-To: <20260928173703.504474-1-omermetekaya0@gmail.com>
References: <20260928173703.504474-1-omermetekaya0@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, Sep 28, 2026 at 08:31 PM Ömer Mete Kaya <omermetekaya0@gmail.com> wrote:
> bpf_mem_cache_free_rcu() uses this_cpu_ptr() which requires preemption
> to be disabled. In rhtab_delete_elem(), this call happens after
> bpf_enable_instrumentation(), so preemption is re-enabled at that
> point and this_cpu_ptr() triggers:

bpf_disable_instrumentation() doesn't disable preemption.
It's migrate_disable() plus bpf_prog_active++.

bpf_mem_alloc relies on the callers to disable migration.
See the comment above bpf_mem_alloc().
All callers of rhtab_delete_elem() do that except
__rhtab_map_lookup_and_delete_batch(). That's the bug.

bpf_disable_instrumentation() in rhtab_delete_elem() protects
the bucket lock from NMI progs. rhtab_map_update_elem() calls
bpf_mem_cache_alloc/free() outside of it too.
Don't stretch it. Disable migration in the batch.

> Fixes: 6905f8601298 ("bpf: Allow special fields in resizable hashtab")

Wrong tag. The batch came in
commit 818e00848227 ("bpf: Implement iteration ops for resizable hashtab")

pw-bot: cr

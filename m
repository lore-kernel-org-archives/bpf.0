Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C813218AAD
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 18:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769192272; cv=pass; b=YBpEL/VHTGY+jYbtd4qoE14Vw8eNee3k9XgrwCWiP1ty+OBq2UjtyU8gqzP0BoO+20f4JBCTjmtSjbWMdsF7g37chOvjWcT17DOVFNADwuKIpUFGVIENwWZP6JVQaLij3+enxMek5c+2Wgo9Dq8iMllCLjgJJrW9fB397vUXXg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769192272; c=relaxed/simple;
	bh=PcrhRkja2BNidi8ueSHFR+dtDd1JMWrricURFvQqo7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PV1lYC2L0HJtIg9IVW/Bo5Cap17YTYITAC8r84hayfMlg7XiMKhgMDXCbaXdYMIkrxTTBhQAv6gNiBsJ62jwLP1lt7oneX7oP6U5+rzlX5peU8i1tebRc8UCpmAvNdrJaA2QCTgdZEMJBhA1kp9pcUN1PdQp5OJYOlTKW65ei2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZcBe2Ko; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZcBe2Ko"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47ee3da7447so19464025e9.0
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 10:17:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769192270; cv=none;
        d=google.com; s=arc-20240605;
        b=LD9foz1MxC8GhgmcN700/7bOsmgv5IWpltwnYU7ePBgFGXHDqEZq7SoEnDQJCtOB+3
         9DzRm7ksGkcOzWklZZTeqBA6SmyGTE32uaC52P6voqqXMMBPR70/bOUiu0Uq8OIjj77L
         uImF35zYVtNsgZaXuIx1PL3sPehZRz9oxuBbhNlmwVS8QxqN5N4TqqS0syBYZg/zGUDy
         LN2AAOXw80KLUWgaCysWNTpDtHdmyoImnSSxyOfXZspCBMMYGBGnR2zMHHejlVOXgShy
         RlSObdkkWXjgCSfBufZitv3xWTmglbXSu0eisO/AzFhm61MfAbnVQkFR5em74M8laWyY
         t3bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8Njop685CDtDYAHuiepzZeOimPgVGEih4T1bD9GMBYQ=;
        fh=qFJSlcA6HngzmOrSJRzJViZPHr3mJubA2xtZLhq8S48=;
        b=jG2aT+/+/zhzNH96OearlC4DerAdQ9ifkgniBWsCcW3bjQ1tIsSFyJ8Yb8n0Lfk40A
         PRlifEP/yJu9kDrvBzJP6BArkyRGmZeEWVBW1agS/mYan1VfA9byorR3EPbWPfb5E+hy
         ahKKyDvLqanrXVecLGAmLTFwhzCY2PmfuGSIOmd7JAB3zOr8/8DMo9fZnDoHQCeF0Z/Y
         6LbZYkin7SURkfrpcgis41dIR+3cg1/4MEtY0E+hgqXkM9gJ7XTCaXdntpaLipnKneXI
         IwlEiyH8vtJxfnQlMV1A5NgRS8kLmnt0PtMQrH7bqe+ju3+jb3HXvDypajotP3d5EfP0
         86nA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769192270; x=1769797070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Njop685CDtDYAHuiepzZeOimPgVGEih4T1bD9GMBYQ=;
        b=hZcBe2KoNFW3l2lhLFabx3ds2KVxJWU3o14AJ1hfV/JxY/Ke20SSVJUI+uJk+POfrD
         ptSD6tE84LDtMHBpFZEZdIVuFrmXlW2wYH6cI63AALqmdsRq0y+c5hXz2b8Zgc3PEJST
         8MvTAH3RYvVjts7gkicPDcZ0AUjKqS2BQ/Z6XW5f0Q83WebOte8EmXCwR1DADoPfUi7X
         pOeCpqEvDknfryb90TRBOyqe61EumDHE7RA8I6TDJgxqFvGiYj0OYcr2+920LUeaG1wJ
         lbUkxzxA4ej/9dSPsxL6mac/jiZTnh3WwN97RrUDsipjrwVBObflZxpTt4WpYjXf4Dt7
         Hp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769192270; x=1769797070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Njop685CDtDYAHuiepzZeOimPgVGEih4T1bD9GMBYQ=;
        b=md3K1Ih8LREDbHwBrae935rhItllJnpY0M7wJkl/lZOgixWg/r4HpxOCP2Q+fGzAoW
         NzFIp04tiVCyLhauw2TT2ke3hkuNUA8aVUK1YkCQErDJ+Cah7JhA6cwH2ta71PX7oDAX
         MFzSWWu7JJKDHlif2vhOhUh+43yWXxb3yItln3G2BsCg9uKnK6eL0Ud0VML0PnGOkNX6
         8rhy62SX84O8R7Ue3BYsf+z5jDxS7NUeS5dsGT+BTB/Le59s29ln/HLXjpQcQZE7+VsC
         fMnnxRHdQb40nW5ggP3RAXHF0pRrThHvBMTt5qf04BlWVuO9LOcny4aslVZ1yd/zspvt
         T35A==
X-Forwarded-Encrypted: i=1; AJvYcCVES53MrVA1tpRICe5dKUNlHIi/vJKYwRUV34bAC+Z5/pPGVx78hY/fMS5Z2LrvkpE8Gxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Bd3laTZO+R3aRXdLclbDEnI1zJTuSe8DwmupZpGB+ANlaEtv
	gUdYVEVJDg9NzAVlz1vE5V8+gSfytwtKx7jbW9IkRNB45ZCpGikhHBNa1ybQ+1Sng1tTro0zRDH
	zRKYhsI2EZvMI4xSz7DA7ijNuiZWriLI=
X-Gm-Gg: AZuq6aJIt1ngu4nyDBQFdC1su6LuVvVKE6LBOpV/WAvZWRIWulIejXDco6CNtUNPOqo
	NDBkCW925s+NRwSovp/VU8hR/toi2f2OrbZ4QIkmoQwpuH2Dee35TqL93c5tJ6gHRIj0bOwomsW
	awrsfG0VC5wOWBiqJT9jx5p3cKWvnElksxOUIndRU3ID3KX/75UhvtCVNDBqTKgdEhoOi7ZZ180
	kq9vXnSi1RQBAgzIQ9VGOOj2QaiV5EzXpXF4Oeoe9ZsiE8a2YR94BTla9huZbuYuwLpZUj4X3Fk
	P9g92eXBxYEisw2+mHQ+n3DuYEYMiorDgqHp+1jn56LjcJ5x+3K1f6pK/zETaUf3BX4Jx8gO
X-Received: by 2002:a05:6000:2dc8:b0:435:a83e:88e with SMTP id
 ffacd0b85a97d-435b1587c9bmr6392632f8f.2.1769192269543; Fri, 23 Jan 2026
 10:17:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz> <20260123-sheaves-for-all-v4-11-041323d506f7@suse.cz>
In-Reply-To: <20260123-sheaves-for-all-v4-11-041323d506f7@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Jan 2026 10:17:37 -0800
X-Gm-Features: AZwV_QhM-NYlnccFIjcj9RRt6cZ2UOQ2HcV0ateutcQQrobA-XAbfYILlKDwm8s
Message-ID: <CAADnVQKbuLD=gaC1W9gtXrj9VdwQCqt2f_rtYwF1Tc1RcUOjKg@mail.gmail.com>
Subject: Re: [PATCH v4 11/22] slab: remove cpu (partial) slabs usage from
 allocation paths
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT" <linux-rt-devel@lists.linux.dev>, bpf <bpf@vger.kernel.org>, 
	kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 10:54=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> We now rely on sheaves as the percpu caching layer and can refill them
> directly from partial or newly allocated slabs. Start removing the cpu
> (partial) slabs code, first from allocation paths.
>
> This means that any allocation not satisfied from percpu sheaves will
> end up in ___slab_alloc(), where we remove the usage of cpu (partial)
> slabs, so it will only perform get_partial() or new_slab(). In the
> latter case we reuse alloc_from_new_slab() (when we don't use
> the debug/tiny alloc_single_from_new_slab() variant).
>
> In get_partial_node() we used to return a slab for freezing as the cpu
> slab and to refill the partial slab. Now we only want to return a single
> object and leave the slab on the list (unless it became full). We can't
> simply reuse alloc_single_from_partial() as that assumes freeing uses
> free_to_partial_list(). Instead we need to use __slab_update_freelist()
> to work properly against a racing __slab_free().
>
> To reflect the new purpose of get_partial() functions, rename them to
> get_from_partial(), get_from_partial_node(), and get_from_any_partial().
>
> The rest of the changes is removing functions that no longer have any
> callers.
>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Reviewed-by: Hao Li <hao.li@linux.dev>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 628 +++++++++-----------------------------------------------=
------
>  1 file changed, 87 insertions(+), 541 deletions(-)

so much simpler. love the red diff.

Acked-by: Alexei Starovoitov <ast@kernel.org>

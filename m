Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAD03BA23D
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 09:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773914258; cv=pass; b=YQjhP+q5u4rc/gfggY92v3czyifujvzlsQtYQH2gYDnz4gmQ4AeKxYNScrtHXy9lfS6H00s9WNKWWWbyAexT6g1QE6wcN0dZpftwszgBJa5G51jbsFT34ydeyw+kELDQ/W/pUxeqPhR1Smmsy2smbZC/f1VE8SiXkigI2OtdWAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773914258; c=relaxed/simple;
	bh=xl7+y3922X8RzVulHc8ZasmnzQZR+Ehu897USVHefbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nk5pSZYU7CGXXkbctxvKKnxs0o5Z/TkztGnR7rLG+MVNak3/Q4/r7FfP5B0tBZL5OBJsJVuVTJmaHxXh1kIXEjRujuj/SFFO6MUXz3ejYFUQADW1A6k6x1ChewAEfetwUMTEPpC8Ksy3iyYz0fLDUBBM8VbyDneHjX5qxz0tahQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dc78GHR8; arc=pass smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dc78GHR8"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4853f2826f7so6906005e9.1
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 02:57:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773914252; cv=none;
        d=google.com; s=arc-20240605;
        b=Aa4yczdMAErQGtwd9OrRS+FMYmtjnnrQgQ2rKbG6klpDRjSspFezdjFTOwlQ/Hxq4T
         ANSA7ffmmdBbZm/dASCPFAvCig6PPwJJqYcb/g5zbKXKpb8aItBZS4XPpgOmimOZH1Yy
         EF9UMUqF/zHYQXNitZdsFNguLJIbEW8EWRK1Psu3aP9rrtiWjkv2t18Ama0tspCJ4Wbr
         vQd2VLDEYJ1I1rFMO0qFHXFpz2XyxOZeKp36tUFi0836AbGiHt86tuJg84yj4qXqSV9o
         ZTOuKXfql3KyfsAuxLxQUhtCbehmbrcHFnEHFd3Zi0v+EmVU+Tk7mCdHcXhbB++AS44j
         OC8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xl7+y3922X8RzVulHc8ZasmnzQZR+Ehu897USVHefbE=;
        fh=2TRrcgVb5Vf5+T+Zis9foCjsnuQcIZGHFH/KdsX9YcI=;
        b=Jje4SG4x/Ge8jyIL72Bfk9KyI7JDE0HDR7eq0bomT/8B7W9x9zIWpiWNN4Jejs4Ka3
         sxHJtYmm+7598lW1RRoZhk8Qf2Hr47vDFDN809ZDGrzvI4OvkveSkDgDWb0Ww97QkQgN
         5SNaJK822b9A5E2p7okpyAkBZAJWe2PXVCrU1GLluyE+wHI/LbFV6mDQcXbMn8BbxgvY
         amQXWZUPUD+kdP0UvAb35WGLzQY7mnykXZTyv0cupjNM0pIfStp26JgdEGN+PWc8PMPx
         33sABq5wbCOaSbqZS6ieGXGbPhGedekapKeN96PFE4UJObPDCRCkEfXw1AIwKMFOSQEi
         9jUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773914252; x=1774519052; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xl7+y3922X8RzVulHc8ZasmnzQZR+Ehu897USVHefbE=;
        b=dc78GHR8QqgZx9jlJA/g/djJDk6jvFVHVg3q9hQ/D2DEEFe/0YNTZ5Hc/7GJcbXEn2
         i0ja/l/Szy5Nrim4pPhatf1muGPvV37CWU6W5Y9AiDT8cOJPMCsJP+M3jndnwrXnbwW8
         4V65rOUeE3lro7Lt6vfMQMDXvdB7sRYmvaJpFVi4l/BiHA2+oFuF10qJvIi4usSc3Y9C
         kOCI1Hv/ps/g4O8nWKuYg/C97MftEck7l+DKJ/hNxvqmcOo2mOAjRUk20oYAF+3q49Bl
         UXqbUq08Ofoe2v4vjPdxmA1PBS38qOCNTnjg5XvvE/0KnzJ3MEVLC0dUmVvi7vmcnR9d
         nM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773914252; x=1774519052;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xl7+y3922X8RzVulHc8ZasmnzQZR+Ehu897USVHefbE=;
        b=SBqRwszqRGN/Ryo5NhCdg3u7iP/oVfNnhdRkcD/wW/u1IpU+/AlAiC0O1unofUyLPC
         mET04woZfMqBuIx7dxVPD5Rw7hj9D56iZxrLAthDoUHiGfUETfVhstwwLdcCdIEm4K0n
         tketNVyvrGOZzGil+anXwM1vzSQv7aM8f9goqGWRvty8zWE/PiGdx3kBbay3hZRBAelO
         1kHJechhoHit7p3KLf6y80LLcRLURlaBrc62B/Fw6XVq1CqAs9nzCk01HPfTN7SmxGB2
         6OpMEwL9K5aP0h5sWzm2qnAV8H01Z2LCXFkYStSRQ3xTUnksGzWxQPqZSN6a/U+bYFEM
         bIDw==
X-Gm-Message-State: AOJu0YwEskyjJlU6F/ixz87yk0xndAz/jG22mW3vscQAMRim9G3kPxHH
	GlsT5d5IPlaGQPHBRjDpX1IXo7VUCskH3M+YSxEbUOGGRf13+OZQPgrXrJAlXHdoDgs7qspwThc
	H+AzPXFcq5XyiO4hDac4G17g/sqUjbY8=
X-Gm-Gg: ATEYQzwAL6I2PMoxICoxqtW49aW6xn1OaN8kTnuWYbzdq5ndYOzIM/IMZPgcF5PX4aq
	QqTxtrj1ddDeakYinXBMXFdLtOut3bL3lX6umct+R6iwdANwZvd9kzASwzpYVtjeSBOBf3qOX5j
	NDMl9CQxfuQ7SDwTYRbVFJNteTp5rhN8pFzBJ084PAwVRxiPBig/4ei0JLXIkEhmIUkWSZ2rPCM
	DFB8vrB0tVYBRA4oDfEySHZc2syRu+HTf6dggURKvKi61zQCK3ZiBIdHzbDcduSWRcqeCqdkQte
	oMxzbA5SwU+5nJ+zuvBJ0h7qvloZkfzNjt7rDXlv0zbZf3Be1Mv1hmcZFGY=
X-Received: by 2002:a05:600c:8b65:b0:483:badb:618e with SMTP id
 5b1f17b1804b1-486f44377dcmr108267975e9.8.1773914251505; Thu, 19 Mar 2026
 02:57:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318174327.3151925-1-puranjay@kernel.org> <20260318174327.3151925-2-puranjay@kernel.org>
In-Reply-To: <20260318174327.3151925-2-puranjay@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 19 Mar 2026 10:56:54 +0100
X-Gm-Features: AaiRm50dnzYkBL9wzOf6bdlH4nDbSKFj9anh7ORsIyU3zSWbo4sFfLGlSpO_fzE
Message-ID: <CAP01T77-shr7gXHKZjc06KscdApo3o97r9aS6FU_h_SaRYnXwg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Consolidate sleepable checks in check_helper_call()
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Mar 2026 at 18:43, Puranjay Mohan <puranjay@kernel.org> wrote:
>
> check_helper_call() prints the error message for every
> env->cur_state->active* element when calling a sleepable helper.
> Consolidate all of them into a single print statement.
>
> The check for env->cur_state->active_locks was not part of the removed
> print statements and will not be triggered with the consolidated print
> as well because it is checked in do_check() before check_helper_call()
> is even reached.
>
> Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]

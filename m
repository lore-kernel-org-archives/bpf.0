Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793153728;
	b=2EvwS869qR0pem+jI/8DYI5QouOqsOS/lQqq0B7GaraZMpiASb7OSfp1XVdRjzvNz3un
	 MW2AAuA5PDFlek+uGHsr9B1gNpNahp3h5Pvcu0uLcH0tNa21zlvnJZAsn2KJMZlBjx1wZ
	 pbblumLJNCJmv6XgsNwFBJWH7bDzQV4h5KHAm48gjBbDA50i0WM86Y2oJinZZ57XQ2bCp
	 Kkkf62cqpz639N3bJzHk71phSnihBPLkXarA8aqm3Gsunyx6qM5a1SRK54XYS4GxqL/U9
	 bm1/tvYFynPC3iwEGPuKBUE/qzcMhMTsrzzZ+prbYWnYnVkCf0fS9eMQ5nuhqacNy4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793153728;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=zfiRKc6faNdhkDmzq4FLA4O/f5pTFuJ0W9YK5j1X3XU=;
	b=reZ1nIJAx3ZD4SdK1pzBedQAkWFR3d5Eem1djl2RM9b47e9kLAmcHqiVDKRiaHmUtt0g
	 38qA8LTLT7k34kVK4i0TJd3S0iT3ZzkSxVJCqeQ8Q5K7ILFgXuhdwPbLlkI3UDG71I5bu
	 OsWYl8wR1Mrq+SZl7xJ5++j+T3SNdBx7wgLENFVLsYiIGWc9lZE7fp9AAOiSOU+tGO3La
	 gr3Q+cNLRcstP6tJD4fwA8bW/nqSbFjmvMVfErY54VMGpWBOSR85ZQDAYiJXAa84A0vw7
	 1/u/C/bxcwfRrwICM/LeR/nk4LYUmeZ4cXnVG+A9m6mYahtGemDp+I5arZ7YPc7Wtew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XE1fVuMs;
	arc=none smtp.remote-ip=74.125.225.139
Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5611606A31D
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 02:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5611606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XE1fVuMs
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-4a5f76661b5so1767045e9.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793153726; x=1793758526; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zfiRKc6faNdhkDmzq4FLA4O/f5pTFuJ0W9YK5j1X3XU=;
        b=XE1fVuMsuhYDeI5N8CJnxGtCyslxKj19uDtBXLRB4+llW8DD9D05krrcHrVzfdJXwC
         6sy3jrI6PTXKWLNkuk+W3834f9iTmqsHG3iC7m/RR9uPKKl8Sm5G64xwaPi37clK/8iN
         3f7k1WXi4RZPlcOXUA9GT2Yw+ZzNQ+gDktbb2Bkr3EHOmtcdfTmJDoVqnMn/gbgsDeby
         zeahgyCuWazaVllLV0/QsNHxd7F3csxX6WpJuTNXSXQPIecwGVu2oPDorVhCFQxAuQQ+
         Q3DRUIDrQ/UYBZYHDh99AmSsMzAKaVUkAsmVaUu5ashPeR2iV0DWmZVXttYNndEE03tM
         ekEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793153726; x=1793758526;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zfiRKc6faNdhkDmzq4FLA4O/f5pTFuJ0W9YK5j1X3XU=;
        b=bodQL/VRN1qvI89M4XurothUL0cuy6YiAwt5FK6P1qWQ5UQTnqTvzuKN6E5zdsM62X
         7PuCh5y18zjhP+BAzP2DmBKbHApE4tBjPmIueJz9g6i6kwqfQZw7/xjqdYpVxQz9XpZa
         iHbOSEs3XYU3KmTiRnm56BPNpfmfUx1+hYoo7Hk75hiqyhA2+XifZH43X1SVcCUN2Xzx
         diggD6A+f7EaIkLWz1kxObFPFtvyOumWmLgLvp8xXIFiymkfF2sYnxEEk1y9GWZG3Lex
         S5/+F3qV7b4ZESb9KMyDeJYhnaM/u9tCuYkRGjtcoc3pLpYhvOFSKlnOWgfk8VuP8EoL
         fxwg==
X-Gm-Message-State: AFq9FYJaWFXpe7WPTOlZl1ISJRESUqbaE3kcj9gM7iSedpCIDTOd2lHF
	BmnUBfxC+RQIMutI/ZvXLpRv2FipcquQSfsGeVPjejq++O2IlysbdU9Y
X-Gm-Gg: AYBFou2WQ3k2LQ0ZUZ+smhy2YqlSxlF9jAqEKTQ/9lZ1ISWXWA4QgZrGCGX+woX19Q0
	AqXi3YPC6vnBxuwcVY+3T/mfgd2YtoWWGZDrDyAyEA5vygonAuaQl9iKSVXCDgB53VntCA7zw4F
	wptrlh47i0Q5BW8YwZpQwM1Ah7Jr+9JxgIvQlaAz+sqfpmnL07Q3VD0mMUauqngvSGJO5UmbeHn
	BB8duoTs6zfPlh2ZukPJuz2XWAbrOsIoGTDtnPEm5PGYlXw6nf1Wcf5h7qGiLNA8fsrShs3gygh
	GgCf/0/FmHlU7rAjJbFnWPf7Nt4R9h20va+0mZzYoLRqfV3aI+gXHuPoBLx2FlVYjWswITYveig
	K+qT57uH/twKc6qp7mza1NB9DQbZ1MRQuAmy6B8oIRt8WCFex+hVQ3OKoqOcUtW0RhJZKtg7d+W
	NaLNdi0IhVT+7x1NwQjJMNUmsTWsE87cNAlZsAz1t3BQy91SPf7tLnPFsuyju09DKXLVeyp3QC5
	9D2pS9VnkwQZNM9m7vmWLpspdigHZ3cHNY5jOJ+PhBGHJi4K7QdUSxHW9lVYWDJ2bZRQKgnX4Wk
	8QFKlowitS+ADDOiruZCTdTPUAd6A+u8C4iyukTcNx3sLqj7AVNxBplsfw4g97SfnXoaS4796Tp
	OpuLx9c8/jdewqSZQxx1gMDzNok/2R+lXoEVgDRlEctZoWZtL5z9xQwJHtuss8GGLhIIv
X-Received: by 2002:a05:600c:3e0b:b0:4a6:42cc:bf7b with SMTP id 5b1f17b1804b1-4a963ffcf7bmr17022925e9.3.1793153726005;
        Tue, 27 Oct 2026 19:15:26 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a9733d48b4sm12909955e9.0.2026.10.27.19.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 19:15:25 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	kkd@meta.com,
	kernel-team@meta.com,
	martin.lau@kernel.org,
	yonghong.song@linux.dev,
	mason@kernel.org
Subject: Re: [RFC PATCH bpf-next v1 09/11] bpf: Let the comparator of bpf_rbtree_add unwind
Date: Wed, 28 Oct 2026 03:15:24 +0100
Message-ID: <20261028021524.1203900-12-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <89d5a613d296bb9e00c60395d44a45f8b39da90068939a82f8b27ce08557c584@mail.kernel.org>
References: <d81d996f09e0fd0b07816dcd0541f39c0f451a23.1793147364.git.memxor@gmail.com> <89d5a613d296bb9e00c60395d44a45f8b39da90068939a82f8b27ce08557c584@mail.kernel.org>
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

On Wed Oct 28, 2026 at 2:25 AM CET, bot+bpf-ci wrote:
> [...]
> TL;DR:
> - bpf_rbtree_add() unwind pad may be skipped under fexit/kretprobe/graph
>   tracing, leaving a freed node usable by the program

Right. Every function with a pad is notrace and no kprobe target in the
next version, as the verifier lets only fentry attach to a subprog that
unwinds, with a test that fexit on bpf_loop() is refused.

> - unwound path may leave node->owner poisoned, and may run kptr destructors in
>   NMI-unsafe contexts

Right on both. The next version unlinks the node before dropping it, as
bpf_rb_root_free() does, and refuses bpf_rbtree_add() in tracing
programs on types with NMI unsafe fields when its comparator can unwind,
as bpf_obj_drop() is refused there, with tests for both.

> [...]

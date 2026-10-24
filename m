Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792868941;
	b=rDU9JBttJuS9d6MFkcFtgCchx3/C4eNbpT2XQmQhsZfVfvB5q+rTLn6OD7KouuozLUZ5
	 PMLlCWy7jy+6dGEW4nmf3kqoS7/ZA6fKwmdriqxCSfF8EaRdHGGT+6u7UyVMWOuJ/RymV
	 zZzxGe1I+tTOel4J6WN8aJm/zQTPWfZLGQLaAVYWEWUVWUqwsfuMImQFKrA3/W1xTsLUK
	 MuoAhAtHBncU3URcQvYCfq4pkKq4k8zCxjwmyHIuTUfFuWy2dZ9ClrzVfCl/+ZY+taUPS
	 pcBGoPT9l8XOManoYZqv+NJKwa03aKP56lM5XCnFO9wGOjOfJgVQe68S2nxBRsiifRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792868941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:To:Cc:Subject:From:In-Reply-To:References:X-Mailer:
	 Content-Transfer-Encoding:MIME-Version;
	bh=b1KmGtfkzCXHo4XGQE9aXZCjXYpjChENBSuESrEsEx4=;
	b=z5yAB471S3L3M2g6hefqWfOXR4tRvMoXipCtlp+glk5FnZv1do21Cw90CY2ZKP1U2i9+
	 isfUZ15zilk5cGAvlLTIjdMrwpHPH5eJtF/H7/q4IkS3iAx8RW06cydORYMOHiZpko6HN
	 kQsPstRAMplnUtV1t5kZ9S1M178UjfaikhQP5ikyyDjreTpkKnYbi3Des5ikiGhzVtcs9
	 gbUpRm0gcktBCcEJmMJhCmuxPoWrzHRs6lIOIK04PRM2Tydu3XywwiiTlU3xmYHlw/vJH
	 K5qPrdIe82tibJY7DOyasHTHnN2/Z24rJuGPwVL9shcVdFppiz6neLZzHPttGy3HcOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XPl1gc9v;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA08606A31F
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 19:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DA08606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XPl1gc9v
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e9995ce866so15860455ad.0
        for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 12:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792868940; x=1793473740; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b1KmGtfkzCXHo4XGQE9aXZCjXYpjChENBSuESrEsEx4=;
        b=XPl1gc9vhSN8FIBnPFVPZxrqB1ycuNmB+ckeO620h5+u2agZWc4EcYJ+aFRB3kH4aO
         0ODza75WLQpzfmF2w0aXasgzT8QPUIV8s/YyKtCF7tjI5NW2xvJOgKZv1KekMZVvtQ9V
         Fb7EXO2JaROBMEyXVrytolyKRK+HuwB9IuVF0atgNK7Qdz0uhOC7CEzMhmzU32N0bk+z
         arIXBh7Pl7xHzghwfGSSTDGUFixnqb9nxWdGRaNm2KnZQ8w19AZn2RSKnc79JTqQ5Mh4
         LHWh6UbZ+tVnJ3opMUwNl55j75tGktX2hlqWN+9iDE4nPMSAbTzslD0H6npJzqTIwdbk
         wI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792868940; x=1793473740;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b1KmGtfkzCXHo4XGQE9aXZCjXYpjChENBSuESrEsEx4=;
        b=CkD4h+HkUCYfJgGuOmU94xHnhMixVELNVBvAys4VyyiHyo9TGFHa/i2fAlEH9v6Ewy
         PPq0D2gFUOTkSJpTutHtCwFSMp49ENaLSnyfHUX6y9beJY5blIwcAyqXzR6gO8CXGszg
         y0+baMyD6woBjPD2TbArxZUFEOB722rSasYBY8JEtPMt6F+eWdVpMS+PY6u78lRyX5W9
         0TTqotDmA1HW6yAUt3M9TgathgNzjMZ46xiQN+cHCbljdiojX50e28/5om0IdYGrEo1V
         qwcQOc4ufVh8g8S0/hdw65puOMZCxGo9Ojq3edq5vNqdZBITi+OIGNMUubpEPQhwCr0e
         f6oA==
X-Gm-Message-State: AFq9FYJcbWdaQ2fN3PVvIvnyMcpJ8sIGeqiDm3Uma8NHyZglFll37JIs
	s/6q3jjfABPtssSAHPF0VBvX7h0+bTsBVY4apRPdUE1FhzcYwG0IjA89
X-Gm-Gg: AYBFou38MKyA36K+Jy2PNzD3Vc/wLD8wxCgyTQVC1gxmM2r2VExwocUIE339dZwk7H8
	BJcHgh9QrkOsoBHUUmb60tz/qlNgPcwO6lXFZ6ZHG+soUVP95niG6OYxhJeYR+QReAtHWShf8tZ
	TmrX8daFkiiqPacF+uYDXdWETw+O9xUyVa7opi4fXd33FtkpMXjOK/WrLex1CL0GJG5UFhA/ab1
	0VK8/tJveFgnvQVagBxGfnNG+VD1KMzmKv3AmX1CFHA7L5CWrU+fq8BoAsqkjU5kh/Qe/VET/s4
	hUukKsZxbnEjhAUolQ6nLAEP5quTnPw+obAGYVVDy+TNTHIOyDOFXcOocDEMTQY92W3YKhv31CD
	GDEBCHjCIyOnQuQZmEZVY6YndIsEfMLKMi9bqEsmPlWAHZtdVp4V9pvoNGBEQy30xSO3WLQVeqy
	3hZOJpPsbFM+hMdvgOLjL9fXb9ZLd1Iyv9yIIWa3rEAic5/EpeHJR3tfaZGvcsJuX4vw2a+eDNs
	x0w/S4/NgixvSEg3ZbVXsoxFQuKbnXWyNeIvW41lS//4NpLzDCCHKMbtV1LAtt0w7hDsRXLn40U
	1MRlgkZ+7CXYk6bk/su/gq9Tv/pwkcYyy2nKt/W9/pzeBx5lC0OrDyS3Qetb
X-Received: by 2002:a17:90b:55cd:b0:3ac:9e76:aa97 with SMTP id 98e67ed59e1d1-3adea1a76b8mr2258311a91.6.1792868940394;
        Sat, 24 Oct 2026 12:09:00 -0700 (PDT)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba32e38sm3785610a91.2.2026.10.24.12.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2026 12:08:59 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 24 Oct 2026 19:08:59 +0000
Message-Id: <DMDAZW82I9LT.3FNX2WI80GNE2@gmail.com>
To: "zhen.ni" <zhen.ni@easystack.cn>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>,
 <akpm@linux-foundation.org>, <vbabka@kernel.org>, <surenb@google.com>,
 <mhocko@suse.com>, <brendan.jackman@linux.dev>, <hannes@cmpxchg.org>,
 <ziy@nvidia.com>, <shuah@kernel.org>
Cc: <bpf@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/7] mm/page_owner: add bpf_iter and kfuncs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <06925440-8df8-4f2e-aea0-ede1a98435fa@easystack.cn>
References: <20261021112437.1799213-1-zhen.ni@easystack.cn> <DMAURQCKK6CG.10CZ7MFXGJO3V@gmail.com> <d39db4fb-e511-440e-9065-72c34a1a295a@easystack.cn> <DMCCBEPCIWH0.2JEDKE64WPJRQ@gmail.com> <06925440-8df8-4f2e-aea0-ede1a98435fa@easystack.cn>
X-Mailer: mkdraft (claude review draft; edit before sending)
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

On Sat, Oct 24, 2026 at 10:19 AM zhen.ni <zhen.ni@easystack.cn> wrote:
> For this one node alone, about 97% of spanned is holes. With
> bpf_for(pfn, start, end) plus a bpf_page_owner_read() per iteration,
> that is at least 16,712,944 kfunc calls, and bpf_for has no scheduling
> point inside, and all of them are wasted work. The gap grows with memory

Right. spanned includes the holes. So don't pass them.
/sys/devices/system/memory/ has memoryN only for present blocks.
/sys/devices/system/node/nodeN/ links to the blocks of that node.
/proc/iomem has "System RAM" ranges.
523024 pages in a 32G node looks like 64K pages.
Then the whole 256G box is 4M pfns.
When a hole is passed anyway the call ends at !online_section() in
pfn_to_online_page(). /proc/kpageflags does that plus put_user()
for every pfn, holes included.
Syscall progs run under migrate_disable() only.

> front. The spanned of this node is already 17.23M, so a single bpf_for
> cannot cover it; you have to split it into N chunks and poll, with the
> chunking state kept in a prog map, i.e. a loop nested in a loop.

The loop over chunks is in user space. One bpf_prog_test_run_opts()
per range with start and nr in ctx_in. No map, no nested loop.

> for 52-bit PA. A 32-bit PFN range will overflow here.

The snippet was:
  bpf_for(i, 0, ctx->nr) {
          pfn = ctx->start + i;
i is an offset within the chunk. start and pfn are 64-bit.

> Solving all of this requires yet another, more complex kfunc—and it
> looks increasingly like bpf iter. So why not just use the iter?

Nothing of the above needs kernel code.
v3 is +474 -83 lines on the kernel side. The diff I sent is +55 -1
and it doesn't touch the debugfs path.


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795654537;
	b=F0jDae3+wEq+C2DgF4Ohi5YnEUGFSvND++uRLIve+OrCVsG2OoE3ei1jHid7XbXrormt
	 zOk5Ehek3xOJzbLAxHZKQV766BcCBQqQ7SRJjL5GKNaBDht+PRgBOOP1/MHgnPoqt25js
	 uvqhpsiuJUFeUwwKiURuz6GiylWz2zVqtkw1G9gHlJZ4wn/K/Z1uEqOUjrHkC4vb2OkRp
	 oY72The5yjXpQ++jZ53JP1eseP3t0/KvWvYeYdAFkRqz2edw/cRZtGs0CzVTS3493t2NF
	 Wi7bQezFnZXYdMgQ2Wlwsheh9BrFEZ+bfUxj1HP0nHTuUIdGtmN+mjLq4X+JkrABo7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795654537;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=MB1nnAUvZK00UyHeT51RwLc2P5QxwKntmb7o82GwYRc=;
	b=Xc1PXMewwaEyXahIwTsF+kSZT9QW44FzY5QJrBwh5nzG0gt/JI4O8ViMb2SLalPJteki
	 6Z2hq1wf8cQOy20xY7hkM/TVG2oSfKhf2DhMR/AB+TfTXsOn1dwHzJx1sSbxtr8TKmnaD
	 G5vzIJOGpbDACUsrpaBBLTjN02tsrVnuvElq0OnP7vMroTBhVn97UqieeIg/sIH96m6P3
	 zcn+TTyiruTZrPF6ssSGEcG292OrMrG//vbS5jntZY8XuQFdo3CZG9esquJFZmFmo60EY
	 qU5UyRemmJ+lEn9OscQki7alDbDypZD2wWCw2JDF2M64qmjZEjZ4JZGsRAcgNKZ9boQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fqF9XtCZ;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FA1606A321
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 00:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64FA1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fqF9XtCZ
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8ca6a12efd9so2198978b3a.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 16:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795654537; x=1796259337; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MB1nnAUvZK00UyHeT51RwLc2P5QxwKntmb7o82GwYRc=;
        b=fqF9XtCZsEfwk7HipQHNQKxwhMUlWuOKdOgcXS1WE0Ej9cthkHQGK2UncY6FKM6/tb
         KAi7ag3jWf8ZU/JND3ZF6dWAhlHucJxmT2UcQ8PVqzPXjJvZ0z19/NGD84AF/hf9UIyJ
         aFTtfwDy9Ep0Mbe9FNIYbJKu+apLAt8H/lp7u1Z7YmG47gEhE0UkEreMvHM0gzaokdzk
         2jlGNcybazcnvOk7p8j6Vf085h6TnGf0jKRKoP2QCXBuOR9cJvhxMfdmNi3GxTkwjOzx
         7EU5gy/lSJwbew1PkitAqT/Dl/4jTy6DNMARiCsQ9wbZBgwUyB3PFhfOx1pLtQMyFJ0E
         VxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795654537; x=1796259337;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MB1nnAUvZK00UyHeT51RwLc2P5QxwKntmb7o82GwYRc=;
        b=aQXh1TK2f5Qqkt0W7kO6S9RjTU5iylV5gF+8IsPRiSVitb+lFAFS5oaOYfgKH6gfMR
         wyvAYjQvozNVbHGdt6fxgXfp5Y5dZj3S1Q3fuwOrvd0bqCz7SSfIac48mv/4qJ2WzLG1
         kDAjP63ZIOc1dgWN4VlmqH0FXLFzmYwDfie0Tp0iAx5sZPBUqRcEt6qVpzN5dfXzdKty
         pWn27Aw0SGm6ffIWBAxnpRGyMR/EmAHXM3y4895K2F1G5Qa/iY67FspeJoUUougVNY1J
         MbEXgaLfay4wes5ZvIO8U5M/ZF0C1FlYJ257ExUQvm0LA86f+pIcp26AgR+Ty4te93/V
         BQcA==
X-Forwarded-Encrypted: i=1; AL+hErEj47a3MR6EA7RVz9r3IkjJaj9fMBUgUpcBv31rzDj5IIspHdgEfctuZ/9LplqPbhM/87g=@vger.kernel.org
X-Gm-Message-State: APuU4Z9dJpAQtLoXMJIAwVjdi3y2F3ui7nQ3jJX4Q9DWrHnkAZB13Prn
	+XCNO5OaNGM42rG/64GXdFeL/tOEo9fUV84yIRu6Ryl5Z9KRjLKVSTZ+
X-Gm-Gg: AZFdTZerrhf4DtCh70xi1U01cl2FO1cnN0EnE59BzNZZzkXep8sxF6PtIoEKyHqtthp
	tOZ90nq5s1Z9OjjchZZGimFdOVcOa6Es//S38WGCD86ffiak4ZVFs3TRkxNhJTS9MLeVTxeqEDT
	fEN5YblLuNsWr36H+T/d9fRYTSLuPReGR5726h13S1h3Ihj3RuoLTPLid3BwauXC6/hzbiYFXJa
	/UAYNPDopnqV9/gpYUIq1dMX8eMukTo2SugXu0f6IdPNQ4NB8Z6pIHpi1+yxOXvVLoSDOMiodQr
	8Jye5b4R9R4TF4biaZXb0M6rH6Eoc64vatPHFnjqugoLLzwR6D6Ob6XU2uGPFov+f5crAXRDnlY
	sqp3M3VMSpeMJCSa66w8JWBay/kdV8zbZOEeqGhi6stLbecOdCOJxlQXKhNn4a+n4W0ZkTTFKu1
	rY9dA+fVhhZ7xlk6odyYZyTYJT87vcZeF1idbBYgPRL0LGcLqSjPFSlz10Qa4Sj9bc4CosGP4Ko
	rNy5xnueF7Bxd4GGMRZuGaeNL57leqkf2b1oxbrYLzqgKwdqoOJIf7MxyIXJPcH4Rxj+2dxM/3F
	oWl9xagjzLF6EknghiJcyu37gdh3JlSQwZvvDMYk+TjozCITSLQB2BsFDUHtJpphrSKeeRhbLk5
	PQoM23ZouKrSBzmlwan5+25YF2iHCL6O/bXg=
X-Received: by 2002:a05:6a21:168d:b0:3eb:aeb4:2c39 with SMTP id adf61e73a8af0-4014c94a631mr17293829637.17.1795654536392;
        Wed, 25 Nov 2026 16:55:36 -0800 (PST)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87334890csm9993539b3a.33.2026.11.25.16.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 16:55:36 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 00:55:35 +0000
Message-Id: <DN4QEPLSCNSU.3MRSDSGO4H4CH@gmail.com>
Subject: Re: [PATCH v1 bpf-next 3/5] resolve_btfids: Exclude a set of
 functions by name
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Anton Protopopov" <a.s.protopopov@gmail.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Jiri Olsa" <jolsa@kernel.org>, "Alan Maguire"
 <almagui@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>,
 <bpf@vger.kernel.org>
In-Reply-To: <20261125212849.868523-4-a.s.protopopov@gmail.com>
References: <20261125212849.868523-1-a.s.protopopov@gmail.com> <20261125212849.868523-4-a.s.protopopov@gmail.com>
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

On Wed, Nov 25, 2026 at 01:28 PM Anton Protopopov <a.s.protopopov@gmail.com> wrote:
> On arm64 ftrace writes the code with
> aarch64_insn_patch_text_nosync(), which is traceable without KPROBES.
> The same holds for it.

Pls add these two as well:

  target                         error    after the skip
  -----------------------------  -------  ---------------------------------
  copy_to_kernel_nofault()       -EFAULT  arm64, with KPROBES too:
                                          __aarch64_insn_write() fails.
                                          ftrace_bug(), no text poke.
                                          text_poke_memcpy() ignores it.
                                          bpf_arch_text_copy() returns dst.
                                          The new prog is all BRK insns
  tracepoint_probe_unregister()  -ENOENT  bpf_raw_tp_link_release() ignores
                                          it. __bpf_trace_run() reads the
                                          freed link

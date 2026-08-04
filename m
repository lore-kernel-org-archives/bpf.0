Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9936041CB5A
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 07:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785828122; cv=none; b=gfavraQM8ICi4oMj+1QIIsOeZi2ukpEeRi0nldfrws1YOlolE+f8ozpDQ+bb9O+R5ePNn24L2EvSXI5yOnHn/CMVazSC+YiZCIrqyJ89bweEGt3WvI9IvH60ribLgDVcATQHP7p/LX8/+OkXLGCF++6AuXLeQe37YqLxKyFK5gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785828122; c=relaxed/simple;
	bh=tj7sGjbREWOsDHase5iZHupHO9PzGRn9IHus8obRzO4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Hn0JpKVWuGRlWcFrQAJMBNniADrbp71687NmjiYNDkUQ7/5EpyBJxVPpaWJZDLlSacenEj1JagiuzmSvdzYcevHP5FlzRw0277MY0b/x/CYNaYrErgCaWtPY64NOOsQ2HGvMb1x6QhwYQaohN6Z/eFReeDiGbGX273vrt+f7MLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Os+UycwY; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Os+UycwY"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49553da76dcso10739655e9.1
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 00:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785828119; x=1786432919; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VXTTsL4O/3paYLRN7BxS6PUkcia5xr1I+hkWDuXdJQU=;
        b=Os+UycwY+x6+py5E97qFnk1Fz9OrpDaFx2KWv68m96p5sd1lhEeNVMXRT17HACsXHx
         C+ojvuLdhCRwBwJx7z9BSRbTYgBg5XHbWuy+kZuySpFvP/uD3AkofS18kXmO1HSHFPyx
         Mf9ICPVq0FJZMt4WP/oUBYBxcwxn2EMFzpp/nupnrZlKkI6jgNuh03uplNEVGvhbEwuO
         C+Tm+HaApNRtVFRpnarwf19EuLUUuTSReZLDm3q+ok8WbccP6JtcI9PBhGz8cYiR5MCs
         oqjSf/pKj1AuxUfoVnGdJHftq5CEE1DBUz6b6arDOR5A68BXjWUze/82Q5NCsLKPI7Aj
         1zBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785828119; x=1786432919;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VXTTsL4O/3paYLRN7BxS6PUkcia5xr1I+hkWDuXdJQU=;
        b=khrtGY/S29AEX3uHuKBGnyay7Z0xfMLmO2wK12TfaPtwQcxQJw/TcP+rwNgoN3P9mE
         Va3xEeL/r8qgfMbsmB8a6jep2ZCMVxKs4ttS80glJX4i580HjNLmWlANyO1gk3D3j3ac
         5lHONtF6hQZ4Y3cJT/kuOPPyP5GZhZS7nrIJ+OJiuNRgnX/hCPdAFmylYZxQGdLkbG6r
         1CIDvlQtph/hm556GSgGk2iXkM7tzf0g0Wd77LCaM6Akozx1W93Tl3aUZqKpk4Jl3CXe
         NcopujrsBN00TQF6eEErx0ZIH7UWgAqLKTFcc68FvYz4kLKVwfW4tYT6hHqdY/WyncTX
         ELEA==
X-Gm-Message-State: AOJu0YyB93jr7yErbQGLGAdwpHG65V1ETJMY24bGmNSO1qWUGiGsjslS
	EYvSOwBajPITF6IG57jcqnG0QikUv7EljniysN9Ud3Ml5XMb3TKPD84m
X-Gm-Gg: AR+sD12rAdNYVnsp3bKYwiEzd9YrSu3Gu1QKZAu8FFXo7ck/SyXP0kfSxBIeiWvlJiD
	490xwVSXbXqO89HD5+Jkimu0iuISQzPuLU2JJyzGEgjrvUHBUzrvrwlN7/Dhp4+yH8Bmih5a6QT
	e1B0uLAGHpop35Qojuq4/iUHtRTl0nMpJrX9+JvEc3WNK073a5dlFZ0NclAVLrdbsEcNkflb6RH
	vsc9syGlq0IpzxkEmi0NEO+vTk8rV/DqtQRHPAiL6ErcAkRCFWfm07clNDLymrw9PTHJWOscHLw
	zQMIY08H7AdCwsv3tZTcwSVQ6J/F6SOU1C5Bf9ahIAiEcgOoLiVQsdf1qMlK69qK/9j3a00s8q9
	HVmxN3BJHbnxgfMmb1Yq693r/zksZb3fDiUQTWFGvA5/GoWEGG4NMUrohKr9bqdJEkkRLRCd51L
	dsiWPbkjXkVC1jd7WObKPJlQkiQE3jRrmJKwOH//3dfbqLTDiMZawwAKfFj3HooNvbhYQM/Nsr7
	BlhImrlRxeBGsOf0RzzXMlYKt0JyMgPEaPL9/4KO3rW5dGKivCeq9yjH85dd9LIRuO8+57rkIaQ
	ss9Ya/N8hFp7wgQFWaZBq7Gm7DQ=
X-Received: by 2002:a05:600c:4e52:b0:496:bbce:fc with SMTP id 5b1f17b1804b1-4980c658ff3mr336982625e9.12.1785828118643;
        Tue, 04 Aug 2026 00:21:58 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41cfde0sm37912451f8f.3.2026.08.04.00.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 00:21:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Aug 2026 09:21:57 +0200
Message-Id: <DKFZ8FJ5G3Q9.32N54NYUAG8OW@gmail.com>
Cc: <bpf@vger.kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v4 1/3] bpf: Show more useful info in stack
 depth stats
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260803072733.191502-1-memxor@gmail.com>
 <20260803072733.191502-2-memxor@gmail.com>
 <CAEf4BzZwSogfspAQG6M4X5V4P+=-W1_hV65+6vpTDy5aaVYmPg@mail.gmail.com>
In-Reply-To: <CAEf4BzZwSogfspAQG6M4X5V4P+=-W1_hV65+6vpTDy5aaVYmPg@mail.gmail.com>

On Mon Aug 3, 2026 at 9:48 PM CEST, Andrii Nakryiko wrote:
> On Mon, Aug 3, 2026 at 12:27=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
>>
>> Currently, stack depth statistics are too crude, listing captured depths=
 in
>> subprogram-number order. Since libbpf determines those numbers, it is ha=
rd to
>> associate each depth with its subprogram name.
>>
>> Print the maximum stack depth and each subprogram on separate lines:
>>
>> stack depth max <depth>
>> stack depth subprog <number> <name> <depth>
>>
>> When no subprogram name is available, print <unknown>.
>>
>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> ---
>>  kernel/bpf/verifier.c                         | 13 +++++++----
>>  .../bpf/progs/verifier_basic_stack.c          |  4 ++--
>>  .../bpf/progs/verifier_bpf_fastcall.c         | 23 ++++++++++++-------
>>  .../bpf/progs/verifier_private_stack.c        | 15 +++++++++---
>>  .../selftests/bpf/progs/verifier_var_off.c    |  4 ++--
>>  5 files changed, 40 insertions(+), 19 deletions(-)
>>
>
> given we are going for quite verbose one line per prog/subprog format
> anyways, let's make it actually even more useful and emit
> insns_processed as well? I'd probably keep total line (processed N
> insns (limit 1000000) ...) for backwards compat, but also have
> per-subprog + main prog line with insns stat and stack depth,
> something like
>
> subprog 1 (sub1) insns 123 stack 16
> subprog 2 (sub2) insns 345 stack 32
> prog (main_one) insns 643 stack 64
> processed 9999 insns (limit 1000000) max_states_per_insn 0
> total_states 1 peak_states 1 mark_read 0
>
> wdyt?
>
> this will give better and more targeted information on where you
> should look for w.r.t. verification optimization opportunities
>
> and we can later add some other useful stats per-subprog/main prog as
> necessary without any major breakage (tool just need to assume there
> might be more stuff after "stack N" eventually
>

The format makes sense, let me rework the output and parsing and repost a v=
5.

> [...]


Received: from mail-ed2-f7.google.com (mail-ed2-f7.google.com [74.125.228.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64B138E8C9
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 20:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787604345; cv=none; b=Ix+/zvU2R4zKt4FoacKz4VY3p3vSVDXZLbtRagLj8ZOnyfDBLKJ+mwkQOdPn7Qe0AeZykkG8VS2eUdnCEuUIrdjIVmasEWpCAtmSLeekzhXfD8S1a0BMG4Lkb1Le/xwn5JBZBP6Z6ZKgC/lwIF+sMb+3QSbz6VV7Vxee4cnWqOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787604345; c=relaxed/simple;
	bh=5lhs+DnDtIjGjpWJul38VwotNXwZAyjlRWl8g9ipxLc=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Fdx395PxbclFEW+BK/vMl05ZLreAK5zuoyek+FPJUJR+CP8W6eiwnakMH+QAa9CYEYjcV1GiUwcPAyeyuaWAKtHYb2sUV2w7nn5nK89hP3E5a1crGU5Sz8wCqy8E5FVWejT/C93DtrXm8iJUkgAU1suVlGr+yjlcRovCR3TTAo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNcDpCdp; arc=none smtp.client-ip=74.125.228.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNcDpCdp"
Received: by mail-ed2-f7.google.com with SMTP id 4fb4d7f45d1cf-6a403027d38so2049790a12.0
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 13:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787604342; x=1788209142; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1jc7yPTsdl9s9ZCxYejVGBlGDxAAvpHITyYBq8v8lr4=;
        b=JNcDpCdpPsRjvmFKaKWQgFVI2kjHrrD8d7xj5s05/gn/RItYA5xzdo76Ayt0DeZpnN
         Gi54EHRwJB+YMudiBnxwMhg0oa74NRrqGCbWEFA8olk73GOFB9HEu86gTFRp4128ZKb2
         rwdPn7NLfb69lgwV8KkTeAXwWFEXf8M8ezGcyJk3KTnJmy1T5ToS9KMF1vWosJipM7v8
         hDIQU/WExsFU0Qi9EHfVcSli/j7UXcuhnxTdtPxtOteAz4+zex08bo2QIEP2c1rhiFNO
         dnT9HL1GB9Wotq+gRCS487qn0BB5EfbIl1m5D4ULRn4EL90sm22W/cvosSf9wjg4Gqru
         UWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787604342; x=1788209142;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1jc7yPTsdl9s9ZCxYejVGBlGDxAAvpHITyYBq8v8lr4=;
        b=d9VXuRUpcjBtmpThIIviATnb3h060mUaHiaKvSUUFCxbjIke5rDpJOZRv7hdspaztY
         7d2j/q8c+YwZCcU+RaMymlhyf1YL6Q3bfY+/D/xy+g8LG+7nMPe6SroL6j0zpY6LNfkj
         VmglXOo7LjeRG5yQZrI57WIP0ktnWF/FH4eTLw1HEcVs7N3ynheLFV3mfWqRVD1Apzz1
         zzha/TC/M763Cn0PUaNNr8KPO0D7ZvsyF4J+Hh/0hVJCP6ebodKTkLknwFgiPZpLS+1o
         I0d5LXVKIZ0pz2sZsYRg9BowzAXX2G7nrNvjTDFPySs90ayvCkV4yaS4NLsSwS0KqqLo
         3t+g==
X-Forwarded-Encrypted: i=1; AHgh+RquGL1ULIGYyFOdeEdpjk4quRvQST/McNogSs6NSzV4xmQok705xPm8uWBEJS2/CRkvSFU=@vger.kernel.org
X-Gm-Message-State: AFuF++nXhfC5utua60bSGxc582PTFIbam34tpHaNX3A6lW286DfkAw+G
	cOb7z1Xu2SNdCp/cfNkrDN3TZ6gOn2b8Manawt/aBlF234JGzc5HVFpA
X-Gm-Gg: AR+sD138njtKqMVG9mFzZTKuCWSs7jZE86KRhzxOJgQwRRIqRMdC7XU5UqJEjo6Hbtt
	hNIkqrX8FZZP+6KaS7B1olIosSievZ63Ktqv9S3Ews48pEyeuKrl2bS6Wl0UkcJe0pSF/Y5BLs6
	IAsQtEfB2Ty2FKXZAPXxbFVvHfWyb+IxjKD2jr7coBOL3/V/+B+P9crgrgY5lFNTjh5UZTFEM1Z
	eRWypkl8Fum73+6igQt2jswyoG8MEN0FJnnqN9cQHPspQfq4q8png/p/5tpVaE8g7q3UmJSBOHO
	loGHg9wb1Jzg+/a4q05t1FGk4lWOjFVFCOlga4Do+EkndjYKapypPiun0NOZwQC8qUGqGbaD65a
	mD+iXcU/NGw+D4QuSlSHtrNE1X7v45pK2GAUkN4bKzI0VUr4wgTuUF+8vRnSYiOGs2fzHYJkCQ8
	XCI8cY+j9h7p/R4pyYj0NvK1TCgJbKSzmhoGq+4EfgQrIC1bKdumcvb0GBBnd7nD1CgU7CIRRWT
	K51HvGYz8Jp2fzI6bmbjMiZfF0PtrOFvsT5+p1fVsh9d3XKTdbHv5gjbgrNBC5/7u99BSWq1uJ0
	fCsYYB2PVMkw00P4Sepu6qchA2o=
X-Received: by 2002:a05:6402:24a1:b0:6a3:f74d:6a20 with SMTP id 4fb4d7f45d1cf-6a582b0c6aamr25186057a12.4.1787604342002;
        Mon, 24 Aug 2026 13:45:42 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e1ae4efsm9450637a12.21.2026.08.24.13.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 13:45:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 22:45:40 +0200
Message-Id: <DKXGUP3WYZAD.1ZH64HX717QXD@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Rik van Riel" <riel@surriel.com>, "Alexei Starovoitov" <ast@kernel.org>
Cc: "Quentin Monnet" <qmo@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "Jiri Olsa" <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: fix array-index-out-of-bounds in print_bpf_insn
X-Mailer: aerc 0.21.0
References: <20260824164143.485301ca@fangorn>
In-Reply-To: <20260824164143.485301ca@fangorn>

On Mon Aug 24, 2026 at 10:41 PM CEST, Rik van Riel wrote:
> syzkaller triggers UBSAN array-index-out-of-bounds and panic_on_warn
> panic in print_bpf_insn() when loading a BPF program containing
> BPF_LDX | BPF_MEMSX | BPF_DW.
>
> bpf_ldsx_string[] holds three entries for B/H/W (s8/s16/s32).
> BPF_DW gives index 3 and reads past the array. check_subprogs()
> prints the program via bpf_diag_program_structure() before
> do_check() validates the instruction, so the illegal insn reaches
> the disassembler.
>
>     UBSAN: array-index-out-of-bounds in kernel/bpf/disasm.c:306:21
>     index 3 is out of range for type 'char *[3]'
>     print_bpf_insn+0x2328/0x2940 kernel/bpf/disasm.c:306
>     format_disasm_line kernel/bpf/diagnostics.c:633
>     diag_print_insn_context+0x3a5/0x930 kernel/bpf/diagnostics.c:783
>     bpf_diag_source+0x615/0x14a0 kernel/bpf/diagnostics.c:896
>     bpf_diag_program_structure+0x1f9/0x280 kernel/bpf/diagnostics.c:1215
>     check_subprogs+0x5c3/0x650 kernel/bpf/verifier.c:3057
>     bpf_check+0x1935/0x89f0 kernel/bpf/verifier.c:21097
>     bpf_prog_load+0x17dd/0x2990 kernel/bpf/syscall.c:3133
>
> Guard any size index beyond the corresponding string table and emit
> BUG_ldx instead of accessing memory beyond the end of the the array.
>
> Fixes: f835bb622299 ("bpf: Add kernel/bpftool asm support for new instruc=
tions")
> Assisted-by: claw:muse-spark-1.2 syzkaller
> Signed-off-by: Rik van Riel <riel@surriel.coM>
> ---

Already fixed by https://lore.kernel.org/bpf/20260820022020.3450479-2-memxo=
r@gmail.com.

pw-bot: cr

> [...]

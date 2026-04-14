Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC88C3C9EE9
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 09:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776159507; cv=pass; b=EA88IOx6Ogjl7ZaUd7PjH902pGjCAIBw/nA/WN0qUnbf7X7rLasa5w1IBaxXpu3M4MBbiXr4nFxYH9/YLBqIi2DMTtP9V3lDD9EkvV6o3xgH8qG4bprpcZ6pcnY5fdo7lugK1tHiOFV47I8W3THj5yvwFgftqaBJXru4SsB4WDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776159507; c=relaxed/simple;
	bh=kcjdDEKz8nZvddy7P6HkRER9j+LwEmEbznRAnp0HJSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KBf1C/VcXQ4eH3GBLDcD9XyLPaWjbUQ9VHJfNXGJ9o+QDX/JLQl1Y5f2RAKhCr/5tLAMaMBIGKhEc6IvjxqD/OWE4qe1SeM5X4aQYOBk1/Mz/+96EBnwAt0HvUEgZo111LmWq5/V9hx/DTvW8m1sjW28AdPXI4w/oVEYACK4+Z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4r8a+4O; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4r8a+4O"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b9c3a9fe80fso701547866b.3
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 02:38:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776159503; cv=none;
        d=google.com; s=arc-20240605;
        b=jPt2+pkn3cDYTE29M7zvOxGXtp82fijqgYWhkXL2/rLr7gYCDUD4h2Kz0QmSFqmy2+
         JnO0h5PI7QlQ4+3l2ZV+V7cQAk75nFScDISCC3ZIaK5S/aInZcRuuPFpkOtm6nSYWQXy
         8+m2id4E2CBR98ULz5rJcd6lRcqNkIlDOKQ99y//L5UbtWbyYh8d+9oM4VGQrL07fxpl
         jTqQsra/z12UNSh6lo8FQ2f/eqFyZZ0v1SoQ/bUrZOh/Y57t/C/r2ur0073P8RHheKXV
         DfP7Ygtjs60xI64vKQxgUOqfTfYAs2Lm5l6sI8bHdlUqVafFEZmmikH9kb3JWuq/YOnh
         WlIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kcjdDEKz8nZvddy7P6HkRER9j+LwEmEbznRAnp0HJSg=;
        fh=CEFYLfGgdOrJ4tNfcYBCw0GsiELtD9rPMaq5zdywx9c=;
        b=AqCDtSVjStbDnhxkpG80bN+rbE6QcK8MnlkMCGBOgHJn7Z4O/6LruWdPJGL3ds1rTb
         rwTrdDiLnalxKU3tYoHJmJkct79xExEf9jxXNgA9VFe/innTopN8t+wikdyzKDP7lm3o
         h3VyW0q9DeAT9pV2twwkzUQXuCluSbqNL4aAJPgbvNQgz1lbA/dLQWTPC7+cADu7Fjtu
         p/x+Sp4Ifvqn3ytrq2+rYW2eJVG5RQyTiyo5QwVSCpGdbFlCCOb/PBalmBqJ8TJ6PxFx
         sFlCUzimF5CJJZw04XSEacfFWzwuyMGsSH24GFXs+BNnuPp85ChwipKMtoGCegEu9o+2
         40tA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776159503; x=1776764303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcjdDEKz8nZvddy7P6HkRER9j+LwEmEbznRAnp0HJSg=;
        b=A4r8a+4OXbJvHsYpWSYVP2jAqKcCoJ0olCQVy7XU+UHe/bE0TKVUaH/NXWOCfiD4ch
         20AduCqgSvH6iOAXLnMr74BSB+jn17dKZVL/SdnwZ4JiKpRNeyAfVQ4r3EejIQHA4gOx
         jeDJ0GWUxYDeC21Q0rwEGXKaooy0mt7+/aZnTRP3j0qrTkqcTDgm6LbM+mhjYusIF/HW
         h1o3V/Rxn4HToJGE45pNNg32MhWxVjenP7IfqO9oVWd7KBYLRAt4Fvbd+uzT90FOyvsv
         iM74lDeMoJturyv/nZlbZJrfXXYDxJbWnUz2HDaF58uGgxRkf3xfHE6AA7IKZ3Jo30jz
         h7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776159503; x=1776764303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kcjdDEKz8nZvddy7P6HkRER9j+LwEmEbznRAnp0HJSg=;
        b=J8CTbD1SlxUTvJ1jM3fVsEBgj7UtbnCPSyPwmrHfuY3M+K1m3DjJZsUS6tCMwiHkXx
         Imxhw6/uE3hjWXZx3AqoBCHvUGH4FFSiS/pDgjuiOyJqgSFrtIWc5YRcDpdevc5I5vTD
         TlZ7PoQ9xbNMwk4awvHOEk5sMKqu2PZKHfErHgJkuPqlWICyTU7Tj9jOFV41HoHxd+eH
         n7QvoaDch5croo0g6HeZqHbk5u9CrNMKpapCgRW0LtJnf5uDZAwla7ncwuJWZk9Pfucg
         lh9o39veVQNya+CkjI1qxr6nqZsYBE9sEGGbw0vwouCyPLj6MVavyxHN9NglIwgVCFHn
         PHRg==
X-Gm-Message-State: AOJu0YxdIGvCOV6mY9I0P7cJ8T17bmk64thPgjtdkQrymWO0nvqt0Y5Y
	bWP95CwxdZ3fjYc7HEexe5Evd1v8Mulzu+4dh9G83S5qAqirSWC9boUgQy9aikhioD2Hpkrlk4s
	Vpy6pBchpe17GcDxXj/ZGSPkoh2gPObKwcbWCpSTX8w==
X-Gm-Gg: AeBDietKTUiekrOzPAaPa5QvzzrDe/r9nYz+dBIlqMnRuNWudOdw3n0QKTu3hI+HGrR
	h1Y2ZRGlzOSPDt1/NIHBqOV2IqcnUSapOFOcrMNGafq4ZztN/uFYVsXRP+zDWM8rlSaUPRjXT+i
	pLrPE6XPTdzVt0snU3UBUzQdTOzWOxLhM/92V6RMLElk4rCwehpAluWRg2BsJRDMSGd7uzhjBJ9
	leu3jC3CbzHe2Gbpy6qFKr8tpT2nri+Zq1FuuuuJ9sPQHiANjm78ANW+8WtRA50TiYCwQC7Uiwl
	a1dCD0fEKIcd3zrzz8n0+cPw3CyqG9fdQw==
X-Received: by 2002:a17:907:1c16:b0:b9c:d04:e05f with SMTP id
 a640c23a62f3a-b9d72658a55mr959935566b.32.1776159502686; Tue, 14 Apr 2026
 02:38:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413191111.3426023-1-puranjay@kernel.org> <20260413191111.3426023-2-puranjay@kernel.org>
 <dd645fcf-76dc-4c68-8b6f-1a168cafd44f@huaweicloud.com>
In-Reply-To: <dd645fcf-76dc-4c68-8b6f-1a168cafd44f@huaweicloud.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 14 Apr 2026 10:38:11 +0100
X-Gm-Features: AQROBzA5ZqN85V-5pwDPQTcpuLbGTsQR3YyYyNFZOhVjcHyYWB-ouK4sX2jSl08
Message-ID: <CANk7y0js0YxPFX1HqpYumN-ji6-OkKi4YO5=CRz8nx8aTzYxPw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf, arm64: Remove redundant
 bpf_flush_icache() after pack allocator finalize
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Pu Lehui <pulehui@huawei.com>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 2:56=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> On 4/14/2026 3:11 AM, Puranjay Mohan wrote:
> > bpf_flush_icache() calls flush_icache_range() to clean the data cache
> > and invalidate the instruction cache for the JITed code region. However=
,
> > since commit 1dad391daef1 ("bpf, arm64: use bpf_prog_pack for memory
> > management"), this flush is redundant.
> >
> > bpf_jit_binary_pack_finalize() copies the JITed instructions to the ROX
> > region via bpf_arch_text_copy() -> aarch64_insn_copy() -> __text_poke()=
,
> > and __text_poke() already calls flush_icache_range() on the written
> > range. The subsequent bpf_flush_icache() repeats the same cache
> > maintenance on an overlapping range, including an unnecessary second
> > synchronous IPI to all CPUs via kick_all_cpus_sync().
> >
>
> So icache is flushed twice: once per instruction and again after all
> instructions are copied. I think it's better to remove the per-instructio=
n
> flush and retain the single final flush to avoid repeating flush overhead
> for each instruction.

No, bpf_jit_binary_pack_finalize() is called at the end after the
whole program is jited, and it calls: bpf_arch_text_copy(ro_header,
rw_header, rw_header->size); which does aarch64_insn_copy(dst, src,
len), this calls __text_poke() which copies the whole program and then
does flush_icache_range((uintptr_t)addr, (uintptr_t)addr + len); once.
This is correct, after this we don't need to call flush_icache_range()
on the same range again.

If we had been calling flush_icache_range() for each instruction, the
system would hang due to the storm of IPIs.

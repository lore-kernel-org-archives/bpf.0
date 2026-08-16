Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CB83C9ED0
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 19:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786909334; cv=none; b=gA/blLJ6GUQftM1CTCw7lc0SCXVhCsey9b/6LJlxQiilSnKvpj4rQRjwHU02iigXf2gvB3StDQJm3ay6+dm4cIAcn4A1SU8jXXOXBQx3xlDSwVnOsyVEhQw1WgrW7px3j6LGlLp54qKBjjGrhO6lAKliB6lDBFPzqzv8TlKZh6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786909334; c=relaxed/simple;
	bh=/rRkH8AbtohodS+IqBUvz2pv1V7l8xA4g1EB3mUt5iM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jA0ktbxYw+/1+9mh25cTL6gYUIzElELakjfyaTiDvqPaP9E8RKjcYI0fKjljg/128AmjYL5KOcZbvI43MPrfpjlYyMUMkBT0cR0IXCYRUJFNRce3sJ07UFiGE1m+mnlKQE6j5/+1XN7ip+/BjFuVb77yDhFsvI4TaP8KoqEi1Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZXadNXm; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZXadNXm"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38511175ad3so2598533a91.2
        for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 12:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786909332; x=1787514132; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/rRkH8AbtohodS+IqBUvz2pv1V7l8xA4g1EB3mUt5iM=;
        b=JZXadNXmCQGX9PQhxFcWkRGGxX7jzVVqlLoKq9CTRPwiRdfDcE3RUR4eiBIM80LLAl
         89WC7j+sZj0AcVjw+OsBST59+LCreMIUCcv3W8SLNwBbbxqYP0UiTrTIlug6ZwXtNZZL
         0qEvZYK8wQ/sUklc/MIxbflSAzMJPuEFeoGp3LuyyfFypty4Pun3414U7+tfih5VZqzS
         gGbHX4oQANL5OUTHHDg8eirwu23oA/apnt3UXt4qU8A3USPls7xvWsGQZAbuaEjx7LSW
         UC/7r0EHZ/RtC6BuGU9lcbZGuT3nLmeEm7p08mykpVeuDS2L4d8geu+mym7yqzE5ZJbb
         CmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786909332; x=1787514132;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/rRkH8AbtohodS+IqBUvz2pv1V7l8xA4g1EB3mUt5iM=;
        b=IYQkEiQxwybjd/VPm1M63PmDFDr1wF9Vb7Xh3yvtNeaGFIBfvxvwrNUqfRophdFoAz
         h+cE2Cv2laQMN7lRewM8mQLL1AwVrs8TJdmnTXjJT+CK9DKnm/FPYCCFg+2cHbVPhnxs
         moI075hlz1C6Gu28cHnX3IZO2oNQc5wZiQi7qkW0zKyYJ1YVpKwUWMCR1R2F/dUB59Bo
         SZe932V+xQconiIIxfY89HISlkAV9mKVKg8VFAFQ4+Iz1k/C+STdvckuiRkjOcPEN+w6
         kogrH8IkELGvBw9YBCzDeURy9/nH5tkoawaSwkLqvWY37iesCQ9g39hO90G6Nm4swPKG
         DNww==
X-Forwarded-Encrypted: i=1; AHgh+Rrve8oCFsJ1e1K7iUvLGh2YoPKf9Mdie4qy1K+impTMGzBLJl/L8rtHERIjQjdVoaJjLsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCBM2nektjUZEAUxsxIj/NYATHoX+kuj6OWVBgx/38kMUGhElX
	U0uiwyuD/7JudAde6GiSJ+uTSUSFCYFjsLqSBikC8tZfvf5ib/3+jwQq9jLvGg==
X-Gm-Gg: AR+sD12M7klYhFFVHhfsPsiUgQZ7Jc9aiAGRuVODWy+8o6nNFkRIiqfQZZ14bdxhmak
	ZzESfzEjDeICi7TPlPFitQR7Ub/xKIGGB06rld2XQ+XyIE6oI2a/iXciUdkHx5XS+tqw954MSCg
	k4itYOF4OqZHhdpryuWZrNbI9f+3h5bKNV1rg1GDxH/9AJ+W03aUaPu37M7S/zjz1J/n9mrquse
	FuPjBIac1OB/HNA5HYd7/9Xu/w+Zp+fyoczD5zhBfe3yODXljYxizFPayHlb9hWkXaYEaXv5nFG
	mfujf02/jdmuFBPFAL7PHx9grvpnb5uQhLet13In7LOOCpCEYDA4pIsUcQv3imEESCix/k+5hLJ
	b05s4077ieUpJgVaDX80jRwH3YObexn6/6V80uid3r6+5t+NrsWyz7FcHSn6XN2tCeAmYH+cfRf
	gYpA+CN0BDGOupayfV8VVwnX04F+2mKZV5bk+r2Lbw3HRmpdXH9lxYoBEXR1sA35enmOVhRgSzG
	1F9oBw5XqNkMc18jJ4XpDrfKH8=
X-Received: by 2002:a17:90b:2891:b0:381:152b:d596 with SMTP id 98e67ed59e1d1-3933b8e1ec2mr21550415a91.11.1786909332191;
        Sun, 16 Aug 2026 12:42:12 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531e3184bsm2292001a91.1.2026.08.16.12.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 12:42:11 -0700 (PDT)
Message-ID: <d73a4991b95cdbdb265f81708c88c04ee253e81b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] bpf: Keep fault protection when merging
 pointer types
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: memxor@gmail.com, bpf@vger.kernel.org
Date: Sun, 16 Aug 2026 12:42:07 -0700
In-Reply-To: <20260814215301.709827-1-daniel@iogearbox.net>
References: <20260814215301.709827-1-daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-08-14 at 23:52 +0200, Daniel Borkmann wrote:
> When the same BPF_LDX instruction is reached through paths that yield
> different pointer types, save_aux_ptr_type() merges them into a single
> type which is later used by bpf_convert_ctx_accesses() to decide whether
> the load has to be rewritten into a BPF_PROBE_MEM one.
>=20
> Before f2362a57aeff ("bpf: allow void* cast using bpf_rdonly_cast()")
> the merge only accepted two PTR_TO_BTF_ID pointers and unconditionally
> fell back to PTR_TO_BTF_ID | PTR_UNTRUSTED, so the merged type was always
> one that gets the BPF_PROBE_MEM rewrite. However, the mentioned commit
> widened the merge to also cover a PTR_TO_MEM base and replaced the
> fallback by a union of the PTR_UNTRUSTED and MEM_RDONLY flags.
>=20
> A union of flags though cannot express the property the later rewrite
> is built upon, some examples:
>=20
> =C2=A0 - PTR_TO_MEM merged with PTR_TO_BTF_ID | PTR_UNTRUSTED gets
> =C2=A0=C2=A0=C2=A0 PTR_TO_MEM | PTR_UNTRUSTED but only the MEM_RDONLY var=
iant is valid
> =C2=A0 - PTR_TO_MEM merged with a plain PTR_TO_BTF_ID gets PTR_TO_MEM
> =C2=A0=C2=A0=C2=A0 dropping the rewrite the latter type would have gotten
> =C2=A0 - PTR_TO_MEM | MEM_RDONLY merged with a plain PTR_TO_BTF_ID gets
> =C2=A0=C2=A0=C2=A0 PTR_TO_MEM | MEM_RDONLY which is not rewritten either =
since only
> =C2=A0=C2=A0=C2=A0 its PTR_UNTRUSTED variant is
>=20
> In all three cases a program can take the unsafe path at runtime with a
> NULL or otherwise bad pointer and panic the kernel on the faulting load:
>=20
> =C2=A0 BUG: kernel NULL pointer dereference, address: 0000000000000038
> =C2=A0 RIP: 0010:bpf_prog_77531a87032eeaf1_mixed_mem_btf_id_type+0x4b/0x6=
5
> =C2=A0 Call Trace:
> =C2=A0=C2=A0 <TASK>
> =C2=A0=C2=A0 bpf_test_run+0x20b/0x460
> =C2=A0=C2=A0 bpf_prog_test_run_skb+0x650/0xbe0
> =C2=A0=C2=A0 __sys_bpf+0xb96/0x3140
> =C2=A0=C2=A0 __x64_sys_bpf+0x2c/0x40
> =C2=A0=C2=A0 do_syscall_64+0xba/0x590
> =C2=A0 Kernel panic - not syncing: Fatal exception in interrupt
>=20
> Note that the last two shapes have to be fixed right here, otherwise
> the merged type retains nothing which marks the load as fault prone,
> thus no rule in bpf_convert_ctx_accesses() can recover it. Fix it by
> normalizing the merged type instead.
>=20
> Reuse it in is_load_acq_unsafe() to avoid open coding, and trim the
> overly verbose comment which is more of an implementation detail of
> bpf_convert_ctx_accesses() anyway.
>=20
> Fixes: f2362a57aeff ("bpf: allow void* cast using bpf_rdonly_cast()")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...

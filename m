Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795454657;
	b=FlnsXL9T/ZaM6HfVVbdYE4ho+sfweXyr0Ax/mOvB0eeb5ZVCLmkR25kal4bhw7Yx4JA5
	 bnziisjtu8PulknOXky5eNe/jT8unEbDy2Xyl+eZS5mWbhUdWBom+iQ/FRaHencl11AfV
	 U6UL2AQ9CVIHHMfflCYwsw3cxXn/upoY6+bkL+IMH+vnBB9/k8looW0IQZY9Yt46cmKBt
	 kLdXZm4rLDNl6FtMPNDtMe3ErPhrU/zv24JCL5Wv5H0vPNOGiMYotlN/UW8WxbGzXk/Gd
	 SHGA3wYkMBmAqUw7CekG0U1/WcTMAo8xE5wLMeWwCMfxJBMeo+P3PhE2hPHwBMBnEfg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795454657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ZgEGg9m51G/5DAgpzXL9PswXeGkJCwpX5Mf+qQRbeMc=;
	b=XqHwkHZ3RKRBEyUE+u1MK821+GZcguvu/v8T3IIx67fYInVtVNnz9AC6cB8SEcASeRLo
	 2naw5o4UcqiBFYfT21faf+V9mGsOKruThxDeR+eKAQOAAFNfvzf36LCbrcMvetW2S9YYX
	 A0vXsDyPmLbXY4fRy76k1vlxzR0bnEPUzg9GoxXMzS/F0aIds7pOrAY/IXn3up8KNcIXy
	 gbkQizz/Pf/yMBIRMccM40Kq6MAe43KAfVagk1UB/CuMPOJyQYMihasZUtszqO2JUou/O
	 FcZvOMWwSV+mO0AIxZ9VPTe7YyfHlXy9cxl5RMm+DNBuiM88UzkFhX5PmpLlshkAj0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BmFABGjQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.64
Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8309D606A31F
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 17:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8309D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BmFABGjQ
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-4a435d8cdaaso739599f8f.1
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 09:24:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795454656; cv=none;
        d=google.com; s=arc-20260327;
        b=spcpWinqSxkEU4WPgqiyb8IrnoXyeE/J4cBhp1jutY9N8RK2n7XSPi73UULDiwlpjq
         6KKONEW6dgptsN4J1XlAoEBt/bDSZkhjP1Lx1wG67VWtmVnPLPPOz1n5+u0tV82rKh0g
         fxiaYndkjGkWCWdtbRULClrhyNXIp9qsLzmxyql+qZVMY6d6E+LyInKqhhyTjZL28jvc
         S60jlTTsCCtdZQmLajp/OKL1Ks8iq0ty49UkO8qIvzFDWUje0ejNvtUVkggtbszFNs+0
         XZDOvGGf3Ijza2jQNluuKNltKHGdOgx1yPLiBqnMReDGCoe0cGNRv8Hxfa96xvPopWL1
         P59A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZgEGg9m51G/5DAgpzXL9PswXeGkJCwpX5Mf+qQRbeMc=;
        fh=da6dXfMxocM9wVuKoOz8EsX46YEeJMk73DcLgbApqqU=;
        b=VJC6JzwpQ/TLQPbr1GBUpm2H5f64HiBz9LwgVgshuJwaSwkNV2vGY9sTWgofteoaPM
         UocPy7aoxxWdjSFDnqZTdLRZlY/dm1A5M0wjKmoxa6s5+C33ivU7JbXX+vYNjcyeH/5+
         bZACPM6q99FexzeEZPGMRvQ4TX7Dmbm07GCm02gIrLImnPgKu/wD11BOwlxjSkmcm3ez
         UqfTsdthNTqYkvnQBv773KCOx0gsPyXcmGZZ2rbyB2O1vZqa50MmDdaygF8UMXmnKnot
         T/yg1nG74dKSJJcfWtBqE1QZy3DKSLEf2o//KBfsvIl88Zj68Fmh3pbUrHgpVj7Ls5wA
         gH7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795454656; x=1796059456; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZgEGg9m51G/5DAgpzXL9PswXeGkJCwpX5Mf+qQRbeMc=;
        b=BmFABGjQN/9jPTL0iJHghX2wIraWr41uMl7Qq4MnUVd4pECgcDaTE1Uwk/vwqJKgVQ
         iTywB3HX4c8wLBspJbKKJJ9ZzXuTcrhphw9jEQwH5+XL/z7E/q1Mu02KYV6xeT3QMjPQ
         vRKEpPeDH3FYp+/QOz+k+2UkSKNs8AieMk2uPfJpWdUlg+E3qO5cHRC0+7Bz4PM5BLL5
         Bob7VZX7005Uvny6lF6Od6VPlHESixgeVnEyV/9hoPeoIgft89xadkOA0+UAAtEwh/BQ
         Gv/B7DuvJBMTQckyEdf/jWFYFP1yyfeshaDyhV+9NnAypZ5T+XfKJEZTWXQe3CoUsO5X
         KFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795454656; x=1796059456;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZgEGg9m51G/5DAgpzXL9PswXeGkJCwpX5Mf+qQRbeMc=;
        b=BQyPxTnZdYNBOT+6PZjfnDonUNJ+pTWcC9aMacYea4OzmYepvWtK/Bx7ZNFWzgxBtI
         QtlvsCUuoUNbXM91i4Jydt+piu3XLpqNoHHUnxxTjRnIFuDGKmAJSP26llEv5IGRAfV4
         52VWMkHvPHzv9ZlSiura9Jf79iC82JT9exav79y/9cxgZrduMi8kHpV0jDsELFAFkHpc
         kh2Cgo2Ej98QmsibFLMd4ojN7TYUpLZ/6NEE7gDfp/2/4Yu4ZGC9ThbyzYzTXFIwwI/1
         CaO8NITjziRaiVjm4xyHqGtuCD2+jJ/cIubmGjPYgManrcjC58c5OSCCsqtISFQVXfaZ
         HFIw==
X-Forwarded-Encrypted: i=1; AL+hErFyABSLIzRaSJahP/lxUbxCUFXxto2jJ+Iey0BmcVcj7p6qVedjRS4qFbFW8l0WrEcLb0I=@vger.kernel.org
X-Gm-Message-State: APuU4Z8pZ+1lXFp0S4MUiyJuGeEv8dihyGOnXAFo571pmMvrtfdzs5sG
	yswOFGP3O0auP2vP4S5bwKmjL52EdJLHsczj54FyYbVEk9f9dDKUqRRZzsMqnTm7by2Momr/Yay
	DUeX2OTSwNWPEHZIxnaPF+EfOIPEMBhQ=
X-Gm-Gg: AZFdTZci5fmfFMOTlU3p+Ze0LJHvJXc7FK2DsdwPGBVUkpbSUB53/uX7raI09qC3h+q
	/PF4+LNz/1bDg5haiPF0acqxLAEhNd0xjQUevlN8KlCyWuyW6mEsZIBCBqkRN7opRCxnK3fYmZ3
	Raln+PNbslgMsn+WG7/EiI1vkoOayTs8/wuX7bIGsh9vfworzrhNntiwDBtMKn1peji20cRweU9
	X2gZ69I5s7qbUbmbXphEjrx+NUW/bZN44Ryk3n8eES9WfS/+ZNEWbT1eMjui9A96vK2w2VZaTBW
	3PoVTldSYIXCHkYw50JSHVi61fCEJwh5FqslI42mPskTyHqxxjbFlemthGigpEYiFg4VzreT5fT
	fxksmpLmOXRSsz6LojlnovPSvGg8zuKgoZcRpnYmSK/eVXuaG3INfywUjIc6j0Ie95OdUL2aS2i
	7wZx3weFiMwkw2AJO/WOYzkJmd0cjIF8JCVqR1fFbaKrUKIytOfbT6ztuODiZTzo2dX+l+Yp0We
	SegBytGugyas6KfPHoHWHeMxOgsKhiV05JQ4w==
X-Received: by 2002:a5d:5e8f:0:b0:48f:bf71:2ad9 with SMTP id
 ffacd0b85a97d-4abb400bcb1mr24309855f8f.41.1795454655445; Mon, 23 Nov 2026
 09:24:15 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261009024925.3169077-1-memxor@gmail.com> <20261009024925.3169077-2-memxor@gmail.com>
 <20261009041346.GHashp-hYpLl-o-l3M@fat_crate.local> <DM0ESVBT9553.2S1RWK1W7M8WW@gmail.com>
 <a08e55c4-26dd-4502-9cca-b063387a0e06@intel.com>
In-Reply-To: <a08e55c4-26dd-4502-9cca-b063387a0e06@intel.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 23 Nov 2026 18:23:38 +0100
X-Gm-Features: Aa3M54relxQoy3EdiSIPsTaCYulqDgyys0pixRmsp_lAiGy74skMPUx1VNI5t8s
Message-ID: <CAP01T77AiqVjyTJbHYqXe2v_h+PYzFEe3DeVTc1nyZVnzOfd5w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] x86/mm: Resolve BPF exception fixups for
 user address faults under SMAP
To: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, bpf@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	kkd@meta.com, kernel-team@meta.com, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Nov 2026 at 16:36, Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 10/9/26 08:23, Kumar Kartikeya Dwivedi wrote:
> >   SEC("fentry/tcp_retransmit_skb") <- attaches to the entry of tcp_retransmit_skb()
> >   int BPF_PROG(retrans, struct sock *sk)
> >   {
> >           struct file *f = sk->sk_socket->file;
> >
> > This program was written for doing a TCP related investigation. The first load
> > of sk is fine, but sk_socket can be NULL (orphaned socket) or stale, so the
> > second load becomes a mov with an extable entry. Below is the JITed sequence.
>
> In every other part of the kernel, dereferencing a NULL pointer would be
> called a bug. Isn't this just plain buggy code?
>
> I assume the BPF program wants to tolerate these situations because it
> can't fully participate in the synchronization mechanisms that the data
> structure actually needs. So, it makes what (in the normal kernel) is a
> buggy access.

It would be equivalent of doing copy_from_kernel_nofault() in the
normal kernel.

We allow privileged programs to do the equivalent of
copy_from_kernel_nofault() on such pointers, for reads only (the
verifier rejects stores). It is just done by instrumenting the
program's loads, so that the call doesn't need to be written
explicitly for every dereference.

The BPF users know that such reads are best effort, and they use them
with such expectations. Annotating all of the kernel is not scalable
to determine where it would be safe to allow, so privileged users use
their judgement on attaching in the right place and using this
mechanism to do safe reads of kernel data structures.

>
> The rest of the story is trying to fix that up.
>
> But I don't quite know how this can be done "safely" in a way that the
> fixups end up with good data or NULL. If SMAP isn't in play, can't this
> just go reading garbage from userspace?

It doesn't guarantee good data. The guarantee is the same as
copy_from_kernel_nofault(), i.e. the read won't crash the kernel. A stale
pointer to memory that is still mapped reads whatever is there now.

Programs that need valid data use trusted pointers the verifier can prove valid
(refcounted or RCU protected), and loads through those have no extable
entry.

This contract is well understood by BPF users. If they need to read
valid data they will use trusted pointers. If not, they rely on this
mechanism and attach to the right place to ensure the data they read
is valid. In practice it is heavily used by tracing programs
collecting statistics and observability data.

These loads never read user memory, with or without SMAP. Without SMAP
nothing changes: the JIT keeps the bounds check in front of the load as today,
which zeroes the destination register for user addresses and the vsyscall
page without doing the load. Patch 2 only drops the check when
X86_FEATURE_SMAP is enabled, where the CPU blocks the load, and patch 1
lets that fault be fixed up through the same extable entry, as we already
do for kernel address faults.

>
> Also, can you talk a bit about the code generation on the BPF side here?
> Are the instructions covered by the exception table handler all pure MOV's?

That is correct. Each extable entry covers a single load into a
register. mov for 4 and 8 byte loads, movzx for 1 and 2 byte loads, and
movsx/movsxd for the sign-extending ones. On a fault, ex_handler_bpf()
zeroes the destination register and skips the instruction.

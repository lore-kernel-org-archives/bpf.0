Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179D44E2F01
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 21:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790286517; cv=pass; b=q8seoucg5RLS9OWBt+4z1rAQ5gXaFqKGlDPAuVHDeIlUX429O6cpww4FEu5cLVrFgeZEj6YS4nlM6xOy1M+4ei+52TBqH+xW63AkiJxTv6Gv7Q1WJq+qDOk53qT+JzNdCInSh7fjDvL8CiaByrcQcLzvB/g8e14h5yQW2hVzaEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790286517; c=relaxed/simple;
	bh=rZERshdcV0tFUZGMj08I8XPWDI+kU48UpwOPfgc8PK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p2+3XfVv70y1XKqIf3cYjMun7CDaLn40aYDdowhfEJ2uvv7+UXKv+CFbMb2GlChM/GSrEctP2ZH/5/gHu8lTIaereDcFg5JU6cDwzn4/YqqfID+g+cKFl/Oz8RF3ldS8gxST2AD3ghHtUvUuiOHYkGyFDH4os1imkN0eikJyPUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlbGNRs5; arc=pass smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlbGNRs5"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-868b2e5be4eso137002b3a.3
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 14:48:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790286513; cv=none;
        d=google.com; s=arc-20260327;
        b=sIylNU4ieOOoRhhW1rKguPmnRkOQx3D02oqZfvLKB5nc8b4xHXJGA5b2i7M3lgV47b
         MXim4rcef/Kq2KIPnXxsirtI0NwhSWHbm1NUPD/kXWe+I3K6e+73nYPOswD5+E+27SO0
         HY7PmufOyQcZmFq84B0/lblVrGhRA8MAk9+xp1Qo1wnDPY1zvaVrUTW3E3NnxDBSFonG
         SBaHP8fLH5MMRevZLV3Lo+taxn5ER8Jk4tuI1EkyThMA4o9pQQwg8KxlAMhi1zFDTzs9
         /8vbGcUWv3tGFrpQJa4wpP66kk+J8oMj1MGn3LtETarRJ9g1lFf9h14sQ9taNkkE9WL0
         T2kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rZERshdcV0tFUZGMj08I8XPWDI+kU48UpwOPfgc8PK8=;
        fh=FUBgW7R1UQ/JYqA8TEwT9Pa4KExPzdlvUPCnpqa4vRg=;
        b=oQ1GeObctdtuswxERaUqltjz+hMTVYg6O7WZ8X3qho2kiInZycVWrUoBwAqPBo05Lg
         JddN2471Bm/4pGEYg5q13ttMqA6RwXg+lLahRpZfBTWpku0iYoozdHko5HUbL6Fh0Rrl
         ESv2QanwTbcDwULqPOKQPh7bGXy055kJqdNmg89m8sWZ92BtxF0d54a2sxuzuHMeVPNo
         WiDOW18N4JFEF/t3DVOITJhs9LXrHnpw8CKMTx1Ze/sRDvSsMbuaYGy7uoeC4I9zrd5i
         jTxqqpmvMWhXFKosr7e4zHGkGeUCthzP+Wwyf3fwJBosUZ9jGYzGYD1tuE8VGvgkwfJA
         kbDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790286513; x=1790891313; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rZERshdcV0tFUZGMj08I8XPWDI+kU48UpwOPfgc8PK8=;
        b=IlbGNRs5xvgzMAn2viM87IliW3aKCTY4fZihT5eOns56NYXkcgrOIpiLqaBj3eQbeR
         Mmjv72v4/Tv3qvfNZ79K5ECJw0Ci9oEmSQyHiLWerbMGD7AOQtfbhhb9mqmRSE8kF+9R
         w/eUhV+66z+lmnG8KvqUHwYSUan6nLkuWFgaxZNFFtP5mEWCOVPFrkCwIdSfIjyvH7ep
         3U5qCoMyAOw1zgVMAJZEmINrfTq38jjm+gQB/NApOMB/JwXiPcjXXEeozb4nkTAZE33x
         LsSAqppgbBJhSs6ZkjO280zeZi60qyFk4+Yl1nX7jKAOH8t8rAzIzAugWBSRL4yspbP9
         Kn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790286513; x=1790891313;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rZERshdcV0tFUZGMj08I8XPWDI+kU48UpwOPfgc8PK8=;
        b=k1+hOzzlwvCSNsUf+L8WxSeC/YqyA7InkT1tXaL1CqttXJw4xvDOUPx8ZRAtuabWpB
         jybSycLeQcSmMzdR7edqso0dtVtf2ET83H/MbR8Jp58J4CPE6gk7qPsNwKGn2WwGnL4I
         QMkeWiLC3+jYF5k0h22BMFAWxPUaQE4+cu+J0OqJo9z7gkQcjAQbwEafPSGw1URQo3Xv
         x7heFyy1NWMwq1UzBfJDVyAaIqcf/qfhpndK1LAIRwbpB9Ue/b+kRsBDFKTWWAZocoEs
         kjAX9Qr3kxwfe32/UK/Ly+qJfrI1wDGPlDPz1xqUetY2VGImXc/ugpovZWEDuQg2B4im
         qWjg==
X-Forwarded-Encrypted: i=1; AKwUvByTXyFKuIv5QbmO3ADbe9jThhhyKiPspSgN81R751a4UlhntC6IbtKkSZLmNaRUGtCD7/o=@vger.kernel.org
X-Gm-Message-State: AFuF++m/5g5D+541gAi0ndrPBBRLmX6IGJQztltx4n875PBtM2vqf2Jb
	UHN/WAqOM+1trHV1hUZVyXaTfzE7+CbrhHb9yxV0AbXyAA7Yx1Jt7i1NGngpTPq0h2p6DbgWYm/
	jMWINk9wQBk1Eb2fDPpb6i+c6qDWnB/E=
X-Gm-Gg: AYBFou0S6+mrovIRNPrb2DVHIFXhlLwWkV+OKUvaqeLVgTdMBfVxvNySyDT38l1ot2C
	CcTP80+CEB9+G7BJgFfwrVlOqd9cJ7qxDy3pJVeygXa77GovMcJWmUWa5OvBC3C98xIhBfGjDiU
	2LCVrG+RJfL0MYr4BlQ4GZ0vWF0Lo9s+oIjOVQiYeIamfRm8/cMTwMTDx3mB4Ry6mjj4qBsHXjV
	jpHhestterYsrOCZdSXVFwuJRPaGoIqZFUppQx4HKJFjr4IssRMtdj86MhW+NzhCAWfdaw7bemR
	wD26/5xSS7HRiBLqkI4Tpixxc/hjBTW5nOysm+ZOXcx6QvA4Uq2YENq3qfE4ZjDvB9Rx3sVt8uE
	5g87rrCVu6JifOVv1EW8Bzz9sdZJnHQIMd50HHyiApbdK/7heEkwnImvx9yCFCmKIP+6M/DNg1A
	==
X-Received: by 2002:a05:6a00:1c8e:b0:871:c970:cf37 with SMTP id
 d2e1a72fcca58-87e9b79bdb6mr3208088b3a.24.1790286513363; Thu, 24 Sep 2026
 14:48:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914115607.350097-1-imbigking12@gmail.com> <c28917c2-4715-4c70-a2d3-582ca641e1d6@huawei.com>
In-Reply-To: <c28917c2-4715-4c70-a2d3-582ca641e1d6@huawei.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 24 Sep 2026 14:48:21 -0700
X-Gm-Features: AclHuK-NmUD52AXBMVMmQy8Gn29BL7Vr649cjcXJIdr9GevbBkjrs5JhZeSwUK0
Message-ID: <CAADnVQLGWcdi+G-cWkxLCtY-Q3iQ4TJKPcL4i35+c2e_snSUWg@mail.gmail.com>
Subject: Re: [PATCH] riscv: patch: fix handling of bpf-jit execmem addresses
To: Pu Lehui <pulehui@huawei.com>
Cc: Wei-Jie Hung <imbigking12@gmail.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Mike Rapoport <rppt@kernel.org>, Xiaofeng Yuan <xiaofengmian@163.com>, 
	Klara Modin <klara@kasm.eu>, linux-riscv <linux-riscv@lists.infradead.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 6:32=E2=80=AFPM Pu Lehui <pulehui@huawei.com> wrote=
:
>
>
> On 2026/9/14 19:56, Wei-Jie Hung wrote:
> > Commit 8718e5a3090b ("riscv: patch: skip fixmap mapping when kernel tex=
t
> > is already writable") gated the core_kernel_text() branch of patch_map(=
)
> > on CONFIG_STRICT_KERNEL_RWX, and explicitly left the vmalloc branch
> > unchanged. That branch has a separate problem.
> >
> > That branch only creates a temporary writable fixmap alias when
> > CONFIG_STRICT_MODULE_RWX is enabled, and otherwise assumes the target i=
s
> > directly writable and returns the address unchanged. That assumption no
> > longer holds: bpf_prog_pack_alloc calls set_memory_rox() on every pack
> > unconditionally in alloc_new_pack(), independently of any
> > CONFIG_STRICT_*_RWX option, so BPF text in the vmalloc area is read-onl=
y
> > regardless of what CONFIG_STRICT_MODULE_RWX says.
> >
> > With CONFIG_STRICT_MODULE_RWX=3Dn, patch_map() returns the read-only
> > address directly, the subsequent copy_to_kernel_nofault() takes a
> > page fault and returns -EFAULT. bpf_arch_text_copy() turns that into
> > -EINVAL, which propagates through bpf_jit_binary_pack_finalize() to the
> > WARN_ON() in bpf_int_jit_compile() and leaves the program un-JITed.
> >
> > Note that BPF cannot be fixed the way kprobes was in
> > commit bdc46e507b59 ("riscv: mm: make EXECMEM_KPROBES writable without
> > CONFIG_STRICT_MODULE_RWX"). EXECMEM_BPF is already PAGE_KERNEL, i.e.
> > writable at allocation time; the read-only mapping is established
> > afterwards by generic code in alloc_new_pack(), which arch code cannot
> > influence. The only place this can be handled is patch_map().
> >
> > This is the same problem that was fixed on arm64 by commit b1480ed230ac
> > ("arm64: patching: fix handling of execmem addresses"), and the fix is
> > the same: CONFIG_EXECMEM is what actually tracks whether the vmalloc
> > area can hold executable memory that needs a temporary alias to be
> > written. CONFIG_BPF_JIT, CONFIG_KPROBES and CONFIG_MODULES all select
> > it.
> >
> > Note that this is not limited to CONFIG_MODULES=3Dn. Unlike arm64, risc=
v
> > selects CONFIG_ARCH_OPTIONAL_KERNEL_RWX, so CONFIG_STRICT_MODULE_RWX ca=
n
> > be disabled with CONFIG_MODULES=3Dy as well, and the bug is reachable i=
n
> > that configuration too.
> >
> > The !CONFIG_MMU build is unaffected: it has its own __patch_insn_set()
> > and __patch_insn_write() implementations and never calls patch_map().
> >
> > Fixes: 2c9e5d4a0082 ("bpf: remove CONFIG_BPF_JIT dependency on CONFIG_M=
ODULES of")
> > Signed-off-by: Wei-Jie Hung <imbigking12@gmail.com>
> > ---
> > Based on riscv/fixes (b94cec5761d2).

Not clear what tree this patch suppose to go to.
If it's bpf-next then pls respin with correct subj,

pw-bot: cr

>
> Reviewed-by: Pu Lehui <pulehui@huawei.com>
> Tested-by: Pu Lehui <pulehui@huawei.com>

and keep tags.
Thanks everyone.

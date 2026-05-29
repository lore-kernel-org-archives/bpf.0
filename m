Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBD43EFFD6
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 15:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066877; cv=pass; b=K6C9F2Y1rWH2LkoXZuHrkVPGsrY7ZjRLzGjropcdJv88aOt3z1/q3LRlR++EgYE7qs9xldx3ctHg9uO56adfuGtTQXTo3yqLa6Q7VKeNGR9e8FFXJaNi0d2wlNR3PHkg41/fQzP5TccIZ5B/pb4yJlk3dpAmJjpIYY91qOmzqXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066877; c=relaxed/simple;
	bh=zmmoRhlbOZnUunCbWDUBWHnzdYCUNtPRO5jKb5Jpwxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BHZKZeJ8/O2zzbFWdxUrz9JjA9q0e/07U9kUXDcSQ8d/MGIzwzeH1ESlny9nr3kE2Oi1W42aI5BRxi8aAJXzLC7bGMU3/RT8J7QYM79rhvSDneeUk/0+8kYOmGrrw8DclIfC2QdH7UqeH9ZhGhIcpOmnt58ZhbPZmcigmfegQ7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o4E/MFMe; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4E/MFMe"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45ef1629ff4so647261f8f.0
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 08:01:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780066873; cv=none;
        d=google.com; s=arc-20240605;
        b=kWPTA8owpvnbZSh3VRc49dpcQhWpzR1fh1gBdTCFo0D83TXCO/XbvuCcOOdnHo21wq
         dFKui5v2TGclK7Jzu3wpMMDHwY7HLJWN6ps9Sqyzon6K2oM5x2c/fHHRnbknnWIUpivz
         SsTtKDTaxw0ec/YDg2FpdV3OjQzKHm5w+CsA4xZ1CVH96PpNUHYe+aA111hoAGEAPkqq
         dvB7sGDcxHDU7xiEb/+5JhYTzsSIFNcwz0JaqxTNK6HledkAOYBsu70vZCsRITFaaUqU
         MqnOvc1PMkf0yWCxu+JiZSyxANDG8nbmsUTegWNuqn3VXSK+aP/yUDcwxC+EZejRx/Jc
         SgvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t1sTVLfJNlmiwQxjlbKINw/eXXkpYYgx6ibmDq3h15w=;
        fh=HpOqXcT6ZTJFXGNfoABpI7aRQh8JM9Wmk1nzwYtoyv0=;
        b=P2JBJLYpRDeZAQ5CUz5XX6Kyw/G8EldHa79UbHIOK+5eiOZkqSOZg2glMNLC6o/mA5
         hLeKr0nAlYYmiOnsLaC4IYGI5rIpnCuaSz20D5Au8PTeIwRvCeiPgBpzxyD9STKTGOzf
         Q1QJr0N3SmT/Tk7monjk50PLhhqUlkR2tqbpvpNz/dGYoqIm8VutPhP6dBoeHvVnpd4J
         CVJOim5dkYAT+Sr3TdWBbRtCdGAuuG9zKV9fFUCJpV91mjkU0cOW+C6vcS8pWltQyw/B
         oZkTGw0H11Nu0medOzomFP87WCBN1RtXfWfp4c0dI/1MNMuSPH3ajVlqaeT0CA5YNvx8
         H+8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780066873; x=1780671673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1sTVLfJNlmiwQxjlbKINw/eXXkpYYgx6ibmDq3h15w=;
        b=o4E/MFMejp7vQEs2NGr4vtimDlIrzNOda/A2nQ7aRgQPbt9d2VQTlkK9FbJg5+h64j
         p7LzJKj/NaE9U2feNYqhikLgew1Q8/g5EyroUCr+dYbrfDaItyvKfmMWJIgXi9aaqqYl
         dogUjD8soabnirlX1RKiF3Y91UrtT+SgMAArf5Q11opEnsWbeWWm5aEx8tATOEGcf0e1
         zS21tgpnG8BKHee+tQANoHpRabdhVY6QEEkFY5T9Dszf+sfulr48kxdpuK/vZh7YNNW6
         4GUcJRlvux68rWPhQgUVGNepah8VX2GtKvMFGx5O/AANt+7995SPkOPXhkF3W1JMu/sh
         xUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066873; x=1780671673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t1sTVLfJNlmiwQxjlbKINw/eXXkpYYgx6ibmDq3h15w=;
        b=m+jqO4Jg4mLzqCfuL36xMhMnNVNAp1SAWALcQpSF0zCrmjCjTZFNBkQRe6x8E7Qc6R
         OBnTU4ZhL8QgXrrcbR/8s80bMEHSNFFsjSDTLu/9jv+TnWOYEAru/SRHuu4UeQnLsNxk
         lcMJvk+nNcckXGeK0zYqdrEgwJK4UdW/N1k5C8QR3EPPJTmbJ+vgDSYClKxCsWExGTTK
         ROQgJUVEIAb4WQXbR/cfqLYZGwnzc/L3H4DTXATNYLHOaXdzW0k08sU5OV0nVHnhg8Sp
         gZq+32vABeQDHVlQ6WKwPsO6N1zCtqKr56UehZwQHclu9Tp2b+c9iwxu5tL7O7gIiRba
         vlsg==
X-Forwarded-Encrypted: i=1; AFNElJ/vR8jK4HE+KxICQDnQ6NxWx8veTjpN4Z76lcP6ukf5VN+vFNU79JUht4dztxvPRptyMMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmbt4/kabYcRhvvl27y7k3DNH88s+uABgjdBNj4+AWtu1d8o0d
	gv9q+LI4Zl75MjEsZAzCeglV/fRV2a2WuJfilJqCAi3PAkbxU6nT1j6st7YPHg8XHxcPgcqh1zN
	fWfDvqKE9kzsN7GRybDGzTIGQt/vbRYc=
X-Gm-Gg: Acq92OHVpO1DGS2DQjH+vqG6r2MabQIzl2I94kzuLyk8dEbYduSivCvldVGFqhzT63i
	NSPBbIPKaQeiTZRm5BC1lPE0hT9kOmjMG/gaBdc4w5ju3NypD0su2WmeFD83VFpAeyjA6yRv+lh
	/aCbRsNebA1+xvSGUMwS7hXAXu/PBg+XNwO5+F2yFCK1FYmmRy6UbdtaGhfZUxHCEeI0i6j9EjP
	h70GgQMo++UjPhOulgJp7xXuXq8dEC4jxXwwAWUKR0lvV6sCo4A+28XmqDbimW+duaXwXi+vNFc
	Rtv7hTBHxK9wAipj9YmJXAncVw0oPi+8C1m8AFtmh6nPJd28Ymna9tMI2GhSLTAUaEMgKjw0AW+
	mKN2D84YLVXDCixhPExeKij01g1lwZkpQnXPQ
X-Received: by 2002:adf:ed8d:0:b0:45d:3cb0:5ab1 with SMTP id
 ffacd0b85a97d-45ef6ba11camr177842f8f.38.1780066872688; Fri, 29 May 2026
 08:01:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522215337.662271-1-kpsingh@kernel.org> <20260522215337.662271-3-kpsingh@kernel.org>
 <CAADnVQLJsvCfRxyLT-NJRubwSPTNd0k5bEp45Zyu9q1B_3oG+A@mail.gmail.com> <544dbc0d-24d2-423f-9db4-07976d67a9d0@iogearbox.net>
In-Reply-To: <544dbc0d-24d2-423f-9db4-07976d67a9d0@iogearbox.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 29 May 2026 08:01:01 -0700
X-Gm-Features: AVHnY4I67Pxk1w09qWBuzGyy-nqJnsxFUxgK_bvs8k6vV-U6irtQG-aTaDaXNbw
Message-ID: <CAADnVQLQwwuVoA0zhb30nt5DOUgEiAgijuxcbn2FhiHCsu2q8g@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/2] bpf, libbpf: reject non-exclusive metadata
 maps in the signed loader
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 5:25=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 5/23/26 5:12 PM, Alexei Starovoitov wrote:
> > On Fri, May 22, 2026 at 11:53=E2=80=AFPM KP Singh <kpsingh@kernel.org> =
wrote:
> >>
> >> The loader verifies map->sha against the metadata hash in its
> >> instructions. map->sha is calculated when BPF_OBJ_GET_INFO_BY_FD is ca=
lled
> >> on the frozen map.
> >>
> >> While the map is frozen, the loader must also ensure the map is
> >> exclusive, as, without exclusivity, another BPF program with map acces=
s
> >> can mutate the contents afterwards, so the check passes on stale data.
> >
> > Hold on. How is this an issue? excl_prog_sha guarantees
> > that only loader prog can use this map.
> > Are you saying the same loader prog will use the same map
> > for the 2nd time. Ok. I still don't see a problem.
> >
> >> Place excl_prog_sha right after sha[] in struct bpf_map and have
> >> gen_loader bail with -EINVAL when it is NULL, via BPF_PSEUDO_MAP_IDX a=
t
> >> fixed offset 32. The 8-byte read of the pointer field limits this to
> >> 64-bit kernels; gen_loader needs target pointer size tracking to emit
> >> the right sized read on 32-bit (follow-up).
> >
> > I don't think we can go from maybe-racy to certainly-broken-on-32-bit.
> > So only applied patch 1.
>
> I've looked a bit more into it with regards to above question from Alexei
> as well as the __bpf_md_ptr issue.
>
> Imho, KP is correct that the extra check/enforcement is needed. So Alice
> as a trusted signer generates the loader program (loader_insns + data_blo=
b)
> and signs it. The loader program contains the below enforcement to reject
> if the metadata map was not exclusive.
>
> Now the (untrusted) host that wants to load the program, it holds a signe=
d
> loader where they can't change a byte of it without breaking the signatur=
e.
>
> However, it could simply omit excl_prog_hash on BPF_MAP_CREATE for the da=
ta
> map (which would "normally" be bound exclusively to the loader).
>
> Then check_map_prog_compatibility() enforcement is skipped on verifier si=
de
> given excl_prog_sha is not set. The loader loads fine, the fingerprint ch=
eck
> can then pass against a stale snapshot while a different program mangled =
the
> data_blob underneath.
>
> Regarding __bpf_md_ptr, I would solve it differently via fixed size, see =
below
> together with the excl check coming before the signature check in the loa=
der
> and the build bug assertions, and a jmp not eq to 1.
>
>   include/linux/bpf.h        |  1 +
>   kernel/bpf/syscall.c       |  5 +++++
>   tools/lib/bpf/gen_loader.c | 17 +++++++++++++++++
>   3 files changed, 23 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index cd191c5fdb0a..487f4653d8a6 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -295,6 +295,7 @@ struct bpf_map_owner {
>
>   struct bpf_map {
>         u8 sha[SHA256_DIGEST_SIZE];
> +       u32 excl;
>         const struct bpf_map_ops *ops;
>         struct bpf_map *inner_map_meta;
>   #ifdef CONFIG_SECURITY
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 630d530782fe..37dacdbc5c01 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1572,6 +1572,11 @@ static int map_create(union bpf_attr *attr, bpfptr=
_t uattr)
>                         err =3D -EFAULT;
>                         goto free_map;
>                 }
> +
> +               /* See libbpf: emit_signature_match() */
> +               BUILD_BUG_ON(offsetof(struct bpf_map, excl) !=3D SHA256_D=
IGEST_SIZE);
> +               BUILD_BUG_ON(offsetof(struct bpf_map, sha)  !=3D 0);
> +               map->excl =3D 1;
>         } else if (attr->excl_prog_hash_size) {
>                 err =3D -EINVAL;
>                 goto free_map;
> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index bcea21c3b7bb..cd8d7df94ac7 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
> @@ -586,6 +586,23 @@ static void emit_signature_match(struct bpf_gen *gen=
)
>         __s64 off;
>         int i;
>
> +       /*
> +        * Reject if the metadata map is not exclusive. Without exclusivi=
ty
> +        * the cached map->sha[] verified above can be stale: another BPF
> +        * program with map access could have mutated the contents betwee=
n
> +        * BPF_OBJ_GET_INFO_BY_FD and loader execution.
> +        */
> +       emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX,
> +                                        0, 0, 0, 0));
> +       emit(gen, BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, SHA256_DIGEST_=
LENGTH));
> +       off =3D -(gen->insn_cur - gen->insn_start - gen->cleanup_label) /=
 8 - 2;
> +       if (is_simm16(off)) {
> +               emit(gen, BPF_MOV64_IMM(BPF_REG_7, -EINVAL));
> +               emit(gen, BPF_JMP_IMM(BPF_JNE, BPF_REG_2, 1, off));
> +       } else {
> +               gen->error =3D -ERANGE;
> +       }

yeah. much cleaner. ship it.

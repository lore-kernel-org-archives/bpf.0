Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793993601;
	b=1h5bNS9n8gvbLYQsORfNAv/GIDhEq0Jp5Z24o1ocO07HToG73xU9fOOlXCO3uP6HZkHj
	 HkoyUsxF0MKpFKAp4f78tVQ7gPEgN0Z0K/rKQBi78ji7bMWKwAzi2wGpY3MxV4vd2OPoJ
	 yk8srAzeMjpFFkx8CuVShyNnATXqLa7uWHtUAwlo91E5SRGlVQ3vCxc01M94EH5jjrdVB
	 jzC5+9hOOTro9OqHNf65sLyyLParODuYZXcKEJek8DnqC54H4JDZaJL/to+6QoM2oTGAC
	 jT7n0tMMAFy6c17IDuJb2+/uXiK0CygM04t5qqIWGBJzHGW0lMSFsW1Tyuk995JUSYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993601;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=WASkhr+Unco/i3EllWy4fEDfIef6kYtQba3wH4Yi4vg=;
	b=wuxPZCu+cCUo6epk4nkkTv983TsffITV1q9GIvUB0oI5iIbuNL8VJb2rbYOHJycySYtf
	 hH7lTq7GboA9aL2zjRl+lAHHPKXrPNbj1DWXffScMoB2pjfazXGWQMGR98+uGFPV3uTyy
	 S0QMw8IBxZb57pHHknrcB/MqRg2rooCIl/4obntaWes3ROt3D6KF39ej1RLCXP0RonRBO
	 UjzFC99h5QhrbjJPGR+gMkle7ZHvvRQB4MNwuBHJMp/KBWVdLknKkqFu+5E8OPWTnzgVl
	 gZKTDLIVcpJTJr3n+JnVbua3dmJEnwgUuYOgpb6iwDud1IH7FyOwHXAMu5GFUaVLyqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="PTOVU/vt";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD10B606A32C
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 19:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD10B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PTOVU/vt
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b094e649d3so632632a91.0
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 11:33:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793993600; cv=none;
        d=google.com; s=arc-20260327;
        b=M8FBk6ZyUhi8D3i2L7fu2fMZT3fVfGN/pa2HnoyxzuZ6fwFOUSgJFRPR5w6EDa4seM
         ojo0gDHSmi4C5lRvk04uN49JYSx/LH3j2q9BbJUjhGnTJOLp90AKBkvAmGOB+cx256t3
         frIlPYgA6Hjus9EcXw2ElgeiU+nF67BjRMp7S1ckB2+QHoabQLD9eOmEldaSGyP6PBDN
         6vBeVRl34l6vG1Isb3uK0yMIcFVELTXzUmj6E2EbHRV68/8rVigkDEFGWzd9qrcmXXWz
         DvV1IrKSiZt3Ru1cEysGsf6CdDYdynyOVqgIrx8iWbNIfAwuQoZ/Gw7CnTQWuDP/QG8C
         qDtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WASkhr+Unco/i3EllWy4fEDfIef6kYtQba3wH4Yi4vg=;
        fh=7lYXQCouJTLVlcmDW55apHWXku5/PusDmkljLIPXiOs=;
        b=hEWzunUpIqTfI+o511g2vMapJ591Y1XJtuUGOv+cektu0iqmjTgqcLFVgoDqR84F9e
         C/2Upj1evNwQ2JVOb4waItpMs0RsQMDx2lZqdplXbAIxbaxGOvWnlBqfvWZOlSjMTaKK
         aJFZDYk+yHERHf7xzyBWKDp3Sq2qQ3F/KWaMJaQWrBap8j+YS2prThYrz5kt7qyoZcnv
         zupKYQc+IjHMaXNaiFGspBqlX5020q8HfA9h/yBIvR12ovN5Dp4lAYSoCkw8Veza+R7K
         60qIKhNp1VMiKWPeQZGWH8+2cTKrFz46Aq+6XsFJtFjD0rOqzckP3CpYlhTfZKptFFMQ
         yggQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793993600; x=1794598400; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WASkhr+Unco/i3EllWy4fEDfIef6kYtQba3wH4Yi4vg=;
        b=PTOVU/vtLVZodS0aOcFhbpPojR0zuZKWzH68M+LgwxhUiMUUV3OwAyiTQVlrcMUxnw
         5JHwdxmXVMsluwjPwApczHspB1hZrE0pKL/8rrvoFqdMiAAIy/MuK/FDLY/YlGrgdoOY
         jxkOm4zP18LMj/UG5TtK2Sbm6RkPSaVEOsrTsblHURQnq9i+o8BdEGcq0vnh65KC4pua
         t8qO68S7cQUlzZGrCjEamaURGUFfAElVnw+yN5jGhpynX4i2G4J6wYWvFEyWHFgm6twr
         X1h0Mzbrfv9Aol8EK2bqGug92Yy85UqYnHSA3uCYJGOwgKYOYLZQImW0f6cOgC9KFbL1
         gmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793993600; x=1794598400;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WASkhr+Unco/i3EllWy4fEDfIef6kYtQba3wH4Yi4vg=;
        b=U+7zJgv5O4Csu3n4v5h7wjKx5IaZSG7WVC+k3D+iNiT8i3LkWFQ//BSoExWC5Z9Ftt
         Dvh5Pu1/nt7AtSOb/TLL0VPoaN5Qb72gZdE3jYfTF3RaRDn+lJrOhquuANBfRh9LLPCx
         FhazMau3uM9nmrC8MB5dgQ/deQ1frIbTy+1/i4ngr95iZQCHQ+sK4vFecuqhIwn7rGAk
         OZy7bYrsGWrbPYKX0AgBsCwoJGQ/3CVUV9ePNzySDjil2mlvOJMrzBrX1XWY2FN3/A86
         ZPBFwrt8S2SNBLYQVPH0WmtW4+2xL6kMaLX5axmg3KAy3nrWKEH4qOiS5IRTQJURO+Wa
         iN1Q==
X-Forwarded-Encrypted: i=1; AL+hErFhTE9NMAmCCYaLonwRy/KAPmhONKO9uNMLoK7ffE182BcKQJB2BR7sOYVpPmhlfDKkmTs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8F2L3gH6MA7JobNXNi/15XYvEGdL4qWCvJJg2IVqtiSZHJldaA
	OkzcNgXM9D3TpXJSIUN/q/wkiEB/w5pZ7RbugWEeqA+bcc7Wk+v3wLkFcFqjCRY3yVszyn7otvD
	PL75/mGI/xT905jjBWYxDv0g2FYO2AGEfU9cf8hc=
X-Gm-Gg: AYBFou1pValv2zTlNxodHDHl4WwGfA3zmWGLA7ga++7wRq6PpQf6mlBhlCpguFyRodg
	nRwOX/LalLFvc7ykbNMgbfLTjQ7HGc2pfkv6Pg6KTcuERK/DtFWX0tmNZLa3DgGos07QqNfxSg0
	Mutrchk91AaPAeeeGVqVlhTQR46kF8M137f2kBDgSckJosSuZ4G26Y2pvGg8GwVfQUmAIa23bng
	1fowrfAA6A3ZiUTPfmIPMXa7FN+n9kki6gcBu4gz8EBP67eBfkv2Sfhs2eJ6WTFpXW4o3y32IIj
	uh2aBWkY6Ruxck8vBpnQhjNSjju8J1/aQZgPkPwBzpSwqPRC62r3pJ7x7Kmj13puLh5kOIxj6oB
	w26oVPe3CH9aIJnEyX5cZTT3TP8EOdvhkjjj5DDPZM2kJTzuCYVrfrUp3z3ocPKErEquRSl3KCh
	Iy+L0=
X-Received: by 2002:a17:90b:39ac:b0:3b0:9cc6:62bc with SMTP id
 98e67ed59e1d1-3b0db6ebd52mr3469969a91.37.1793993600100; Fri, 06 Nov 2026
 11:33:20 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <d85ece6e-27f9-4d9f-83af-4101bc76fef6@app.fastmail.com>
 <356db94e-f5d6-4fb2-839a-b97aef72256b@app.fastmail.com> <CAHC9VhR9sjunJRnM9gy-BkBZkapQTrr8a8FtmaK7JkAmUqTrLA@mail.gmail.com>
In-Reply-To: <CAHC9VhR9sjunJRnM9gy-BkBZkapQTrr8a8FtmaK7JkAmUqTrLA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Nov 2026 11:33:07 -0800
X-Gm-Features: AclHuK9gXDhZeKl8Js7bG-wUcnzU8mjlehe58_riZeQRtc97_9zHpsNN_OoiZ0w
Message-ID: <CAEf4BzZKmn6g0SK8OddjKFj_vAmZFvpZv32Hs_S+GHgT7VNfrg@mail.gmail.com>
Subject: Re: [BUG] bpf, lsm: new first argument in 7.4 inode hooks silently
 breaks BPF LSMs
To: Paul Moore <paul@paul-moore.com>, Daan De Meyer <daan@amutable.com>
Cc: roblabla <linux@roblab.la>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul.mabileau@harfanglab.fr, 
	linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 7:41=E2=80=AFAM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Fri, Nov 6, 2026 at 8:39=E2=80=AFAM roblabla <linux@roblab.la> wrote:
> >
> > Hello,
> > First of all, I'm sorry if I'm sending this email to the wrong mailing =
lists, it's my first time reporting a linux issue ^^'.
>
> Hi,
>
> It looks like you sent this email to the right people/lists, well done
> on the first hurdle :)
>
> > In commit 16959c469f232f5c76cfb628297cafbf6dbdba79 (lsm: expose mount i=
dmaps to inode hooks), merged in 7.4-rc1, a new argument was added in posit=
ion 0 of various inode-related `security_` functions. Specifically, it adde=
d this argument to inode_create, inode_link, inode_symlink, inode_mkdir, in=
ode_mknod and inode_permission.
> >
> > This has the immediate effect of breaking eBPF LSM programs relying on =
these hooks that were compiled with BPF CO-RE and using BPF_CORE_READ.
>
> ...
>
> > Now, I'm not sure how the Linux Kernel treats eBPF LSM hooks - if they'=
re considered part of the userspace that shouldn't be broken. My understand=
ing is that kprobes are not part of the Linux Kernel stability guarantees, =
for rather obvious reasons (they allow watching the internals of the kernel=
) - but I'm not sure if this extends to the LSM Hooks. I assume not. Still,=
 this kind of breakage is really painful for us, and I hope we can find a s=
olution.
>
> Like kprobes, the LSM hooks are intentionally not part of any stable
> API promise.  While we try not to needlessly churn the LSM hooks, we
> reserve the right to modify parameters, the LSM callbacks associated
> with a hook, and even the basic hook semantics from one kernel release
> to another.  The reasoning is very similar to that of kprobes: the LSM
> hooks are linked to kernel internals and thus need the ability to
> change as the kernel changes.
>
> LSMs that need to provide a stable API must provide an abstraction
> layer between the LSM hook callbacks and their stable API.  The LSM
> framework is not responsible for the stability of individual LSM APIs.
>
> > Could we fix this type of breakage by making sure new arguments are onl=
y added at the _end_ of the LSM hooks signatures,
>
> I'm sorry, but I can't make that promise at the LSM framework layer.
> It is impossible to predict how the kernel internals will continue to
> evolve and thus I can't promise how the LSM hooks and callbacks will
> need to change as a result.

Yeah, I think that's a reasonable stance and we went through similar
discussion about tracepoints not being stable APIs, no questions about
that. But I'm wondering if it's not too late (as far as I understand,
this hasn't gotten into final release just yet), would it be ok to
just move newly added argument to be the last ones? We had similar
problem in not too distant past with one of scheduler tracepoints,
where new argument was added in the middle of argument list, and that
causes just unnecessary friction when using BPF with old and new
kernels. We did move the argument to the end and resolved this
(without really mandating any stability guarantees).

So, in short, would it be possible to send a follow up to Daan's
commit and move `struct mnt_idmap *idmap` to the end of LSM argument
list?

>
> Regarding the specifics of how the BPF LSM has dealt with this in the
> past, and any plans for the future, I'll let others speak to that;
> hopefully they will have some tricks you can use to make these
> transitions easier.
>

(this is answer to roblabla, I don't think you, Paul, should care)

The answer here is nuanced. On one hand, libbpf and kernel (BPF
verifier) don't really know exactly what BPF program assumes argument
types are. libbpf-provided BPF_PROG() macro that everyone is using
with BPF LSM just assumes user specifies correct sequence and types of
arguments, and libbpf just provides a bit of syntactic sugar with
casting untyped input arguments (they are just "u64" types) into
expected types. So it's not easy to detect this automatically neither
in libbpf nor in BPF verifier.

Having said that, there is a way to handle this, although ugly and
*everyone* using specific LSMs would need to do this on their own.
Instead of using convenience BPF_PROG() macro to define BPF program,
you just use raw `u64 ctx[]` access, and then cast ctx[0] to either
`struct mnt_idmap *` on new kernel, or `struct dentry *` on old
kernel. And you do that for all arguments. E.g., something like this

SEC("...")
int my_prog(u64 ctx[])
{
    bool new_kernel =3D ...;
    struct mnt_idmap *idmap =3D new_kernel ? bpf_core_cast(ctx[0],
struct mnt_idmap) : NULL;
    struct dentry *old_dentry =3D bpf_core_cast(new_kernel ? ctx[1] : ctx[0=
]);
    ... and so on ...
}

How you determine "new_kernel" can be done in various ways as well, I
don't want to overburden this email with details, but it's doable as
well.


so, tl;dr, it's possible to handle this LSM signature change, but it's
painful and requires knowing about breakage and doing a bunch of extra
plumbing.

ideally, if it's just a new argument addition, it should go to the end
of arg list and then all these issues go away

> --
> paul-moore.com

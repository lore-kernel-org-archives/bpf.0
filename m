Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.221.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795111106;
	b=P85lBJewE4RoLxOtFR8Cnuu7ZpN/TE37SQMmjKXB111fD1EFcBfF3l4PK/hXPqI//viS
	 olXtIDPPNOrk/4Mg0LJTE+M2cVhyoEVeh7eP+Sxtyp+eQQHgf7ZFPSp8Mlx72WvAA8en5
	 mFj28gowe27dcXO4vXl5hpevP9ODV3hj+WVOYrv2XxbTzx0wVNiiUWPEdzDEVvjwA/tTY
	 myIEUGk8BxTz+p3vONVfB6F5TyBt/qUzgGrUpCYkP0pjJbj81Zfng65X+XU1LHVznHtVI
	 Z/mOOfECla/G4iHXEkaAC1nwA42Wv6NW424MpE9IntZsb9Buw1fEUO9CXZ4fBKXFALg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795111106;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PslAxsc1zc8ecKHENMwh3peIr40sPCuNVTraR5q6Nts=;
	b=SHAP5qnTwOv/lSyRqUdDHfI3iZnfq77xxVSGHkYQGbGmFW+hV4+tvn03nCysTMTZdWls
	 53YUImHecp+nR9h5kWrHjTy2TlTZJgndBot5Y9EJGIKFERTY3/bN8uA1mKIaa4lGRbcYd
	 N9hUyQ0B584Y7dEPjwND2dMgCLkWVAGcQpKHw4xtLVhDZL4ST37H6eH5La9aiay5nY6s6
	 0X4m73w+Kj0D26ncO8iUGw/k6dZ3Sf2ycbppv+6ENtYmMqPVV63NDT5gnZgDRrqQ6QgtV
	 DOCpMZcIRNNUX6Cr1GFKPBytPCKPH6C/JDhqLmiitEA6gk4dBnDaVFpR7sYD5nxymbg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KskaJ4DE;
	arc=fail smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2B960A5BC4
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 17:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C2B960A5BC4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KskaJ4DE
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4a357b1c649so1704570f8f.3
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 09:58:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795111104; cv=none;
        d=google.com; s=arc-20260327;
        b=OylRNQL2V1R846AnZntXX+aJuLfeABA5NKz9zK9P1gGt8HUsMugFr0MI7kuMa9SZ4/
         fPozBpekdLc1cUcbR60ju2uhgFuy9PMErCw+D7bPMFZo+vYs8aR2p15Y5RSxFTKWFySD
         T/c13PAhyVFNXmGHiLLlxzSUbp9ANWIK4gdxKRa+lA+GfnT2bhLRwFSW5RuOnL7sYXqn
         Zh7Dmd7N0neZEVbmozJFYM+uA7nh8Q7QP8zFnZTWpRqOayw/+khh/MeUvvadV3/aDCL/
         2sLK79bMZnW5gt+2iqYLDdVrlXZb2BVWngHQOgKQ7YqsSYMBxnkKW9MwGWPkKc1g9PTj
         tbnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PslAxsc1zc8ecKHENMwh3peIr40sPCuNVTraR5q6Nts=;
        fh=NlvZIMx0Yef5O9FKzuI18UWLmn1phhKeV0qGkdHc9k4=;
        b=eEXnRfh20PHI4DpP6FhrQwu531RHnybec5vvBJ8XHtx46tMDr3AHvQTY9ZtQtHE1Kj
         V4asNsuzQ6K0WSnCKuFb1SNH3MCFTfFOngBWk44cWNm9iG5zBaWvO+qernSh9BqBVFL9
         wAb1jRC1VFQmPLSgpafnTg1l9SkaNc3Kwpr0FAnXKGvmGa25nk3B/ROYhFWMpK6hFfKI
         JPWOG2uOQmGK94JVlf0SEqmZpavbl6zevUvhjxGo6HbYUzLojmSb/1jl9WKENMtFO9Iq
         7K/y3SAXiuodBSfRmJc5KqDY8cNLvCV2ayZ+6evq4nLdMyRbdIVcnKcFPvKcsfgUY64T
         uYfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795111104; x=1795715904; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PslAxsc1zc8ecKHENMwh3peIr40sPCuNVTraR5q6Nts=;
        b=KskaJ4DE9TbkUaMgwVxD/dbhrstg5KGdGNvSesaol/MYrJhWspuc0LVzoL0MwJEqzY
         g4fOwkWNChJfSfmqPxn4GprZEmgOvbYFS25vXUkx2YkNPADbYswD/0HRkFRcS3jHNJWA
         o+1yod281+t+3gODsKlHjGn4eIG0oemdhiiMxBEpK8LhpLMRA+rS6oE07kIoV8saIWAb
         O11fWDJd3UQpFLK2B4dy8VBZJm3nf5wDBWyvQu78Z34xuWQXazOgCUCDofobObBR9Iqh
         Aa6/b1pJ2Nx8gkVMxmtWMz2esM8nJYipSMzevRUFsN0VBXk1tZHFFxq4/1gEvbQiMdJC
         aCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795111104; x=1795715904;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PslAxsc1zc8ecKHENMwh3peIr40sPCuNVTraR5q6Nts=;
        b=HRdDA31JcVpAWqGECOK/N7Dvq45utVw9b+OjWuZFZfM3/b7gx00B2+nE8lLbFL5xB6
         Xi0pgCHwmaEqFwmhPhteGvac7r7tmBPN1DNl9ZN5XcBQwuKg0YsHvhd0LvH85bNGN8ou
         0C7WuHTnva9OZtA4eGSeC2dTmCQKch0s+mCQUQ9STQa9hOUDp2OTsKv8rY48CdzDi5B5
         Gd57BRED+zihQheUCnM9PwxCufDGfRUOtFJDQ5ezQ6nKuVwCWnxA4Ne7o2sR5hY9uHIX
         RzKm8NGxnhadqnzJqAxQ5K8XWzwa7byhgTmlbGsrVgIn3zOhqMtHuwC4mL7apl4K6NEN
         wCDQ==
X-Forwarded-Encrypted: i=1; AL+hErF3dr7lNk3KnPnVtiBKToCSYKKiRosuZotqM6fKh6GU8j6ytExYUaXkA6tC9zQG1ix7hCQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9/yolcbUmNB4+lpGQJj5fqNsAODDOl4Lnpnnid4d9iDKfLIoJP
	HdwUtsu2yksMQNg4HjsbJgEeygHeF1HpC0qhjKLC9WfRrr+XV7hwqcIM2Z1M82u3PrKF6Vgr0PB
	PwDgrAcj18HVOSwaza/qExNNTMzxc068=
X-Gm-Gg: AZFdTZeuVQzaROat6awaBLlRK5bNhsMiGpCZvezWio/1513/s92iyRmaNYf/V35LzzX
	050B1EAitESp09FrHovl310CRqYJSsyLVYnwgMrPuSUcIoE7giVYB2v+eaYrAjgO0wmI8z+ZbJW
	GP9VGBBQkvfpuh31l97y6IBPPVlZJTgaADm8Mtb7ZcjM98sI8e30FJTyYM5EUmRuU4XATUqeaxl
	Y6DmBSi1bkM6YuB7CReC+WGPOWA0EkipXJegP4oJlfs13teKEB+X7l1OdQnNacBBGbwD3CRPJVb
	v9zA/rqe1OyMJjpZaZDcl/sEuPNScgcIwsqTvse5RL8ikdOeeCUKQSllxqKQKbGQZhxyEWv6tQN
	e3nsDB7WCDn9YI3RCFDGZ+pbBMuUPjDBBrd/blU+o0NLnLuSQg3t2VyyQp58AM/61cnPXGEAJh4
	Cgtzx3+rpaiYtyvLysfEkml5Wj9fyLv+bAHw==
X-Received: by 2002:adf:e010:0:20b0:4a8:647c:f965 with SMTP id
 ffacd0b85a97d-4abb348dae1mr205469f8f.41.1795111104076; Thu, 19 Nov 2026
 09:58:24 -0800 (PST)
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
 <CAEf4BzZKmn6g0SK8OddjKFj_vAmZFvpZv32Hs_S+GHgT7VNfrg@mail.gmail.com>
 <9d6bdc31-e57c-4187-be78-29d82471f710@app.fastmail.com> <9695ec3d-7b81-488d-989f-0bd411d673f2@linux.dev>
In-Reply-To: <9695ec3d-7b81-488d-989f-0bd411d673f2@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 19 Nov 2026 09:58:12 -0800
X-Gm-Features: Aa3M54px5BqoBHIu0T3IW_WGJ1h2ACQTKlGPoaDQlVnbwzNn0EkGy5HFiAACHIU
Message-ID: <CAEf4BzYNo54oz12C+s51KG5yWozDHGsQHYqdqHfqpSJ8=QPmyQ@mail.gmail.com>
Subject: Re: [BUG] bpf, lsm: new first argument in 7.4 inode hooks silently
 breaks BPF LSMs
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: roblabla <linux@roblab.la>, Paul Moore <paul@paul-moore.com>, 
	Daan De Meyer <daan@amutable.com>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul.mabileau@harfanglab.fr, 
	linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 4:52=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 11/9/26 8:07 AM, roblabla wrote:
> > Hi,
> >
> > Thanks for the replies!
> >
> >> [...]
> >
> > So what would be really nice is a way to make eBPF code robust against
> > kernel changes such that it either works, or fails to load, but doesn't
> > do the halfway "loads but silently misbehaves". Here are two ideas that
> > have been in the back of my mind that could help solve this issue (thou=
gh
> > I understand that they may be rather large changes, I'm putting them ou=
t
> > there mostly as a conversation starter):
> >
> > 1. Could libbpf/the kernel have a mismatch check on hook arguments? I
> >    understand that libbpf and the verifier don't know the types a
> >    program expects, since BPF_PROG() only casts u64s. But the macro
> >    does know the types at compile time. Could it (or an opt-in variant)
> >    record the expected prototype in the program's BTF, so that libbpf
> >    can compare it against the LSM hook's prototype in vmlinux BTF and
> >    refuse to load on a mismatch?
> >
> > 2. Since kernel BTF has parameter names for the bpf_lsm_* functions,
> >    could we maybe have CO-RE-style relocation to resolve "the argument
> >    named dentry" to the argument index at load time? This way, adding a
> >    new argument could happen anywhere in the argument list without
> >    breaking eBPFs, and removing an argument will (correctly) cause our
> >    eBPF to stop loading. It does mean the eBPF programs must provide th=
e
> >    same argument names, but maybe that's an acceptable tradeoff?
>
> Hi everyone.
>
> roblabla's comments got me curious, and I spent some time with my
> helpful assistants poking at the problem.
>
> There is another workaround in addition to what Andrii suggested.
> A program can already make itself fail to load on a signature
> mismatch:
>
>         union security_list_options___mine {
>                 int (*inode_create)(struct inode *dir,
>                                     struct dentry *dentry, umode_t mode);
>         };
>
>         extern void lsm_proto_mismatch__inode_create(void) __ksym __weak;
>
>         SEC("lsm/inode_create")
>         int BPF_PROG(deny_create, struct inode *dir, struct dentry *dentr=
y)
>         {
>                 if (!bpf_core_type_matches(union security_list_options___=
mine))
>                         lsm_proto_mismatch__inode_create();
>                 ...
>         }
>
> bpf_core_type_matches() checks the expected prototype against the
> hook's member of union security_list_options in kernel BTF.
> On a mismatch the call to the unresolved weak kfunc stays reachable,
> so the verifier rejects the program, and libbpf reports:
>
>   kfunc 'lsm_proto_mismatch__inode_create' is referenced but wasn't resol=
ved
>
> It's positional and needs the exact argument count, but it turns
> silent misbehavior into a load failure. The same should work for
> tp_btf with the btf_trace_<tp> typedefs.
>
> But of course it's just a workaround..
>
> A bit more generally, expanding on roblabla's second idea, I think libbpf
> could resolve hook arguments by name with the existing CO-RE machinery,
> without kernel, verifier or LSM changes.
>
> The BPF side could look like this:
>
>         SEC("lsm/inode_create")
>         int BPF_PROG_ARGS(deny_create, struct inode *, dir,
>                           struct dentry *, dentry)
>         { ... }
>
> BPF_PROG_ARGS() (name TBD) takes (type, name) pairs like BPF_PROG2(),
> but instead of casting ctx[0], ctx[1], ... it reads each argument
> through a local preserve_access_index-marked struct, so every argument
> access is a regular CO-RE field relocation:
>
>         struct bpf_func_args___deny_create {
>                 const struct mnt_idmap *idmap;  /* 7.4+ */
>                 struct inode *dir;
>                 struct dentry *dentry;
>         } __attribute__((preserve_access_index));
>
>         SEC("lsm/inode_create")
>         int deny_create(u64 *ctx)
>         {
>                 struct bpf_func_args___deny_create *args =3D (void *)ctx;
>
>                 if (bpf_core_field_exists(args->idmap))
>                         /* use args->idmap */;
>
>                 return check(args->dir, args->dentry);
>         }
>
> Nothing changes on the loader side:
>
>         skel =3D deny_create__open_and_load();
>         if (!skel)      /* mismatch: load fails, libbpf logs why */
>                 return -errno;
>         err =3D deny_create__attach(skel);
>
> To achieve this libbpf would need to do the following at load time:
>
>   - treat bpf_func_args___* as a reserved type in CO-RE relocations;
>   - find the program's attach target in kernel (or module) BTF:
>     bpf_lsm_<hook>, the fentry/fexit target, or the tracepoint stub for
>     tp_btf;
>   - build a struct from the target's prototype: one member per
>     parameter, named after it, at the parameter's ctx offset, plus 'ret'
>     for fexit, fmod_ret and LSM;
>   - resolve the relocations against it by name, with a strict type check
>     (pointee types must match, qualifiers ignored), since CO-RE normally
>     treats any two pointers as compatible.
>
> A missing argument or a type mismatch is a normal CO-RE relocation
> failure: the program fails to load with an error naming the argument,
> unless the access is guarded by bpf_core_field_exists().
>
> And this is not LSM specific, fentry/fexit/fmod_ret and tp_btf would
> work the same way.
>
> It doesn't help if a hook keeps its signature but changes semantics,
> or if the attach point goes away (that already fails to attach).
>
> Here is a vibe-coded prototype of the above:
> https://github.com/kernel-patches/bpf/compare/bpf-next_base...theihor:bpf=
:bpf-named-args
>
> It's an entirely new libbpf feature though.
>
> Andrii, what do you think of it?

it's an interesting idea, we discussed this internally, needs a bit
more iteration and making sure that it will work reliably (e.g.,
accessing program's context through CO-RE relocatable accesses is not
guaranteed to work, and that depends on compiler decisions, so we need
to make sure we can guarantee this works). Ihor is going to
investigate this more thoroughly.

one slightly different take on this idea would be to have
pre-generated structs like bpf_func_args___deny_create in above
example in vmlinux.h by bpftool, so that users don't have to use yet
another magic BPF_PROG_ARGS macro and repeat kernel-side function
argument types and names. Instead all this can be (hopefully) just
provided by vmlinux.h so users just do

int my_prog(struct bpf_func_args___deny_create *ctx) {
    const struct mnt_idmap *idmap =3D NULL;

    if (bpf_core_field_exists(ctx, idmap))
        idmap =3D ctx->idmap;

    /* use ctx->dentry unconditionally */
    ...
}

something to consider as an alternative, perhaps (still there is that
relocatable access to ctx issue that we need to figure out)

>
> ---
>
> And just my 2c re argument ordering:
>
> Paul, with all due respect, prioritizing code style and personal
> preferences over backwards compatibility is unreasonable even for
> unimportant applications. And here we are talking about apps
> implementing security policies, which many organizations (not just
> companies) in the world rely on. Given the recent flood of
> cybersecurity issues (in Linux and beyond), I don't see why would we,
> as in kernel devs, intentionally make the defenders' job harder.
>

+1

>
> >
> > Thanks,
> > roblabla
>

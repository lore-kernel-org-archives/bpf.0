Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795011498;
	b=VNO+tbFLDuRrEJ3yAub9NWQwFTejUSQyHjB13zYwscZeXHHqkJJK5R0KC+DGZ+pP7KxA
	 YBytGX4g+5utp1VzKqUNWY3X60Dd8qcNlYMupYb1Cvz3x+3L0GvliN3HJraUwBFq4BDUJ
	 u/QCrf9TMVIWt2O5pv/eHTOjC0WvhN/P4qBGwqh/INQjus24edrSWB1mt1pgONglmG+3r
	 x77xaHipkpXdDAC/FKS+od6hicY5FSxKJnSbyHLcleDdd3z7gMepF4Czv6zpovEOXFXnQ
	 FK3igD+Vl8S59mV0FsMt940zd7HTEn0CgAlm6fAjw13juD02zwMwvtIB+tbTq603gPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795011498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=E995rutgSzyg1i9LNX9zVJhyluCmPXgjFoQIxd7q954=;
	b=1jtHjPwq9ewoIV8Ykmm7YjjRJxIFC9iIz1YMIW22/we+38tmbmGu65t6SbJf/EnUZkO4
	 /K3lT+rAHwjPcXeJcUBCnihxLlux6oZAmPpYfVjM6sx77RV4hKlQpXp5tms0/VY0txEAQ
	 1Wb7vkJxRlD6J55tGafqcdWeBpH1AosLdE37I8GaX5RAal/U9twT3KpniQvbJ2Aj5+8p3
	 4XiQHr3TaE62w9FfE9P1SEN2VdGzesz1vox/5zanqWaFBsWQiUTjhoUi5mQ3oAUgmH0KG
	 NWZiFevNVgdI5ywr4useRdfZUyevJej9eb501gHEyehKm+pA4Mog1V9VIO5jh6r7qew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=AUModmDo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E0D60A2601
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 14:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6E0D60A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=AUModmDo
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-67da62357acso1351107d50.0
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 06:18:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795011496; cv=none;
        d=google.com; s=arc-20260327;
        b=ABtaindXrlKoZhzkxCDb9Wwf2vwp5nJze5me+YqbMuPW9h3hepO/XNsenxbOvRKv9n
         jjiWMiQHeF7uhXxDZ2EM6syHa7QjWvi5wEABKhBvJNha9iWgmGngXw+74sTt4zUo3Kq4
         l0fYcir0/ZK+UL+qdBaIr05Hkw9pKx7wXZvLcvhnfk7qsM5ouQkT+NOEqkH04ebyLbRY
         YbyRlJ5Re5cunhCpJcN+Ori0RakaBI0lZM2RJGd/rkHoa+d/FvurnUKN7R9Dzr/P1f2R
         XhxPhmxa+wr8Wq7b+r4iui+GzB+GDcZhDa+RNJKzaQ1YtxEN1j5pVRUGcARM7G3SYm6O
         EONg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E995rutgSzyg1i9LNX9zVJhyluCmPXgjFoQIxd7q954=;
        fh=GE/BhCRMi/jygplqNyU4h7J6avkHwfmBoOozJdHASSI=;
        b=d3n1LUfKAS/xBb2V1F+XlbYmoaAQ7XrzFGTWWuqcN/j4CTkOyPcIL2SXjk2YCaP/iO
         +6uZn7n2UwT33YtoHLn1YlhYf4xWUZbweMpAOcw6+tX8AvcaK05JzUS6lKCMdhToHRlp
         iRScDNpjgbdgwjxaNTOunL4hkMY2aSoYHTnBLbJV3OyahmIWw53G1lEQeoBpSjzp8vIb
         GD7jVu/XiFgqcJQn2LCY8dLKkkXaV6M6I5iDo6ehRL7CYiatmW/w2rj9Wnkxe5w/x2ZP
         L994Ppic1MVG4ji9Ojz+qQJskWN6lznXc2wgg+BPzX3W5c/jUTrlwPuQ44SG0lFnj6TL
         dDRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795011496; x=1795616296; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E995rutgSzyg1i9LNX9zVJhyluCmPXgjFoQIxd7q954=;
        b=AUModmDof6ErWSMGyCdXNcxfTkCwx7QQL2OOBXQ7guAC6qyj7WSCpZaWOY6QzreIOx
         4pS1K2knwQavnNNBqwkB7+CVuy4nIAO47uvqWWVcKyxSaO6HjJtoc//F5a0pyaE8S01s
         /czjdm/4IH2mCCMXcGgJ+GZqDBEUEiy7q/sTAICpTY1pUfq86x1hJs/saKnvMVve4VAU
         dhgD9wlXcDkxqLBCRCjgiv0lYbOp/01AnpGqDAN4hs0GNRXnJ/5567cggS43udDzh4hT
         S1mqoJlVcJcBRP7sAPAVEiqwKlHWhgOXZR0SkDez/xXmjrYfV8KYm/x8HKsnMN15yy24
         SeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795011496; x=1795616296;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E995rutgSzyg1i9LNX9zVJhyluCmPXgjFoQIxd7q954=;
        b=w+Tbwz+fGw0nDj9mdv/A+xw32TFhKthZcp13q/ynnyRN9BK8npvaSsBvqsfYMC06sX
         1UV3OQCbxpPjn5LBGzvEmh1yhwdWz39NKAKsaVkxTKYJo+IwlqmDujvUb+UOKHlBkEGz
         H4/O43T6l4ZG0+EpJWf4aHlX74Fw8UGedJDn+kosSh99i53T+Sex30Sxw0yoIOzvhWQN
         0j+A4oIPBYJ0mVtvFGK72gpgXmc89/ECrhw2Gngg1WIcxZRRP5xB2XmiriObyWbUf+yV
         tL5oxyspK8qtYnDoIlkP8C6OSfM64dToKumHc1l3vGCLm8rlYExRM6T0IWBojvp4v4Fi
         ib+A==
X-Forwarded-Encrypted: i=1; AL+hErF7IsFJIELVPKsvnSqjrFMxPDaAr84I9yI1HX1eVegwU80V7zTIJh0tKZf+TvfCWvd6lHk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+F+/dTeklTJNUFApSvBYb9i9MqkdZiGPg62QzDUoxsS+150hbQ
	5nEhbznVwLlLDUGD6C8ZTgWFGZfQWScYI8eagmDbJ2Rye6IbEndK2U7HGQcDN2bAeIJ/zOiy8GX
	XF2563s+ByBjhylAi2PQ48iy3RwmvEMxR+Olt7tlmJ7Tg7bkq9CAUEA==
X-Gm-Gg: AZFdTZce8dV0/d1O/E5EfAPosQkV5fcP9JaFJVfwl7CiZNwekhRYKfYQnt22M0peE1Q
	tVSDLAuDpSU88eqotkMqk3l2tjbarmhcW+Vw0FVB7pb+xnU8be+uW3HUUcyglTtwkzQJfjianPo
	XHKKLHYWuvytCM+gcYGYyn1ftmyd3DQsrzcAWp6M8VmVBqNEiXpbGYk2VRpD9zBLL2AhNbhlic+
	ra4AdGHzqt9q+aMIhHxVcDKKGskj2VTMuQs9Qlm8RI5o2CtxiH1D7c+/IQdXWztE0tKNb7DMrke
	EZtEMltVIdT2MZNUJZ6Pdn97f7BxJhJcjpXLz37CfNSaNfhAzKhrR6yqP014tLPeZvRhH0YDlhI
	525vaKfp0TFjVEIrM/rKQ8ifHaznBJhaxtnrb73KO0/u8Mx8506zfR4tP7gN/BNqNCUYbHhM=
X-Received: by 2002:a05:690e:190d:b0:679:a42b:f0dd with SMTP id
 956f58d0204a3-67dd3cf9efcmr1187071d50.14.1795011496626; Wed, 18 Nov 2026
 06:18:16 -0800 (PST)
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
From: Daan De Meyer <daan@amutable.com>
Date: Wed, 18 Nov 2026 15:18:05 +0100
X-Gm-Features: AclHuK_kSwvu5Jj3k6C9_kA8WpAYJGoXqqdOwo0daouusPGhJdTvAUCcGkN4sy0
Message-ID: <CAPa8sAh6b5xn4rZzPfM0nZ+_kkywWj22fy8deLq+6qYews0rdQ@mail.gmail.com>
Subject: Re: [BUG] bpf, lsm: new first argument in 7.4 inode hooks silently
 breaks BPF LSMs
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: roblabla <linux@roblab.la>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Paul Moore <paul@paul-moore.com>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul.mabileau@harfanglab.fr, 
	linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Note that we've already merged code in systemd that depends on the
current argument order, so I'd really prefer if it didn't change. If
it does, do cc me on the patch so I can fix the issue in systemd.

Cheers,

Daan

On Wed, Nov 18, 2026 at 1:52=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.=
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
>
> >
> > Thanks,
> > roblabla
>

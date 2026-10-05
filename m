Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBEE4DD3AD
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791221227; cv=pass; b=qdSCXWGuSZh0mRqKucVVqeKONc1oKTyMH9MXU6qL28gpMVo9yqd0CA/uITCbXEAqSiLFlmcTWPqLsg0LZb5uxS1qiQ28/JiirlEqJOtIyAUjw5a7LNfa5oDfYelN2T48940/HHnpTLOADUkjEKhZlBuiuDE3DwzjyutV3VJa0HQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791221227; c=relaxed/simple;
	bh=SvNUMArrKWFvoS8qkrww/WErXldZpTTjxx1KfsSc/OM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZ4wB/i4EG+muMlrJodeum9vX2kvjHEk49CP0SDN2CFtH55c5V1Nkn4OwboxLzj1Dmp0WxFIssweautzcs9bXjD6PQn1GXV31RW1vXz2OwSxc9trYclt1UzxccTpr5TPHN4MoViNs/2po6jwzbjVaEjQ+dHDqdwtr1wupHk1x/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T0g7/EXX; arc=pass smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T0g7/EXX"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-35129e4607cso1315959eec.1
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 10:27:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791221225; cv=none;
        d=google.com; s=arc-20260327;
        b=JvHoih4TIyjki/Af263uaASLLeGNLQwcDwI8lav9ZjqmbtYVoEDPesx6tjnzmk/Mlg
         7afk5oMtt4Kc/JRhqg8jiKPZwH0gRGE5qP9NYxgnTOJwG931szreCt1Tk8GRQ5pOtgSo
         bL7+9OCS1QsCg/h4ZCNIyYD8356LcC1EbQQNFa7idW/6/rbS9NBCx1uucrXJCqWnBh7L
         MtyG5jtIXdTfC09ebI6EEnDoTco+qPUvfs0DCSCsIbGdoQM93MYlIuh75plLB2EhIBD8
         55uHJGVE3DOg878oVm3MBDrF8QNxleXZ8ydP1tiLxpEWpKX9mQezkuYr/IuhCrMESiN+
         3nKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0fw8n8AkfovFoqxnTVJMYaNAw3G0Dz3Kg4SbR/EI24c=;
        fh=Cpey1fQH4/mPr8SOu5E/V5E3QXVE76iTSmN/bze6uVY=;
        b=Zux7CF2K5pPasBx4a1MnwpISLRnNum43smnqEqN5k5rphDCxEU2BGVz/OkbmbxL5IW
         Lv4N/Q+ommk6yllJET5qFbFrvq43Tosdh77CW9Qt3wRrR0HMUM5ZYIQnEP/phrmTD75v
         gH9Blz/pwn21/l6LeBNYvwgx/TvlC633cu04elbNiLHGURrvtxDJre7h30f9/IRFKWxe
         rK68/gegKe6ApEMVDzOVXki4GII8GZeF/Jz22y64b21QPqT6OY+5e1g7uAFY7v1dllm8
         52sFjrjU+4q0UM1YsXJIUVNPDZ1cfiGL+XFwJ2yUHPnV5pOcLm/YRDpOmrup9dz+m7yw
         B9iA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791221225; x=1791826025; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0fw8n8AkfovFoqxnTVJMYaNAw3G0Dz3Kg4SbR/EI24c=;
        b=T0g7/EXXJQCgVmzXibOLowcEQ7WA40dWbRs97CM00RCNGcgTAQ6VbtK9Z6ie4q/h1E
         +Zu9T+P3xeV4aViFhKYBn++ARD6K+VOtyayBdbQCoh/QCSJvJXsRrzBi8bM9e41aX3YX
         MHnvsS1SMq/oI8Ml+OX+2CU/v3hM1H3itcYlz4SbePZ0h9yUlUmpj4QU7SZrFve6w+sl
         4AwMlX3To/hSqHzf6XnieFOJS3nnKjbzzTEQpZQ2UsSAYuULHKl2d/9fzIqjsrUz8Yu+
         l2dBh0Vr4Q65dMRSytXGORkC50q7PmJ/pnJ2lV7FvSnjVwndq+2K94+xWPmwp+Yx9Twj
         r7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791221225; x=1791826025;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0fw8n8AkfovFoqxnTVJMYaNAw3G0Dz3Kg4SbR/EI24c=;
        b=nh6dUcURgx++/rXXHYf3BXXGnzGoiBfwQr/Wq7hORLaLmARL+P25uVN93gV+hbYln+
         7UbmsAgIiFJIKr7NKlmvl4KfvMpS747TQMFxXSqLc0uPyz4jPPUD/1xz7vmLu9lNPNMw
         LpzEsTAKGxiCC6zzYRJBD6KG1QHxO4RnS7TPTQcMT6U8Gz5MhH8I+L4qDveLZNWiSFRQ
         qqX7bdkREpnxAUX6GJ4OLZGXNCbX2/Y5b26RxxFEIq9jIWVuGVuBmdG0vlqYI+O4GsnK
         NHNwvS04XpYYcIkBdZPwiZCQ4HrpDwJ25Vzluh/P7R04W+WCPSRblZj2FkSM18074MQe
         xQ1Q==
X-Forwarded-Encrypted: i=1; AKwUvByFZc9dksIT34neXF0AG0mUB+n3Yl/KnYMHl2zcy2t+MhXXrYlMuFEGiXbeYVIRaMWt0wo=@vger.kernel.org
X-Gm-Message-State: AFuF++kopC05UHVOYdGhzj5cZjlVFmlnedPnvyrTFFaSuzw/RGk1OGBF
	bs0/ZIM11IbwT+7HxBSNcm9u5UX8RaZXUymmuqU8NszK3t4cUejFb4ygXUR7FY79cQ6svEAo5Yh
	KZ8/TaH/QWmbtEFLx4x4NxFXmtdFWyROzXlIJ3KjN
X-Gm-Gg: AYBFou2jt7z3IA0Hg0UFyNNuF9gPjcSW7lRkOkm62hol8NnuL/hVjKaAhKCWPQlRLEM
	I6oXxcImu3TcYEdc0VBkczZ5gVgcLc0Hx0SY6xwgv+sqR91R0ZAbBiL4hiLhmNLLval85KXOkHC
	w0TWSS/lorwLuOak2lYczFbWcL9JDw3NW6bipHjVpNn9L8p+Xcqu+mZQpl9/kTTuT5RMvcz/V2k
	Qxu8x7qolAeUyIJjtipuKk6pdRUEj8WEP0ZUrCfWdZu9XMlNO48ali1zd4BtGI0fVbTM2hxEs1q
	U9z4y6WNBXzz+m+DK1NDYTEvgLEtWN6X+09qGnCwCoFnDYLuNNq+VyMd22AQpFqzVyjifxZaMJl
	0vm4OR7eVlTjV1HsLll0cGW6WA6NZTP3jePZHslkp9Sne5BOKMbNrTYqB9KzxKw15FoprG2yJK4
	rNxdL7RPEZOfzyFNAK68CNtA==
X-Received: by 2002:a05:701a:c909:b0:14e:d8ff:1592 with SMTP id
 a92af1059eb24-14f58fd159dmr15279044c88.5.1791221223925; Mon, 05 Oct 2026
 10:27:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005154533.4147685-3-kuniyu@google.com> <7557423d5efced7e3307ed14a4ad8f364246f3ea738395123f61296ac4cc2284@mail.kernel.org>
In-Reply-To: <7557423d5efced7e3307ed14a4ad8f364246f3ea738395123f61296ac4cc2284@mail.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 5 Oct 2026 10:26:52 -0700
X-Gm-Features: AclHuK9EJNuLuqVE4teO2iA_KA3FNBEAYhgOEbqAXbKZ3GJJpU1bqQDO7AsTh4I
Message-ID: <CAAVpQUAkMupUTZpL+-QAwYYG+awade04rNSA6jEWGQ3o5uafvg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/9] bpf: tcp: Add a new per-socket flag and
 kfunc for bpf_tcp_ops.
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	ameryhung@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	sdf@fomichev.me, edumazet@kernel.org, ncardwell@google.com, 
	willemb@google.com, ukyab@berkeley.edu, cleger@meta.com, kuni1840@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, martin.lau@kernel.org, 
	mason@kernel.org, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 9:27=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > bpf: tcp: Add a new per-socket flag and kfunc for bpf_tcp_ops.
>
> TL;DR: The bpf_tcp_ops_set_flags() kfunc filter seems to let cgroup_skb a=
nd
> sock_ops programs call it too, not just bpf_tcp_ops and cgroup_sockopt; t=
his
> is an API scope issue, not memory safety.
>
> > diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> > --- a/net/ipv4/bpf_tcp_ops.c
> > +++ b/net/ipv4/bpf_tcp_ops.c
>
> [ ... ]
>
> > +static int bpf_tcp_ops_set_flags_kfunc_filter(const struct bpf_prog *p=
rog,
> > +                                           u32 kfunc_id)
> > +{
> > +     if (!btf_id_set8_contains(&bpf_tcp_ops_set_flags_kfunc_set, kfunc=
_id))
> > +             return 0;
> > +
> > +     if (prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS &&
> > +         prog->aux->st_ops !=3D &bpf_tcp_ops)
> > +             return -EACCES;
> > +
> > +     return 0;
> > +}
>
> [ ... ]
>
> >  static int __init __bpf_tcp_ops_init(void)
> >  {
> > -     return register_bpf_struct_ops(&bpf_tcp_ops, bpf_tcp_ops);
> > +     int ret;
> > +
> > +     ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
> > +                                     &bpf_tcp_ops_set_flags_kfunc_id_s=
et);
> > +     ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOC=
KOPT,
> > +                                            &bpf_tcp_ops_set_flags_kfu=
nc_id_set);
>
> The commit message says the kfunc is exposed to bpf_tcp_ops and
> BPF_PROG_TYPE_CGROUP_SOCKOPT. Does this registration limit it to those tw=
o
> program types?
>
> register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCKOPT, ...) puts the set
> into the shared BTF_KFUNC_HOOK_CGROUP hook.  bpf_prog_type_to_kfunc_hook(=
)
> in kernel/bpf/btf.c maps CGROUP_SKB, CGROUP_SOCK, CGROUP_DEVICE,
> CGROUP_SOCK_ADDR, CGROUP_SOCKOPT, CGROUP_SYSCTL and SOCK_OPS all to that
> one hook.

Oh didn't know this.  Although it's still safe with try_cmpxchg(),
I will update the filter like this, maybe with CGROUP_SKB allowed too.

if (prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS &&
    prog->aux->st_ops =3D=3D &bpf_tcp_ops)
    return 0;

if (prog->type =3D=3D BPF_PROG_TYPE_CGROUP_SOCKOPT)
    return 0;

return -EACCES;


>
> btf_kfunc_is_allowed() looks the kfunc up in that hook and then only runs
> the hook filters, and bpf_tcp_ops_set_flags_kfunc_filter() returns 0 for
> every program type except a STRUCT_OPS program that is not bpf_tcp_ops:
>
>     if (prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS &&
>         prog->aux->st_ops !=3D &bpf_tcp_ops)
>             return -EACCES;
>
>     return 0;
>
> That seems to let BPF_PROG_TYPE_CGROUP_SKB and BPF_PROG_TYPE_SOCK_OPS
> programs call bpf_tcp_ops_set_flags() as well.  Both program types provid=
e
> bpf_tcp_sock() (cg_skb_func_proto and sock_ops_func_proto in
> net/core/filter.c), and the verifier accepts the returned PTR_TO_TCP_SOCK
> as a trusted struct tcp_sock * through reg2btf_ids[].
>
> For cgroup_skb the likely caller is an ingress program running in softirq
> context.  The commit message mentions cgroup_skb only as a possible futur=
e
> use.
>
> The cmpxchg update keeps this memory safe, so this is about API scope:
> once programs start using the kfunc from these other program types,
> narrowing it later would break them.
>
> bpf_qdisc_kfunc_filter() and scx_kfunc_context_filter() both reject the
> program types they do not intend to serve.  If only bpf_tcp_ops and
> CGROUP_SOCKOPT are intended, should the filter reject prog->type values
> other than BPF_PROG_TYPE_STRUCT_OPS and BPF_PROG_TYPE_CGROUP_SOCKOPT?
>
> Otherwise, could the commit message list the actual set of program types
> that can call the kfunc?
>
> This filter is unchanged through 3cb5919af2b2 ("selftest: bpf: Add test f=
or
> bpf_tcp_ops.{enqueue,dequeue}_rcvq()."), so no later patch in the series
> changes it.
>
> > +     ret =3D ret ?: register_bpf_struct_ops(&bpf_tcp_ops, bpf_tcp_ops)=
;
> > +
> > +     return ret;
> >  }
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/373369=
89320

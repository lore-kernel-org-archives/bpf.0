Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF2F320CD3
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 03:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782187155; cv=pass; b=ZtFF0U5k5zAsfHQt1X8vuVaUXtLGHBvi3Ir06xCxD09JwDzbjT0hpIn5/1l+kGoL1NFlBcnkaxzXP+nPUJBB6LCa4muq8jAQ/R+WID0oUMccHajo/uFhYALJ5LxvKSU7/O7p+0kxGRfSnn2tz4MCBJCB4cFc7CJYSHOrKbENah4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782187155; c=relaxed/simple;
	bh=gG3nM6GM0xXcee7k3sO2+otJiw1n1BGZCjCkgApMqe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bum7orSfIhB/jFBcdfvfOfdyJODB4qKtRboFklU+Rj1ZEJez6Eswz5LFuom5tFb5S2Zp68o9T1ypMiIMY2NNm+un8K+ACsx4NBPFC0ETs1kCvxEtiHQ3aa3LVuOLMZ2pgxRcgUJkASsALfDog2pkMr6xhC6B0TqNltlSXEipxAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayc6Yxc9; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayc6Yxc9"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-37c867bd3e0so2549900a91.0
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 20:59:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782187153; cv=none;
        d=google.com; s=arc-20240605;
        b=hdVAVdVz2g9EK7YxnjWx8Dl+V49HgEpBpUXc9M5kT4uxlbpePuwau0G3wsT7NQ7paJ
         /Bd8BuXZ0cBaXDW8eVf8y/dB5pkYzAUvskN/iUQafe7WxvK9s1V1ONoYl2dcynrm0hRZ
         oigdG2JR7ao6YsWMDccAwpsPbUqJFoDDNgqwxrLNPFnrgVGoruhcw8nZLslJfWHLPtNj
         ursBZsq7EE0oXrKBflaizKqL90x9HpQowhM0h8JwdXW4ES+nIsMhSZLJuk5QaaKE6fd2
         x0gGFB3JqvEUhcqbAGTb5COfEmiSBiHE5Bd3fnp2j0I3S4K8TLlld6EQPkTnvw8orskG
         nAKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fv4+YQzwW9vJ3yUowssNEEOn5d5CfHMnYf5q6sRM4Aw=;
        fh=z5gR84X8Qfu4k2Ols1OaTlVgh+OG2vUt6z90Ik/REQI=;
        b=VYv+UnRhpltyrtA+mEpk2TsRYJkZmsWxtyPWpqKMfXaSJBd6FeTP3Iq0Bxoc5M95DI
         JLZNS0dEgtonZk6Qe0BZS6pj0xG5SJhDMCrgPY5DgwdRfG7p+lSxdlVxSmeTxZHRXSBc
         8oV35O6ffMXMrlMma3t99PCh0+CEgTds92MjzJZOEHL8T0WBMLTFYb144iUL5Tmj2vgl
         VHSUZrh77izKqDBoU87JTW+Ei6vM1dsWmggWUPF8p6Ga7OxxyKYWWQfy99BHJVefyhSw
         UyeJMeh6SxLnGpHRq4Z0VgYJx0L7XDpABMlzNlVW8cXCatixfiLQAVEfX4lnUIp8IbJ3
         ksSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782187153; x=1782791953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fv4+YQzwW9vJ3yUowssNEEOn5d5CfHMnYf5q6sRM4Aw=;
        b=ayc6Yxc9BZ+MZUTfJWUjsUjR6/AmNZnL8Egi5GytMU1FqCvZDNwOE7s9xkQgfiztdR
         nn4jlG1gEP78vF/wMFDw8ZTiKMBvy6GjmBy58WtRFUjFfG2V+u5XAAY7w46Umife8eo4
         qgQIM+1syaO/b2udQFkxZ7jSfGNGACFkI2L+6E0oZqfxuHmPaMTbJHenO6rubQThlvf6
         IDKcvkU59HSHmQBC4k2UWtPEk2TmMMqqQhgwttGAdhfDFjuCbbnKbl/0gH7QzexsqcgP
         d0WhSZcBajAwY5rIT2/lcz1WT6GLNYVvfcU3GF7DH7yfScHes7q+viapvK0ytMpyzOXI
         YRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782187153; x=1782791953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fv4+YQzwW9vJ3yUowssNEEOn5d5CfHMnYf5q6sRM4Aw=;
        b=JbNw3pEHFSr1G4oFw0V/CKSFwVMAE6F0o/5uejbX4diByA3HZVcEfdpjWJoeFsTBP5
         Y1EWnH6yIFn92GKC1dpyV+i9UkjJDThq6fHZK3g8juf29fA0Al1RdbA21/+o8OCUkkJ8
         MxBcHijisAqczks1U5Wk4u0s55w/Zei/xHO4isTlsCb5mL8LHyAwNEO9kqOrhdr3fTMp
         aGbDd1g3hZ53RpWl5s+Ij53nj/nO5YiCLqtiy2ONiCIk1BW4j4ZOMoWV50rUicvdU5at
         CuieJPfh8OaUshT9H1ZId+7KGnarQ47pId2Chu0KiE3Xz1ayvz1DZEVc7lw7l/qmydNc
         HpRw==
X-Forwarded-Encrypted: i=1; AHgh+Roy5X2LmuHcJLsH7dzGPx3ks7JQ9PLaN0JdD04aVfjGKCAjlQMeNmvwssxNF+2ogzSixa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAIcK8TME5ngjrkPJTPDdIXttWXdJkZa4tlVJw+/sJ9Zm9xv2y
	dIh7CJ26sBmx4Fv9ACQR1amaqI4KJHD4uQW6WXJN0lX32vuKKntoRQ6vomvQJGq5KuysRbWoarD
	6D9LPudK10BFdjcFGRdYc2fNCnCWvgFQ=
X-Gm-Gg: AfdE7ckhfFpq7+zR6hipk3xlWUrVM8iPlQ8WZ7cB0XmTtT/kAJQhA8a8KLoNU4SMd7a
	4adyxYNORH+k90Sob3/TWN2N7IVxrvQjTAesvTYuy/JxoezF2bp7M3qr8unenVS8rsOfX86qsaO
	mLeN2bs1r7nCWcxxRy6JU6c6Np5vc17YNzyXMxw7XMX2385EDDZdCDf2ZERz+smmK4/0sYeIXYE
	kibZcd8xfAuPlpqg2DdaZ2zcww0PePlkdmhwdo8vWpiQ9xrvHCCCJqGm/4fKTwIjd8GBrhxOX3j
	zSwHV8F2v7xpyDbyXBy4mTbvTjKuc4tIW/ABSKwlejZPsCj20/DGpx8o/3X59dBWMlpiZL0rISu
	p0tCOZyAGkq+QmA==
X-Received: by 2002:a17:902:db04:b0:2c6:bb31:4564 with SMTP id
 d9443c01a7336-2c7c9ae9c89mr6495325ad.34.1782187153306; Mon, 22 Jun 2026
 20:59:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618203411.73917-1-dwindsor@gmail.com> <20260618203411.73917-2-dwindsor@gmail.com>
 <DJFZGYZFMN73.1799LMXW49WZO@gmail.com> <CAEXv5_jVXS4JoExcd71YkXEE2WXPJ0_9STO-uCwgNF+Eia_h5w@mail.gmail.com>
In-Reply-To: <CAEXv5_jVXS4JoExcd71YkXEE2WXPJ0_9STO-uCwgNF+Eia_h5w@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 22 Jun 2026 20:59:01 -0700
X-Gm-Features: AVVi8CcolJU9x8Dp8q7P56rN1jCQzLpqqLG-VPMeXHQRVjQ7aayUcNcv-uHuUCc
Message-ID: <CAADnVQJsdrL2RjxM4UE1WyWrT9KsprFP+=xLHRtFhUSccDqQcg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: David Windsor <dwindsor@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	linux-integrity <linux-integrity@vger.kernel.org>, selinux@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 8:49=E2=80=AFPM David Windsor <dwindsor@gmail.com> =
wrote:
>
> On Mon, Jun 22, 2026 at 7:57=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu Jun 18, 2026 at 1:34 PM PDT, David Windsor wrote:
> > > +
> > > +static int __bpf_init_inode_xattr(struct xattr_ctx *xattr_ctx,
> > > +                               const char *name__str,
> > > +                               const struct bpf_dynptr *value_p)
> > > +{
> > > +     struct bpf_dynptr_kern *value_ptr =3D (struct bpf_dynptr_kern *=
)value_p;
> > > +     size_t name_len;
> > > +     void *xattr_value;
> > > +     struct xattr *xattr;
> > > +     struct xattr *xattrs;
> > > +     int *xattr_count;
> > > +     const void *value;
> > > +     u32 value_len;
> > > +
> > > +     if (!xattr_ctx || !name__str)
> > > +             return -EINVAL;
> > > +
> > > +     xattrs =3D xattr_ctx->xattrs;
> > > +     xattr_count =3D xattr_ctx->xattr_count;
> > > +     if (!xattrs || !xattr_count)
> > > +             return -EINVAL;
> > > +     if (bpf_xattrs_used(xattr_ctx) >=3D BPF_LSM_INODE_INIT_XATTRS)
> > > +             return -ENOSPC;
> >
> > This check is good to have, but it's enough. No need to duplicate it.
> > More below.
> >
>
> > > +
> > >  static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfu=
nc_id)
> > >  {
> > >       if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
> > > -         prog->type =3D=3D BPF_PROG_TYPE_LSM)
> > > +         prog->type =3D=3D BPF_PROG_TYPE_LSM) {
> > > +             /* bpf_init_inode_xattr only attaches to inode_init_sec=
urity. */
> > > +             if (kfunc_id =3D=3D bpf_init_inode_xattr_btf_ids[0] &&
> > > +                 prog->aux->attach_btf_id !=3D bpf_lsm_inode_init_se=
curity_btf_ids[0])
> > > +                     return -EACCES;
> >
> > This is unnecessary. Only one hook will have xattr_ctx type.
> > The normal verifier type enforcement will do its work.
> >
>
> Good point, thanks.
>
> > > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > > index 1a721fc4bef5..b41b02173e24 100644
> > > --- a/kernel/bpf/trampoline.c
> > > +++ b/kernel/bpf/trampoline.c
> > > @@ -859,6 +859,9 @@ static int bpf_trampoline_add_prog(struct bpf_tra=
mpoline *tr,
> > >       }
> > >       if (cnt >=3D BPF_MAX_TRAMP_LINKS)
> > >               return -E2BIG;
> > > +     if (node->link->prog->aux->attach_limit &&
> > > +         tr->progs_cnt[kind] >=3D node->link->prog->aux->attach_limi=
t)
> > > +             return -E2BIG;
> >
> > No need. The check inside kfunc is enough.
> >
>
> Paul wanted this check because it occurs at bpf prog attach time,
> whereas the one in the kfunc is at inode creation time.

Sorry, we're not adding redundant code to the verifier.

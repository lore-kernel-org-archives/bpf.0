Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEFB221726
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771875345; cv=pass; b=XkuCEISyBwFHempN2e/Z9lGTERgp2u0UYPz328QH7p6QoJMHWLy0u4sQnn76IS1ABN3ktIzxm4UyknKoFBAT1y5zVC0pc6AONFzEPpP5wVKU5k6HYjBVohJrBC0V7kwvLKxPKdbs9FIM3u6uiuw38WDNEKr9JdtZbnB3AGwPqys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771875345; c=relaxed/simple;
	bh=axPKsj973CJEnsqXW6JO5OGkwmZLoejWq3/4vMg+PHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fmjVP1W83Ou6LaOe6UpTIGza41/kyh71Gdut2//zl9Fi7zDsV8Xt+q4S3zrAx5A6CHu2Si+PriYRZCBq0GELX70ImeAYhTam6PdCYHIzRwws+pfdUb3QKYShtmCfTvJQ6e2vCIHIJuOzcMkrMGF2e7QRQ0alImXwjkr5lsEVn0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkXHs/PV; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkXHs/PV"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4359108fd24so2924892f8f.2
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 11:35:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771875341; cv=none;
        d=google.com; s=arc-20240605;
        b=SGV21ReG6+dkUXGhcjx15FhtgO7i0yCJScAD00G1gBISAN7W766U8/lGFxNhk2ikRb
         YFucej3fzc1SkJI6Wl9nXK/Fl+SXhOdESiaMHD/n1lZCxgcTGC63MkESMb8DQW090BLz
         Lf7jXjeMoiKvFDMura3ZElSrMAB02ogmOSVC9ixQAuLFoLlmuwOBvHsNNnTKKoiBSOx1
         h+Glat3ab2Ty/IsXwOtdarmYbzSOQzey5OOuzu1JkQzqqn+bMs4e9l5DN5DhbjtK7hwS
         jvWtkstRjmCxf43ay35BHcu87Cs1uJuLPkJ7YJlDjTB4XZ+EDgFrMwHGTccu6jotQsRM
         bVXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MBHq3GUoAOL0w6S711awWfpqNru5IpSsWmVFqqx/NGE=;
        fh=xurMgHsUwzR9+N2vE2Tw20HHVFVZxj9KfU7TvlUK79M=;
        b=bjOHhF8cNjyfVTmGRv8Nx6h8xzd3OEBP9JFCWb4X+wqG0yS0VAidrMyH2ec4fsEz/3
         U93QdAyoFH7AyofXR5iRMDJFuwDry8hc77kd/7dADkS+XPtVZZyropD6VJnUDs2QoC7V
         XF6/YjOJiHEJJ5OOmBI+246CXsaQI0RW2PKP2ilISE0W1eSu7DhTSUFrLpFPSnc9RWug
         n6kn2YiHz4DFuSu0AmgipAOMexigSTb4AUiCgz+jJ1O2cHpI81G94lX5IdCJPfiAByoY
         Ods2uQ9wsPBH3FiYxtJI/5WFakohUqS6W3PrscMnfALkwRAvRt4tY3GO4vgla5lO0WXF
         yXcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771875341; x=1772480141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBHq3GUoAOL0w6S711awWfpqNru5IpSsWmVFqqx/NGE=;
        b=UkXHs/PVkUBHkVYAv7JRvfAqkX+EdQmgAQsp/+c63qBkNyPsmaFXe9OKSdBLP5x/jk
         kEXYrqFju+cbkM5CSRapouhOz+h9Q6uPXLuCfYSd9e4iaZ22wKA56+DX5yKv/ePmj+HL
         CiAnGMEHr4y9a1EwrE8SGVcccibnX9KM5JbTlM4lHBnVHPAiu3gEMaRBkXS4Lur3qee2
         bOcQiIhwlTlsGAANkpudi5U0kYO7UpwfmdtRBn13kk/0pfkmX39bqY1nt2kSoE8/wPpv
         qvgzVMXl9nN7zC10X6Ygt/uYxSZjkf0S8Zg6ZwurTWjth7LkLwN6egBRvqHPUIOGMZ19
         lGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771875341; x=1772480141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MBHq3GUoAOL0w6S711awWfpqNru5IpSsWmVFqqx/NGE=;
        b=NMYML/CjsYexgVT0dGrxg1IGAz01JeegJZp22DESqEq1d0xnnf09xuTM7eIVfUv3QI
         GNqyixqlLwzBOdPaJZuoMdS17vXO1995Ga7Rm916lv2ayWJvxAorkdAFkQ9qF6NaXXJC
         xoumwJGpOpV8rRFBPiULc0l2gK8Sh4lOV1rKrqupTrYYdFgRFPt7z+2RDDRvzbqj7zfQ
         Hg8WCUhB7VnIDwYZGPkHU4P7I9IMXLES43VhHBH/WnPof1kfP0Dj+3bWv4m6a9Y+WlKH
         k/Tlhs8VsOcn/WDI5CqT/Ja4xlssfIcyKgpCnjknM3zEZhcTebRAerpxnhlPKG5+7Txk
         xRRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgD2K4vHg3jieFdBnMsAkbDQb9trJuuHBoNRTA5BjTltaBRQWEAOyLhBc8BvhmhK0wS3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZtQUxiJIBZiW6qGOFkSJL0gXRQa01nRHMo7EXc9PsF625l6V3
	i74JkmQuAEyN/YQ5bQkWAzqOUaYSKFe4eRQG70MFfXHVKHopmTwtc3nlbBsh5cq4Pnn93X/mfkY
	YPOiCE7MQ7SsWYfGWGe9MjpgdlBd0xkc=
X-Gm-Gg: ATEYQzwha+aYUMFf5PjnHuzt5kBKLg7bJOqdRuzP+lFoafeMpIFxOESQRDVQkJuvXuI
	GA9ceVFbaGwVjXbT/Qd8E1WduLhDSbyK9uMLvNnPzNXL47nIH5BsKQtxdU80CM42UrIYcZeL3Eo
	xa2khwE7t1bRbklRuaD7FUBErDGTTgLy5jF1BkdypOLTLVsO7tymZmhborMNeUhF+EIldq2y9fj
	8WuPo6QqwI1VDgL3to0EpSjqWPyiOITZ5VRDAPbi8WxSn9d70M9KM6fk9YKK78KHBEtxgoivQ5t
	tR5VTVTcAnrAfk85bfExdIiEQKhxss6itSFXg3br7ZoFQEltFCdiFhZu+jCdN2hmC1XlPTjLbZ2
	44+BM6iH/
X-Received: by 2002:a05:6000:26c3:b0:437:67b5:9bab with SMTP id
 ffacd0b85a97d-4396f1954b4mr19136260f8f.56.1771875340626; Mon, 23 Feb 2026
 11:35:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220100649.628307-1-jolsa@kernel.org> <20260220100649.628307-3-jolsa@kernel.org>
 <CAADnVQ+2-DtgWqeKmrbsP0O7Rz2ZkDjkh1kfHDSxF0K8Xs+1ww@mail.gmail.com> <aZsT6_3tkli3SPsI@krava>
In-Reply-To: <aZsT6_3tkli3SPsI@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 23 Feb 2026 11:35:29 -0800
X-Gm-Features: AaiRm52XzWV142EilgaigHV4dPqGxP7EWSSexa4oS_s3WmGsUCX0T2Q1_V9DwOI
Message-ID: <CAADnVQL_Jpe_7a55HTn5CyYoxWcHahiK3+CDeOeURqZAuf+teA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 02/17] bpf: Use mutex lock pool for bpf trampolines
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	Menglong Dong <menglong8.dong@gmail.com>, Steven Rostedt <rostedt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 22, 2026 at 6:34=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Fri, Feb 20, 2026 at 11:58:13AM -0800, Alexei Starovoitov wrote:
> > On Fri, Feb 20, 2026 at 2:07=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wr=
ote:
> > >
> > > Adding mutex lock pool that replaces bpf trampolines mutex.
> > >
> > > For tracing_multi link coming in following changes we need to lock al=
l
> > > the involved trampolines during the attachment. This could mean thous=
ands
> > > of mutex locks, which is not convenient.
> > >
> > > As suggested by Andrii we can replace bpf trampolines mutex with mute=
x
> > > pool, where each trampoline is hash-ed to one of the locks from the p=
ool.
> > >
> > > It's better to lock all the pool mutexes (64 at the moment) than
> > > thousands of them.
> > >
> > > Removing the mutex_is_locked in bpf_trampoline_put, because we remove=
d
> > > the mutex from bpf_trampoline.
> > >
> > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  include/linux/bpf.h     |  2 --
> > >  kernel/bpf/trampoline.c | 74 +++++++++++++++++++++++++++++++--------=
--
> > >  2 files changed, 56 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index cd9b96434904..46bf3d86bdb2 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -1335,8 +1335,6 @@ struct bpf_trampoline {
> > >         /* hlist for trampoline_ip_table */
> > >         struct hlist_node hlist_ip;
> > >         struct ftrace_ops *fops;
> > > -       /* serializes access to fields of this trampoline */
> > > -       struct mutex mutex;
> > >         refcount_t refcnt;
> > >         u32 flags;
> > >         u64 key;
> > > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > > index 952cd7932461..05dc0358654d 100644
> > > --- a/kernel/bpf/trampoline.c
> > > +++ b/kernel/bpf/trampoline.c
> > > @@ -30,6 +30,45 @@ static struct hlist_head trampoline_ip_table[TRAMP=
OLINE_TABLE_SIZE];
> > >  /* serializes access to trampoline tables */
> > >  static DEFINE_MUTEX(trampoline_mutex);
> > >
> > > +#define TRAMPOLINE_LOCKS_BITS 6
> > > +#define TRAMPOLINE_LOCKS_TABLE_SIZE (1 << TRAMPOLINE_LOCKS_BITS)
> > > +
> > > +static struct {
> > > +       struct mutex mutex;
> > > +       struct lock_class_key key;
> > > +} *trampoline_locks;
> > > +
> > > +static struct mutex *trampoline_locks_lookup(struct bpf_trampoline *=
tr)
> >
> > select_trampoline_lock() ?
>
> ok
>
> >
> > > +{
> > > +       return &trampoline_locks[hash_64((u64) tr, TRAMPOLINE_LOCKS_B=
ITS)].mutex;
> > > +}
> > > +
> > > +static void trampoline_lock(struct bpf_trampoline *tr)
> > > +{
> > > +       mutex_lock(trampoline_locks_lookup(tr));
> > > +}
> > > +
> > > +static void trampoline_unlock(struct bpf_trampoline *tr)
> > > +{
> > > +       mutex_unlock(trampoline_locks_lookup(tr));
> > > +}
> > > +
> > > +static int __init trampoline_locks_init(void)
> > > +{
> > > +       int i;
> > > +
> > > +       trampoline_locks =3D kmalloc_array(TRAMPOLINE_LOCKS_TABLE_SIZ=
E,
> > > +                                        sizeof(trampoline_locks[0]),=
 GFP_KERNEL);
> >
> > why bother with memory allocation? This is just 64 mutexes.
>
> ok, I could probably use __mutex_init directly for static key
>
> about 64.. not sure how I missed that but there's lockdep limit for
> maximum locks depth and it's 48.. so we'll need to use 32 locks,
> which is probably still ok
>
> >
> > > +       if (!trampoline_locks)
> > > +               return -ENOMEM;
> > > +
> > > +       for (i =3D 0; i < TRAMPOLINE_LOCKS_TABLE_SIZE; i++) {
> > > +               lockdep_register_key(&trampoline_locks[i].key);
> >
> > why special key?
>
> if we keep single key we will get lockdep 'recursive locking' warning
> during bpf_trampoline_multi_attach, because lockdep will think we lock
> the same mutex
>
> there's support to annotate nested locking with mutex_lock_nested but
> it allows maximum of 8 nested instances

yeah. subclass limit of 8 is there for a different use case.


I guess you never validated your earlier approach of "let's take
all trampoline mutexes" with lockdep ? ;)
MAX_LOCK_DEPTH is indeed 48.

See fs/configfs/inode.c and default_group_class.
It does:
                        lockdep_set_class(&inode->i_rwsem,
                                          &default_group_class[depth - 1]);

the idea here is that the number of lockdep keys doesn't have
to be equal to the actual number of mutexes.

I guess we can keep a total of 32 mutexes to avoid making it too fancy.
Please add a comment explaining 32 and why it needs lockdep_key.

I thought declaring all mutexes as static will avoid the need for the key,
but DEFINE_MUTEX doesn't support an array.
So since we need a loop anyway to init mutex and the key,
let's keep kmalloc_array() above. Which is now renamed to kmalloc_objs()
after 7.0-rc1.

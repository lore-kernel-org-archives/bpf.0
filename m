Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DDD2FE582
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 02:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785724166; cv=pass; b=CJ59mUgKU57OOeiAI6aPBsJHeNxMvPjXt49yzPPJq867LmbpvZXAHh3SUkmoxkDSLbOIIIYkE/1wdVF9FnzKCRwX/uXFkaNThwy4qxskU9z4MKYTf/KMzFPE4RLUnHt/r8XlAbh4fccmzj/JNdQIo/kegtVLgjTzVkLDE3X2GBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785724166; c=relaxed/simple;
	bh=6BKo6a/fZZgSNwGYMaNu4yAY6/Dm7GkFusN13Gumcu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hR7BScrEgDfnH92T44GJIMEidwcu89NgMBhPKctFoy5sLeW8yRcBJMukjS7KiqkgVaMVrCXu2ZeaCcyLcYL+rw1oI/HhcSoGIFy/7/INNegtR5AKmX/XxT9UsA3oPO7B/cEztB7CCn695upiqpcdRb290PqXK4Jc6By8ThHKiX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8YvpmWS; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8YvpmWS"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aeb8c19017so3899560e87.0
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 19:29:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785724160; cv=none;
        d=google.com; s=arc-20260327;
        b=reM0CpBitYlq3dvDDgcioNTWblcKmgXWQfrUn7sy9KsqodcO1zYZy+QQuAJ5+TaqPy
         TTr5PWne/oPAU0QryDPvGQHbeVOVzi/MJbZYZ9dIQbGEHsQU/Pw8OUKppYwbbtGDnpc5
         JZrp7yPm82MwXhcDyzPvb9zYeGvxo82Z4YIuIocBfJl+LbBV06dkXqdlhZT48i3UUf5y
         JR9xkFWfuPKujMxueOiXiJ3f72Ng5HKWPJ5Rm3kUErun4vEnxqRjJjH3ByJaR0zxqLEA
         2zmT5KxQC9bKXaw5P5ZljQ6E7nDad9cL5jRthY3W8YaePSu3Z3sCj39HY1UnvXyM/fnG
         YQKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yVhihwITAfz3n4uJB5RhPmF2OZxrlKktDDWd4HN0PXU=;
        fh=6kUPJ+GxVgkMUEPRCVk9068npD6yStNJr5jsFlmn7Fg=;
        b=qdK45Am/zu8uLKbsDD7CUMwIYIUEV4AO1Pqx529O4PVLGRXbxxGhX+IB4F9LQHrZJO
         MfduUsjAGVJ/kxJHAl1QrwgkejwdOQRsALWQEs1aGou3VlIgMhkJBU0u9T8zUbOH1G6x
         lbMfs6GgL5hIT9CQpWsb74a11ZG4FPeLNII0OYV48Ejm2unononuMQVOwy3T2d3mCeDm
         gXTpI97Ny/JKzgwAIzNk36iI+orcBd+Rx3K8jHluOvVc/0nObKzx/iN2+hGGJ6Wb13BK
         un8ozT1VEB27Qjnb68SN2kXjFJfeVGCTL0T7VNA2drz71XVdtYCPuYKyySxiJzWclsY4
         BOOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785724160; x=1786328960; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yVhihwITAfz3n4uJB5RhPmF2OZxrlKktDDWd4HN0PXU=;
        b=f8YvpmWSB6W49+J7o8rVOxTJ5sDwDnAUMyTIHUkUNAjyK/E7iF44FrCBZr3iSbR9Br
         OtbTIWd9nLlnR+DvosjDtKvT6QWaJkq6t27N/g+PFZVmqqIBbCW1jFMbezAmVUSkMT1f
         7Z/D0Jly2H4+2ZQP99Hi7DV9ZG9PEsXpBft5R+++b1o2GVx/6A+aNe+oo835/LQKjzjP
         mYR09zuogm47sQ4bjnhNj0AjR3v4XbGaw6mKvLw5hITyARCV88su/ZqsitOYAuNnXnv0
         r4uLrID9ECSiVWRmoPLe8FiVPT5zZLt2IVNUZdk7M+Gr9D2+JXZ4Mh+XEaI2GriLIO4K
         4g5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785724160; x=1786328960;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yVhihwITAfz3n4uJB5RhPmF2OZxrlKktDDWd4HN0PXU=;
        b=A7dnsTOQhYVScLYmQ5GvHm67OpBYsA5k8IEl73qNcEAjIsWjMrmWkyUfrWikL0E7bN
         Pwvb3jg/FUBIa+aPDzAQWR8AyGEgmUTUJ6JFE4Px0ZeOMopePuhYveW6raazNisyeaYk
         9c91tGEEpXsCSOe3Ho0GJ2MxYrQQuEXFPNVTH6rXneHttyNvZ1OL69UO3VC04nG15qE+
         sXRnb5u5QCg52qsvrB/tjal1Dy3qpEozxkGyJ9ekFd3oo7tWPDNO2zt+tmHd3FYrjAx+
         1bfgEl0eBlygfzTiM3Z8a7bg03CD92mz9pyg/YZaiNUDClywhNNvg/aqWKPWYNs4kPWN
         57TA==
X-Gm-Message-State: AOJu0Yzs29BxVtb1/8r2g69BOdVNvafvg+GH+GyM3bNx5wrloMCgx6C7
	sNdqFb//kJUb1wS9fDAAiwxmW5jia97Q7o6+eCz8eC79Uq68o95GSncYrl2dZsOux8n809JejGX
	pwEaHgLACWorZ31hNxlgkOKZGK/b62vo=
X-Gm-Gg: AR+sD13tjafYPoHeHgpjkZ1n0m+7eT9pzHCNbk+GU6L3vTFDUA54mlgtS+WZCa7uPC9
	sfGKdQTJLZsqcFPkQavJeiACEIxRV7e61caSOHI0NDesyS+5szTciJD8MfNDpvmcRKGUPP3RstG
	AKE4+bTtJDPIRX07VMdursD2FO6TFbZOT1H4jkET6mAGTrdsyhpN/+tuhFFZ1TW+Fx9a7p85pzN
	fO5HoMuMCjpYfxBbnolXE2tNJh39FQQtn5pyiQO7e2SnLzl2GFgqOiNgDMSMCQtAAwifDJxUoaV
	8GarAmMa+g7/eF4eWPBhZmUeUAdHc8987vltece5hkk=
X-Received: by 2002:a05:6512:61c1:10b0:5b2:a3a3:f8bc with SMTP id
 2adb3069b0e04-5b2e4f34600mr1078603e87.24.1785724160105; Sun, 02 Aug 2026
 19:29:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726021304.97ED91F000E9@smtp.kernel.org> <20260728033837.1466123-1-dingning04@gmail.com>
 <DKEUME1DRKOR.2R2XVNQDZKVSR@gmail.com>
In-Reply-To: <DKEUME1DRKOR.2R2XVNQDZKVSR@gmail.com>
From: Ning Ding <dingning04@gmail.com>
Date: Sun, 2 Aug 2026 19:29:08 -0700
X-Gm-Features: AUfX_mwEwpHI-i2By8EjhZXHPmcGr0Ttv7R6KbGsYZWY-jR3VTn86BzlSh-gME0
Message-ID: <CAJP4iuumoLdD62rXf=3HexiKVoKbXHJka7tm9+Cw-LaKmuvC+A@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Reject writes through untrusted allocated pointers
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, eddyz87@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, shuah@kernel.org, 
	danieltimlee@gmail.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The existing PTR_UNTRUSTED branch is after the access-permission
check. It only handles the case where we propagate the PTR_UNTRUSTED
flag to a field pointer loaded through a BPF_READ. For a direct write
such as res->key =3D 42, no pointer is loaded and that branch has no
effect:

my_child =3D res->child; // in that case, my_child will be marked with
PTR_UNTRUSTED, that is what the existing PTR_UNTRUSTED do.
res->key =3D 42; // The existing check doesn't handle this.

On Sun, Aug 2, 2026 at 4:32=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> On Tue Jul 28, 2026 at 5:38 AM CEST, Ning Ding wrote:
> > A kptr loaded under an RCU read lock has MEM_ALLOC set. After
> > bpf_rcu_read_unlock(), the verifier marks it PTR_UNTRUSTED, but
> > check_ptr_to_btf_access() still allows writes because
> > type_is_ptr_alloc_obj() ignores that flag.
> >
> > Reject writes through MEM_ALLOC pointers that are PTR_UNTRUSTED. Reads
> > remain allowed and are converted to probe-memory accesses.
> >
> > Also skip the owning-reference check for these pointers, since they no
> > longer have a live reference after leaving the RCU critical section.
> >
> > Add verifier tests for the rejected write and permitted read cases.
> >
> > Fixes: 503e4def5414 ("bpf: Replace open code with for allocated object =
check")
> > Closes: https://lore.kernel.org/all/20260726021304.97ED91F000E9@smtp.ke=
rnel.org/
> > Assisted-by: Codex:gpt-5.6-sol
> > Signed-off-by: Ning Ding <dingning04@gmail.com>
> > ---
>
> Same comment for this one, split kernel and selftests into separate patch=
es.
>
> >  kernel/bpf/verifier.c                         |  6 +-
> >  .../bpf/progs/local_kptr_stash_fail.c         | 58 +++++++++++++++++++
> >  2 files changed, 62 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 7aa47342dc65..24c151ad2e62 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -5804,13 +5804,15 @@ static int check_ptr_to_btf_access(struct bpf_v=
erifier_env *env,
> >                * program allocated objects (which always have id > 0),
> >                * but not for untrusted PTR_TO_BTF_ID | MEM_ALLOC.
> >                */
> > -             if (atype !=3D BPF_READ && !type_is_ptr_alloc_obj(reg->ty=
pe)) {
> > +             if (atype !=3D BPF_READ &&
> > +                 (!type_is_ptr_alloc_obj(reg->type) || reg->type & PTR=
_UNTRUSTED)) {
> >                       verbose(env, "only read is supported\n");
> >                       return -EACCES;
> >               }
>
> There is a PTR_UNTRUSTED check already earlier in this function, why is t=
hat not
> working or not enough?
>
> pw-bot: cr
>
> >
> >               if (type_is_alloc(reg->type) && !type_is_non_owning_ref(r=
eg->type) &&
> > -                 !(reg->type & MEM_RCU) && !reg_is_referenced(env, reg=
)) {
> > +                 !(reg->type & (MEM_RCU | PTR_UNTRUSTED)) &&
> > +                 !reg_is_referenced(env, reg)) {
> >                       verifier_bug(env, "allocated object must have a r=
eferenced id");
> >                       return -EFAULT;
> >               }
> > diff --git a/tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c =
b/tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c
> > index fcf7a7567da2..d7b8cd6458bb 100644
> > --- a/tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c
> > +++ b/tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c
> > @@ -8,14 +8,22 @@
> >  #include "../bpf_experimental.h"
> >  #include "bpf_misc.h"
> >
> > +extern void bpf_rcu_read_lock(void) __ksym;
> > +extern void bpf_rcu_read_unlock(void) __ksym;
> > +
> >  struct node_data {
> >       long key;
> >       long data;
> >       struct bpf_rb_node node;
> >  };
> >
> > +struct plain_data {
> > +     long key;
> > +};
> > +
> >  struct map_value {
> >       struct node_data __kptr *node;
> > +     struct plain_data __kptr *plain;
> >  };
> >
> >  struct node_data2 {
> > @@ -31,6 +39,7 @@ struct node_data2 {
> >   * [35] TYPE_TAG 'kptr_ref' type_id=3D34
> >   */
> >  struct node_data *just_here_because_btf_bug;
> > +struct plain_data *just_here_because_btf_bug2;
> >
> >  struct {
> >       __uint(type, BPF_MAP_TYPE_ARRAY);
> > @@ -82,4 +91,53 @@ long drop_rb_node_off(void *ctx)
> >       return 0;
> >  }
> >
> > +SEC("?tc")
> > +__failure __msg("only read is supported")
> > +long write_untrusted_alloc_obj(void *ctx)
> > +{
> > +     struct map_value *mapval;
> > +     struct node_data *res;
> > +     int idx =3D 0;
> > +
> > +     mapval =3D bpf_map_lookup_elem(&some_nodes, &idx);
> > +     if (!mapval)
> > +             return 1;
> > +
> > +     bpf_rcu_read_lock();
> > +     res =3D mapval->node;
> > +     if (!res) {
> > +             bpf_rcu_read_unlock();
> > +             return 2;
> > +     }
> > +     barrier_var(res);
> > +     bpf_rcu_read_unlock();
> > +
> > +     res->key =3D 42;
> > +     return 0;
> > +}
> > +
> > +SEC("?tc")
> > +__success
> > +long read_untrusted_alloc_obj(void *ctx)
> > +{
> > +     struct map_value *mapval;
> > +     struct plain_data *res;
> > +     int idx =3D 0;
> > +
> > +     mapval =3D bpf_map_lookup_elem(&some_nodes, &idx);
> > +     if (!mapval)
> > +             return 1;
> > +
> > +     bpf_rcu_read_lock();
> > +     res =3D mapval->plain;
> > +     if (!res) {
> > +             bpf_rcu_read_unlock();
> > +             return 2;
> > +     }
> > +     barrier_var(res);
> > +     bpf_rcu_read_unlock();
> > +
> > +     return res->key;
> > +}
> > +
> >  char _license[] SEC("license") =3D "GPL";
>

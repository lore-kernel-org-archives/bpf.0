Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE539381AF
	for <bpf@vger.kernel.org>; Sun,  8 Mar 2026 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772980170; cv=pass; b=CqRom/roiwRzVTIJhqLhUga68BICvX2wrwYw7+jIcwrYe+kIxugif9EuW/Ei6v9/0t3uLzW2W/Zt8zIO6oRwLlvnoAkgjmqHEHJ/2b3ybLwq8iz6sOlhLZQ15JrABXgSCJsg/IoZjbykvAf5stdsRaDlqAHl1NhZ8YGwen0p6O8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772980170; c=relaxed/simple;
	bh=y/N//R5WtdXTMgX0UCXLyYbN/1JK8lgXJrqU9YO39vA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZfJs+/gs5AjAY0VbGlzhHopdd6fKcOOdGPSGV3goRG18K7s9fXMjDCoS0zeKN45uLIWMfVGSwGT+R+thZznLfzBKFWewZ2M6Ukq39LTUiFGiMqd7opK0Lahz+vp7pzR33Y5eQ2RzzqMeGOCyLadx2mcObJ/GxRgWzaGSkp5BteY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnOtK7mY; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnOtK7mY"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8299f1ca86fso985848b3a.0
        for <bpf@vger.kernel.org>; Sun, 08 Mar 2026 07:29:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1772980167; cv=none;
        d=google.com; s=arc-20240605;
        b=lDawKf//D0PN7gaf9PPioO3EqIrmg4oA0gykGG8/D79aHj466Q8gEemstejYKpK4zQ
         KE7V9CeIiIdbJip4t4hGN1KevcARTjLB3io6WIdGIHBWW1LoalzMi4VT+zWCGjPzCU2L
         wi8aF5ui/0NwLlUZqzME18WY7rOZayMpVC1wAruZvEFKOaQR8HzFG6JklOpG+5K9Ez5i
         BqVAAEHOQhfzb1b1Z8L1qaHgk5TIpWnTsEIQtVdOokLCmWF8j66z4U6+2Sz/B5Ccrbsv
         jmDoTQwHiMuwsSioIt7Gfe8oK6YUtlWeepiT6JsmWxubvUQmYj7cZ+5hF0ppYfEWebjd
         W4KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z/6NrBvBmwsDMU9KR+Uw724SLeTdYW/wEZrx768r3V4=;
        fh=GaEWHf6kqGHD4SfJy4Ze1g61NFLk9JLj2Bo7sQ3828o=;
        b=QyIakQRNaHVny4ebPehAVV8+nYfc9FeR/nmgsP4gZMqTCc7yfXEutfWlYeV5xxXqL4
         jOiDOe2kiw6CYdmah25p6gE+Tf9oh8OfmNIghWzz5ZCOEVoHjnDoOoQvUddH08bFMtaY
         Mlr2mCD1RtdlFS2PuGq8yvtoxfUcQsnQOb/4+wb0/1xsFVxCqu9BNW5bS5HXDtbYQdz4
         xwJseCufd9oS2Neq+MjxQ5//9apj3Wg+nyqOSsW989ZwVyLEzdfyBx/sZLP2Vr15hChm
         alBONgrRXpz7V5jMpVGfbYwpN/XhBdvFKTw7y2prdPobRUaYm00kzVWOQX2QD0h11w6V
         PskA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772980167; x=1773584967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/6NrBvBmwsDMU9KR+Uw724SLeTdYW/wEZrx768r3V4=;
        b=BnOtK7mY+f605SHRmFzmHcdBSVTo8Wxyu2+3zZenGyLddDhRmlrWBnLmeCrpXeQTi1
         ckhCV9p0qFaGtJ9KFch+/RZ0Ny4d5DhpugP2fiGesAAhjXrPq+fHZ+R4ZnBAgyTEtgu9
         cnshAXr3Efnxp+ws8uXYSgU4LikxJy8qWZv858+syGK78Qh/QK1EwkHur21eWYNCmpBJ
         i2heQQqL2gYnrY2gff9HzbKVAsv8uISIy1Fb7dCD586QwbfP/waYZ9FXsRiHwr49icRz
         69coKICpKR9Q2VYeEU9vsFeCBI+24CZAA5KXANuXUufjWpXAmKgOx3MYGPy1zxPJ1gH5
         fyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772980167; x=1773584967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z/6NrBvBmwsDMU9KR+Uw724SLeTdYW/wEZrx768r3V4=;
        b=clpTRZJtufetE5huN/4xmt3UyW120O8AJQhBGviR+rx3Kz4wYPQ38x+nT+s9iFI++h
         t0VDSi7UlK/UyVZT7Sb8EKz8ig9E5nZ4HnuRPNx7opI/JbYntXyPJ6E3dOgjjVHuK3eY
         FAD8vFpio+nptAwkR5/DqB4wO+YxwSLY12OM46Fh0n0GVyC62K3C3KnK26e078+dfBcx
         67Ve+QvU5u+oUBFH6x1KBEk06cEuqUeILBIAy8niBfeRM6pPa8wbdqdxV8934iR7T09g
         QBx9VKbL1+JAp1wX9R2iIqBF02V6PR6KJw/uFPIWsHhRhdKQse1XNyOW1IqiS+oQc0ce
         MDMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuYKeRqYEMvabFVkfi0EVXrToCjJ1VJ5t9AP/O0WAm89VHICJ4hoxOd6PBw8fWiXnm1Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQkyQlR7zcJObiF3rzK40963+m/Yw3OzpiV8J+M6TmVFpxG1sk
	Qa6ZcmtmGO15Xwh1ihNPSjoYTXWJBvcp9QMn+Ew+qYldcsMnvX2F/ciizignAZ53ixJRXXK3YBW
	6sCbVnW911jpGBdnp8RRPKiNSPooqd7g=
X-Gm-Gg: ATEYQzx4P7uTmA9ocWsZo56us5vI1mfAXb6q9bv3K9NIwJVUxhzkX4Qk1nT+A4pd9kS
	1HTKaQ7zbI7rzYiDjqhxeG8Z2CsHwYNvdtqrt0aN98PH/W0JvAnaXJ8HnVQNMaQb600jwOnhg8i
	CXVvv6m0JDv91KR3lc7TZUED+bPn63ZissvIOfdrn691/PRsN1SN1DQ0TME7PzTNs+9iWWqLKFB
	w2OBLneeI03RF5iaXetgCtUUsyi+nnGpAt1097meN+0GoAZjBmQmzLZDkjLfGBZOGB0wnH+3Sk2
	HA3vVQ==
X-Received: by 2002:a05:6a00:928c:b0:81a:b602:daf6 with SMTP id
 d2e1a72fcca58-829a2f83f20mr7731332b3a.48.1772980167139; Sun, 08 Mar 2026
 07:29:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304031606.43884-1-pilgrimtao@gmail.com> <20260304031606.43884-5-pilgrimtao@gmail.com>
 <87342fzjq0.fsf@gmail.com>
In-Reply-To: <87342fzjq0.fsf@gmail.com>
From: Chengkaitao <pilgrimtao@gmail.com>
Date: Sun, 8 Mar 2026 22:29:16 +0800
X-Gm-Features: AaiRm53bYnml7X5G0IwFiciLPE0so5wAI_RBE2RyqprCPZQnLYA0nY9y1vDH3uQ
Message-ID: <CAAWJmAau_VwGVG1URNmOEKhDwAHQQRkvhWU-Vzd5Fa_jWBxnOw@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] selftests/bpf: Add test case for bpf_list_add_impl
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, 
	chengkaitao@kylinos.cn, linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 11:40=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> Chengkaitao <pilgrimtao@gmail.com> writes:
>
> > From: Kaitao Cheng <chengkaitao@kylinos.cn>
> >
> > Extend refcounted_kptr test to exercise bpf_list_add:
> > add a second node after the first, then bpf_list_del both nodes.
> >
> > To verify the validity of bpf_list_add, also expect the verifier
> > to reject calls to bpf_list_add made without holding the spin_lock.
> >
> > Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> > ---
> >  .../testing/selftests/bpf/bpf_experimental.h  |  16 +++
> >  .../selftests/bpf/progs/refcounted_kptr.c     | 122 ++++++++++++++++--
> >  2 files changed, 124 insertions(+), 14 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/tes=
ting/selftests/bpf/bpf_experimental.h
> > index 54ec9d307fdc..fdcc7a054095 100644
> > --- a/tools/testing/selftests/bpf/bpf_experimental.h
> > +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> > @@ -110,6 +110,22 @@ extern struct bpf_list_node *bpf_list_pop_back(str=
uct bpf_list_head *head) __ksy
> >  extern struct bpf_list_node *bpf_list_del(struct bpf_list_head *head,
> >                                         struct bpf_list_node *node) __k=
sym;
> should this be available from vmlinux.h?

In v7, I removed most of the function declarations and kept only the
bpf_list_add macro.
https://lore.kernel.org/all/20260308134614.29711-5-pilgrimtao@gmail.com/

I have a question: bpf_experimental.h already has many similar declarations
for other kfuncs=E2=80=94are those redundant too, should we remove them as =
well?
or is there a historical reason for keeping them? I would appreciate your
clarification on this.

> > +/* Description
> > + *   Insert 'new' after 'prev' in the BPF linked list with head 'head'=
.
> > + *   The bpf_spin_lock protecting the list must be held. 'prev' must a=
lready
> > + *   be in that list; 'new' must not be in any list. The 'meta' and 'o=
ff'
> > + *   parameters are rewritten by the verifier, no need for BPF program=
s to
> > + *   set them.
> > + * Returns
> > + *   0 on success, -EINVAL if head is NULL, prev is not in the list wi=
th head,
> > + *   or new is already in a list.
> > + */
> > +extern int bpf_list_add_impl(struct bpf_list_head *head, struct bpf_li=
st_node *new,
> > +                          struct bpf_list_node *prev, void *meta, __u6=
4 off) __ksym;
> > +
> > +/* Convenience macro to wrap over bpf_list_add_impl */
> > +#define bpf_list_add(head, new, prev) bpf_list_add_impl(head, new, pre=
v, NULL, 0)
> > +
> >  /* Description
> >   *   Remove 'node' from rbtree with root 'root'
> >   * Returns
> > diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tool=
s/testing/selftests/bpf/progs/refcounted_kptr.c
> > index ac7672cfefb8..5a83274e1d26 100644
> > --- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> > +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> > @@ -367,18 +367,19 @@ long insert_rbtree_and_stash__del_tree_##rem_tree=
(void *ctx)            \
> >  INSERT_STASH_READ(true, "insert_stash_read: remove from tree");
> >  INSERT_STASH_READ(false, "insert_stash_read: don't remove from tree");
> >
> > -/* Insert node_data into both rbtree and list, remove from tree, then =
remove
> > - * from list via bpf_list_del using the node obtained from the tree.
> > +/* Insert one node in tree and list, remove it from tree, add a second
> Use kernel comment style: first line is just "/*" then text starts from
> the next one.
> > + * node after it in list with bpf_list_add, then remove both nodes fro=
m
> > + * list via bpf_list_del.
> >   */
> It sounds like the new test is quite different from the previous, why
> not add a separate test running new codepaths instead of retrofitting
> into the existing test?

I merged the three test-case patches into one; they still share a common
function, as some logic can be reused. I added some log output for
readability.

> >  SEC("tc")
> > -__description("test_bpf_list_del: remove an arbitrary node from the li=
st")
> > +__description("test_list_add_del: test bpf_list_add/del")
> >  __success __retval(0)
> > -long test_bpf_list_del(void *ctx)
> > +long test_list_add_del(void *ctx)
> >  {
> > -     long err;
> > +     long err =3D 0;
> >       struct bpf_rb_node *rb;
> > -     struct bpf_list_node *l;
> > -     struct node_data *n;
> > +     struct bpf_list_node *l, *l_1;
> > +     struct node_data *n, *n_1, *m_1;
> nit: The naming scheme is a little bit confusing.
> >
> >       err =3D __insert_in_tree_and_list(&head, &root, &lock);
> >       if (err)
> > @@ -392,20 +393,48 @@ long test_bpf_list_del(void *ctx)
> >       }
> >
> >       rb =3D bpf_rbtree_remove(&root, rb);
> > -     if (!rb) {
> > -             bpf_spin_unlock(&lock);
> > +     bpf_spin_unlock(&lock);
> > +     if (!rb)
> >               return -5;
> > -     }
> >
> >       n =3D container_of(rb, struct node_data, r);
> > +     n_1 =3D bpf_obj_new(typeof(*n_1));
> > +     if (!n_1) {
> > +             bpf_obj_drop(n);
> > +             return -1;
> > +     }
> > +     m_1 =3D bpf_refcount_acquire(n_1);
> > +     if (!m_1) {
> > +             bpf_obj_drop(n);
> > +             bpf_obj_drop(n_1);
> > +             return -1;
> > +     }
> > +
> > +     bpf_spin_lock(&lock);
> > +     if (bpf_list_add(&head, &n_1->l, &n->l)) {
> > +             bpf_spin_unlock(&lock);
> > +             bpf_obj_drop(n);
> > +             bpf_obj_drop(m_1);
> > +             return -8;
> > +     }
> > +
> >       l =3D bpf_list_del(&head, &n->l);
> > +     l_1 =3D bpf_list_del(&head, &m_1->l);
> >       bpf_spin_unlock(&lock);
> >       bpf_obj_drop(n);
> > -     if (!l)
> > -             return -6;
> > +     bpf_obj_drop(m_1);
> >
> > -     bpf_obj_drop(container_of(l, struct node_data, l));
> > -     return 0;
> > +     if (l)
> Can we do early returns, like
> if (!l)
>    return -6;
> bpf_obj_drop(l);
> if (!l_1)
>    return -7;
> bpf_obj_drop(l_1);

This change results in runtime errors, and the error log is provided below.
********************
117: (85) call bpf_list_del#101493    ;
R0=3Dptr_or_null_node_data(id=3D13,ref_obj_id=3D13,off=3D48) refs=3D6,9,11,=
13
118: (bf) r9 =3D r0                     ;
R0=3Dptr_or_null_node_data(id=3D13,ref_obj_id=3D13,off=3D48)
R9=3Dptr_or_null_node_data(id=3D13,ref_obj_id=3D13,off=3D48) refs=3D6,9,11,=
13
; bpf_spin_unlock(&lock); @ refcounted_kptr.c:441
119: (18) r1 =3D 0xffff00006957bf50     ;
R1=3Dmap_value(map=3D.bss.A,ks=3D4,vs=3D36,off=3D32) refs=3D6,9,11,13
121: (85) call bpf_spin_unlock#94     ; refs=3D6,9,11,13
; bpf_obj_drop(n_rb); @ refcounted_kptr.c:442
122: (bf) r1 =3D r6                     ; R1=3Dptr_node_data(ref_obj_id=3D6=
)
R6=3Dptr_node_data(ref_obj_id=3D6) refs=3D6,9,11,13
123: (b7) r2 =3D 0                      ; R2=3D0 refs=3D6,9,11,13
124: (85) call bpf_obj_drop_impl#102200       ; refs=3D9,11,13
; bpf_obj_drop(n_new_ref); @ refcounted_kptr.c:443
125: (bf) r1 =3D r7                     ; R1=3Dptr_node_data(ref_obj_id=3D9=
)
R7=3Dptr_node_data(ref_obj_id=3D9) refs=3D9,11,13
126: (b7) r2 =3D 0                      ; R2=3D0 refs=3D9,11,13
127: (85) call bpf_obj_drop_impl#102200       ; refs=3D11,13
128: (b7) r0 =3D -11                    ; R0=3D-11 refs=3D11,13
; if (!l_node) @ refcounted_kptr.c:445
129: (15) if r8 =3D=3D 0x0 goto pc-22 108: R0=3D-11 R6=3Dscalar() R7=3Dscal=
ar()
R8=3D0 R9=3Dptr_or_null_node_data(id=3D13,ref_obj_id=3D13,off=3D48) R10=3Df=
p0
refs=3D13
; } @ refcounted_kptr.c:459
108: (95) exit
Unreleased reference id=3D13 alloc_insn=3D117
BPF_EXIT instruction in main prog would lead to reference leak
processed 194 insns (limit 1000000) max_states_per_insn 1 total_states
20 peak_states 20 mark_read 0
*******************

>
> The point of returning different errors per each error path is to make
> it easy to understand where your test errored out by just looking at err.
> > +             bpf_obj_drop(container_of(l, struct node_data, l));
> > +     else
> > +             err =3D -6;
> > +
> > +     if (l_1)
> > +             bpf_obj_drop(container_of(l_1, struct node_data, l));
> > +     else
> > +             err =3D -6;
> > +
> > +     return err;
> >  }
> >
> >  SEC("?tc")
> > @@ -438,6 +467,71 @@ long list_del_without_lock_fail(void *ctx)
> >       return 0;
> >  }
> >
> > +SEC("?tc")
> > +__failure __msg("bpf_spin_lock at off=3D32 must be held for bpf_list_h=
ead")
> > +long list_add_without_lock_fail(void *ctx)
> > +{
> > +     long err =3D 0;
> > +     struct bpf_rb_node *rb;
> > +     struct bpf_list_node *l, *l_1;
> > +     struct node_data *n, *n_1, *m_1;
> > +
> > +     err =3D __insert_in_tree_and_list(&head, &root, &lock);
> > +     if (err)
> > +             return err;
> > +
> > +     bpf_spin_lock(&lock);
> > +     rb =3D bpf_rbtree_first(&root);
> > +     if (!rb) {
> > +             bpf_spin_unlock(&lock);
> > +             return -4;
> > +     }
> > +
> > +     rb =3D bpf_rbtree_remove(&root, rb);
> > +     bpf_spin_unlock(&lock);
> > +     if (!rb)
> > +             return -5;
> > +
> > +     n =3D container_of(rb, struct node_data, r);
> > +     n_1 =3D bpf_obj_new(typeof(*n_1));
> > +     if (!n_1) {
> > +             bpf_obj_drop(n);
> > +             return -1;
> > +     }
> > +     m_1 =3D bpf_refcount_acquire(n_1);
> > +     if (!m_1) {
> > +             bpf_obj_drop(n);
> > +             bpf_obj_drop(n_1);
> > +             return -1;
> > +     }
> > +
> > +     /* Intentionally no lock: verifier should reject bpf_list_add wit=
hout lock */
> > +     if (bpf_list_add(&head, &n_1->l, &n->l)) {
> > +             bpf_obj_drop(n);
> > +             bpf_obj_drop(m_1);
> > +             return -8;
> > +     }
> > +
> > +     bpf_spin_lock(&lock);
> > +     l =3D bpf_list_del(&head, &n->l);
> > +     l_1 =3D bpf_list_del(&head, &m_1->l);
> > +     bpf_spin_unlock(&lock);
> > +     bpf_obj_drop(n);
> > +     bpf_obj_drop(m_1);
> > +
> > +     if (l)
> > +             bpf_obj_drop(container_of(l, struct node_data, l));
> > +     else
> > +             err =3D -6;
> > +
> > +     if (l_1)
> > +             bpf_obj_drop(container_of(l_1, struct node_data, l));
> > +     else
> > +             err =3D -6;
> > +
> > +     return err;
> > +}
> Do we need this big test just to trigger that verifier error?

I simplified the "list_del/add_without_lock_fail" test cases, I'm unsure
if this aligns with community expectations. An alternative would be to
remove "list_del/add_without_lock_fail" test cases entirely. If you have
a better approach, please let me know. Thank you.

> > +
> >  SEC("tc")
> >  __success
> >  long rbtree_refcounted_node_ref_escapes(void *ctx)
> > --
> > 2.50.1 (Apple Git-155)

I=E2=80=99ve also made the corresponding fixes based on the other
suggestions. Please help review them again=EF=BC=8Cthanks.

--=20
Yours,
Chengkaitao

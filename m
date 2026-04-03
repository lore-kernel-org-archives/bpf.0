Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D0E313298
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 17:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775238105; cv=pass; b=ZD12BWZvt0fPDSwjL8QdI/P3GDorMQ2xOIiviI0zg/oajOOvnzG4rj/9nsU0ObXD194kd3S7DslTBU4LsNYU7Al9LB+L7IdECuPuqUBkJ7m4JkFFbRlO7CAUvlKVQpg9TzjXS0d3p83hzZe3jh4Cby5bxrfwXDFTRGUVVAVDQlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775238105; c=relaxed/simple;
	bh=5lWVn8YMvYAwRs2zR285cHCiDnPH0plenXQD6VjDk7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NWQdVA2U2jjey3uTuFbcnNJhCjRZyZzdboO3WNS63eMpvr2v2hGURpbWWcxvqwPnBT+zqvsqMyK6hW64nf026FzTj60N1oAOb1eyY03yNHDPiolGWeLa1CTYmFCQ0wKMGGWvLTAPHCSCotc4TUQaF2u85YnT4Wo61o2joExY8i0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSpv9MDk; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSpv9MDk"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso802879a12.3
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 10:41:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775238103; cv=none;
        d=google.com; s=arc-20240605;
        b=LZgV2mBpbOZC31tJo+LgcVzKGZw38DM0I8xuHMhwnEwgMk5ukQ/q5qbX9tQQA+ZKb3
         245rA7QuXKjEHhD9DZLhXoCce65krgLM7PNUqzKLLOlrlvGknE7zBodCKBNGylU8fXrX
         BHfO+L0A1xoufUMRZwmuoOyAyqZgAxV2nBe9/73B8ci95nJn3QZMELhtqFvl1gwNRqb4
         jDyqSGwblIMAK7kS4z6J4sVJz8DzoVwSogOs0kd0mK6PpCCJrSGHQmtXk1ki6e90QIQE
         7aSJjJVL9wNTpoFMDnaFH08fsYG+R6j2wKtXmVkPvDpv2hi7onmbfPtwqDWv6N916N6M
         4Vfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0W7mSWaqi0MOT0pMvqxQVOJ9twswqNKYzff6Qr8i4JI=;
        fh=dx8X3qN6Vxp0dyuQxQ/54FTA2lX5aRJWitqEDj7PX/k=;
        b=DmCqCxJ3k8LP1d26egUAb8qDK25aVQzmR4JTbzwdsaEIelp5uMDCmCKG43QmpiwXGw
         578cDhzrh977m+lCTqIGUr5jA8S5I3QMd+fCKjWJZMvVLDQO7waS1hvC4uIUoURpc1Ni
         XF1UFv6CS063ybwJ9IWVGC7da8cjctMgpRVhkI49JAmc3yC4pY6lJ59jbjd5eRuVzOCa
         +E2t5GamY+tbIzMf34/J73H8DBFbJIF0cwZxFfs9Rb7/FTcXcb3UrvAlXCuJ6DggcUbb
         VEF8qSnLj/NMKmqGE8OhuC2OBl/2m96UW/tv6zC0Q0rCqEZemmCVgz14kfLlglZM7O9q
         0bRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775238103; x=1775842903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0W7mSWaqi0MOT0pMvqxQVOJ9twswqNKYzff6Qr8i4JI=;
        b=HSpv9MDkKT/viPLD0hFieh7xKUWoJGWqEL4KzchnVZm/cet9S9gFXgbUsl1JVDWB+F
         sczg1985a16tvcxoYeurl9bj3T9tSN+GSSn+u7m6vY9EEZ2jKBuO/nddnNnZy4+u6yU4
         BC3edVGDzPG23s6SbMqU6KiJcVeUWhWnKu80FN79xRQ96yWVQB2Sv/dImD47tIAb/CkN
         d8dhgo6mpb79RF9/WufLOqPMTK82zv2YS++IpInoInWJ6RigAYum/tBAYLdQWZ+vVTA+
         C/c1ziEuiN1tERPZ4ka0TJbcKa9QHCOCVd3JqkgSK4d0rq9wfpCsQibgLJC0P7fTDAfZ
         +sUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775238103; x=1775842903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0W7mSWaqi0MOT0pMvqxQVOJ9twswqNKYzff6Qr8i4JI=;
        b=bN6aWRynaRF+S8GDlszNWAUqTnKzMyiVDWJqbTILsJ/ZAxHKv5m6h5H8lx45w3cuLk
         R1Hz4bpPQQ+fVL0ttbj+5cJJn21Z30QUmQd+n0y1tq2QLlA2gXsyOLYALNcYt0Ir7JWn
         2tgRlW7hybMKyO2DfqRe9y3sg5R9AQSi4y/efk8qWxJ3/OrQcVZNSTotGPOnq5tp9k99
         ZYeRL0er3rjjN/9oNftHR0vm+8/s2pz0UcRM6m4JO0eG4o7yUe391o7gKxkB1c57TfBC
         UhVl7gtOqW0XYF+9TEaCiO3UxA60HxZ8CLCnB0cQ2g0LOQxK7B7tfAPN1lnZ10t/33PI
         QcwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnfCkt/hSDQkIOvy9+vqG43miPEPGDF8yDDeHhGbZtYFAequ/KB5cBB//tZKOwOanra24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8GkJRew+kjGDsTcviMCsi1ME9Euls0Z9ME5Nfcwsv0ms+/4nf
	m5n9XEu6yYVoPRmS90OaGLUyLv1niwAiwrLUijHyz1/GVOroGdT2TEDfWbNB3LWGYQhWHnzjVCS
	lkBiCz5frXH5eiCuN8OPK6U7otlwFeNk=
X-Gm-Gg: ATEYQzzIQBlIMBcN8TL779L1U7T8XXyBlqRaxa1hMY4/6ubVAdNv51oB9MtoCsdJHC7
	gnn9r7cjQg9+fpSEtdVqR0WtrybUm/Kn57sgrLRG5rUs1Yqb2VfZFyNEQegfD+0mCBx/w5yjJjF
	cP7O34Jup6KGO6W/B0xHp1IthTMGS3xpkVfQ06SjDNmQT1OvSEZcni4yj3SdhMwB1O7BwWNqSQh
	7aXn/1PaXXY5LYrtK1SzFNRqp9ZZ4v0D+JBRcbDf/ZtZwUjkwuep735Q44QWJja6qoc3yQ/HIz/
	S3xluw==
X-Received: by 2002:a05:6a20:12c5:b0:39b:835f:1730 with SMTP id
 adf61e73a8af0-39f2eff3fc0mr3843834637.15.1775238103105; Fri, 03 Apr 2026
 10:41:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260329140506.9595-1-pilgrimtao@gmail.com> <20260329140506.9595-2-pilgrimtao@gmail.com>
 <CAADnVQ+xS4ti=cSqAnG4ePmjEZXUb-8Ss9cjkWiiWgtv-_NNVQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+xS4ti=cSqAnG4ePmjEZXUb-8Ss9cjkWiiWgtv-_NNVQ@mail.gmail.com>
From: Chengkaitao <pilgrimtao@gmail.com>
Date: Sat, 4 Apr 2026 01:41:32 +0800
X-Gm-Features: AQROBzAJduT_bxIDNRvRaGan1qOkkmaaMw5BmIuyvPDf4XREPWFaFbQgB8Axi24
Message-ID: <CAAWJmAYxbEX0M3JFJn11WOfvRoLrxnuXtkDp5omt-FJYwc8mpg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 1/9] bpf: refactor kfunc checks using
 table-driven approach in verifier
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Chengkaitao <chengkaitao@kylinos.cn>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 1:05=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Mar 29, 2026 at 7:05=E2=80=AFAM Chengkaitao <pilgrimtao@gmail.com=
> wrote:
> >
> > From: Kaitao Cheng <chengkaitao@kylinos.cn>
> >
> > Replace per-kfunc btf_id chains check with btf_id_in_kfunc_table() and
> > static kfunc tables for easier maintenance.
> >
> > Prepare for future extensions to the bpf_list API family.
> >
> > Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> > ---
> >  kernel/bpf/verifier.c | 261 +++++++++++++++++++++++-------------------
> >  1 file changed, 144 insertions(+), 117 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 4fbacd2149cd..f2d9863bb290 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -544,9 +544,6 @@ static bool is_async_callback_calling_kfunc(u32 btf=
_id);
> >  static bool is_callback_calling_kfunc(u32 btf_id);
> >  static bool is_bpf_throw_kfunc(struct bpf_insn *insn);
> >
> > -static bool is_bpf_wq_set_callback_kfunc(u32 btf_id);
> > -static bool is_task_work_add_kfunc(u32 func_id);
> > -
> >  static bool is_sync_callback_calling_function(enum bpf_func_id func_id=
)
> >  {
> >         return func_id =3D=3D BPF_FUNC_for_each_map_elem ||
> > @@ -586,7 +583,7 @@ static bool is_async_cb_sleepable(struct bpf_verifi=
er_env *env, struct bpf_insn
> >
> >         /* bpf_wq and bpf_task_work callbacks are always sleepable. */
> >         if (bpf_pseudo_kfunc_call(insn) && insn->off =3D=3D 0 &&
> > -           (is_bpf_wq_set_callback_kfunc(insn->imm) || is_task_work_ad=
d_kfunc(insn->imm)))
> > +           is_async_callback_calling_kfunc(insn->imm))
> >                 return true;
> >
> >         verifier_bug(env, "unhandled async callback in is_async_cb_slee=
pable");
> > @@ -11203,31 +11200,6 @@ static int set_task_work_schedule_callback_sta=
te(struct bpf_verifier_env *env,
> >         return 0;
> >  }
> >
> > -static bool is_rbtree_lock_required_kfunc(u32 btf_id);
> > -
> > -/* Are we currently verifying the callback for a rbtree helper that mu=
st
> > - * be called with lock held? If so, no need to complain about unreleas=
ed
> > - * lock
> > - */
> > -static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env)
> > -{
> > -       struct bpf_verifier_state *state =3D env->cur_state;
> > -       struct bpf_insn *insn =3D env->prog->insnsi;
> > -       struct bpf_func_state *callee;
> > -       int kfunc_btf_id;
> > -
> > -       if (!state->curframe)
> > -               return false;
> > -
> > -       callee =3D state->frame[state->curframe];
> > -
> > -       if (!callee->in_callback_fn)
> > -               return false;
> > -
> > -       kfunc_btf_id =3D insn[callee->callsite].imm;
> > -       return is_rbtree_lock_required_kfunc(kfunc_btf_id);
> > -}
> > -
> >  static bool retval_range_within(struct bpf_retval_range range, const s=
truct bpf_reg_state *reg)
> >  {
> >         if (range.return_32bit)
> > @@ -12639,11 +12611,103 @@ BTF_ID(func, bpf_session_is_return)
> >  BTF_ID(func, bpf_stream_vprintk)
> >  BTF_ID(func, bpf_stream_print_stack)
> >
> > -static bool is_task_work_add_kfunc(u32 func_id)
> > -{
> > -       return func_id =3D=3D special_kfunc_list[KF_bpf_task_work_sched=
ule_signal] ||
> > -              func_id =3D=3D special_kfunc_list[KF_bpf_task_work_sched=
ule_resume];
> > -}
> > +/* Kfunc family related to list. */
> > +static const enum special_kfunc_type bpf_list_api_kfuncs[] =3D {
> > +       KF_bpf_list_push_front_impl,
> > +       KF_bpf_list_push_back_impl,
> > +       KF_bpf_list_pop_front,
> > +       KF_bpf_list_pop_back,
> > +       KF_bpf_list_front,
> > +       KF_bpf_list_back,
> > +};
> > +
> > +/* Kfuncs that take a list node argument (bpf_list_node *). */
> > +static const enum special_kfunc_type bpf_list_node_api_kfuncs[] =3D {
> > +       KF_bpf_list_push_front_impl,
> > +       KF_bpf_list_push_back_impl,
> > +};
> > +
> > +/* Kfuncs that take an rbtree node argument (bpf_rb_node *). */
> > +static const enum special_kfunc_type bpf_rbtree_node_api_kfuncs[] =3D =
{
> > +       KF_bpf_rbtree_remove,
> > +       KF_bpf_rbtree_add_impl,
> > +       KF_bpf_rbtree_left,
> > +       KF_bpf_rbtree_right,
> > +};
> > +
> > +/* Kfunc family related to rbtree. */
> > +static const enum special_kfunc_type bpf_rbtree_api_kfuncs[] =3D {
> > +       KF_bpf_rbtree_add_impl,
> > +       KF_bpf_rbtree_remove,
> > +       KF_bpf_rbtree_first,
> > +       KF_bpf_rbtree_root,
> > +       KF_bpf_rbtree_left,
> > +       KF_bpf_rbtree_right,
> > +};
> > +
> > +/* Kfunc family related to spin_lock. */
> > +static const enum special_kfunc_type bpf_res_spin_lock_api_kfuncs[] =
=3D {
> > +       KF_bpf_res_spin_lock,
> > +       KF_bpf_res_spin_unlock,
> > +       KF_bpf_res_spin_lock_irqsave,
> > +       KF_bpf_res_spin_unlock_irqrestore,
> > +};
>
> I think it's a step in the wrong direction.
> I'd wait for Ihor's BTF_ID_NAMED cleanup.

After reading Ihor's messages on the list, if I understand correctly,
our two approaches seem to target different problems. What Ihor's
work appears to achieve is the ability to remove the entire enum
special_kfunc_type. My goal, on the other hand, is to replace many
scattered func_id =3D=3D special_kfunc_list[...] comparisons with a
table-driven approach.

That said, once Ihor's solution lands, my approach would no longer
be applicable as-is. So I have been thinking about an alternative,
please see the patch linked below for details:
https://lore.kernel.org/bpf/20260403170900.58659-1-pilgrimtao@gmail.com/

> Kaitao Cheng,
>
> also please start your part of code reviews.
> Your patches are not going to be landing if you don't code review.
>
> https://lore.kernel.org/bpf/CAADnVQ+TKKptnNB25V3=3Dbcdybh5G6c2DyW2sYtXvyR=
aVnPN8MA@mail.gmail.com/

I will do my best to carry this forward.

--=20
Yours,
Chengkaitao

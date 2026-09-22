Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591BF3B993A
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 21:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790112342; cv=pass; b=WeebR3nG60ZgTVQp5hRUuTDluAlNVZ2m+TlBauCVQuqlByw4MChPVlUuWxowT5DxCbJ+GgHZyo5P04Wda7h7uuzCOzSylhlEbLapl7tyrgGbpj8RPH/MKXoQb2Gj9Y5dGll+pNMdbLzoJkUtI0SULcYz5QpZD2d3D1m6OQAFbzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790112342; c=relaxed/simple;
	bh=pXYvhRI2QGsBBW3YRAxvYrIFCISaKUPoPZrA0Uk82g8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AqP5W34n7kLC151XwJQh+juwy4eqQ+PRKZWatmX6uJ8CmZUCLGAimxfj+iJjIjWw9w+efp+kVa31sK1m/+/WNl7HfIUVtSHXxbigfCPCi/pLN0GSBH+Aq8fiuGKtMWVoXgTS9m8fPmfbKAFvaAJTynXP19C0WR+bMUvstDLeS/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSkq5i8v; arc=pass smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSkq5i8v"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-7f4f0d37f9dso199931a34.1
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 14:25:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790112323; cv=none;
        d=google.com; s=arc-20260327;
        b=TPN8bxeS1FNaANWoIDZjBCkZUMHxDvWGjAMz8jF9l1GAg3ByBjAkyyt6blS0uHEWeW
         22GYh9kxgYdhvvmw27lRTmxkes1v5R5o80sjkphuDsczXl2pIcVHF3YYomX/6l17XYJ7
         PN+fznoo2Ke5Ps3yAWFbCQx8GsCJyTNgM7UGtIcmhVS3yOOoP1MCdpsR+DwwRR7inzmM
         4lYzKTAcEWdk4511wPDWGoTIddTQxiOecwut6kSMJamjw2p4JR8chLEc7tT1lhJd7dNZ
         wE9hmhZqn/3e4ni+6FRXOJcAvtnwaZUeZAoQ5GGO8gq8beNtdIjCd5vM81xUuv3TOevY
         i41A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AuJYqNlcz0zNjaMhYbGZxdr1/HF9I12Q60L33tc4/FI=;
        fh=Mn4Kp/tm7wGzuMnNO6K1cvcBgh/rlyOQShpIgHQn+LA=;
        b=ZWmXO2OP90K41eJ0U8dZPCF2gnAMIol7TIkdyzSzvVnCMDyy6Nelo4kyLydRW7AT8Y
         cmUr9C71eFHX37QuxrJBkeS4bAX4jIpxfXVTT8qVkwrWPP+mMQvZfwLi+/8eYNnkjejb
         2sckNyGDF5Wb1hldrzuVfcPXBdLAq8B4rKSnpCHYrKi2DTb8AFOwP50fPQsAAIOxBGZE
         4PFmfhhbP+2edP40/jmlEAzaGHg3q6n3GOng38ZvaKE3eHeuzf09+PkaqvmMXc5qWn/H
         PYzXazLIvhsA8UC/e1OkgxH6Jq3q0+zdMKlDpSZf7U5C8fF1qq8AAA+X3lqib+jHcrvo
         b/jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790112323; x=1790717123; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AuJYqNlcz0zNjaMhYbGZxdr1/HF9I12Q60L33tc4/FI=;
        b=OSkq5i8vINRwKHr7NQaM1cdkw/VoB8P0qLnJ3tKKo9NWlKlcMXVfnA+OIHLCQiLrPE
         it0hL4EGw9qi/EOy91MRleZ0rXLFHflqa/bcrXHKw1GZ6hXJOlBrPNzX+4oeddN70kvO
         KTlLuLb0TzWY4y5+w49pM6/XB3ILmFfiAmGTFu+JeElfER8qMr+pKSPKw7xDgZ1/X4Y8
         8pceMb1M5oaKEwu1vzAsoC6I1TUC1r84LCls8FPgtqa9uPDPBDJnIOuhBXgcuqz5lWzQ
         huSWc5gxdGcMOjsiMRNHXWFyylbheXzINsanmanzdyucdeZrRkyTgMlSYWxRITlukIif
         Gupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790112323; x=1790717123;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AuJYqNlcz0zNjaMhYbGZxdr1/HF9I12Q60L33tc4/FI=;
        b=GhBPJk429PxpHQTd8293aXheb6ZCWqhwfk0L2ZfLTTP5wG7giPjSvoke2YSpqCOiEM
         5pUmKOgdUos3okb8SHMFIa59A0UllJyESD6m96AJpRl8tDNtmuAlrdotOfxZtcmSkuGV
         cepLsA6lfud7b1+oEVjdx5lk1AKiOQ7Q4ipwrQYblL7KnUhTzk3v8io6kTd5k96lAfv0
         ob5gfF5ToZEeazb5kDzeiqYHy6iHmpXjn8cC66PJ3AXelhsswW+u35Z0x/XeFcr117s+
         MApMBFHZrwLs1bLHZQ4GkPUeJFQdxJxjiLIMufpulUIOO1dhHzjPS9I5WhW9zZ8iO/1/
         FCfw==
X-Gm-Message-State: AFuF++liSzR3LKi4eUBe513VjWWY/OU8SxZMmzneJZB+N/TYMTl52eeK
	LnLxnTTe53Y9AX2ea8pBi8quu9T8QoMAqrqd2rbMCLuHAsTsspIpKKL+E4EOx8PomeUlZmEyCyC
	bGzKK8+fQHQzAWI+yz9hZ9kjZf0RRdqo=
X-Gm-Gg: AYBFou2C3oGTX/c1W8AvQIqhaz9YTEFbDrK1qARWC928eoGo44yBQkZpSUGtt7mDpnY
	UL3qK+vx22uSEDa2fyBo9Y+HrTfGQmFb+DGeJhGT58xYNikn1JQ1eP4GMeQJjZ3TucCLQ1bqQA6
	Fwg5L7AAIYEDvIlltiRxuo/zy1KuDhG2S6MKtwsvsR1yfE9OWEAEXQimYH6W5m7OvWYyzWrCVMP
	PCoerdjuCjNuLDOVQQos/1UpsR04k059oauzwdiQdhtyDbnPLV4/dNvjHJAJGZpPqaPNtd7IXfd
	l2+d13mjNpztUVDv2RLijUa8W0Rj0JylQcPWLBAhdv1C4sE+kqbKwezEeDor40wZyuwP5uM=
X-Received: by 2002:a05:6820:81cb:b0:6b2:69bf:c8d7 with SMTP id
 006d021491bc7-6d2cff3fea4mr645741eaf.10.1790112323062; Tue, 22 Sep 2026
 14:25:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920210438.345847-1-xyx2021@mail.ustc.edu.cn> <20260920210438.345847-2-xyx2021@mail.ustc.edu.cn>
In-Reply-To: <20260920210438.345847-2-xyx2021@mail.ustc.edu.cn>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 22 Sep 2026 14:25:08 -0700
X-Gm-Features: AcwNN1VgA74wWA7Xo29HWMftmoxSc1Da10njS8DwcdHY8cYoZSTwYkR5lptmPKw
Message-ID: <CAMB2axMmrTb+UZ84UD48MwMtXbk1s9bWtreU3AOfjzU0fPT0BA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/2] bpf: Destroy callee-local dynptrs on
 subprog return
To: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2026 at 2:04=E2=80=AFPM Xu Yunxiang <xyx2021@mail.ustc.edu.=
cn> wrote:
>
> A data slice is valid only while the specific dynptr that produced it
> remains valid. prepare_func_exit() copies a subprogram return value into
> the caller and then frees the callee state without applying the normal
> destruction semantics to dynptrs in the callee stack.
>
> A callee can therefore derive a slice from a local dynptr, return or spil=
l
> the slice into its caller, and then let the dynptr disappear with the
> callee frame. The slice retains the id of a dynptr that is no longer in t=
he
> verifier state, so the verifier continues to accept accesses through it.
>
> Before the object relationship refactor, bpf_dynptr_data() slices from
> referenced dynptrs also carried the shared reference id, allowing a later
> release to catch some of these escaped slices. The refactor made those
> slices precise children of their source dynptr and exposed the missing
> teardown as an accepted stale access even after the shared resource is
> released.
>
> Before freeing a callee, scan the first slot of every dynptr in its stack
> and call destroy_if_dynptr_stack_slot(). The existing teardown rejects
> losing the last dynptr for a referenced resource and invalidates the dynp=
tr
> and all of its descendants, including slices held in the caller. Propagat=
e
> any teardown error through prepare_func_exit().
>
> Reuse the existing teardown API and diagnostic. Update the affected
> callback test expectation in this change so the commit remains test-clean=
.
>
> Fixes: 308c7a0ae885 ("bpf: Refactor object relationship tracking and fix =
dynptr UAF bug")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/20260829040712.B1B511F000E9@smtp.kernel=
.org
> Suggested-by: Amery Hung <ameryhung@gmail.com>
> Link: https://lore.kernel.org/r/CAMB2axOmdHwSrHihSRskDywkCmEGQOX+6dZPN_A9=
u-HhxY3UDA@mail.gmail.com
> Assisted-by: LLM
> Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
> ---
>  kernel/bpf/verifier.c                         | 28 +++++++++++++++++++
>  .../testing/selftests/bpf/progs/dynptr_fail.c |  4 +--
>  2 files changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 18aad4886f9cf..99b8f9add5c47 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -843,6 +843,31 @@ static int dynptr_ref_cnt(struct bpf_verifier_env *e=
nv, int v_parent_id)
>         return ref_cnt;
>  }
>
> +static int destroy_dynptrs_on_func_exit(struct bpf_verifier_env *env,
> +                                       struct bpf_func_state *callee)
> +{
> +       int i, err;
> +
> +       for (i =3D 0; i < callee->allocated_stack / BPF_REG_SIZE; i++) {
> +               struct bpf_stack_state *slot =3D &callee->stack[i];
> +
> +               if (slot->slot_type[0] !=3D STACK_DYNPTR ||
> +                   !slot->spilled_ptr.dynptr.first_slot)
> +                       continue;
> +
> +               /*
> +                * A callee-local dynptr is destroyed when its stack fram=
e goes
> +                * away. Apply the normal stack-slot teardown so referenc=
es cannot
> +                * be lost and slices derived from that dynptr are invali=
dated.
> +                */
> +               err =3D destroy_if_dynptr_stack_slot(env, callee, i);
> +               if (err)
> +                       return err;
> +       }
> +
> +       return 0;
> +}
> +

The naming of destroy_dynptrs_on_func_exit() is too specific. Can we
make it generic and resue it in two other places? For example:

  static int destroy_dynptrs_in_stack_slots(struct bpf_verifier_env *env,
                                          struct bpf_func_state *state,
                                          int first_spi, int last_spi)
  {
        int spi, err;

        for (spi =3D first_spi; spi <=3D last_spi; spi++) {
                err =3D destroy_if_dynptr_stack_slot(env, state, spi);
                if (err)
                        return err;
        }

        return 0;
  }

  The callers would become:

  /* mark_stack_slots_dynptr() */
  err =3D destroy_dynptrs_in_stack_slots(env, state, spi - 1, spi);

  /* check_stack_write_var_off() */
  err =3D destroy_dynptrs_in_stack_slots(env, state,
                                     bpf_get_spi(max_off - 1),
                                     bpf_get_spi(min_off));

  /* prepare_func_exit(): invalidate slices that escaped into the caller. *=
/
  err =3D destroy_dynptrs_in_stack_slots(
        env, callee, 0, callee->allocated_stack / BPF_REG_SIZE - 1);

WDYT?

>  static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
>                                         struct bpf_func_state *state, int=
 spi)
>  {
> @@ -11061,6 +11086,9 @@ static int prepare_func_exit(struct bpf_verifier_=
env *env, int *insn_idx)
>                         bpf_diag_mod_end(env);
>                 }
>         }

nit: add one more empty line here.

> +       err =3D destroy_dynptrs_on_func_exit(env, callee);
> +       if (err)
> +               return err;
>
>         /* for callbacks like bpf_loop or bpf_for_each_map_elem go back t=
o callsite,
>          * there function call logic would reschedule callback visit. If =
iteration
> diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/test=
ing/selftests/bpf/progs/dynptr_fail.c
> index 1cd61d72c166f..55c9a6be7fc56 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> @@ -125,9 +125,9 @@ static int missing_release_callback_fn(__u32 index, v=
oid *data)
>         return 0;
>  }
>
> -/* Any dynptr initialized within a callback must have bpf_dynptr_put cal=
led */
> +/* A callback cannot return with the last dynptr for a referenced resour=
ce. */
>  SEC("?raw_tp")
> -__failure __msg("Unreleased reference id")
> +__failure __msg("cannot overwrite referenced dynptr")
>  int ringbuf_missing_release_callback(void *ctx)
>  {
>         bpf_loop(10, missing_release_callback_fn, NULL, 0);
> --
> 2.43.0
>

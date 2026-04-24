Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D58F2030A
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 00:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776989082; cv=pass; b=LyhgoamfpvXdSG/CoJ3RU1MoPYeyyRNfdBcOH7f5il/l6pilo/Wwvm4vPMO1ZLO03MpyctoFrolJzYldKE7JXV7LRvxjx3buJ9QLEpjaAOCdWiO5GYxB905+PdF4jJPTd+iCwpTPKFZwA87HkfEPMMUe7Bek1CfqjBWPejDarvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776989082; c=relaxed/simple;
	bh=XYZmYU7R757R+kJImYb8VbDrjzv14DOjMhqjQNfJoKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipL6mDfd8vCqC5r28QNipZMZA6wttAT3EG3+0/0w0cr7s5xygGwDlf9fl4bedfm1TykuIVeKfq79T9ndDHc6aS5X7/xHG8oWqyCITYFlNKb8TNNXq1ES9GBTFHqBgMMfCqCNT159xDBjRCgrxV+jxCwRQMrLXhIiRNyHjyhyyAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3jygZv4; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3jygZv4"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b2503753efso73721985ad.0
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 17:04:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776989081; cv=none;
        d=google.com; s=arc-20240605;
        b=NAYRC4596EejD2NczE7O03TNnmjPtZ3pmjCTlCmFiH1hrmbZIU/Hw7sh0xDN1Hpy/+
         OR6fRb58h/8GTsk73E9PWcAUshO8BADERpan4JyL2JLB8AK4cAtsByPdvWw6hQ0QvlDd
         a+PqtogICL+6iUiVa0RNHVaLc+K5eQvzlbZ9xU1BU+UDfH5mJmM/0ISuvPk/ffGU0w86
         J81irGJfuH2JZbHEM3E7iWop/09mwNqss4cXZ3HxyN8CGbFXBklX3pO2jspplShKSvny
         W3bISeB1CxCV6fzo2zdRm4gSMt0fHATpWU5YmbW/q05wzFBapJqeNSM97ZLhrAnon/rj
         fL5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=25ufDGXhGZece21opl5fPUpmPYr8ALP3YrC4huWBc6A=;
        fh=zJ7odwitiZ4Go6vwe9A1wHagnO8NzvH3mQM+pdfOTPg=;
        b=HX+friDDcA9H4ELWEWNoB6omRLBiGH0QnZQuwDH5sStWCTUvVMzMJThg3ORiiw889v
         43bV3IMoFPTfTIjQlZBuIXBMVaDMhigPIdU6MLZrF2bL8uj3AOE9gNboUKlm48R6YRBK
         VCKwsDeJ5Kw9iE9kZMj4VkLvcv6EvdTkb+59RJZhBl7V3v0lwnn9HpEbvfE6oWuE2/0d
         1aQaB3vebHlNtxg7dYPJ9R0G4xlrfjGWvNk7JlDWuBv32EWBOIWJjapHl7WM4DwnejSC
         G4wlTuynm8oP198lSWlhqAmUAU/E+a6pExFNwryfS/4KjvZKGcpzJ6NnXDusoYcrU5ZD
         QEVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776989081; x=1777593881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25ufDGXhGZece21opl5fPUpmPYr8ALP3YrC4huWBc6A=;
        b=A3jygZv4bIk99Op6jbxvZZr8GbiUKzO53qyz3+HhgMh/TplF01ByQpKicvv4Ykzhby
         Pm5IU2oI1MrG4JUMOJEtT/fwfIxH9Pq5/aRxfPSdzToysVuZwHNSvuvIsom9ehcs7Y2l
         6m7KHAFnkikQkcfVjmZzsL2QpCsECyzvX1w9OzsrSArH5IXUo4TfbEG4C5uAzukZz1Ky
         quqVDFav/q3orgLt4pcS01o2ViUe5hPSVL2lxF3GfEXZPRlH2w8Wv4biW5pjVUw5hCC1
         mZG5tfRGpPqwQcGGod/X124zyC2QlddtN3vDsITkw0d+qyrbY9nuWStxGJ4W96VMJsCi
         +aow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776989081; x=1777593881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=25ufDGXhGZece21opl5fPUpmPYr8ALP3YrC4huWBc6A=;
        b=MDlNFwWFP4vgJGYQIYZsD9o/Cx6sOj/neeSFx6w3doUD2HRbDeFJdHAQS2lbngquOC
         f7/b3NBv2OAqAPqcwf/tI6l+NGitA/zj+HP1Srh9xq66aur5sORl5WU68qk8CM0xl3jd
         315EpLHoAIyqNGR3YLl97bX+drnkA8fO2Dusj5M7kH9vSqcYKZi6gbuhJV6PUajYhTt6
         bwIcpECJ9iBS90DWaIwKjV9kJCrR1anjCmfJx0uN9WqrvryKOTjU+Sj9BwDJ2/95dute
         zUdOXZv0SqbXZNI7RLGgjDl1s8oLDlz5Uyatkw35DnTmONJxUwHGnesMbhU+IN/CM+GT
         DxZA==
X-Gm-Message-State: AOJu0YwUJvI5NQ+BVltO3j7qp4COROyXMqbR4UL43YjU8bnvRF7x9jFo
	ECdJvJ1109B0JPVWqcDje4LH73A/6KteixGBHrXFmAGi28JD+8nS/bugkUTiH9O9oSs+VPfgtQH
	mDzUER+4FQBPbCwSIoPIrcv5nTSF6cHA=
X-Gm-Gg: AeBDietCgVnwuFlIhWY/YROAU1Z5u2vT0z5FG0rf4/k8VGPwhePjI1T9SEap3b+e4Uh
	PYtccR9gIXdvEJci4mtjTS6q7lmr34Yagzf/xh6qOSL0B3QSTWawKFa7c+lottJ5vPjLhJtwKE3
	DQMx6nST+1GnTdSDnFZ1pFuf5e911leVZzQYpKd9ICXUco6ojRQgpgGldNfI0LVp/ObKqa7cI4R
	RT4AqpqZB32RIQe25ARcuMkWqVV/ccCShQV5XmtwUz8qlX1JfDjPI2n874A0TK+2PBUm+Oa3yfO
	y5orYq6tbOgcOClvtT/f6bHm58XsH8R9hA==
X-Received: by 2002:a17:902:7c0f:b0:2b2:81aa:f6c3 with SMTP id
 d9443c01a7336-2b5f9f6408emr248803555ad.29.1776989080715; Thu, 23 Apr 2026
 17:04:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421221016.2967924-1-ameryhung@gmail.com> <20260421221016.2967924-4-ameryhung@gmail.com>
In-Reply-To: <20260421221016.2967924-4-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 23 Apr 2026 17:04:25 -0700
X-Gm-Features: AQROBzDTUcAGssQhOFcSS6UXDb2vYMnNc_kbBkRlJMvtnJ84oTJ7xeXG6eX-fzc
Message-ID: <CAEf4BzYoZaEPjbFBdUQP6kGYz-YPUKzYY1ngGhu0wNCLzT26=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/9] bpf: Preserve reg->id of pointer objects
 after null-check
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 3:10=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> Preserve reg->id of pointer objects after null-checking the register so
> that children objects derived from it can still refer to it in the new
> object relationship tracking mechanism introduced in a later patch. This
> change incurs a slight increase in the number of states in one selftest
> bpf object, rbtree_search.bpf.o. For Meta bpf objects, the increase of
> states is also negligible.
>
> Selftest BPF objects with insns_diff > 0
>
> Program                   Insns (A)  Insns (B)  Insns   (DIFF)  States (A=
)  States (B)  States (DIFF)
> ------------------------  ---------  ---------  --------------  ---------=
-  ----------  -------------
> rbtree_search                  6820       7326   +506 (+7.42%)         37=
9         398   +19 (+5.01%)
>
> Meta BPF objects with insns_diff > 0
>
> Program                   Insns (A)  Insns (B)  Insns   (DIFF)  States (A=
)  States (B)  States (DIFF)
> ------------------------  ---------  ---------  --------------  ---------=
-  ----------  -------------
> ned_imex_be_tclass               52         57     +5 (+9.62%)           =
5           6   +1 (+20.00%)
> ned_imex_be_tclass               52         57     +5 (+9.62%)           =
5           6   +1 (+20.00%)
> ned_skop_auto_flowlabel         523        526     +3 (+0.57%)          3=
9          40    +1 (+2.56%)
> ned_skop_mss                    289        292     +3 (+1.04%)          2=
0          20    +0 (+0.00%)
> ned_skopt_bet_classifier         78         82     +4 (+5.13%)           =
8           8    +0 (+0.00%)
> dctcp_update_alpha              252        320   +68 (+26.98%)          2=
1          27   +6 (+28.57%)
> dctcp_update_alpha              252        320   +68 (+26.98%)          2=
1          27   +6 (+28.57%)
> ned_ts_func                     119        126     +7 (+5.88%)           =
6           7   +1 (+16.67%)
> tw_egress                      1119       1128     +9 (+0.80%)          9=
5          96    +1 (+1.05%)
> tw_ingress                     1128       1137     +9 (+0.80%)          9=
5          96    +1 (+1.05%)
> tw_tproxy_router               4380       4465    +85 (+1.94%)         11=
4         118    +4 (+3.51%)
> tw_tproxy_router4              3093       3170    +77 (+2.49%)          8=
3          88    +5 (+6.02%)
> ttls_tc_ingress               34656      35717  +1061 (+3.06%)         93=
6         970   +34 (+3.63%)
> tw_twfw_egress               222327     222338    +11 (+0.00%)       1056=
3       10564    +1 (+0.01%)
> tw_twfw_ingress               78295      78299     +4 (+0.01%)        382=
5        3826    +1 (+0.03%)
> tw_twfw_tc_eg                222839     222859    +20 (+0.01%)       1058=
4       10585    +1 (+0.01%)
> tw_twfw_tc_in                 78295      78299     +4 (+0.01%)        382=
5        3826    +1 (+0.03%)
> tw_twfw_egress                 8080       8085     +5 (+0.06%)         45=
6         456    +0 (+0.00%)
> tw_twfw_ingress                8053       8056     +3 (+0.04%)         45=
4         454    +0 (+0.00%)
> tw_twfw_tc_eg                  8154       8174    +20 (+0.25%)         45=
6         457    +1 (+0.22%)
> tw_twfw_tc_in                  8060       8063     +3 (+0.04%)         45=
5         455    +0 (+0.00%)
> tw_twfw_egress               222327     222338    +11 (+0.00%)       1056=
3       10564    +1 (+0.01%)
> tw_twfw_ingress               78295      78299     +4 (+0.01%)        382=
5        3826    +1 (+0.03%)
> tw_twfw_tc_eg                222839     222859    +20 (+0.01%)       1058=
4       10585    +1 (+0.01%)
> tw_twfw_tc_in                 78295      78299     +4 (+0.01%)        382=
5        3826    +1 (+0.03%)
> tw_twfw_egress                 8080       8085     +5 (+0.06%)         45=
6         456    +0 (+0.00%)
> tw_twfw_ingress                8053       8056     +3 (+0.04%)         45=
4         454    +0 (+0.00%)
> tw_twfw_tc_eg                  8154       8174    +20 (+0.25%)         45=
6         457    +1 (+0.22%)
> tw_twfw_tc_in                  8060       8063     +3 (+0.04%)         45=
5         455    +0 (+0.00%)
>
> Looking into rbtree_search, the reason for such increase is that the
> verifier has to explore the main loop shown below for one more iteration
> until state pruning decides the current state is safe.
>
> long rbtree_search(void *ctx)
> {
>         ...
>         bpf_spin_lock(&glock0);
>         rb_n =3D bpf_rbtree_root(&groot0);
>         while (can_loop) {
>                 if (!rb_n) {
>                         bpf_spin_unlock(&glock0);
>                         return __LINE__;
>                 }
>
>                 n =3D rb_entry(rb_n, struct node_data, r0);
>                 if (lookup_key =3D=3D n->key0)
>                         break;
>                 if (nr_gc < NR_NODES)
>                         gc_ns[nr_gc++] =3D rb_n;
>                 if (lookup_key < n->key0)
>                         rb_n =3D bpf_rbtree_left(&groot0, rb_n);
>                 else
>                         rb_n =3D bpf_rbtree_right(&groot0, rb_n);
>         }
>         ...
> }
>
> Below is what the verifier sees at the start of each iteration
> (65: may_goto) after preserving id of rb_n. Without id of rb_n, the
> verifier stops exploring the loop at iter 16.
>
>            rb_n  gc_ns[15]
> iter 15    257   257
>
> iter 16    290   257    rb_n: idmap add 257->290
>                         gc_ns[15]: check 257 !=3D 290 --> state not equal
>
> iter 17    325   257    rb_n: idmap add 290->325
>                         gc_ns[15]: idmap add 257->257 --> state safe
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  kernel/bpf/verifier.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>

totally seems worth doing

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 93003a2a96b0..0313b7d5f6c9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -15886,15 +15886,10 @@ static void mark_ptr_or_null_reg(struct bpf_fun=
c_state *state,
>
>                 mark_ptr_not_null_reg(reg);
>
> -               if (!reg_may_point_to_spin_lock(reg)) {
> -                       /* For not-NULL ptr, reg->ref_obj_id will be rese=
t
> -                        * in release_reference().
> -                        *
> -                        * reg->id is still used by spin_lock ptr. Other
> -                        * than spin_lock ptr type, reg->id can be reset.
> -                        */
> -                       reg->id =3D 0;
> -               }
> +               /*
> +                * reg->id is preserved for object relationship tracking
> +                * and spin_lock lock state tracking
> +                */
>         }
>  }
>
> --
> 2.52.0
>

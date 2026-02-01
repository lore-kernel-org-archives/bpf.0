Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C597E2110E
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 03:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769915220; cv=pass; b=qkD1hxruRqwOOOZwmxybPu/+97T95WHeec+KwPkpC/+AGtcFc4RPSKLv9n51r8FYaPgJt7A32TPRnnuDWMRhtFgbrJUvKAX28vmdshyeRfvohwYXM2YSXUFVfRswyPARIHvxATFqqDXxPxHxAbvUveoOs3WUhKXBzCrF9dvg8aU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769915220; c=relaxed/simple;
	bh=TzbNGNweUxGIf/ABGGjYIPJbkCkSrpHiu+dK4piSpkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8d/2emybJs3euxRQ99QeJCL7q1oaBHoZYiuvksRf8V9KM/y4cEHft3Fhu11J2RhOhL6OLZ2GDc/u7g14OrNLpzfUPya61A3ZDp6spHTR+s3/r45novvv4sOMmDWP+ri4lc8IJFMhF75Pmx9zr/Ax5m4kZZnQHOP3uTv4RHa5rE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgpAN8kv; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgpAN8kv"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-482f2599980so3620285e9.0
        for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 19:06:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769915217; cv=none;
        d=google.com; s=arc-20240605;
        b=HerHYspG7nbRVDNWUzY7GzhhEJKXscdscY9dRZw/GnjYgZ0bd96CSszZzVniwzQ1Gy
         hZuyHIQeogroGlcEe8ddBY5BTjE981GPxelrodsDzhhdrT0EZLgv0JIopXOv9IMRpLct
         gB1pRiqSYUWbmH7QtkYDL94qjW2sHdlbVG5vcGTcSwOzfmCqFsFz0WQlAjNTCyPHDyJ5
         KXy7AHwuBvnHITB/U9NVkCsE3/Fj1FJNuTqgNZidBTGQF5d5f5zBKo85cUR5HedY4w4x
         aQ7CKe1oupPJ1IvD+GkLgl9i4Pjbi/xitsjScDDJjiqkdmsJFwWANOk4cghro8TRSnrd
         kxbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1MHd4PZRxowT8qBYY/3UXhHsaGurWBF4Evxs3jcK7b0=;
        fh=pcS/HywzzpiYSjeXTtxkKOY9njydhUunhc57JDSUbEk=;
        b=QM9S1yROAWt0krMCBW77P6GelJYso3wowe9H/Uw2ykdJFGp8qQHiiA/2fNwr2GJykN
         +hABfl6T3HA4gA+6M4/3r18q6XDO+buklkwJaxSaoBeu5a8JytygfP5kFsn5bZfexzQb
         4tvPgSQCpnRMtzA8kwhpgv3Wl0vDSj0N1NCxyt9Yy1TuidBYR/8252DVQbRchTSYJ101
         bsqYgKHONaFWTIHoVuadhMjWIoq7fSvOXx7NPJlmu2HUjxqt/iR73YbSgWutkA3tCeOw
         uwbeH5l5XIlsA6o6zhzhkUbaD7EqpWAJfsHgyYRYhd446CrWo3ZuvcwDZ8c04BgjYgXS
         FGWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769915217; x=1770520017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MHd4PZRxowT8qBYY/3UXhHsaGurWBF4Evxs3jcK7b0=;
        b=KgpAN8kvhr0qAU3T4CpqDN1f6g+cgp9pw02WzmtEJGeeyR0Gb+y08WIBIBZnvHw2ch
         3YpguyBMJ27g7LlugtLYbfm4mafKwRRpagh0f3+2Epv8Wppx8VBESdOk+8szHV7WOTmP
         CKamoLsH4ntlqE8/evnuGl8xTjx1Gp5XVeHdHNGPMgquvu31usjYwuvLXY+geiynyVpl
         mydoyX/KPQJT3sM4s8oCyhF4Lt81D9ibemWQ19aYj08yyO0ZMxsUlY2hVdJkveAQCJQv
         LgB1tlWm5WYT2+l8Qs03E7qwpNbId8PJyYP+qaATab4oafY/GP2SBmmWcRfvelI+Vw7T
         Or6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769915217; x=1770520017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1MHd4PZRxowT8qBYY/3UXhHsaGurWBF4Evxs3jcK7b0=;
        b=f4QD1BQLns/Av7fhckDO+hs2r5BntZiAoo95Q5V9eDACoj8O705BIeWHM8thysmORx
         hMKzqIa3BMdBSqtNE6mKHiS8M9GbMmolBs4YIpY7Sm7h0JwKx9n4ZRFa/VoHnHGjXSmo
         EDnMbqOpWG51RQiFrRXkx/kLFn8AzIddCyQxb5BwPcgPLD+ty9qs1jN/BkvpWDT/LTng
         rtOQjx47TKbVmlIwzS21ir5cTt3dhh6fkmMf4GaidMoMeVRsRt5ljyDcFwHWNX7caXXA
         X9HNhrUcle1hNaNXYvLRW1wkyvA7WLDmW9tFowFMCZ/N0t3cvwXHh5BRGOYVa8WRsNuR
         7qEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXApaVW9JHQ+4mxQ/subEyER5LeQ2crfosoCNqimFhkbzVjPXfWxfMrCMyJp6LZQj/tHbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsk15dEVj/pwZFk/YlTB9WSzuRbeLcvRzjHqLr57QSuY3kD1bj
	rkkVbXTLbQcKexggBrF15UXkAalQTYUKg450d6xTPHU4qs3B2s/82KajAJANGDRKIuohUE27vXq
	nZ3XPWGt0rX/Hs8SlOELjXiwXi2NdF5I=
X-Gm-Gg: AZuq6aJY5FtPxZBfsmezIDcdNa0JEFTmqTnbaxpFx2AQWJUknMzz1VGIOW00FEo07nM
	0A+D4cQLapio8gT2k6EnByzgG2RxVkFURG4uGJtaPHLahRdzIT4Zd28gT6YvHe3/EiFYPXOR24S
	CWS4RkbF14oYT+UTZMCYJwNbbM/4GqO7sYOMRsuUAtm/0HZgMOqoSDZccHs+67pN80wss44ZpBu
	0NCuObq/4flMLknJUkzhl2ftiQNAa1A67Zc1HCAmmzaEduWNBCr10+fChQwZhZQzNOd9a+1fx4P
	P9uOEGUXZFSYY4TB8SGJVtaR/OlQNvgafJWG9WDPa2ZtUoRfTNmqt8bCwKpZ1x2E4/63kh8BqPE
	mQcNzwJJ6IP2e0A==
X-Received: by 2002:a05:600c:474f:b0:480:3230:6c9b with SMTP id
 5b1f17b1804b1-482db4596d4mr92056235e9.7.1769915216961; Sat, 31 Jan 2026
 19:06:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130081520.59713-1-yangfeng59949@163.com>
In-Reply-To: <20260130081520.59713-1-yangfeng59949@163.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 31 Jan 2026 19:06:46 -0800
X-Gm-Features: AZwV_QiffHVR91JWs7UTGBCNFQiiselJi7-rInmkl06oXX7yfpT4WEByNAmkd6M
Message-ID: <CAADnVQLk1y8k7xBdJbF+W+V5JQdV50kFxvLpkZp_LPs2KMt7Mw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next] bpf: Add the missing types in the logs
To: Feng Yang <yangfeng59949@163.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 12:16=E2=80=AFAM Feng Yang <yangfeng59949@163.com> =
wrote:
>
> From: Feng Yang <yangfeng@kylinos.cn>
>
> Add the missing types to avoid such uninformative errors as shown below:
> R1 type=3Dptr_ expected=3Dptr_
>
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> ---
> Changes in v4:
> - Added a part that was accidentally omitted before, please ignore the v3=
 version.
> Changes in v3:
> - Fix the self-test failures caused by this patch.
> - Link to v2: https://lore.kernel.org/all/20260129073614.113380-1-yangfen=
g59949@163.com/
> Changes in v2:
> - Group together those for which only 0 or 1 can be selected. thanks, Myk=
yta Yatsenko.
> - Link to v1: https://lore.kernel.org/all/20260128085842.145057-1-yangfen=
g59949@163.com/
> ---
>  kernel/bpf/log.c                              | 53 +++++++++++++++++--
>  .../selftests/bpf/prog_tests/linked_list.c    |  6 +--
>  .../selftests/bpf/prog_tests/spin_lock.c      |  6 +--
>  .../testing/selftests/bpf/progs/dynptr_fail.c |  4 +-
>  .../selftests/bpf/progs/linked_list_peek.c    |  2 +-
>  .../bpf/progs/local_kptr_stash_fail.c         |  2 +-
>  .../selftests/bpf/progs/percpu_alloc_fail.c   |  4 +-
>  .../selftests/bpf/progs/rbtree_search.c       |  4 +-
>  .../struct_ops_kptr_return_fail__local_kptr.c |  2 +-
>  9 files changed, 63 insertions(+), 20 deletions(-)
>
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index a0c3b35de2ce..c7d08b1ba96f 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -432,6 +432,44 @@ static const char *btf_type_name(const struct btf *b=
tf, u32 id)
>         return btf_name_by_offset(btf, btf_type_by_id(btf, id)->name_off)=
;
>  }
>
> +static const char *dynptr_reg_type(enum bpf_reg_type type)
> +{
> +       if (type & DYNPTR_TYPE_LOCAL)
> +               return "dynptr_local_";
> +       if (type & DYNPTR_TYPE_RINGBUF)
> +               return "dynptr_ringbuf_";
> +       if (type & DYNPTR_TYPE_SKB)
> +               return "dynptr_skb_";
> +       if (type & DYNPTR_TYPE_XDP)
> +               return "dynptr_xdp_";
> +       if (type & DYNPTR_TYPE_SKB_META)
> +               return "dynptr_skb_meta_";
> +       if (type & DYNPTR_TYPE_FILE)
> +               return "dynptr_file_";
> +
> +       return "";
> +}
> +
> +static const char *trusted_reg_type(enum bpf_reg_type type)
> +{
> +       if (type & PTR_TRUSTED)
> +               return "trusted_";
> +       if (type & PTR_UNTRUSTED)
> +               return "untrusted_";
> +
> +       return "";
> +}
> +
> +static const char *rw_reg_type(enum bpf_reg_type type)
> +{
> +       if (type & MEM_RDONLY)
> +               return "rdonly_";
> +       if (type & MEM_WRITE)
> +               return "write_";
> +
> +       return "";
> +}
> +
>  /* string representation of 'enum bpf_reg_type'
>   *
>   * Note that reg_type_str() can not appear more than once in a single ve=
rbose()
> @@ -439,7 +477,7 @@ static const char *btf_type_name(const struct btf *bt=
f, u32 id)
>   */
>  const char *reg_type_str(struct bpf_verifier_env *env, enum bpf_reg_type=
 type)
>  {
> -       char postfix[16] =3D {0}, prefix[64] =3D {0};
> +       char postfix[16] =3D {0}, prefix[128] =3D {0};
>         static const char * const str[] =3D {
>                 [NOT_INIT]              =3D "?",
>                 [SCALAR_VALUE]          =3D "scalar",
> @@ -473,14 +511,19 @@ const char *reg_type_str(struct bpf_verifier_env *e=
nv, enum bpf_reg_type type)
>                         strscpy(postfix, "_or_null");
>         }
>
> -       snprintf(prefix, sizeof(prefix), "%s%s%s%s%s%s%s",
> -                type & MEM_RDONLY ? "rdonly_" : "",
> +       snprintf(prefix, sizeof(prefix), "%s%s%s%s%s%s%s%s%s%s%s%s",
> +                rw_reg_type(type),
> +                trusted_reg_type(type),
> +                dynptr_reg_type(type),
>                  type & MEM_RINGBUF ? "ringbuf_" : "",
>                  type & MEM_USER ? "user_" : "",
>                  type & MEM_PERCPU ? "percpu_" : "",
>                  type & MEM_RCU ? "rcu_" : "",
> -                type & PTR_UNTRUSTED ? "untrusted_" : "",
> -                type & PTR_TRUSTED ? "trusted_" : ""
> +                type & MEM_UNINIT ? "uninit_" : "",
> +                type & MEM_FIXED_SIZE ? "fixed_size_" : "",
> +                type & MEM_ALLOC ? "alloc_" : "",
> +                type & NON_OWN_REF ? "non_own_ref_" : "",
> +                type & MEM_ALIGNED ? "aligned_" : ""
>         );
>
>         snprintf(env->tmp_str_buf, TMP_STR_BUF_LEN, "%s%s%s",
> diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools=
/testing/selftests/bpf/prog_tests/linked_list.c
> index 14c5a7ef0e87..141c611de1cf 100644
> --- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
> +++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
> @@ -69,7 +69,7 @@ static struct {
>         { "obj_new_no_composite", "bpf_obj_new/bpf_percpu_obj_new type ID=
 argument must be of a struct" },
>         { "obj_new_no_struct", "bpf_obj_new/bpf_percpu_obj_new type ID ar=
gument must be of a struct" },
>         { "obj_drop_non_zero_off", "R1 must have zero offset when passed =
to release func" },
> -       { "new_null_ret", "R0 invalid mem access 'ptr_or_null_'" },
> +       { "new_null_ret", "R0 invalid mem access 'alloc_ptr_or_null_'" },
>         { "obj_new_acq", "Unreleased reference id=3D" },
>         { "use_after_drop", "invalid mem access 'scalar'" },
>         { "ptr_walk_scalar", "type=3Drdonly_untrusted_mem expected=3Dperc=
pu_ptr_" },
> @@ -87,12 +87,12 @@ static struct {
>         { "incorrect_value_type",
>           "operation on bpf_list_head expects arg#1 bpf_list_node at offs=
et=3D48 in struct foo, "
>           "but arg is at offset=3D0 in struct bar" },
> -       { "incorrect_node_var_off", "variable ptr_ access var_off=3D(0x0;=
 0xffffffff) disallowed" },
> +       { "incorrect_node_var_off", "variable alloc_ptr_ access var_off=
=3D(0x0; 0xffffffff) disallowed" },
>         { "incorrect_node_off1", "bpf_list_node not found at offset=3D49"=
 },
>         { "incorrect_node_off2", "arg#1 offset=3D0, but expected bpf_list=
_node at offset=3D48 in struct foo" },
>         { "no_head_type", "bpf_list_head not found at offset=3D0" },
>         { "incorrect_head_var_off1", "R1 doesn't have constant offset" },
> -       { "incorrect_head_var_off2", "variable ptr_ access var_off=3D(0x0=
; 0xffffffff) disallowed" },
> +       { "incorrect_head_var_off2", "variable alloc_ptr_ access var_off=
=3D(0x0; 0xffffffff) disallowed" },
>         { "incorrect_head_off1", "bpf_list_head not found at offset=3D25"=
 },
>         { "incorrect_head_off2", "bpf_list_head not found at offset=3D1" =
},
>         { "pop_front_off", "off 48 doesn't point to 'struct bpf_spin_lock=
' that is at 40" },
> diff --git a/tools/testing/selftests/bpf/prog_tests/spin_lock.c b/tools/t=
esting/selftests/bpf/prog_tests/spin_lock.c
> index 254fbfeab06a..b365010e47c6 100644
> --- a/tools/testing/selftests/bpf/prog_tests/spin_lock.c
> +++ b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
> @@ -13,9 +13,9 @@ static struct {
>         const char *err_msg;
>  } spin_lock_fail_tests[] =3D {
>         { "lock_id_kptr_preserve",
> -         "5: (bf) r1 =3D r0                       ; R0=3Dptr_foo(id=3D2,=
ref_obj_id=3D2) "
> -         "R1=3Dptr_foo(id=3D2,ref_obj_id=3D2) refs=3D2\n6: (85) call bpf=
_this_cpu_ptr#154\n"
> -         "R1 type=3Dptr_ expected=3Dpercpu_ptr_" },
> +         "5: (bf) r1 =3D r0                       ; R0=3Dalloc_ptr_foo(i=
d=3D2,ref_obj_id=3D2) "
> +         "R1=3Dalloc_ptr_foo(id=3D2,ref_obj_id=3D2) refs=3D2\n6: (85) ca=
ll bpf_this_cpu_ptr#154\n"
> +         "R1 type=3Dalloc_ptr_ expected=3Dpercpu_ptr_, percpu_rcu_ptr_, =
trusted_percpu_ptr_" },
>         { "lock_id_global_zero",
>           "; R1=3Dmap_value(map=3D.data.A,ks=3D4,vs=3D4)\n2: (85) call bp=
f_this_cpu_ptr#154\n"
>           "R1 type=3Dmap_value expected=3Dpercpu_ptr_" },
> diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/test=
ing/selftests/bpf/progs/dynptr_fail.c
> index 8f2ae9640886..b497e61a3224 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> @@ -1090,7 +1090,7 @@ int dynptr_read_into_slot(void *ctx)
>
>  /* bpf_dynptr_slice()s are read-only and cannot be written to */
>  SEC("?tc")
> -__failure __msg("R{{[0-9]+}} cannot write into rdonly_mem")
> +__failure __msg("R{{[0-9]+}} cannot write into rdonly_dynptr_skb_mem")
>  int skb_invalid_slice_write(struct __sk_buff *skb)
>  {
>         struct bpf_dynptr ptr;
> @@ -1111,7 +1111,7 @@ int skb_invalid_slice_write(struct __sk_buff *skb)
>
>  /* bpf_dynptr_slice()s are read-only and cannot be written to */
>  SEC("?tc")
> -__failure __msg("R{{[0-9]+}} cannot write into rdonly_mem")
> +__failure __msg("R{{[0-9]+}} cannot write into rdonly_dynptr_skb_meta_me=
m")
>  int skb_meta_invalid_slice_write(struct __sk_buff *skb)
>  {
>         struct bpf_dynptr meta;
> diff --git a/tools/testing/selftests/bpf/progs/linked_list_peek.c b/tools=
/testing/selftests/bpf/progs/linked_list_peek.c
> index 264e81bfb287..60f3f9e4d3a8 100644
> --- a/tools/testing/selftests/bpf/progs/linked_list_peek.c
> +++ b/tools/testing/selftests/bpf/progs/linked_list_peek.c
> @@ -100,7 +100,7 @@ long test_##op##_spinlock_##dolock(void *ctx)        =
               \
>         return !!jiffies;                                       \
>  }
>
> -#define MSG "call bpf_list_{{(front|back).+}}; R0{{(_w)?}}=3Dptr_or_null=
_node_data(id=3D{{[0-9]+}},non_own_ref"
> +#define MSG "call bpf_list_{{(front|back).+}}; R0{{(_w)?}}=3Dalloc_non_o=
wn_ref_ptr_or_null_node_data(id=3D{{[0-9]+}},non_own_ref"
>  TEST_FB(front, true)
>  TEST_FB(back, true)
>  #undef MSG
> diff --git a/tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c b/=
tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c
> index fcf7a7567da2..ae6cf9efab5f 100644
> --- a/tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c
> +++ b/tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c
> @@ -40,7 +40,7 @@ struct {
>  } some_nodes SEC(".maps");
>
>  SEC("tc")
> -__failure __msg("invalid kptr access, R2 type=3Dptr_node_data2 expected=
=3Dptr_node_data")
> +__failure __msg("invalid kptr access, R2 type=3Dalloc_ptr_node_data2 exp=
ected=3Dptr_node_data")
>  long stash_rb_nodes(void *ctx)
>  {
>         struct map_value *mapval;
> diff --git a/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c b/tool=
s/testing/selftests/bpf/progs/percpu_alloc_fail.c
> index f2b8eb2ff76f..87154ca70bb4 100644
> --- a/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
> +++ b/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
> @@ -60,7 +60,7 @@ int BPF_PROG(test_array_map_1)
>  }
>
>  SEC("?fentry/bpf_fentry_test1")
> -__failure __msg("invalid kptr access, R2 type=3Dpercpu_ptr_val2_t expect=
ed=3Dptr_val_t")
> +__failure __msg("invalid kptr access, R2 type=3Dpercpu_alloc_ptr_val2_t =
expected=3Dptr_val_t")
>  int BPF_PROG(test_array_map_2)
>  {
>         struct val2_t __percpu_kptr *p2;
> @@ -84,7 +84,7 @@ int BPF_PROG(test_array_map_2)
>  }
>
>  SEC("?fentry.s/bpf_fentry_test1")
> -__failure __msg("R1 type=3Dscalar expected=3Dpercpu_ptr_, percpu_rcu_ptr=
_, percpu_trusted_ptr_")
> +__failure __msg("R1 type=3Dscalar expected=3Dpercpu_ptr_, percpu_rcu_ptr=
_, trusted_percpu_ptr_")
>  int BPF_PROG(test_array_map_3)
>  {
>         struct val_t __percpu_kptr *p, *p1;
> diff --git a/tools/testing/selftests/bpf/progs/rbtree_search.c b/tools/te=
sting/selftests/bpf/progs/rbtree_search.c
> index b05565d1db0d..f060d7ae22fa 100644
> --- a/tools/testing/selftests/bpf/progs/rbtree_search.c
> +++ b/tools/testing/selftests/bpf/progs/rbtree_search.c
> @@ -189,10 +189,10 @@ long test_##op##_spinlock_##dolock(void *ctx)      =
       \
>   * Otherwise, the test_loader will incorrectly match the prog lineinfo
>   * instead of the log generated by the verifier.
>   */
> -#define MSG "call bpf_rbtree_root{{.+}}; R0{{(_w)?}}=3Drcu_ptr_or_null_n=
ode_data(id=3D{{[0-9]+}},non_own_ref"
> +#define MSG "call bpf_rbtree_root{{.+}}; R0{{(_w)?}}=3Drcu_alloc_non_own=
_ref_ptr_or_null_node_data(id=3D{{[0-9]+}},non_own_ref"
>  TEST_ROOT(true)
>  #undef MSG
> -#define MSG "call bpf_rbtree_{{(left|right).+}}; R0{{(_w)?}}=3Drcu_ptr_o=
r_null_node_data(id=3D{{[0-9]+}},non_own_ref"
> +#define MSG "call bpf_rbtree_{{(left|right).+}}; R0{{(_w)?}}=3Drcu_alloc=
_non_own_ref_ptr_or_null_node_data(id=3D{{[0-9]+}},non_own_ref"

I don't think it's an improvement.
Now it's completely unreadable.

The "R1 type=3Dptr_ expected=3Dptr_" message sucks, but not because of
type modifiers. It's missing struct name and that's where the mismatch
often happens.
trusted/rdonly/alloc/non_own is all noise.

pw-bot: cr

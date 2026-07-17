Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C765301719
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 05:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784264933; cv=none; b=s5WetVGpXRN3rgQ3RHSSCyp24AlbcqHH1qOpZocYrPkTFL8atx8peVHqIB+ciKBQ7qdWd3zONUXrD6J5yqQNxWLiC0pTPnEcXFkdeEGmG+4GRklXOiT83clkjhoC3Z/bAWG/sLmVv9mzHjdrfAtqs+M6DKZFlU6AXxCyIKqFVDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784264933; c=relaxed/simple;
	bh=y8ra6iNrqOySRVd8TSKzMCECDm6NutDHBWQ2nV8+r/A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=VxAFrpKbUfsCSpdo3D3IvYnDGgknmdNRnuEy962LUlP9Kh7lBx8ahnf0FI1evjPaBK172/3pA1EfHzibEfH0g77Yjknqrhqgjb2VsAL2B/q13p1VXg4Pu28daSLe+lYqv5lQ4Gl/cLTuri5gTuxxVoKKPKxt+5ho8V22+y3NS7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=h2/JWY6w; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="h2/JWY6w"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-848595b338cso8591429b3a.0
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 22:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1784264931; x=1784869731; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3Kk0LSnTy6u9JE2Hs6bboN5a228uN9ZkdsFyoBfZC18=;
        b=h2/JWY6wyhsu0t1/kEfIGs3hanmDpW9uxt+roIer0HQTD4/nWDRWrEBL06STnPqjuL
         lIntOnvO3RmVYG/UKWYvxhzSd7KwaZYST6oz34n/2E/HX/e63KV3nU/1o31XloxuH1hR
         HtMOf4PDWglmXR5ZwrzEOGcRisKFO71YtBI9/CKR8b9d1GTjTf1oZARCYMdPaC+t64DF
         fgiWIEaWX3ht9s5vO3t8DmpKfwsetkFluEoZEI8SkvCh7hZt5TcuE5DWXM+oeePuFSGV
         nD6Yp5mnfvkYcq+1S9t2zuMcIkmumuP0ZMURe+XDgm5iQC6QxuFpZrn6mnydEDQqtuqI
         GOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784264931; x=1784869731;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Kk0LSnTy6u9JE2Hs6bboN5a228uN9ZkdsFyoBfZC18=;
        b=pnCBYdoQnptmqaSQYuKprMEYWd80fkESFyatHVGx5zzh/NFJZZ4dOKPk1S1arepWbS
         WIf3vIA8OVo/u7G8sVirzUzrZj4FMQVmjbhNJbb0jgrqoHvqxo4Tuk9TXPKQEZAbFWmL
         UsDx/XEY9WHG1LufwG5CQ+4VVqZ+g32PlVTClEpZ/ctOUGqsF7/O7WY9iRqkLIH7DP1u
         NM4W5HGgNDyai/Cvab/RatMcC9NDmzZR4FntRZPp5lTHf+5tmzeTMK/0cX/tUMTIaI8p
         oJZYjBFg0RDeHaJz/YaHYIn3iL2mV4lIFGtuQHbpytIqsBkcCh5YT1c7mD6bvv14qm0R
         A/dA==
X-Forwarded-Encrypted: i=1; AHgh+RrRdVnsvgGbl4YH6Wljsc4thQVNvIsx6K5i0eQ+c9Oa6GAw3oms+Qdi3zYHN6EnuY/nn40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo9e3En94HAFq1b+wv/XuVIiPVZQM+p0jDSsftCcIHODfKGcYu
	ltyGgjJWduFGOuaOCPaTsfAeZabtSL0/dHdfdFACMjqDGDq5gaqnZFcEXp3Lo8V8mpE=
X-Gm-Gg: AfdE7ckfWWT5yOXHVkXxLUuS44gObyiQm5nHeOLNREFWsH0kReNJkx5p/IchxJluynJ
	h9n65CFbmU5GF4G8XUkBuYBCCEc4GaBY6RT9DK91ItKgdnASgGBoQmMAgVAHe9Z7Lb4fBsjjaXL
	nMMjaQlSfdob/tY41C/nQrjz+cP15S7zF4/Q+/2KHaoAYSkIfKeX7jqz2Ni7rr3LNyPJQYxN53S
	wmIwDcKthyq5v+G1gmXxeDL08XEyMJMaSqDQ+6v/aiztfXNWNucdHLsKnahGqRvsocXkTLIgIa4
	VvwaGNkkyu5BfDqfSkInIdyPMPDnohV9qGIYw2OIb0UQmD0j42NB09aweovFoxRYC2twnjR/yQx
	lNwV2xlcEwdr1bz4AIgRCxFkLsYaz3sTnbNHYGPfJTyeRziEgRA1r9KwwQlrZE51AAJ44MMzTof
	0iIBJFbln7QVAKf0PJoRRUeHBXXvoFzjKWbVdPmlFGWw==
X-Received: by 2002:a05:6a00:400b:b0:845:bda6:574b with SMTP id d2e1a72fcca58-84c292a0f41mr1060179b3a.5.1784264931283;
        Thu, 16 Jul 2026 22:08:51 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af6e48csm248690b3a.45.2026.07.16.22.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 22:08:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jul 2026 01:08:49 -0400
Message-Id: <DK0L4ONMR16L.29VHFM0R991ZH@etsalapatis.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>, "Quentin Monnet"
 <qmo@kernel.org>, "Shuah Khan" <shuah@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kernel-patches-bot@fb.com>
Subject: Re: [PATCH bpf-next v10 1/9] bpf: Drop duplicate blank lines in
 verifier
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Leon Hwang" <leon.hwang@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260715153254.92010-1-leon.hwang@linux.dev>
 <20260715153254.92010-2-leon.hwang@linux.dev>
In-Reply-To: <20260715153254.92010-2-leon.hwang@linux.dev>

On Wed Jul 15, 2026 at 11:32 AM EDT, Leon Hwang wrote:
> There are many adjacent blank lines in the verifier that have accumulated
> over time.
>
> Drop them for cleanup.
>
> No functional changes intended.


Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

What about the files we factored out of the verifier? E.g., backtrack.c
also has the same issue.

>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  kernel/bpf/verifier.c | 14 --------------
>  1 file changed, 14 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index de816063ae63..e1244a721194 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -634,7 +634,6 @@ static void __mark_dynptr_reg(struct bpf_reg_state *r=
eg,
>  			      enum bpf_dynptr_type type,
>  			      bool first_slot, int id, int parent_id);
> =20
> -
>  static void mark_dynptr_stack_regs(struct bpf_verifier_env *env,
>  				   struct bpf_reg_state *sreg1,
>  				   struct bpf_reg_state *sreg2,
> @@ -1671,7 +1670,6 @@ static bool same_callsites(struct bpf_verifier_stat=
e *a, struct bpf_verifier_sta
>  	return true;
>  }
> =20
> -
>  void bpf_free_backedges(struct bpf_scc_visit *visit)
>  {
>  	struct bpf_scc_backedge *backedge, *next;
> @@ -2291,7 +2289,6 @@ static struct bpf_verifier_state *push_async_cb(str=
uct bpf_verifier_env *env,
>  	return &elem->st;
>  }
> =20
> -
>  static int cmp_subprogs(const void *a, const void *b)
>  {
>  	return ((struct bpf_subprog_info *)a)->start -
> @@ -4044,7 +4041,6 @@ static int check_stack_read(struct bpf_verifier_env=
 *env,
>  	return err;
>  }
> =20
> -
>  /* check_stack_write dispatches to check_stack_write_fixed_off or
>   * check_stack_write_var_off.
>   *
> @@ -4840,7 +4836,6 @@ static int check_sock_access(struct bpf_verifier_en=
v *env, int insn_idx,
>  		valid =3D false;
>  	}
> =20
> -
>  	if (valid) {
>  		env->insn_aux_data[insn_idx].ctx_field_size =3D
>  			info.ctx_field_size;
> @@ -6683,7 +6678,6 @@ static int check_stack_range_initialized(
>  	if (err)
>  		return err;
> =20
> -
>  	if (tnum_is_const(reg->var_off)) {
>  		min_off =3D max_off =3D reg->var_off.value + off;
>  	} else {
> @@ -7404,7 +7398,6 @@ static bool is_iter_new_kfunc(struct bpf_call_arg_m=
eta *meta)
>  	return meta->kfunc_flags & KF_ITER_NEW;
>  }
> =20
> -
>  static bool is_iter_destroy_kfunc(struct bpf_call_arg_meta *meta)
>  {
>  	return meta->kfunc_flags & KF_ITER_DESTROY;
> @@ -11539,7 +11532,6 @@ static int process_irq_flag(struct bpf_verifier_e=
nv *env, struct bpf_reg_state *
>  	return 0;
>  }
> =20
> -
>  static int ref_set_non_owning(struct bpf_verifier_env *env, struct bpf_r=
eg_state *reg)
>  {
>  	struct btf_record *rec =3D reg_btf_record(reg);
> @@ -16421,7 +16413,6 @@ static int check_ld_abs(struct bpf_verifier_env *=
env, struct bpf_insn *insn)
>  	return 0;
>  }
> =20
> -
>  static bool return_retval_range(struct bpf_verifier_env *env, struct bpf=
_retval_range *range)
>  {
>  	enum bpf_prog_type prog_type =3D resolve_prog_type(env->prog);
> @@ -18363,8 +18354,6 @@ static void release_insn_arrays(struct bpf_verifi=
er_env *env)
>  		bpf_insn_array_release(env->insn_array_maps[i]);
>  }
> =20
> -
> -
>  /* The verifier does more data flow analysis than llvm and will not
>   * explore branches that are dead at run time. Malicious programs can
>   * have dead code too. Therefore replace all dead at-run-time code
> @@ -18392,8 +18381,6 @@ static void sanitize_dead_code(struct bpf_verifie=
r_env *env)
>  	}
>  }
> =20
> -
> -
>  static void free_states(struct bpf_verifier_env *env)
>  {
>  	struct bpf_verifier_state_list *sl;
> @@ -18675,7 +18662,6 @@ static int do_check_main(struct bpf_verifier_env =
*env)
>  	return ret;
>  }
> =20
> -
>  static void print_verification_stats(struct bpf_verifier_env *env)
>  {
>  	/* Skip over hidden subprogs which are not verified. */


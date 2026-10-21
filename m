Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792545408;
	b=wl2/g9qCBFKoMJkrj/2WpsSBJ1/ttOFDQTv6PhlJKImaxCxPx4Yx1bBiAGVTGB5t6+no
	 gGh+elnYJe5ry0k3f0KMqH4uQuZUtIv6vHbMSEuu5gK2/cNgFt6DayMf2BNqheAD1E1UE
	 1syaq/LOvU7+PcCCz6uRyO8ztua8VbUbb9oclpvqeA9R6xCpzpqTC0fINpCJ58tk5vR45
	 oIqCag510T1WzrjMH/rS4YtTR/OgvU4/sBOSbz0ga9HnuttYTRyndpSAsyeZ5sX9jWB6Q
	 soR3KIMC4hCLX9BWmZXDrCCKnCdz9J4Zrax75xN6gpspXd/W3gjuNaJUYQVoVjxGUHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792545408;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=HxqLkORV3PwHOzAiuThO0Q15jhetZ3Ew/zu8JJiVi7k=;
	b=X/C374V6Otm0Igu8PzCqax0vljE4PB92YLsw2s0IXVZ7yEFwg/84/kjF22OOPDfpPPlU
	 KBDWZvStD0K7jilZjEHsCPUF/p5kMYvABhJaDsXyvJeOtRyI/O0/f0laVB/DX4yQdk4ph
	 WA7IKpR+m0gCPcpZ3H2B/uDYvVXeatYBVYc0+1zObhbVjQ+E2nnHPgekA1brBglBztVL/
	 2hJBrtZmU2qGXH1VBBvv3ZOAb0Kb64W0MenTNtgETBm6qShAA9gviO+iqHkNSdrgqzYgc
	 EJmJT3nP5pc6kmbU6/lMw2E+6ILJoDixIuen4boh6rl3ejYgfUfiYLgkJd17k5tKDdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=beAsBT3a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.75
Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC818606A31B
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 01:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC818606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=beAsBT3a
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-48db8366c3aso76956f8f.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:16:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792545406; cv=none;
        d=google.com; s=arc-20260327;
        b=g/tvzDyKnLzIS5LcMswGhOUS0HN/amPJfUhHX/QdOooAAQGjeMgaGnQ4FcKKiW85ep
         ydF0K5HaQ2V2Y6aSTaQ5ZSK+bcpGNRpkZzH5MFKF7XhIyrP1GjuwD370bFjypYXYhN7t
         e/ZUcDCArH2FoxMVXLOUS6MTXWjFE1Oi6de3Wb+ANp9Rr1vxQWVOtoR9UlXnGxEm/bPF
         0pCx9Ql5ZwOkbxNBfY3EdvxTOXNI5aEs3WnUFwt0n600yCi5C6XIoDTioOTQCkcYOaxR
         iICfVU/jhiTzy4jcPFZH2xeJVUArIMqD2evuDx9z0nSa9iddqmStfQjwtUuJqG8VkWEJ
         J7Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HxqLkORV3PwHOzAiuThO0Q15jhetZ3Ew/zu8JJiVi7k=;
        fh=uAH1Fe/HsVckTo0kf55PUzXC5nloPKWu+GlJSL4ntLE=;
        b=gMQkC1ZzN4z9TGyg1H1vIpmvRou1EshiW6pJU/Rz0BxQlLRZT47o5ysULQwM4Y/Ynl
         LTWb0zAIASBQA56Tkr/h3Fsz7uQyl90nQNidDX6wOXj/cOZp9nybcX0LdcLQW7ry+gWt
         kpTXq4Hbete2E7riRdUEg4M1xPF4n02ErpdMFZRWjhEd5tNBo004Hg7xpz9mHs73r/SK
         7Qn1ITAzh2G7aB7ZtpIzi1nUI7euwecF01sTp814WuPA0R3tpzSFQ7O/UHeqP94McnhE
         UR4xHUlNQQ+Bz9w0wsMg8MPf6WlIiucZU7naIlS3/kV+LIDb3MPUV6C5Ej6HAA1qJe+5
         qlhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792545406; x=1793150206; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HxqLkORV3PwHOzAiuThO0Q15jhetZ3Ew/zu8JJiVi7k=;
        b=beAsBT3aYyD+aRBMzRCTp/Sd4kSLdXs+vuHnQONm/NdiwkWmX/7I9fmeJGjFqjXCJc
         Q8weid4V8ijcf1D4WFLflO5UI9ZPk8uT2F7aCXqgojtvuS8yymb1p82q+EtVh8gs3R1j
         1TutMkkf9s4C7vOUUR4hiAuAGTbThoSGLajhgumk0hfzK9Ln7MnXcGX9OpZUsFVVNQfj
         JJP+18IO/ppaHmqEUwqEcBY81UWYz7Ao47kYCq2bHX22qiIp6GlEjQnlW0HuKeuICpej
         gVgKiUvK1zzNl7f7x4gefejNK1Y0pNSezYpRgbqCXJOzhD3Z+0Mhio57sMBXIZytY9kz
         D4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792545406; x=1793150206;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HxqLkORV3PwHOzAiuThO0Q15jhetZ3Ew/zu8JJiVi7k=;
        b=LGmHFfXFUx2zc4mhH+0iLR/ZZ9ncaz+Kb6x7awEToovqzgKOK2TLeUfKoq3qEwThVq
         EZJ/HWcWdrM6oJw0c2P/IXs4kpOiHraSbX39bUoMoMJl77GjL4k4v0gxVk8Sc3WvYSQI
         kb+GRWjgp+lEQjdneQJEbk8pgwzVyHqzJ7IJP2ORHvFJzEyMyb43vU6n4SJww6HOhovI
         jWoET4/Cb/Ybjb5cCKYJ7qGV+ZLz2z75QXqAT2boOxu7IqbDrM5NL3IUanQbCyD+ly9g
         oSrJOuCM5plu0rScP5wbDsI7Q4fgacDTKk7RlqEjubVUHHsu2e1NlzzWUr9+l4kW7S51
         adbQ==
X-Forwarded-Encrypted: i=1; AKwUvBw4B5dq42cXD20QyMwLOpuA06x5eB8Ti4ddliURwJRmrplf28to1T9HS5Ho1PIAS3dm5hQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5WDw+YgWMWIaCfbkDq9zafIimXir9XUu4NF55bGFvMO6IT50m
	m3aYLEAatRAsdFxwyMFvOWLxLKLxE10PAf/uojJOo/vr3JDHzq21qnr2kuDv+79SWDSufEULM7q
	2MX+/p/rl2hnM8J7KaWpUFQjdgV0NRVM=
X-Gm-Gg: AYBFou14g1DjmPaTPmoZ9c9riFvPyvpeUrYw5u2f7v+BBxHy1lI20q7+DXxtUzIvia2
	xQYCy/vF+2fzyB4Q8Sx6KH24r6jMDlc9OY8CTROoO0/VglqoPMb9e3TqLckzU2d2e0KSEKU40K/
	B9AZ75DUseypTjqlMM8tTKy9kFbPIwyUCI1nGX0/Tc64+WrYiCZMGvsnLFrEOV8TpoOGgMRabAH
	GcdFxFOhDz/apV/s2V5JWI1uzPOa/vDbKQ6ho/uxtzlIauKnRYyPdDKeEYEUxYjsN+RnzP1hQpw
	fx/nTkFHCEkx8qY9DqqQop3a1CrZHQjCXJfG2a7tMWnCLuK9G5+bDxugRO58zl6zVdxIvYjuVvu
	Ar1agRPZlaqer+khsyu1zdYulKQ5IM7RltqktZqTnDfKUHIULKVssxBpDT52N9SzItMPVghCwaD
	LVUYF73bPsHo5lfaxhTpR8brqrjFwaow==
X-Received: by 2002:a05:6000:29cd:b0:48d:fd4b:cdd6 with SMTP id
 ffacd0b85a97d-48e264a7c37mr375570f8f.25.1792545405965; Tue, 20 Oct 2026
 18:16:45 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020145059.2146170-1-utilityemal77@gmail.com> <20261020145059.2146170-4-utilityemal77@gmail.com>
In-Reply-To: <20261020145059.2146170-4-utilityemal77@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 21 Oct 2026 03:16:08 +0200
X-Gm-Features: AclHuK_K5Xm8sAmH-AYY7GPbGPUkCACRVkryFSpARJ2cxbI30JD3SrlALPBIioE
Message-ID: <CAP01T77TTMfAExOxcVnyebdNKc1aTFw0yOXQbEW5zZYxKgMUEA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/6] bpf: Bind trusted fields to their
 parent's reference
To: Justin Suess <utilityemal77@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Oct 2026 at 16:56, Justin Suess <utilityemal77@gmail.com> wrote:
>
> A field in the __safe_trusted or __safe_trusted_or_null set walked out
> of a referenced parent yields PTR_TRUSTED with nothing tying it to the
> reference that keeps it alive. Releasing the parent invalidates the
> parent's own register but not the walked field, which stays fully
> trusted after the object may already be freed:
>
>         file = bpf_get_task_exe_file(task);     /* acquired */
>         inode = file->f_inode;                  /* __safe_trusted */
>         bpf_put_file(file);                     /* inode stays trusted */
>
> Set the walked field's parent_id to the parent's reference id, or to
> the parent's own parent_id so a chain of derived fields stays bound to
> the original reference. release_reference() already invalidates every
> register whose parent_id matches, recursively, and regsafe() already
> maps parent_id through check_ids(), so no other verifier changes are
> needed. An RCU-protected parent keeps bounding its fields to the RCU
> critical section through MEM_RCU instead.
>
> Fixes: 6fcd486b3a0a ("bpf: Refactor RCU enforcement in the verifier.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> ---
>  kernel/bpf/verifier.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 534200c0d27d..c85c83a6ee63 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6562,6 +6562,7 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
>         const char *tname = btf_name_by_offset(reg->btf, t->name_off);
>         const char *field_name = NULL;
>         enum bpf_type_flag flag = 0;
> +       u32 parent_id = 0;
>         u32 btf_id = 0;
>         s64 min_off;
>         int ret;
> @@ -6716,6 +6717,11 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
>                          */
>                         flag = PTR_UNTRUSTED;
>                 }
> +
> +               /* A trusted field is pinned by whatever pins its parent. */
> +               if (flag & PTR_TRUSTED)
> +                       parent_id = reg_is_referenced(env, reg) ? reg->id :
> +                                                                 reg->parent_id;

This bit looks correct. While you are at it, there is also another
related case that needs fixing.

        file = bpf_get_task_exe_file(task);
        inode = bpf_real_data_inode(file);
        bpf_put_file(file);
        mode = inode->i_mode;

still loads with this series applied. bpf_real_data_inode() is neither
KF_ACQUIRE nor KF_RCU_PROTECTED, so check_kfunc_call() types R0 as
PTR_TRUSTED with program lifetime and nothing ties it to the file:

  6: (85) call bpf_real_data_inode#65472  ;
R0=trusted_ptr_or_null_inode(id=3) refs=2
  9: (85) call bpf_put_file#65416
 10: (15) if r7 == 0x0 goto pc+3          ; R7=trusted_ptr_inode(id=3)
 11: (69) r1 = *(u16 *)(r7 +0)

The verifier cannot infer that relationship, the kfunc has to declare
it. Current proposal is to add a __derives_ret parameter name suffix,
in the same
style as __sz/__str/__uninit:

  __bpf_kfunc struct inode *bpf_real_data_inode(struct file *file__derives_ret)

At registration (btf_check_kfunc_protos()): at most one argument carries
the suffix, that argument is a pointer, the kfunc returns a pointer, and
the flags do not include KF_ACQUIRE or KF_RELEASE (an acquire returns
its own reference, a release has nothing left to borrow from).

At verification: in check_func_args(), when the argument carries the
suffix, record the lifetime id of the register passed for it, which is
its own id if it is referenced and its parent_id otherwise. That is the
ternary you have in check_ptr_to_btf_access(); factor it into a
reg_lifetime_id() helper and use it in both places. In
check_kfunc_call(), after R0 has been typed, set R0's parent_id to that
id for pointer returns. On the PTR_TO_MEM return path, skip the implicit
ref_obj inference when the kfunc is annotated so the explicit annotation
wins. A program-lifetime argument has lifetime id 0, so the return keeps
today's behavior, and a trusted field walked out of the returned pointer
inherits the same parent_id through your 3/6 patch.

Then annotate bpf_real_data_inode() and bpf_kfunc_call_test3() in
bpf_testmod (it returns its argument), add a section to kfuncs.rst, and
add reject/accept tests for the real_data_inode case next to yours.

One known limit: if a KF_RCU kfunc ever borrows from an MEM_RCU
argument, the return should carry MEM_RCU rather than PTR_TRUSTED. No
such kfunc exists today, so this does not handle it yet. It might be
better to future proof the handling for this so that we don't run into
similar bug later on.

Also, the last sentence of the commit log about RCU parents belongs with
1/6, where Alexei suggested the __safe_rcu_or_null route.

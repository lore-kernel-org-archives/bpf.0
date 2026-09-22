Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C5048F02F
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 21:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790114294; cv=pass; b=eZ0OJIF4F7wCo+G0PHX4L01EVHowJqZqjpRMYnVWnt0KOwArw6pCBzWnTpB97R9kQf6xMJlckclDzc9f3Pj7M/5pfT/0j/9xgPKRY3mKQSHUN3Z/QKU+QwLdSGdUjlZj+r1JyR118JTtbzZvKBCoYBwCcwJVyF1JVVnSpei8hzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790114294; c=relaxed/simple;
	bh=opoN1DNpZ9J7XAOXSrrZEYlrtkp6IUShblxKpHJzhkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XKDvhAG3YVj9MQMuhZK0hRbGc+L8+00+v1aSuT2n71llFczkc9qEoY5QLCeChNRI8K6oMMT9NDnKO/96UcDC6PFejdQRuzt9dJHNZl/Yb6SjAq6NWMJFfuXgtlUfBizwNrWxw5kn/nNYhCWRKU1KpdZIWkz3b6L5tLADzDnezIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hagmlsfu; arc=pass smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hagmlsfu"
Received: by mail-oo2-f43.google.com with SMTP id 006d021491bc7-6bc475ffcf6so175564eaf.1
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 14:58:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790114287; cv=none;
        d=google.com; s=arc-20260327;
        b=Jh68619SmTwGCCFWzJWXbb8dLanoyyCzkY/aGNJ5VUS4qGWqx3r4aFGVbl31qDt22B
         HGL4NU2jYCHinPuhUWt8jya2GlBcOL9GRamK3RR4WwNy+Fyfcb1jqX53/VfgBpbbxUY3
         TYrT0JYuBOY7fIxBUjj93kCpjUUFvTZCaz627wZ6tydAkb2ieELBSlKZw7vCsvxn7tdh
         K+qItEzcmZ3Ipv5FOiYtt4Ejl/vMecwQHDtdLua8OuVlLHwEiPJrBq6kuVRVaqPZWxOg
         smD/knbRMCZXbrpZ+NlVxGAWAaR78z++AKjCAA1gVlNkhbDGv75AmhPgoOKVrlMHyLGW
         CDEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mNzyVTMtwl2Y+ZZF4UZqBeV07F0RWugYWhTdRT4SLYE=;
        fh=Mn4Kp/tm7wGzuMnNO6K1cvcBgh/rlyOQShpIgHQn+LA=;
        b=rpXc+56Vz1v4JELjczwwSgBvzsZMHE5TMVma3pvaO6rLcqCBqgledhaQ6YDLXK9122
         ROW7R71h3IS5MhIRD1LBjjVqzg/YGnkvm3yPfMCLnKTAx8dg2eo4by4actT7HmD0XBgX
         k7/eFZz8aqdgb/56GVDl33+jth5jz3Kvg4OxG1I8mqwosqWYeabmWyrHn7aRhKRdyhT6
         RfsgaUxrLVlKJh4/zWqwngEQcXPj14xyBrTV4sM1Zdwd+/x0b95S6nJecERsDTH9wjnG
         UAW+s0tciXbswAC3d7dWY/KdHyVOmL4W/ynDtTwQ6+pnxWo36Q8YHpggOvHudXNLtCto
         yMEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790114287; x=1790719087; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mNzyVTMtwl2Y+ZZF4UZqBeV07F0RWugYWhTdRT4SLYE=;
        b=HagmlsfuC/VQKAg1a9yA+Gzy+OeSpMt2MtckzRsnBVDgWDk26NlzNsbJvygrN+Df0A
         s2aOFlFdQHXYeA7cRaFBrj8Sajix94c1ZSa9vYLQN7kSpUTVO3/sNC71P4rjDN11utv5
         gKsJtd5iZ1nB6j24tBMhq1Wqd04tcys0tYabgLsOymxuzHYvhr/HRf5vgzChe2sajKCb
         3A4ESd+I/qiCYAMilIjaHN9vYr+h920iUKTzLZEvCOL1/0bsCJbn8J91x4HLKyzDku/c
         iS0mjcAeRpQVO4I0Iah3H1+6YYc3DyRUVhvJfDPXqBIXL7WWG/S9wMZXctaNtcwUlwWk
         wuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790114287; x=1790719087;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mNzyVTMtwl2Y+ZZF4UZqBeV07F0RWugYWhTdRT4SLYE=;
        b=P0Nz33XrwgMTh2g4Go2rsBrIL7cof45jhqcVsGSpVePKFm5lJCZgnSU9issf5wmJL7
         D81KE3w8CITryCek81Aq37/hdxs+QhOhfNJRISlhWrCiS0xo1UC7mI+SLK7SB0J23pGX
         rq2evRXvMCXp1NY9dd6ue/WdJl7OIu0P/Z+ZNMJIXSXUKWLHXVKmRRap46Kle4K8g8ZY
         qnCE86w3zBqju3R5zvSUXUWuDX8/vOXn2Rno0DyMzOyU9+qAI48x3n2VMfJUURhk2cjH
         87jjbQoDlP6/04kaEtSjaEGOYg9NfrVqmpgpzCB8BurYg5y0BnvjMgkCDEV1DnCekmPt
         jsRQ==
X-Gm-Message-State: AFuF++k5AOppY70zR5FoMoqtRoG9SKz+8DIQsrsJBuVLKiR0J7RolhoR
	6Y6HY56gN7BfnF5T0S/DLQ2VxfK0i63AGPN3AffzySgJ1RAdT9ZF2bWeXPHi8YHkNAhxNmyV8af
	lghbRpeG7QrQzSR1mJZGHfN0z94aRxhQ=
X-Gm-Gg: AYBFou18XkmJrdirb5JOdWTnipduMnf4in+0VjbSZTn/iwkYVcc5KdvZHsDrd2+ry/K
	i/ru0rRWvHKNNy0ybRJ4Icejc7DnQZ004w2QYYbPS3EwII1SwyjckwyRBVhYktelIL01K2MZQ7I
	tzfGXyaP8PY0/sq+asgURSmej3knFVfnWNaKc3vdy6aTjYw78y8nCefanJnJ8cWxvvhfnFhoQD+
	K5QQAqfDmpKgwSiMrm4zQbYgRIDljaA/Ute+/Hmi9fW4U22ILFsgOZlNOHgwSCaaiGkOahqj5YQ
	FDXEKfxc07D8B+aELHoKwFjyfNIMzhEAtT9bCWcpKf7mpYKeKUrC1o4ewT97E0ZZYGNItrQ=
X-Received: by 2002:a05:6820:1a0e:b0:6c9:80d9:5e8 with SMTP id
 006d021491bc7-6d2d2622425mr558704eaf.41.1790114287094; Tue, 22 Sep 2026
 14:58:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920210438.345847-1-xyx2021@mail.ustc.edu.cn> <20260920210438.345847-3-xyx2021@mail.ustc.edu.cn>
In-Reply-To: <20260920210438.345847-3-xyx2021@mail.ustc.edu.cn>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 22 Sep 2026 14:57:53 -0700
X-Gm-Features: AcwNN1Xr8k72KFIT7lbJuwcwf1A6aO_tW7b3aY1WqJ2MAzoLJEDyYVobi2D5Pz8
Message-ID: <CAMB2axOEZjRV1K4Yxb4=1f2jvPHiD2rVy-+byXbvs3G0qat63g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/2] selftests/bpf: Test dynptr teardown on
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
> Add failure tests for slices that escape a subprogram from a dynptr in th=
e
> callee stack. Cover immediate use of a ring buffer clone slice,
> release-time invalidation of a caller dynptr slice after it crosses a
> subprogram return, and immediate use of an skb dynptr slice in a qdisc
> program.
>
> Cover the error path where a subprogram would otherwise lose the last
> dynptr capable of releasing a referenced resource.
>
> Also add a success control which derives a slice from a caller-owned dynp=
tr
> and creates a separate clone in the callee. Destroying that local clone o=
n
> return must not invalidate the caller dynptr's slice.
>
> Assisted-by: LLM
> Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>

See below for a few suggestions on naming and writing to improve
clarity. The rest looks fine to me.

[...]

> +
> +/*
> + * Destroying a local clone on return must not invalidate a slice whose
> + * source dynptr belongs to the caller.
> + */

Specify that the clone is local to the callee: "Destroying a
callee-local clone ..."

> +SEC("?raw_tp")
> +__success
> +int caller_dynptr_slice_across_subprog_valid(void *ctx)
> +{
> +       struct bpf_dynptr ptr;
> +       int *data =3D NULL;
> +
> +       bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
> +       caller_slice_in_subprog(&ptr, &data);
> +       if (data)
> +               *data =3D 123;
> +       bpf_ringbuf_submit_dynptr(&ptr, 0);
> +
> +       return 0;
> +}
> +
> +/*
> + * A slice that escapes a clone's call frame is invalid once the local
> + * clone is destroyed on return.
> + */

Likewise, "A slice derived from a callee-local clone is invalid after
the subprogram returns."

> +SEC("?raw_tp")
> +__failure __msg("invalid mem access 'scalar'")
> +int clone_slice_returned_frame_invalid(void *ctx)

Can you use a name parallels to the test above to make it cleaerer.
E.g., callee_dynptr_slice_invalid_after_return()

> +{
> +       struct bpf_dynptr ptr;
> +       int *data =3D NULL;
> +
> +       bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
> +       clone_slice_in_subprog(&ptr, &data);
> +       if (data)
> +               /* this should fail */
> +               *data =3D 123;
> +       bpf_ringbuf_submit_dynptr(&ptr, 0);
> +
> +       return 0;
> +}
> +
> +/*
> + * A slice from a caller-owned dynptr survives the subprogram return, bu=
t
> + * releasing the shared reservation must invalidate it.
> + */
> +SEC("?raw_tp")
> +__failure __msg("invalid mem access 'scalar'")
> +int caller_dynptr_slice_release_after_subprog_invalid(void *ctx)
> +{
> +       struct bpf_dynptr ptr;
> +       int *data =3D NULL;
> +
> +       bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
> +       caller_slice_in_subprog(&ptr, &data);
> +       bpf_ringbuf_submit_dynptr(&ptr, 0);
> +       if (data)
> +               /* this should fail */
> +               *data =3D 123;
> +
> +       return 0;
> +}
> +
>  /* Invalidating a dynptr should invalidate any data slices
>   * of its parent
>   */
> --
> 2.43.0
>

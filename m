Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E743936212C
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 18:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781028045; cv=none; b=YlU4xe4PtDq1rFIjiN+dfzwQ6OX/wZlXoP6toQ9EKjBJ6/UaOC8ZScY4cuW6WszzQO4uSnBibLOylaH8aucU5D8SC+RRA0qK8FL0/Nyhcxgci3Y7pPoTPp3eAD/H+EvNDoFd67sIWGM+muAVbBs3LsHM+6Fax3HS9dqIldt33cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781028045; c=relaxed/simple;
	bh=B7evdCIZt4OnEsN8q2gu/FQza/5MBUo2CkfD+rhDGhE=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=CqdnsDlxCjzKpOKqJpVawH9uz2EuZLHq6UAaGX7ihZ6XGjRqSwThT3ZU6YEh7CWlsLeg1mpxjbBlfBqJRZWufn2hG7EmLa+F64XarSGPbnbGR4APYTdoPow9lqatlJ7OzVDP8lIl/wYEan8v+heR4zxzLjRSz1NCLZnE5Rl3zCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLshcWHP; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLshcWHP"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e615efd7d7so5274331a34.2
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 11:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781028043; x=1781632843; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6A5NE+0IkSLW3UTw/XgPu13o7JqeoGAggPRE51syJs=;
        b=BLshcWHPYyZLMkzfJXvX/w0RsSpnD8TXrpZBw8wgo+nsw+40TcD9P4c0s2WDTxzTSt
         piAsEULT6Z6m6uuWof9FU3Y5/G7QFgd79zypITA8yAsW77ZZq7J08pcInhsQ80pVEvqF
         Iw7PkKDmkA7q6lFgebMxnVGOfoKxeYf53y6mVp437vv5dfspeUZzfA1HT9UpT2SK3/QV
         iB7zEyswxi8mKnmUIbx+Jw+jty1DTPg8C9EvBJMB9+1NyvGX3brGb5pfyAIW1xHhIB76
         BWA4HHBdXbx+8WvGceS41NJyjUYbbXngqrqGTO0cAF5OHRN6f7ixaGeRHKiApqJ8PYyC
         Hrug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781028043; x=1781632843;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R6A5NE+0IkSLW3UTw/XgPu13o7JqeoGAggPRE51syJs=;
        b=C+ADSh6u5wADksbggi+EgNBQn0IQVUGa5T6nn/D16h6IhjKu5AZ4X9fyai6H2HJRad
         FrCJNQBxDPGFoTotoncxmiYool5uTNRRo+GbYgwSLhPwIRfqLZpcVZ5OoUSrMybnOUC/
         x180FqjEpSsn0b0eOB4+BDss0jkWs8bRBWYacYeYyG6fOFR2P3jEE/hkJy9aQ8MdyWQO
         QkWfbYyLR58ytYEcXZtxWRajOwHbsfksKjzfFxyh4h/MBQUrDyVdCaLk0TW579/k+Ukq
         b9Jis3cluZMm705C9oN0yNGlgResUCSGHWl4ZcTiX6+aR1Lt0PQETnk2EyJQtdYOvv3b
         Tzkw==
X-Forwarded-Encrypted: i=1; AFNElJ8IgorDcDq+S5DiOLPS2/A4SFao0meYzyANk0Tw8xFcq4YVcln/j7WclG4cnm7ThmqrcqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYBXEIBMxTg9cP+PixjPIkoFTrZgVm3bsP6Wo2GrsAxqt38r15
	iVCQXpkQMSDzm5eUy1FkD+7jtsyMUemAKT/o5JsliEtZ9KKX3dA4k6c9
X-Gm-Gg: Acq92OEJOseaCtnyjn7JWMEgjvArBl8l9+QYiVke16XtfYjugAKiFfDvEkEBqV2rY3k
	WF639pK6gT/sv9Ti09cmCRG+73nmC2u/st6KpUhkoFATYN4W2Hv6cWllp6bXeGbZvR79PSun8jY
	hAJ2IjEsLgcNTWokc7cI4/m3C5Rl1nfgZqDJVMv3vejJyfc2NMfBzdrLY21rwkUfWUyVhJMBK3F
	xuXpi2ufBjmObR4CyeuAG0JvEjl/JeYM+D/d7/wQg+Qx22OanhqBc80iimrIV75eVzT9pkrXKze
	seQ3gkfKYN5K7mHbP9hSY2SIzbeFrU3m/6wM7nZ4wvN8c4r+hkvYQo7ycrlG2VniXUH4wtKVBc2
	7YslHH98fs09EBKZqHDnU2U+akyObD/H+Uj2fyb051qrwZOHHgRipp62OXqvD8vu/ubi3OMDEu3
	RiwQMp1q9bkqHty/LRg8mwXZw5/La7bdlAMljDwGAVYB4teINrmtQL9Ua8yx3YRvqc/ZUwEBIyt
	6gy2HT4k0qAimTgepXRazl5ntsq
X-Received: by 2002:a05:6830:4122:b0:7e4:230:96ca with SMTP id 46e09a7af769-7e70c7fe87bmr15498666a34.21.1781028042660;
        Tue, 09 Jun 2026 11:00:42 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:46::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e78de8bdsm14527379a34.16.2026.06.09.11.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 11:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 11:00:41 -0700
Message-Id: <DJ4PQYTQDWQT.1ENYNRIC3C7IH@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 <kernel-team@fb.com>, "Martin KaFai Lau" <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: Keep int return type for
 tailcall subprogs with maps
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <20260609163947.1717694-1-yonghong.song@linux.dev>
 <20260609163952.1718472-1-yonghong.song@linux.dev>
In-Reply-To: <20260609163952.1718472-1-yonghong.song@linux.dev>

On Tue Jun 9, 2026 at 9:39 AM PDT, Yonghong Song wrote:
> LLVM23 ([1]) supports 'true' function signature in BTF. The return type
> of the caller of a tailcall must be an 'int'. Otherwise, verification wil=
l
> fail (see check_btf_func() in check_btf.c). So with llvm23, it is possibl=
e
> that the compiler may change the caller's return type from 'int' to 'void=
'.
> To prevent this, barrier_var() is used to avoid returning a constant pron=
e
> to be optimized.
>
> Use Array map to store the subprog return values. Otherwise, due to
>
>         data_map =3D bpf_object__find_map_by_name(fentry_obj, ".bss");
>         if (!ASSERT_FALSE(!data_map || !bpf_map__is_internal(data_map),
>                           "find data_map"))
>                 goto out;
>
> in prog_tests/tailcalls.c test_tailcall_hierarchy_count(),
> the test result will be different from the original one.
>
>   [1] https://github.com/llvm/llvm-project/pull/198426
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  .../bpf/progs/tailcall_bpf2bpf_hierarchy1.c   | 21 +++++++++++++++----
>  .../progs/tailcall_bpf2bpf_hierarchy_fentry.c | 20 +++++++++++++++---
>  2 files changed, 34 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy=
1.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
> index d556b19413d7..13b0ee9475a8 100644
> --- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
> +++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
> @@ -11,25 +11,38 @@ struct {
>  	__uint(value_size, sizeof(__u32));
>  } jmp_table SEC(".maps");
> =20
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, 2);
> +	__type(key, int);
> +	__type(value, __u64);
> +} array SEC(".maps");
> +
>  int count =3D 0;
> =20
>  static __noinline
>  int subprog_tail(struct __sk_buff *skb)
>  {
> +	int ret =3D 0;
> +
>  	bpf_tail_call_static(skb, &jmp_table, 0);
> -	return 0;
> +	barrier_var(ret);
> +	return ret;

I think it's missing the actual fix.
bpf_tail_call_static() should return 0; instead of being void.
And here, instead of barrier_var() tricks,
it can pass the return from bpf_tail_call_static() further out.

>  }
> =20
>  SEC("tc")
>  int entry(struct __sk_buff *skb)
>  {
> -	int ret =3D 1;
> +	int ret =3D 1, ret1, ret2, key1 =3D 0, key2 =3D 1;
> =20
>  	clobber_regs_stack();
> =20
>  	count++;
> -	subprog_tail(skb);
> -	subprog_tail(skb);
> +	ret1 =3D subprog_tail(skb);
> +	ret2 =3D subprog_tail(skb);
> +
> +	bpf_map_update_elem(&array, &key1, &ret1, 0);
> +	bpf_map_update_elem(&array, &key2, &ret2, 0);

I'm sure there is a way to do this without introducing maps or global volat=
ile variables.

pw-bot: cr

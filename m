Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50265331EB8
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 18:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781028825; cv=pass; b=XSywQYp2V6IPzNNl3Ll/Osv9UIW4CWJr/ZKFF7+l+MRD1X7ylSMyjeWRAttyqq6hbhnmdNkXe27go8JlrEt3x+5Knw2Y4tRfhTkN2vHhrzcfRz2sh+rfuqf5mRcZDot3fQGL+nyVZZ/hsK3JwnQXIiVaLfkHdiiCV87GAwnykoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781028825; c=relaxed/simple;
	bh=xxBGXw+PNT3Zl+Vw0C1KBdKE5X2im5R1dbmuUa6lXBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jhWL+64J0lyE3pvIpuCvkUuGpa0d6JTWLYJ8OXUNTOS+6RccK4Ygk2CME75Od/ypU9R7q2HSbFVoWjP/wt2WWtaLsiYT3NyrHrj7IlrAfrE26KjgA1APwGZDog+WrWnjwe5/15sVNX8rpzDDZC1WBlRX5RtKbFqZ+hag6pfxXi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqKeaO2Y; arc=pass smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqKeaO2Y"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4859b1fc7a8so3137158b6e.0
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 11:13:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781028823; cv=none;
        d=google.com; s=arc-20240605;
        b=bqzhuiucrKs6oDzY64dvuBqSrR2DivMsGqcmJFASIAXz9PXdllJKAZvke61rNgv+ul
         8HtBKJ/e8xAdw/ytGPzKgWJNl1bvpBtTzQuuAgHHG58JzhpHKWPhdeR0aVSLEOU0sBWY
         cAy/39ozElQJ+FKL7fqYZoRaHInBN7PCskqQIHPVkHnTotZIyO6zwKmFelyqZEaxLQet
         Ql6xgynPnYshe9jYZzGu26crl1lGC6MOmzujQKz8WFhmLHYP0XFZo1f3+QO5CAU3bQdL
         BzS5jMi9/o/8s7pFEele9bMeXLgH1WFUv31nvjskGrvKbNckLYyGnbI+9NNcK+3um7Wu
         q76Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GCvRu8hrzkQXkGuDEEG3s72p2aRg+M0r+vkoBe1Q+hQ=;
        fh=QhQSFghT6mPLuf8Nc7OU5TqaDM4pdFr8dYwjtzUtNOo=;
        b=l2Yl/KYl2RtYN4EFxsgT+urkji6+BI0WHyjujo8xcuPnqF/G7/wFioB7O70V+IX8jr
         CF9usboycydK8nRMtd+eQqIzNkr5C+KfYnod0fANt22pbgGFuAsOVvjL0q3mYPM3UHfc
         +B/9Bq68H1N95vXXamxoRWfZiqhok5Rq1j+islvyY/tEEM4O+hbEdtnmshGTR6L1cPl8
         1SKkY5oXO4ZnTwA3LbXDV48xmGbgxeDqW/k5WdtyCeTU2tD5FJrLdOP0pmIdqU9XUSBM
         fbZgXfFb8BK8U5oypSs72YpMxnC2pVxeTXkqL/IW8GLhsAF4tSDdeSq+9MQE6/z7GBrP
         MZ7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781028823; x=1781633623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCvRu8hrzkQXkGuDEEG3s72p2aRg+M0r+vkoBe1Q+hQ=;
        b=SqKeaO2YQyltOLqAvzKIKVk5axiohHpTO5pyQKiHLXXFL2sXSKya1A4th2udCbwsbU
         U/m+gWlL42c39Q2GkKskZN/04QRRsIPHzqlIj6yspB42j4sJltebBmDOUFPYDoHToLaM
         xOOTTpFWqFw3PRiYp6LJTwtvRAYH3AE5CjctilVFrvJxHpWcGc6TosP3wDQGJ7PIjnkd
         C3uzjwpTYrNGGehv6RFxoH2jYJJBpguSfQMpRgUcplx7iUoPtwIcEEPp0qBbCnGPyYrf
         pReD8ZIvFwa8282K4mXHOuWc9VjZPiLsm8VRRgI3KBa89njkDpjNatO3jUh+hpqY/0P2
         94bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781028823; x=1781633623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GCvRu8hrzkQXkGuDEEG3s72p2aRg+M0r+vkoBe1Q+hQ=;
        b=W5D1IWw/r04ywPVUS9zT3Tenw8olfqx4X7GJIidqKj7/5gNv0AJXx36/Ad9fIyGhEv
         99ZJ+AB4sd2HeW6xPs2q3qSTOj8c9vSSQg9CTb5twdVLQ+m6kNmhgP8NmSpEuv6zSuUH
         /FXXv6mKmhmx8+TzmWUxN8CYKYrsJMTIf2cCAfp2lGqlQAkmJtY+NlZNowod7KzlplqP
         xgL1kcxbMG8sEwmVn1qU+jupp5Kp+pjeFPynTrZOegMWK5Jxyo60JbI8rV6QocupGBdA
         CynRNt87c68+OUwISqskIawT8acXqHU3T1Bhhx8yvjTi94sbw4qQt1Z8GfUYjHxAo9Fq
         GYSQ==
X-Gm-Message-State: AOJu0Yy6DNWtTWJnsZFFx2PJ0iAG6BpbBflvcHbdJS5QITzNxKUW6Y6B
	1F/eI60L6NmWoH2blzMwReqmzygVFViNVb8L0bTCu13UOCj9J177JUo6B6mK+vDwq082aZ89z0x
	nu+iKXG9s06Wg7wEYaz5hzGB5JR9Yw3yvNH+e
X-Gm-Gg: Acq92OEycxy+jwGMr9i8mpk8iR3ChqydL4YwomLHTiyD98U3RNfdOeOv9tZJCB1wjkv
	3dsKZOc4m8CXcvF/a7cfTToIek21ELFVzjmsabk3UOirH7Aw510F7x65vMI/VU9eIVaRrANq108
	Oej+uxMjY79JZOnQXBBIjdSHLLXzMYb/Wew5c83zEGjda633DtbyzWwNSAVx9l4aee7Phdq4uRP
	rPhl2IKtDj7e1kuDNzx19zcD5oEN8KziPyQdB5TOdy68QXE6ICrADZo7vKpUdQOJtKwIHfb4nw8
	kQE9ZjE4WCnKCCxP0d2eRIeNVCwj
X-Received: by 2002:a05:6808:4f09:b0:479:da53:2263 with SMTP id
 5614622812f47-4868e02bc81mr12338690b6e.29.1781028823200; Tue, 09 Jun 2026
 11:13:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aibX7BzvtbZYoZcY@stanley.mountain>
In-Reply-To: <aibX7BzvtbZYoZcY@stanley.mountain>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 9 Jun 2026 11:13:31 -0700
X-Gm-Features: AVVi8CddKhW45DsQgNu-Lm5fVTfv856BkpSAQbH-uKw7Sb7B1xbQwn1MldG84RU
Message-ID: <CAMB2axPe6Rx2f2wUeePGedBzb5Jr4cKuD4rAnSuk6Q2b58mtgg@mail.gmail.com>
Subject: Re: [bug report] bpf: Refactor object relationship tracking and fix
 dynptr UAF bug
To: Dan Carpenter <error27@gmail.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

"

On Mon, Jun 8, 2026 at 7:55=E2=80=AFAM Dan Carpenter <error27@gmail.com> wr=
ote:
>
> Hello Amery Hung,
>
> Commit 308c7a0ae885 ("bpf: Refactor object relationship tracking and
> fix dynptr UAF bug") from May 28, 2026 (linux-next), leads to the
> following Smatch static checker warning:

Hi Dan,

This is already fixed in bpf-next in commit a3863aa4f55e ("bpf: Fix
dead error check on acquire_reference() in check_kfunc_call")

Thanks,
Amery

>
>         kernel/bpf/verifier.c:13115 check_kfunc_call()
>         warn: error code type promoted to positive: 'id'
>
> kernel/bpf/verifier.c
>     12810 static int check_kfunc_call(struct bpf_verifier_env *env, struc=
t bpf_insn *insn,
>     12811                             int *insn_idx_p)
>     12812 {
>     12813         bool sleepable, rcu_lock, rcu_unlock, preempt_disable, =
preempt_enable;
>     12814         struct bpf_reg_state *regs =3D cur_regs(env);
>     12815         const char *func_name, *ptr_type_name;
>     12816         const struct btf_type *t, *ptr_type;
>     12817         struct bpf_kfunc_call_arg_meta meta;
>     12818         struct bpf_insn_aux_data *insn_aux;
>     12819         int err, insn_idx =3D *insn_idx_p;
>     12820         u32 i, nargs, ptr_type_id, id;
>                                              ^^
> Originally id was int.  It needs to be int for the error handling to
> work.
>
>     12821         const struct btf_param *args;
>     12822         struct btf *desc_btf;
>     12823
>     12824         /* skip for now, but return error when we find this in =
fixup_kfunc_call */
>
> [ snip ]
>
>     13112                 mark_btf_func_reg_size(env, BPF_REG_0, sizeof(v=
oid *));
>     13113                 if (is_kfunc_acquire(&meta)) {
>     13114                         id =3D acquire_reference(env, insn_idx,=
 0);
> --> 13115                         if (id < 0)
>                                       ^^^^^^
>
>     13116                                 return id;
>     13117                         regs[BPF_REG_0].id =3D id;
>     13118                 } else if (is_rbtree_node_type(ptr_type) || is_=
list_node_type(ptr_type)) {
>     13119                         ref_set_non_owning(env, &regs[BPF_REG_0=
]);
>
> This email is a free service from the Smatch-CI project [smatch.sf.net].
>
> regards,
> dan carpenter

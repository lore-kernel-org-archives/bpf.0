Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B88C35CB6C
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 20:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773694637; cv=none; b=Dc/7UGXEzNLQr/wskEmcbOL8Dws+taBc1b6plxOCNgJjh29UOKc414J5AO5BQNTB6K3JECB3E2+Ujc3HV+6x6CCCVqIZ033kd57/ROKym72TTXdVqsSSwMmFCdwuyUqJKwKKeoTo64dOe3KpaMUkU6NWAg/9xt2rKIs/opZNuPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773694637; c=relaxed/simple;
	bh=D7y7XQHaMsKBo0fZQqrBDSh9xP5an1NYpg26xhytOSU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CbFl1XChDLKPN1gJLsY8JCsOzdpWsXsblCr2MLIjmjaJIYZlDaabdJ947o+vatmuVS7LMHDbYb3eAeU+3zeNtUQ4/FK6O4dHzK9Ct/5raajoN7scZMKO+v88kENKERboGXpBt68S7OMhVzk95p+yjNKFvNLQfar3izcKUhL51Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxKeZcfl; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxKeZcfl"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b4520f6b32so7123458eec.0
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 13:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773694633; x=1774299433; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D7y7XQHaMsKBo0fZQqrBDSh9xP5an1NYpg26xhytOSU=;
        b=kxKeZcflp/SHR4lUssQjDuTWXRttu1+Poob7OSllmhM8+H/K72CSenYPxt2tYt9fVe
         PTh35w2UXDXngRtpt47/tcz+HcIhjA61K/XCmyDvK6suYTVhl2CKCrLS7mGSnOegdAhO
         iFM0PwYH6o97QoPtqG88GR+iwXqq8kRoAOQ2CFWVZyF+Eb9qLsxNJQHkWiagkggkZk3P
         s21V0w0dXzdO5PBKaNXF6RWVW83myxiwax0FTNFI29wTNAUzzA49SqM2olsD+2X88SsF
         LRnxr9LqVXmXCfuWNC8HGyPQDo5b03t7UuRvMDoRFU9w4L3H2E6/+XcDS/Y/u+H/2s4H
         6xuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773694633; x=1774299433;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D7y7XQHaMsKBo0fZQqrBDSh9xP5an1NYpg26xhytOSU=;
        b=HuJd/DufS6jFnme85nEvS1WhiFzrqblyRIxmSO0wmQG+iiumnUiCQseS4rXIdtjm4m
         joKWPaTshfSMomx/JAUysndTPUdviE6QDsAvo6xf2mOF2xr5kuRT4QGfWZEkLT7JEWcL
         lwIAvnFb5N1PcWglf+hrq8y7y6b5TL0KKGPhX9OCqyV7CI6P3WwdLXeQ91lWxmlrYYnU
         fFd9ceeBnHkVSIgq0uKnnAhItrdY4JoBVkuGHpU7YioxXCWGzMv6ENyil4RsjzDoBJuO
         TsEodMaxEjgUsVWBdOtMsaehUmSOyH2Nw0EyJb9O+2AL9+MbqBNwSRk5VXYZ4dEE1Jvv
         R+fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiPFGRzvNKKwlj3CP8DxwgKyvfDwjuANoRJO/PTUpdGX1BbOYMeE3VH1V4u2B4lCyDhjg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq8j42GN1Pp9Rts7sA4DM0D6S6w/q+Lda7InOojJKSBadpuvs0
	spK5TmKjX31nNNa9fAQyOjtuaKB5JBqnul5Iv44XlwENGkZw8cm9NihN
X-Gm-Gg: ATEYQzwKQz7CZGgGCI3Q3VxHxcH7U/+wJVFD4eFhrB+T7oTiPlQydQj2Gx0eJxMzYml
	Dq9vRwgEgeTbw/XgQRlM8e4fveBxZ/19f5z0N7syC0oSIEg5QaLbah6qudVJvxrWUvNATyj/lxk
	lr/xxooRBkRUyHZ6OTGBlyxTHXsGVgsTdJ9fheG2K7/YMyICGxSFzbsJrN0KIKIdITzob1L3IK5
	c3781yRpGZULNqGI9LxVO5tLfwVQh7ZSBGwIPur8hBoARb4cfj949h1jLTKZIY5uEO5WLYxsWg9
	jdnEclyUHk4NlY0xnA8upmGSQRETbvrjRUjuhDZyxOM740WD6It2Z5SGVJMdg4/xDaq/UAZlE/D
	amfk0VI5aGoKcSbr/MFy2ieuIqF1NOsp5oAKO1lcd1NDNjIlxqXkktcHNcedTgw4bI+HySkQJA3
	kOeBXEcrs76VxOt0BzK2w6WfqEtstSokD3apLPRhiGLlj9OAXQsbyFwfHpok8=
X-Received: by 2002:a05:7300:8b83:b0:2be:2964:44c3 with SMTP id 5a478bee46e88-2bea547ccb8mr6542994eec.10.1773694633132;
        Mon, 16 Mar 2026 13:57:13 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::7bc? ([2620:10d:c090:600::76f6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab3a0c34sm15964777eec.7.2026.03.16.13.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 13:57:12 -0700 (PDT)
Message-ID: <29e5aa5fc5a9724d0c3737297fbecd3a3eae76cd.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 01/11] bpf: Set kfunc dynptr arg type
 flag based on prototype
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	kernel-team@meta.com
Date: Mon, 16 Mar 2026 13:57:10 -0700
In-Reply-To: <20260307064439.3247440-2-ameryhung@gmail.com>
References: <20260307064439.3247440-1-ameryhung@gmail.com>
	 <20260307064439.3247440-2-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-03-06 at 22:44 -0800, Amery Hung wrote:
> The verifier should decide whether a dynptr argument is read-only
> based on if the type is "const struct bpf_dynptr *", not the type of
> the register passed to the kfunc. This currently does not cause issues
> because existing kfuncs that mutate struct bpf_dynptr are constructors
> (e.g., bpf_dynptr_from_xxx and bpf_dynptr_clone). These kfuncs have
> additional check in process_dynptr_func() to make sure the stack slot
> does not contain initialized dynptr. Nonetheless, this should still be
> fixed to avoid future issues when there is a non-constructor dynptr
> kfunc that can mutate dynptr. This is also a small step toward unifying
> kfunc and helper handling in the verifier, where the first step is to
> generate kfunc prototype similar to bpf_func_proto before the main
> verification loop.
>=20
> We also need to correctly mark some kfunc arguments as "const struct
> bpf_dynptr *" to align with other kfuncs that take non-mutable dynptr
> argument and to not break their usage. Adding const qualifier does
> not break backward compatibility.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519B62DB7B8
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 22:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785797322; cv=pass; b=j/xvncRdtNLBSCr2IW2zWAmyM+qKjZ1K8gG4Isn+sqMqB4K8uF7580Yz5RbXbLmCwce7IVkChSZpQDsyE3puNpq8X1+/i3RN/Bw7jhsDt96PWPLLi4HtyC9CNL6UnG/EV7v+tT9z8SaDlzAGLshLHzyLSI7mx4S3bJJWL+yzs78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785797322; c=relaxed/simple;
	bh=m0g5xoqNpLM2qD/VcvL0hHvUgdZthTePopAKnMwVJX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aTow9US28GxowlH32KO8d2+mkuphq+67kfMgI2LMM1v+OxqKk4v1cYtv5Ndz3ntC1e8NsEwYPRiBnvYFxCVgsIa9TTlDOplze4ZSoyNsfB4u7J5l4fIvKGaXZwFS4gWbnWrdm8NCZuriEXJzqkPrDBg0rdEAuF2cuHoEJXiagOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUSbP9aK; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUSbP9aK"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39c74c469e8so27840481fa.0
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 15:48:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785797319; cv=none;
        d=google.com; s=arc-20260327;
        b=mn8Z4vpTIr1mKdkrbxUPFCH7Iw9BbSMHvHxgVl+kALmWvseC0Pn3utttlrgMf7YgwF
         0slWNrz8Y5WSHkStuSIgnh96b0kjIeSbK007WbsKrntMLIvwWbo/tiyHq0HdMbegovLT
         1bIQOcUTFQnqcwnYzf3btD8o9dMvIYHqnw2iwihec+xfhozZXA5WG/9mRGkdSCbX8nzj
         bYvehobm3LxYFa8TGYkC99aDoSr33S1B5seQTDdL6wJkZCu3G5Yj/cVVupY7eME46xFs
         Yz4tadCSfLovAQow9ttpbV7NMNgRiYVGTUinid83c3eoYsCL2ZCUqIEWrbc3EhA14ZB2
         fR5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SK+xt9c2t7Dz5MgpaRItEmQotjr7C5tngP8GEt7qorM=;
        fh=cqU7B36V0WqUBD2MUgHBzVpKFyoyiCztquNwU6GNt6Y=;
        b=RybbBvHE0LqjRpBOx9tfnSaL3ioTLWBqNmG10AyXW7HygYhjAHyu+Sv7w7CwIby4V5
         HI6uzTvwAFqeBsfWQ91Zw2O8bPJhzBAyNAsOEV94maIw0j7XJS0DOnPQTt1RV0CBPHiv
         cQgnwCIUCoSlgHqExZUFzSnUgnWZYn5Z+Jqs2FgxxElgVfN7uZMA075q3Mh6vyoQdjlC
         7z8AuMwo60J9skCYkATtYOUbXlR3e2vdH2/FGmMO/LGNfYyMjGDNz44yhx8EQjHqbZ2/
         63wSyVGYazvcl6pOwZ1AJRlxWKIDMAYRqa4lvT9rtdu9/y4m2VkttFZ8nlITbzuaVaNv
         +aRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785797319; x=1786402119; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SK+xt9c2t7Dz5MgpaRItEmQotjr7C5tngP8GEt7qorM=;
        b=fUSbP9aKfhfo7LdFOuB2mDoTCxKQNcfTQOVgFoz0JlugT6T2hbID9Um+lBzrrELMnK
         0aEv+GnhKV5blnSc7RKIjjoTVEfx8a6MYmDVah7eHC4Ajm0tigMlJdVVr/jv+a9JzifN
         qiVi1reJSln7RkNx7HdTO8quxJmJp56qZLjwL9kDLJioA3osH2zWZp+giC3ciqwSs4V0
         RY7raRvS86rQSO4rbLNdZxUIZLigevKIRYqK2ElbGHLtTSqzylNLIkZVaASM/U9nEezO
         neyvSdGylHQWfP6K7E77NG2A5aadtUMpv8NBa4S6qJfA8DHSTpPCU5Mtsd8+n15EEk2G
         mqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785797319; x=1786402119;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SK+xt9c2t7Dz5MgpaRItEmQotjr7C5tngP8GEt7qorM=;
        b=Og1+eh98V0tlY5veTXkbqBbfdVcmG6Vs8B8fL/OxnuUdhoG5MUCj6xMTE/qrunQEj5
         2T0cIdChkU79WPKPAZjJJq5+PRQIF2/7hi1vx5TKkt9WnHOKZCh5DszDoo9eAABde8Mk
         6MeTMWWscxmjUbv2a3Rf65UgX8E+OJ4D5OhVSEQf9tnsH1tc4IJOnGWls5h6g1BOvpv1
         yEMY2aniQ9kc+GbDeHDcK+j6QvcODU+x6aY3LhJ8KsAXJWQ7MSKGzmLlE8Rrf9Ul3slV
         zsxkOe+MI7KBxfMmyA9nNnpLSqcteLoIlusHNdrEb9/2UHb2WJXADr+SGBE2TFdhS0f9
         dI7Q==
X-Gm-Message-State: AOJu0Yx8NBw04E2vDm2lD4QdrwmPyo3y+LXW0Mkuq8NPmxuIxPx4x5WA
	jzesMTydwhqMAbpeFZMNb5ZWr++7ROFGNqIQAfxVHcrS3PLTIygGyVQhHMvGh94XTsTl3gGq/Cs
	4dNTltCwOjOO8uxoULQTRyh69fCwgGg4=
X-Gm-Gg: AR+sD131S14R/HZprkFs57f6yZ1Dws5Kn+m/MYMSzz0GdfCL9sN0rwPr9mEh1z9kLbY
	7yndErsCXv5yfGdTg3PomFd5lzGQp3bV5y4HANSYW/CJsyExvpoM+Zd5vchfQR4uXSaUK1LRSEU
	BSxoIHO7qot5F1h0LA/ls55yc82Q8QnoPxi9Dxs0kAlj4PSrwxV7rgf83jut2+rp7p+DyQyRkpj
	Qj1vKJtxYM5i16feWC/Le3NvF5mXZK1ZpwcMdUzJ0Zd2AInOpbvBAJ5L3XD9dFuiUDSzcdgfbDQ
	ll8fWRLpQK0BDIzlEH/8JaiBBMPu4kSd/GTF59TzaC/6NIA=
X-Received: by 2002:a2e:a802:0:b0:39e:b3b2:e95f with SMTP id
 38308e7fff4ca-39f861482e9mr26137401fa.18.1785797319098; Mon, 03 Aug 2026
 15:48:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803112218.3361213-1-dingning04@gmail.com>
 <20260803112218.3361213-3-dingning04@gmail.com> <CAMB2axOMcg8ZKPR8GOmeOuKUyDKZ9WVvAgJvRU5kuTm+_tOcvA@mail.gmail.com>
In-Reply-To: <CAMB2axOMcg8ZKPR8GOmeOuKUyDKZ9WVvAgJvRU5kuTm+_tOcvA@mail.gmail.com>
From: Ning Ding <dingning04@gmail.com>
Date: Mon, 3 Aug 2026 15:48:27 -0700
X-Gm-Features: AUfX_mzulvW4HccJVaxHXbapqhhPQNo_uODl-w5bhtXCwfU5ctgtBpzcTG-FPHE
Message-ID: <CAJP4iuvNNcaHgv4T-VmD7ugLkHo7V5nz3ibCdgg6C=jxrkOahA@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/4] selftests/bpf: Test refcount_acquire return nullability
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, memxor@gmail.com, greg@kroah.com, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
	Viktor Malik <vmalik@redhat.com>, Justin Suess <utilityemal77@gmail.com>, 
	Leon Hwang <leon.hwang@linux.dev>, Kaitao Cheng <chengkaitao@kylinos.cn>, 
	Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > +       tmp = bpf_obj_new(typeof(*tmp));
> > +       if (!tmp)
> > +               return 3;
> > +       bpf_obj_drop(tmp);

This dummy code creates a temporary node_refcount_only object and
immediately releases it, the actual bug test starts afterward. Its
purpose is compiler scaffolding for BTF: The dummy bpf_obj_new()
forces Clang to emit the complete BTF definition of that type,
including its bpf_refcount field. bpf_obj_drop() then releases the
temporary object so it won't affect the actual bug checking code.

If we remove the dummy block, Clang might not include the complete
node_refcount_only description in BTF. The program could then fail
during loading (e.g. while creating the map, since it can't validate
the kptr's complete type, or during verification, since the verifier
is not sure the object contains bpf_refcount field) before reaching
the actual test. (whether it still works depends on the clang version)

Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FDA2F7EF1
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 07:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789458644; cv=none; b=td8p5PwIO72Ql6bORTb1qdGqyZuPUQXAmUD76e1IBKozkSX8CTFWtRw5pEQSMaKMPP94oo96XdAlxnkR60AtzkxWvpNQSy8XMWz1k8iUWOd6potdXzQcD5+PsUqvm8Y6icz5N8xzeBvwTdGeK3l9qAujUECaoNLq1yJx5pU//mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789458644; c=relaxed/simple;
	bh=fyBUoIZS3920grWk3YIxKWDnOuLpEIhT5hwBmshFAFQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fay5CEVt7SK41tOjn488kVA5FBDLM9MWx59pi1sizJBvGmRhD8sM9JeaEfv+etxyEA+bL8IiOzlE82ykSudcUWfWyqFjRzqIfojmIrC0kU3l08mR7J53nQ+eJZFiyGTFAAIr56uOLxxug/8MUzGK4PVmuQAdRYmEwOgVrgIQ8Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oR4s02rz; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oR4s02rz"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ed1368so28624745ad.1
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 00:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789458642; x=1790063442; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fyBUoIZS3920grWk3YIxKWDnOuLpEIhT5hwBmshFAFQ=;
        b=oR4s02rzDYli+nbPwLxBkvaHuJTu+e1sqb7ISRE5ba5L/q6VSxvhxMg/tvwuMYMW0N
         BrQEDjZPb3YCbUshD5EBGhN3/G2kNsO2vy9buVIcCpqKloSL/d3YbCfX63vjfErIzeUE
         OExHrxtd1t4LCS7DNgkG5d91jpgqFdiFnwuC3HYqUabD23TQV2tEd4SqV71CvxNlBuKA
         sO2FZyhnMqDT6P7XWygS86gi4bmqGPJEjsA27QPqbgmix2+FmZ37/fL3buB/AROPr1rS
         DKcthKDukTg3NOe9epdFUhHagL2o6P1DWLy+vqkkUGYxwGbYmhX+Z9ok1z4V1TLiqQYc
         DfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789458642; x=1790063442;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fyBUoIZS3920grWk3YIxKWDnOuLpEIhT5hwBmshFAFQ=;
        b=Tag1phA6zzt0FLs/B2NViSNOuL23/BmaJ6+oCarvol3Vo8cC+VRScDTtZ1H/tH4HVL
         bZjiS/1YNWkPAoYtSHcDuLY25xfB/P8mDSGBmabqWzVyuWaVWPyiDlXnB/FL1SUj6gx8
         XIfwRWUugrhQ2lE129oyjXoEDQdkqUbq7NYOiy1ybURjWup4diJyXFcXAio5DbDh9I1H
         xduwF/dbPgkm29HsyFtbebr6ARvCgRzWe4mKi9TLc0DeFmEbnTtQWukOrsRgMiMcEAK3
         4aZLCWKG1FbNPMZfnUXDo1BJjdGKjhyidtq1YP37AWmk+ptzwqQ+L3dd6woDnj2sk68j
         Yccw==
X-Forwarded-Encrypted: i=1; AKwUvByg30LuA74dusJgAucUzWDn2Pc3Vvc449oXeoy7vL3jiqFhXtt/FikcJrF7XbiE1kt+5IE=@vger.kernel.org
X-Gm-Message-State: AFuF++lb6y6YiM4VUdfvO6LMVQR433qjf6WjqcnZ+xwgoU8cU1fX8lB4
	TpqlBfqTSqzqq56QHaEighLx4et8gpiKbM1qFA5vdR42e8epwyYohPD/
X-Gm-Gg: AYBFou1WUSe8KkHzgq+gsvP6dRzpCMCv72F9LUPN5OiArXeaAD95ZpNph+oECLDQp7m
	tjMKfVQkhdo+XOpOni1irRrplrnkUtgslIRmLLgENCYGXArfNbO5yMtFp/djCpbvevjxQoSSjgE
	N0kqK6t5RZ99pvLo48CD5QM3416oJxe2u+RgExusMqoEFproA7JXQlAXgKmia5dOoc2J+PQkzQK
	9eBoGnGVDOee06yApkRbXBFism6gZDNAe6ZCeZ/iuIrjqX5t39OgSXUuRntXeDDtzI7tNNwzxLM
	hrojRhbOJLHfhmMH9BRoccng4m5CK4PQyPHMSPUZCIGzvyfsEHtwnY1SN8eKGQnUpUnsUf0m4Fr
	WpviLs2A1ER+3Ev7mrcey77NOKMIxrHQCyL9I1s516pAGI0Cfj0nFrPMfPugOr5G/kDoOBUQN4Z
	3TwM8uKfm016SsNPYD0KF8aZVZQeD6PyOEFN2ddT52HGqp/Vy2G0K0gac5i951SeZxktreF/mV6
	WAl6MTq1SxC40A+UDQVaGnk6Jc=
X-Received: by 2002:a17:903:32cb:b0:2db:39dc:48af with SMTP id d9443c01a7336-2dd6c757b6bmr117895955ad.17.1789458641976;
        Tue, 15 Sep 2026 00:50:41 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd4bab2981sm45307055ad.49.2026.09.15.00.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 00:50:41 -0700 (PDT)
Message-ID: <0c42189021fe88ae97e88ab5609fe6118aa00742.camel@gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: Verify global subprogs in each
 sleepability context
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Emil Tsalapatis <emil@etsalapatis.com>, 
	kkd@meta.com, kernel-team@meta.com
Date: Tue, 15 Sep 2026 00:50:38 -0700
In-Reply-To: <20260914131923.2544250-2-memxor@gmail.com>
References: <20260914131923.2544250-1-memxor@gmail.com>
	 <20260914131923.2544250-2-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-14 at 15:19 +0200, Kumar Kartikeya Dwivedi wrote:
> Global subprograms are verified independently with a fresh verifier root.
> do_check_common() currently seeds that root's in_sleepable state from the
> program, even though a global subprogram can also run from callbacks whos=
e
> execution context differs from the program's main entry point.
>=20
> In particular, workqueue and task-work callbacks are sleepable even when
> the containing program is not. A global subprogram of that program is
> therefore verified as non-sleepable, making in_rcu_cs() true and allowing
> loads of RCU-protected kptrs to produce trusted MEM_RCU pointers. The sam=
e
> subprogram can then be called from a sleepable callback without a classic
> RCU reader. It can retain such a pointer while the object is freed and us=
e
> it after free.
>=20
> The verifier's execution-context predicates are complementary. A state is
> sleepable only when in_sleepable is set and no RCU, preemption, IRQ, or l=
ock
> region is active. Each condition which prevents sleeping also provides RC=
U
> protection, while in_rcu_cs() treats a non-sleepable state as implicitly
> protected.
>=20
> Use this relationship to represent a global subprogram caller with only t=
he
> result of in_sleepable_context(). A protected sleepable caller is normali=
zed
> to in_sleepable=3Dfalse at the independent verification root. This both
> prevents sleepable operations and makes in_rcu_cs() true without copying
> caller-owned lock state.
>=20
> Track only the contexts in which each global subprogram is actually
> reached. Verify it once if all reachable calls use the same context, and
> twice only if both sleepable and non-sleepable calls reach it. Calls foun=
d
> while verifying globals or asynchronous callbacks mark further contexts
> for checking. Repeat the existing subprogram walk until all called
> contexts have been verified; unreachable global calls remain unchecked.
>=20
> Accumulate instruction counts over those verification passes. Preserve
> the total recorded before each pass, since path accounting has already
> added this pass's synchronous instructions and its root total must also
> include asynchronous subprograms.
>=20
> This makes an unprotected callback verify the global subprogram as
> sleepable, turning its RCU-protected kptr load into an untrusted pointer.
> Protected callers and global subprograms which do not depend on implicit =
RCU
> protection remain valid.
>=20
> Fixes: 81f1d7a583fa ("bpf: wq: add bpf_wq_set_callback_impl")
> Fixes: 38aa7003e369 ("bpf: task work scheduling kfuncs")
> Reported-by: Nicholas Carlini <npc@anthropic.com>
> Suggested-by: Nicholas Carlini <npc@anthropic.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...

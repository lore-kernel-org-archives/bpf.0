Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5F5487BE
	for <bpf@vger.kernel.org>; Sat, 18 Jul 2026 01:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784338410; cv=none; b=LbDudPRXzspWve4iQ4RoGtS+Y1CK68TSNHlw/3TKvRL0lKxxUUm/Q3PmXTTIbv59GATNv7VJJoYmveH7zbiFetCyQOivD++jtlW7mkJu+YStAXi3Q4iMkoMl0OBEax+HKP4eI1yxFZdfaiSl02dZNOvfdilPYvqZNg/jZ3FKABY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784338410; c=relaxed/simple;
	bh=8Wb4xheC1rzK7ezjqoBwoj0mj1Vsh8xcfNwE9P5RrOw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rM2Xy+hn2e53OVdrcz7nfGL2JXsCEc6PBBfCsOYdbtwgNZpMdKzv5WsdXGU1neIwuroOVha//OpPOeqexbad2wKIjEB1kSpX5m5g4Kq2C5hIYu7uAd9uaS2eNxyqiqbg8fdRHM8UzIfYd3ZYCyFiBu10o9mh0P9/tOXrRAMzSVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvfF6DMH; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvfF6DMH"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so3177484a12.1
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 18:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784338409; x=1784943209; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=y8yMuYjFWmrqTlOrsvMbWqKf62GMosOfqlnJHZfe4ZY=;
        b=OvfF6DMHkn3HDG9tgGgknzEr+7imnh5IFXfp7sOQMsasgHz5IE4vcDABucAH4EH3/w
         oeBjKYOLGj5+IbI+8r6K1FpdZtguW0iIg89dsS9r/6mUJSRMteCy0XUexc8LuuWCc42I
         44m9uY7NWLnj84uEX2RzW1KHxmZjiUqmx7GbazryCQs4LzfYhJFvWtflG/mNKfvA1D1k
         jmt8Fs23wu7RMl3A3keHUe64KyW40N502GrGbXulYJjs5ev0QL3Ll3oBkmDr6HcViIlv
         QTRMCf4lJ/xLZBQQ/uhqRfkfHhtzeDS6FeWRqcxzeAHUsFyRO+SMnehBrutS9tLrWHQu
         oHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784338409; x=1784943209;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y8yMuYjFWmrqTlOrsvMbWqKf62GMosOfqlnJHZfe4ZY=;
        b=hcvuIR7rWpuDVeUZnZI96FNltE1HREkjXdRIQ6ysWLxthzKcxTkvo5VoIRCYRuJfF5
         cpAWlVSKBBl271M/ePTZIgptfTxyEV0ned+6KhawEscdRFyBUoHeX5B6XZk8uOcx6Dqm
         4c9GcA3Le1at+R5TBwbNS1qnD+rAK0z9RD6xLmJlYoCxDmbGWJVX7nP+lYS+sBwjYuX+
         3YVR88Sk8WptsqTOKEEeYrUdvLS5H3pn5hG+Rx2iU6WnAvNNk8EJ6U8bjn1R7QaV1PCe
         F2DCwQAAACOpp6Mke5ECaRn62BHklvYV8O5asXdzmnbkZZ5HK3cgg1kkdtsWegdR3jsH
         lNww==
X-Forwarded-Encrypted: i=1; AHgh+RrE59O6cmekwsn7AYMsE2ivN4i4qS0kC5IAkoEN849t6A1PeunmCktogEzX/bqiZBomrKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YykCzHSuKNhFG0ds2yKPlPxDnw1sh9m21NA3HEJmfRqy7v5vrbG
	m0NrW6M3ovGrtkfsEYiZINJE8IozxfaPIjTPTP8tlWANhnFOaecc75Jc
X-Gm-Gg: AfdE7cmMESawR4/SQMlRknl4WfFlmsPGzW35vk3iiFRCo4v8w52YGGXUiMW5+DcTnsl
	xnUCjOLQ5I+3mPBA9kEB3NX3SePZ20vRGII81v7eTOIDoa0pqUQTvBeLYhLwDdw6pQiqF4jXgh3
	qZVrYrUT5/RhbLD6pKquvz7pNCfCRFYqkzWpJ0+P4j2QUnZ9uyxBgj0ew5x+UmyajlBeu7lKS6f
	7rWUqp+ysV1RzKTPHJ+SWJL8zqe1Baa6FWS8p/lfDVc9M9bDbSh11v1yzUXER6NSJzRXGeeaZ+T
	SoHuz4zaZPNnzdfNtRYyvFqV7GslYabTQLcj/5p0FKJhwF8sO5uz9xAs10g2JDFaIF6ZFoHsFRb
	xXBmz3HmqKLxyepiMYo3xgz236rgqBL4THkY10Pz04OIAf3VbWwkYTuFMsVJELYLhcglwprMZSE
	BUYUrNIcRgb8HdjFgL9umKVl5V1dtx2irz1OVMQOojVYIN7jtn5UaXW9zdrRMRx5auR+FUDIfyr
	iFMyyQ=
X-Received: by 2002:a05:6a00:464e:b0:848:8829:8585 with SMTP id d2e1a72fcca58-84c2922a448mr4967256b3a.8.1784338408629;
        Fri, 17 Jul 2026 18:33:28 -0700 (PDT)
Received: from ?IPv6:2605:8d80:58a2:16cd:6088:eaa4:7f53:3698? ([2605:8d80:58a2:16cd:6088:eaa4:7f53:3698])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2adfdfd0sm1973425b3a.25.2026.07.17.18.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 18:33:27 -0700 (PDT)
Message-ID: <bbf82d80eb0dc307d09a6c7cc33c23063a55a90f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/9] bpf, x86: JIT __arena kfunc argument
 rebasing
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Fri, 17 Jul 2026 18:33:23 -0700
In-Reply-To: <20260715220052.1590783-4-memxor@gmail.com>
References: <20260715220052.1590783-1-memxor@gmail.com>
	 <20260715220052.1590783-4-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-07-16 at 00:00 +0200, Kumar Kartikeya Dwivedi wrote:
> From: Tejun Heo <tj@kernel.org>
>=20
> Implement arena argument rebasing for kfunc calls on x86. R12 already
> holds kern_vm_start whenever the prog has an arena, so each tagged
> argument costs two instructions emitted right before the call:
>=20
>   movl %eN, %eN         /* truncate, clear the upper 32 bits */
>   addq %r12, %rN
>=20
> A nullable argument tests the truncated value and jumps over the add:
>=20
>   movl  %eN, %eN
>   testl %eN, %eN
>   jz    1f
>   addq  %r12, %rN
> 1:
>=20
> addq carries a REX prefix for every argument register and is always
> three bytes, so the jz displacement is constant. The sequence is native
> code generated after constant blinding has run on the BPF instruction
> stream, so blinding never sees the rebase and needs no special handling.
>=20
> bpf_jit_supports_arena_args() is not flipped yet; that happens when the
> struct_ops trampoline side is in place as well.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 49 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)

Hi Kumar, Tejun,

Sorry for the delayed response.

I'd like to push back on the JIT based approach.
As far as I understand, it saves a 64-immediate move per callsite,
for jits that have dedicated arena registers (all but s390),
but it puts implementation burden on each jit.

There is an easy workaround regarding 64-immediate move:
use R0 as in the original patch-set by default,
add a jit_has_dedicated_arena_register() predicate +
and encoding to address this register from __internal__
bpf instruction, say BPF_REG_12.

I'd prefer to keep the bulk of the implementation in one place instead
of verifier.c + 6 jits.

=3D=3D=3D

Tangential to this, I think that __arena vs __arena_nullable is a footgun.
Is it really so performance critical to avoid this null check?

=3D=3D=3D

On more tangential, these flags would represent a third way to encode
arena arguments we already have:
- KF_ARENA_ARG{1,2} for kfuncs
- ARG_TAG_ARENA for global functions.

Any ideas on how to unify these?

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975995;
	b=jZXXsU+lP5h+mWHfLAwt67QZpiUNaD5vyP5A7AXSrcnA8ZHryQPINbZI9TiqxF60k32H
	 I4nreXjK7DbbncC9PiVzcDHQ3dx557iuJUA7VJ7tn23G2uSeSsiGgKdMJqzAHcIL6G8zo
	 1p8YvYtW9KuJY1q8LklLlz0858kCwb4wnCL2GcnK29e8cF256XDap4kcTK5onHAS7Nty8
	 Mp1nypknPlf81bzKbpi9PuIxOYU/1TJvmSMw9tTuLB48dEukXq/t/viBuLTdyJDAD8xDk
	 oqEpSd6CRZLhD9sG1g7t/uFcfSbaHkA1eWapSjBYSzQFKKYux1rVXBVSn8OE+Wbd/Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975995;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wJHuZKeVM8jv5qvU9c5nSL6+0QKnNX+FEKTqmbwRBiY=;
	b=QauEqo+DyI7RwCQXq/a+W0yvQaiGgYr5QxpTTTO+5VvJD/W6uZS2QGpEhNRLv3ozPJ8N
	 3c40MtZYJHqub/2qoAjaQvLpzRsmkthnMvdedIvxf8Afgd66/m7urJowjOtlixwU07w2y
	 pHvSU8ycUBqjNAvLfaO5TqUSzbwgrLnYZg/d7Ft/ZdMednTFaAJN4QGIDJxknGnmvFIl0
	 AME6B4tdtFlV3mt01MxPLNelCMsg7X3j/JESAzFqpAgx5iuIgWP4/VMTaZPS4fXPRY0Dr
	 H23M9RQ20Nil57pIsq6xs0X3dGsyS6jE1o6CMDz1yqA7BQ+Mg23WhHfQvgccyzP2ATg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JPFhKD6j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116D7606A32D;
	Fri,  6 Nov 2026 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JPFhKD6j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26C21F008A4;
	Fri,  6 Nov 2026 14:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793975994;
	bh=wJHuZKeVM8jv5qvU9c5nSL6+0QKnNX+FEKTqmbwRBiY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JPFhKD6j+OQY5X4qBp25hMcQ8nMTttg5IvGVP3qbGp/dDa7TaT2mAzciTFHTlEslt
	 1lZnIkdYKnX9H/TVkIEE9hz1LfzOLMEH768PGPCcaDuHgHOBN39PcZIFimXnUgftqF
	 zH+ti885zDo1MDd/V1v8F+KhVXGOND4uCg0X1ar/Dj1DLFOm0fAf24fXF4m0XbfjiZ
	 FmL2tnw6roY2Ba5tz46D1vsfYg0K5toMVQ2oRj4+pfak0sbO6TzWj91csI4SpHyHlw
	 g+ZGQDRAebOCSCkEj6+OTpRrkQjl2fx4sHPdCPm87qvzkis4ciOCrZFxAlcv7fKsQE
	 vV7Tw/oB4qh6A==
Message-ID: <sashiko-outbox-201598@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] sched_ext: Reset task fields on exit of an
 SCX_TASK_READY task
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rahad Bhuiya" <rahadbhuiya2021@gmail.com>
Cc: sched-ext@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20261106142818.1475-1-rahadbhuiya2021@gmail.com>
References: <20261106142818.1475-1-rahadbhuiya2021@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 14:39:54 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] sched_ext: call to undeclared scx_reset_task_fields() breaks
  build
--

commit 64db5de46ee85990aea72e2451a03a9902ada739
Author: Rahad Bhuiya <rahadbhuiya2021@gmail.com>

sched_ext: Reset task fields on exit of an SCX_TASK_READY task

This commit calls scx_reset_task_fields() in __scx_disable_and_exit_task()
when a task is in the SCX_TASK_READY state.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 0403c46342813..1cb1532512e6a 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -4014,6 +4014,7 @@ void __scx_disable_and_exit_task(struct scx_sched *=
sch, struct task_struct *p)
>  		args.cancelled =3D true;
>  		break;
>  	case SCX_TASK_READY:
> +		scx_reset_task_fields(task_rq(p), p);

[Severity: High]
Does calling scx_reset_task_fields() here break the build when
CONFIG_SCHED_CLASS_EXT is enabled?  Commit a298fd5f4ee8 ("sched_ext: Fix
use-after-free of a NONE rescuee leaving its sched while running") is not
present in this tree, so scx_disable_task() still resets task fields inline
and scx_reset_task_fields() is neither declared nor defined.

Even on top of commit a298fd5f4ee8 ("sched_ext: Fix use-after-free of a
NONE rescuee leaving its sched while running"), a task in SCX_TASK_READY is
not under a scheduler's active runtime control (any transition from
SCX_TASK_ENABLED via switched_from_scx() already ran scx_disable_task()),
and calling scx_reset_task_fields() during scx_rehome_task() would zero the
default initial p->scx.slice set by init_scx_entity() or scx_enable().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106142818.1475=
-1-rahadbhuiya2021@gmail.com?part=3D1

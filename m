Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE9F41D12F
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 09:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785835856; cv=none; b=Hx+9G2m/POed+4LNYSgcfFcVuSyR1YLQREdgMLzNpgpy827W7S6vWkLdALbV6qR53funBMXmH+v/n4QNv1fShfsdGU8/+gtVuZrwmTpty31O0dSFIMkPC8xbyIoEgIeicBUuM8olvltrby5aysKSiRqjoD72RcKrYAtk6JsMohQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785835856; c=relaxed/simple;
	bh=Ve4w0qhxPiVUoHXilOQZmyI2gnoEdRUoGilk/iIGVYc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Y0kKN4uLdNlropgWNw1BcGL5KMoIvhCBZubSB4CzNJtMyeYZ6cSfT5J5IhxUPhyjQIi1hQeHQaYVant4N4alG9jLWRJZhwjDLMlS9lAWil0OSm5wEbdhk5Xv09iJN8vT71ah00V9ISqVG8Te/fWS+wePCCOcNn8SMJu43mCYwOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZynF5jY; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZynF5jY"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-47825ef4012so2180081f8f.1
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 02:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785835851; x=1786440651; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ve4w0qhxPiVUoHXilOQZmyI2gnoEdRUoGilk/iIGVYc=;
        b=bZynF5jYPZcYTuqWj6rsvri34QpkQT9E0gng26Hp34cpVy/kkLIczXAODW0qo3Au6H
         MFqxOtGBS3MZwjjvVVxCXKL97jLi7USJTcQb8qhLzocVwWvmhNSvKm6yCBNu+AANqIBb
         +DPaz0pVdXy4xifwESvREKGvnTeiqKgS7YTsO608vsluzzp0yvrmhSlqp2q7OoaLxw4z
         NP6s19Pu4YT98oi9iiIioN174mgH80oPOtK9RNqZKJo8cZUe3wKtqMPulhgVXJTRzIRf
         aAPffBJFCXMmoP43zDiNSef2oJeoZW9vyDzJ/v1USC3dFuenlPIw1T2NS9Ger1omkpJn
         lu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785835851; x=1786440651;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ve4w0qhxPiVUoHXilOQZmyI2gnoEdRUoGilk/iIGVYc=;
        b=I0xJtbCafMopmx/v2AUSoD2aIeFaZuFMtOpX78AlsblwoSN9V+LZrDLTv7Not0qDlo
         8op6zGZpFg21ViOBeFCFvmGEBe89JX9o3WxuhA9cNRGoVreKgWhT7+LWbxn2SeJyXQ4K
         6NIfqJmm9mOmJx+03WsETSovXv/dxKD2hZYva00HM1PpYzoQkwvZTq8nIgOn2jDkcSMH
         oEcr20wKfH1+OjL6BR053vfLUH6z1KiZynPTmcfwGblPPFRoc4KgpBLQez3VPqgWC+hs
         Oh9awBX1qoIK5itcFWqEuBAeFhSjYY5u1naeRZ1P+3HGJY8j9rY9pf7+mnv9Sq1HGpQN
         z4hA==
X-Forwarded-Encrypted: i=1; AHgh+Rr13bNQD07ZL3YAy0ZPEiSnfRVWOUUQ+H5doZvMnTJDKvRtzXRR4c0gpJUFnJC1DPBAUZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP/LZeonuyKqH8HGWffvsKOEPyejSJRNemX/if3GoFeTQR4uGC
	kmx3jDpRS03kAUuhv+eLeFD+34Dxx+RTfWjBpc7b3StMdn4v8Zj6kuOe
X-Gm-Gg: AR+sD10GMPX7+MjFJkIzfLsArnPXMp3oPnneKHzTGMgQWnknaCMcZghTZd54x//MQm9
	IYHtb0xfyW54Om0CB3XOzZR2QIde8j0G8jm2JVI9D8dNcMUcItTF6bgZOkDzuvd/63aK2f/PdJK
	2Q6sBApcAOXPrDqLXJdaNlZhXhB4Na7UMv5mvm8YE3fOtkEdt/8FApHSV0+Wmzzbp0jJNTTv0wQ
	NfoIWpYReakENQagCfOjVQ2OD4m5DbzPHBbU6z6mcvh5JuK6FIXQFQMTknxWdTM/5Zzlhvo+iko
	U5XSyi4CWmQgbbtSrMvH1yMR+/zBvPXBJEwguxnVXN9bopORDS5TjxjlKuBcErvykSvxgf0khv2
	B8z/Yy+rJPVjzlj/MxTCPLtdjxn1LKquTGRXN8X/NkZy/0QD8TpQEk36SlayBvZQU4FL6vUz3Ij
	5DZlBW3dCNzVLL6U0clUxYUmSA4LioNAvfEVQtCRVe8Yqit2EWiCfgT5XXRTi8zMQqm9eLM6Vsp
	VzNZJ+CJWfisGFcuoGrzrCn4PTOVRBuzb7wUJdGaegyC5XGpYqbdcUZwjvschL9g7fc/7lOrH4k
	ct+aGBdQIdtKHL0l4v67Fu/uZycPMiVnHj7TZw==
X-Received: by 2002:a05:6000:615:b0:47f:762f:32a9 with SMTP id ffacd0b85a97d-47fd72a8f3fmr34666122f8f.12.1785835851289;
        Tue, 04 Aug 2026 02:30:51 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458bb4esm40503735f8f.30.2026.08.04.02.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 02:30:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Aug 2026 11:30:50 +0200
Message-Id: <DKG1Z3YPOADL.27ICCO5A3JVZO@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Dave Marchevsky"
 <davemarchevsky@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Invalidate RCU pointers after
 final spin unlock
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Ning Ding" <dingning04@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260803112615.3362122-1-dingning04@gmail.com>
 <20260803112615.3362122-2-dingning04@gmail.com>
In-Reply-To: <20260803112615.3362122-2-dingning04@gmail.com>

On Mon Aug 3, 2026 at 1:26 PM CEST, Ning Ding wrote:
> In a sleepable BPF program, a spin lock can provide the only RCU protecti=
on
> for a kptr. The final bpf_spin_unlock() ends that protection, but the
> verifier leaves the pointer valid. Another CPU can then free the object
> before the pointer is used. A capability-limited runtime PoC triggered a
> task_struct use-after-free in __bpf_get_task_stack().
>
> Record whether the program is in an RCU-protected context before releasin=
g
> the lock. Invalidate RCU-protected pointers only when the unlock leaves t=
he
> final such context. This preserves valid pointers in non-sleepable progra=
ms
> and inside an explicit RCU read-side section.
>
> Fixes: 5861d1e8dbc4 ("bpf: Allow bpf_spin_{lock,unlock} in sleepable prog=
s")
> Assisted-by: Codex:gpt-5.6-sol
> Assisted-by: ChatGPT:GPT-5.6-Pro
> Signed-off-by: Ning Ding <dingning04@gmail.com>
> ---

This patch set makes sense. I think while we are at it, we should improve t=
he
behavior here.

For RCU unlock, we currently unconditionally invalidate refs when it hits z=
ero,
even though we may have other sources of RCU protection. The only reason it
doesn't matter right now is probably because we cannot do a RCU read unlock
within a spin lock critical section.

We also do not currently consider bpf_preempt_disable() as providing RCU
protection, even though we should.

Could you extend the series with these changes? And corresponding tests whe=
re
possible? It might not be possible for all combinations, but we can test th=
ose
that are permitted.

Unlike the correctness fix in this change, these are mostly usability paper
cuts, so do not need a Fixes: tag.

Thanks!

> [...]

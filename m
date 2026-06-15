Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227A83B42CE
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 20:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553889; cv=none; b=I+8tQPzIhPJPII3M2eJ/ll7CrUsydGXXHaCeGdk1XYBVgndEdXjImKm/QKxmr4lyYIc8pVL7J4fZX79ysPi2J2Yv8iofvmdVnhBEpxETkefh2XniHgpow03migO6aAy65KkwF1f1YqueShXcoo36bWburzi3Y0ZvmGVVcR1VOGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553889; c=relaxed/simple;
	bh=O7AK+avBtUq66QCHc+PycHss3yeDRao/n+7K4bdeeNo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=PQ8RvQZQqdGRQIFT1RbN/vXB/Ofg1p7SectBqu49/5k6yUkqJJ3i98c0H0MVXca6DN/J6olw7pD+Oqy0cjmcLFHhIzwdPYeWKScNNp6x/+Jd6Qwm2YJ6y3EWiVuRLRHY1Pvd6kC+gGg3/2PYxj+7qHbrPApAV9If2O+VlJJhRs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdsx/2IE; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdsx/2IE"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e6b5c374e5so3835177a34.0
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 13:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781553887; x=1782158687; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXCGDsnXgpty84dJ1mO0u39WICRv28gHhnNvC/hudJQ=;
        b=bdsx/2IECURggyX46rSg85ssblHsIbf3wiikLYY7CpGJjRhs2Qg71wEnsYuMLwFkUe
         OAUNfm/VZro6iDhiaL1rtyY4LsHtQC0p4FqepsveNZ6hLgUSfN73B+Xr5kpkfO66DheY
         YQMH/kKklL1XgPj+KvixXZIL2QCGf8XGNmfxfjl7SzmPT7Xq/2gsQIke2YOXPfbLQI+N
         caacBJ4fLwR5TPhXGg9jJqGDPlHXcMTFWtL2GXJi77N7qd4KRBt8RY9TD6b/tDPmQwRJ
         Pap1+tilJRmbdnP66PCUC6R3la9eBjxjH5WDLER43MDRKKcDUTG404yirMRlUGyCQjIS
         y+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781553887; x=1782158687;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oXCGDsnXgpty84dJ1mO0u39WICRv28gHhnNvC/hudJQ=;
        b=qiMDevb/0+iDxu4meHguP3HOQutXfxOqiKIag++Ka1vg8eboXDR5uU6Yw1f5Ck6ZMR
         RNxqfYADLDppt1RnJ5ORVa81FWwWPeLPpYcn7WVI23DsZnXqKflhbTiezmiwoq9+Z6Sd
         KFkwX26lcKV3tTAG6MflzQsmTj8hTz3K8t0RbpESqFv56gC9Glmd1yInOhnY4hQRDDBJ
         3yIliu5Akl9OQvd3w7UkckIjhK3wybbTfDiiiWWHCSo1H6AHhP2JKnMVKyP0IDUW5753
         KCWieHiFF/K+2WzXk0L8P0S8IcZ17pbarN0WGrLiYB+8D02bid3qPzz7k1h3CjWe2FdF
         A6Iw==
X-Forwarded-Encrypted: i=1; AFNElJ8iGbGvsNaMosBg1bxuwXHnyS+hED6bax1sg9CCWbzMfspiasPJgi34O5FstdUhYP2PQZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZL6mVNoXeU1tTW3Jp510WypfK4rGBsVxsL+XSIz2ppei/7gW5
	KdP/vSBs4dX9KyQGrn+H2tnHFiMqEw8p6tFqs7MMpFSllIhwurM71HiW
X-Gm-Gg: Acq92OE1vNaKweCCB1I1kQHdtMv6TnFzxHMlVjRHOxVVhlwwodNEBoZPCiAmtgXoeZY
	z1FNqBrOr3LI5vao84AmI+qPeEHgeMw5QflTUiiUqODjFBSSRA8EoCdJQHwUrkUjrZeORrlkXor
	YuRioXgptUgHn1wDk46AHsob5fNID0CWTEwqpZokwsvxyQ48EzVRo9Ibj9T0GTIRPv4H/1aNyDR
	Eob6PgvMtTSTsanefAEiIWdDaG6jVc2fLBvJbg1Pry3rqMTGAnJa/AzoiGOjjfAYVeEdP53Rvd4
	TIM83afD17sRnIx9D94mspGvqr9vZDwsEWE2xpOC2AXh6Wy40gx2qvCPla8mirOryeY6WcoaZUW
	lu1wtywC9vgIYUrIikSWr3bJ5k+y4oR6938Ofua2I2U4mHMBYWJ1LRXaixsOcEsGD0IMLobhFBA
	TCijcczrXuCjt5Fd6v4BHCDX5VqJsu3QlwvwduRzPGjyfMfHDouQrxCPz4jWw06P3QjONyk8tVF
	w4wdSSDTev4NK2KiTnVPIA5zzTh
X-Received: by 2002:a9d:7f08:0:b0:7e7:4a94:bace with SMTP id 46e09a7af769-7e8fc9ac8dbmr393027a34.13.1781553887063;
        Mon, 15 Jun 2026 13:04:47 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:44::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f6dfde9sm4892917a34.24.2026.06.15.13.04.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 13:04:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 13:04:44 -0700
Message-Id: <DJ9W57VQJQ0A.XOCAQZWY51HR@gmail.com>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>, <rcu@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH for-next v3 2/9] mm/slab, slub_kunit: register kprobe to
 trigger _nolock APIs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Harry Yoo (Oracle)" <harry@kernel.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Hao Li"
 <hao.li@linux.dev>, "Christoph Lameter" <cl@gentwo.org>, "David Rientjes"
 <rientjes@google.com>, "Roman Gushchin" <roman.gushchin@linux.dev>, "Alexei
 Starovoitov" <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Puranjay Mohan" <puranjay@kernel.org>, "Amery Hung" <ameryhung@gmail.com>,
 "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, "Clark Williams"
 <clrkwllms@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Paul E.
 McKenney" <paulmck@kernel.org>, "Frederic Weisbecker"
 <frederic@kernel.org>, "Neeraj Upadhyay" <neeraj.upadhyay@kernel.org>,
 "Joel Fernandes" <joelagnelf@nvidia.com>, "Josh Triplett"
 <josh@joshtriplett.org>, "Boqun Feng" <boqun@kernel.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Lai Jiangshan" <jiangshanlai@gmail.com>,
 "Zqiang" <qiang.zhang@linux.dev>, "Pedro Falcato" <pfalcato@suse.de>,
 "Suren Baghdasaryan" <surenb@google.com>
X-Mailer: aerc
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
 <20260615-kfree_rcu_nolock-v3-2-70a54f3775bb@kernel.org>
In-Reply-To: <20260615-kfree_rcu_nolock-v3-2-70a54f3775bb@kernel.org>

On Mon Jun 15, 2026 at 4:05 AM PDT, Harry Yoo (Oracle) wrote:
> =20
> +/*
> + * A no-op function used to attach kprobe handlers in slub_kunit tests.
> + * The barrier is needed to prevent the compiler from optimizing out cal=
lsites.
> + */
> +#if defined(CONFIG_DEBUG_VM) || defined(CONFIG_PROVE_LOCKING)
> +static noinline void slab_attach_kprobe_locked(void)
> +{
> +	barrier();
> +}
> +#else
> +static inline void slab_attach_kprobe_locked(void) { }
> +#endif
> +
> +#define slab_lockdep_assert_held(lock) do {	\
> +	lockdep_assert_held(lock);		\
> +	slab_attach_kprobe_locked();	\
> +} while (0)

Great idea. That should cover all kinds of cases.

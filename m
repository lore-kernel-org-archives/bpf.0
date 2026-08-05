Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A1B2F1FD7
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 07:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785913244; cv=pass; b=Hm+gD5xeScZ1I8FSKQRcRkYjg1WqI3FI3JZ3YBN7+Qmrd6ARnemeqqvPu/tKveWtowN8/9w+fmTtmZX/82G9F3lyGAq5ZfCKYjKntUx6DqaceW6SgbEwYUrh8HH5cCo0c4HmjdguqU+5CiZivdem++EyDCdKfwpYhMfhxvkhx1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785913244; c=relaxed/simple;
	bh=Ce0YZZcMVvFdnB2y3Y8k1D3uBS3XXJPKrq1FjeKjQVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gWrafmtg03PrsIN53hVhvmpPcx/cdQrI7iKMmkKuu8fXbHnUKjwLrtVv1Hj45Ky8UhCKKVaIxMQ3aNxzRfBCJqrRgr+OgJxp4mAwFqOwuEqCd0EiPulC5SdveUscdt6/nI6nHpvM33/TNvg7Hy2EVFgs5HC3qAzXDYZ1mxcmx7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VE7TBAO6; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VE7TBAO6"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b011edaf7dso670820e87.2
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 00:00:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785913241; cv=none;
        d=google.com; s=arc-20260327;
        b=XyvQH0JF1AfNSW1dK30NM+vbIbBxNgDivRMYiwMxupjix8l9uET6Fr4FnA1OsgYhxU
         OWLnVddhK1IoSsszHAFEjEYqi/v/avMPyIYDeLQ3j+xbHfZWF3UW2bdOgj0tuuJQzwkk
         NgfIAmFhSmlNoEfEbPbmOEYJdURSl9cdzbKNYDO5sybMUlbLyhljwvL3/mS2v2vDxFg9
         RbTlE4aJOuoWEKQfDb5i3TSawbSf+S7d3kn5/vdlexMaLoecYszdFm3veOz+NPeSk3MR
         ycb8AE8lpyFhl8/94sTYFPmVV82qIYCc10LIQ05tkazv57jjQdpab1Wc0bthDN9RGspW
         htqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eSC4CGLgztqlLOT556YFobeiFl6UC5hhb3ugyCp8cKg=;
        fh=MDEUoWdNFOaYs9P8SDKvubhlpq2V7f7WWYzybv3BFPY=;
        b=nRiLxgG9mKJg299QIa62zYPK3C1ZgQFAyJI9cms0rrJrqe7yl0pSuADR63mD72fkms
         mvwfN8JQ+Ofir804GUNT04pZSMWQZv1+1x0bMgKQYnmgVynjX2rIrAehwXqaQps+TG3E
         pdQ7ce/Un/n5A5rWHYkb96jbcnfXnjjuX+VI2N8uxgnHWD3Mfw2iaNGRqk2gy5FJfvSx
         4EatuMNDafudMO4S/Nx+5NlgaDp4thDVWoA0ZUlRqIDhnN7EZ47PkUW0Vj7Ir8n2tQ2M
         LDYEl7FkAxF5M+qJqux9+zwxehQTbwdcF5NdamVKb5ytvyUr24ZZcYWN15V7POkk7/8J
         9Phw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785913241; x=1786518041; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eSC4CGLgztqlLOT556YFobeiFl6UC5hhb3ugyCp8cKg=;
        b=VE7TBAO6LXTRZZsKpRftN2bG/NRc81nOUE54X8yMjEjocJ7q8AObYD8YVd/u+1zc4u
         cVNbI8eVzeuTpTzEwDt+TfieGPjE2hp6fK/Vjy6ft42MUSLhbUFzNM/2wKIu2pV1HYOy
         X0lOtFdwEZWCX5hGs+nkwzZ9n75o+V6H2mb4mYmrpXyf11pTn8A+ubNXIabD/owkH8wa
         TTPqtxq7LcE6+S1ZfB/StZPy5UD0TlnSn5RdVgYl2Y/mBoILIqxs9enSeiEXzbEaNP25
         HjwPKIFcBLFsIL8uJcJYxcshGxhCyyUZDcgmQlT75EkYplkhQGApeK3pGbkkZ4bHbU9r
         hYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785913241; x=1786518041;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eSC4CGLgztqlLOT556YFobeiFl6UC5hhb3ugyCp8cKg=;
        b=qxivue2JI8M3Pg4FB0iJL2g1gfR2OR1tH/Uzpe7Xhm0fwNpZvMskmjVJGJzhGM9qC7
         4UuBlaJps9/PRVqej3go/jc7wMik1un9iwUuHiBnwwHTJmq46tsEaH+8PcSw72bDYNlR
         1AQPj4wGFmAPI4+K/KTvEem3VrV2W21Gsan1M0WduGbwm0a64PCe8lGnvzo8um4HU0Ux
         m6lT9qEfDBXkQv3oWrxTiPHj/Ro8SysJcNvWvv0NaM4B5e1SBoM57ExKTkrO1QtKm402
         CWO9GiD3b4upRZViSnxNgXdx/jDXI1/faWUETAuCp8QbYdljpzX34uuuO9xhcEeWWqZ5
         MGSA==
X-Forwarded-Encrypted: i=1; AHgh+Ro92OJ9YmsQKi+KUZLtQLRzpOGLmHTsDto7tADqcitrQByR5M/8PTbu5zNWBN3JLGTEL0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAIbTt1TN0K+naWP3kNNIU9JiRuw+VJMH8X1ERAdrbpl7oNC0y
	QqFMeFDS4SRCzGpkq6fFfBMbFvC4x064++VJC/2eLC4INe/uVWjtyjC0uw8FdbAroX0OFWrwc1N
	dQvxnO4STXIcfOBBlX+ha66JZ1oHC3FU=
X-Gm-Gg: AR+sD10yUCiwZplRJUy3CsErX1CSVL1TMRDldKf+SwGtH7r78gW2/jkZoTmKhLXc61h
	vOkq4HVwuugaG+4JUWa7RL6JFEYj8b30z+31vBhWbsmAkONeywRFCyVS5uzddPwNmQ+Mls0MIKe
	/2S5WTVzLrjkTMllAAfZbJZ/sH1YoWoMIS0d039BTK5uaheShKCN3gMX0DDvVs4tW0fzBwVXw+I
	O3I4RU3Zlgg0fT8GEEz03itmBDuTTatUAQiQphNVl54BJDBqYICYPTEBfavtBDiQb7y5RMjWCQ2
	ic2Wlrna0qyTFgReBD357dHf8frHivHm8j/b5o1rBCkyefo=
X-Received: by 2002:a05:6512:304f:b0:5b1:5a31:86b2 with SMTP id
 2adb3069b0e04-5b2f4b91d77mr556901e87.16.1785913240806; Wed, 05 Aug 2026
 00:00:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803112615.3362122-1-dingning04@gmail.com>
 <m2zez2i2hp.fsf@kernel.org> <aba45a18-fb2f-4993-868e-976723b2e017@paulmck-laptop>
In-Reply-To: <aba45a18-fb2f-4993-868e-976723b2e017@paulmck-laptop>
From: Ning Ding <dingning04@gmail.com>
Date: Wed, 5 Aug 2026 00:00:29 -0700
X-Gm-Features: AUfX_mzRPiFlIYJdpzTeSJbhR64WqVcl1JLijxBtIRxMXfJwT7cxJWo2VNG9Q_I
Message-ID: <CAJP4iuthyUKs5wYMpjGLyQKW8syiHm6pub+9rMMo7wsw-w6G+Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Invalidate RCU pointers after final
 spin unlock
To: paulmck@kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org, 
	Puranjay Mohan <puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> > 1. Disabling preemption
> > 2. Disabling bottom halves
> > 3. Disabling interrupts
> > 4. Acquiring a spin lock
> >
> > As you are doing it for 4, can you also do it for 1 and 3? I don't think
> > BPF can disable bottom halves right now.

Hi, I have written the follow-up patch to account for
preemption-disabled and irq-disabled regions. But still working on the
selftests.
While checking rcu gaps, I also found what looks like a separate issue
for state pruning also regarding the MEM_RCU and PTR_UNTRUSTED. A
sample example is:

  bpf_rcu_read_lock();
  bpf_iter_task_new(&it, NULL, BPF_TASK_ITER_ALL_PROCS);

  if (condition) {
  /* Safe: the outer RCU lock remains active. */
  bpf_rcu_read_lock();
  bpf_rcu_read_unlock();
  } else {
  /* Unsafe: protection reaches zero, creating an unguarded gap. */
  bpf_rcu_read_unlock();
  bpf_rcu_read_lock();
  }

  /* Both branches have one active RCU lock here. */
  bpf_iter_task_next(&it);
  bpf_rcu_read_unlock();

But STACK_ITER comparison in stacksafe() does not compare
spilled_ptr.type. So the verifier considers the trusted and untrusted
iterator states are equivalent. It can possibly prune the unsafe path
before is_iter_reg_valid_init() rejects it.

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/kernel/bpf/states.c?id=6655c409707ec8ce9ce0850ffe4fe02331fd4d9c#n806

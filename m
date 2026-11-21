Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795223639;
	b=ZpEMCE+ddKVnapxt8ceNVFJ/xJtsXddHQ/TfLcQ1jmbSa/E7/XsHvNqGm6TmQD/FW6Xi
	 75CHXJrsYWueQWAXmOgr50tm06SfKMs8AOcqXwfj82WXyp1ZtKxZBMA5lTRXWbtNbx3yy
	 H08S0NzMPw1wGsgohEPCNJ/O3vS5fG3+6W3nqKsKJDmIFpBUkcjJS9YkZdFez9NUNLgbJ
	 JCS1v7ysLv04rYXhN2ZW9gQHPonQMmMeaLvszoYHfPI+20GFjeqax4nGy12QnhxMSuBkD
	 NtOeVAS+NMyJJEE6Q8EmEr8lfyv0B/KSLugF55GSbmewKIlbFxKoxrFme7EU3IwVfRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795223639;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=tU9Cn/FadT5rYtiag0jDxCbFoHUlMPHp7fQS4vyTs1Q=;
	b=HzJkz5UzK8Eeoh78vQkwmQhdJfQ9FSCeo9ygSFY+udfqCIrQKlKxaCH3CtPZTBkjUAQD
	 FLg/Hq8ZNEimSq1L131KHR9NQZPfyBB5LHUEMwbPW5m9q/kELe9cOOmhLki3Odat8lnaP
	 y2H1/1QsjbjNRk5dQd4PAPhWKWJGmcQlmRP4OolkY6+n3QR+Z7+Shkjx7yKX4GLtKRKSI
	 XkPZ+AYudKmujOFZc+FtOJZPBrl+MTVIIe7ek3NeKRTsiIty1Jh+m4pePACXXkn7Pvhwp
	 PisNZLhhf49frbPczMe2VDBj0F+zS/09PF/LIvBRZmAd5kXum3hSn8wE6sES/0L11kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BwtnRUyq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73AB606A69F;
	Sat, 21 Nov 2026 01:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BwtnRUyq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507641F000C6;
	Sat, 21 Nov 2026 01:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795223639;
	bh=tU9Cn/FadT5rYtiag0jDxCbFoHUlMPHp7fQS4vyTs1Q=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BwtnRUyq7X/B+YnxT3i0/V6yIthL0J37sEfxt2HWXkvOdYkw9stAY4qg26mEw2sNA
	 z94PIKaXtHQL7nKyqOtVpYXwytYizgwXKT1FHM9evXNzB7hI224CdgjU9IrHRQm9EV
	 anxgmi6B5SMAxeowxsDToocS/mjYZhXNhpJP5O+dvu/rCi77Kf3VgviGHbY/N0nbrh
	 cy+xmI/GgF8qGjDK31x4h5qrl/uJCv/99k6nOEbSLAZnAZJ+cmJ75kTr620FglS8C/
	 Pf7NeoDaKegmmVSPxV/X/decmwaqTMl25IqS6WUejxZDb53f0xsT/GSz+zobJ6U/Qq
	 a31ww0lUkqYtA==
Content-Type: multipart/mixed; boundary="===============9058164219103786062=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <d76bfe6573fc2c9e4aca4d36766a3c616070ae7067065a38def07e8430803d7a@mail.kernel.org>
In-Reply-To: <20261121003403.2928928-3-ihor.solodrai@linux.dev>
References: <20261121003403.2928928-3-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v2 2/6] sched_ext: Prefer ___v2 kfunc names in compat.bpf.h
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com
Cc: alan.maguire@oracle.com,emil@etsalapatis.com,jolsa@kernel.org,song@kernel.org,tj@kernel.org,yonghong.song@linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,sched-ext@lists.linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 21 Nov 2026 01:13:57 +0000 (UTC)

--===============9058164219103786062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> sched_ext: Prefer ___v2 kfunc names in compat.bpf.h

TL;DR: __COMPAT_scx_bpf_reenqueue_local_from_anywhere() in compat.bpf.h still
checks only the ___v2___compat name, so with the new libbpf it may return
false on v6.19+ kernels, silently disabling scx_qmap's sched_switch reenqueue.

> diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h

[ ... ]

>  u32 scx_bpf_reenqueue_local___v1(void) __ksym __weak;
> +void scx_bpf_reenqueue_local___v2(void) __ksym __weak;
>  void scx_bpf_reenqueue_local___v2___compat(void) __ksym __weak;
>
>  static inline bool __COMPAT_scx_bpf_reenqueue_local_from_anywhere(void)
>  {
>  	return bpf_ksym_exists(scx_bpf_reenqueue_local___v2___compat);
>  }

After the libbpf change described in the commit message, the
___v2___compat names resolve nothing.  This predicate still tests only
scx_bpf_reenqueue_local___v2___compat, so with that libbpf it would
return false even on v6.19+ kernels where
scx_bpf_reenqueue_local___v2() can be called from anywhere.

The in-tree wrappers scx_bpf_reenqueue_local() and
scx_bpf_reenqueue_local_from_anywhere() check
bpf_ksym_exists(scx_bpf_reenqueue_local___v2) before calling it, but
__COMPAT_scx_bpf_reenqueue_local_from_anywhere() is exported from this
header and schedulers use it directly.  For example, scx_qmap does:

  qmap_sched_switch():
      if (!__COMPAT_scx_bpf_reenqueue_local_from_anywhere())
          return 0;
  qmap_cpu_release():
      if (!__COMPAT_scx_bpf_reenqueue_local_from_anywhere())
          scx_bpf_reenqueue_local();

A scheduler built this way would silently turn off its sched_switch based
reenqueue and fall back to ops.cpu_release().

Should this predicate also check scx_bpf_reenqueue_local___v2, so that it
still returns true on v6.19+ kernels with the new libbpf?  Note that the
two ksym checks probably need to be in separate branches rather than an
||, since the comment in scx_bpf_reenqueue_local_from_anywhere() says
clang can fold that into a bitwise OR of the ksym addresses.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44845964556
--===============9058164219103786062==--

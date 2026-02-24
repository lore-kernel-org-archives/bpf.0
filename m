Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7356D2C08BC
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 18:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771957069; cv=none; b=dOhQ4eJjwvuCnYl7zwE/LspNFhx07r6CrUowfmrRod84pbvU0pYCyWTQQ+l9fdD4Mmw3iiyJi1TGDLZlYhpOCpqUrYPJs0MysuBwKsjJW2nOjQ//IuQkr+kdoM0fMAjspQT1Q085C9Q0FHPSWekQaKqyD+eAGL+qRwAXLnTJw7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771957069; c=relaxed/simple;
	bh=Z+3R153IEpDGTD33uAnjl7v1eLPZp8WHdWY2PyRSPkA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GDvzD/60orcOHky81cktReFrACfAEqeKFSoQJ51c8BtyTkUMkYC3pT2zHsae07LD1ylc6f27BMERsImxnLiszYF96hEvTQzxvzs5hjd9lo2iwm1yypsoB2eVC+WK2/V3sRnRbXZJ7r75L/dQg6MYlkdLnBTWHtyN3Vv4zVUoU/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+NJTkcS; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+NJTkcS"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2baa6ec5638so47840eec.0
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 10:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771957067; x=1772561867; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9Tz9/b8jsc1aBPZOt4cZ5oNCFggW4j/PEAgGC8TQqME=;
        b=D+NJTkcSIzhwTppq/hrNJWM3wr68M5AfQFkxCy1xgr7KN9QflnjNoA0+fu2tx0P/bE
         EoDlfX81nNVC1UaUK9CVs8sVU9duwrNpKTYMFm+TeWSulPHLe0crlEyQSv3b2dMBZBmg
         QqJQunhNWuy9mOS+o0mjxpSLUJ8Y0EbWesHtwx0x/YBoD0qn3zBSPuVebMEnsS/KzISf
         c9frSd3hHO0yU4t8XsRbKY+UZQvbB1PewENp5y21911yn7jxHcHzqSMCaXOty6XH6wg6
         EUdf4Hfzj7q038pmHH2WVxe09ubZxDNPA9Z39cQnlrROhvwaMZip/vVoNc5UFy1+eE6w
         HY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771957067; x=1772561867;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Tz9/b8jsc1aBPZOt4cZ5oNCFggW4j/PEAgGC8TQqME=;
        b=MBZTMpTbpQ0Phusf/BCWa0lw7pjeEBdUEMem6m9NEu1tA5FgAE0UbE3rOVGnquFHhF
         kJBjE6O392eMN0hVr5UJpGbkSWRq3ARQr5cD2lEwtuma4iPDbLAqRNKb4MLUu3CEruzx
         IAhp0Zh8BuD/5zlskpWYGhe5ykJiLGQCc9Ts0w1MdIMHgw7errCagVmbW5e10to8C8lB
         DOCfgzTTUy05rm0ssLE/qx+nzd2fXPhQVBU/qRIS3hjqqEKSNwWbubBqf0J9Gsc3ifiP
         Tm++BOzMc4YBtWrJ6D3h/4M1VQcXC9Z+QssXi9h9h/HzgJ2k6IvxMpDqnR+SAyFr/xIY
         uHrA==
X-Gm-Message-State: AOJu0Yxe/E4s7oAQOVhc0HJNbUGhqfWomRVNVUHAgv2WdMkt4w6pbPh+
	1V+4CCBaDV1+PEy1+IXuNwE/u7mGqwv/u5gMj10mGsLytdtHEgMqL2298tJ6B5+e
X-Gm-Gg: ATEYQzwVljvuxa4lgPUSDgyxUKEvuVRSRtyiku6XU5uKfrgW3V4V75iN+3snc5mnwNm
	jA8m4Nhsisq0z0nsAGH/U5Kr5/RVQ8JEH6fdwwb218gD25ZdR4XETewTs4a4dKltWANn61u1gfq
	WUoWdWXaqZj8UHQljA9CNdnOdEqjq/9JuwJd+I4umRrrWSNfa2Kmwy1XYVR87Wg4zTghUAEzufp
	7xpkIbGgxAWyaMy56VzVcAqMqbFBiR0v9ZHel8exRFS7ZK4pdoFvuDcchIPnvReaRr1WzAVcvrE
	dS7kEHGTtU11sLwvoAZTxUThiZx50PGgMA237Qmqri4Hv+kb3KvsvI89mi6kgjk43GbynbGee5V
	0EApUAKesFHtEX4MINnzioHqdwHBi9QUiEEO9K0jARIGLd5bmmmzRwA06Zh7ZK9K5XzkfX+EH1a
	VqNfomrQjglSVc5YewgMrPlC9b1MfHgzcP+7ybx0p5iW1waWd0LvvFakou3C/GDNtYg5KoTPXlH
	mi+Hg==
X-Received: by 2002:a05:7300:1352:b0:2ba:6ce9:db47 with SMTP id 5a478bee46e88-2bdbc3799a4mr369683eec.9.1771957067266;
        Tue, 24 Feb 2026 10:17:47 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:79f3:c942:f01f:96aa? ([2620:10d:c090:500::1f1f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dc167b2sm7150309eec.28.2026.02.24.10.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 10:17:46 -0800 (PST)
Message-ID: <20ec0bf67e3664eeac349dde21bdda2d3546079b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Add KF_FORBID_SLEEP modifier for
 KF_ACQUIRE kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
 kernel-team@meta.com
Date: Tue, 24 Feb 2026 10:17:45 -0800
In-Reply-To: <CANk7y0gjg4tCcDvoK7nwcjw-w2aPtjDiJCdPvqRHS0Wvce2wiw@mail.gmail.com>
References: <20260223174659.2749964-1-puranjay@kernel.org>
	 <20260223174659.2749964-4-puranjay@kernel.org>
	 <562fc6aeef17412ba8965bc4938fe9c0dbbe0f9e.camel@gmail.com>
	 <CANk7y0gjg4tCcDvoK7nwcjw-w2aPtjDiJCdPvqRHS0Wvce2wiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-02-24 at 15:24 +0000, Puranjay Mohan wrote:

[...]

> > - remove the following check from do_check_insn():
> >=20
> >   >   if (env->cur_state->active_locks) {
> >   >       if ((insn->src_reg =3D=3D BPF_REG_0 &&
> >   >            insn->imm !=3D BPF_FUNC_spin_unlock) ||
> >   >           (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL &&
> >   >            (insn->off !=3D 0 || !kfunc_spin_allowed(insn->imm)))) {
> >   >           verbose(env,
> >   >               "function calls are not allowed while holding a lock\=
n");
> >   >           return -EINVAL;
> >   >       }
> >   >   }
> >=20
> >   Relying instead on `sleepable && !in_sleepable_context()` checks in
> >   check_kfunc_call() and check_helper_call(). (As one more refactoring =
patch).
>=20
> But removing the above hunk has other effects, this check is not just
> about sleepable but all function calls under bpf_spin_lock. Do we want
> to relax this now?

Discussed this off-list.
The side-effect of this change is that calls to any non-sleepable
helpers / kfuncs would be allowed while holding a spin lock.
This should be fine, but probably belongs to a separate series.

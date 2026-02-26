Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF31431A7FD
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772111828; cv=none; b=kY0gwMA8QHTH252sQp6sIhSl2S2mL6qDbp3Qw9CDPqgguNoOpm0z9Gtd6ZPZChfu+JuQTGrrse9fq4mXxI/p4ysrqN3DAjgSJptNt9Uc+7RrfNwnE8FGYcRts14mM+aI0e9EeOP5ql9bdStFYG2dOyo6yGBmd7mlJ+12YRAPoo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772111828; c=relaxed/simple;
	bh=J+G20XvNWjZZfTdlMQzXuHIMC3nJwvJ5LU44kSdfCEM=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=Ig+J+l1BcjTLo0XGld/Tx68yg3s9f70JYrK5/8EwXMK/LfyzlBxozN2XXbHUsjrr/SZd6Mpxjn2WVCIoNw6mJvFB9iWr2D9WywgJhB4Al5OTe4+Vr4Vl6neJN+yOcxK/vug3D4ZOqBw9hoMxqA9Y1b4+DNW7VFU4LWZvoWK3ljI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=E0kQ1hmI; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="E0kQ1hmI"
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <jemarch@gnu.org>)
	id 1vvbEn-0006So-Ao
	for bpf@vger.kernel.org; Thu, 26 Feb 2026 08:17:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
	references; bh=2pvJPdsLnTINzXzHZgUFZbyQZOCBpp3E9sjUDagPah0=; b=E0kQ1hmImXGulT
	jYFbjHd6ZVwOGcHfbz78m3y/fW3QZi0Vfh279VCfR+0cfvRuj75kaHVhXjhWDtCLydl99N+84/GRN
	oyzcYLbiPV7Ncdhn2DaWmqY6RgUISUVJ4W+xy+ZmyNFlIsjldRZbDU1krVedjAiPFItR187BtHiuC
	WegXZnDO/B2sBNhu7XkaBKUru2568SKQlQxi4cGT0xBW1Ymq2EEED/8Bv78Z4y+pAoMAXGHHeFH/a
	S9byK9G+J3McdXVw/pUuttf/8U/Wgmziqh0Jbqf+cjbOAtfiYiTRcm17axcb82+CHFm5sYeTz6RRo
	KD99LCN5NSeqEzYAccHA==;
From: "Jose E. Marchesi" <jemarch@gnu.org>
To: bpf@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] Compiled BPF
Message-ID: <87tsv3sn2h.fsf@gnu.org>
Date: Thu, 26 Feb 2026 14:16:15 +0100
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hello people!

[Turns out I forgot to send the topic proposal to the mailing list once
 the topic was proposed (in time) via the google form.  But better late
 than never..]

Work on GCC BPF (also binutils, etc) is progressing at a good pace and
there are a lot of updates and topics that would benefit from having
some face-to-face discussion with the kernel hackers.

Some of these updates and topics are:

- Dealing with some pending differences in behavior between GCC and
  clang/llvm.

- Support of "optional" but important BPF features such as quick calls
  which are currently not supported by GCC.  We are preparing an
  exhaustive support matrix to track this, kees-style.

- Documentation and maintenance of the ABI in general, and some specific
  ABI issues in particular that need agreement and definition at this
  point.

- We are finally ready to add -fverifiable, aiming at GCC 17 (GCC 16 is
  now in stage 4) and we would like to get feedback on some of the
  details.

- Handling CO-RE limitations and corner cases at compile time.  The
  compilers should emit proper diagnostics and behave the same way.

- Testing: we have finally upstreamed the infrastructure that allows
  loading and running GCC BPF tests in kernel.  Along with the support
  for building the kernel BPF selftests, the idea is to have strong
  coverage to detect regressions ASAP in both kernel and compiler side.

- More upstream BPF projects are adding support for using GCC BPF, and
  support in distros is improving.

- We recently got an important reinforcement for the developmet of GCC
  BPF, thanks to Meta: Vineet Gupta, an experienced GCC hacker, has
  joined the party and is already doing great work, speeding up the
  development.

It would be useful if we could have some time during LSFMMBPF to
dedicate to these topics, if possible.

Salud!

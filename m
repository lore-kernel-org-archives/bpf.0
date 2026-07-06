Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450DD44211B;
	Mon,  6 Jul 2026 10:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783332995; cv=none; b=OcXs1RwE8rlqeKJXDiMqAV6r+xgOpVuL09W3x4hYY/egNgJzX+RveOLAtP/7FZizEodu9RWX1+3PuLZaB9+fB/6MB4qLj1KYK/8Qnu3T543JCeNad0lY6/KZNWf3Is4766h4Qt9OWnHpF6CcZHo5VmNBp4Fo6j5KUhJdwss3khk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783332995; c=relaxed/simple;
	bh=Ui/6WL/wE/IDrkuouB3Cpe6r7kaK99syNQCjQSVq+XQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Vu+njwD769XqcQT+y1XMhRgtzSiylY0zd9Pg3KIuyoU+lv79yTUVn6ABTzSVWceXobiCgvzc0Fa+hrLm2t3fXQRYO1E9wXJ5vqgfZr6BH3+FQngE32FhFfk/IxX1pjh9ajo4pjyRiVqZsKEmVR1/YJNdfi9WkFyOpx3SQeO6lTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jd2yAfyO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jd2yAfyO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A361F000E9;
	Mon,  6 Jul 2026 10:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783332993;
	bh=yT+Ai7PVmpAGS1R+fNNohYl4y8lLsQnylybaH+IWsZM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=jd2yAfyOznOWM1i2Ex037TWFM7s+HhO1kBqYSmUyH4LNJVTE4mwE75V0fcjoEkF6C
	 IFKL54m+7HZSeZR/IY6no51OooriHNxhrUQ3TTrntwWHmP4mZuleKJKufAT/TJEfTD
	 TW99ZoZ1hahJl5gNfH/dfDwXyRhf8T4FPQwEJEKCzKkOdj0fNCbM3sqHvXwSJs/fPM
	 HgoU87Ir/VXbg9FbyyZ/zF8s7Jm0XfpWKg/bMAlWEOuzpo4q4UEHpqlHRQdDtIGpyN
	 YrSbKjzBH5N3Au/2EiKn7BgYfagVaGr+8vUUWEXzEEMGPyj2qySQtou/oMPLvbu0AT
	 tfKVqrYrvBIeQ==
Content-Type: multipart/mixed; boundary="===============4166175548752548279=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d49e2fcbde106e80971b769793170fd479315d563d31bcaf6db33737c01c814c@mail.kernel.org>
In-Reply-To: <20260706093525.13030-4-mahe.tardy@gmail.com>
References: <20260706093525.13030-4-mahe.tardy@gmail.com>
Subject: Re: [PATCH bpf-next 3/6] selftests/bpf: Add ksock kfunc test
From: bot+bpf-ci@kernel.org
To: mahe.tardy@gmail.com,bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,davem@davemloft.net,eddyz87@gmail.com,edumazet@google.com,john.fastabend@gmail.com,kuba@kernel.org,liamwisehart@meta.com,martin.lau@linux.dev,pabeni@redhat.com,song@kernel.org,netdev@vger.kernel.org,mahe.tardy@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  6 Jul 2026 10:16:33 +0000 (UTC)

--===============4166175548752548279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Add a selftest that exercises the ksock kfuncs end-to-end. One sycall
> bpf setup program creates a ksock context and connect the socket.
> Another syscall bpf program lookup the context and send test data.
> The userspace harness create a network namespace and a new socket on
> loopback, run the setup and send syscall bpf progs then check that the
> userspace socket received the data from bpf.

This isn't a bug, but would a quick pass over the changelog wording help
here?  A few spots read a little off:

  "One sycall" -> "One syscall"
  "creates a ksock context and connect the socket" -> connects
  "Another syscall bpf program lookup the context" -> looks up
  "The userspace harness create a network namespace" -> creates


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28783010022
--===============4166175548752548279==--

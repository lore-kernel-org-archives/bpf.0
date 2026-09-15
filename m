Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEAB4CC292;
	Tue, 15 Sep 2026 18:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789498611; cv=none; b=OXDguuqG90RzwbgIHRmFtil7T0NRI5tMQ0XhoSIArXXQc1xHcIosCsjrCOXNaF3gAODEPmU/G6mDhSG4eRiTAcWazF/5fHkwmlr3By2G1Jd3L0I0KIgli/uoQmBBMIHu6yH8wnhMRivSjw02ppDK7wGDsW2QVmSuldQpDrOzgl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789498611; c=relaxed/simple;
	bh=aOznO4V+wW0XukDe2WGO3DuI3hjH/v86lD1a01h/kc0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=lNq1scUu3m8gdNwiVbsnaU1EINcTs3IcwK1/MP09BAbJ47qCic32zqHSE/oN4BeNNzw5LsjqUxIgnLUv9vJ7V2knGXwo9miYvXWugPBw4mFrvwzzIhd6snMrlTZcqtRwCMT9RUfyLFqB+YEOeG2cb2c4Q8QkHShgN26tdCHB1vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdbcG8n9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdbcG8n9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B5C1F00893;
	Tue, 15 Sep 2026 18:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789498610;
	bh=brPSm0i0iAPhu0vw8QLPXoS87QOKCyUejOTNe1Qi6qM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BdbcG8n94+7uP5IGMz+16HmjIKSh8JHfrDSLAQp/OZfPFaE+NhpzYz1x6jXhy5YPw
	 u6sx3PcY8F0PBED1VvqlWUtr3vqvS3jcAyhUtvECjg/WqoPbE2PEQKEHaYjQXFw+6f
	 EzOmP0cDmJ1jLfGBGHnketz1IMX0V9qVeOeqKOrxeb9uJfLe2xuVlz/maQrwNka9TW
	 72ZOvBeiYAa8gkW5VI2SYm22NUqRfFRw/bAdQHZVhFgGN6IO3lEaP3wPdFqdM4SdZ9
	 +Md5xmMchqenebhpeCAiVfF/KUdMYlKzWnKOAkUsIOyPXgd1EcFo+zZSUOLnzFXO0h
	 AzqCJn1pnGVlg==
Content-Type: multipart/mixed; boundary="===============4463277524376841096=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <79c55d1971d336ea0800c17110521f8e2db8b838d5ca53199b25de7f299d7b71@mail.kernel.org>
In-Reply-To: <20260915-libbpf-log-buf-fix-v2-1-2feca3fa4842@gmail.com>
References: <20260915-libbpf-log-buf-fix-v2-1-2feca3fa4842@gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: Fix program log buffer size validation
From: bot+bpf-ci@kernel.org
To: luisflavieira@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev
Cc: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,luisflavieira@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 15 Sep 2026 18:56:48 +0000 (UTC)

--===============4463277524376841096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     libbpf: Fix program log buffer size validation
>
>     bpf_program__set_log_buf() checks the existing prog->log_size instead
>     of the incoming log_size argument when enforcing the UINT_MAX limit.
>     As a result, an oversized value can be accepted.
>
>     The setter also accepts a non-NULL log_buf with a zero log_size, while
>     bpf_prog_load() rejects mismatched log buffer and size values.
>
>     Validate the log buffer and size pair consistently with bpf_prog_load(),
>     and check the supplied log_size against UINT_MAX.
>
>     Signed-off-by: Luis Vieira <luisflavieira@gmail.com>

This looks like a bug fix. Should this include:

  Fixes: 847b98421362 ("adding ci files")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35007077686
--===============4463277524376841096==--

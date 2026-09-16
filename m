Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FBF511E8D;
	Wed, 16 Sep 2026 22:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789596072; cv=none; b=A7jZrf+0YexQLeLe6V8K5D4H8iRHshdYneh1QrX7n2sXt7rH1fh2ufiAkC/Yq8fauWgWG94iv7Cf+MfNp02Iq0V7Cq3QjB0k34qugpEn3rfJNz4mKBKn3HOM2DzWM7/8QYeJpfEliw0VefMLhU5MoHvZYW0PBt+Ce1exaIt+swI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789596072; c=relaxed/simple;
	bh=wcHgehP2Ip2QVN1vAXVNxL/yk7AGWUsHVVEwg2tDCUk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=TzaPDN3IR6P72ydCIOXy0cWHkdflP5ePwCnKeGtJByAjvfFOvamRM0ZP19KExNdzhXDNPH4XL6zEOA2KTcew5D/M1yFO8cQPzJLnHQQgl819BT6G3jlPI2IdoDYebr/ki8erKIBm376LRIN3667vMPVK7VcVk5i4FZRalkNJekU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frIvug/N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frIvug/N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4111F00893;
	Wed, 16 Sep 2026 22:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789596057;
	bh=bRe5+0z9WObVqkY9t9W7TzPyySZ5x1RzQcBR6ZRgZyc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=frIvug/Nfu7jBKrvDkIscNbUjVCLSWcZbfyW+E5+Y9Al8BYu8ihZtcA21Y/BeLgNO
	 2U4gGVmOs29vAgERP9K18zHiwVTaCKhFvU3ZOxpkcjPrcJF7omGYR7wvCpNRZ0+xxf
	 KRecvc8SccK8M/hMQA2uW3a5adlNGVzuEdvTzTkxH70dEr6TwoJShcosE9Dw1EIouF
	 RKHnmLtnlBydPdlrCHYoHA5K818h+NI6YNTJDfDU847LdB8YiXLuV7+10Vhkhn9fyE
	 Iui2fzh49scMTPAzL23Sw7ikK4O4ExTb28pGlJgupSP/QDquorVddjgOrElGLP9sja
	 0gaKU+uPk1Ycg==
Content-Type: multipart/mixed; boundary="===============8930977808325852854=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3be99835c8dfd22e0b1607ffc0146711e2f8f804ad9c371b90d6a11ade7a3715@mail.kernel.org>
In-Reply-To: <20260916-libbpf-elf-entsize-fix-v1-1-cf181da33eab@gmail.com>
References: <20260916-libbpf-elf-entsize-fix-v1-1-cf181da33eab@gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Validate ELF symbol table entry size
From: bot+bpf-ci@kernel.org
To: luisflavieira@gmail.com,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,luisflavieira@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 16 Sep 2026 22:00:56 +0000 (UTC)

--===============8930977808325852854==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     libbpf: Validate ELF symbol table entry size
>
>     elf_sym_iter_new() calculates the number of symbols by dividing the
>     symbol table data size by sh_entsize. A malformed ELF file with a zero
>     sh_entsize causes a division by zero.
>
>     Reject symbol table sections with a zero entry size before calculating
>     the number of symbols.
>
>     Signed-off-by: Luis Vieira <luisflavieira@gmail.com>

This looks like a bug fix for the elf symbol iterator. Should this include:

  Fixes: 3774705db171 ("libbpf: Add elf symbol iterator")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35154126900
--===============8930977808325852854==--

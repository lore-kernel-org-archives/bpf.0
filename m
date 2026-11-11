Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440039;
	b=2IxaGtBGshGWyDonGhF/o1EqEHl6fjMOcmzq68aSyLCnz/ISrb9z1/2yfD4RlpCLaLjl
	 rXjV9Z8JYbUxAIlombinOFDvhmJCMw9bFEXbO/laVCOiR5nErv6RaIQy3PT7bW1vb5jD+
	 UFL1t22XAJvMzFbHcBe5q0omZyJSSWIbnRLXBjS0Pk95lseIowy9HaNcaG2H7BAj240hq
	 4G9YYz2NjTP+yadzlmORM3gf/xg18Cv+1/uV7XcBcPiQKhViRQmk2+S8vlSP3cMU2tgmp
	 +GTwgnOwHdgLREnUBDRucAkVvlt72GPb6xx6a4rjYLg/Cd7Dx/bVnqOrcLjiWwoTcDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440039;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=eBzvO0TwAcpk1pVecGkUIgm3C8M8r8TbgI/xpSQv70E=;
	b=5WPPiK8KBKGlX+sq691Gnx9VPw/4BI9FAF645/6HzHcuTXSriYTzVFzCe55V1Od2rvc7
	 N+5o/2J5vCcwyqeZh1fDhGBP8uZPgxpsLS25dhvlvJyiw23/dv9UUSgdPeIg4eNLMfhPL
	 /tsFiER1+bG3+wyJDobAK3/BNQXZIULmzci74AljmHIYj8wjYfIhoN0crA7M2rk8JTU4q
	 nw/eP2MBsKEfbu/D8u35gwjI/0pglCOrXenBhwZv9J/wvxLfeD+VhJyRIN5TribnHqxYt
	 6U/5bY7Qbx32wk+q/j3jfvnBCeNpZcVoYztDQEljk0t5/cyq8+nk95E3mpVMm1RBY0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UOG9qzF0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AA1606A32A;
	Wed, 11 Nov 2026 23:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UOG9qzF0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265301F00A05;
	Wed, 11 Nov 2026 23:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794440039;
	bh=eBzvO0TwAcpk1pVecGkUIgm3C8M8r8TbgI/xpSQv70E=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=UOG9qzF04/l+tB5PMijWoH1Ilh9V5TkUq1L9J8D/9Hf6le5yaBjub0ICwiqdw0sWB
	 oHjduSz+ut++a7B/5s7vKpfFvLgboadIS/BhuXVua7Qy+UPGku6uRXnwchz2Kn4Naq
	 4qHZ+DctJfzEZKtsUpbG592NBLOMNJKH9h8dJr7uiApw1ezDKh8DHGXWCFG5uuBjns
	 3TRhnmqu+6xMrkAcUrv66bSnRBiJtZ6h8VSNpZIyrZXcNhyHUv+P20f5zh6gDIKwtW
	 m6yPCE6MOH9iHJ1eR/RHzVFekOuB295SK0LLQOvxqzP0u6Qu/Xi5F9EpiTqUsZZtGg
	 3SoMJZ8DAFXkA==
Content-Type: multipart/mixed; boundary="===============6923270527550495412=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <0bad64fa2725547166cab46053d2506688de06285d5c96c3feb4bf7b45ef87fa@mail.kernel.org>
In-Reply-To: <20261111115911.1142000-10-david.laight.linux@gmail.com>
References: <20261111115911.1142000-10-david.laight.linux@gmail.com>
Subject: Re: [PATCH v3 next 09/13] kallsyms: Add a kernel parameter to change the kallsyms_markers[] density
From: bot+bpf-ci@kernel.org
To: david.laight.linux@gmail.com,pmladek@suse.com,kees@kernel.org,david.laight.linux@gmail.com,linux-kernel@vger.kernel.org,linux-kbuild@vger.kernel.org,bpf@vger.kernel.org,jim.cromie@gmail.com,ljs@kernel.org
Cc: mcgrof@kernel.org,andrey.grodzovsky@crowdstrike.com,rostedt@goodmis.org,andrii@kernel.org,wusamuel@google.com,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 11 Nov 2026 23:33:58 +0000 (UTC)

--===============6923270527550495412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> kallsyms: Add a kernel parameter to change the kallsyms_markers[] density

TL;DR: Commit message only: the subject says "kernel parameter", but the patch
adds a build-time Kconfig option (CONFIG_KALLSYMS_MARKER_SHIFT), not a boot
parameter; the review suggests rewording the subject.

> kallsyms: Add a kernel parameter to change the kallsyms_markers[] density

The subject says "kernel parameter", but the patch adds a build-time Kconfig
option (CONFIG_KALLSYMS_MARKER_SHIFT in init/Kconfig) that is passed to
scripts/kallsyms as --marker-shift.  No boot or command line parameter is
added.

Would something like "kallsyms: Add a config option to change the
kallsyms_markers[] density" be more accurate?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43116767394
--===============6923270527550495412==--

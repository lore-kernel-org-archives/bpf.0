Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281AC322C6D;
	Fri, 11 Sep 2026 15:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140441; cv=none; b=igfbpX20DO/l4lApRnf+G+EXfFv4yBfEoXKbmYuxnPV2B9y7FOQr9qeWFd5cJjNtd3bSNoouWwy756ebv4BXbrU06KMWzco/HTJEBxOGJqH03FmTmzjRTX+N9qAgaWmMGVfeOI0gp/pTuluBYSbuWtsDCbWAkytP7PsQUZOOBfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140441; c=relaxed/simple;
	bh=/5ngQOz0Fr8fdgWYP5DEuPldXuC86Zqli3ZKMfiIHN4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kvZbtrVRBggV4Y8Mlxr+tNY/QMofy8Pf8LKw82W/WZSo02yJ9VB/Hsn77Ia9tQVZyTY/GnE33ql5VLlaZfkMeO6jCsRPLuBUqFMZd8+fWBhskbKk86MYlkM4WWv0UaDCS9XNHvmNpOVdzzOd3PCVf4C+0zDRAzpIy/WTTDrOnqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mc+MqGTZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mc+MqGTZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA101F000FF;
	Fri, 11 Sep 2026 15:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789140439;
	bh=8BJjhrhS+0Oxmm6z0xTBYFFxEtdSj4DGbwn14Xt9haw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Mc+MqGTZCtk4Kp02/a3LLiMpT8xvAjbcK0AaiPqoc+pP/DmZsoFW+uxCBEHwaZKq2
	 2x6xRErxisglzqqC3UIDxH4aZLu+fUd6c/6NfxwF3TTKm+2XDLCpMUcaMJRNjmT01q
	 4DK+4+OC3w1ZxO07Ztd7wigs8hkMwebitlVuGIuNoSlL/mwpQyDYeYPva5+TSY4yPQ
	 8Z85+zDs4l9xQ/aOPZL202F5AtXqTNHo8NDjwBrRpt5mMP76jPeUafzcS5cLyVelNf
	 kgX/jo4G2Ij2YabAouQaxmVOfnDm9yo1c4aYRAqG1qH+/Y2kvPcugkk0Bn76DtZ7bH
	 Bw781eWfPUmNg==
Content-Type: multipart/mixed; boundary="===============1584994168545175848=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <42eecdb6f344f592a4764f367f13550c93417fa903f5e58a832c2aa01841c9e4@mail.kernel.org>
In-Reply-To: <20260911141621.1944900-1-sammiee5311@gmail.com>
References: <20260911141621.1944900-1-sammiee5311@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Tolerate libarena skeleton failures under BPF_STRICT_BUILD=0
From: bot+bpf-ci@kernel.org
To: sammiee5311@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,martin.lau@linux.dev,rbm@suse.com,emil@etsalapatis.com,nickolay.lysenko@gmail.com,shuah@kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,sammiee5311@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 11 Sep 2026 15:27:18 +0000 (UTC)

--===============1584994168545175848==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> The Makefile documents BPF_STRICT_BUILD=0 as tolerating any BPF object,
> skeleton, test object or benchmark failure so that the remaining tests
> still build.  Every skeleton rule honours that through
> $(if $(PERMISSIVE),...), except the three that build the libarena
> skeletons.  Those invoke a sub-make with no guard, so a libarena failure
> is fatal even in permissive mode.
>
> With a libarena source that fails to compile, BPF_STRICT_BUILD=0 stops at
>
>   make: *** [libarena/libarena.skel.h] Error 2
>
> while an ordinary program failing the same way prints SKIP-BPF and the
> build carries on.
>
> Guard the three sub-makes the way the other skeleton rules are guarded.
> The build then prints SKIP-SKEL and continues, and test_progs,
> test_progs-no_alu32, test_progs-cpuv4 and bench all link.  Nothing
> downstream needs a change, because the missing skeleton drops out through
> the existing permissive paths and libarena.test.o is reported as
> SKIP-TEST.  The default BPF_STRICT_BUILD=1 still fails on the same input.
>
> Fixes: a6850fa388f6 ("selftests/bpf: Add BPF_STRICT_BUILD toggle")
> Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
> Assisted-by: Claude:claude-opus-5

The Fixes: tag points to a6850fa388f6 which introduced BPF_STRICT_BUILD,
but the inconsistency where other skeleton rules use PERMISSIVE while
libarena rules don't was actually introduced by commit 7e729028d7ff. That
commit added PERMISSIVE guards to most skeleton generation rules but
missed the three libarena skeleton rules. Should the tag be:

  Fixes: 7e729028d7ff ("adding ci files")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34611055093
--===============1584994168545175848==--

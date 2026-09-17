Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052784854E1
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 21:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679804; cv=none; b=D+q6Ul0fKoUhFu+ttBlU8YFrf2TRbKbVMtoxOn7gzPvQWdgrwn8SrIiiB87YbRtIo3s4xYv2lTdm70yUSX0q1b7r6fTL0Hfv79VUKMUXcPvvBMJ4f52IlsoQM8ggBRopjhfIWgirDEUeRomT6raDNSL2k5WHL4Pcf99O8F/h9vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679804; c=relaxed/simple;
	bh=OZqVRkF+pAfZ/7yfsPmFsCCUPRfYtXKKyRsorJ5Xz5w=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=dB/O1rPYw4rVa60tAc4z8ucsWGaF68RV8s9SqEDu8bZNhHD0wSmRdgP2/kw23cc3LzLu6daTk32lblY4/IJHAhLbsyFcqJpUC8g5XQAR3Dv+3zrKv/w4oq9pQ3GEg5Im0mwtdshxkX7HrsuwQA/2ip182BZwf+ZTbg6WF36z3qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONhoZKGZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONhoZKGZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EAD81F00893;
	Thu, 17 Sep 2026 21:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679802;
	bh=OZqVRkF+pAfZ/7yfsPmFsCCUPRfYtXKKyRsorJ5Xz5w=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ONhoZKGZbLiApjr7TwKV9g7eiL9BxFIekCLWijStbQ21faCDpwwNQc7e08gjnepPG
	 13NlpEx9gDlRzA6HdG04X+6HpA1+CyBaJFxzkk6ZWbLZQvIdNa+vZFwsCsCIJoV/GB
	 0tjY0j++9M64Y8MQnSIl4uIbYq9eNc9rvg34jpXsBGbzAgEXEoMmVxpG7cez3hL+v8
	 38LUfIiLF+XN/BtWh51rua5O9x5DFg+4SbjyPxJdzJG3Bvr9OBfHcB3Dq/MV3H3s1t
	 hJ4j+AxxiNWLQe93LNoRiPX2DlL1YrlYe0BkRDlNvmozcArYqWllD9aQVelcgykrae
	 lNTe4FXeTJA4g==
Content-Type: multipart/mixed; boundary="===============1874988963266926423=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4307078dfcba04d5b675e1442b3eea19d5e173c047b856e614e9bd84449add73@mail.kernel.org>
In-Reply-To: <20260917203040.3150212-2-andrey.grodzovsky@crowdstrike.com>
References: <20260917203040.3150212-2-andrey.grodzovsky@crowdstrike.com>
Subject: Re: [PATCH bpf-next v3 1/6] libbpf: BPF program load strategy enum
From: bot+bpf-ci@kernel.org
To: andrey.grodzovsky@crowdstrike.com,bpf@vger.kernel.org,andrii@kernel.org
Cc: ast@kernel.org,martin.kelly@crowdstrike.com,slava.imameev@crowdstrike.com,linux-open-source@crowdstrike.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 17 Sep 2026 21:16:42 +0000 (UTC)

--===============1874988963266926423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: BPF program load strategy enum
>
> Replacing the boolean field with an enum simplifies the addition
> of new load strategies. Currently, the bpf_program structure defines
> the autoload behavior using a boolean field. This field is now
> replaced with an enum, allowing new BPF program loading strategies
> to be introduced by extending the enum value range.

This isn't a bug, but would it help to mention in the changelog that
this exports two new API symbols in LIBBPF_1.8.0 and makes
bpf_program__set_autoload() a wrapper, and to name the strategy the
enum is being prepared for?

The changelog describes the internal field swap twice but does not
mention that the patch adds bpf_program__set_load_strategy() and
bpf_program__load_strategy() as new permanent public ABI symbols to
LIBBPF_1.8.0, and turns the existing bpf_program__set_autoload() into
a wrapper over the new setter.

It also does not say which new strategy is coming, which is the
rationale a reviewer needs in order to judge whether a new exported
enum API is warranted over the existing boolean one.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35272462686
--===============1874988963266926423==--

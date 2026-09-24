Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306BF17BCA
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 00:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790209119; cv=none; b=rI1eVC/s5W7f8w/Uyd4rOAc+zgpgk6iy22fm2mMg5meBY+JDXWJrV48ZKsk0TuZot7sQA7/c/kOjKXUYoVBdMh5FRs+2+t3n2Q/LUCRqBifYJ9Y7xt937k3wuxudLcaDT2+j7nzIXfE9i2moCK55PCU1FWdONY42+TlM/0kW44w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790209119; c=relaxed/simple;
	bh=LMqW6N7iTPl2dasKQuOaAuAORDe1P7ntuMaZkEHNlok=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SqKczh+21t4nRE3lNAsIO9A0Wt+pAjnl1iNnZfBMsr1MAqP++nH8jaIzrdDknMOge8UYtroHbhi7+h30/om25wdxueQqaCZbeJFiqg6DkrA0eQndVeM0/d/M3W1lEniVrka9VgCb4U0Jl7pIzXx5xWzAtkEWq3HLx2d7WkVlvTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mguNe7Fc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mguNe7Fc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5799F1F000FF;
	Thu, 24 Sep 2026 00:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790209117;
	bh=LMqW6N7iTPl2dasKQuOaAuAORDe1P7ntuMaZkEHNlok=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mguNe7FcLj6Yf52GAiw1bqZYEx6iyhilTWNTWlT/+CIWOt+NRz+EMg1PVEv1zcQby
	 6HIXBkC7K6Pd2veXmNO8N9XtvedQZr8SmGpopcPt7z+NNpjB6AlI97QTfFeW8uPUM3
	 z+BcWiUtCHKOQGLB1WGkZbm5fk7T0HRZeXUzMfzVJOfTcWL+w0QlbKb8fyk9hvab4H
	 fE7yR3jOltT7GCC98yluAOe1/ipx3k80Sm6ucCWrxEEcKN1LBvOTcPxEJEmTK5zWde
	 UyFlD0Jv8ccAgVwzISdQSsnqGuTNOkryM51THb+L6nkH0AiZSwppGx+Jg4oMV+rE+i
	 j4Q3G6tZ7tkow==
Content-Type: multipart/mixed; boundary="===============6065458611927516199=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20812d5b5cce8195ae4499fcd5f457549071b7722fb634196ae996b3aaa470b4@mail.kernel.org>
In-Reply-To: <20260923232939.1886328-2-andrey.grodzovsky@crowdstrike.com>
References: <20260923232939.1886328-2-andrey.grodzovsky@crowdstrike.com>
Subject: Re: [PATCH bpf-next v5 1/8] libbpf: BPF program load strategy enum
From: bot+bpf-ci@kernel.org
To: andrey.grodzovsky@crowdstrike.com,bpf@vger.kernel.org,andrii@kernel.org,ast@kernel.org
Cc: martin.kelly@crowdstrike.com,slava.imameev@crowdstrike.com,linux-open-source@crowdstrike.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 00:18:36 +0000 (UTC)

--===============6065458611927516199==
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
>
> Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>

This isn't a bug, but could the changelog mention the new
bpf_program__set_load_strategy()/bpf_program__load_strategy() API and
the libbpf.map additions?

The changelog describes only the internal conversion of the private
bpf_program::load_strategy field, but the patch also adds two new
exported public APIs (bpf_program__set_load_strategy() and
bpf_program__load_strategy()), a new public enum
bpf_prog_load_strategy in libbpf.h, and two new LIBBPF_1.8.0 symbols
in libbpf.map. At this point in the series those APIs expose exactly
the same two states as the existing
bpf_program__autoload()/bpf_program__set_autoload(), so why is new
public ABI added here rather than together with the strategy that
needs it?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35934836796
--===============6065458611927516199==--

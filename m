Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABAD304972
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 01:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783992282; cv=none; b=DSVzmXpIc0fKhLQxxzp0D+RxgNMkzNrrUbnMTSpG72LOFJOlTCFGy6w7kFmuW7PZIHsc/w+/SJrteZM1Kw5w0cVBRPmDyUM5gM/yD++uYrBLkLMHlXvebqFRhauMSV3mttWel9btwHSgu1XbVin2fkIf0rMnZroBWavMFX4LB50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783992282; c=relaxed/simple;
	bh=yHi2gUIbby/xl0CR7LSaJ2D/R5r1rUsY404FWMev6Tw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LZxituopzp7dQ6y3n4j5GhadmLsWiIcla0wtVT02FLU0hKuIduN2LIRW7jBvhWfI6XVwZJEvYOTNDY+DFGR8k/v/t6SYvliG6/jnfcwu4jfJHdpMvjNf3AxvEt07KaTOUZDr8fF/wFNK3ij+4K32kE3gvQFR1T4F2vdHENPIjNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieyEl8ap; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieyEl8ap"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8EA01F000E9;
	Tue, 14 Jul 2026 01:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783992281;
	bh=JfIn58RweGjWENZA5JqRBnvaqdWPSSh3sQsOLRbxWyI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ieyEl8apIZCL1x4/WgzXBbxRux0rHTyUFdNelpP24MP1ubdsmCcIbPBLnB/MMvWvc
	 x7BoHyYsIH/sPBb6RUnLBb00CeAMHpoJGYxiuIU2vTBRswUGv3/UOFjbNE/ni/XQrF
	 slpf8bhO0AWS/v7lmR2KnL6zHHaDp1Bidr6CaJH4LfaBfBm7MrrLj/nNZissPTjJnA
	 Z5TkHamqELzsyEKgzyTY4HkZ+ACxBwIMvAEfAtqY+XdhjDih8GI4bPRnjp8OqqzBkN
	 LUZdwla/OtWRI8LMJ9GGv6GYqx7gPuwIBhYb+e+Oq+XFKmenudEChwY68L33u9cOx+
	 W0GW34DF5MblA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y 2/6] x86/bugs: Enable IBPB flush on BPF JIT
 allocation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pawan Gupta" <pawan.kumar.gupta@linux.intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260713-cbpf-jit-spray-hardening-6-18-y-v1-2-755f60c55705@linux.intel.com>
References: <20260713-cbpf-jit-spray-hardening-6-18-y-v1-0-755f60c55705@linux.intel.com>
 <20260713-cbpf-jit-spray-hardening-6-18-y-v1-2-755f60c55705@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 01:24:40 +0000
Message-Id: <20260714012440.D8EA01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] BPF JIT allocations trigger a system-wide IPI broadcast for IBPB f=
lushing, allowing an attacker to cause a severe local Denial of Service (Do=
S) by spamming BPF program loads.
--

--- Patch [2]: [PATCH 6.18.y 2/6] x86/bugs: Enable IBPB flush on BPF JIT al=
location ---
commit 6fe177facacbbf6baebd63b419b7a3255bc1668f
Author: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

x86/bugs: Enable IBPB flush on BPF JIT allocation

This commit enables an IBPB flush on BPF JIT memory reuse to mitigate
Spectre-v2 JIT spraying attacks. It adds bpf_arch_ibpb() to broadcast the
required MSR write system-wide when BPF JIT is active.

> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index d7fa03bf51b45..fd0b7880cf7e5 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
[ ... ]
> @@ -2383,6 +2396,27 @@ static void __init spectre_v2_update_mitigation(vo=
id)
>  		pr_info("%s\n", spectre_v2_strings[spectre_v2_enabled]);
>  }
> =20
> +#ifdef CONFIG_BPF_JIT
> +static void __bpf_arch_ibpb(void *unused)
> +{
> +	write_ibpb();
> +}
> +
> +void bpf_arch_ibpb(void)
> +{
> +	on_each_cpu(__bpf_arch_ibpb, NULL, 1);
> +}

[Severity: High]
Does this introduce a potential local denial of service vector?

During BPF JIT compilation, bpf_prog_pack_alloc() invokes the predictor
flush unconditionally:

kernel/bpf/core.c:bpf_prog_pack_alloc() {
    ...
found_free_area:
	static_call_cond(bpf_arch_pred_flush)();
    ...
}

Since this results in calling bpf_arch_ibpb() which uses on_each_cpu() with
wait=3D1, won't this trigger a synchronous system-wide IPI broadcast on eve=
ry
BPF program load?

If a user spams BPF program loads or unloads in a tight loop, could this
create an IPI storm that starves other tasks and locks up the system?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-cbpf-jit-s=
pray-hardening-6-18-y-v1-0-755f60c55705@linux.intel.com?part=3D2

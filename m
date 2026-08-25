Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890D73314D2
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667621; cv=none; b=l5YBQm95DakLIn8m2r8dPH4ARKBGyYTvLlraXD4jGM7XGsMQNn8l9OhT+tf0C+k4sqjAr8Hq/CiO34bKSkRBcj6jKisFXUHU2YRsGhgbVeyaTYKzZL7C7Jyo3YRtzbstyiF+PPuZHJQMM6tc86JZZsex3pBeM55Hqf5bX+wBcd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667621; c=relaxed/simple;
	bh=uxSnBVQmPJkTe2zagIq2eaAlEDTfx9e11aG/wo6uNmk=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=sJ/ORpkgrEv4AVl/U3MO5lek+5NpHyRPqVC73FROoOeFE5lmkVa5YkDPhfN4dXqhayBjzfekVdtXRu/CMAaKnLAfAPHGx0qUPC8c9Cnqufl0E3RbLoYnWNCLs3nB61lHmEhfY2M33fVLb5HwbQV/3KajSRI61KDbFPoZceQqcJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wgwv4xDR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wgwv4xDR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AABE81F00A3D;
	Tue, 25 Aug 2026 14:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787667620;
	bh=2Smq+atWoiBJX1KPn86M9A0v8LQiVLOwpH8nGiTdpWM=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Wgwv4xDRSs32dlD13n8yPA0RiMUAygWA2ptey/+a6SaQT2eyKmrVnh3qHY9mS9SmJ
	 94FHVggXmlpzPrftUsUpR3m3Alx4QBSyAFa0jDDNepHPmQDRiPTlUi/a8KsrBYjScz
	 CsoT3zAHeVWTchcoGGcLBe4aCZLkzLstGCVj0/YxQVEiI2GsHLPmo94KySowzcG40c
	 Z1Kl6pHZ5Ri2KL7uw1iKM29Q5YP+RRCgTBEQzc7u0Ivt5UZ4IoNtkfEpTZNqDADmlv
	 EdQR1E1DrVWUbZHekhS2r4t+iz4aH8RF3/ZSKlD0vt9wMLgHkfwE53/aAJLn02XP/e
	 LFUtDT5VVmeNg==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH bpf-next 02/11] bpf: Refuse caller-supplied keyrings
 when the bpf one is active
From: Christian Brauner <brauner@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: memxor@gmail.com, brauner@kernel.org, kpsingh@kernel.org, 
 ast@kernel.org, john.fastabend@gmail.com, a.s.protopopov@gmail.com, 
 bpf@vger.kernel.org
In-Reply-To: <20260821214111.1120748-3-daniel@iogearbox.net>
References: <20260821214111.1120748-1-daniel@iogearbox.net>
 <20260821214111.1120748-3-daniel@iogearbox.net>
Date: Tue, 25 Aug 2026 16:20:12 +0200
Message-Id: <20260825-gedroht-auerhahn-abgas-3f032d4567ae@brauner>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1525; i=brauner@kernel.org;
 h=from:subject:message-id; bh=uxSnBVQmPJkTe2zagIq2eaAlEDTfx9e11aG/wo6uNmk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT1Llnw4e4Kfa6VTYXC3qv1wteXzHLccqPW8+naAj9fh
 mtH+WeWdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkhiUjwzWD8LRnDAt/hZ35
 YSDc8vVmz5zQkF13Ah5/5LuhM8WOLYrhf/y9o0Kedje6ZNR7HQu3axxJuLoqIHb3TL/rgZe1zf5
 GcgAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> Nothing changes for systems that do not use the bpf keyring. Without
> bpf.keyring_unsealed=1 a caller-supplied keyring behaves exactly as
> before, which also lets it serve as the staging step for software
> installed onto a running system whose signing key is not enrolled
> anywhere yet.
> 
> Passing bpf.keyring_unsealed=1 states that the bpf keyring is the trust
> anchor for this boot, so from the first program load onwards a caller-
> supplied keyring is refused with -EPERM. Deriving this from the boot
> flag rather than from the keyring's runtime state keeps the decision
> immutable from userspace.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index e331c2fec612..e6cff677267c 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -669,6 +669,13 @@ Kernel parameters
>  			keys. Once the keyring is restricted it becomes active
>  			and can be used for BPF program signature verification.
>  
> +			Setting this also means that the bpf keyring is the
> +			only keyring a loader may select for the rest of the
> +			boot: caller-supplied user/session keyrings are
> +			refused with -EPERM, whether or not provisioning
> +			actually completed. Leaving it unset keeps the prior
> +			behaviour, where a caller-supplied keyring is allowed.

Yep, that's perfect, thank you!

-- 


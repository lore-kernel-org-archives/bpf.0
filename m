Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A823BCD3A
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 22:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788648288; cv=none; b=Rs+nFI2NbR5Cy4+kF5lPOJtWlre8Gz07YqehzKLYxU2n/Nc/J+/WuqWtK9l6yMylJO5rhupUXuL7Et53FSLicVX+3+46L5rK/FoZekZimkwtZ8UZeES8SRosq3yFSGN2r/KddCewV6VOyjBBBeEcfpsKEg8Y9MurPSNjxeJ3k8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788648288; c=relaxed/simple;
	bh=G5+C+YDHxNzEQ93jILeiROdUW3TKk/IGTXyQAtJJ3iY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Lb5Vz3z2EMqmHwC0nqtsHceJkyp0Ygujv0WASEFtCk6TkWtoDDzqfMsQz9tzdLjwrYVkKd4OYe8VJL9oDpnmzY2ZO7uD2HSCiqguXUt3epcFmgZCl8IU4oAU9hNUCeXcl9wWUwrfikEx/+jx+81sNSOyoSjBTic1JNcxPdWx7Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kk3bae51; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kk3bae51"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82E21F00A3D;
	Sat,  5 Sep 2026 22:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788648287;
	bh=DkajoZa4uG5OW4Qw8WWwCdy5akYwwa1si4b78445HsI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kk3bae51lU3JcGe3s/ckptdPmchtQ8C/POCHm2CaB+MAwgBci8GGHAfjccPqlbtPR
	 slp4ZCcXRimuK6Fn0ktyf2yEA0SlxV5icZN4TNuwn/5yXdf41fjrqepinlp7k45GXk
	 Qm+oPT84XThywDN0eK0AASaRkTrGfBZiz0GSg+VvuaGohlCzgmziWDx2v5iK61Dx5e
	 /YXJp7TFCRUAichN8uwP/LpiISoqT7hnOGvSUHwJ1ySNPn+Lx6o52qhE9FmzZk2UBg
	 ZYj5AobCm36YB9JMEK56JMZCwyfaFknEv1dA0RsmV+ms2KdHZE0Kh5finwGNqCCey8
	 TROIq8lXlVpsg==
Content-Type: multipart/mixed; boundary="===============3939478147476393628=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5be48987cfe75e107873b539eb72a03021979e0e2a14e8bdd0c4fb8f592b3a8c@mail.kernel.org>
In-Reply-To: <20260905220117.922028-5-ameryhung@gmail.com>
References: <20260905220117.922028-5-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v1 04/22] bpf: Only compare func_id against kfunc BTF IDs for kfunc calls
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  5 Sep 2026 22:44:46 +0000 (UTC)

--===============3939478147476393628==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Only compare func_id against kfunc BTF IDs for kfunc calls
>
> Helpers are identified by enum bpf_func_id, while kfuncs are identified
> by a BTF ID. Both values are stored in bpf_call_arg_meta::func_id, and
> a helper ID can have the same numeric value as a kfunc BTF ID.
>
> Introduce is_kfunc_call(), which first confirms that the metadata is for
> a kfunc through meta->btf, and use it for comparisons against the special
> kfunc BTF ID list. This complements is_helper_call() before later patches
> move these checks into paths shared by helpers and kfuncs.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>

This looks like a bug fix for the helper/kfunc metadata unification.
Should this include:

  Fixes: bf9c1b911f4d ("bpf: Unify helper and kfunc call argument meta")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33995442755
--===============3939478147476393628==--

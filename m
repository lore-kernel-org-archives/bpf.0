Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795580581;
	b=mXtngp+f+1ZlPlp/t9lQ+FziHVlELWSmsTNbuf19HtRFyDkpz3RvPUS+dBd5ZZXb1Q+z
	 WLOImuXHplq9ZxSCvC/Y3xOgZ3GoeZ3jZhb6ERSkLtKyVB5ZpuyAFx2T3cKZSXP/C7ie1
	 +9OtvZHdKnZVrB3WNSHrX+kIA2xIJ/IGRLsiqP1QzFMgIcS188S3wJ+6iIgZ84ljk1E6u
	 iDLj0gVb4c2XcM1CHcJo/tQ6UcwR02RbfKFnfxxAcozzVU72WJzhvvPVm14l821dRnIsv
	 0JmjznEB7wpTUcxx0ZDMePKnJYz/Kvsn6at0/L8SGGy3VCc/YN4XfP1C5uRO9AZFaxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795580581;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5IqHR7B3aedVm5SCA6788o/yEH0agx+sbs2oCgqHtYI=;
	b=e257fUzptRTR+SPZVeQcIPWeGefknRSTLp1Gu7Gd+jDyZIonEXve5WqW9EoB75Xo9g6o
	 NSIKMrkrW2FEsepfB/FT91/c6msQyJPOtR7VAvPQiiaaAv6BKqvqhcnBqzdFEZVMppVMm
	 IlueVCVLC/0kzwZuBeKXs4sbvBzGik3+Qe9vFJVHfkU38vKuQhSsmW2x6oWOAcXRwVw0F
	 u5Y8e1uv7WcOvLpTDmIYvRJkNx71Px6qjkoNUGMSKszOFl36w2Tqli39CIA2whBu9HNP7
	 3YcgJ5LEoH5bZXVKKlgchN2PbIz3qpZpv2P+YF0lX+Rerv0FGC4+SDa+zGGfnYnv/5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fnG9CKXh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25AB606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 04:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fnG9CKXh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F6E1F000CA;
	Wed, 25 Nov 2026 04:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795580581;
	bh=5IqHR7B3aedVm5SCA6788o/yEH0agx+sbs2oCgqHtYI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fnG9CKXh4VewQtU+ndIpMddICXN1ttNXeQyuB7Psznjjj8OBptTYzegQcfKT7ec4Q
	 uhkgUfa7foAlN8bmX7ROdEMpL0bniJp1AS7n2IgKM56LKa3VA2jbONwlvZv21Ua86n
	 /PAP4Wu/GwYYSlPJ3oar6w40TdyRdGqDvK8csM4bVMBGgLotNKbKSp0Te5kx8zwuAW
	 r0M042Cay6osf2sOUCaeXbOg8DmvC+oRG40vAgaZSNH+6a05VQEVG0gfjgU2YyXAjr
	 RtZru0/0leFv5AvNVr/95QrXxabftzzrNIMAyCW9sxsDwiSRqaThsZonMX7+5Ieqyp
	 3g9eE3ezkk9wA==
Message-ID: <sashiko-outbox-232571@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2] bpf: Add rcu_read_unlock_special() into btf
 id deny list
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sechang Lim" <rhkrqnwk98@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261125040106.2200628-1-rhkrqnwk98@gmail.com>
References: <20261125040106.2200628-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 04:23:00 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] bpf: unresolved BTF_ID for static inlinable
  rcu_read_unlock_special()
--

commit d423a98c605ab7698cdc1fbadbd9de2303d91def
Author: Sechang Lim <rhkrqnwk98@gmail.com>

bpf: Add rcu_read_unlock_special() into btf id deny list

This commit adds rcu_read_unlock_special() to the btf_id_deny set under
CONFIG_PREEMPT_RCU to prevent infinite recursion when attaching fentry or
fexit BPF programs to it.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e7013ed8cadd7..0e8afc0250b54 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -24735,6 +24735,7 @@ BTF_ID(func, preempt_count_sub)
>  #ifdef CONFIG_PREEMPT_RCU
>  BTF_ID(func, __rcu_read_lock)
>  BTF_ID(func, __rcu_read_unlock)
> +BTF_ID(func, rcu_read_unlock_special)
>  #endif
>  BTF_SET_END(btf_id_deny)

[Severity: Medium]
Can resolve_btfids fail to resolve rcu_read_unlock_special when the
compiler inlines it?

rcu_read_unlock_special() is defined in kernel/rcu/tree_plugin.h as a
static function without noinline, and __rcu_read_unlock() is its only
caller.  When the compiler inlines it and elides the out-of-line
definition, no BTF_KIND_FUNC entry is emitted in vmlinux, causing
resolve_btfids to emit an unresolved symbol warning (or fail the build
when CONFIG_WERROR=3Dy passes --fatal_warnings).  Should
rcu_read_unlock_special() be marked noinline as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125040106.2200=
628-1-rhkrqnwk98@gmail.com?part=3D1

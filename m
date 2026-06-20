Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75321799F
	for <bpf@vger.kernel.org>; Sat, 20 Jun 2026 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781969535; cv=none; b=Z+fcxyZxAaxW4YM4yYgvPpEzwPZ0sXoR1jz0mfY9YqEQZOnltUa9i6613NvgCcYd6i6tovcvQBJbjqKxC4v1TeIitLiLWotiz2XNYnJwPQfX/oE98fltFTT1Qfr6IYsJe0OJ4U+KGK6GWLa/G9rMi5e6ZFekI3Q20m6o1HQELP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781969535; c=relaxed/simple;
	bh=Qa+ftFbCnEDB2NsiUmrSVvf49BE9ftmer3CNRwG8zuM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MPN2xcgmFyxaEYu/IveRsTg/gl3FedlPCRmT2+xxFgygKlyddP0E+gXkHM5I2xPoz/sJppDNsd31PVKPSu9hbvfxUMw6hgBJWb5m69cj6+Zq8n266KbJZrU6eH+QJFdaOZ3H6Pkw92LZmpyN+MLKODFrNU5J36S9qSdWayT1BEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8RFxltT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8RFxltT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201131F000E9;
	Sat, 20 Jun 2026 15:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781969534;
	bh=SdiaIxM6AA/Stee5Bb4RNoxV4ZQjhyydkPs/0D3XOiY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H8RFxltTHP+Ng34miiV92UNDgdTeCWfWFEfwT0SYGjKgrcEIf+pFuoCUoPVncrl4s
	 UHgRROFWGWXtRhwU/rj1qrKxPJQ33ThHDSWWHbXSJUmljAN4QlM3qRzXDBBmwaL5e7
	 QJLzBl8j/DKCeZig9oCc16cE+I43rhuqIDX/7T8eRcryJATZEjjt9ZVaSOWoXT4SEz
	 QvBgjGNvLgEtnY3p+OpVJviBdozJ6hiQQFbrElGYG0JBtasp6Ztt0s1p6VgLcRBIlF
	 QYwFVVcDFCIVLd4hcq2qbyVAiwu9MVSo1uEvSouXjtgk4f4KKvITU/E97zcxaB2ySA
	 cLdUH0F3LTJbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Cover nullable RCU pointer
 use after unlock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yiyang Chen" <chenyy23@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <ed2b303079d5955af859daaae94dfde5d29bd64d.1781968391.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1781968391.git.chenyy23@mails.tsinghua.edu.cn>
 <ed2b303079d5955af859daaae94dfde5d29bd64d.1781968391.git.chenyy23@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 15:32:13 +0000
Message-Id: <20260620153214.201131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added tests fail to test `MEM_RCU` pointer use-after-u=
nlock behavior because the pointer is not an `__rcu` pointer and is read ou=
tside the explicit RCU critical section.
--

commit 78986d2dc799ce86278ca6d6e66b17c43c68dbeb
Author: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

selftests/bpf: Cover nullable RCU pointer use after unlock
   =20
Add coverage for nullable BTF pointers that are read under
bpf_rcu_read_lock() and then used after bpf_rcu_read_unlock().

> diff --git a/tools/testing/selftests/bpf/progs/rcu_read_lock.c b/tools/te=
sting/selftests/bpf/progs/rcu_read_lock.c
> index b4e073168fb15..b78542706fbce 100644
> --- a/tools/testing/selftests/bpf/progs/rcu_read_lock.c
> +++ b/tools/testing/selftests/bpf/progs/rcu_read_lock.c

[ ... ]

> @@ -372,6 +372,26 @@ int cross_rcu_region(void *ctx)
>  	return 0;
>  }
> =20
> +SEC("?tp_btf/net_dev_queue")
> +int BPF_PROG(rcu_null_check_after_unlock, struct sk_buff *skb)
> +{
> +	bpf_rcu_read_lock();
> +	bpf_rcu_read_unlock();
> +
> +	if (!skb->sk)
> +		return 0;
> +	return skb->sk->__sk_common.skc_daddr;
> +}

[Severity: Medium]
Since the skb->sk pointer is loaded after the explicit bpf_rcu_read_unlock()
call, does this actually test the MEM_RCU trust behavior?

Because skb->sk is not an __rcu pointer and the load occurs completely outs=
ide
the RCU critical section, it appears the lock and unlock calls here are
isolated and have no effect on the pointer's trust state in the verifier.

> +
> +SEC("?tp_btf/net_dev_queue")
> +int BPF_PROG(rcu_null_deref_after_unlock, struct sk_buff *skb)
> +{
> +	bpf_rcu_read_lock();
> +	bpf_rcu_read_unlock();
> +
> +	return skb->sk->__sk_common.skc_daddr;
> +}

[Severity: Medium]
Is this negative test being rejected by the verifier for the wrong reason?

Because skb->sk is a standard PTR_MAYBE_NULL, the verifier will reject the
dereference due to the missing NULL check regardless of the RCU unlock.
Could this mask the absence of the intended RCU reference tracking coverage?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781968391.gi=
t.chenyy23@mails.tsinghua.edu.cn?part=3D2

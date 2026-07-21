Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3557239903B;
	Tue, 21 Jul 2026 18:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784657584; cv=none; b=gsw5D2t+Yw/xiRrykz3I+2qOenpqmdTxWjK1CZPb4Ty4RMdG1nFGHssuAiTAHDrtjAUDsIhW/yjkSw6+84d73NUYx++kcLJGXTxi3o+rBjBDVSEh1wLzK3h6ZZ2D/uHZfVGH81Q25ZTkZCfHFrcaCwkZndNr/LG3gYBJEtTg/GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784657584; c=relaxed/simple;
	bh=GOTXWGIgTIVh86BYkheKLDzRC6QjKgkCZNGocWn65x8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CYdttiDDfD4JglIS0RSIiVlPfaJ/FQzUX51jvUCvC6E+MNRE+tmYR45iEXCMBGOn+/1VXGxOhKyddnWbSSkbDc7ZusNt+PiST/62+0w3r5wWvYhrM5uRkN5kDTzKSbVYxhP+lxXeQfhv8T7OTIxOKAkRQRHe3FzXdj/QKboCUaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRXMj2GB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRXMj2GB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739321F00A3A;
	Tue, 21 Jul 2026 18:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784657583;
	bh=GOTXWGIgTIVh86BYkheKLDzRC6QjKgkCZNGocWn65x8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=YRXMj2GB8HnNWkit+emhpgq0tGFSHybyhqaOXXyxGkCY5y9MqMfLwnU+7QA5Ykzop
	 qBgBaE7Rv+eN8GMyir6jrBu8QqgyLbXQFx0HxIDnX4CQrwKDoCu2N328zsSZNg15rc
	 eMimnQqEZUOLmBR22gvYe3buFLCu/6otr3cuq1z+/QYETUB+/7y2VKBo9S6SHT0hku
	 jE2Qci53TJzRXdS+cMUTERPbB0Ey3OhepLamCkSZ7EM242Rj9yutV2YPGytmxgAGGa
	 dtn8bJhxGubIQlusoZlC3YBakGZI0IkdizIGcr1gy9WtQMIdKUJU/vS28DdNiL6j5K
	 /S5ymVaH37Yxg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Pu Lehui
 <pulehui@huaweicloud.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bot+bpf-ci@kernel.org,
 bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, puranjay@kernel.org,
 pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr, pulehui@huawei.com,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v6 6/7] riscv, bpf: Mixing bpf2bpf and tailcalls
In-Reply-To: <DK3GTYQ5UOMO.CVL471XPD0AT@gmail.com>
References: <20260708064436.2971933-7-pulehui@huaweicloud.com>
 <a721df30ec2f824295000183c8e91f2c19d0bd56ae115b835b402be9eacc1c71@mail.kernel.org>
 <b4aadfde-9745-4c71-8dd4-ce433331f91b@huaweicloud.com>
 <CAJ+HfNi_icVbeB=jw-xnXrwzigZwP2OVRbzaF3VC87i6fDpdDw@mail.gmail.com>
 <fc972c33-1b66-4979-97e9-71627fb6179f@huaweicloud.com>
 <CAJ+HfNgPWwX3dfu=62TSMKeLD8m9S0rc2k9G8rVN7r2SuzQ6MQ@mail.gmail.com>
 <23cb9eac-1775-44b8-a9ec-10edde808a30@huaweicloud.com>
 <326eda4a-39e6-4f1e-8fe5-dc1cc9ae6739@iogearbox.net>
 <dd20e3ea-4b3a-45d1-99f4-79e99e51e7fb@huaweicloud.com>
 <DK3GTYQ5UOMO.CVL471XPD0AT@gmail.com>
Date: Tue, 21 Jul 2026 20:12:59 +0200
Message-ID: <87mrvkus7o.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Folks,

Sorry for the delay. This slipped between netdevconf and ongoing PTO!

"Kumar Kartikeya Dwivedi" <memxor@gmail.com> writes:

> On Fri Jul 17, 2026 at 9:37 AM CEST, Pu Lehui wrote:
>> Just a quick note that the verifier fix we discussed has now landed in
>> bpf-next [0]. Looking forward to your feedback on v6 whenever you get a
>> chance. :)

Nice one! Happy to see that!

> Yep, if there are no more concerns, it would make sense to pull this in.
>
> Bj=C3=B6rn, what do you think?

That was the only concern I had!

For the whole series:
Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

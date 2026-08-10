Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3920C3AB28F
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371638; cv=none; b=fdKF4JNYO6gnI00czOt/HjRaujHhS/fMsdCduSAZhIH/FfYHPN5VuqOJFwlapnHQvrY2mnGM8JohjVU3sBpfGQ0fYmPJdLVR0RUmG8CpJVipzzfMcfcvXHsmZMvl0eovPS90TdYKIfdIJoDshxHG35pgMv/b/TAJvJI2SQQtzQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371638; c=relaxed/simple;
	bh=3qtnKdag+7AGprnPTL/qBvvdL+1X3BTxhWb2L6o6UVE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mlzK/MtDHO/Vdvm7Xj12fbC6+R7MwJRaP6QMkO1M4kcKGI7yvyOHo9Jg+HuzoRQ0fC3L3JInKWCWeFLTlg/ccBKaA2WpfPNSYTVyq5+eVjD8IgPHz8DJ+hLZr21srmYKGh5SNTSp7pMBYyvog7clgJHSGvaBMrUalwyyBRUsqBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=o9INK1eO; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="o9INK1eO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1786371627; x=1786630827;
	bh=3qtnKdag+7AGprnPTL/qBvvdL+1X3BTxhWb2L6o6UVE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=o9INK1eOkBDZbtIi7B+miT2RnVFSi1h9jIvPklJaE6A1k6PQfjxNUv18zus/xLARe
	 B0na3ovm54KPTEIN4jA5Mg7JQcgDn5/y152f30qcum4UTtkyHstVhNER7t46tC0J1P
	 1fLC4vyjYEmVtJj+0KXMSz06C2alzR4NUeKDksy6q8j0/Jvq00W/oO1TayPYtDzxn5
	 j36/ZX4icII2lPkrG4xBUETQZn3A9H3NU6i+unqnzH44vMoIUdW/ISEc3pS+MX2ika
	 ewbwq6x6s4QI+3n/ZgIEP7MH8jc/IeJOnTnLegUq6yeYQ9rAcbuZI9Uqsq7IV+1m5w
	 2ywp+qdQE6sCQ==
Date: Mon, 10 Aug 2026 14:20:09 +0000
To: bot+bpf-ci@kernel.org
From: Vinicius Sampaio <vldsampaio@pm.me>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, clm@meta.com, daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, ihor.solodrai@linux.dev, john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, martin.lau@kernel.org, martin.lau@linux.dev, sdf@fomichev.me, shenghaoyuan0928@163.com, shung-hsi.yu@suse.com, song@kernel.org, tangyazhou518@outlook.com, vldsampaio@pm.me, yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v4 1/3] bpf: Simplify cnum contains() by removing redundant branches
Message-ID: <20260810142042.18168-1-vldsampaio@pm.me>
In-Reply-To: <0f2e2ab963398c775f5eed7438c6c4054d61e3da6e0a7ae731b56813ad016ab1@mail.kernel.org>
References: <20260730102129.15209-2-vldsampaio@pm.me> <0f2e2ab963398c775f5eed7438c6c4054d61e3da6e0a7ae731b56813ad016ab1@mail.kernel.org>
Feedback-ID: 138063245:user:proton
X-Pm-Message-ID: 6fadc3c6a223701b2133b14ac54f019d77450de8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> This isn't a bug, but would the changelog be tighter without the
> benchmark table?

I can change it in v5 if there's no other option, but at least it's consist=
ent
with the other patches in the series.


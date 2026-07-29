Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch [185.70.43.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476F63F0750
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 23:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785369398; cv=none; b=rqpc+0zi+C8JM/wyMB0vFHtvNMJ870fJfii+hIhjdAGRKMOGSIPXSEF39wcPuVCONOKFLyQb6j4O8ouqphl5pZxlGQ2wOJ2+czuUUo+sNdlrM8jtx5DPRdFLCIzCNA9XbWSIvhySVgXp1d//qCRCJCzqXEdeCJmt7/bzK1CDQhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785369398; c=relaxed/simple;
	bh=q4FNewTTWYQMvx3IjIQx4ydH9ThvXHyLw/JNcfkbzWk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s9ieR4Csol3v1nQIrTzZzYQUeFOyv4PfVv/PqPvKtJyy6mBQ86bjqsCP0wLMb0keG3cmgjjcPEuIiXKLKi35it2FJ6Vs0e/W+6hxmExbWvWB6CHt26PKROC9bmGLJDEYIRx2/7d4RhCNvCfyh5fdbPKiPKDS36J09zxRHPB/tEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=clbZCcSN; arc=none smtp.client-ip=185.70.43.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="clbZCcSN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1785369393; x=1785628593;
	bh=q4FNewTTWYQMvx3IjIQx4ydH9ThvXHyLw/JNcfkbzWk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=clbZCcSN8qOxf56y50LIl9QEV9LurCIZbXIXWYPOpJ0lga4mE4sfHMZzBiBUJhvnB
	 WRNMdM9I05IVwxDUrGKf+81kcd3ptmJPVOH+qHFoBzH088DTsYqofnSihJOixqjTT/
	 03E66tI9swaxltUytl3CBKdqhRFrN/CBRGGHVh25o9NeUGegd8eS/19ExbnokzP4FX
	 d97pBpBYv8iKsNCS1LGFOvJ/7Yq85PUao4pwJvUrAuf8wWejeuLnCMSpQJEMhsMgif
	 3uHhCkZaWLjEZgMJ8rxDJ1oI7gt59aeDdDDQaM9dzIFJSSE9k+0b9Ypv4vNKe6TXRg
	 Q6Zj5osV11y1g==
Date: Wed, 29 Jul 2026 23:56:27 +0000
To: bot+bpf-ci@kernel.org
From: Vinicius Sampaio <vldsampaio@pm.me>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, clm@meta.com, daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, ihor.solodrai@linux.dev, john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, martin.lau@kernel.org, martin.lau@linux.dev, sdf@fomichev.me, shenghaoyuan0928@163.com, shung-hsi.yu@suse.com, song@kernel.org, tangyazhou518@outlook.com, vldsampaio@pm.me, yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Simplify cnum normalize() implementation
Message-ID: <20260729235650.375675-1-vldsampaio@pm.me>
In-Reply-To: <427b5feb2cb3ab65aebd4dc7a69c2b4ec4788b314ed6c79fd5bcbdd4f3d43d57@mail.kernel.org>
References: <20260729194932.292368-3-vldsampaio@pm.me> <427b5feb2cb3ab65aebd4dc7a69c2b4ec4788b314ed6c79fd5bcbdd4f3d43d57@mail.kernel.org>
Feedback-ID: 138063245:user:proton
X-Pm-Message-ID: 8c1ea01cffcfc7d1d183fc4e07501bde2d54fdc8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> This isn't a bug, but could the opening line be recast in the imperative,
> e.g. 'Simplify normalize() by dropping the redundant base comparisons', t=
o
> line up with the subject and with submitting-patches.rst? Also, 'a
> optimization' should be 'an optimization'.

Sure, no problem.

> This isn't a bug, but since the deltas here are all well under a nanoseco=
nd
> and one row regresses, would the changelog read better with the benchmark
> table trimmed (or dropped) and a bit more room given to why removing the
> ST_MAX carve-out preserves the represented value set?

I'm keeping the table, so that it's consistent with the other patches in th=
is
patch series. Also, I think that the explanation about ST_MAX is sufficient=
,
since until now everybody who I discussed with in this mailing list seemed =
to
understand.


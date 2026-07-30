Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58603CB918
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 10:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785406727; cv=none; b=T4+akaHOwc67P9e01j67UNIospY3115HER9g3gViwZUKXEg5ULiLSUG1necdkfbV4Q1yR4HUuX0Puho/HY7D8CwBG9IaMwiCxXPBCN6pTdrMMaYyfML6M9dVpU1NBVrdWZHMBWlhoS7BgknMLIolv3R3YN4vjjxVj9Qx4FoIe04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785406727; c=relaxed/simple;
	bh=+n/TZd302S+TadP1DYmqoFLPMNwVQUEVvWv0ZGn5ORM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E0CoqwDrGSH3T6F4Z3YJTty/jdGuRUIlZPRcDxAnWLgZtx0lPeDA8DChRC6dmD4ZVFA5rxVNdoZ0ENbz1G4YBBC+3OpPbSrr2g2c2/prqcmj9KHudBRpV5rp0xaCPSUy4xQVHiAqDgRLryKHdB3KCYLSxacvKqFy8KvK4HAhD9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=aSphMS78; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="aSphMS78"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1785406712; x=1785665912;
	bh=+n/TZd302S+TadP1DYmqoFLPMNwVQUEVvWv0ZGn5ORM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aSphMS78VJTbKJHGM6e+rKYXgH75SVOAov9WtxiJ28xD4XqSIuoxbd0M5/YGUOcMJ
	 Ms5VrzPuZoXnhJMWeYij+6t2HTxnzkAL9LzETnOaVAMfwIDpPfUhi2Ungd6/yH+Sh7
	 3Y9S1TkITcfVUH+GaikeG2gS1Yt/vcWZfTah0fGfuLr05TlzHpVvuMJmRbU83nPaFu
	 dUV+GBJfp/PVJx2ikPl0L+q4u3RfkiBJ+6Ted8XXPLd15bdWrGs7vNYWYZGEc7cC8d
	 kSdsECBgrNnQW3HAs8Ds0bZ03WV2dr+tFXfzQM5gKRQ4aP9DOUQi+hINTHTpUU+c2/
	 MRpvONfupemBw==
Date: Thu, 30 Jul 2026 10:18:26 +0000
To: bot+bpf-ci@kernel.org
From: Vinicius Sampaio <vldsampaio@pm.me>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, clm@meta.com, daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, ihor.solodrai@linux.dev, john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, martin.lau@kernel.org, martin.lau@linux.dev, sdf@fomichev.me, shenghaoyuan0928@163.com, shung-hsi.yu@suse.com, song@kernel.org, tangyazhou518@outlook.com, vldsampaio@pm.me, yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Simplify cnum contains() by removing redundant branches
Message-ID: <20260730101849.14282-1-vldsampaio@pm.me>
In-Reply-To: <776af17a5b92e5d99bf506310ed77ae3343147e2d516494b4d548e2fad7b6b66@mail.kernel.org>
References: <20260730001145.381820-2-vldsampaio@pm.me> <776af17a5b92e5d99bf506310ed77ae3343147e2d516494b4d548e2fad7b6b66@mail.kernel.org>
Feedback-ID: 138063245:user:proton
X-Pm-Message-ID: a961edcb85583d67c6c929cc347b19785036f7d1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> This isn't a bug, but could the opening line be dropped or rephrased?
> It restates the subject line and uses the "This patch" phrasing that
> Documentation/process/submitting-patches.rst discourages in favor of
> imperative mood. The substantive rationale about circular ranges starts
> in the next paragraph and could lead directly.

Sure, no problem.


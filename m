Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6C1246797
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 02:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770258689; cv=pass; b=pDUiS22nL9qx6+bF6dxST2CyLP1T0sQ0R2g/9chxRdgVg9s41ipw44QPWnT0Uf+kV0oydi275mnd3fSzNyq17Ax9v69yG1qgjwhPDgylJtYBQosmGVe5Ce22t6pLJS9rUnUg1Bb0gCmIwr8nGCeo45NtHsdGCXocMdcTGtmUGuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770258689; c=relaxed/simple;
	bh=5AbCWXqj0rWtxfe99mu2ECl8wlzaOdHMNBsseLAgS9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=byvxlr4HoXTAwiLyEnoctUqLBPvKdmTlZ4GwiHg6XaiCl56YJnzzcV7/miMZFyldDxqq7gT4Wr7wuytnxXlZMItEaZZZxR4w69wfIvlo7nyNGtiD7ZOLTyajwRyvaZxhFHpjYDDlF9yr05jf2/sTWkM+6JAJB0VdgyuV0eSQFK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dN7iZx21; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dN7iZx21"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42fb6ce71c7so275701f8f.1
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 18:31:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770258687; cv=none;
        d=google.com; s=arc-20240605;
        b=id2knOe4rHs8TpYefhP4WQq6jmNMVeM4763yllczx54Ix1XXAA2n+fjNvoUNsNKiT1
         o/mP/ArwLajaEOk40pmUsxo2VPVxbRNc1zGoEsVRhQy9aHmtpI9Zk0yDJicQxhZJcVV5
         WqBh3onXsor0lWVWVsCzjRVc7HB5sM8AMI23CEJzj71VB/2IHbdX+gq3N5PUEFcR8iJi
         PXUjgnudgD1GZw/eaz1NyRERAlkSWCMW86PuhX06jJpptylEgy07jsGDalm8SS0aBfVp
         GC9W2GBbCI1dWOFxo1t0B7jNvnJ75kw4LoPIrY7ehVCnHhUhT1MhPypkeGHZj+n8do53
         FEBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5AbCWXqj0rWtxfe99mu2ECl8wlzaOdHMNBsseLAgS9I=;
        fh=/vcNYrAJJb439dsZ7iBfi10x9/H/MJg6e/sjvEyepHc=;
        b=ODOL579EIIJa1XSounvI9w5oJitsYyXc+1WVxNfbArQ/yojKIaBmBdwuqZQ1b5oB4w
         sv94x9FuAWl5O4R4N7FsFoESjWHH9VREe26dt0smmiTuSYoR9BnKNK5l0kcsWdftqLb7
         0iEhbypQwijlqJB4LbC6S+qGU+V8kL/jOkEwUlbxuuo+Z+Y37djIUTQgYVrhFR0ENcGB
         m/vh24Om5yvuEZenBHe31zYQv7yem7efOtrx84bEdV2VAdKmADLzQPcpFzQk4A9/AN4W
         TKOCz0IniVcUQ5HuSyPOXnKU1kZkrvTy/356WG58wlPSoYsNPwD5kMObDP2sw71Ba1+9
         0pAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770258687; x=1770863487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5AbCWXqj0rWtxfe99mu2ECl8wlzaOdHMNBsseLAgS9I=;
        b=dN7iZx21EANvHZLClna8LFFb+sLbaoIRyvUXx+8ZFqvm82NkpxH8OdMRpDdf+aUp9A
         UVh9aPgOMbsizX3wcS26b+Nro/d0/4n0x2pnRdnBYbOvo8a+styOThS+GhDKxkPW8q9K
         eRAG2vnqCJWrfvL1ajjqlaLz7UI4xzxO9E2CKQGlsuSu7By9fRBgqLxNaRivgB2IGABU
         524OJhqRG0FSFVafRmjt+gHNilUJZOsmz7+egNc7/g6M+pEIjugjDbQgw9uL1jJN5c4I
         /ZEIzl44/fQnK4KdIvg6RGy4zEOsvPxmKrQPHhbF2UNWaVZOxL36NboH/XaqVADJz4Sd
         EIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770258687; x=1770863487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5AbCWXqj0rWtxfe99mu2ECl8wlzaOdHMNBsseLAgS9I=;
        b=sTgWaMqLwrRlTMHZPcsvl65bL4Rq/LViLwKajvuS4JWRNRHEM1rBu8X4VMUDi/Ji1N
         71KKrT4pHddI049meLgcCDoGr8itJjEgM9owvr1SDt9kZEHyj2sT6zKh8J5tcRfjSoc4
         yiK17GtKbeIMEehVYophJrdu2FtWhCxAoMksy3Grtgg/XlRviwhZzvqEfTD6h9f1+Ctc
         cD0T5sf3PN6y1xSENx9glEAlwgWTzbigmJi/04ZeSCnayvObpK9oSfjFcYvNEkrr9KXP
         anfVZlkM9he3NDPoE6s/712Ix2WyDuLfpwOtBynyAsGahEl7GSbfIC8sLXJ9ZjA0aJK/
         3ghA==
X-Gm-Message-State: AOJu0YyGaeUsk3aold5dY1fXRV9yeOFSYPX5M+FFwuImS3Z+BsmeJ8oC
	YSUoH+G7NSWYZbEIVamdZWnzAu2dmcWpS2bfBqNs4CL3jpwS51jppNeqoqPa9yT/EEH/Rwrf+hp
	n4es+NYW9MfH7DmdyLwXepFXNyj4ON1w=
X-Gm-Gg: AZuq6aJLPrPjb3EJ5dwSmXekcFm3xyeQxWSCi8K/kuYn1AYZKxX3VaJxWKrWygdhkDb
	e7sy8WUBve84NhZ8mMfprX7Eu2e0JCRznN1Y6AJ8JlxY69l89MiC2f8CLQ9vLvnk8459tZMRzWN
	lPSZurMoyDgsfl0ATU/iRBHimM2B8NTLr3XRuXpqg0kqE7z8G5JuLq1ZjgguCJlKayj5iDo9Itz
	pf2sdr4iuOKcFf6d9eF17alDii7UZ6bZEDWIwnJDnpQNQw6qBrsKCBo3pmVscDPVNtXiD7xZo4M
	mFKD6Ymw7KeV/CD7VfbIAu2jX2wRv5JZJu67sG3Wq1caBmux4YWPS0xYg2rOBWUYSgkEVaKezcz
	mq0REiwweCkmA2Q==
X-Received: by 2002:adf:f20f:0:b0:436:1882:e90e with SMTP id
 ffacd0b85a97d-4361882e931mr59458f8f.2.1770258687077; Wed, 04 Feb 2026
 18:31:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205003853.527571-1-memxor@gmail.com>
In-Reply-To: <20260205003853.527571-1-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 4 Feb 2026 18:31:14 -0800
X-Gm-Features: AZwV_Qgc38d_ziGamfZ4z8MCRj56JjkdN_R1iN-0Q884mRBjEXpkLAjaDXMr5EI
Message-ID: <CAADnVQKeRgyevspE+MnBRtJtMQQmyctAnzex0f0rOnWcApRmSw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/2] Fix for bpf_wq retry loop during free
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 4:38=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> Small fix and improvement to ensure cancel_work() can handle the case
> where wq callback is running, and doesn't lead to call_rcu_tasks_trace()
> repeatedly after failing cancel_work, if wq callback is not pending.

Applied. Thanks!

Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4791C3A9630
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 07:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785743093; cv=pass; b=pP+AYFw12I5xmwWiMxHiYKxuQFRVEh9eDtaS9/yGcqeQ7vUVgDCQ0CV1dfGxOaRBaQw23tRZOgFuM1+8YN0U6x4wbS5rWp9AGxtJDLQ+SWnPCBTYEnhOLIlT8gRnc4fghXZUkMGeT2Tvc0MBfYbe7+Efd8vC/AzNun2UkJoHlMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785743093; c=relaxed/simple;
	bh=cJDlXSq7P893Ibj0jUtw5pn2rm4iYQEsYVVoMt9+iWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SLUZnBmlnv/X6cFNhBRxyZQAjF/wA2ZrXMKbxUAHsSFlLZmE3oLkanlq6NTKcBT1/WKyb9RqT4JNZUI/HLFXRsiShjB0wkzX2CdvoLMs2b5/hxSw54hIrBYoi4Bi7prBEHf6yo6CAX/c0WOJEZucYCVnnGKPEMXKXGCRJ6QG8gY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=siINx5yY; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="siINx5yY"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b29599b81cso4415215e87.1
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 00:44:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785743090; cv=none;
        d=google.com; s=arc-20260327;
        b=bTPx/ZeBPM++uA2k+dMbf1Plau15x54i7JvRwHJUZ1DQcouzr50WC32XN2F80kLdrq
         oMgt4IQ+xDf80MEDE6KyLg8f5IlA1HmrP1YEHbiZAjiuEFnCtd/4Fwf8C36x/aVVsPr+
         soXIXBfn0uCC0KUtTexKqXyjV8CV0i1bYVlt1qWKQ2aISUXwMPbWRSX+x5JtiQEzncGI
         tgxpYl4xJg3SaTZT8EU6Bt0fUauZO0r0zgH/I9DAJSALmin4DFvHkbiHk83pE2qftpPP
         3eMQBBerW6BUeRiaJGDGjkQUuTYjKE+ORF47LEUM1DvadNQMrC++l6meLrc4irJEtjBF
         6QVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cJDlXSq7P893Ibj0jUtw5pn2rm4iYQEsYVVoMt9+iWo=;
        fh=8GAb1Mb+qxtIOVEZVrf3J2AoChRw6EceRUAOI6TxVic=;
        b=Gma1ufyrimhuJkWF4JQpJyt1aPppwAxl/jn1vSF6XFCyMi5NFTW5PLUhqFqbEuHii3
         a0GaCR3+RwywnqNCqWrUvBdlj9wK5oOZYlEGWEbnnXtbg6BJ9APHS+heabSdGN53w+UF
         sk4b00lRtTim9FMMlxI/Wyi4ZTqiULOzzwEbJGefoJwtqCSSwcV2nbEByxBj7omF/A5J
         WbDN0XulNBy5Ydle3hRrFzZbIDZgvhjDcaHvCBB4o8O1q8BogE6ZbalJtl5mkMc7ZYE+
         2ifF27zAGmCazX6tFm6YKnWg2UnTcmJW+0SfxvhF+jHQ3HEXxSeLfR64lSg/cRATENMT
         DDHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785743090; x=1786347890; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cJDlXSq7P893Ibj0jUtw5pn2rm4iYQEsYVVoMt9+iWo=;
        b=siINx5yYH8Dm2asA2HLkAO5Qdm3pS4G6Fzfrincioc5CHNyApBhnDOGjDpOkdKaNX4
         L8UAhvdxliT6mnFOtqcWCJlpiQax3SPnxTHLr6+HlaSdVSBfwSiJS00Ch/4UEntG4Lxo
         jdnTVLDmLXNF4b/7xP0ZvUcuhA2IxxJoAQMEe/HrYqF5llK9Kj68B8/PBBLYH799CO52
         fsvp+NPzUWpU3m846gQiAhdbAMn4jv3/opYMxrQVWOsVTCb52hBDCv87FL5wy79dMvny
         ZzCT4XZbqQtR43ZPX15tC4Zbrc85aWUz3WTDfuitANUIJQmHgiU4fvIU77lQHxlH7Kzx
         BisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785743090; x=1786347890;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cJDlXSq7P893Ibj0jUtw5pn2rm4iYQEsYVVoMt9+iWo=;
        b=KE/MVcRZGE9TjGj+e/2vVbICmPoEPvk7XTIRFwvIK8+iOdb6WLv7Cm9FFI+oZpI3Tg
         EK/2SgBmzrptqUuLpPc59j7s2CoyWbQhevkLJ5BvzulbTpF4HCpLqAXzbejaXHay1hqI
         AvA4xPz7hPJxYga72g6Ryi2/aISqoftbZ6H0ozoY696k0O418CEjftOoRenl4mSGFO8a
         CGXcXcZyYwRQroPZuAnw2lTVO8PlNNNaIV10Lh0pMHVC9mVoY2vBu7RfZXBeJexjbqYP
         iZfQslG9VH5RNCsCeunKk6vlKVgDLNTnPhAJNBGRRpeR02wqkzMbSzoj3fkmZBPN+fLL
         D58Q==
X-Gm-Message-State: AOJu0Yy4WcyHkvepGQC2XisIYbgaxSoH1ZBXkOGs2iSXeip3JUpUGESG
	yX6OeunWbuF2oi9db3ZBTw22PNjQy4C8l93YQf2qcTP7JOKZ+voIF5HbIuPN8obnKwdcf/uILyF
	TIT8gUCHhobW0MNyn/rJLGxs4QqUqoQk=
X-Gm-Gg: AR+sD13JpCt6yNgl/yRs48S5lt3PSYG+04uf4T0dTOJ4uYZ6S0rYYzuZzI0UdqsF2Gb
	8q0Cny4eLn0tVPkhwYRpucRVC552Obz5fXShczJjz7H4l3xEXFsHj8rwEdjMrf6fbMgYRGFMKUu
	clnbIdDvL5uxXup9fomnHmECP2DZag9MqFgEihEX5XnRn7PyFXIZSXlMXd068s1Tt3dsqcydnCt
	mNNAXe1onEmTBSwE40GKET+0eWWOqPaEPeWW/Ds02IM+zRFsziDeNx/KuZD65jmcCIXmDvh9SHV
	0kZjAkIfJ8VhOC/PGkrXqpv7cE6G5zSfRxwQxteJTKxHdq4=
X-Received: by 2002:a19:6b0b:0:b0:5ae:b269:10f7 with SMTP id
 2adb3069b0e04-5b2e4f9b568mr1213456e87.63.1785743089931; Mon, 03 Aug 2026
 00:44:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726235030.1152542-1-dingning04@gmail.com>
 <20260726235030.1152542-3-dingning04@gmail.com> <DKEUKIOKSY28.2XVQVGCKLI40C@gmail.com>
 <CAJP4iuuYfqFChH1P2=3Q6WxHbMTNnAkCagR2k+Lr4W155gCj3A@mail.gmail.com>
 <DKF31NEIMOOB.2CPM6KGVXD73K@gmail.com> <CAJP4iuuz0T694PnyZmcq9f9PaQLX2kV+Sd+veQN+uydsvZ=BFA@mail.gmail.com>
 <DKF3XPW4HDQK.FDJMYDLGXZ60@gmail.com> <CAJP4iuskVz4RUrXKcnNhcAwMwcNjCP-Pzpc6=HqfWoDpHKWgWA@mail.gmail.com>
 <DKF4LVGKEKE2.2LUROK1TAUGZ0@gmail.com>
In-Reply-To: <DKF4LVGKEKE2.2LUROK1TAUGZ0@gmail.com>
From: Ning Ding <dingning04@gmail.com>
Date: Mon, 3 Aug 2026 00:44:38 -0700
X-Gm-Features: AUfX_mxgeBOTmRhTgN-9XeaVqcvlacCdpIjswSqlId5_9OEg-7S3pDyDrVzmilY
Message-ID: <CAJP4iuvL2=72SUwjHeN7mDLKOSkM-KKvBVYrE40R+rnOJs9P-w@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] bpf: Reject untrusted pointers in refcount_acquire
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, martin.lau@linux.dev, 
	davem@davemloft.net, greg@kroah.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> In addition, I would add a comment saying that the BPF_WRITE case for the
> type_is_untrusted_ptr_alloc_obj() types was already rejected earlier, so =
this
> check only permits reads on them.

Thanks, I=E2=80=99m preparing the respin and will check every
type_is_ptr_alloc_obj() caller to decide whether it should use the new
stricter one or stay the same.

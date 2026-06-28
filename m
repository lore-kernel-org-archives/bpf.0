Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C1B3A16A1
	for <bpf@vger.kernel.org>; Sun, 28 Jun 2026 12:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782648994; cv=pass; b=TzoZNe4TqYx8TcBYfwzYJxbp29qg06sbOvY+bog6py6ejUjb4fj+D0pWAPZjL1I5zwNZdG9RffOQi/nA8NDcypat7BEeq33evJVfqtSeZd3CnOeGdZaT8zlAONk9HwN2hAkAHaJqfjT5S/mKGB8osgYcTrsBHlvvrXROwJF3Y98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782648994; c=relaxed/simple;
	bh=RMUcDI1StIDI+D03aa+iM8MljuIZTtn0DfooOOj6yjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BYBCJ16zHMePIM2tQoxyAXe7w7HyYZPrQIKjkm06mzKJs2LpW0bhkol0RnhGjiYMV8nZlIlyEHaXMnw8OukaedgwjeL2dtKYoumVO76ob81/vREbrODneCE2nFulSN4fePZOexj4o6atPc3eQlZ3MiAQmDlQCuMO29Ji9Ojrc7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=jztQfS8R; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="jztQfS8R"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-845b733e82cso1481350b3a.2
        for <bpf@vger.kernel.org>; Sun, 28 Jun 2026 05:16:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782648992; cv=none;
        d=google.com; s=arc-20260327;
        b=fUreM4I22Q/f0ooIQNCEWMsP3/85HO8b92pXhJ7Le1j+NnVy0wIADr4BeeIb8nig/E
         6Qdcdf9loXSqwRCfJZ2tZT0QGJ/WP1OGeO0V90EE1BcqNc9rG8bXTa7ykOlcEnhNyeOT
         oEXQFwQX6wFyFy6xEMicdZUG55pHckPHRswqLYCFoNy0X4UIeUX5K699nqXMd1XGj9eB
         38bLUAQm3syocTiTSf8fJ6n+KDmzVPfy6CbsTO3jzok/wIfjC39gqPErRXWrN1MyvEdm
         UbUEukPrSvqtFtPpkVdKur70RK3IBlF+JHMpkE0E2eKdZp9Idiv7m8rPcgSE1Z2ZRpkL
         RAAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RMUcDI1StIDI+D03aa+iM8MljuIZTtn0DfooOOj6yjk=;
        fh=1NHhrpVCiqRcEqYtXqot8+/0F+5WE7aKd/ewuCf6pH0=;
        b=BQruxS+fHdobg55yHcow24HGLBPKdhg/Ro2YkYOBTuBK68IvNRWYmCQf5d2aX76PDh
         Q/Q5W+7hU5YAEqpIRQKyhv3HS5gUYtEypoK4zrUDYZaRnWK1llgx+S/QWh1P7OW2zEDW
         Fp5z3LQ3jMw1IWOj20sp+/7BWliELIq9WqQOPJuXkKHSXK91v3Pgy1VUytjIgBs4UxcH
         bhhQG32DUTZIVZk6NOF36EEbt2Tl5LcpdOqBfUUHq76IG/pY/M9vrb7CYlMJ9caB9ZQh
         D7avRoLQ804rRd6ED/VMNK95FYK+sr0PHkWOjzCGsRU6rY7ZTmbuiUlwqoHoBM6b7D6P
         BGcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782648992; x=1783253792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMUcDI1StIDI+D03aa+iM8MljuIZTtn0DfooOOj6yjk=;
        b=jztQfS8R4tB59V9HDCHQFZMecGZLae67Ye2WSJX36nkVvG8s3dreE/aTvn6g7QqaT/
         6CMRC9PrAoXgbBMfXaqzR3iHyX7ch34Wh1qQd8us63mMnjA1JN38+kL/5/YMcuKhmoid
         blO566MEuVnxNRKNIuLxn8l0VB+nqWOfG1cPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782648992; x=1783253792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RMUcDI1StIDI+D03aa+iM8MljuIZTtn0DfooOOj6yjk=;
        b=ObMYKciPq5dH5odmvdLnv5CbmZRZfzJE8S4blrwcuCDwVChZ2uTG69AgUS4ZDa83h8
         wfOdfAP0JxQhco1NIABSNIsWDPrOmzX7P5Tz/3Wbc8igAT4rw5V1q5AX5BMDgX0X/B6Q
         wbREUd+eD9rsw8C6plpByaX/pXn8QAa+Ldo0+qopTxQUf1BSiIhhDd86BVO8vGRC5W9O
         v9uu8Sw5+tZlPzjdoERTrWdyBAVXxeb9z5ae04PkNcMi5N8KC0u1mdZSVim1YAO8VXNQ
         +7f7ukPYvyK8DYbzRaQ1x+8JqVe5Ak/RNGRiMoyG8p0uPdqlYJqO/jZhvLhXDBveuHUG
         d5iQ==
X-Gm-Message-State: AOJu0Yw+omqDFOOCwR8Q7xs59mFrRtJ4dquEk/UaxfJkyj7gNtiQOA90
	yGhyqM6haXaRhODrDTgiNSGvpxVfjULfCgKqVmox8gSKj6myOPFTknDZNLODR15oHx8ZCaAXCGM
	Fnk7ZXdajfrytjhtGLhKQOFFcaoDgkjnOGoT8R3GBkJAM3becnZ4=
X-Gm-Gg: AfdE7cnhokzNBIpLqt9N6Rqw+xxuJbp7s8hD6yQbVtTbOUgtwm6hTQKsxtHgcD9IhA3
	zgHF/XcbqC0hg7+pi6HkxyMXH/faQI/kgbbhJtkoDhd3VxTxp7AgsoqG+oy99YfNtdirif/90Dl
	WLNF+hE7nJzU9W0m5+L7h7QkcuwvQztkERFvU9HEKWBw2rNvFFeAI+l5r6GGnxP2rCBb6F+az0r
	qCTVodBVs3woz3wnft9RenNxExqLUZ+vNJjzHLnZ8u3GpAV15/TZOyK7W9D6ucnej4FLXW7cyqy
	mDa3kDWK
X-Received: by 2002:a05:6a00:94f2:b0:845:bcf0:118 with SMTP id
 d2e1a72fcca58-845bcf00accmr11132513b3a.41.1782648992308; Sun, 28 Jun 2026
 05:16:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626165156.169012-1-jhs@mojatatu.com> <20260626165156.169012-2-jhs@mojatatu.com>
 <20260627165218.959371F000E9@smtp.kernel.org>
In-Reply-To: <20260627165218.959371F000E9@smtp.kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 28 Jun 2026 08:16:20 -0400
X-Gm-Features: AVVi8CfK6ZQWPR_bECyYbUG-IfHbpb8Amli00uwF06yQtXNsZDWtTMw8GIyhK3k
Message-ID: <CAM0EoMmgF5HFuGYWAg3Mrx7tP_BWzjuu7w9UVsr=R9soV3fXLQ@mail.gmail.com>
Subject: Re: [PATCH net 1/3] net: Extend bpf_net_context lifetime to cover
 qdisc enqueue
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, netdev@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 27, 2026 at 12:52=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] The patch moves `bpf_net_context` initialization to `__dev_queue=
_xmit()`, but fails to handle asynchronous qdisc enqueue operations (e.g., =
via `netem`'s `dequeue` function), leaving a NULL pointer dereference unadd=
ressed when qevents execute during `net_tx_action()`.

Indeed my lord, this is a valid point as you described below...
Even though this is a pre-existing issue I believe it makes sense to
fix it in the next version.
I was too fixated on fixing the obvious issue that i missed this one.

cheers,
jamal

Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93D0B665
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 22:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770849671; cv=pass; b=NQvnq5uWaWVLttlvCh1gHZ3SAXBoRpTfjVb4EBQkpoP6POkJ0Kh26hcGa7l0LYPrAmdW83sChCmjdg2dStI7KfRnsw87lihun+t/gRS+QKd07T6Sip9LhHRNEfaPsM53M43gDpMhbgbfC8c53ubV8NbYYJDCaINR+5Oog62I3AM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770849671; c=relaxed/simple;
	bh=gazHbjAOAIoDDz05B2M0Y2xB83Y5BHq711CbDB+rFIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sCeBiv9JCo19a0JB+0G9/BqjcpBFehE/yo6kHCixoWXOYYTVwIomGNvx0sGUODeR6a58HirXY4U2EuEiFJvsrxTDYquWrMl/rzmXgXrB/QjCHiN62jSBx2B/DzrphpTf1ApLDUFzs3Ee/+lvGbvpial9/jVveAiJ6kfk52K9vOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFhpZLZV; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFhpZLZV"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4362c635319so2171578f8f.2
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 14:41:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770849668; cv=none;
        d=google.com; s=arc-20240605;
        b=IScwqiWQezegfgCKaaOBt7b7vQcQsuMLWl/bnbxu1+Olrgg0nEr/EQAqBFe43BgmCI
         SuSyjHJuWo8gBeFUTZPZXLRJjtpbQOG+aGfoQbbMGC1H49vzfxlnfS8TqXnAUh5k6I4b
         JJ5ZQ9eVjCtECO0Zi0xRovGoqpAK9VZgYgY+BAWsNLMmvceWoJcnSlchHbebrEKGNZcC
         MM07swUJEdEUbWjTU+o/Y3y1FRrCxv1z2euQOxeySTEMQ2DJuiXV1J9Ya18woKmjZmtJ
         9URr4exJgQIbFxtQwGoALuzbyOtPWZo+PNzFSTQOVKqs3TWtbEU7by0cv1mizCofy23V
         5Qtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gazHbjAOAIoDDz05B2M0Y2xB83Y5BHq711CbDB+rFIA=;
        fh=4XGv0Wm+KOLE0uUil1EUDcGXWCKFEcxHxzSs0USpHRg=;
        b=Zbt4Pq/4x6RUwDJK4IuGF5iaE2A1uL4BhFoRlb2ltG5OzUsr1OsT8TyQci3w83ZYqX
         lZFaahAFVbbsz+9qvHSkSeY2dWmW+fpyLAHkUOub2fZ/7J4e/KQrglhVULQeY130lexJ
         n1RaVqCT6zmX3e6kqmG9Zyfg9U+sU4/LezDZ5YQGqgigout6kuAJfSKhKa3n2uBqf46k
         TecEAKdBjbihev2v9Ifda2lulZA4BNbkkWQVYPacfe2+nxTgwJvT+0Z0W1CFG2Pgoec8
         PyKTqOzbtAiNyRjghKCyDlBJ5YJsEpLMkKjFWwAySDW2JHTWSNknC1/gRHBWvYo8l9v2
         sSyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770849668; x=1771454468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gazHbjAOAIoDDz05B2M0Y2xB83Y5BHq711CbDB+rFIA=;
        b=IFhpZLZVmcSQYZIU4mLQbSYPDOCoACZ1MIjQYtBeOQqoD5ePrNgDy7AAJZfyUZ2ju0
         MbkeZ0loD3cRDffEBDhBhlLhD4toB2J9OnOscYsogaKggeQA+89QUABeNOk3M7TEG4Ot
         K5t3etLH9hqlRuNlYRdoPZ1J1nUyMTD4BkRTQXIMN6K5292D96+whvifOYDUdJ3jazQI
         FzOdil9tYaAFhZAWg4Cs/5BrOmExEPHrwTnGMT/BWBIuqaMVsO6cKCbZy3sgS00IEwp2
         cuEVjrf/jT+2XBpYpqTRrbtdDyrnRTTyXbIjcuVLN8VucQ4Ul6iX7ZTexSrGkYVRcGss
         /uiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770849668; x=1771454468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gazHbjAOAIoDDz05B2M0Y2xB83Y5BHq711CbDB+rFIA=;
        b=rcqyUQzeo44qc7vtXNjQ5MrAruL6EPjjC4jBFyFVdBDDzwaSk+uUZ2rcxKUuDaLMsR
         DZj7h6hUAt2DkPOrwLYXmG/ePxSsbWPVOIwVZPGap4rpgcQTrbFDqkooTp2DDq6h+t+G
         1QFjX6g4VyPM0WoE/BC7FVV7qSNbmnDvfiFhE1BeSb2qL+gxbEGwEp5YjTha4sNEg28o
         v2uVFDDCVfRpAO9swYhskPNas7918ogGlP1XWVJTd2x5DZmprB0j7C1b/qP+ZYZy5+zZ
         K8+t9oqPnXy2P4DSfS6flBnA3mZFO7uRmykkHYOlZucFPdOaEJTY0NrnjNE2/LN3rQB5
         6PXQ==
X-Gm-Message-State: AOJu0Yx/YYR1REUHLiAoBlNH5wWxn+f0AXsWUXPWk21IVSNN7bLJDZJZ
	uWLIxG3BeL6ewMdjr7CsRGHgLO5PoXV4QGxCQbfXb1pT0hPWD9ouFHa9JY6MOGs0SOD4XMlRwvp
	+zYHwVEHy8eIjCz9Fim6iDKmLNNurgNo=
X-Gm-Gg: AZuq6aIH58nAoUZoQXok3UmUOMOOc1Bbe50HAjwp5TO2MkHn28eNOQaJHBe43eZfmM8
	2+x5Rkw8TnIutoj6pWIi5Y3POW/Tlb2ESGTuHCeUlZMU7ceQCznKy/tl5nV5GBmfU+CYUSEv8pH
	CG+R/X6+EoBdtA96OwO71Hh6TXhyaagYOSbRzKXpWC1JdYnl0UBsOoTGcW+bw7mwKUmXRYL2sHE
	iw/gkrM5sVAOQJpSMJLN/dJgq5H+qy4ff9edxYIl217WCb7kDAJmgtz5zhw9Zd/zOR/k/DaOCXO
	AVLze/MWqFtKBae/bseuLt19spy0F76WLRIFvSLrTGdnjs62jPwX9UJr9lsBdhHCF6KT0Cju+cq
	oZ/gbvYR2/RtKSVEZDmz4sjpjGQ==
X-Received: by 2002:a5d:66c5:0:b0:437:6dc8:c372 with SMTP id
 ffacd0b85a97d-4378f178fc6mr352209f8f.38.1770849668119; Wed, 11 Feb 2026
 14:41:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211185747.3630539-1-memxor@gmail.com>
In-Reply-To: <20260211185747.3630539-1-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Feb 2026 14:40:57 -0800
X-Gm-Features: AZwV_QjaLUlyJJvFSiP_nvTm7XNhY6mArKBapdKA7NoQvBe-jloZNPnEyGKuoO4
Message-ID: <CAADnVQL46T968=Oob8=cHOMXdiV3TNzJc5woEPqeQ9iYjMoV2g@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Fix map_kptr grace period wait
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, kkd@meta.com, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 10:57=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-=
fast")
> broke map_kptr selftest since it removed the function we were kprobing.
> Use a new kfunc that invokes call_rcu_tasks_trace and sets a program
> provided pointer to an integer to 1. Technically this can be unsafe if
> the memory being written to from the callback disappears, but this is
> just for usage in a test where we ensure we spin until we see the value
> to be set to 1, so it's ok.
>
> Reported-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> Fixes: c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-=
fast")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

It was applied to bpf tree.

Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E282639184C
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 16:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774543787; cv=pass; b=bwMEWKBTiZP18ujXa22L5xVIjv06WU3YV0KY5iokJ0A60ZmUT2EJzeE6W0IIuJwWj8P7xEwuG1W8N1mYtXcVCBK4oP/6qNQjVPRXJZ9BkqL89JZu07okgh+oMqq2CHD6JawD9212VTo3XuwEYdLypVxZ4T6Mtou8DoopN7z5mI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774543787; c=relaxed/simple;
	bh=HDnpTRi9f9R1c2iwgUvZUHCtXIHtlkFWDW6j6CqCTEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pq8CqdME09M6OUg6Uy8mMtyc6pv5HtvDLGDKZoeT2lZ7Y4/BlDalM9g97I6Xp4fsL2RMYY3YYYpuzOxIh5qPjj8xgw6WCPeDaweh/pjYGz84S96cOhDZpoQREmfFnrAiFtFA8OE44cBzMNi2L+vORMhvPVVTbJXAa9UXHR13h1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAC1NG0c; arc=pass smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAC1NG0c"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so11275085e9.0
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 09:49:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774543784; cv=none;
        d=google.com; s=arc-20240605;
        b=EnWtqMOiQnK9jzXkTllcw7jLhzw6PZQFM3s5i3loy7TVI6n1DGNaP7dWHH/Ax1z4O0
         aiAB8x2OxlhLWN3hd7O9oARTGtRv7qlGDl8vG3HwU1bIGFPvD+YvIKy1zAEsHgWWSBc/
         /9aP+II5ye5i9t9K2583FCyTH2J36lmr4fNWEcZ3fwBK614hKgnRzoLI0IYG53SokpEU
         b9RUXh9f+bGjayOCkvouOr87ihB44fJNFPoSonCmzsuTJyLu7/IC2AzKq3ZWhg7hMa5A
         s3jao7PeQzsrCZHEujlQ1yF8KFIdoiWFem7XErFBrRWUT3rTxewsKneQSellW4qDRdOJ
         s+wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HDnpTRi9f9R1c2iwgUvZUHCtXIHtlkFWDW6j6CqCTEg=;
        fh=mV8Uwy03aTQpEc71kkKqimIDFbwq2oIhKiU5zAUO9K0=;
        b=F2UXffi24l7CYY1QBNWxljdts6bhGUAnELdMbzcp/1ZHkvlgLda82YQ1ysfbsfh5un
         x1Uidm8s2NNUPI33Zgf1DdekMIyDgpYCVcWlOQJ2tNr27VbPVgULDRc90dfvQVKin44U
         4+fX9MBTTIf8OZOHoQPz8tmFxd+6SUsrsP/AhNv902XlJCRVFyKyXG+KYRMEamQZpB54
         dXZM5bTbFBvK+TTP793qY2Mu57eQerpEqqBNef+Wu2o342Y40TJsvfBf5nJZCttZ7L/N
         Rn4WipJiNk2sE8kFcHLFdzHvld5t3jSOB15yHChiauxM6R4YC4Vb+zm4BecAcDmbwyXw
         T1Fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774543784; x=1775148584; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HDnpTRi9f9R1c2iwgUvZUHCtXIHtlkFWDW6j6CqCTEg=;
        b=cAC1NG0cMuvgyQpwBxN7JRQBy4s9r0yfg9mgyh588VloVzuc8e3wZSslj9sSZVBsqL
         smTn/HC1220k4PHxkA9MFwo8YHpN2bRTe4z+FVBCtqnTB+vBWv3fZ+mVAlas6BK9aEfM
         c0F//zFPSS9WphYpbIgtKvX8TOFW2ZHCn+KJr+y/gx36opHv1FsAZ2IzJK3365PKbSAE
         16fATOjz7HcJwsE/ui4E5CrF8PPCk06w9F7vphBcl9utceORgJ3aVjZOU3R9WAYXwhcK
         s1D/A9Y06rs0VTYOCnonvbnBx5sNR2sYwsXgw5VH3jacYywzj+A5tfmBaZEWY3A3C4D5
         1Vaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774543784; x=1775148584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDnpTRi9f9R1c2iwgUvZUHCtXIHtlkFWDW6j6CqCTEg=;
        b=pqnJ+S/NUk4MeaQyEQ1lbK3c+lwFU7aoDg/eqsLS0jnqBtRWazcnjEHilNkMkYxj1W
         WmATnu88DKLFylOmrBBxO1i0Waj3cimLHLFUdoPii6kCnI0pTC9RSHav4NoUdWm8af1o
         w6wqoHOS+eQ/P9zi+oJV94zwiG863RmvnfKqb4bjxN/HBBoWS1G3+rS9uyAXE7N1TCnC
         3LmqOKO5TKAKzRD4caN7/gE3ciYHFT79v4hN0OIGr8HHrbfLFNDlGcEd8r2spYdiixlQ
         5VheXLxM8NNjtzNUE9la83aFZxGavLjzQXKhlR1GcIVtmY+p7xg37OeHqgyd0pPE79wX
         zkTQ==
X-Gm-Message-State: AOJu0YztCvXss2dWOBE3aB7YZp+2rgH8gyZTmAIPQ6UfGO2isgFNEKI6
	gZaAse986NZNZ/KCvvAgVu91KqJi0L+qroDNH/OQcLm0FKeBxq3xG0sTbpziCarEFDIGDiF2mx1
	5lRCqBueLyRH1NZuyTpV+hZYXjN3n9h0=
X-Gm-Gg: ATEYQzxv57aP0XRJlp6oUCmNDCiHZG9mjAJgNkMKBCfn8UVifXyaK0lat/qJgF5SjUR
	D2zlpYuW1U3g0QEgPWAfoNbzsQA3yiFbJ9HmSvRY7I4mOlrkgVpCM/U6KD9I3Zj1Z2IhoMFBLmt
	e2s05E+5E5glszpWxazHc940AwPhqf+sLfTg770zKTf2aPTnPW6GBUn3W+5mJQg3qRtxpVeVsIg
	CtzARzAuhVvpjdiPlFf2PprW/XVxu0oBAuBugB8red4/EvLs73rCZbUmm2C6LEJU9nA+rh7j4pr
	614auxvT3GOOcrjy3HTGMo0fqVd4w9aafdM6aLKmDrfKJjW03FisHiu39/XC
X-Received: by 2002:a05:600c:1d15:b0:485:3abe:ab86 with SMTP id
 5b1f17b1804b1-48715fc3d1dmr130180005e9.4.1774543784004; Thu, 26 Mar 2026
 09:49:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325-sleepable_tracepoints-v6-0-2b182dacea13@meta.com> <20260325-sleepable_tracepoints-v6-4-2b182dacea13@meta.com>
In-Reply-To: <20260325-sleepable_tracepoints-v6-4-2b182dacea13@meta.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 26 Mar 2026 17:49:07 +0100
X-Gm-Features: AQROBzA30QmO57W599CiYVl-rUD___9cSzFSgp7EgNa_UmrYDKEUiSP0KPSk1pU
Message-ID: <CAP01T77juJW4jZUKt_ded-uyDgqRguw+5y1=x37r4A+=wCTGNA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 4/6] bpf: Verifier support for sleepable
 tracepoint programs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Mar 2026 at 19:55, Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Allow BPF_PROG_TYPE_RAW_TRACEPOINT, BPF_PROG_TYPE_TRACEPOINT, and
> BPF_TRACE_RAW_TP (tp_btf) programs to be sleepable by adding them
> to can_be_sleepable().
>
> For BTF-based raw tracepoints (tp_btf), add a load-time check in
> bpf_check_attach_target() that rejects sleepable programs attaching
> to non-faultable tracepoints with a descriptive error message.
>
> For classic raw tracepoints (raw_tp), add an attach-time check in
> bpf_raw_tp_link_attach() that rejects sleepable programs on
> non-faultable tracepoints. The attach-time check is needed because
> the tracepoint name is not known at load time for classic raw_tp.
>
> The attach-time check for classic tracepoints (tp) in
> __perf_event_set_bpf_prog() was added in the previous patch.
>
> Replace the verbose error message that enumerates allowed program
> types with a generic "Program of this type cannot be sleepable"
> message, since the list of sleepable-capable types keeps growing.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]

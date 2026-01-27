Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB792F5A12
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 23:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769558037; cv=pass; b=CtY1b10C16v84nd7l9F0zlIGcDLPESJAUNvXyjmEVEbRu3aye18EV8nF1JEDBM+DtFn/DdYeHlTHIACp362uvjjTf0xNw1Pc7Iw8QnzDqE1rxvbIPHztAxgvmK2hRGpeFl03Py3Z03k5QdoDM8mkM1crgDoKeCEikZDDn8r8J34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769558037; c=relaxed/simple;
	bh=gQolxqMVHHjTQT8v4gvW/K8k31HxXy37p0cquffi42w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XlcIg+0lGY6r6PoH5cQyKlJ5vdZPcXBBoA3jpvjz7FUr2gYzBnz5g9zBrLslPPiczV04zv1UDKg5ex5V7dPoM2hWctYUJTS+gtBf8vu1n8pbzJn/jDzVLRzWDP3t6/lTqRMKEpMmKH2DQXl+2mGmf4IxZ/Kx1LLJqW8zv0Rx6l8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kY8xyltk; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kY8xyltk"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-43591b55727so5943786f8f.3
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 15:53:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769558034; cv=none;
        d=google.com; s=arc-20240605;
        b=hG0Cw8UQ6zvIiN3MN0i6aakUP3yhMPaAxBXMGbu4qRrH1xmOBiNqiiIg91blAs45o0
         IRNAZDzHvqDW+HotDaCCLm283h5hJ9tiw6D7ZxA5WpFN+dyZSYNsLPosCakijfRA7fLG
         5mMQwxne81dDU4wbQcqJSkuXMTjk861kn+N4gL2gbpEFznSeqOOUx1b4ZzGXRlZe/VdG
         +bXSHSWAZ/g2Y0qL5cV44X+U3skv51TeNAZYG3sf/HUUf6moO89WgUks/E69anYAbupK
         Apo1ykA9IwMcvraUxyhRxkWSwrW6v3oxpUqjUxkwnxJEQyvIq+f3mUXWtMJLBsWi/Av1
         AY/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gI2kZbIH0S2QQYxtE47yNqwWX21DVfbCqSw7iEkLvxs=;
        fh=eWvt/84dv8gmoSBLGziAOnKgz0jBtwgGZiZYG1EQXXA=;
        b=aL4030fOXGphr/rQldnEDR/HHg8r/vdUt1bmfTV6RcYmibyvnuF3LkqZFn6hHC9+m+
         c4/p3cMFKXdQU/bn3autGLMcE27XG6I92imE2dux+U/wtLr1fOdqW0pMqI8Sfgdc3HoN
         ldbe3uFUfA0rIquyxy+zV0fo+g45KuSrfic6fAuXYoKjdHsTjrdJfgzUREcgij9kEt3e
         HdwlanHkg7zap+HIwZovFYFGlYS14hcTDZQxbQQAGZSgZWDGFBQ+k4Da/Y70qaXVtWwk
         cXXoRo1EOzljbeMJU1m8h2iog4jK55piiNw2BCwrPrS+VUTCrZfX5fjOXQWS/NxVIm3W
         MZkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769558034; x=1770162834; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gI2kZbIH0S2QQYxtE47yNqwWX21DVfbCqSw7iEkLvxs=;
        b=kY8xyltkZn3c7T157jwVnhJz4vzlkS2BExJzr8Ni8aaZZ3vaZO747Qmo6fD+spVex7
         BdaeCiT8MZR49PBP3R9kTnUbEPzhemJ2qt4tA/V81XZR/s5shC5gIx3uFi3iPX7OQg4S
         TKtZDaKzK31TI8FYzu9axzsx0C6Xjl7P7qcd5eHEqlEFFm7HPImFx5K3G1YO+W22In7D
         jMjkSZ4g001wMq4D7OL4jPtRXdtkUBqWHEk3A2Gv16wyyv2/kPP1SQFE+mUAvuepYFUF
         N4AQ5yCEykI8qvLrvZyVHi2evORhvaFmlCBPRh1qHNliqGP9nKbQymqUWefNbkNKdBnT
         Zskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769558034; x=1770162834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gI2kZbIH0S2QQYxtE47yNqwWX21DVfbCqSw7iEkLvxs=;
        b=OfIyfvbWbSu8acBtdp9ZFcvrTCSUK3kJGmXcl6sMvj6Wco0oVTcD3NMJjBNzj4u8nC
         DjclFYbVRTnbhjSdcWymthtqkmZoovd/HZ2GTx3nsValwUw0UA2ki6y085CVNY7IVO9x
         eppzpVEgO6x0xaTuSz9Db3tfV1bEi8dC6Dx/fkO78uzjaJzCC1NArhVUnRkFG+cTdWS1
         tiKT0oAy0yx+7utw4FYETzLDStWRozXW8OXSo1b0fNNDZbWq418+AdqNj0Y10UbYWPzl
         pvJc5xhLT7aYfOfWQsbKh/Uu7/2KR6HZa6LTDnJCCxMn9QAkSjlPYuraVvXgn5dfRJML
         Dyjw==
X-Gm-Message-State: AOJu0YyVHvzAXTbVBHouyv63ptShdceWj+bqy0mq2+eRsOED8i19hJ88
	JWrG0nabqG7bgSCgt+YOq2VO2KmEpOHzRMNAKH7J/ylC3P8U7+jwBImjPywFxLCIlRYsRrRIaFy
	fp5oxye5IpGefCJX0f713TfbPBaFNBNE=
X-Gm-Gg: AZuq6aKOvyrTmrX0g+Ycs784oX0+v7XiMoTlze5wTNgv3FBr6eRJ9cSPLw6O2GT7U0N
	VhpdRsvZzUOtstnoDN0zG8Akyva0b9HUY+8S2mTXfinjyHtdQWEjsdvfrrQCq+zbfFg0UhgFIMU
	nomBc2R47/+C7dI1QdHBGhmTuHM+/CiYnUqWQLBolPsxbeZynZoEssXzY2avkhRl0u89GVtDG4U
	e2F4CZ6EizIp3ll4ngwDPMJXMf6CNOC1tLNTiSXIY1E+KRl340B7PIB243fxFVwQ7xM3mN7btXq
	hPMUsDFqVivaVxqhiPRmz0tmt4lj
X-Received: by 2002:a05:6000:2310:b0:435:a21c:f946 with SMTP id
 ffacd0b85a97d-435dd1c401dmr4838964f8f.49.1769558034443; Tue, 27 Jan 2026
 15:53:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127231414.359283-1-emil@etsalapatis.com>
In-Reply-To: <20260127231414.359283-1-emil@etsalapatis.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 28 Jan 2026 00:53:18 +0100
X-Gm-Features: AZwV_Qjvbho7UFyx6XLrrSboqXW6HJnV50h7eFm5N9veXFG52J_aMSvGMsLT_uc
Message-ID: <CAP01T77Bp7T7fq_zyhqFLsnY=791VF2JLyU+zxZchEO5Yq=5cg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Allow void return type for global subprogs
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, martin.lau@kernel.org, 
	song@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Jan 2026 at 00:14, Emil Tsalapatis <emil@etsalapatis.com> wrote:
>
> Global subprogs are currently not allowed to return void. Adjust
> verifier logic to allow global functions with a void return type.
>
> Also adjust existing selftests that were ensuring that global subprogs
> with void return types fail to verify. These tests should now load
> successfully.
>
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---

Looks sane, apart from the renaming nit, could you also incorporate a
test to ensure freplace logic fails when return types for global
functions don't match?
We didn't have global functions with void returns before.

>  [...]

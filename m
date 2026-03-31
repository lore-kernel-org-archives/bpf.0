Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D403C40DFA6
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 00:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774918757; cv=pass; b=JljkL3pDHXJbjHxzn7jdyzQaSr3Ja755fFe3Tg2XzGGFQmV1ZCflwH1hvYD4mMHqbG+Sm3dnpGqGtXBFEhkpm2TVpnrPfDvrPByso4MPdgmJ5oAgfI0JGYO2hojrQJH7h1ooLnAjVzgMZs1Az4lSnGzNLpITtd04pwofYZJ/McQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774918757; c=relaxed/simple;
	bh=8o3RxRm1dnKFXXdTQnq001ks7TiVKBBf9qD/9lLjrlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFgcxRMVrcQXGDgVSAjeLCIf+YKI4U7rify5lCKqrI/BdIxChOK1PhqHX76yCQdr0myL+lW0HXc8YoM8YLqCcrnwoGhcY3joLrP78JICaHm2as6FWyxwd1YaOBtO2pFZ6FxVpsFXSHmfYXXN0hy2Ba2gJ3DBnCCUETTbM5DM+24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPM+UZv1; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPM+UZv1"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-43cfb723698so1317744f8f.3
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 17:59:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774918754; cv=none;
        d=google.com; s=arc-20240605;
        b=lUxqrWguMXFrIRDllD0sifIyoufVMgzVYoWcT1THR7PpB0qwhKBCcmy75pxGgxTWfz
         qaQDJTBYTdAjaBk8ehgJRXozfFXNMkx/3kH9ke93p9tcV+Lq2nt6PXCnMa7XquVdbtc5
         q7CeKHBTL5yuTNc4LUa8g6OCKr1cYrialGJxC+0ukS0O2X7g/DATxUWCDVSweRZ4cPGZ
         BghEdgzVOb5SKqJExRB6pxb7hc6XyDWDF5Zv8VGmyU3ItFkxBHJB9TxZNaec3TVbuoGM
         yn2ED2EGbcObnPwsnq5ka5HXBqFi88Ms+MjKz8Epuov4VXktR5rEfjCL+TriumljOOLV
         GDqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8o3RxRm1dnKFXXdTQnq001ks7TiVKBBf9qD/9lLjrlk=;
        fh=mV8Uwy03aTQpEc71kkKqimIDFbwq2oIhKiU5zAUO9K0=;
        b=P9seMHXaT+5JvEj7gLGZnapaojsB2QT7syXF1KM5CFQCUoLM6bDtCCirXMpYtDXyRl
         Z4+bmjiDePzpteXyv9fg96TSDXA8UcYPN/qzqUm51HgJPqtE5Rajg+hira9Qo3w8ks0q
         fYfU6mIz9p5+j0g1ln3z87qY5VxoMcS0uwXvjLRzrlrDJ9+9vIt3E9eBEj7rLErK7iKM
         dvfDEpeN2aKnVTrM9zSu127rbW0Cj72/svlA81UMZwT5xRHmXTf7mkdtN9GITkkVGsw5
         IpH53zFE9PaVqgW3/TXUto0nxPpCYtF4kestGq64MtB4p17YkHFHy8XSOI8oPsio4mkJ
         +Uog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774918754; x=1775523554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8o3RxRm1dnKFXXdTQnq001ks7TiVKBBf9qD/9lLjrlk=;
        b=GPM+UZv1FH5XRrP0okxKajQqs/CiiSGUQQ8meOmnHta3xpSZKXnTwJd/OJ5tLlm0Ds
         jBk1fWDeVDpFKA2WJMoZ9fPUJm/CbC76jB2hDs6KmyVLBmLn5e2HnKEv3BcCscZ80ajI
         0NbRRm2xW1ZCMdylfUzX0ie7kkW+j/9u088m9efoo7SgdvpvA0tuenWUqPa3VsvzZdpJ
         pg99Lm8VninCupGOGB1RWudO1gsxUexQ1elkz8tQe5DsH6MElHr4vvsPMUjcW3Vmgf1F
         XWXXqEQcLfHSlut5Om3xy/WJNvcD/Sl+C/HhB1EBKNpxRQzrt+AqaDrQ7+T+hupEUNRJ
         l39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774918754; x=1775523554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8o3RxRm1dnKFXXdTQnq001ks7TiVKBBf9qD/9lLjrlk=;
        b=RDmb/oxdVO4ZpsZHcKkG9Idsrdet1Cl+RawOFRkl/ZeSh/LA82IFc4zhgGCXYAf2AD
         xZpePkKXj21iB1YaFtoM5hVub8+Ck3GYHcWT/vQF2R/ged8mHdZtR8zLKgpxGhMx/tj2
         gLgCIiZrcQ941wCsOqUS2BdL187aZfE8v2uLOygtPjfp4ThkaBhVvzR40wSWJMI/SldP
         YuKxDMRIgubU+WCCbY3Yg78ubBtnR1b40cmSXHw/UhpJ5Ld6eq5ppOcgfRK26ruLvqHv
         +2QCBX6taPZ0kkxUD1rD3vfo/1zUGqjycFpzE5CH3phSXxOjNBkPRcUq86OMAU3514lK
         mU9w==
X-Gm-Message-State: AOJu0Yy07yN2kqyGOj+wGZ5yBxieHoeoIR0KdpXmmKnM5EPeIVeGFA5t
	gmo0Ewuya9JJKurBHhRjzhNuhT40v9ByTj9vOdx9V7U6TITpecQuSLE24zGZ9oHOmKoGn0hmhh2
	ieGyrOw7wCkirLTiJI0vVvnq/5V3LyJU=
X-Gm-Gg: ATEYQzx90iJMQT98eciBOZRjxOK8LUlUZ1D7NJHno2HimNzorThjEMyVWJDXo3bviA3
	VpML/Q7PeCnSMj7ehdk2jFVnvunuYKTRzV6yDFtoJsZo+OU2NTftqpO3dn9EbSgOa3MU82/xfNf
	o3Mjj+bx9Uu/coHjY0baOXEb8kMFo13N2fiZ8UNjPAHSusTyZZ4thf8j+SCpWU4cMItroh2o4f+
	Yqf6j/ZUkFiirja9pwhXuxC2QnuMR8q070hfkNv1yMqcNf9fTuTwq/8mXqfhk07RNK6+aMdOLjy
	vpHLuG18fPHH9rgGWyHP2ilnJXH0Aq/KNgNpbJXjnJOrwN6dvYJbtZBDp1vm
X-Received: by 2002:a05:6000:2f85:b0:43c:f66e:f2d with SMTP id
 ffacd0b85a97d-43cf66e113cmr15873614f8f.27.1774918754114; Mon, 30 Mar 2026
 17:59:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330-kmalloc_special-v2-0-c90403f92ff0@meta.com> <20260330-kmalloc_special-v2-2-c90403f92ff0@meta.com>
In-Reply-To: <20260330-kmalloc_special-v2-2-c90403f92ff0@meta.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 31 Mar 2026 02:58:37 +0200
X-Gm-Features: AQROBzClBDIlS_Nf6I1J2QZBFiNRAsdHm80bGZEScP6NNG_LNbXl8UAMapHOojw
Message-ID: <CAP01T74oVmU4H0xBS=Su-Xo-b8hkx6gHg2k-aF5Unx+pNjLkRA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf: Migrate dynptr file to kmalloc_nolock
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 31 Mar 2026 at 00:28, Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Replace bpf_mem_alloc/bpf_mem_free with kmalloc_nolock/kfree_nolock for
> bpf_dynptr_file_impl, continuing the migration away from bpf_mem_alloc
> now that kmalloc can be used from NMI context.
>
> freader_cleanup() runs before kfree_nolock() while the dynptr still
> holds exclusive access, so plain kfree_nolock() is safe =E2=80=94 no conc=
urrent
> readers can access the object.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]

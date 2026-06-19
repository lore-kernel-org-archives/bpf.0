Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7454240D583
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 00:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781829038; cv=none; b=rHyJ/wm7YGIN8i/8jcLIlAaqbkunG7zz3y72r3BHr4m4f/lzDSXofRBDkWY7GKu00SDthrOsMxLuVLAs9EtEhHWC7odSvYbFPqNXPKJ4MO7po4P8HnRXYC87Pfqv5wD/1PJVc2tzlmfqMdT5RErxzHZCYWf7Y2PKvlym6RRNyj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781829038; c=relaxed/simple;
	bh=hvbIk5SojXr+ZJBfDkpyXUPKEQomDt0eXG4CXMpDO+c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=We87HRSiM3Dhx/pYckgHGc05UENeZq6dJKgXJhtj8jwPV8GZ9iP1/IRpk0i5XRbq4EJxs2QmRWNav4O//WJ0SQAT8uxiMXgD0rvWpnvOcTfOHmjYRkpFnpQPSscNd/y3GEEU0wfAAGOGp+o4FTn44kwY5KFXvBPEc3w40BZcGwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEleJeHi; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEleJeHi"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-30bc806fcf8so1862171eec.1
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 17:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781829037; x=1782433837; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hvbIk5SojXr+ZJBfDkpyXUPKEQomDt0eXG4CXMpDO+c=;
        b=kEleJeHiSnXW3n/o7zycSzSEPxLNn2fRmCv1YVtepm4hVc/nFeocFbfspgZPpGThNd
         09JwIZeVP5uVSUY0aIK2wqbu2KZvrKY2VwTTKZ3YdSYTnV4gh7ionamGHQfQmZ+twk1v
         TzmAXv7SYWzeOBl6dX8MEjScv3Eucq27SRrdY6izo9dnWjwkY3O5acDyOv2c0Pa+Ud62
         v82qPfWgDcLDfLnunkBJEFvbGqWrarBQ3ycelXBRBEyiu/b01Ussf095zlHP04ddfsea
         nsw255NTTT22V6YyKcFySSAEuL/uw35Ekecv6wSilVmsVgT8TgkW4a0jsXUcy1CFz1Lg
         3XHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781829037; x=1782433837;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hvbIk5SojXr+ZJBfDkpyXUPKEQomDt0eXG4CXMpDO+c=;
        b=nEuOx1xIh7fBOiNceRcZgLSZCUAlkMqwp5+ZipEz8EuBJbKYAT+FK7miuK5bSXBgy/
         8meSEpXYXFaeUgt/72SjJB5f2YnISaemokd/Xe7fohUm3moK8Y3CLkOgV7GagL4NfVGZ
         UHX//FdsPmkiRP1MU+x3/pLHY6UOFxwZv4pIwL2NYuaBv8AonxaIdULGF/LyO8InLtPx
         Er1AsyKsMSENif8E6/pfjfdtDwT/gK9ek1eDl3MaWB1cNlRaYJ+HObcmzER3zAWWYsG9
         PmBeXlLfQXWWJdVa4JS96ERHZdH42f5S2Ngn6r4Xt93VwKsGfPHQUtKBYidt9aWYBbqj
         brVw==
X-Forwarded-Encrypted: i=1; AFNElJ/DoUWGIrKi3suByBTotmmzbxWYb+NBv6nGPvxqxYVu5gRpHGOUJQP9JrhaxRWsz9EUACs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvsEYKSc4dsyG7hHy4dxXmPKweZj5o9XC80F2Tx5xPvTltu6yE
	/Rh5joqn0KZjq981WXI+EzWlGiJ/TAGgPTVLzlwFzrnFAGlkxAgo1jwF
X-Gm-Gg: AfdE7cmZnEm3WQKC+jW+V9k7T0LdEEtUhOaEOJdJZU1m0KIezhRW0CbfoBu51Ywv7c+
	KaYwk0JPdWcjAmeBiyZhHHac/RhHdAYmHrMuN9Fkc2kAahrs7h0qhMXCTy9A8Z5xcuY8EGyHSdz
	7bIZqMZcGiTjdokZ0XbVBVaWY1s48QjO4xT67LnxmtKMmBFOWJ4LN8AFhJfCndKwXrS8l/9fWZA
	wvpOLBIkQVk9RO2sw2KLR5Z4WEym2/mmOnlYz/gKiQoTX0lFV8Tzr6SRm91/zq8lNBpf6ipiFiE
	07+j90kjv0MuTcJCjKTBnQJiF+aHDw1eaBVAfnaihQ3uIb+/aeB4c6KcHuZkwVcJzfMYmKVpllD
	+WUBFDqIrjLbkXd2o6+un243u2N15WQBqKYYaMQ9iCeEN4cWfeod18o4PpiWHmBCt79Uy6uEIFo
	OCcex6Xt02UlU+x82pZNXuoZ3sN8gsbzWONKboR0NdY6Ul/IKr+38/XvzVBkPWZ+X4FC7H
X-Received: by 2002:a05:693c:20d2:10b0:30c:2d7:cabd with SMTP id 5a478bee46e88-30c0cff3b63mr84557eec.9.1781829036416;
        Thu, 18 Jun 2026 17:30:36 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:ae6d:cb3e:a1c:6cba? ([2620:10d:c090:500::3:8ac8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c066cc0bdsm1022817eec.5.2026.06.18.17.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 17:30:36 -0700 (PDT)
Message-ID: <ec06d9d008496090a3b67cea357bafb3b516fb77.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/4] tools/bpf: Sync btf_ids.h to tools
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
 linux-kbuild@vger.kernel.org
Date: Thu, 18 Jun 2026 17:30:34 -0700
In-Reply-To: <20260617210619.1562858-2-ihor.solodrai@linux.dev>
References: <20260617210619.1562858-1-ihor.solodrai@linux.dev>
	 <20260617210619.1562858-2-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-06-17 at 14:06 -0700, Ihor Solodrai wrote:
> Sync tools/include/linux/btf_ids.h with include/linux/btf_ids.h so
> tools-side code can use BTF_ID_FLAGS(), BTF_SET8_START(), and
> BTF_KFUNCS_START().
>=20
> Keep the tools copy's existing compiler header dependency:
> tools/include/linux/compiler.h already provides __maybe_unused and
> tools/include/linux/compiler_attributes.h does not exist.
>=20
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

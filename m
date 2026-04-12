Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF0A41C71
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 23:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776035480; cv=pass; b=KIKvZ55V1Z/sgGZsgjJCmcXR6LpT5Aui0brRBsZ7MM8UpSG18jr5vYVSZ9IhgMaACEldiCUQzYp/QAJnFf80Ty729bG7pKCUj3vXzpEpjH3u2iRcG0Gw4trF6gkpkJygzdtexGfX4Bsz7DO20wY6iuBZVlDrpIMGqS6N68g27Xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776035480; c=relaxed/simple;
	bh=O4Dye5EdmVWUfaWu1QkxhooxF/wW3FIPyLpCd+SkSSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OaouZr2RVhVYsXldhGptSmibon6iIZ2hn0/sMBpVDSpUm5hR3rSIvozssJYlszbT4nv+ETVeNgW4s5A9gGFYu+GznyZOmgPZugbIznzBuB1HE4rHdK9DAtsNjngzakkRB8Ojm2/MfPqyD7ixhVFf0ebOnvebaw1O+3ehVHjAntw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vs9MKPb2; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vs9MKPb2"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d7213b6ebso524568f8f.3
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 16:11:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776035478; cv=none;
        d=google.com; s=arc-20240605;
        b=EvPEszMCQ/C/rlgMUfpcS6TTHjYoAhj0jk1aSjhAnBj6Bu1v8UvJNioMtYYkHyeExu
         u6TKTqbO6MH5QTENM9qsGloxyLWsMKwGN36zbBYppGPlbi31kSHIuYqUNpBKoLUzj8xW
         nyvzhrJAExOEjxckktNuMGh4lWNzGSZLdGSrHgO+zD3R4ZEL2cm2q4wr5G26ayeYP+oc
         Chkjg2kQQkBGnjhhNE63NX389in8hsGaZvHS67k/nV8tFVfNN6oSzTI7E92R8F2bDb6T
         aNagQY8LcRJu9iVOi3MtuaE9txLDMGmBwGzD3VEbJJdll63IzfatVYAXL0W6iVOGbtsb
         rk/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O4Dye5EdmVWUfaWu1QkxhooxF/wW3FIPyLpCd+SkSSQ=;
        fh=AoyNRaktsZ7bW/hTwiP8Dm5frmwh/+vEg7lx+EPGuMM=;
        b=WhIP8j5v22rexoP4hFX1l8DiK75RVjitVT6GFSd0mcmDRFcKlPq+9KoSjzT/t9Tm9S
         bT1bwYRLf+qyJnUl8/Xuj/UZWC4gkUUUsDsS7GRaL4YEWtDALCy86qH+XAT/n3JMEGsJ
         zFYg1HGNgPq45acgO7Yo6p3BIvu3CQbPtvUlAIs2t+1b/3QA8up/yZpSs1tQ9eRC+6hM
         I/cs3n+bv0/g8Z8nGc3qyg8rSjVHXF+AZ7tLcM2WCQFeYcEwKpaprBMbW0MmUWuzqKSb
         R5FcbirIubv0g4FTIfkjmhm0Au35QTT6k5mxFWWQ4M+P6WoJOr/yz0UKeYLX8HBTSO9N
         r9+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776035478; x=1776640278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4Dye5EdmVWUfaWu1QkxhooxF/wW3FIPyLpCd+SkSSQ=;
        b=Vs9MKPb2iCmRsdMYddO6CVCFYiZsNGeFpViJnTYjrovrwHAFSqOYlFrp7kbATjTxKf
         6fFLtzwAojioueCX8EuYcl1wg0LboLiDYQzYeb3Gsh2iiHq9JlORdRhBkdF1QId1Fmb0
         5G4T28cNJbIk+C+YMnLmYPnMl8wqGjI3u9gKk1gkJAFJJSFcql7E4ugHTB0tK15K/MUg
         Xy4NbkmHtJn0KO9cjDhcMJt0FbqpuYtqWIvxR16hJY5x6iy4SH6erdpjLVuuJBl5dPSo
         dvsVpvPmIWGD2jCp090NWO2aggyw7UDNtmc3/Q31bOanbtds0s+YttHQ/7Ukh4M4IcSo
         J8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776035478; x=1776640278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O4Dye5EdmVWUfaWu1QkxhooxF/wW3FIPyLpCd+SkSSQ=;
        b=NmQYnfudyIeW8F2gTwdfPQEWlkkxG7oXCzSvCWi9ZxYnZuOoc2gwEnJfqQI4YSH/6x
         hS8shAAkPP4ve5Diu1UMof0BNfJzs9bj4+NdyYxlHSnsOxq1wHRxQVbQ3DeG++oJu3BD
         uHykwULkbTbFVgBoliuNAXdCpWbMnPv1fawdjKjnEbG6B8vgdgIu4jBBLFr5smMTuevX
         1EuTNFz4LCd6WYyEhlbkuAdm24rZG/0ELXrrUP/ZKATUDNjsUeRHc3nce9EGmLpE4pSh
         gLYs/uYp0W3xkJ8HKuN+Ozj1A42MV+KHG4QxcgxdaaU5a4xMOrljp3knAUD1RXIwlLD4
         Uapg==
X-Gm-Message-State: AOJu0Yze0+FnT68dExy6eiOAl2q5up4i0ZLMPOdqTDa/1e+UowafjkeQ
	M/g8WtJAaO4RqS4FScwSfYbOftz8k/RK7OVtMEaFP20BzKbjdtBpUOzTWbUb4fCY7W0N14Iv4T7
	jZeyoRlwCPQqpB2kCjtXchUCq2bZkU9Q=
X-Gm-Gg: AeBDiesIhIkgsv8JF7CSVJNJhiXRVVNNAPIOygE4eOaHqLhHS0B619hawbOXXKQp2YH
	/RSTx2iCKRq/UAq1H30dj8usBsgzEzSfhs5t81mJFO3En/Z+0rm72CHDtsWB62DR44VU6L1eL9t
	zWz4oX5BLzvo2DoclQoMg22WPc3ESDb2HCu6UwoZQ1ybs787cOqqU/MSlxJG8PzUIQbUiz8dEKL
	5tQkdJwZaKfXWWzKjdeUi63vWvqhAZketm7RWvKMTt91Cq4SOh/oTXLOxXsOipM1xEGfjs3siCE
	2RnT7islM2+65Nu/m9PEO54QStQawjCDWQ7nKzh4RbihZ0vzjsqHMk0WHBSvU3lo26mCrVe+HoH
	iFlNamxynhQiyHrUfTczKzG2HOw==
X-Received: by 2002:a5d:6acb:0:b0:43d:71f4:7ed4 with SMTP id
 ffacd0b85a97d-43d71f48099mr3895019f8f.15.1776035477674; Sun, 12 Apr 2026
 16:11:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 12 Apr 2026 16:11:05 -0700
X-Gm-Features: AQROBzBbLUqwna6pjp5Aw-JgkyvLV8fmRFhs-ukDZtD0BILYJ_WmFJj2F9nmT_M
Message-ID: <CAADnVQ+nBB9a-5fR=b1Ty-N=LUnc1gmEZ_R2z8mSNZzaZC23pQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 00/18] bpf: Introduce resizable hash map
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 8:10=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> Benchmarks and s390 tests depend on the
> https://lore.kernel.org/linux-crypto/20260224192954.819444-1-mykyta.yatse=
nko5@gmail.com/

Is it going into this merge window?

Please include all perf numbers right in the cover letter.

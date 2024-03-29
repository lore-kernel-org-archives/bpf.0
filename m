Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D28B241E7
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 23:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711756068; cv=none; b=W1VL8ipAtG81gvwecQQyOMC2/nTwp8SX8DDyYckEsb4pzDfunRgEtSXjsUw+BRR6dOPxOmSRtb05Db3QTVBslxs26LawEfUGNE4+PnXUTf6lF5ydr3r43udyeDc3mEk5cF8SaIe4v8SvssRUOF7o4Lez4wC/aWMLjirvMMTyl2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711756068; c=relaxed/simple;
	bh=XeEZzKAx9o56jkJGJFAHZP83CbmtdeH5+DMqzaEoWtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xs06N0H7snKw1sLfA4xNTV6PLBseYYKs47lhvJqRHDnMF1w+GNkfgcBzVf7lWYCQJDFUrd+1Y8sD48xhRYZ53LZA03Bu/VnP2xNkmUuYYmi/9vRJdwhcjanOlnXLy9uyiqAIhFfdsyodiqJdrcTgJ0VYxwBwkL8raHz+TaL6BDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiucC5sP; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiucC5sP"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-34175878e30so1791330f8f.3
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 16:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711756065; x=1712360865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeEZzKAx9o56jkJGJFAHZP83CbmtdeH5+DMqzaEoWtU=;
        b=QiucC5sPTgnuGfSXo6WJV50F3961dRp0SZBL1Uh4lWyhz0wkxhYEiwDWUpe1U0sQ7F
         t1dIXLNMxWPAs7nnHovsCxsQBfxJjsbONgRZ2k4+bdOMA0K4wXvvWEooM37aqZrmYbyX
         701qne4eznv+8w6myNFz0Q0XbNWopA2aDNZ24QrbsTAVJAZV02yPlQkJ8t8Gta9eiH4U
         WCtmoJD/3k6lqbhm33KVC7LJm9V52vT+RnTL656egQZj8GyJdK1S8zBU2MUYXlIXroE6
         Ihu4m3zBI62fI129W0ZThhbW3wcSDGOScm7aFY7FZNEjrtFGpZj7FaVSGh6mYHw7BFek
         Gskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711756065; x=1712360865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XeEZzKAx9o56jkJGJFAHZP83CbmtdeH5+DMqzaEoWtU=;
        b=NjA6yYqOgjb2pHjaXcKUxILGNoFAn6t9zNevVq3YC6QExETfrDb2dO9E1/igHwxjx6
         JsBmWMo7S++SlTLzfKIlzEmugghMyz7LI2jMe8n6gaE9nUtGdMySLGADvHyrhnRj8bvx
         t9chFwbZoXXZIAVSmHvDDB8fmFmL6RiHXLv/hVCQLnaBfYCVOXlyzGccd5RhYzwznS6Z
         Hx7wGedRxHP6HL9mHa9WBLXb0wzxAW7xU/9nH+1BCnkYaekeqnyPww+ByL6HgENmiJ0f
         KNWJ9V/9XXRuCN1Afww84cTVK+SUtnt9QYrg6szowBkXuCZ2QDqodQeGkAXMsVtUaFPy
         qWpw==
X-Gm-Message-State: AOJu0YxBDIFIOhSL+RpjYfQV7U9tEON8yF3xnwgxVK7QYukI5iZto2g+
	fcXfYI76N4kpkTWu2Xwzt7fmlzY7ww06KTmA/disesZsz6fgM8EIo6szlrWTIkcDf/eNnKTNu9m
	8jUJ7atwHiYFX5XDmCZf4K4K9YKU=
X-Google-Smtp-Source: AGHT+IHWHopHb5S19meupMipT1ITlHqRqtIyY8jXbP/CUfcp0AhY63gEMtBSIlUoAgwpsidEhO5lYRikHF0rHYx1cwM=
X-Received: by 2002:a5d:6882:0:b0:343:39a6:60f1 with SMTP id
 h2-20020a5d6882000000b0034339a660f1mr2200050wru.62.1711756065558; Fri, 29 Mar
 2024 16:47:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329184740.4084786-1-andrii@kernel.org>
In-Reply-To: <20240329184740.4084786-1-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 29 Mar 2024 16:47:34 -0700
Message-ID: <CAADnVQ+Df6dG1JibNrJbwT8VM5aVXJO8D=4_Bh1SK_WxYbYDkQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] Add internal-only BPF per-CPU instructions
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 11:47=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org=
> wrote:
>
> Add two new BPF instructions for dealing with per-CPU memory.
>
> One, BPF_LDX | BPF_ADDR_PERCPU | BPF_DW (where BPF_ADD_PERCPU is unused
> 0xe0 opcode),

ADD or ADDR ?

> I also added BPF_LDX | BPF_MEM_PERCPU | BPF_{B,H,W,DW} (BPF_MEM_PERCPU us=
ing
> another unused 0xc0 opcode), which can be considered an optimization
> instruction, which allows to *read* per-CPU data up to 8 bytes in one
> instruction, without having to first resolve the address and then
> dereferencing the memory. This one is used in inlining of
> bpf_get_smp_processor_id(), but it would be fine to implement the latter =
with
> BPF_ADD_PERCPU, followed by normal BPF_LDX | BPF_MEM, so I'm fine droppin=
g

ADD or ADDR ?
Looking at the rest is probably ADDR.

Feels weird for BPF_LDX to mean dst =3D src + percpu_off.
Should it be on BPF_ALU64 side? Like a flavor of BPF_MOV ?
We have several of such flavors:
off =3D 1 -> arena
off =3D 8, 16, 32 - swaps
off =3D 2 - might be nop_of_goto

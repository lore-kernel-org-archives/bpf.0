Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEFC4322ED
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785170914; cv=none; b=sgBePCWLLIodEj353MRPlMomm0RcD0WYMsCT00F2vFNN1BZqoAVc5WN8zI0es1xSzxakY9tuVNGytbyHVC1WKweCglH7YeV22OERiGCOf0ZDG9XCdxSLCOd6kUDSI/0x5kqiQsM3sJGoXbhnZPIkM69x1oHlYcX3saqIZ+CSLwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785170914; c=relaxed/simple;
	bh=7lrb+OAi9DCKhJw3ePJB8KSiQ9YAEEE7agkCBYXZSxY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CN0gDLEs8e3QiAipV8E/E23zUYj3gBH43mWbEC9G+EUzl6FXHtz9WUdaZp7VQg7z7w1lwa2rSuDWyEp2FsQ6LSgBQ3sROlpMVj5YQJ25cAvaP9HqS+73F7AQpNn0f9UBSJwvgDG2OwCtS2XElI6JEsIqX9uweUxrbTwHnUxXNTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QueN13Ey; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QueN13Ey"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cacb8416a1so27832635ad.1
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 09:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785170913; x=1785775713; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=og3JNtsWQTBkplpaeC1hHpUPch0hDd3Y/HxzvHrm9OY=;
        b=QueN13Eyxis8apsnyuFqekWf7vI4LYnviY8XIksMIaid7nJ0TDVGE0O834FqMmmm6C
         YFnttDpCY9U/Nc4kRTcKm8b/0GcJXeXw8oc05DZTkA+GIpRHL6sdFRTqbPaw2k6fiwOg
         hNmYsS4f48zQJYDq+YpYVTylcAyPaw/wmdR0u6gW7LFCdvHyi5BFw6HzJ5sq8kS1EfIL
         gZeoncirYTxwO6UkhPgFxED8ddKg5GnSpmWHsKEN0iaEyC68rBzos1ha2D/i3Q+ksIgc
         OnHvnE+VBoV9blSADmwtb/L4g/WEGgRehG+/xsZJdDAQnihEobdCaO3xgi5XcHHx9odp
         znXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785170913; x=1785775713;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=og3JNtsWQTBkplpaeC1hHpUPch0hDd3Y/HxzvHrm9OY=;
        b=MLAOXDI+4E75aW93HPrI9BCY7QDkBXuGneUW5evz2KEuRFFkA5uxUa9P1r+EltbFdt
         f/k5iP/w1r3FB2aLAfoOCc0lz4UcV+xHtF7y/ExDi0jwv6Xl6ntH/EQXmnSQ8HzjwnHN
         +lL9yJxmxXNFYoyjrT21QLfrQ2KY3VYr6BE7slYMEcILycdOsyKChvYCaX4LGz1Kz36d
         2MDFafzpeL5wUlnxGzmSufgiiqT73Pu3y2J7u24Bqp9nYvCdHMyWQncgI+zgSsUNHowb
         JU+Jx+FFnUYsn9kyQujSte/9JDINV3Oh2U8sJ2GVYygWw5fINA3QY31riy1bplXeWERu
         ig9g==
X-Forwarded-Encrypted: i=1; AHgh+RptBHehmExI2Ht/HOTStRzSOXG9osHA1WH5s6jgBqmRJbVZ6yRiIAeniyoh2puaEUMJ/3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym7bxnDH7TVjZHNMNipaFKQOx7HH0AD09wRnliGmIjIMbRku7z
	fYof3to8LXFtpyBNOZxFpDaJTL6h9XmhvJNwTxnQKCLdsAlXTp/OD7I0
X-Gm-Gg: AR+sD112RTH5b+PRZgHfFERbQSspfBT8H7AOIUml8UfNHWEbOihF/fXuvFWKpNFfcGT
	v+2Es8GURQf34jVnsgIAHPsYBWW6lN0/L3UFh8jxDeuQfKD/QpwTsh4wGnA2MVl2uNiHOXkk1+C
	euZX9aO9RurPpI1ekgD6v4H9BA+AaYOkUn60tG8IY3yijlgBMAr9vrjFxQMOTllXt6Ny+8TOtfE
	qWvZaHiyXphtHWdOqADd1auGkw2DZrXWGnQWac7RZCjVMIBgycnwzkqC0seTBalpA9iM3CQCCH4
	b+6mQ6Ken9Mi62ceUMaH/XvjtmQXiNg5mflvlxQnLod8lJOhR/JefyRVQfSnpXEkfhLP1WgULvv
	mioxZnQIPWNsNcFW9K4yNI5p2GPOwMvvGvhxz0eKo1VAlF2MsAjlPfqCd8qXUk0EjzgLhA0jVyV
	BHaJe4pidjYpez9vDzzQCH/EgZAxGEH7RzlpMbGi7+
X-Received: by 2002:a17:902:cec4:b0:2bf:27b2:4b80 with SMTP id d9443c01a7336-2cfde797787mr92001515ad.14.1785170912564;
        Mon, 27 Jul 2026 09:48:32 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde59bb13sm38799105ad.1.2026.07.27.09.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 09:48:32 -0700 (PDT)
Message-ID: <ea6041eda0af3980637490f08c97be2539f1ed33.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 03/18] bpf: Split kfunc map argument into
 __const_map and __map
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, kernel-team@meta.com
Date: Mon, 27 Jul 2026 09:48:28 -0700
In-Reply-To: <015164cfd5ac0c3bae007313c3859fef6a583233.camel@gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
		 <20260724190813.1458271-4-ameryhung@gmail.com>
	 <015164cfd5ac0c3bae007313c3859fef6a583233.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-07-24 at 12:07 -0700, Amery Hung wrote:
> Kfuncs used a single '__map' suffix (KF_ARG_PTR_TO_MAP) for two different
> things: a verifier-known map matched by map_uid against a bound
> timer/wq/task_work object (bpf_wq_init, bpf_task_work_schedule*), and an
> opaque 'struct bpf_map *' used only at runtime (bpf_arena_*), which may b=
e a
> map fd or a PTR_TO_BTF_ID struct bpf_map (e.g. a bpf_map iterator's ctx->=
map).
>=20
> That combined path only accepted the btf map form due to type confusion. =
The
> 'if (!reg->map_ptr)' check reads reg->map_ptr, which aliases reg->btf in =
the
> bpf_reg_state union. A PTR_TO_BTF_ID register always has a non-NULL reg->=
btf,
> so the guard silently passed and validation fell through to
> process_kf_arg_ptr_to_btf_id(). It also recorded PTR_TO_BTF_ID info in
> meta->map, which would be meaningless.

What a bug, I wonder if we have more places like that.
In LLVM code base they use the following pattern:

  class foo {
    int tag;
    union {
      struct bar_info { ... } bar;
      struct buz_info { ... } buz;
    };
  };

  struct bar_info *get_bar(class foo *f) {
    if (f->tag !=3D BAR)
      fatal_error(); // the error is compiled away in release builds
    return &f->bar;
  }

And similar pattern with checks in getter for just mutually exclusive
fields. I wonder if we should adopt the same approach.

> Split the annotation to avoid such type confusion and to align with
> helper:
>=20
> - '__const_map' -> KF_ARG_CONST_MAP_PTR: verifier-known map, handled by
> =C2=A0 process_map_ptr_arg() like helper ARG_CONST_MAP_PTR.
>=20
> - '__map' -> KF_ARG_PTR_TO_BTF_ID: opaque struct bpf_map, validated by
> =C2=A0 process_kf_arg_ptr_to_btf_id(). A map fd still matches via
> =C2=A0 reg2btf_ids[CONST_PTR_TO_MAP], so bpf_arena_alloc_pages(&map) keep=
s
> =C2=A0 working.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

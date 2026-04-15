Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16522279DC2
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 02:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776219557; cv=none; b=ETK38zLfbvRa6+R7/LBoOlTM+zrw2+7e95OKly8/P5lOlaqxh7lcJoYJRovDY82XcmnhDxLJQYoW2wjMFzSuBuwP0Nrey4fGFKoTzocoWLLCz4nIXarUfC2vwH64V36isFrYkJy7rY4fuAvGxrSU79lj7qUi5WgKAcUWPUqGfhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776219557; c=relaxed/simple;
	bh=XeQ87EHe33pOaGkgnC608dHJhKevu/fcMFPkjsj636c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCfyjkkSeGB27UUwbNyUXZ27G6GqAMlM0zUI51U1KKfuv6qdRGfyIVncN2qjbPcDuMxwRqdcYup9bWx9ulVA0LvWVqmqFArb93qVlPT39uyIpdTqOx99d8ItobcTdYipG8pc+s0kPwqPGkco/uPnBEfghaMT1mQHldkSj013Pm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BfeEVRO7; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfeEVRO7"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c6e2355739dso2807817a12.2
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 19:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776219555; x=1776824355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q5kLQANDOtR90mQxqxGfcuXQkA+pFzc45ACzvp0Jj5o=;
        b=BfeEVRO7tlqcU5amf7KulvCt3YuPePkgFtVjAqUKbINc5rOKe49Rf4nn3aO54jTw0s
         nXXs5i1V8rbcrjb6kfahq2ubxZFX1zFpSny73bxy8jpVEiVKDYVyk76DnnrUEaeD9/XD
         Ya4TbuhuZlMZsxLDVy7mLKFXrdjDqEvF0wuqXgv8WGiIP1JgEMODnSKZRm5RiR3kZb2C
         VklrkvNkm/+ESZI0SK0G/9gKGIBATLu+Uo99sl6KdVHC1HVX2pEXszFDhHz8klODUupi
         CWzmxLFozqiNwCYP5zfJfRhHB8bFdKgYLFePtV6do/rtuve70Egv2iiSLh2kfPXwIry1
         P6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776219555; x=1776824355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q5kLQANDOtR90mQxqxGfcuXQkA+pFzc45ACzvp0Jj5o=;
        b=O042ncvBOAN4bZ42Fzxmv9LHxSz8R7Vk/i9yJACz7LmgCUl9z4u7MuP++QAccqyzr5
         gvujuLSHOem7XyYcHfJci1ZY/9U0RI96K1wUNQeQELq481yywtbkf9b+pzyrID6rXQ45
         lm4URKVQYY+Lq1UFXDNWquB3itPzBmUqketb4VRZRmQs8UAtgKSLWRBwCz9bmKAmpJZF
         DghjBeJ5q8CqJwt6zPw4izI0jzv6NpljRKcJCRmg4PyA0bCEKGpO7j0IODNP6jo4TECH
         52mDBFDPLU7iaUKT58tTL1IXu3eZeCRxs4Npxbl3cV9qH9lrFywPddOwuntuznxu+VhL
         WTPA==
X-Forwarded-Encrypted: i=1; AFNElJ9c8vjc0zWGA40uzUzSSwc0OyT6Ya8DMbC3ON/DszVtuwAYvA8jC0s9H68olarrKJyNZVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVGl5fhRpmBrmJSZWvBuBXrVV9T5UBI/gbYZIfKxHGVRvVMP/I
	iVVkHFeu3iJXTY3C97QHACyfpyU12gOoyGwUD6BIscQrDGREMD06ti2k
X-Gm-Gg: AeBDiev9lGrjv9HcOcg0hADhNffd4HgO9ENtHsMHnbLxv/syWa8Hzy8oQENwwkTFNFr
	MvWKUXG/BpyPlYmlsvZfpK6yvcjQs4XW0VU9Q8Ue0hNNy9qYQdOj/vORar4P1PF7k3ip7InY83a
	fxOgLt7G+I95FSG26sSI23jEknjO5hGHsrk0uAuDpSvQM+BLUV1okV4X3FpOCZFTa8i2sTa80Yk
	bt53KHsGL2/kEKX25phTchgbORuEQawHqnzmv9incBMQu2LCNw4eoCqyOXn78FNbgUAGwlo61p6
	9JGF8OrsBwhEUDBr8pTds/Yl5an3Qj71LeSPiz4obPQ7fkqqi2QY/VjeieWSPj2lUOmvNNWnidR
	l8dJBnEcDDKkOB5TAZe4AyneM2Rup8mZeXAtSAuShDrrI790x0f/U00ScdZXNH+++Yc16i7HeRz
	4n8rNtLQf+/K1JMQv31sLLY4Vo2bh4l54Z3zjRSn9nsNsR0N23Sa51v2ySmbTrQ+Zsz86OO+bZ2
	CncpGGKs0l+niBi+6bUWxcm8cKyaG7UnNZ+z/QtH74PMHpB5US+hyVGSRKxVT/bUiVFhqs=
X-Received: by 2002:a05:6a20:8d07:b0:398:840d:39aa with SMTP id adf61e73a8af0-39fe3f3f127mr15144921637.29.1776219555338;
        Tue, 14 Apr 2026 19:19:15 -0700 (PDT)
Received: from MacBook-Pro-49.local ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7957eec605sm201964a12.8.2026.04.14.19.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 19:19:14 -0700 (PDT)
Date: Tue, 14 Apr 2026 19:19:13 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, yonghong.song@linux.dev, song@kernel.org, 
	eddyz87@gmail.com, qmo@kernel.org, dxu@dxuuu.xyz, kernel-patches-bot@fb.com, 
	martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v4 2/8] bpf: Introduce global percpu data
Message-ID: <yujp3deu4uko2xkr4dghofpvhrni6szmd7wlozehtzndvhasrl@f2xjf4egi5fd>
References: <20260414132421.63409-3-leon.hwang@linux.dev>
 <72dbcacc4cf2e76dc9de3c045e2fe1f3454d8880197b0db92c7d994ca82dcab0@mail.kernel.org>
 <fef2c9a0-c609-49f4-a165-890aaecfbfd8@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fef2c9a0-c609-49f4-a165-890aaecfbfd8@linux.dev>

On Tue, Apr 14, 2026 at 10:19:22PM +0800, Leon Hwang wrote:
> On 2026/4/14 22:10, bot+bpf-ci@kernel.org wrote:
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index 1757c5720503..8ec24d63a2c4 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -6362,7 +6362,8 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
> >>  			if (tnum_is_const(reg->var_off) &&
> >>  			    bpf_map_is_rdonly(map) &&
> >>  			    map->ops->map_direct_value_addr &&
> >> -			    map->map_type != BPF_MAP_TYPE_INSN_ARRAY) {
> >> +			    map->map_type != BPF_MAP_TYPE_INSN_ARRAY &&
> >> +			    map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY) {
> > 
> > This correctly prevents constant folding of percpu array values in
> > check_mem_access().  However, should the same exclusion also be
> > added to const_reg_xfer() in kernel/bpf/const_fold.c?
> > 
> > That function has a parallel constant folding path via
> > bpf_map_direct_read() that only excludes BPF_MAP_TYPE_INSN_ARRAY:
> > 
> > kernel/bpf/const_fold.c:const_reg_xfer() {
> >     ...
> >     case BPF_LDX:
> >         ...
> >         if (!bpf_map_is_rdonly(map) ||
> >             !map->ops->map_direct_value_addr ||
> >             map->map_type == BPF_MAP_TYPE_INSN_ARRAY ||
> >             off < 0 || off + size > map->value_size ||
> >             bpf_map_direct_read(map, off, size, &val, is_ldsx)) {
> >                 *dst = unknown;
> >                 break;
> >         }
> >     ...
> > }
> > 
> > Since percpu_array_map_ops now has map_direct_value_addr set,
> > bpf_map_direct_read() would dereference the raw percpu base pointer
> > directly, rather than the actual per-cpu address.  For a frozen
> > read-only percpu array, the constant-folded value could differ from
> > what the program reads at runtime after the BPF_MOV64_PERCPU_REG
> > fixup converts the address to the correct per-cpu copy.
> > 
> > In the v3 series, bpf_map_direct_read() itself had a guard
> > (map->map_type != BPF_MAP_TYPE_ARRAY), which protected all callers.
> > The v4 moved this to caller-side checks but appears to have missed
> > const_reg_xfer().
> > 
> > 
> Correct.
> 
> Will add a guard in bpf_map_direct_read() in the next revision:
> 
> 	if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
> 		return -EINVAL;

hold on.
 			    map->ops->map_direct_value_addr &&
-			    map->map_type != BPF_MAP_TYPE_INSN_ARRAY) {
+			    map->map_type != BPF_MAP_TYPE_INSN_ARRAY &&
+			    map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY) {

map_direct_value_addr() is set, but then immediately disallowed ?
Where else it's used?

Even if value_addr is working, then map_direct_value_meta() looks broken.


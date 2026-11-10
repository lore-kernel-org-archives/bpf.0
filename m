Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318540;
	b=1Wbw4LBy8DkGEP4DIiwM+BSZ1kV6ODkT5Y8pUelubByIzxx8xoJ4H2gmPrPs1XluQgAx
	 AT0GPiddmoL/qLm4yLwNdsGN1ojG4joI/r5g2znShyAuCIYHFGLgWROcfqVXrniB1xo6V
	 xaD8LEg55326asqp+ND+AHgF+7+OpBtxEfdum91Ng4Wzvu4UfuvG+3EGJrr235d9fdWNe
	 NcvGFMoQ2zK5khuj9PMqpU4Rj5xssZkepm9GoTIusUAtR0vJVOVLAO6b166OJn0keuCP8
	 xJwgzCZGlkqhb012bxI8QedAcuz0lWC8tclIS+1TfMpV3myL+3rP2Y+MF34FClh38Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318540;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=q+YMVvkEa8uaOBbexYkxUBo5dx74+xkphIFCSV1U0i8=;
	b=ChLTYMc/pmDhxu1F65V1VlHco0Ni7Je3PuSnvCqu4InRbj7lDtM8CZBTH+qt9VNtqV1Y
	 4wRwYVA8/VO5HOZ1k2lkLpIu8yPMvt9TCYo0VSw9+B8KwP+vGkpm2XdjdmFWqpKK3u8j6
	 CklRH4lM4CSTnB8XNgzHWzQf+qJ+90pWROCrH2hFOTCshvz0Fgtj3Y+InAB62xQjmOKSl
	 /XCSwfV0f9hLKhyTotradcNl41XrCFIubm3qudaQbMHwu8lkVY/jJajcJ6F2j9F9MiBZD
	 37GCYPT7SfbBQRA3GK4nACPWr20VGx4/X4VhipwFi7lRGNa0Tx12mnz8d/Ho9BboTsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U3pZ+JWc;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616D860A260A
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 13:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 616D860A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U3pZ+JWc
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-492f563d1c6so754391f8f.3
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 05:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794318538; x=1794923338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q+YMVvkEa8uaOBbexYkxUBo5dx74+xkphIFCSV1U0i8=;
        b=U3pZ+JWcNB+aUIQUkCWa/CoRrIxZottPyQ/U/RqEIHU8QvhFvxBkH2cALjw59mxU2S
         tt+WKohbj4ODaJ5yG3Ju4uUFACHMACrWvr0q3gyxNuzowYiagaIFfTSnDtuoIuKM6LaB
         jczTSMfVDYtSHUEIbpgykRs/LmEJWXIFOjVa8MPeUGbUP04K57Aos0p8ZvnVM/kOZNPp
         ShalNlCmNFobzlT+72+oz4RhDF8dNTyzRnITgCQBaKgmQ55R9vDev1chitgL2HL94v/V
         hM/daagI3jOeMww1OHmdvFVyF3i3oaviGDjg9IIbkWu4TNd1/31arkBsq1H5nOp08y+l
         0e3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794318538; x=1794923338;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q+YMVvkEa8uaOBbexYkxUBo5dx74+xkphIFCSV1U0i8=;
        b=paBJg/zSV1hj+GbD4MO6qDrSmxG16a/LEn3BBg1PW1w8MNcMDAIA2rg16FZE30f2VJ
         XBvRmpHKIpYzL56RbnUucosxx2aR0rzE4Q8dsFtzUO4qRu+ktIuJCkfeyVrR19+C6FgT
         TjULZ60RPiUWjODyCJFT3D1k8cT1IRfntqBpTjHw6vTYViIXCJCseX/JjTsawY/QT6Qr
         DNh6Td9HIfGGwuSt91gtCq4/gdsz5aD+z1mQB41pX8Gle+qhQTQu/xyemEe6M1+puY7+
         fxgnjQv9WLg8SGaRSJLyZmsV9qnU4cci85G4W1s/jTLJ7im+6d096RFIXu0JJXbMlPzV
         /OoQ==
X-Forwarded-Encrypted: i=1; AL+hErGj8g6WzSAfkWg1vGvwUxglAG3PzKz7dJbXf6GNneZ7MsjxL7aUrN6DEnnoYmbyrz6AbLQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9qPZGQXCy7X+6CHoQv67umYRwpbm0d1ALgSzUbjZlmNOxGmilG
	CWK/n2hZrQZZhhsFvKpxGFOa8aVwHX+ezodicKvPYl/wUx/QEZvgnyk3
X-Gm-Gg: AYBFou0QFJnNlwhFpF8QW19BmVLjMfeOXrb3TcDycWgcKEOIuxiau11eZi2Z8f0rCDQ
	79X4zL2E/78mc01u0wu5dCeRuB9PZZOiZAaVwXcIT0cjRqe3vymAOMJlVvaF4a/KF+8lxpO75Ap
	IOANvtRebB1ODKxonm8rv0cEmE9gWzFdfXw1WhSuvKeOYuI4ILhsQCCjxIh4zx+6i77+/79hq47
	xtzekXpxNWMaFNjNhGks/vTLBYb2qytTmvK72Apw7YjIkZJJHaaE7TAd03Cm1l7aA6ynvC9x/m2
	n17CM030nHMULglo0TmvgZAVIr8Gbfk2IT8jnfHAouGjNBHyz7W7+LCCK6sbvJUH7AhLm8maGJl
	ypdTnFdAjebEISXQmeCAocCC/46t+KPjgKfeZntoNJ1sswn6B06hEyJTOxhYuP4N0jtaxl2rqLu
	CquNAf3MrPIG2Mc02zENICotaoxWFDCm7+/StgYMf/R7EtSSs/D/INshbcfSKr6NjTL6cZ+kO+1
	0YxhWdChOHXP24no0qwnwuTOlEckNFSYpzqMyCaT3emcV7xxBCA/xg6EvtwN+DSPhQpogwU9hEy
	VhcescI1RAnzY8nClCivBFxctlG6cjchvC+A5A==
X-Received: by 2002:a05:6000:4006:b0:498:a72d:c097 with SMTP id ffacd0b85a97d-498a73d0414mr3856529f8f.19.1794318537546;
        Tue, 10 Nov 2026 05:48:57 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4984e26f8e3sm4483376f8f.1.2026.11.10.05.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:48:56 -0800 (PST)
Date: Tue, 10 Nov 2026 14:00:27 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, almagui@kernel.org,
	john.fastabend@gmail.com, qmo@kernel.org, brauner@kernel.org,
	kpsingh@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	emil@etsalapatis.com, ihor.solodrai@linux.dev, sashal@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	martin.lau@kernel.org, mason@kernel.org
Subject: Re: [PATCH v2 bpf-next 01/18] bpf: Add BTF ID sets for fmod_ret
 targets
Message-ID: <avMje16UShiO3bH1@mail.gmail.com>
References: <20261109170550.141443-2-a.s.protopopov@gmail.com>
 <4bd4574839415920b87e63fe2c5340ec54df15620210a2aad053ea7d7be14b94@mail.kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bd4574839415920b87e63fe2c5340ec54df15620210a2aad053ea7d7be14b94@mail.kernel.org>

On 26/11/09 05:42PM, bot+bpf-ci@kernel.org wrote:
> > bpf: Add BTF ID sets for fmod_ret targets
> 
> TL;DR: Nits only in resolve_btfids: a comment may misleadingly suggest entries
> with a missing function are rejected (they only warn), and a new outer "off"
> is shadowed by the inner one.

Will fix both nits (will be resending series in any case, as verifier changed
again since then)

> > diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> > --- a/tools/bpf/resolve_btfids/main.c
> > +++ b/tools/bpf/resolve_btfids/main.c
> 
> [ ... ]
> 
> > @@ -1344,7 +1355,16 @@ static bool is_arena_param(const struct btf *btf, const struct btf_param *param)
> >  	       param_name_has_suffix(name, PARAM_SUFFIX_ARENA_NULLABLE);
> >  }
> >  
> > -static int collect_kfuncs(struct object *obj, struct btf2btf_context *ctx)
> > +typedef int (*set_func_fn)(struct btf2btf_context *ctx, const char *name,
> > +			   u32 btf_id, u32 flags);
> > +
> > +/*
> > + * Call FN for each function in the BTF ID sets which have SET_FLAG set. Reject
> > + * an entry with flags other than ALLOWED_FLAGS, also if its function is missing.
> > + */
> 
> This isn't a bug, but could this read "even if its function is missing"?
> As written it can suggest that entries with a missing function are
> rejected, while collect_set_funcs() only prints a WARN, increments
> warnings and continues to the next entry.
> 
> [ ... ]
> 
> > @@ -1356,24 +1376,39 @@ static int collect_kfuncs(struct object *obj, struct btf2btf_context *ctx)
> >  	for (next = rb_first(&obj->sets); next; next = rb_next(next)) {
> >  		struct btf_id_set8 *set8;
> >  		struct btf_id *set_id;
> > -		u64 set_addr;
> > +		u64 set_addr, off;
> 
> [ ... ]
> 
> >  		for (u32 i = 0; i < set_id->cnt; i++) {
> >  			size_t off = (char *)&set8->pairs[i] - (char *)set8;
> >  			const char *name = find_name_by_addr(obj, set_addr + off);
> 
> This isn't a bug, but would a distinct name for the new outer offset, for
> example set_off, make it clearer which offset "set_addr + off" uses here?
> 
> The inner "size_t off" (offset of a pair within the set) now shadows the
> outer "off" (offset of the set within .BTF_ids), and the inner declaration
> would trigger -Wshadow.
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42662799554


Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73922D77F7
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 01:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792113927; cv=pass; b=JivIsnQCZGeK0rL3FJ+mZGKrpG+tBXLp/OkCInPvch13KH26DpwhDxIIkkWX9ZaTHlRvseASIU3g7raAElmEO3M0LlNdqLr0K7BTWGiaX3cdFWqHgVLW0wpavklC641uXL0sBI+NQfy9gDGsE4RCHae7Gsp8CZ87NUkvfoavqgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792113927; c=relaxed/simple;
	bh=+bpcFbcbAW3WAHM8r3YhKoj09+trAgCwrTbQly1NaWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LO2wYIBh2GQ1Y9pUCNQPOni4YxVfwJdHw1VULrXYR29uf3eUyRJEQhLkW61TCGXkUqzhJ6ywn5ZtrseGCd+b1MKxMBWHuQXJW12prZSlDb2KL+QbrDuBTfWdamjztiH4xoO4JjPSgj0iZPAXxVcikTAhDOPYqd9jrtpMf4056gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INC9/Wrm; arc=pass smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INC9/Wrm"
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-4a1bd6e9a26so3415985e9.1
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 18:25:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792113924; cv=none;
        d=google.com; s=arc-20260327;
        b=cY3CnBO3h1yb/6PQaqA4BgdUUscUxN7Votjp85sa/EkyQb14ghCYoPClylWZQiu8Xq
         eNvM7CDgfodiFQuQh2wLEzWDE/XMcCJW419d0+3VKKLluFX1tEg6VdCerSiNlUAUfrsN
         DxbqAFZBruprXxM2EKgGB89Lky3qP8QO3pII/u5ISv4izBQVBWzq7o3oxGOkyWPAYBjQ
         RLN9f1u3G900z8XW6cnSgSi6y3JFXOVVMpbhuSMtSojoApKdDpw+VCpPqTLbRHpSLhou
         aXTalnSHXAgpuIwH+W2di7Azj2uZChAiYkcaf2p2m7xTXBSgz2bbKEgrMTbPmOAp99DW
         xpYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+bpcFbcbAW3WAHM8r3YhKoj09+trAgCwrTbQly1NaWI=;
        fh=XRb9Qb+KyVvM3PB+53gjUzCWf1FO/OLJrYfCzoUflUM=;
        b=MwzxvasHc9zlgyA65pYEprRZ2e/xn1kHEvbAnfzBsHGtzpZ99riZ6n3vJLOPxqgzsf
         0WLyQD2HpLdR+Tl2MdrzoShZ7jC0Vh8F4hrlaeS3GEwmI0dIMnn6znymS4/R7XUmC4Zg
         mGzc/meDvVqk5/X1+1hXbrDhe9Pb/nz+ScHXLM/IBpcS3gqcavTgwOQTxI4wNuEE0bbU
         uBkc+hBvjbLCt9TQ216XHeT3NCHjraiXtP9u1kGAzSJ+rRyXWpVyLdczUIo/CrPKqiSe
         n2NsodQw3t9DhrY3cTsSUhVILbbSNzd80zcwpOdGl+C+lkp7HdYXndYIMf5BBMGPsWBY
         staQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792113924; x=1792718724; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+bpcFbcbAW3WAHM8r3YhKoj09+trAgCwrTbQly1NaWI=;
        b=INC9/Wrmo/D4Hei960d5qF0lt1QdjZxKUu4Z6pmwS8B2RXOw7HMlUWYC1UgnXWBIxh
         b1Yr2THM5EKMeptH738G8lHROu5hTzWOHcuOBYWXk1p4WxU50BIAlJ39Pu9TMRjvNtsM
         SRD5y8hokJCk7SmLOsv/bXRiF+bvrHFb8nxAXIIVgaCuipMSWFmQj/5F3VilMXnRbKEJ
         DgDmc0vIFXOvjkDL035lfe2zdaDMhuCdL0I/7tOLNS7D//pIctbNI7PgB3wVfK9h73dr
         3hDCcqFwEfbM72H9zQDn6RIYLf6h6QKKXgINpcYm80RGp5QnJrR6MvBnWXyvdSpwnPrw
         imSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792113924; x=1792718724;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+bpcFbcbAW3WAHM8r3YhKoj09+trAgCwrTbQly1NaWI=;
        b=EGSrG8npeIZVwKm4xnG8leJePaSD1J+v8IuXguAXuVqdjkZOCQhdiD+gomnrotasU3
         wEGN4JrZslHySo/OVPa9MaOjV4vYEwtVXJvhXaEvJi5v4KHYuyyx6hEd+V+9kCIGVwVy
         oikqC3WjCcJndgJS7CWBUABrine+p9KaDDhnp5+sYXBFkMO35oh2bJ2hkrBELU3OqWr1
         EiuMlyDF7csNeaVfjK/TsqQJ0MBRAQW99IWPfVtuvUoDRto1/M0qiGtLRg33z/lB00ct
         VeJpbcCTwEXp3Q/GuYGOdAMgR6pp+fGDejRZ6ZdnfL+xX+RJN//sP6LZ4jPz0LsSArjR
         b6dQ==
X-Gm-Message-State: AFq9FYJhyfeag6WvuUtaFtbOh3fLBNsk0wlSJ6Jj8Uynjx2fxctVYzQJ
	5h7PaffKGKGeavo+jpY2j2NgQBu6rdTz+E8BquBNzCevcQ/mps8aNKERNnlhixWpHfwfiy4Vjfe
	D+9zVXNK/TJOFuIFzzy9RJfZaziZcSa0=
X-Gm-Gg: AYBFou3b5mpcMxHdvBQBSdQ3W8ECGtSFszA/ugTzo2p33mV0o5Sol+JnNXtWm/4qyfH
	sgi2zp+8rmerfhOfFzdfPlADwVmXtsDxhbVvwd70M2KIBpPFfIa9dT+p/bDKs1NWCc0+zQ58KV4
	BVTYSmIUYMX/xJwNlpYbRcoX5fyyFSVFpUCMRzb1My03byW0g7FvL5CXm5ZUnIvXfhRq8UuK+jk
	EJiBhtopDlBu2n+UP34jWs7to1OwlQnHLRATvskDccaOglaxBxVyBN+ymiGgP+qx+pM+ydfl+1g
	XZZCz9yNeeJ8pDHzNx0MT/WeoRH7PsPLQ5zxErokjhsK/9jqbKU8xxtAPvxc6HIYcE1UxT53j/d
	nrxpieIQ5/ARhRvkEQjYyyxtoC43dH200pEmfYT+8QgGAbRXrDpFUtiX0hnp1s00cLonjw1IrP9
	OoNkVhYiqHYHd37qln+EAaIr6wLBOBufRisXvrklr8SA==
X-Received: by 2002:a05:600c:630f:b0:4a1:9f59:ee7 with SMTP id
 5b1f17b1804b1-4a19f5911f4mr284879935e9.0.1792113923736; Thu, 15 Oct 2026
 18:25:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015234125.3152346-1-memxor@gmail.com> <20261015234125.3152346-7-memxor@gmail.com>
 <DM5V1EIGVJEG.1IIPS4R40HPA0@gmail.com>
In-Reply-To: <DM5V1EIGVJEG.1IIPS4R40HPA0@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 16 Oct 2026 03:24:47 +0200
X-Gm-Features: AclHuK-oRf6ku97yve1k99Waa9FUgE7sRIP3ge1HTYxnuwWiYnvFOk5bT5KzVoc
Message-ID: <CAP01T743a5wuvP=5cc8Aqb=PHGhSFWcir0sCSWMvMT_=gk8Kjw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 06/15] bpf: Recognize __nullable on pointer
 members of kernel structs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Tejun Heo <tj@kernel.org>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Oct 2026 at 03:10, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Oct 16, 2026 at 01:41 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > it on, as the tag says. A tagged member of an existing struct thus asks
> > every program that reads it for a check, including one that reads it
> > through a probed pointer and relied on a NULL dereference reading as
> > zero.
>
> Commit log reads like BTF_TYPE_SAFE_*() can go away one day,
> but with this change adding __nullable to a member of task_struct
> breaks every tracing prog that walks through it without a check.
> So the tag cannot be added to existing structs and
> BTF_TYPE_SAFE_*_OR_NULL lists are here to stay, right?
>

Well, BTF_TYPE_SAFE_*_OR_NULL also enforces a NULL check, so not clear
to me how using the annotation over that will break a program (see
type_is_trusted_or_null() usage). The only difference is that this
annotation works with type tags applied directly on the struct.

The only reason I did not drop those macros yet is because our
baseline GCC version does not support type tags, once we move to that
point we can drop both the macros, rework kfunc suffixes, etc.
sched_ext is fine taking that dependency. The tag when specified on a
struct member directly will do the right thing, just like
BTF_TYPE_SAFE_*_OR_NULL does.

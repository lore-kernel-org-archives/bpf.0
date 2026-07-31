Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4671036E47E
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 19:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785525904; cv=none; b=aH827L0eB6FqFl2YFYb1Ig8NQqaJ72Do4bYyWf2MTIFBVe1GN1H7wnvi9Ba0AOjRwS2p7injE80MmyApcr8kh3YicE72xwbnIKO0psjNuvchDbaXLEJyTKrj2p8/vOEp891UxYsuTCvhv2H37P/wNOvOhhhkJsw0Wl8um/7LWfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785525904; c=relaxed/simple;
	bh=+236ZUiGE1UTZf5D568G34CzbrXLYB0nlzUL2poy9i8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8u7Pq41JYwVnFDuu7gB0hrbqoCmQdQKOEwNKfki5SdwbtcH5H9fpUc+yOxSxinmX4d0pXDeRHkwUWaodvIXFng9aHCx0jeAxdbDorMXu/Wbeh+MBhr4cq5NeOF8TVhDqD7R4qsOku0lS5HqYgMJlCMr6bnQyJK3ZRszDDmEcxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDaDBSRc; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDaDBSRc"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-81e86df8987so19554857b3.3
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 12:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785525902; x=1786130702; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1w94Tr21pSE0EfOV5IzEh1sDDQbxXsJWYMJqC312JyA=;
        b=hDaDBSRc0QKOuNvST+/T/jfxPa2Fpoz8ME9z9I9oDw8WVw8NHeH+0D9RADBTtbBxw9
         gvtOU8qz28kcY3iwi9qP19EnV6CglGpxXbFu5DjDB+6ZETOTW43PljvJHgnVib2coAjl
         yt4/LV1PnZPsrlmdu0/iXjSRiWQO5KXZOCUGmXS2pyH2POeRe5Vb3Uhz5yz5Twr+Z7se
         Rz/xoN86rPd6fxf9JZC4LyjOkQcvkH8ng39GB/9VPXx/Wff/K1798fjEfFtqeV1ioIyz
         FvcAmE0LLnJ5F0oWfc4nfh/KeS07cwzyNgUmx7+8Sp0+DtigjFjehvkOxyZIZV0Z5j74
         9TNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785525902; x=1786130702;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1w94Tr21pSE0EfOV5IzEh1sDDQbxXsJWYMJqC312JyA=;
        b=W+iVGayO5IGDr4BMLgXnPOW/dP/xqEuNKBmAmE5h6Ii85j69bbbSkDUaTbVld4Ve3G
         mE0AgAeWZrgyGzbSABuD0W9hS+AX7oV9qANlIA3K96aC8YNeLvEvwHIBRqAvV+8coeBj
         2CELcIg0njxR4cuY8LkIHoKRcjJ4+iRRxAXAMujTyFjgiPBHBSjF5nL6x1dcTn8c69wW
         FJJBBwkGrqQAehxpSTl0JS5F196J80YGOxfvB+tsBVaThhZO2TV/KMdBCXJcI0f1z8Tn
         JffL98chkL5REVImtVFvJ/scVRkdJMwtPTo8gMma4PYfLGd9qxLb99ypQBi2NDMN0oM7
         bBow==
X-Gm-Message-State: AOJu0YyDDU8+2Xs630GMUT0JGJf6Gdb8WNJIukeiotw3Pt66cuSgblCb
	EsR/pa5gpWlCgpdx9AVknne7soNZZciwVPceRkSgRUeFKyIqVWMw0ZyZW14Exgdd
X-Gm-Gg: AR+sD12TCmBDx2bZrSujQApbWD57BqbGmrhOglq6wQbZ1JA6JdZzzpkTAj264Ej9Fuj
	wp2B0NVrh2NDd5SdN7IZv8lb2u5OB2EPY9XUOPy11iA/vgmrDYXsYUVCYRXlOMlApaXa9AhKaQg
	enWwGrby1aPDzC3yQoPuhRMb0J075xUgXyDxF+iHzHtnHCXFM1vlJ6EpwIQ8Re5G0imMXnYIDbo
	2UT564zd0CPZWaYCRH+C9HRRc3NSjqYaH7iVDNFK6rUYCumPKpDrI0ggOexOdsDR4PlyRswhWEh
	4N9bMwhECNC4mynM6HqkZFB34RlqtI6O9I3NxUo4Lino1Y2TjCTN/sJ/woswZGwlhSVnY41lvJY
	CNKD2aRerli3ZS3jUP63O9b28HxBe3wx3LO7011br3oprUa5WaCUCeMfU4cYEB7+gy56DUQqd/d
	YJgLeonBWvkS5qG8opJIg05tjYZB5lmR6qY2pMlftGewTLLQTMzxEYPyr2lWey/0odTq0iWXDUj
	rGIbrtIBOzPR2V6rLqMjQA=
X-Received: by 2002:a05:690c:6d0b:b0:7fd:ddb0:2622 with SMTP id 00721157ae682-81fd49bfea7mr14802447b3.6.1785525902064;
        Fri, 31 Jul 2026 12:25:02 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:d52:64e9:32ac:b832])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fccf30319sm13142527b3.6.2026.07.31.12.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 12:25:01 -0700 (PDT)
Date: Fri, 31 Jul 2026 15:25:01 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 12/13] landlock: Document the BPF kfunc interface
Message-ID: <amzzYACkhCpraJLO@zenbox>
References: <20260731022047.189137-1-utilityemal77@gmail.com>
 <20260731022047.189137-13-utilityemal77@gmail.com>
 <20260731024550.A713C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260731024550.A713C1F000E9@smtp.kernel.org>

On Fri, Jul 31, 2026 at 02:45:50AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The kfunc filter excessively restricts `bpf_landlock_put_ruleset`, contradicting the documented intent and severely limiting ruleset lifecycle management.
>
> [...]
>
> [Severity: Medium]
> Does the kfunc filter excessively restrict bpf_landlock_put_ruleset,
> contradicting the documented intent?
> 
> Looking at bpf_landlock_kfunc_filter() in kernel/bpf/bpf_lsm.c, it appears
> to apply -EACCES to bpf_landlock_put_ruleset for most program types and hooks:
> 
> kernel/bpf/bpf_lsm.c:bpf_landlock_kfunc_filter() {
> 	if (!btf_id_set8_contains(&bpf_landlock_kfunc_ids, kfunc_id))
> 		return 0;
> 
> 	switch (prog->type) {
> // ...
> 	case BPF_PROG_TYPE_LSM:
> // ...
> 		if (!btf_id_set_contains(&bpf_landlock_kfunc_hooks,
> 					 prog->aux->attach_btf_id))
> 			return -EACCES;
> 
> 		return 0;
> 	default:
> 		return -EACCES;
> 	}
> }
> 
> This prevents BPF programs of types other than SYSCALL or two specific
> sleepable LSM hooks from legitimately dropping a reference to a
> bpf_landlock_ruleset they acquire from a map via bpf_kptr_xchg().
> 
> The verifier forces the program to drop the acquired reference, but rejects
> the call to bpf_landlock_put_ruleset().
> 
> Additionally, looking at bpf_landlock_kfunc_ids:
> 
> kernel/bpf/bpf_lsm.c:
> BTF_ID_FLAGS(func, bpf_landlock_put_ruleset, KF_RELEASE | KF_SLEEPABLE)
> 
> The KF_SLEEPABLE flag seems to prevent calling the release kfunc from
> non-sleepable programs, even though the underlying release mechanism
> (security_policy_kptr_put) is designed to support non-sleepable contexts.
> 
> Could this severely limit ruleset lifecycle management by making the kptr
> functionally unusable across most BPF program types?
>
Sashiko repeated this same feedback a few times.

It seems reasonable.

I don't see why the bpf_landlock_put_ruleset's allowed calling context
can't be broadened out.

It's probably ok to allow it for all BPF_PROG_TYPE_LSM programs
(including non-sleepable ones) in addition to BPF_PROG_TYPE_SYSCALL, and
drop KF_SLEEPABLE in accordance with the security_policy_kptr_put docs
stating that the hook consumer cannot sleep.

Same goes for the bpf_landlock_ruleset dtor.

Justin

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260731022047.189137-1-utilityemal77@gmail.com?part=12

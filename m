Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFF613D891
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 00:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786666449; cv=none; b=fGOWOQ5vhHIHsG/QfqjIc/SVUjCDu/YyvPPJrEDFz8hhiq85cXRFjMA4+Ur85MYKvKxDsF9q2Cl5Ifu2L1fNeaRJIT1PAkB8fo97/M7jblSxCvPx42ZWBgeFQYiPtLB+ZlUGx6On9DtP3EbEkXCdVuquLUg6eLlpogwrx/z1gHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786666449; c=relaxed/simple;
	bh=C5nVkUNMV7Ig+Y8GVlrqoFzpmDyOaJHY6c0sq4Xossw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VzETK8+yVIFzqS2mq+6biJGHpNeDug6ehj7SPJFHvdKf3F2+NP/cnAXeSZMV6cq8yF7EWTFF05q025Db2Q7HNXtnXq85Pu868Qwhbu8oDmPVbCDx5WJSoNYuUNZyos3/cZ80AjqOvqZlVRq1veaGwyOAPUMpqXpONjsrzAuuwMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSXkwScV; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSXkwScV"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cbedf433a99so390317a12.2
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 17:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786666447; x=1787271247; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6l3D5/SbgYiklv+NVxjZquxsLJXOjF4y5W1m+lLTXkg=;
        b=aSXkwScVByLYl/Tw2ZCRH5XSfKR2eI7bs7p6HOshb/12J5fai5otmTHiqmTDvqEQeX
         5w9MjmGqgrmUCm/gQSnVbm7EvnqoKLCL6vaChBaYxiytoIdaJzOkWaM5NlxEog8ZQt/v
         QLq9VpT4lRWB1qmUCm1Gwh3YQtxXvZxtNU5pUTvLqd33LZqF7AuZcEdYbQ5j3luPE/Dh
         tp5Kp84vAab7AEHVUBd8xPA/a31OOhhxFDc5pMMCh1Ut8sLxsNobqNUtk9W+dDCa80/v
         46bSRZ9BlPUWrynSsetphSwD6KwB3vG3hbsDmkkWtFaVgjaPcVCPljzJUbK2/fT7cqZN
         y25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786666447; x=1787271247;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6l3D5/SbgYiklv+NVxjZquxsLJXOjF4y5W1m+lLTXkg=;
        b=owMENYsxYEgEz3sDLR98gTGukrYxp2jhXVmUATPVktKBgqkpP8IlpN9niwu/RiNO6t
         JyOuXvkDjBwedrnMETgoR0M5TB397o3YGibykfcxpROUwVfwPozcHqaG+PIG5Y/wPVCA
         72p6LEsKZk1GpS7Et4Oyv30EGLhBBc5+Gtxtbv++KGDjk22VuxqmVaFa+VGzOxS9Wusd
         p+y4PRhpE0OmB0GXHjzuYNJ/FjeujZKx4j+DE0UExE5oa3n3rx05LO2TzzQz3DOtq+Ge
         UDkFeL5BIemwMvpN7k6hdxM9rx/Eut38i5VCeg/+Vy7L5HkIGzVvPQEJNA6OzZXxEt3r
         SDSw==
X-Forwarded-Encrypted: i=1; AHgh+Rp44YV/0Sj1zZJQyWu8k+YnMCK4OKUk+kvyFFu0Cnl+MCRZ2hjpj5KIplXJci5DhycK7WU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDOb31tz9pOu1xqC4pV/kBAwbajvh0dO8dGvZQj7ARS5bIdi0/
	KaRjYvU/98UZbD/IzdysfaDVbPh0DWHthbjQYxwqn6HBivccuPZKhfG6
X-Gm-Gg: AR+sD11cGR/zCfDNehiQdMKyfuaigCFBXzF7+BNyOzbD/UsFNO1PCncuvR/ixFLi6vP
	xAsRUWxbfBjIsIFneFUCcONpPvUo72eoPpYrec61Zt2Batr5vJfKyWiy+9kwn6iQ8x6x4bNLb5m
	hzPVk4Ymq7AcxflbuP5zD26/lJzOh0h2ISFvDt/WFq/VEuzc2QX3qaDXPoZPFEQWVjIr36CNk3w
	C2ib1RwX4FHUwsIW9BNFMuoXiIwhbdcyvm73Jq2/+V9rxe5tSnWfiEUES6wKesiSEtMxq1WVVoO
	fDc00fEYXhfRujVgAHIeM3zrTK+BrVILRX8hHQQO2xsuR1TpX1O0gq14/t3Te8wYXsnIz93rxqT
	gNPM1OjjeSKlEAFOMWoLKGIiaG4BM+ffVDjnPOwSrpHC/WqEqDhQeTYuz5Saz5e04Ydw5Tgvu3a
	A5rIjqNFcxYfZ3pIkqyeeayO4Mub6hyEidXIjUDw7e81JAJGxkSjMIBogxA8BZ33yWNsiUDY3YP
	H14hpsu1XNs0upFKjbWk6+AFdfZ7ceVWJJbcg/13XzTYg==
X-Received: by 2002:a05:6a21:3384:b0:3b2:8685:1473 with SMTP id adf61e73a8af0-3cc719c7356mr2129297637.7.1786666447552;
        Thu, 13 Aug 2026 17:14:07 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2cae:4c28:2903:b6f9? ([2620:10d:c090:500::7:1c5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ebcb69807sm12372396eec.10.2026.08.13.17.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 17:14:06 -0700 (PDT)
Message-ID: <b698a1805cf0164abdedca01fa12494effce0c49.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Merge pointer types also when both
 are PTR_TO_MEM
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: memxor@gmail.com, bpf@vger.kernel.org
Date: Thu, 13 Aug 2026 17:14:05 -0700
In-Reply-To: <20260813204032.644949-2-daniel@iogearbox.net>
References: <20260813204032.644949-1-daniel@iogearbox.net>
	 <20260813204032.644949-2-daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-13 at 22:40 +0200, Daniel Borkmann wrote:
> save_aux_ptr_type() only reaches the merge when reg_type_mismatch() says
> the two types are incompatible, and that in turn requires at least one of
> them to have a base type reg_type_mismatch_ok() rejects. PTR_TO_MEM is
> not among those, so for two PTR_TO_MEM based types the merge never runs
> and the recorded type stays the one of whichever path was verified first.
>=20
> That is ok as long as all PTR_TO_MEM variants can be dereferenced with
> a plain load, which stopped being true with commit f2362a57aeff ("bpf:
> allow void* cast using bpf_rdonly_cast()") adding PTR_TO_MEM | MEM_RDONLY
> > PTR_UNTRUSTED. If the other path saved e.g. a PTR_TO_MEM | MEM_RINGBUF
> first, then bpf_convert_ctx_accesses() does not rewrite the load into a
> BPF_PROBE_MEM one, and the untrusted path faults on a plain load.
>=20
> Fix by merging the two whenever they differ and both are of PTR_TO_MEM or
> PTR_TO_BTF_ID base instead of keying it off reg_type_mismatch(), so that
> merge_ptr_types() gets to normalize the result in this case as well. The
> rejection of genuinely incompatible types is left untouched.
>=20
> Fixes: f2362a57aeff ("bpf: allow void* cast using bpf_rdonly_cast()")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---

Would the following work?

  diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
  index 1e537bc25ef5..a02914af0f5b 100644
  --- a/kernel/bpf/verifier.c
  +++ b/kernel/bpf/verifier.c
  @@ -17022,6 +17022,8 @@ static bool reg_type_mismatch_ok(enum bpf_reg_typ=
e type)
        case PTR_TO_BTF_ID:
        case PTR_TO_ARENA:
                return false;
  +     case PTR_TO_MEM:
  +             return !may_fault_on_deref(type);
        default:
                return true;

?

Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A65E2DBF47
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 22:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770847479; cv=pass; b=Yujv7sKnoYtfHnsNtKyixOv4wAa7FT5dlCSwh7kHwg2H28FuaJ/kDpQkrpj83C/49VRnkH7uJ9JAXiOBoaY9chwqm9cuNw9z49FD61kGpqoQkJjQ5zqfKWhxQ0kGFbMDTTVpNkT699UBBrXxKRYfaXlz0CPCuz7WWxESYrpIXgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770847479; c=relaxed/simple;
	bh=xYLITwmQkBHZuyWBinrWhpg72zDbwiwLJN9i99eG/4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OiW8qHbyvesZpBa7XUI4/shuNes3CmJYPGl5yXvsuKGFGTO/fl7vssetsHXUUI2sfiZXMAsoo1PUVhALQSi+PnnwSPeZ8+/s1zN54qBo3Zn8JWbkI4JwD0m+cIf1D61i/PjllnZlIL5K06jzLv/tbaF3qRDvQ6Hwpa4DgUm1VJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmpJkNxD; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmpJkNxD"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-436234ef0f0so4487469f8f.1
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 14:04:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770847477; cv=none;
        d=google.com; s=arc-20240605;
        b=OUzAkeOXlmMB0bdQoDB5SZjIj0FS6gnU4TwMhWqfD/dfu4r7hcmkX0ktKHIyCh2XuN
         1BC1NDBKXMGn98nB7OiV5KZeWzcV8eZISQVF/W191rJB5HiXI29iYM8LllTjukyUog5U
         oPwQwRC24rCQsqWW2Js5QiAGdkZBcRdRy/MURRc9eO846klTZJoNuPvUOJoBaB4aSyH4
         NvIKITuNZDXPA2P30SymuP5jfMPf+ZAtjEp8wKgFG4sgmeGEz/+1uyPDWy3WJknkhxYx
         DINN6xAzJrVbt1vkBNHAUngB4zT1ZrFHBJ7OYmb37MsF7iug0JLGEjf9pWmjX6Jqs9bK
         +2fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FR6+el64FV3XLWEDv2HPciNXzhYlgVXQsT8sq8aBxGs=;
        fh=/vcNYrAJJb439dsZ7iBfi10x9/H/MJg6e/sjvEyepHc=;
        b=S8KX1ShrR8HoiTL/ELqq/sWeEH5bJkaBfnlKgUCFdKZmAII6Vtf70You1ESYoTAPLH
         XVhYX25UEwuZ+qZ7CjMckepTfsM4w4r0GSD87rEMXI60w+jGICwWZNUgxK3xHxYUfR6i
         AaC6vyC9osaCEktabyqJ/t28pwAswQ5lrsTTjE/GJVFfvB6c1wE/NlBTooAa5oRsy9jz
         ARaMtm8od5tD6I5Qvp6q81JhfP2H7vUlvfYGSARtTaD11swuNY+u9LcTMCdWgTXZ0KuU
         3kIZ4lHauBu2JxB/NJ+Nu5ZMRVVc4kAX2eUgjSKg+CyT2NfWL5tWnvSB2soZ7ggdhx7i
         2RRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770847477; x=1771452277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FR6+el64FV3XLWEDv2HPciNXzhYlgVXQsT8sq8aBxGs=;
        b=WmpJkNxDzBNxis3JDJ3YbfmW+rhtFv7uByoXeWvWoKLf3MZk0sUdau3HNqbOK0vacI
         on/wTZ5GS0ufe3NLZ/4nMtP+6Fv6K0IDdIyAsJkU1xA0PkodLewQ5KoDHP1LGoO5+qPu
         qWdnUCN+zlWZAa6RIL92P3N/qWfBB6Smhoh64bpBDaQloQB+sK2YhfNA4lY1hdoU1CDk
         u71WdTm6yxj/wVhbMmYZ3nWZVdBL/G422DUBAF/DhBe/Ner5waBmB3A2TcqCG7V3tevk
         pofxlRlbxLitfCfsP3aSvIFBQxxAUC3gpA0XBzPvCNj9nCERxj9X64LHuj/0UzMtf3nO
         921w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770847477; x=1771452277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FR6+el64FV3XLWEDv2HPciNXzhYlgVXQsT8sq8aBxGs=;
        b=ifALuWbkU0gaGOl1kUXnkFv+MRb0CriNBgPT74oeju46PkGUYM+CGfIjMoh/mPJd90
         TxCXu2PQ/vFXQ8cdWHPUB5TwXvRZDeqgACV7C+97AZzGHA2lIuJ5ZJZ96KSR1UKv/ZY4
         Qq53DRqflD8tcRE3GBUBXCKLrNT1GDaZNYBUbOMBbT0ptDa4sKa9v/NYVbUVYSBdMUga
         ZcZtCo1wUfuc4DMu2sDn7UoMq0wYODDEsChLi/5TmHp5Sddjgu7fW4RWB4RKu30Kmz0e
         KsCM1uoN9EAPEohAsfs2R8RcIeF0XsSUgBklgefVnOl2uSmQX7RChQ7w3r1PYQgPhKlG
         EswA==
X-Gm-Message-State: AOJu0YzafJXTpceaoLhr1uN20dVogusIxTHj0GZRc7kNceqhRR3FMLoE
	hJ6H0gE5CG5Ap4MD1XG8IoijJ7WdUqLRGjz9V7BeAswuWlpW50SD3v9K9oc2YEGfymyJ5VvRTxR
	kEkiMnHveCBJuGIgShAmEd1qVo2bIFcI=
X-Gm-Gg: AZuq6aIV5URB8ZSFAnMHHNWYcbuizwTHN6QQ5u48Xr6pp+tu3GBjoY1D+vyy5vGzaN/
	eQpwArIAR2ng14Ejd8RVP6bfdErHChZmOXSN2QT4bth0pmwszo6uHRRYLpLjY/+J22AyVX67sOi
	UlywlO8B3OqKRibN1qJuvcGxZGbVN9mRHCsW76xDN2WO6+DGYnDtWmPCRzKEyVSmc7zH/RdGPVE
	p2s0Rnk5V4Hl8nBmHW/Fc+i4BMohnoXjxpSr6uqAs7W7Uyld7siC8bmihfcvYqzzODsh5VSMcAh
	fjcWYOHS9pbkbPPpve3Yj6jOIB4nmtWE+tiW1RjuPOWACa0MTkSzxNb4Y1YXsMbUrUWT3tJNPM+
	79dwstXND9FqSGLZWPtMrMCx+TA==
X-Received: by 2002:a05:6000:4381:b0:436:42cc:25ef with SMTP id
 ffacd0b85a97d-4378a9eca8cmr1301638f8f.13.1770847476626; Wed, 11 Feb 2026
 14:04:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211181248.3040142-1-memxor@gmail.com> <20260211181248.3040142-4-memxor@gmail.com>
In-Reply-To: <20260211181248.3040142-4-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Feb 2026 14:04:25 -0800
X-Gm-Features: AZwV_QidD527w6s22qwIRJNVNmYf3srIe60M7xk892AK67HlPeK55rJHXUhwrxk
Message-ID: <CAADnVQKbp1FXQTAFkHt_T+AaxSnNGsjX6=cguvNip6ZNEetCiA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v1 3/6] bpf: Enable rqspinlock in tracing progs
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 10:12=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Allow using rqspinlock in tracing programs, since it is safe to acquire

...

> -               if (is_tracing_prog_type(prog_type)) {
> +               if (is_tracing_prog_type(prog_type) &&
> +                   btf_record_has_field(map->record, BPF_SPIN_LOCK)) {

hmm. Did you mean BPF_RES_SPIN_LOCK ?

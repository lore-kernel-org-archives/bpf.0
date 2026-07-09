Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175B03C8C5D
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 21:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783633830; cv=pass; b=gvTAwBl/KJ7oWo89KuaMhBQdRlvn3sPepYu/acCDEqMqbTc1z3u0EFOg2htaOWIbtf/Q4zUC1kYPuGnFny+f5Whb4IlnLRtNsLuFcKRoEENV3v2HPBdnAkOSG/iFqsDWX3jSzZtZ9BHwHWwsNpHzn/CEQALQXXOQBlv/9Jx7+1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783633830; c=relaxed/simple;
	bh=QZU1CA1cQeL2WvZUsAarUegvdKd7AYzS4BOYt8+niWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLDZ1AkSw9sh/ycRz3mTP2kL2ZmgMvcOqxGomNJlGSo+b1kv/HKc5+2Qe3AVDkOAriNaWL0cNAGdrcs5+GFB+shF5qWkpJZewKnugftYlAP869mz8m2MCKvj46y7V+tyjdvWiMe0QhT79qiHR73B4Bcn6fWjqjTQk/7KoE+XX40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuNvKGI2; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuNvKGI2"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-66771ded50aso455016d50.1
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 14:50:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783633828; cv=none;
        d=google.com; s=arc-20260327;
        b=JFe5+JlNEdhsjQU/ONsId2UQW2sH9AqXs2cp6qZfX+tfIMaSxROt7Xq8lU7TH3tmVd
         ZbK4gsOQGP5jmku6c43XhgjIR2abUJbwC1OvloM8ULbWKW/gEMQsU6hSieHC4OM9d3kH
         CIX35BcrPVaZTsO5N5kjYuuWeajMXUp38XkRGMgU+9jHbab5qVHTknJwabSeXO5cDxjR
         T5knVyeZxCFXJpmJtQ7nBGA7EjjpKQw1/uiPwxWtP32+KBPfb8cxRTMYlugJelt0w/0s
         Wc2Gz4RRsOm+wNnKAHhiVk/CllrT1BtVONPNbOU3PpPf184LHZRQFJPsOJuxe7K2Pe5d
         Bfaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QZU1CA1cQeL2WvZUsAarUegvdKd7AYzS4BOYt8+niWY=;
        fh=ag6O94OH92ZQTvEhfXWmc938ny+4TK6R774SOnpXDqQ=;
        b=Mj1hUff8HrXfBtsvAz2DuGCtj++R6OSi0LbHRVSHJc8Xijn91VaQ8xEl08PEjiHzKm
         I/52FHg3/PK7CqAHwwuO+JPJgFZEYHPJtJU7IoHKAu+eWp+r3OLIbdxGZTU/tkc9zQbI
         E0MqoCFjKq6jQu8Ngq359QQYLg6plZblZOSB8hEEo40ipvAImO3bqxA/5/c0f+03rtBF
         Fzk5X2EhlPKNJ80V5dR+RG8JGiu3sOftwebe3SNY7jXJt7hZgkjJQNTTnRFQzx4ua/05
         j4/POcqkqLamkyv6A2X/0f3hVCofbMS6z8xwOR40gPJwKjE3YZjV5jYJ4J+hOia8QiR4
         xfzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783633828; x=1784238628; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QZU1CA1cQeL2WvZUsAarUegvdKd7AYzS4BOYt8+niWY=;
        b=FuNvKGI2AZDJcefp4cfVpzg8zWts9tTpidzXrvkNHB7TQyxN4c7UIrJ0bwWJNc6VFb
         U+l+3Nzz/8K3OmM5BhcigqWMlQ9z7TtHtlsbD9yMg7Bu8CjHm7tpiITyO7eDzW7TfcYl
         8zEqxcPV50cH+1/OCOTQ82YA2uJKGntVa8rcLEi5YBR35G1ZHOMLirssP+fvG2lgT2OE
         XRfy35+FxomT741jWij/nxiSit9yDP4eD7PUfjA5QqlL/7oSDWfsHPuR7HWpShJ3/aKr
         8CbTeSxEi6Oz9KCppA+0oh1F+wvH7liHgsh45eKifpU6Z6PaDgY6azjFv1HAaj0Ox8Dz
         prAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783633828; x=1784238628;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QZU1CA1cQeL2WvZUsAarUegvdKd7AYzS4BOYt8+niWY=;
        b=Uh72aOL/CpDK9xgv5qkjxjZCz6+cmehvN494uqEHTmQWu60I3yGHxCvbfquhefvYXI
         PFoveoXcu8YZcQU8lO8KMdXj49X3RBiLvuuuWaxFP/s1hLWesj8EbkG6k0OxIgarz3Mn
         bUBjf54AUQHKKThrMBrrGn99h4uo2Ko4XzsQ2omlZeHjU/0CmwRiAJVa2icx4gdOfCpJ
         zupGfwZocHcg4E34ftITMtNSn3I8HxicE7D2DfmxdOxv+gZ9OHQ26LpYwnGQ/aEL6cHd
         iHab+xV1KNUoW7GMA4rRDalzZXdb2E84kS1+kAGFWZSWqQALUcqid3L5JNwa30wtqIhk
         qdAw==
X-Forwarded-Encrypted: i=1; AHgh+RqdiUbMAyo/EfffnTMg6ovebypDpywFMK1fgJZbEX0MYPlgbBPfMyt5Vn6fiAr3NIb9UEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxos9bDJKagz2LLEUCECmeRDTmI6T6HjXHVKJ5h6iODjcma73ME
	380934mSu5M+bhpevmohfaBfiNRgqGNU1LWh2XNuQAoij8rHx0xDTz4SnblAS4jzUz7C4ko9Jn0
	lpTR6l9EENGxIPzeZdDJsfQc9VQPd54s=
X-Gm-Gg: AfdE7cnwrkm2KajSudelTbXplWNbA5YjGIodNXDJfp28pWkToS/TijWF/pLYdC1+yE/
	g79fhLSy/GUzkbm9TpUgUyqu5xCWUKqGKMnxGac1c76RK94odvOV+FvmG1ICkBRzAoczE60ccL4
	3PHmxIZP8cPc+2ZdWleQbLq8c8PJbWdoE9MAQF8VYVyPCn+Mq/Y02lK3p0XWUVZcG8wNRNwFxrT
	MVdomdIP11S9kT7p26XWmC+TK90aeXS28EsPrIi6H6rt7eRgnCo47KKTLo5b803QVjmRqNZyuu5
	0HuxLng=
X-Received: by 2002:a05:690e:23cb:b0:667:8b90:3570 with SMTP id
 956f58d0204a3-6679f26f8dfmr4940312d50.98.1783633827971; Thu, 09 Jul 2026
 14:50:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709155837.1879230-1-main.kalliope@gmail.com>
 <20260709155837.1879230-2-main.kalliope@gmail.com> <20260709161557.794E01F000E9@smtp.kernel.org>
 <CAMB2axMeZbxWry=P5JTVo_xDw7TUeUKdK6X0_LKjvLWnLJyHMw@mail.gmail.com> <DJUBOWHO347N.1EKHIDMTB7DSA@gmail.com>
In-Reply-To: <DJUBOWHO347N.1EKHIDMTB7DSA@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 9 Jul 2026 14:50:13 -0700
X-Gm-Features: AVVi8Cf4Kfn7RAMd0LquKodZ2ffbhqy7yZbq71rdlefclCRwUQX49MGqTd6h5Bg
Message-ID: <CAMB2axN+ePA_eFKBMBP1kuK8yhr+6PhRmyjX3EDgYthkw4YdDg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: reject rdonly/rdwr_buf_size kfunc
 arguments that exceed u32 max
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, Nicholas Dudar <main.kalliope@gmail.com>, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 1:29=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> On Thu Jul 9, 2026 at 10:01 PM CEST, Amery Hung wrote:
> > On Thu, Jul 9, 2026 at 9:22=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
> >>
> >> Thank you for your contribution! Sashiko AI review found 2 potential i=
ssue(s) to consider:
> >>
> >> Pre-existing issues:
> >> - [High] 32-bit integer overflow in `hid_bpf_get_data()` allows arbitr=
ary out-of-bounds kernel memory access.
> >> - [High] Explicit 0-sized requests to kfuncs result in out-of-bounds r=
ead due to verifier BTF fallback.
> >
> > I also noticed the second preexisting issue when working on a patchset
> > unifying helper and kfunc handling. The patchset will fix it.
> >
>
> Exciting! Are you also planning to unify global function calls (and exten=
d the
> type system so that we have parity with what helpers/kfuncs can take), or=
 is the
> scope only helpers and kfuncs for now? Just curious, but I think it the
> unification would be a good base to bring their argument types and the ha=
ndling
> at parity with helpers/kfuncs.

Yeah. I'd like to cover global function calls. The incoming patchsets
will only cover helper and kfunc though due to the size of changes.

The basic idea is to have a common function call descriptor for
helper, kfunc and global function call using bpf_func_proto. Then have
a bpf_func_proto-based verification. Hopefully most of it will be
helper/kfunc/subprog agnostic.

As for the logistical refactoring:

- First step is to unify bpf{_kfunc}_call_arg_meta, which many
verfication logic {e.g., alloc memory size in this thread} rely on.
- Then, KF_ARG types and their verification will be aligned more
closely with helper's arg type.
- Finally, drop KF_ARG and unify core of check_func_arg and check_kfunc_arg=
s.

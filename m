Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA72329C7C
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779892074; cv=pass; b=Hyog5xyo4s66lNXy9iQ/C36zH2LUipnCZoj8jPLHSERbuVLRqGBrSH4kh/OsnF6kuzQAwvfq62BWtWFF3pK+KItLgevzTxhH8C81IbEPoBxtQdV0/QAeEgYFU9ZIuQ9hF83mnESi74GW8spSMkCCkESYJAQ83yEJv4KMmxE8/Z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779892074; c=relaxed/simple;
	bh=ve1GxgwUJDqrHgI4wen/u+LK8bDh1//NcndXCcpRWVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WIa/6aF/vxw6HFruxB1ISpS+bPN5tI2/832enCxPXwuZ8EdEdsdOSMi4IyKFV/W9OtK1uR/LFPDHYxYU0U2o/HwYR7hC3wv2t+GiOxLfclkXuItJ1zGQN6VJZw/lQa6UXjSNTUfO4Q6qF1aM7qGSoNWraVMyoVrkuju3eSRALn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uoK+JU+u; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uoK+JU+u"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-65c37eafcbeso12411728d50.1
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 07:27:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779892072; cv=none;
        d=google.com; s=arc-20240605;
        b=UFnCneTC7opsPORTaNEMR6cPHZZueapE2LSEyVi1WPioGSFDcuy4KSm3HwaCvuZ/fd
         z/18xJvSuP+NmU+vpGfmvJ1qYrG+vZqoydGDHJA/YbuusVsFPWTZc1T05j+a8fAebl0M
         edsnWj5AVxIM+MvH2oy6PhokCtyeJ4rvWtPBnqXhguzrrJBTYidwvhk4mEgn+ZiNy3dO
         gZ8QTQL6J9ow3xkfubbNeY3rZavOC3uazSdMAEvZ10G6nB218IEXwMhKinKoiDHXR/61
         rhmd0N2bXC56eYPRNcHaENrF1TguQsQW6OjKWTf2ovlOLQ6P1wn0UuvzW9Gi9EC0N0k+
         ChrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ve1GxgwUJDqrHgI4wen/u+LK8bDh1//NcndXCcpRWVo=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=kU6dcguiKYgST0n992G7A+z4JNJJrso7rx4n+78HsrmaYHK+5Yu7Nk2mC4A3v7oVhL
         PgiicoMAOVSGESE/UX+4RSGFNTkMhonw4RbRqOVlg0zDhuQrV7X+HVMcCpwky7EbTHHS
         QBxzY+ZH/ll+GVs0m8ndzp7+2WSaY/df/dvxeIZa0wYBxiKEa4myaMPqsBGpekGLxU1f
         jCz9/pV6k293wmAsTyO+IbH0PXdGnl4bQbV01wJEiixF0BVQqEHE9cBpQBVDWjiwQ8w6
         /saFoElOQtgDoOkrTQAVlrg0hhSKxjH340zca2Y+3UlRh53oSvKRq7pLcSA4VDjyimuW
         49Vw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779892072; x=1780496872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ve1GxgwUJDqrHgI4wen/u+LK8bDh1//NcndXCcpRWVo=;
        b=uoK+JU+u98wD/2vfXB8KvWwRDVSvYpXoprUr2xCmN/vyogPWI+UnkR5aa5CLF/DFWr
         A6Qnm/cwri5an+9UCnpQSX2qqWIHMvJYCg3ip9zevkVA1QgcW1/Ll+rzD6YsK/RVC/lB
         WmJ8CzNvouxNMLPf+R7+4ki14V1dNIDsODU3mwAhLOWER2IpZUTiPtd579lvSIpANQor
         nqo/EWvZH7lwnkETVWGdowcdCGPjwHrPCz2UUxBLU0AckCOjS/ezOBdPlMU/wqnn6O0N
         wCAZhC1/zOndM/nwh2QnuPVbgbGctIWrBJ7QIB7ycjKd36ZI9ylwfi2EJizJ1h7QmrB7
         JkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779892072; x=1780496872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ve1GxgwUJDqrHgI4wen/u+LK8bDh1//NcndXCcpRWVo=;
        b=MgkrhgN5GtSoxjMQ//lhWMmk9F54qCgw2oE2szflsIt1BHcvOSm6/ZDhyYtwWzDtvc
         FmwvOQXbGaUucYpgTFTuouQMZKSUBHsW9A0qS1NFpPqabpUtZCdN/2MWHddAzhkkPZ2h
         /LWkBQb+R+QdUEzWZnWnnw+lGqVxXARZxVUVnzsvErhGuN2ZFfOEzvISUeY38PPR3JCB
         QBilvY8SfFVLwMqXZ2l9XJXPtwjZZnMXwbC6DlbDe7UyAW1omZw75vxuPN2g7r2ErsvX
         vqHpY30t02faiD0ZMu6o/YOWupUSliGaLKO5bJMcalFzAODh5KMwrfNK0SqzHJcrFk0t
         HUGg==
X-Gm-Message-State: AOJu0Yxue90xXYhTFxUvsdaseY7Auu5MgT1zvpVTQtnkZ3ilDtMnzYOu
	+JeUCGRkooT82lLJLO+42fjTJQivC7e+NBcB93OU1fRznmzsWeZsjehUbSndvoH1Fsg7i81jCh7
	j18nz1xwq3aJ2Jp9IScOkeoOVLFPPL3154YjEYX5jqjG9XTSLsQVylwvj
X-Gm-Gg: Acq92OH5rLqiFYj6wXqkQQ40sUZEQUckeV/bLY95fgNUit1S0RArx58EW4lo1PkBwPI
	A5llNC1ssMstdYqdl3X6KSgycQCFJkTSVXiDt0E/pM9Zsd8xfB3/Zh3rE1ZgbfQqiO3UQuL56iv
	3ZxkbzBT0sNQax9aUjSrsJMutB/n2vHTI6YhlCj9t3H45GsOygVmwuQPN9hL1lce7mn1NXgN8Dc
	46iTYVB0Xgv0o0EwsUoK9SMgX4qjnVF+GIE9AzHuWfdMRcf16fHogta0rlMqw7BLkogDeuRZDMj
	70kfz0dMY8p3ocJG6727Nz7vx70Xar0I2gRTrqmX96c0GRU=
X-Received: by 2002:a05:690e:44e3:b0:655:aceb:4062 with SMTP id
 956f58d0204a3-65ec98196a3mr18160634d50.28.1779892071374; Wed, 27 May 2026
 07:27:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527-libbpf-load-vmlinux-btf-in-gen_loader-mode-v4-3-27daa15487a9@google.com>
 <20260527141042.B632E1F000E9@smtp.kernel.org>
In-Reply-To: <20260527141042.B632E1F000E9@smtp.kernel.org>
From: Sid Nayyar <sidnayyar@google.com>
Date: Wed, 27 May 2026 15:27:39 +0100
X-Gm-Features: AVHnY4LVyxM33KMk2U-BKoGICs3t9VlSWi0yECqbSJyqbPhrzB1u3fMTEGxO1d0
Message-ID: <CA+OvW8Y4aRCtJR5_84VGPiySto_MvAZQkL1agXRk7j200vbZsw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] libbpf: plumb btf_vmlinux_value_type_id and btf_fd
 in gen_loader
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 3:10=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 4 potential issu=
e(s) to consider:
>
> New issues:
> - [High] The patch truncates the bpf_attr payload, dropping `value_type_b=
tf_obj_fd`, which breaks module-backed STRUCT_OPS maps in gen_loader.
>
> Pre-existing issues:
> - [Critical] Double-close of `inner_map_fd` in the gen_loader cleanup pat=
h can hijack and close an unrelated file descriptor.
> - [High] The condition to populate `btf_fd` incorrectly omits `btf_key_ty=
pe_id`, causing map creation to fail if only a key BTF type is defined.
> - [High] Memory leak of dynamic arrays `gen->relos`, `gen->ksyms`, and `g=
en->core_relos` in the error path.

There seems to be a lot of feedback to unpack here. I will address
these concerns and refresh the patch series once I have reviewed them
and incorporated the required changes.

Thanks,
Siddharth Nayyar

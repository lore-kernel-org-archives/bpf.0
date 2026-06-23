Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E32242D65
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 21:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782249134; cv=pass; b=Cb+e8zxb8wQ8RkOvU/epXDeGbw6sb5dq5Op3Mh+sKanFQZp8wLNCz1OWU5pIc0AL8m6Rd3ofc+4toiawtNGzuS2gHV1favPnZsnVi/iNVpYc/4tSlXjSakkp0rFup38rcd4g7C3y3G8wqegAHkfQb2BNrnkbKk/w1b5IjmlhL3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782249134; c=relaxed/simple;
	bh=kZfxy9FfiF7uVIj+9jfG6dLWC2emcUn5RI5hh2mcd/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QRACj9KAJKTkyXUxNaDuHDsl+YrIG9Ri9MzD3lFlQRoyFYp8bXk9+DcNYlyrShl+tQNHqwyLJD6ntBjBWUmgmNCN9E6I7lQ1/BuPxKIo5W9JaJstt3uPOEGMjRiHWUW8z8L63EIs3UBgFLa62lKW67NahVjrGxrmZeCdhQmYFPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPnj+PWI; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPnj+PWI"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6607048fa62so281217d50.1
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 14:12:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782249133; cv=none;
        d=google.com; s=arc-20240605;
        b=K64NxydO4pnSxHEn/VusQjlGGYUv7/LBj4BERsj4kHBx7z8++taoSk5CFWYjB+eUVr
         lriObgMs8/i7W1+Dkv31eiAfxskfTUKZBL8QrG9Jrmim1JryJcOLkN4kq1COzGHQy9W2
         gX7j/XlDQJ3NoGuYxx84qm1FVxoVg9TLQ/gGHyRe4uwh4sl5YA1Y0OnvzmhYoL6S+ts5
         8SbsxyU0gs8t7hVv5dvYvZXpB8QZSyZz8/372kwxn1Iase/8lrQKYqQxnqWWvFEN3l+6
         K/HgRNBRJtndjIS8t3kOfzYd5NLPZyN752ZTfn61rL2Yak8jxlYsg7YvJz4PbvTt2EpQ
         MPxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xCOjxkz8u6ep0mmkWFDHxDwi4eYC48rTpGsOqnivmT0=;
        fh=O0lH+17YwoIuJaddJiTq03pK5Q9LaNFy76MUHdsyzZY=;
        b=Kxt4o9SS/M7hbN2cfQxfeT56P2alNwBiPDakdrOKhbMH+GpCVaa8Qie+J3QZCCH93u
         0RF/uToJIiWQ0qUSjHgSMz5eNN7Tx648FzTEOheRfJgTsUQvtQqzKDKXd99PT7CsLnej
         AQybAJOSsDeAWlAQ6uTsxrN9Wd9QwZ7aWEhCNJvo97SRFQCYTNHMEmqdpJufEIvN7ESR
         W964d/nywPr+jIlkBAQL8Cg4LFSmCojH/b8Eh6O8QARTSv5XDMAAC0c/wEmMQdYYmgPh
         AqZmu1c/pLN5KDuVRYdV9EWBFqwtR7O17KhCPOQbUYcbKj5SgrKeo8U3EkVAFRdYs8V2
         PVYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782249133; x=1782853933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCOjxkz8u6ep0mmkWFDHxDwi4eYC48rTpGsOqnivmT0=;
        b=RPnj+PWIp8HL//gz50L3w4x54MeNRWOT+rucaegQCQLaIXtvXkabyxQtp0qCrBxlCF
         7NUFMOkhCwZ/osUJ0z209QvTVKAkKiLq2ro3Itfs1xVt7Kr+LDhgEXioYaVZyHWux4au
         8fVroHqAy4sheCwH2KpCLT+WADMVUpU2kv1Tk3HKIYEMKmIldHyz8Xf2+aVm3I1ifTq5
         7ihlPaucwxxuJO9Mpj43HlYwlTmcBIyJ8Pur87jdOIFTU+Zy3b00vTQW06HpNE0MZSG0
         qKbnt5SsdhPyl/p0Cf+8Z/VgVnlR5OdPX/F/M0p6i2UGuxQpoMGGLaja7fqhr5L9XIog
         PkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782249133; x=1782853933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xCOjxkz8u6ep0mmkWFDHxDwi4eYC48rTpGsOqnivmT0=;
        b=b/44IenQAQemGAQE9CsSIP+TM2mE899gNRjvkrBbkvjqpGULsxm0fzO1uaPc0L+uZI
         YSWoBAU9o5x40th2puEcEq5IhCXMFQMWcqyMQ+orH60CyLeWH1ph1FNGKNzLq7WPk1jT
         Uy5p7GFvoFF+6ZJKoaT9N+Rfh+OB/mwYDjVHrPkVPsPe/cH4xgtgNn+MYtnH/RKH7DH0
         4NoCR0/y+nfUnQsbno9iTwYrCPlnQCpYRvzcBfyc68R2tIPSk2XHcw7x31i0L46AcSL8
         THe9j5MVhWwr1CAqwk0ZAYeucnbLRCxRegOpuRre5TbZOTa3wkD7w94hfutJtKq+13eP
         J98w==
X-Forwarded-Encrypted: i=1; AHgh+Rqu592uI4EM1RA0yzYLf1g4+BUj3cxQTr+EnLtGwWbFjsOg8ia/D6vF1/JNtPXBoRbz1Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqsjRHv8gml6YhxtK3hATxvqn1krhCUs24zP7EPPkCXdk3CD4Y
	A2Es3sQHne7L/Kz4vCSTJQp8q8BbVJ0aI59SctuDU3IJPp01KBvscbgDgASDkHkbUXDpeeo7Fqm
	1SR28isBgleuOjNfaSRBqqr5GuR5Ic3g=
X-Gm-Gg: AfdE7cl0/QvXSsngFEybeJT0pbP/maz9alrHY0FwAke2SZu7R5qEZex4nXDKavextWW
	mh4KTquYv57G369tuTtRHc6eH9jQ1/vRZbRAGC0SkJsFf+vwOV7u/K5BpgCYba68D8zc6CKkCG4
	vPTzuMGtAiCq/2Lu7w6oPVGva+y3yPfUDZ9Sj2uVqlTdPmkLrrlNIhJwspMF2iE6vs2ooDvY9IU
	kjrdi7THlj1MftenwcfB7Un1+8GdTZ32kejkBahh1yBLr0aWGiuwz4Jlz2IMRfFZLnwc1GhpX9u
	nPNVvFAKNftU
X-Received: by 2002:a53:ac9a:0:b0:651:b40a:d6ce with SMTP id
 956f58d0204a3-66312db1a4amr16014170d50.14.1782249132774; Tue, 23 Jun 2026
 14:12:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623175006.3136053-1-ameryhung@gmail.com> <0e6fb8d7eca4b5494e08a2230056e333bdd814d97c16784b3e1f7687b3640990@mail.kernel.org>
In-Reply-To: <0e6fb8d7eca4b5494e08a2230056e333bdd814d97c16784b3e1f7687b3640990@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 23 Jun 2026 14:11:59 -0700
X-Gm-Features: AVVi8CdPATuIkHZtw8dh-ablNsRiSfhN7U9w3x8Tvd-D-AMkpVHnC8gqPCRqJmI
Message-ID: <CAMB2axNtddR1ON592gTuVSLmR02zgYeY4Z9yEy2o_XJtd9NXJQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 00/15] bpf: A common way to attach struct_ops
 to a cgroup
To: bot+bpf-ci@kernel.org, bpf <bpf@vger.kernel.org>
Cc: kernel-ci@meta.com, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 11:07=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> Dear patch submitter,
>
> CI has tested the following submission:
> Status:     CONFLICT
> Name:       [bpf-next,v2,00/15] bpf: A common way to attach struct_ops to=
 a cgroup
> Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=
=3D1115527&state=3D*
> PR:         https://github.com/kernel-patches/bpf/pull/12604
>
> Please rebase your submission onto the most recent upstream change and re=
submit
> the patch to get it tested again.
>

In case anyone is interested in trying out. This patchset is based on
bpf/master, 3d8e6fef15db ("Merge branch
'fix-effective-prog-array-indexing-with-bpf_f_preorder'"). The
selftest in this patchset relies on a bug fix currently only carried
in bpf.

>
> Please note: this email is coming from an unmonitored mailbox. If you hav=
e
> questions or feedback, please reach out to the Meta Kernel CI team at
> kernel-ci@meta.com.

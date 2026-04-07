Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E6B3CAE88
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 15:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775577152; cv=pass; b=TaCc6LLCpFPELaaLIbnWcTBc8pZX2PcPWM+PeQmCDfmu0AeKyY/GD9wwsdm1gVFpMLZFtXnrGyiQcmfmYPhNZLYWJ8W1NT2qpytVokq00YZhNR9ssSTnAh4xSHDW5+prEWEw7nimDj192NIkDf4xRekTw0Dz8JKf3+NwHB2y44o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775577152; c=relaxed/simple;
	bh=/kt2EwKuCUl7jV6h6cW5P8/B8IanIT4L1Bkp+avqSho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LgRIEwdeGJFdIQPMZcBdri0oaonL1utBMIRCzD9dBiR2ZIaW9htaoY14GUswkK/zDzH28gPWxY4YEx6LoC4Fw19kXw72aY0gXqXqRbjbz0CmK5KjOTSd/ZjByiddHcBsSTGzbDOtKlcxMDIm706oyEzZJChZfdoASsW6UY8/Hcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNq/TbCa; arc=pass smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNq/TbCa"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso97985e9.1
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 08:52:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775577141; cv=none;
        d=google.com; s=arc-20240605;
        b=dzv8z8gQeKiIUfO829/ZZf+HPXcI50Riz8D7xN+mV5Af/bzrX20ROeXz87yHXgW4+q
         iri8/xuHHVSlsjStLC2e9sa0je1yYUQ6znkR8TuFtPRbvN5wNrffBB1U34PYEwY9rPQP
         DGmzHjskRch+oT/VcjwMrR9di4k5g56qce9bkK7eXciipbEDaWJUsneWWqCGjyogucbA
         EFlUXiUWZKuMC7+TxJVbXw3x4rn38J0HUnn6kEPOgvyaurtPj3WHcGce4DMTzDVkyW22
         E3bOdf9OYUHxe+HexPxhO+BJYHauFHSw/co8H4ENZW37ymQ+EYxrS95DqLccu010dri5
         5NBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/kt2EwKuCUl7jV6h6cW5P8/B8IanIT4L1Bkp+avqSho=;
        fh=Sq/K1EFVkXPFuOWzTVIi+KAjY0pEP9GWsF7LzpDFuvs=;
        b=QWU69gG8DbNrI2euC3++Q9E+T7kuoI17hpAGIsyzcAOeM+5MsjxAKvCo96AwlDdYlg
         mheflUjtIUZvC/egYYX4Bcsh0CtRZTSZyqmWoRma7gRi9T3u0a/8acCM10WJ4wNV21nN
         loQZnKDlploUk8acxLH9aN/LYWx0+fTHJ2QvNqklj5CmsmFqw5QT3N35iCcUBs2yHDuh
         Y084himuv44RhMquVh2239Nv4rjxvcLG3JAaH/DmZKZJ6v6k1lADLlhqhcYLjwbiAmtW
         9mw+Co16S/grqeoVjgdX08Zdpn9Q46N9dbzdVEmk3E68MwX/jdmAxDZ2OYDsfqicl3QM
         Q61w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775577141; x=1776181941; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/kt2EwKuCUl7jV6h6cW5P8/B8IanIT4L1Bkp+avqSho=;
        b=PNq/TbCar2lBJVFBHnOF9OTbMEjj8pCl2LS9JIaDiji2KoG4noejG6RwhAhLPsP5gq
         LGKbczqI79khX2p3gjUfzdFAVeRYQ2LifZGgCk+rx1ECHToWhE/ZGrxisI5h5OVbvAbw
         6MRd5N7ncIz96D4as9+hXJ/tjQ/mDZ3qbWbALbQrienWK2NYGt2aYIwock2S+6m4j4uf
         uniPC8BdCeUi0/i6S22YkuAoTQ4lGd1RXT1fE7PcMTqKJwgWkAKlQzAx32aGueBw3BHj
         S0PYvPVYlP2fTpBO5Svuytd1B0X1sEgZU3nfH+5oSAKRY930zrDkxADq4Iuczic3d68E
         rTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775577141; x=1776181941;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kt2EwKuCUl7jV6h6cW5P8/B8IanIT4L1Bkp+avqSho=;
        b=RUn5uh89F/VJoKQ0Ge5GRs9CmnSAelif/EO56HJoVBcdoS0H40iwxMiXxgbZDwyvDe
         ZeHBDs+lKPfjW4tY3E5+7vwKmh0h6oM6qeNe8AcFRHGQrQGzWASIQ71A0auOOroOQxli
         Iy+dntv3L0p4ZBK/mOVlwssRJNhY9uIdYJOMJtBm/N4foHsn2qEpFDzk1sbyRxJQCs7V
         MlFDMbtBb8PYIhUXoecxPSw13NMu0zg8+2phBqFSszZntltRLO4MOYV9XAYwXRS7zUOH
         R0/4ruXILsuA55mGMRAyUp+4X6LYhNwWI4VUBd68Ch6pRnrz+adMDBaGsmjUzyu4/ZFq
         tgzA==
X-Gm-Message-State: AOJu0Yy/7JRXGb19XS8Jq4U1zMNQ4kigdPCAWnHBDlY8RKnKbeNXU9XG
	UiAy78RnidI+Olq42RQetT870cInlWWWXcV4HDbIkCae0+6htNWmY1Er17u+LDGplXjZI52g9SI
	ooesVyy9CsBY/YyJ6RAZJUyLjyw7e9fs=
X-Gm-Gg: AeBDiesXzPsSqkigtkLwiJlwh6kmsFrRxhh1rdy7QszgByRwAH6g/m4GvC81IEE/lcd
	RD70LAOYfxMV1YbJpymYxDxQUL2hsZ0MUldRkfpPhrH6wtCvHZJ8zW/kiKfITRwTfxSFYwuA8aJ
	DD5isf78baTxsvRY+2voWaSm51wGG/Fyx+RKw1RG6hbyBRA6Ngif3bNCqPCSP5Q/PqNTEYWoKnB
	KEe9XhIAJAEp7Si9R47L7/aYABJVXtIdBCt2YnH5odhxnRr1PRXDWSOPi4ZHByyeOGUmNwDqBGY
	GxIeOlYjjpAyKe3DbVM19EARP5oeybNoTzG9PNDF/kITr7FtQL0E7HIDndvgTtfkU89SjDTN
X-Received: by 2002:a05:6000:2d85:b0:43d:c06:bcd7 with SMTP id
 ffacd0b85a97d-43d21267df3mr19200786f8f.26.1775577140414; Tue, 07 Apr 2026
 08:52:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406150548.1354271-1-ameryhung@gmail.com> <20260406150548.1354271-2-ameryhung@gmail.com>
In-Reply-To: <20260406150548.1354271-2-ameryhung@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 7 Apr 2026 17:51:43 +0200
X-Gm-Features: AQROBzBmsIhPvryF9-ovIqOZ6j6iKmWXrNffF9ZGi7apYtlTdrbJjnZWliclnsE
Message-ID: <CAP01T75_ugHFvnCshrB7HaFUf_11U4bcRK3Qi3ej2e64mB9GTQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Allow overwriting referenced dynptr
 when refcnt > 1
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	martin.lau@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Apr 2026 at 17:05, Amery Hung <ameryhung@gmail.com> wrote:
>
> The verifier currently does not allow overwriting a referenced dynptr's
> stack slot to prevent resource leak. This is because referenced dynptr
> holds additional resources that requires calling specific helpers to
> release. This limitation can be relaxed when there are multiple copies
> of the same dynptr. Whether it is the orignial dynptr or one of its
> clones, as long as there exists at least one other dynptr with the same
> ref_obj_id (to be used to release the reference), its stack slot should
> be allowed to be overwritten.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]

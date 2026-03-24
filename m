Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1842336074D
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 16:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774368476; cv=pass; b=TZWt5GFYa2kSEkt5Fv/2+LsiQIQ3L/bnoewmBw33mUNqpkCzdt22FKfHYMl3GRq2i3Y8Qspl+18g+Ktj7/kEeqGyI/4jjhZylFt0/Sl5STdwv38BWqkHEARPP+gA94oBq3fSz52Ve5kKSo9sXXf2n38a9k7vnDFYdN2cQar8guI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774368476; c=relaxed/simple;
	bh=CWgKyEE7HM7HrQi/1b6i0FBSGikaLp873YPdX58ewa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txmv6J7bKhiV25G5k1nX+BnFIF9LLsRTIAyLlW+iQ/Uj1E4xEE3LD2JSbThPiJHm6lt/URi8rD1SwXvK/0GZCIBel9ohsptT94QAiZi3NVn6SgUgr5wgr+OtizzcR7GmSijCl5hrdl8gCVfk3tsG+PEVXgqFfQgM1AnnI0ZoBxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ktj/f4a7; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ktj/f4a7"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b9382e59c0eso670685066b.0
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 09:07:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774368472; cv=none;
        d=google.com; s=arc-20240605;
        b=GWnrUy6nNo9naOeY/IKQpJrkkBcBnFSsvTfT4PfzbeZXbQy+fBkCmiifwSKCEGePDt
         mkBbHiar+r++8w7tZUMnAj7Q7sKtWoI7nNYn5zIRVPVNUw1NkQGujj4qbSwejYGYM6t0
         ppGKxbyG3FqIZMPbsvddFYNEEUNrXzlOrkzrNQcEPW93uhOTVGfCzVryQkezJ72szELZ
         Ff7EyhYdVYDkEZK/w+kB5Bgp5AYt74H/ScCJvg5tQhJXBEo5935ULittyqiTadEtmVqs
         jszEPHseM6Mq2b1ONOfOtcBxse073Oqsw+IoUhjmz1Y86XuRFUvXlyHg8EV5lBNvjha7
         gnDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CWgKyEE7HM7HrQi/1b6i0FBSGikaLp873YPdX58ewa8=;
        fh=/wOiA49IBmR3exKxYaCb+YMVipba8z7XvpII9ufU1cg=;
        b=H1QBigMFA9nYs6g4hFFUAO3FfBl2XWwavKQWnxOVSDxfafbOColSXpVD9KVxvJSjo+
         43twlxUIzeGhc0oje40EYewK4+dX+J4eiRcQxNE6pfdnSnLUbWV0dxZPdmkJYNfEqSA5
         fo/xQ4NTooX0Y+mhafkT3VOMqMf5BkQZ+GBB8fTZmDUHq7ndXZalu/XsJIbqECoOSB/D
         D6cJa2rNOwLPygny5dpwbNf3Xc/obKlTXUhu5iYv16muy0lsteyGHAnLUsPqEhRSgJ4h
         YLBEHv9khb3+k16dMcIVX1hu4WX1IqbH7MVpXFYWuS6p8t3IlB+VETRsugkhtIlcxL3z
         ffdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774368472; x=1774973272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWgKyEE7HM7HrQi/1b6i0FBSGikaLp873YPdX58ewa8=;
        b=Ktj/f4a7iD6bYDyvQCZjlgWDP6opa5bzJWtZ7rHGhJX3qAHGUKn/pdfN2M0bWsUKkx
         uSYnoq29CrJAnsTtw3/70HX1QLn8FvtSXdpdL/mqeh+AGPHFqv4HQEvxv2XUZMGoGNNp
         ajvayF60pZCgWCwloU+IALxuDtBlMgzgCe15iHYGgfF7v/1b9XpBuyMPg/WAHc6RJA/U
         /TPoQlSXKFSBfHP0u0LaHA9wIPtrWxjOJkl8HHeqmponTYT4zVEiWGmyOET5JHWbDazq
         eUSl87rW5aw76thnYmw+kBQRnmbl9Nol2UuOFtuxiJ0xjcnUN3/cSP5oAlFRwGMc+rWb
         oNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774368472; x=1774973272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CWgKyEE7HM7HrQi/1b6i0FBSGikaLp873YPdX58ewa8=;
        b=fudcqa8KLPC7lbVXF3ZvqD/7B7ZvXKD/cV6e4I/oAkw6mE2ZxBMUlXe+SGAyC9E5VK
         ixoP8nrn8IrDsvT/S5bFJWFlF7GT/c5UtDdgcwUETW5L51x6/FbZol85+BZVWBmvuk1V
         mN3Me+lg590xJMz/G8rzFY5thCnTOf0+vZgahclFoIKzmbMOSwXdaH7K3hSP3DSRvCBb
         BwA3nEQiJmUloDNKIQyCB8sDSH9pmigUnR0nRtLw8o7E3wn6eMdYO9gQGMRajVWxbDTC
         m5GvUXosbShl+oeVeNs46uq5lEA0Xn7SYKPp30CisWrKthYtWvj7HPYF0Rgq6vqXeVpQ
         wVbg==
X-Forwarded-Encrypted: i=1; AJvYcCWytj6AJ07xZa82zSncGYsGFzPU849LBC4gNHO5QRsLNIjUN3Kt6UvYqRH3qykuq1c8z7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGyEHwa93TOQFjBKYbJ5nVUVqUBilokvRXxr0dXuVfI2YODRxM
	7Yj843tCEIszCoyKM/LNQIjX5ykG4HBiN8B50O5AZX6UC2C0nstXh/JwlqNmRDjCp29VZp0fVKM
	sVySsLgRTqNdoUswvg8Ke0MKe3M+joOM=
X-Gm-Gg: ATEYQzz0hCUISI9MJbmPXjNGCFL4y62tIv83v/CDSNR9S0re6Vlhps8iWm803GJABQI
	Jhd/7zFVWXz7bejLMjffLLU/bCdtGLrsf76/O1sirZKRn2DXcPAHd0C2D369KxEFviqpE+/0wir
	I9Zp74LNNwyDNvcgPbloNztDUu+BX412pNpCHI8GtvifrgSI4FPG3l6FMmDBOxQoHWG7gqb2Pzv
	SPN66CRqGOMUhmx/xB0R4pYxfOTH54/LXVgB48SXXswgFMa51drxJRFWlF0TCPrsXQj0bOBRqhj
	HzKmyyfx4ToNBGLHPIYhxBWdxzHvx/u3ZOhEFmfRn+KZjwuV+mnLFA5YDloi8miHUSbuqndP1qH
	UKl7/htOhAEEQ+ZqP2RFVYQ2+gA==
X-Received: by 2002:a17:906:c9c6:b0:b98:4d6:8c9c with SMTP id
 a640c23a62f3a-b982f363047mr1019281566b.32.1774368471653; Tue, 24 Mar 2026
 09:07:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324152230.2916217-1-memxor@gmail.com> <b7c13a1f-1efc-4ed1-922f-54ca7353dbe2@iogearbox.net>
In-Reply-To: <b7c13a1f-1efc-4ed1-922f-54ca7353dbe2@iogearbox.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Mar 2026 09:07:39 -0700
X-Gm-Features: AaiRm51dg2jxIEezg-Qf5yJRplTOkzn-RK4Cf2Dvo87uzkgvb6CaXVDVNJ4js8U
Message-ID: <CAADnVQKbgk7SoOGjnhA-CiPobA+OWL6LFarC_Zdssh6waucpng@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: Update MAINTAINERS
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, kkd@meta.com, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 8:48=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 3/24/26 4:22 PM, Kumar Kartikeya Dwivedi wrote:
> > Per discussion with Alexei, add Eduard and myself as maintainers under
> > BPF [GENERAL]. While at it, drop R entries for reviewers who have been
> > inactive.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> (this can go into bpf tree so it gets synced next time into both trees)
>
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>

I recall Dave was applying changes to maintainers via net. Not sure why.
I'm too lazy to send bpf PR with a single patch and it's really not a fix.
Applied to bpf-next.

Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB9112F585
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 02:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774490975; cv=pass; b=Tvdo9zz/m0glRXN8RQ5qpOFb4NLuK0gpdRwrXFMQOcmfNAy0hbq54XJjbwkEMOH1n31qLeYFEJMnhTRu1iiRNx6hLvTXbGswCZ+93T3Eweas/fU4Dsw/I+EbFp3o2i4LH0RE4kz9D32rGTRxKskh0Z/8KiLb76fr50vfvgac6wY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774490975; c=relaxed/simple;
	bh=SM+x8B+Pz15Gvc1EQP2Y8VvxinV8pQbKuNafLtpnPcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W8sIACLnNqa1uiPK2+VF+Q5nPSJkshWB47iFWKZJx82A+iUuxDC4A10J1eIfbffrt9coXcVFsqxmXHCPXVRAWgfMI9tfXSZPssqmE2AMWpV/K/YVmIFUhcdSYREOICEUKTGAyCLE9Ll3Ss0feZeVSxeMLX75Qc33pdaCBEvo3Q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KZN7Rz5A; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dgmdjjvQ; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KZN7Rz5A";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dgmdjjvQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774490972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SM+x8B+Pz15Gvc1EQP2Y8VvxinV8pQbKuNafLtpnPcE=;
	b=KZN7Rz5Ax5DTS3CgZiamEURs2Nml1/jj20u18opqBXTS7o9LPXcGYDWA/6F5N38xxkJSLf
	zEMsy6xhW4BzkdHFc2Lg9bXLCGjDAb1lte6QzQzua8Dibp3XQG/C83gZQE18ESkMkgyWxn
	LnjMxuYtTXVkUI3rLZKijtSmgUQgXGo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-08fG-fatP4iIcjn8jGVcPg-1; Wed, 25 Mar 2026 22:09:30 -0400
X-MC-Unique: 08fG-fatP4iIcjn8jGVcPg-1
X-Mimecast-MFC-AGG-ID: 08fG-fatP4iIcjn8jGVcPg_1774490969
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-354bc535546so457941a91.3
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 19:09:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774490969; cv=none;
        d=google.com; s=arc-20240605;
        b=hqiOFaN3qaOWa2kSqqaH6nnRzXrSCnAj4iaKmXuucQWV89sf4+wnBzKAz2oGPOAsnP
         CKxCoRagtAL7OmrAy4ZJd83JVeC2ZgIiMYhvEqBrUxNJy6myc/1rZ76XOzIYCvCgb108
         d7IB/ms0o7kg5EhuXwiHwNm+LviWHuOPOYQtPtoGF2Pt/AdNJ5B86v7lhFAuN1i7mL5N
         pLukleFXzs0HjgKLmaTQ1kTlHIhwp35ATtF0HmR4i8oo5YoJgAq3lk3Orupu5nbmB/64
         QkXbuX824cxlL5ZAUQEcUa6GqrzNFyDx90oka/77YSeObwqc9xmR5+zDglNc3p3ZVLSb
         T1nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SM+x8B+Pz15Gvc1EQP2Y8VvxinV8pQbKuNafLtpnPcE=;
        fh=Ja7CfbmvEW5yQhVA9nqfi/jO8bYL012hBwK/sd4v/x4=;
        b=k6FEwFvNEELi45cqmh1xUtNFrdPq79WKXrhipqEaAqnEOInzZFls2/8oFOGS6/YT+1
         XfMpfeOgjVQDmlr9N+Ps2ErfeSlXtGIDbAcLLW1k0ehroGydLQyv0+4xiIHbFgUK+ut1
         Q4HikZTvrVdANA+2ZPpumfYnX3E5RZ+keDF7AQNoLpIKql02h6LUzF1LD/qic8YZcikn
         CLhQtMQx1L66PdXU1sKzsUxEbZfsSooPYH98k9Gu0DZQR7S4Y8E5GaduMxNPVvxXkksM
         wsqAHolFMxjHe99fHmuwrzrZaUkW6M7dRUiYnYyc2nFht73ayi4hJpZV5kUnryIugSfU
         T6qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774490969; x=1775095769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SM+x8B+Pz15Gvc1EQP2Y8VvxinV8pQbKuNafLtpnPcE=;
        b=dgmdjjvQp7K+JooQx0xwwqgu1Ws+c1riVHbP90ERxHYNq3xGkT3BP3eIRV7uNMsxD6
         dqAWUXhgrE5LJ3XL7Imgm8BXD1r4nPZ6cxWVi/Xhb4YK5QY2iRWEGgQNGOG5TEWYA0rw
         84fGjY7n+U3XBujyQKrZj8OC9srsaVJdcy+ozWvHoAlXXOk1Q0M5u1XIfi983L1twujr
         i9J9OfQWNA8uFIX2TBDnRtr9ipb3DHL/SpVbLMfluKshuY+1TrhtIbuhve/cRdyay39y
         gGQCySXYdla/lYQB7lbjROw9AFcCcilnk4OmNBfiCLMOlHNeSNY+Nbace4fzH7Ls8V0w
         wM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774490969; x=1775095769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SM+x8B+Pz15Gvc1EQP2Y8VvxinV8pQbKuNafLtpnPcE=;
        b=NGdFYoGNxUewYw+lv9prCv9adALGm9n9Hxwb1AmBC02DgychQgFAGPZPqtf9wSUz32
         tlk6x2fS13muy5dvCaRZc8cU2pJgg5/Ixf0cY98PtLBrGyhZIXuGAUMEX6NTmfgq/UZY
         TRaEc5KgujqvEqoug18B3PwkQhUo8yWzwrYikF1RBCd9odO/prjy1vXL+UB8GOjQmroG
         FUhEB52v/6+tlwA3II8m/WujnlZDk574U7B/NN62Rocj97DqJ34tdL5Jy/Nam/uPytYR
         1tgRydKbAAlLzd6vR7j2t2LkFP+Gtd/1LisdIAzJGxclI2z3baRTLr0TuMah3gvDFeml
         xp6g==
X-Forwarded-Encrypted: i=1; AJvYcCUG85LQ2ikzA2SV9AVRLmERTIS02Iv/XZLGxmglaOKzy968ys/pgrCKF0sJ/vhO9G0pS5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVfLKlWYHNFbo8xGoAaWQrMO44q5Xwml0cUtFHv7v3Z9g70T0Q
	6mOVlRJkTBw9g0RY8p8fEK/AbwbEAugZ1hc8v837crbm3eD30X2bNK+kyYu82pgtpLcrvGWwJmj
	rgsRkpL3I9YcBczYfAIN+aSzh0fhgGP6ZhMwl6OV328S4EB80YlAcLuQJ3mEy7vb3jTVIBA0Qdx
	oDFTec8osOdCNzt7zVwVBRxqrWD4dO
X-Gm-Gg: ATEYQzwjxihy5qP7+JNSrMKtOEhD2KdlbafbyCsOZMpNhcq2o4so4lipYBByesg9QYR
	XsrAhquC1MZVgsmiI/QUkNH9L3PtQkVqEucXVZoHOVlZnO/2F8Jf3nqZ31eCQIFanMHzBs/3qja
	yh7bnywhhvTUOyhMMvbndIEFDs0g5jwoNo3+V8A+3aHE6/dtsy5RV4ZU0fSgdHOof04dwHLwvgG
	3ZS
X-Received: by 2002:a05:6a20:3d1c:b0:398:8546:c3fc with SMTP id adf61e73a8af0-39c4ab516d8mr6008499637.7.1774490969234;
        Wed, 25 Mar 2026 19:09:29 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d1c:b0:398:8546:c3fc with SMTP id
 adf61e73a8af0-39c4ab516d8mr6008444637.7.1774490968666; Wed, 25 Mar 2026
 19:09:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f4caa9be9e5addae7851c012cab0a733be7f0974.1774365273.git.mst@redhat.com>
In-Reply-To: <f4caa9be9e5addae7851c012cab0a733be7f0974.1774365273.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 26 Mar 2026 10:09:17 +0800
X-Gm-Features: AQROBzAQPVawV1gSLClGfkluwZR06MG28vS66UgSXN-aCJ_PcJcLGWhQhc3M-Xc
Message-ID: <CACGkMEt146_eZCuTt3qP02sjFXPMHb-1s_TcMnOBXox5k87Ugw@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio_net: sync RX buffer before reading the header
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Omar Elghoul <oelghoul@linux.ibm.com>, 
	Srikanth Aithal <sraithal@amd.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Vishwanath Seshagiri <vishs@meta.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 11:16=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> receive_buf() reads the virtio header through buf before
> page_pool_dma_sync_for_cpu() runs in receive_small() or
> receive_mergeable(). The header buffer is thus unsynchronized at the
> point where flags and, for mergeable buffers, num_buffers are consumed.
>
> Omar Elghoul reported that on s390x Secure Execution this showed up as
> greatly reduced virtio-net performance together with "bad gso" and
> "bad csum" messages in dmesg. This is because with SE sync actually
> copies data, so the header is uninitialized.
>
> Move the sync into receive_buf() so the
> header is synchronized before any access through buf.
>
> Tool use: Cursor with GPT-5.4 drafted the initial code move from prompt:
> "in drivers/net/virtio_net.c, move page_pool_dma_sync_for_cpu on receive
> path to before memory is accessed through buf".
> The result and the commit log were reviewed and edited manually.
>
> Fixes: 168b61da6871 ("virtio_net: add page_pool support for buffer alloca=
tion")
> Reported-by: Omar Elghoul <oelghoul@linux.ibm.com>
> Tested-by: Srikanth Aithal <sraithal@amd.com>
> Tested-by: Omar Elghoul <oelghoul@linux.ibm.com>
> Link: https://lore.kernel.org/r/20260323150136.14452-1-oelghoul@linux.ibm=
.com
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


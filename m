Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D84D3644A1
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 20:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783715687; cv=pass; b=SPMHKiALbgTChFolGQ5EcDSEcqOOn2iNdhwCUSLxEMIana7NEBqqwLjlmP0m31k/1VB1f6HnneYZ3lF5NSe9DEjpKRVpOgvxZ1241rw5AHzlZC/yku1Tpmb4lND7KuqaIPQTxfA/PQbFJFXPYxtimdzDdopf7ryyPNU/aV2jGmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783715687; c=relaxed/simple;
	bh=5Ef7X/Kg3mKH04Cd3UXn/P4r6Kfue0PWlaV33hXZ8w8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ji8ZAnS5Ka8KHRRsB2xIaNKpWoOe2DWiZqdbqy+vXfLlaQqLJcie4M0UOYz1DXyc0cxAnW4beFV0bH//FJkhjgMk8k1J9trrx1f4He+TNE5CoP/2llVLtCUvnEwoWpyh3me4i0tBZDixDlUQnwNC8IYQuzBZ/VbKn7jYdh6843g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWIBAcvn; arc=pass smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWIBAcvn"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-4730b8edae6so219701f8f.0
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 13:34:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783715685; cv=none;
        d=google.com; s=arc-20260327;
        b=G+e1+Qn5vXc8HZ31NTOgW7u5w1JTZcaDLEdaKxq2f4M4n3riN7/BTHF+0sFFIh0HIw
         Bn9h/aj12RRhLQJiI3h/vz4ajneI6efoibiLVE7VzVPQhTWpHIic3WEOyRn4WAFxMY93
         6Q7sCUGK3ofKurdE1eXlTlgHoHSLnkfNJwZcwR4REFvNQRFRCOTkapwjiaYV+vN7mDlG
         2msEVQ9akFXNiFiwv2jLgk+8FoNtzmImU1TSdf5k0D3+l40HI/JyU6eOVdnxDbLmR2Yv
         dYzkh9vdldEFMWLtOakDbWx1RotVpkx9c0/2/pwgQT/Y/UVtubVek7e6CL14TkU4KuVS
         xQKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5Ef7X/Kg3mKH04Cd3UXn/P4r6Kfue0PWlaV33hXZ8w8=;
        fh=hI+viqf+lxkPBKEwaQx0K4Mwetpfm4hAvCHd0O+bPss=;
        b=JCGQyL2MYYZbAWtosNgPEAVnrQkyiIMn5S3XCoptnEs/eJIbjmkUhziXIuMYL6+GH/
         CaK1d0Jx6wtM1+bRTQffZ/DeFiRf7LehBA+jcZLBWsdxVxNOXe/sBqHLEcLKrYNZJKkF
         c1ljF4txPPp9sbKRwHWS05bl+rOT3qhfkBvYZ6B9DPVltXPmMCUlFv3oXaPcz6vjoXK5
         l4Bhbo7j5X2NLDZdTatRIutzCelVqlZNnACZgdqkLEKQsyBOBS2dXQH5SRoCBuFNtkby
         M4a/AwlJ2+JXZaTpCEVMWUMwUh2F4oo+vMmcRU1ORSaAE1mx3xqBILtHi4FnkCE7XDgc
         1HdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783715685; x=1784320485; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Ef7X/Kg3mKH04Cd3UXn/P4r6Kfue0PWlaV33hXZ8w8=;
        b=XWIBAcvnbN3wfiFMNbxe89X7y74i4ve1tXj7NPB32YJVnAGXSwk2EOlKAPWe3g+G+H
         Kw7Pf7/ea4fOM5eE4Oi9wPXOShJVsJzlLShGxD3IHx/x849SS4KsGMKYo8F/j+54lqp1
         qSd5mkZiVPbbxvwL9lb7RtpthPJEA5QiTBm9lNKckxYx5y82hB3Oa74LFiFPnOP/QzSP
         jTV6sg/1T07Vu/TXHB84uHvhqFjWhZ6t/JvuCAziVwtUC25U+/l3LVvbFtTtPIk/bWk1
         tvdMOuY9G4U1SIxarcfdOqIO1s7IF7ux0xHWfrXCRSk61zLf3veUzocJBx84ORIZTy8E
         0iFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783715685; x=1784320485;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Ef7X/Kg3mKH04Cd3UXn/P4r6Kfue0PWlaV33hXZ8w8=;
        b=Q4as9luwvJd7krEnvaDd4hkG6TyxEfexqz7oy6t7gqPgSI1A8evPkO+Z67RD5vde6E
         mGT7NZO83Z0vWhknE6YlkKgRe6OmYvqGou/3MqO7Z9c1iOxp8vsSVCWQoeRbmSC5Ipcw
         /DmDL9DkwUDFDy47S/F/853/ZYZhGRWfmvGNv+nfvzUqIDpySJ5vzuSjFRmFtiaK44gz
         6dQs6EWBn0raaalMyj3Ar4Iw/lxsg/JXC6C0EBWmEES2yZk/R9iJBqnXx1SwGWLXHcr8
         wwgQ7eSGYaNxOJDA5MQGmsKx436sU7RcvHoA1PpVCs5fCVGmI6D99wda8L6+syRmZ8q/
         R8LQ==
X-Forwarded-Encrypted: i=1; AHgh+RpBcIoh425I34/dZFX5tCnu2LTKjg2wrrtnqxYNNPmXKegGWBBm5cWpxVLLxY7W0lnoItY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9doa9SmwAgBrzP6Aa6cbuBkHPgdKKKA+SGTvwhgklI0f5vfUB
	FxutH0yYVZ3TIT0lC1cfEE7Ubn9Vdf8BZL4AQdNv95/0DaXAy1KxeW+DPxMMRrtxLFX+JSgXbVf
	JO+bp4QkNqPHHGBrrJI5tkGDVB/7nmro=
X-Gm-Gg: AfdE7ckeej38I54PyiywW7Me1VNOzAGeB8Tfj4NLdEpcLCk109MkRO3rDLwcnahlcac
	P6NNzMWw6HCWXRufl33KMoe3RjeKCZKttyCPoD+cEGcMTTj7Ueu2ewH3mhJN5jP9gPVRb845kyW
	MYl8auYVR05dLPd3Bj+VAaEOyej7fh8Vf7XZFCyGkSCbe0THhOUgyrzd7eJmJHaFt4sT3m85pAT
	r/WKS2qhmnodqnjKyaxXONkkU5xUvjMXG3hZx2Qgzoo+NKJ7cgF0uFqIlO1voFSnX2WdLCjX7Ph
	vpMZkYtzrZx+5lwNTtRMsWlwS764aSmqu9pPtDjd0Qto5sb+mWyuPPGo6JBellRoKxbx1A3O8/W
	jIAh0RR//ZnUInUP0vVRqWYGIwt1WzSoHXFnei1y8uP/VcVmnzu89iUxTyPs=
X-Received: by 2002:a05:6000:1acf:b0:472:c426:2ce9 with SMTP id
 ffacd0b85a97d-47f2dcac21amr295085f8f.12.1783715684524; Fri, 10 Jul 2026
 13:34:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709182800.2037938-1-main.kalliope@gmail.com>
 <20260709182800.2037938-2-main.kalliope@gmail.com> <20260709183918.E42371F000E9@smtp.kernel.org>
 <DJV4TO9OH6AN.58C10SBPE8FF@gmail.com> <CAJZwKki8MwOmij3JZK=KnnO0hEUuxWA-iY=GK-TtvtVRvOkjOA@mail.gmail.com>
In-Reply-To: <CAJZwKki8MwOmij3JZK=KnnO0hEUuxWA-iY=GK-TtvtVRvOkjOA@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 10 Jul 2026 22:34:08 +0200
X-Gm-Features: AUfX_mz3R7qvDlP1KDXkHw9pd93r-GN_7i72AGy5AR_OgDccKGsl_2fsjDQ_Wak
Message-ID: <CAP01T76KdhEsbZj8yZN-yg5ogx99Ud87qqrhOGXTrX1ALdAgyg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Require a BPF cpumask for bpf_cpumask_populate()
To: Admin <main.kalliope@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org, 
	sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 10 Jul 2026 at 22:17, Admin <main.kalliope@gmail.com> wrote:
>
> On Fri, Jul 10, 2026 at 3:18=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> > Once this lands, please send a follow up to address this.
>
> Thanks. Patch 2/2 covers this, which updates the cpumask_common.h
> declaration to take struct bpf_cpumask *, drops
> the struct cpumask * casts from the existing populate tests, and adds
> the borrowed-destination rejection test.

Ah, my bad, makes sense. Let's just wait for others to ack it then.
